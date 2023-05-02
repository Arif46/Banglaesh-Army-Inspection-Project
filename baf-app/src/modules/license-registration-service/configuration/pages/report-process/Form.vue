<template>
  <div class="inner-section">
    <b-overlay :show="loading">
      <card>
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">Report Process Form</h4>
        </template>
        <template v-slot:searchBody>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(register)" >
              <b-row>
                <b-col lg="4" sm="4">
                  <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="organization"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('orgProfile.org_name') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.org_id"
                        :options="organizationList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="4">
                  <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="service_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('service_name.service_name') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.service_id"
                        :options="serviceList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="4">
                  <ValidationProvider name="Form" vid="form_id" rules="">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="form_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('globalTrans.form') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.form_id"
                        :options="formList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="4">
                  <ValidationProvider name="Title (En)" vid="title_en" rules="required">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="title_en"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('globalTrans.title') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        plain
                        v-model="formData.title_en"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                      </b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" sm="4">
                  <ValidationProvider name="Title (Bn)" vid="title_bn" rules="">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="title_bn"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('globalTrans.title_bn') }}
                      </template>
                      <b-form-input
                        plain
                        v-model="formData.title_bn"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                      </b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" xl="12">
                  <p class="form-style-2-heading">
                    <b>{{$t('component_settings.searching_section')}}</b>
                  </p>
                </b-col>
              </b-row>
              <template>
                <b-row v-for="(item, index) in formData.search" :key="index">
                  <b-col lg="5" xl="5">
                    <ValidationProvider name="Field" :vid="`field_id`+index" rules="">
                      <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label-for="`field_id`+index"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="item.field_id"
                          :options="inputList"
                          :id="`field_id`+index"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                            <b-form-select-option value="date" >{{ $t('component_settings.date_range') }}</b-form-select-option>
                            <b-form-select-option value="app" >{{ $t('externalUserIrrigation.application_id') }}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="4" xl="4">
                    <ValidationProvider name="Required" :vid="`is_required`+index">
                      <b-form-group
                          class="row"
                          label-cols-sm="3"
                          :label-for="`is_required`+index"
                      >
                          <template v-slot:label>
                            {{ $t('component_settings.required') }}
                          </template>
                          <b-form-checkbox
                              class="mt-2"
                              :id="`is_required`+index"
                              v-model="item.is_required"
                          > <span v-if="item.is_required">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                          </b-form-checkbox>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="3" xl="3">
                    <b-button v-if="index === 0" @click="addNew()" type="button" variant="primary" class="mr-2">+</b-button>
                    <b-button v-if="index !== 0" @click="remove(index)" type="button" variant="danger" class="mr-2">x</b-button>
                  </b-col>
                </b-row>
              </template>
              <b-row>
                  <b-col lg="12" xl="12">
                    <p class="form-style-2-heading">
                      <b>{{$t('component_settings.grid_section')}}</b>
                    </p>
                  </b-col>
                  <b-col lg="12" xl="12" v-if="inputListGrid.length">
                    <ValidationProvider name="Grids" vid="grids" rules="required|min_value:1">
                      <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="grids"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-checkbox-group
                          class="text-dark"
                          v-model="formData.grids"
                          :options="inputListGrid"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-checkbox-group>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="12" xl="12" v-else class="text-center">
                    <p class="text-dark">({{ $t('Field Not Found') }})</p>
                  </b-col>
              </b-row>
              <b-row>
                  <b-col lg="12" xl="12">
                    <p class="form-style-2-heading">
                      <b>{{$t('component_settings.action_section')}}</b>
                    </p>
                  </b-col>
                  <b-col lg="2" xl="2">
                    <ValidationProvider name="Status" vid="status" rules="">
                      <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="status"
                        slot-scope="{ errors }"
                        >
                        <template v-slot:label>
                          {{ $t('globalTrans.status') }}
                        </template>
                        <b-form-checkbox
                        class="mt-1"
                        id="status"
                        v-model="formData.status"
                        ></b-form-checkbox>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="2" xl="2">
                    <ValidationProvider name="Details" vid="detail" rules="">
                      <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="detail"
                        slot-scope="{ errors }"
                        >
                        <template v-slot:label>
                          {{ $t('globalTrans.details') }}
                        </template>
                        <b-form-checkbox
                        class="mt-1"
                        id="detail"
                        v-model="formData.detail"
                        ></b-form-checkbox>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
              </b-row>
              <div class="row">
                <div class="col-sm-3"></div>
                <div class="col text-right">
                  <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                </div>
              </div>
            </b-form>
          </ValidationObserver>
        </template>
      </card>
    </b-overlay>
  </div>
</template>
<script>
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '../../../../../config/api_config'
import { reportProcessStore, reportProcessUpdate, dynamicFormEditData } from '../../api/routes'
import { snakeToWords } from '@/utils/fliter'

export default {
  props: ['id'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        org_id: 0,
        service_id: 0,
        form_id: 0,
        search: [
          {
            field_id: '',
            is_required: false
          }
        ],
        grids: []
      },
      stepList: [],
      formList: [],
      formListAction: [],
      inputList: [],
      inputListGrid: [],
      serviceList: [],
      loading: false
    }
  },
  created () {
    if (this.$route.query.id) {
      const tmp = this.getStepnameData()
      const search = JSON.parse(tmp.search)
      const grids = JSON.parse(tmp.grids)
      this.formData = Object.assign({}, tmp, { search: search, grids: grids })
    }
  },
  computed: {
    organizationList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    dynamicButtonList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.filter(item => item.status === 1)
    }
  },
  watch: {
    'formData.org_id': function (newVal) {
      this.serviceList = this.getServiceList(newVal)
    },
    'formData.service_id': function (n, o) {
       if (n !== o) {
        this.formList = this.getStepWiseForm(n, 2)
       }
    },
    'formData.form_id': function (n, o) {
       if (n !== o) {
        this.getInputList(n)
       }
    }
  },
  methods: {
    addNew () {
      const tmp = {
        field_id: 0,
        is_required: false
      }
      this.formData.search.push(tmp)
    },
    remove (index) {
      this.formData.search.splice(index, 1)
    },
    getStepWiseForm (stepOrServiceId, type) {
        let tmpFormList
        if (type === 2) {
          tmpFormList = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.filter(item => (item.service_id === parseInt(stepOrServiceId) && item.form_type === parseInt(type)))
        } else {
          tmpFormList = []
        }
        const stepList = tmpFormList.map(item => {
            if (this.$i18n.locale === 'bn') {
              return { text: item.form_title, value: item.form_id }
            } else {
              return { text: item.form_title, value: item.form_id }
            }
        })
        return stepList
    },
    getStepnameData () {
      let tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.query.id))
      const isStatus = Boolean(tmpData.status)
      const isDetail = Boolean(tmpData.detail)
      tmpData = Object.assign({}, tmpData, {
        status: isStatus,
        detail: isDetail
      })
      return JSON.parse(JSON.stringify(tmpData))
    },
    async register () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: false }
      if (this.$route.query.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${reportProcessUpdate}/${this.$route.query.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, reportProcessStore, this.formData)
      }
      this.loading = false
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$router.go(-1)
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    },
    getInputList (dynamicFormId) {
      if (dynamicFormId !== 0) {
        this.loading = true
        RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + dynamicFormId).then(response => {
          if (response.success) {
            const finalList = []
            const finalListGrid = []
            response.data.tabs.forEach(item => {
              const tmpList = {
                  label: snakeToWords(item.tab_name),
                  options: []
                }
              item.layouts.forEach(i => {
                const input = JSON.parse(i.data)
                if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'options' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date') {
                    tmpList.options.push({
                      text: input.label, value: i.id
                    })
                    finalListGrid.push({
                      text: input.label, value: i.id
                    })
                  }
              })
              finalList.push(tmpList)
            })
            if (this.$i18n.locale === 'bn') {
              finalListGrid.push({
                text: 'লাইসেন্স নং', value: 10002
              }, {
                text: 'প্রদানের তারিখ', value: 10000
              }, {
                text: 'মেয়াদ উত্তীর্ণের তারিখ', value: 10001
              })
            } else {
              finalListGrid.push({
                text: 'License No', value: 10002
              }, {
                text: 'Issue Date', value: 10000
              }, {
                text: 'Expire Date', value: 10001
              })
            }
            this.inputList = finalList
            this.inputListGrid = finalListGrid
          }
          this.loading = false
        })
      }
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    }
  }
}
</script>
<style scoped>
  .form-style-2-heading{
    color: #3f414d;
    font-style: italic;
    border-bottom: 1px solid #3f414d;
    margin-bottom: 20px;
    font-size: 15px;
    padding-bottom: 3px;
  }
</style>
