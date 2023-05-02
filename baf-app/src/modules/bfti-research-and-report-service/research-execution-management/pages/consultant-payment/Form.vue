<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Document Type" vid="document_type_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="document_type_id"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('bfti.doc_type')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.document_type_id"
                        :options="documentTypeList"
                        id="document_type_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Title" vid="contract_sign_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="contract_sign_id">
                      <template v-slot:label>
                        {{ $t('research_execution.title_or_topic') }} <span class="text-danger">*</span>
                      </template>
                     <b-form-select
                        plain
                        v-model="form.contract_sign_id"
                        :options="RFPResearchList"
                        id="contract_sign_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                      <template v-slot:first>
                        <b-form-select-option :value="0">{{ titleLoad ? 'Loading....' : $t('globalTrans.select') }}</b-form-select-option>
                      </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Client" vid="client">
                    <b-form-group
                      label-for="client">
                      <template v-slot:label>
                        {{ $t('research_execution.client') }}
                      </template>
                      <b-form-input
                        id="client"
                        v-model="form.client"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Project Duration">
                    <b-form-group
                      label-for="project_duration">
                      <template v-slot:label>
                        {{ $t('research_execution.project_duration') }}
                      </template>
                      <b-form-input
                        id="project_duration"
                        v-model="form.duration"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('research_execution.consultant_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Employee Name" vid="resource_pool_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="resource_pool_id"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('globalTrans.name')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.resource_pool_id"
                        :options="employeeList"
                        id="resource_pool_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                        <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="designation" vid="designation">
                    <b-form-group
                      label-for="designation">
                      <template v-slot:label>
                        {{ $t('globalTrans.designation') }}
                      </template>
                      <b-form-input
                        id="designation"
                        v-model="form.designation"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Organization" vid="organization">
                    <b-form-group
                      label-for="organization">
                      <template v-slot:label>
                        {{ $t('globalTrans.organization') }}
                      </template>
                      <b-form-input
                        id="organization"
                        v-model="form.organization"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Date" vid="date_from">
                    <b-form-group
                      label-for="date_from">
                      <template v-slot:label>
                        {{ $t('research_execution.contract_date') + ' ' + $t('globalTrans.from') }}
                      </template>
                      <date-picker
                        id="date_from"
                        class="form-control"
                        v-model="form.date_from"
                        disabled
                      >
                      </date-picker>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Date" vid="date_to">
                    <b-form-group
                      label-for="date_to">
                      <template v-slot:label>
                        {{ $t('research_execution.contract_date') + ' ' + $t('globalTrans.to') }}
                      </template>
                      <date-picker
                        id="date_to"
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        v-model="form.date_to"
                        disabled
                      >
                      </date-picker>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Amount" vid="contract_amount">
                    <b-form-group
                      label-for="contract_amount">
                      <template v-slot:label>
                        {{ $t('researchRequestManagement.contract_amount') }}
                      </template>
                      <b-form-input
                        id="contract_amount"
                        v-model="form.contract_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Already Paid Amount" vid="already_paid_amount">
                    <b-form-group
                      label-for="already_paid_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.total') + ' ' + $t('research_execution.paid_amount') }}
                      </template>
                      <b-form-input
                        id="already_paid_amount"
                        v-model="form.already_paid_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Remaining Amount" vid="rem_contract_amount">
                    <b-form-group
                      label-for="rem_contract_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rem_contract_amount') }}
                      </template>
                      <b-form-input
                        id="rem_contract_amount"
                        v-model="form.rem_contract_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('research_execution.consultant_payment_info') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Paid Amount" vid="paid_amount" v-slot="{ errors }" rules="min_value:1">
                    <b-form-group
                      label-for="paid_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.paid_amount') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="paid_amount"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        v-model="form.paid_amount"
                        @keyup="payableAmountCalculate(form.paid_amount)"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Tax (%)" vid="tax" v-slot="{ errors }" rules="min_value:1|max_value:100">
                    <b-form-group
                      label-for="tax">
                      <template v-slot:label>
                        {{ $t('research_execution.tax') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="tax"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        v-model="form.tax"
                        v-on:keyup="vatOnChange()"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Paid Amount (Paid amount-Tax)" vid="actual_paid_amount" v-slot="{ errors }" rules="min_value:1">
                    <b-form-group
                      label-for="actual_paid_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.paid_amount_without_tax') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="actual_paid_amount"
                        v-model="form.actual_paid_amount"
                        :state="errors[0] ? false : (valid ? true : null)"
                        disabled
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Payment Date" vid="payment_date" v-slot="{ errors }" rules="required">
                    <b-form-group
                      label-for="payment_date">
                      <template v-slot:label>
                        {{ $t('research_execution.payment_date') }} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="payment_date"
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        v-model="form.payment_date"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :class="errors[0] ? 'is-invalid' : ''"
                      >
                      </date-picker>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remarks" vid="remark" v-slot="{ errors }">
                    <b-form-group
                      label-for="remark">
                      <template v-slot:label>
                        {{ $t('research_execution.remarks') }}
                      </template>
                      <b-form-textarea
                        id="remarks"
                        rows="2"
                        v-model="form.remark"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                      </b-form-textarea>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
              <b-button type="submit" @click="form.status = 2 " variant="primary" class="mr-2" :disabled="buttonDisabled">{{$t('configuration.final_save')}}</b-button>
              <b-button type="submit" @click="form.status = 1 " variant="warning" class="mr-2" :disabled="buttonDisabled">{{$t('configuration.save_draft')}}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
            <!-- <pre>{{ form }}</pre> -->
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { consultantPaymentStoreApi, contractSignedApi, contractSignLists, consultantInfoApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      titleLoad: false,
      buttonDisabled: false,
      budget: [],
      locationIndex: '',
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        id: '',
        document_type_id: 0,
        contract_sign_id: 0,
        duration: '',
        resource_pool_id: 0,
        rem_contract_amount: 0,
        already_paid_amount: 0,
        paid_amount: 0,
        tax: 0,
        contract_amount: 0,
        actual_paid_amount: 0,
        tax_amount: 0,
        payable_amount: 0,
        research_request_id: 0,
        prepare_rfp_id: 0
      },
      RFPResearchList: [],
      employeeList: []
    }
  },
  created () {
    if (this.item) {
      this.form = this.item
      this.contractSigningData()
    }
  },
  watch: {
  'form.document_type_id': function (newVal, oldVal) {
    this.RFPResearchList = this.titleTopicList()
    this.form.client = ''
    this.form.project_duration = ''
  },
  'form.contract_sign_id': function (newVal, oldVal) {
    this.contractSigningData()
  },
  'form.resource_pool_id': function (newVal, oldVal) {
    this.consultantInformation()
  }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    documentTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    titleTopicList () {
      this.titleLoad = true
      const params = Object.assign({}, { document_type_id: this.form.document_type_id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignLists, params).then(response => {
        if (response.success) {
        this.RFPResearchList = response.data.map(item => {
        if (this.$i18n.locale === 'en') {
            if (this.form.document_type_id === 2) {
              return { value: item.id, text: item.prepare_rfp.text, prepare_rfp_id: item.prepare_rfp.id }
            }
            if (this.form.document_type_id === 3) {
              return { value: item.id, text: item.research.text, research_id: item.research.id, research_request_id: item.research.id }
            }
          } else {
            if (this.form.document_type_id === 2) {
              return { value: item.id, text: item.prepare_rfp.text_bn, prepare_rfp_id: item.prepare_rfp.id }
            }
            if (this.form.document_type_id === 3) {
              return { value: item.id, text: item.research.text_bn, research_request_id: item.research.id }
            }
          }
        })
        }
        this.titleLoad = false
      })
    },
    contractSigningData () {
      this.buttonDisabled = false
      const loadingState = { loading: true, listReload: true }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { document_type_id: this.form.document_type_id, contract_sign_id: this.form.contract_sign_id, research_request_id: this.form.research_request_id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignedApi, params).then(response => {
        if (response.success) {
          this.form.client = this.$i18n.locale === 'en' ? response.data.organization_ministry_division : response.data.organization_ministry_division_bn
          this.form.research_request_id = response.data.research_request_id
          if (response.data.prepare_rfp) {
            this.form.duration = response.data.prepare_rfp !== undefined ? response.data.prepare_rfp.duration : ''
          }
          if (response.data.research) {
            this.form.duration = response.data.research !== undefined ? response.data.research.duration : ''
          }

          this.employeeList = response.consultantInfo.map(consultantItem => {
            if (this.$i18n.locale === 'en') {
              return { value: consultantItem.resource_pool_id, text: consultantItem.resource_pool.name_en, assign_consultant_id: consultantItem.id }
            } else {
              return { value: consultantItem.resource_pool_id, text: consultantItem.resource_pool.name_bn, assign_consultant_id: consultantItem.id }
            }
          })
        }
        this.consultantInformation()
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    consultantInformation () {
      if (this.form.document_type_id === 2) {
        const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
        this.form.prepare_rfp_id = researchId.prepare_rfp_id
      }
      if (this.form.document_type_id === 3) {
        const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
        this.form.research_request_id = researchId.research_request_id
      }
      this.buttonDisabled = false
      const loadingState = { loading: true, listReload: true }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { document_type_id: this.form.document_type_id, resource_pool_id: this.form.resource_pool_id, prepare_rfp_id: this.form.prepare_rfp_id, research_request_id: this.form.research_request_id, consultant_id: this.item !== undefined ? this.item.id : '' })
      RestApi.getData(bftiResReportServiceBaseUrl, consultantInfoApi, params).then(response => {
        if (response.success) {
          this.form.organization = this.$i18n.locale === 'en' ? response.data.resource_pool.organization : response.data.resource_pool.organization_bn
          this.form.designation = this.$i18n.locale === 'en' ? response.data.resource_pool.designation : response.data.resource_pool.designation_bn
          this.form.contract_amount = response.data.amount
          this.form.date_to = response.data.date_to
          this.form.date_from = response.data.date_from
          this.form.already_paid_amount = response.data.already_paid_amount
          this.form.rem_contract_amount = response.data.rem_contract_amount
          if (response.data.checkDraftValue === 1) {
            this.buttonDisabled = true
            this.$toast.success({
              title: 'Success',
              message: this.$t('research_execution.draft_status'),
              color: '#D6E09B'
            })
            // this.$bvModal.hide('modal-form')
          }
        } else {
          this.$toast.error({
              title: 'Success',
              message: 'Consultant Data Not Found!!'
            })
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    payableAmountCalculate (amount) {
      const totUsableAmount = parseInt(this.form.rem_contract_amount)

      if (amount < totUsableAmount) {
        this.form.paid_amount = amount
      }

      if (amount > totUsableAmount) {
        this.form.paid_amount = totUsableAmount
      }
    },
    vatOnChange () {
      const percentage = parseFloat(this.form.tax) / 100
      const tax = parseFloat(this.form.paid_amount) * percentage
      this.form.actual_paid_amount = parseFloat(this.form.paid_amount) - tax
      this.form.tax_amount = tax
      this.form.payable_amount = parseFloat(this.form.contract_amount) - parseFloat(this.form.already_paid_amount) - parseFloat(this.form.paid_amount)
      // if (this.form.document_type_id === 2) {
      //     const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
      //     this.form.prepare_rfp_id = researchId.prepare_rfp_id
      //   }
      //   if (this.form.document_type_id === 3) {
      //     const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
      //     this.form.research_request_id = researchId.research_request_id
      //   }
    },
    saveUpdate () {
      let msg = ''
      if (this.form.status === 1) {
        msg = window.vm.$t('configuration.save_draft_mess')
      }
      if (this.form.status === 2) {
        msg = window.vm.$t('configuration.final_save_mess')
      }
      window.vm.$swal({
        title: msg,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.Approval()
        }
      })
    },
    async Approval () {
      const assignConsultantObj = this.employeeList.find(item => item.value === this.form.resource_pool_id)
      this.form.assign_consultant_id = assignConsultantObj.assign_consultant_id
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      // const params = Object.assign({}, { form: this.form, budget: this.budget })
      result = await RestApi.postData(bftiResReportServiceBaseUrl, consultantPaymentStoreApi, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
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
