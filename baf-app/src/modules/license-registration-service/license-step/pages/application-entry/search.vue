<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('li_step.application_search') }}</h4>
      </template>
      <template v-slot:searchBody>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
              <b-form  @submit.prevent="handleSubmit(searchSubmit)" >
                <b-overlay :show="unitLoad">
                  <b-row>
                    <b-col lg="6" sm="12" v-if="adminView">
                      <ValidationProvider name="Office Type" vid="officeTypeId">
                        <b-form-group
                          label-for="officeTypeId"
                          slot-scope="{ valid, errors }"
                        >
                          <template v-slot:label>
                              {{ $t('userManagement.office_type') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                          plain
                          v-model="gridSearch.officeTypeId"
                          :options="officeTypeList"
                          id="officeTypeId"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                          {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" sm="12" v-if="adminView">
                      <ValidationProvider name="Office" vid="officeId">
                        <b-form-group
                            label-for="officeId"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.office') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="gridSearch.officeId"
                            :options="officeList"
                            id="officeId"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" sm="12" v-if="adminView">
                      <ValidationProvider name="Designation Id" vid="designation_id">
                          <b-form-group
                              label-for="designation_id"
                              slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                              {{ $t('organogram.designation')}}
                              </template>
                              <b-form-select
                              plain
                              v-model="gridSearch.designation_id"
                              :options="designationList"
                              id="designation_id"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="6" sm="12" v-if="adminView">
                      <ValidationProvider name="createdBy" vid="createdBy">
                          <b-form-group
                              label-for="createdBy"
                              slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                              {{ $t('priceMonitoring.officer_name')}}
                              </template>
                              <b-form-select
                              plain
                              v-model="gridSearch.createdBy"
                              :options="officerList"
                              id="createdBy"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{ officerLoading ? 'Loading..' : $t('globalTrans.select')}}</b-form-select-option>
                              </template>
                              </b-form-select>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="4" sm="4">
                      <ValidationProvider name="Organization" vid="org_id" rules="required">
                        <b-form-group
                          label-for="org_id"
                          slot-scope="{ valid, errors }"
                        >
                          <template v-slot:label>
                          {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
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
                            label-for="service_id"
                            slot-scope="{ valid, errors }"
                          >
                            <template v-slot:label>
                            {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                                v-model="gridSearch.service_id"
                                :options="serviceNamesList"
                                id="service_id"
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
                    </b-col>
                    <FromDate v-if="dateRange" :fieldData="customField" @loadValue="setValueInData"/>
                    <ToDate v-if="dateRange" :fieldData="customField" @loadValue="setValueInData"/>
                    <AppId v-if="appId" :fieldData="customField" @loadValue="setValueInData" />
                  </b-row>
                  <div class="row">
                    <div class="col-sm-3"></div>
                    <div class="col text-right">
                      <b-button type="submit" variant="primary" class="mr-2 btn-sm">Search</b-button>
                    </div>
                  </div>
                </b-overlay>
              </b-form>
            </ValidationObserver>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
import Input from '@/components/license/admin/search/input-field'
import FromDate from '@/components/license/admin/search/from-date'
import ToDate from '@/components/license/admin/search/to-date'
import AppId from '@/components/license/admin/search/application-id'
import { wordsToSnake } from '@/utils/fliter'
import { stepSearchView, designationWiseUser } from '../../api/routes'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
export default {
  props: ['orgId', 'serviceId'],
  components: {
    Input,
    FromDate,
    ToDate,
    AppId,
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
        step_id: 0,
        gridSearch: {
          service_id: 0,
          org_id: 0,
          from_date: '',
          to_date: '',
          application_id: '',
          officeId: 0,
          officeTypeId: 0,
          designation_id: 0,
          createdBy: 0
        },
        layout: [],
        formInputData: [],
        unitLoad: false,
        dateRange: false,
        appId: false,
        serviceNamesList: [],
        customField: [],
        is_disable: false,
        officeList: [],
        designationList: [],
        userList: [],
        assignDesignationList: [],
        officerList: [],
        adminView: false,
        officerLoading: false
    }
  },
  created () {
      this.getAssignDesignationList()
      if (this.$store.state.Auth.authUser.user_id !== 1) {
        this.gridSearch.createdBy = this.$store.state.Auth.authUser.user_id
        this.is_disable = true
        this.adminView = false
      } else {
        this.adminView = true
      }
      if (this.orgId) {
          this.gridSearch.org_id = this.orgId
      }
      if (this.serviceId) {
          this.gridSearch.service_id = this.serviceId
      }
  },
  computed: {
    officeTypeList: function () {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === this.gridSearch.org_id).map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
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
        this.getInitialStep(newVal)
        this.loadSearchForm(newVal)
      }
    },
    'gridSearch.officeTypeId': function (newValue) {
      this.officeList = this.getOfficeList(newValue)
    },
    'gridSearch.officeId': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getDesignationList(newVal)
      }
    },
    'gridSearch.designation_id': function (newVal) {
      this.getOfficerList(newVal)
    }
  },
  methods: {
    async getAssignDesignationList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(commonServiceBaseUrl, '/organogram/assign-designations/get-all')
      if (result.success) {
        this.assignDesignationList = result.data
      } else {
        this.assignDesignationList = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getInitialStep (serviceId) {
      const tmpStep = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(step => step.service_id === serviceId && step.order === 1)
      this.step_id = typeof tmpStep !== 'undefined' ? tmpStep.step_id : 0
    },
    loadSearchForm (serviceId) {
        this.unitLoad = true
        const formData = {
            service_id: serviceId,
            step_id: this.step_id
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
          searchData: this.returnData(),
          service_id: this.gridSearch.service_id,
          step_id: this.step_id
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
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => (item.org_id === orgId) && (item.public_application === 1))
    },
    returnData () {
      let searchField = []
      if (this.formInputData.length) {
        const dynamicField = this.formInputData.map(item => {
          return { field_name: item.field_name, tab_name: item.tab_name, value: item.value }
        })
        searchField = searchField = this.setSearchField(dynamicField)
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
            step_id: this.step_id,
            grid_step_id: this.getGridStep(this.gridSearch.service_id).step_id,
            grid_step_name: wordsToSnake(this.getGridStep(this.gridSearch.service_id).step_name)
          })
    },
    searchSubmit () {
      const data = this.returnData()
      this.$emit('LOAD_DATA', {
          type: 1,
          data: data,
          service_id: this.gridSearch.service_id,
          step_id: this.step_id
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
    getGridStep (serviceId) {
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      return tmpService
    },
    getTabList () {
      const formId = this.getGridStep(this.gridSearch.service_id).form_id
      const form = this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList.find(item => item.value === formId)
      if (typeof form === 'undefined') {
        return []
      }
      return form.tabs
    },
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
    },
    getDesignationList (officeId) {
      const assignDesignationList = this.assignDesignationList.filter(item => item.office_id === officeId && item.org_id === this.orgId && item.office_type_id === this.gridSearch.officeTypeId)
      this.designationList = assignDesignationList.map(item => {
        const designation = this.$store.state.CommonService.commonObj.designationList.find(obj => obj.value === item.designation_id)
        return designation
      })
    },
    async getOfficerList (designationId) {
      this.officerLoading = true
        const params = {
          org_id: parseInt(this.orgId),
          office_type_id: parseInt(this.gridSearch.officeTypeId),
          office_id: parseInt(this.gridSearch.officeId),
          designation_id: parseInt(this.gridSearch.designation_id)
        }
        await RestApi.getData(licenseRegistrationServiceBaseUrl, designationWiseUser, params)
        .then(response => {
          if (response.success) {
            const data = response.data
            this.officerList = data.map(item => {
              return Object.assign({ value: item.user_id, text: this.$i18n.locale === 'bn' ? item.name_bn : item.name })
            })
          } else {
            this.officerList = []
          }
          this.officerLoading = false
      })
    }
  }
}
</script>
