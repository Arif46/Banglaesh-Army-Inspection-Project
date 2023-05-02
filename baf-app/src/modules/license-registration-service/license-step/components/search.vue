<template>
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ ($i18n.locale === 'bn') ? menuInfoList.search_title_bn : menuInfoList.search_title_en }}</h4>
      </template>
      <template v-slot:searchBody>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
              <b-form  @submit.prevent="handleSubmit(searchSubmit)" >
                <b-overlay :show="unitLoad">
                  <b-row>
                     <b-col lg="4" sm="4">
                          <ValidationProvider name="Organization" vid="org_id" rules="required">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="12"
                                  label-for="org_id"
                                  slot-scope="{ valid, errors }"
                              >
                                  <template v-slot:label>
                                  {{$t('user_role.organization')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                      plain
                                      v-model="gridSearch.org_id"
                                      :options="orgList"
                                      id="org_id"
                                      :disabled="is_disable"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      >
                                      <template v-slot:first>
                                          <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                                      </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="4" sm="4">
                          <ValidationProvider name="Service Name" vid="service_id" rules="required">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="12"
                                  label-for="service_id"
                                  slot-scope="{ valid, errors }"
                              >
                                  <template v-slot:label>
                                  {{$t('org_pro.service_namel')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                      v-model="gridSearch.service_id"
                                      :options="serviceNamesList"
                                      id="service_id"
                                      :disabled="is_disable"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      >
                                      <template v-slot:first>
                                          <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                                      </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col v-for="(item, dindex) in layout" :key="dindex" lg="4" md="4" sm="4">
                          <div v-if="item.dataType === 'InputField'">
                            <Input :tmpData="formInputData" :fieldData="customField" :index="dindex" />
                          </div>
                          <div v-if="item.dataType === 'Dropdown'">
                            <Dropdown :fieldData="customField" :data="formInputData[dindex]" :drpChangeData="formInputData[dindex + 1]" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                          </div>
                      </b-col>
                      <FromDate v-if="dateRange" :fieldData="customField" @loadValue="setValueInData"/>
                      <ToDate v-if="dateRange" :fieldData="customField" @loadValue="setValueInData"/>
                      <AppId v-if="appId" :fieldData="customField" @loadValue="setValueInData" />
                  </b-row>
                  <div class="row">
                    <div class="col-sm-3"></div>
                    <div class="col text-right">
                      <b-button type="submit" variant="primary" class="mr-2">Search</b-button>
                    </div>
                  </div>
                </b-overlay>
              </b-form>
            </ValidationObserver>
      </template>
    </card>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Input from '@/components/license/admin/search/input-field'
import Dropdown from '@/components/license/admin/search/dropdown-field'
import FromDate from '@/components/license/admin/search/from-date'
import ToDate from '@/components/license/admin/search/to-date'
import AppId from '@/components/license/admin/search/application-id'
import { wordsToSnake } from '@/utils/fliter'
import { stepSearchView } from '../api/routes'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  props: ['step', 'menuId'],
  components: {
    Input,
    Dropdown,
    FromDate,
    ToDate,
    AppId,
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
        gridSearch: {
            service_id: 0,
            org_id: 0,
            from_date: '',
            to_date: '',
            application_id: ''
        },
        layout: [],
        formInputData: [],
        unitLoad: false,
        dateRange: false,
        appId: false,
        serviceNamesList: [],
        customField: [],
        is_disable: false,
        componentKey: 0
    }
  },
  created () {
    this.checkSingleService()
  },
  computed: {
      orgList () {
          return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
      },
      menuInfoList () {
        const menuId = this.menuId
        return this.$store.state.LicenseRegistrationService.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
      }
  },
  watch: {
    'gridSearch.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    },
    'gridSearch.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadSearchForm(newVal)
      }
    },
    menuId: function (newVal) {
      if (newVal) {
        this.checkSingleService()
        this.layout = []
          this.formInputData = []
          this.dateRange = false
          this.appId = false
        }
    }
  },
  methods: {
    loadSearchForm (serviceId) {
        this.unitLoad = true
        const formData = {
            service_id: serviceId,
            step_id: this.step.value
        }
        RestApi.getData(licenseRegistrationServiceBaseUrl, stepSearchView, formData).then(response => {
          if (response.success) {
            this.customField = response.search_field
            this.setFieldData(response.data)
            this.checkDateRange(response.search_field)
        } else {
          this.layout = []
          this.formInputData = []
          this.dateRange = false
          this.appId = false
        }
        this.unitLoad = false
        this.$emit('LOAD_DATA', {
          type: 2,
          data: response,
          searchData: this.returnData()
        })
      })
    },
    checkDateRange (searchField) {
      const dateField = searchField.find(item => item.field_id === 'date')
      if (typeof dateField !== 'undefined') {
        this.dateRange = true
      }
      const appIdField = searchField.find(item => item.field_id === 'app')
      if (typeof appIdField !== 'undefined') {
        this.appId = true
      }
    },
    setFieldData (resultData) {
      const laArray = []
      const daArray = []
        resultData.forEach((item) => {
          const layJson = JSON.parse(Object.assign(item.layout))
          const dataJson = Object.assign(JSON.parse(item.data), { tab_name: item.tab.tab_name, field_id: item.id })
          laArray.push(layJson)
          daArray.push(dataJson)
        })
      this.layout = laArray
      this.formInputData = daArray
    },
    getServiceList (orgId) {
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => (item.org_id === orgId && item.step_id === this.step.value))
      return tmpService.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.service_id, text: item.service_name_bn }
        } else {
          return { value: item.service_id, text: item.service_name }
        }
      })
    },
    returnData () {
      let searchField = []
      if (this.formInputData.length) {
        const dynamicField = this.formInputData.map(item => {
          return { field_name: item.field_name, tab_name: item.tab_name, value: item.value }
        })
        searchField = this.setSearchField(dynamicField)
      } else {
        searchField = this.setSearchField(0)
      }
      return searchField
    },
    setSearchField (dynamicField) {
      return Object.assign(this.gridSearch,
          {
            tabList: this.getTabList(),
            dynamic_field: dynamicField,
            service_name: this.getServiceName(this.gridSearch.service_id),
            step_id: this.step.value,
            grid_step_id: this.getGridStep(this.gridSearch.service_id).step_id,
            grid_step_name: wordsToSnake(this.getGridStep(this.gridSearch.service_id).step_name)
          })
    },
    searchSubmit () {
      const data = this.returnData()
      this.$emit('LOAD_DATA', {
          type: 1,
          data: data
        })
    },
    getServiceName () {
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === this.gridSearch.service_id)
      if (typeof tmpService === 'undefined') {
        return ''
      } else {
        return wordsToSnake(tmpService.text_en)
      }
    },
    setValueInData (data) {
      if (data.type === 1) {
        this.gridSearch.from_date = data.value
      }
      if (data.type === 2) {
        this.gridSearch.to_date = data.value
      }
      if (data.type === 3) {
        this.gridSearch.application_id = data.value
      }
    },
    checkSingleService () {
      // const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => (item.step_id === this.step.value))
      if (this.menuInfoList.details.length === 1) {
        this.gridSearch.org_id = this.menuInfoList.org_id
        this.gridSearch.service_id = this.menuInfoList.details[0].service_id
        this.loadSearchForm(this.menuInfoList.details[0].service_id)
        this.is_disable = true
      } else {
        this.is_disable = false
        const gridSearch = {
            service_id: 0,
            org_id: 0,
            from_date: '',
            to_date: '',
            application_id: ''
        }
        this.gridSearch = gridSearch
        this.layout = []
        this.formInputData = []
      }
    },
    getTabList () {
      const formId = this.getGridStep(this.gridSearch.service_id).form_id
      const form = this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList.find(item => item.value === formId)
      if (typeof form === 'undefined') {
        return []
      }
      return form.tabs
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    updateDropdown: function () {
      this.componentKey += 1
    }
  }
}
</script>
