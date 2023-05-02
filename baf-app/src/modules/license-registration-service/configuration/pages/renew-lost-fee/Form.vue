<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.org_id"
                :options="orgProfileList"
                id="org_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('service_name.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="form.service_id"
                :options="serviceList"
                id="service_id"
                :state="errors[0] ? false : (valid ? true : null)"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="amount">
                <template v-slot:label>
                  {{ $t('globalTrans.amount') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="amount"
                  v-model="form.amount"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Challan No" :vid="`challan_no`" rules="required" v-slot="{ errors }">
                <b-form-group
                label-for="challan_no">
                <template v-slot:label>
                  {{$t('component_settings.challan_no')}} <span class="text-danger">*</span>
                </template>
                  <b-form-select
                    plain
                    v-model="form.renew_challan_id"
                    :options="challanList"
                    :id="`challan_no`"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Vat" vid="vat" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="vat">
                <template v-slot:label>
                  {{ $t('step_assign.vat') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="vat"
                  v-model="form.vat"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10">
            <ValidationProvider name="Expire Type" vid="expire_type" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="expire_type"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.date_expire_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-radio-group
                  v-model="form.expire_type"
                  :options="expireTypeList"
                  class="mb-3"
                  value-field="value"
                  text-field="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-radio-group>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10" v-show="form.expire_type === 1">
            <ValidationProvider name="Expire Date" vid="expire_date" :rules="`${form.expire_type === 1 ? 'required' : ''}`">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="expire_date"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.fixed_date')}} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker
                  b-form-datepicker
                  id="expire_date"
                  v-model="form.expire_date"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)">
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10" v-show="form.expire_type === 2">
            <ValidationProvider name="Enter days" vid="expire_days" :rules="`${form.expire_type === 2 ? 'required' : ''}`">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="expire_days"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.enter_days')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="expire_days"
                    v-model="form.expire_days"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10">
            <ValidationProvider name="TAX" vid="tax" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="tax"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('step_assign.tax')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="tax"
                    v-model="form.tax"
                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10">
            <ValidationProvider name="Type" vid="type" rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="type"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.fee_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.type"
                  :options="typeList"
                  id="type"
                  @change="changeFeeType(form.type)"
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
          <b-col lg="10">
            <ValidationProvider name="Type" vid="payment_from" rules="required|min_value:1">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="payment_from"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.payment_from')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.payment_from"
                  :options="paymentFromList"
                  id="payment_from"
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
          <b-col lg="10" v-if="form.type === 3 && form.payment_from === 1">
            <ValidationProvider name="Amount Type" vid="amount_type" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="amount_type"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('component_settings.amount_type')}} <span class="text-danger">*</span>
              </template>
              <b-form-radio-group
                v-model="form.amount_type"
                :options="amountTypeList"
                class="mb-3"
                value-field="value"
                text-field="text"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-radio-group>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10" v-if="form.type === 3 && form.payment_from === 1 && form.amount_type === 1">
            <ValidationProvider name="Fixed amount" vid="fixed_amount" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="fixed_amount"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('component_settings.fixed_Amount')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="fixed_amount"
                v-model="form.fixed_amount"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10" v-if="form.type === 3 && form.payment_from === 1 && form.amount_type === 2">
            <ValidationProvider name="Percentage" vid="percentage_amount" rules="required">
              <b-form-group
                  class="row"
                  label-cols-sm="4"
                  label-for="percentage_amount"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('component_settings.percentage')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="percentage_amount"
                    v-model="form.percentage_amount"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10" v-if="form.type === 3 && form.payment_from >= 2">
            <ValidationProvider name="examine_payment_from_type" vid="examine_payment_from_type" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="examine_payment_from_type"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="examine_payment_from_type"
                  :options="inputList"
                  id="examine_payment_from_type"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value=null>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="10">
            <ValidationProvider :vid="`challan_no`" rules="">
                <b-form-group
                class="row"
                label-cols-sm="4"
                label-for="tax"
                slot-scope="{ valid, errors }"                                  >
                <template v-slot:label>
                  {{$t('component_settings.challan_no')}} <span class="text-danger">*</span>
                </template>
                  <b-form-select
                    plain
                    v-model="form.expire_challan_id"
                    :options="challanList"
                    :id="`challan_no`"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dynamicFormEditData, renewLostStore, renewLostUpdate } from '../../api/routes'
import { snakeToWords } from '@/utils/fliter'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      serviceList: [],
      form: {
        org_id: 0,
        service_id: 0,
        type: 0,
        amount: '',
        vat: '',
        tax: '',
        expire_type: 1,
        amount_type: 1,
        expire_date: '',
        expire_days: '',
        percentage: '',
        fixed_amount: '',
        payment_from: 0,
        type_payment: null,
        type_checkbox: null,
        renew_challan_id: 0,
        expire_challan_id: 0
      },
      typeList: [
        { value: 3, text: 'Renew' },
        { value: 4, text: 'lost' }
      ],
      expireTypeList: [
        { value: 1, text: this.$t('component_settings.fixed_date') },
        { value: 2, text: this.$t('component_settings.enter_days') }
      ],
      amountTypeList: [
        { value: 1, text: this.$t('component_settings.fixed_Amount') },
        { value: 2, text: this.$t('component_settings.percentage') }
      ],
      paymentFromList: [
        { value: 1, text: this.$t('component_settings.normal') },
        { value: 2, text: this.$t('component_settings.type_payment') },
        { value: 3, text: this.$t('component_settings.type_checkbox') }
      ],
      loading: false,
      serviceStepForm: null,
      inputList: [],
      examine_payment_from_type: null,
      challanList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeNameData()
      this.serviceList = this.getServiceList(tmp.org_id)
      this.serviceStepForm = this.getServiceStepForm(tmp.service_id)
      if (tmp.payment_from === 2) { this.examine_payment_from_type = tmp.type_payment }
      if (tmp.payment_from === 3) { this.examine_payment_from_type = tmp.type_checkbox }
      this.form = tmp
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === newVal)
      }
    },
    'form.payment_from': function (newVal, oldVal) {
      if (newVal >= 2 && oldVal <= 1) { this.getInputList(this.getDynamicFormIdFromServiceStepForm()) }
    },
    'form.service_id': function (newVal) {
      this.challanList = this.getChallanList(newVal)
    }
  },
  computed: {
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    getChallanList (serviceId) {
      return this.$store.state.LicenseRegistrationService.commonObj.challanList.filter(item => item.status === 1 && item.service_id === serviceId)
    },
    changeOrganizationId (orgId) {
      this.form.service_id = 0
      this.serviceList = this.getServiceList(orgId)
    },
    changeServiceId (serviceId) {
      this.examine_payment_from_type = null
      this.inputList = []
      this.serviceStepForm = this.getServiceStepForm(serviceId)
      this.getInputList(this.getDynamicFormIdFromServiceStepForm())
    },
    changeFeeType (feeType) {
      this.getInputList(this.getDynamicFormIdFromServiceStepForm())
    },
    incorporateDateExpireType () {
      if (this.form.expire_type === 1) {
        this.form.expire_days = null
      } else if (this.form.expire_type === 2) {
        this.form.expire_date = null
      }
    },
    incorporateExaminePaymentFromType () {
      if (this.form.payment_from === 2) {
        // Type Payment
        this.form.type_payment = this.examine_payment_from_type
        this.form.type_checkbox = null
      } else if (this.form.payment_from === 3) {
        // Type Checkbox
        this.form.type_checkbox = this.examine_payment_from_type
        this.form.type_payment = null
      } else {
        this.form.type_checkbox = this.form.type_payment = null
      }
    },
    getServiceStepForm (serviceId) {
      const tmpServiceStepForm = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      return tmpServiceStepForm !== undefined ? tmpServiceStepForm : null
    },
    getDynamicFormIdFromServiceStepForm () {
      return this.serviceStepForm !== null ? this.serviceStepForm.form_id : 0
    },
    getServiceList (orgID) {
      const serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgID)
      return serviceList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getFeeNameData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getInputList (dynamicFormId) {
      if (!dynamicFormId) { return false }
      if (this.form.service_id === 0) { return false }
      if (this.form.type === 0 || this.form.type === 4) { return false }
      if (this.form.payment_from === 0 || this.form.payment_from === 1) { return false }

      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + dynamicFormId).then(response => {
        if (response.success && response.data) {
          const finalList = []
          // 1) Tabs
          response.data.tabs.forEach(item => {
            const tmpList = {
                label: snakeToWords(item.tab_name),
                options: []
              }
            // 2) Layouts
            item.layouts.forEach(i => {
              const input = JSON.parse(i.data)
              if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'options' || input.field_type === 'paymentCheckbox' || input.field_type === 'payment' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date') {
                  tmpList.options.push({
                    text: input.label, value: input.field_name
                  })
                }
            })
            finalList.push(tmpList)
          })
          this.inputList = finalList
        } else {
          /** Data Not Found */
          this.inputList = []
        }
        this.loading = false
      })
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${renewLostUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, renewLostStore, this.form)
      }
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
