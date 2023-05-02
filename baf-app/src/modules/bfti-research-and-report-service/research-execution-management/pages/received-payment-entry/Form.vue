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
                  <ValidationProvider name="Budget" vid="client">
                    <b-form-group
                      label-for="client">
                      <template v-slot:label>
                        {{ $t('research_execution.client') }}
                      </template>
                      <b-form-input
                        id="client"
                        v-model="contractSignData.client"
                        :state="errors[0] ? false : (valid ? true : null)"
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
                        v-model="contractSignData.duration"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Contract Amount">
                    <b-form-group
                      label-for="contract_amount">
                      <template v-slot:label>
                        {{ $t('researchRequestManagement.contract_amount') }}
                      </template>
                      <b-form-input
                        id="contract_amount"
                        v-model="contractSignData.contract_amount"
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
                  <ValidationProvider name="Remaining Amount" vid="rem_amount">
                    <b-form-group
                      label-for="rem_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rem_amount') }}
                      </template>
                      <b-form-input
                        id="rem_amount"
                        v-model="contractSignData.rem_amount"
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
              <h5 class="card-title"> {{ $t('research_execution.payment_schedule') }}</h5>
            </template>
            <template v-slot:body>
               <b-table-simple bordered>
                <b-tr>
                  <b-td>{{ $t('researchRequestManagement.installment') }}</b-td>
                  <b-td>{{$t('researchRequestManagement.payment_for')}}</b-td>
                  <b-td>{{ $t('researchRequestManagement.installment_amount') }}</b-td>
                  <b-td>{{$t('research_execution.rcv_amount')}}</b-td>
                  <b-td>{{$t('research_execution.rem_amount')}}</b-td>
                </b-tr>
                <b-tr v-for="(item, index) in contractSignData.budgets" :key="index">
                <b-td> {{ getInstallmentName(item.installment_id) }} </b-td>
                <b-td> {{ item.payment_for }} </b-td>
                <b-td> {{ $n(item.installment_amount, { useGrouping: false }) }} </b-td>
                <b-td> {{ $n(item.rcv_amount, { useGrouping: false }) }} </b-td>
                <b-td> {{ $n(item.rem_amount, { useGrouping: false }) }} </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('research_execution.bill_collection') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Installment No" vid="installment_no" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="installment_no">
                      <template v-slot:label>
                        {{ $t('research_execution.ins_no') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.installment_id"
                        :options="budgetInstallmentList"
                        id="installment_no"
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
                  <ValidationProvider name="Installment Amount" vid="installment_amount">
                    <b-form-group
                      label-for="installment_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.ins_amount') }}
                      </template>
                      <b-form-input
                        id="installment_amount"
                        v-model="form.installment_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="rem_install_amount" vid="rem_install_amount">
                    <b-form-group
                      label-for="rem_install_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rem_install_amount') }}
                      </template>
                      <b-form-input
                        id="rem_install_amount"
                        v-model="form.rem_install_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Received Amount" vid="rcv_amount" rules="min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="rcv_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rcv_amount') }}  <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="rcv_amount"
                        v-model="form.rcv_amount"
                        v-on:keyup="totRcvOnChange(form.rcv_amount)"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Vat & Tax" vid="vat_tax" rules="min_value:1|max_value:100" v-slot="{ errors }">
                    <b-form-group
                      label-for="vat_tax">
                      <template v-slot:label>
                        {{ $t('research_execution.tax_vat') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="vat_tax"
                        v-model="form.tax_vat"
                        @input="vatOnChange()"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Actual Received Amount" vid="actual_rcv_amount" rules="min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="actual_rcv_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.actual_rcv_amount') }}  <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="actual_rcv_amount"
                        v-model="form.actual_rcv_amount"
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
                  <ValidationProvider name="Receive Date" vid="rcv_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="rcv_date">
                      <template v-slot:label>
                        {{ $t('research_execution.rcv_date') }} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        id="rcv_date"
                        v-model="form.rcv_date"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :class="errors[0] ? 'is-invalid' : ''">
                      </date-picker>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Receive Through" vid="receive_through"  rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="receive_through">
                      <template v-slot:label>
                        {{ $t('research_execution.receive_through') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="receive_through"
                        v-model="form.rcv_through"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remark" vid="remarks">
                    <b-form-group
                      label-for="remarks">
                      <template v-slot:label>
                        {{ $t('research_execution.remarks') }}
                      </template>
                      <b-form-textarea
                        id="remarks"
                        rows="2"
                        v-model="form.remark">
                      </b-form-textarea>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <!-- {{RFPResearchList}} -->
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
              <b-button type="submit" @click="form.status = 2 " variant="primary" class="mr-2" :disabled="buttonDisabled">{{$t('configuration.final_save')}}</b-button>
              <b-button type="submit" @click="form.status = 1 " variant="warning" class="mr-2" :disabled="buttonDisabled">{{$t('configuration.save_draft')}}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { rcvPaymentStoreApi, contractSignApi, contractSignedList } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      buttonDisabled: false,
      titleLoad: false,
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: false,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        document_type_id: 0,
        contract_sign_id: 0,
        duration: '',
        installment_no: 0,
        rcv_date: new Date(),
        installment_id: 0,
        user_id: this.$store.state.Auth.authUser.user_id,
        research_request_id: null,
        prepare_rfp_id: null,
        cnt_sign_budget_detail_id: 0,
        rcv_amount: 0,
        editFromCheck: 0
      },
      RFPResearchList: [],
      researchRequestData: {},
      contractSignData: {},
      budgetInstallmentList: []
    }
  },
  created () {
    if (this.item) {
      this.form = this.item
      this.form.editFromCheck = 1
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
  'form.installment_id': function (newVal, oldVal) {
    this.installmentInfo()
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
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignedList, params).then(response => {
        if (response.success) {
        this.RFPResearchList = response.data.map(item => {
          if (this.$i18n.locale === 'en') {
            if (this.form.document_type_id === 2) {
              return { value: item.id, text: item.prepare_rfp.text, prepare_rfp_id: item.prepare_rfp.id }
            }
            if (this.form.document_type_id === 3) {
              return { value: item.id, text: item.research.text, research_request_id: item.research.id }
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
        this.contractSignData = {}
        this.titleLoad = false
      })
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
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, rcvPaymentStoreApi, this.form)

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
    },
    contractSigningData () {
      this.buttonDisabled = false
      const loadingState = { loading: true, listReload: true }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { document_type_id: this.form.document_type_id, contract_sign_id: this.form.contract_sign_id, research_request_id: this.form.research_request_id, editFromCheck: this.form.editFromCheck })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignApi, params).then(response => {
        if (response.success) {
          this.contractSignData = response.data
          this.contractSignData.client = this.$i18n.locale === 'en' ? this.contractSignData.organization_ministry_division : this.contractSignData.organization_ministry_division_bn

          if (this.contractSignData.prepare_rfp) {
            this.contractSignData.duration = this.contractSignData.prepare_rfp !== undefined ? this.contractSignData.prepare_rfp.duration : ''
          }
          if (this.contractSignData.research) {
            this.contractSignData.duration = this.$i18n.locale === 'en' ? this.contractSignData.research !== undefined ? this.contractSignData.research.duration : '' : this.contractSignData.research !== undefined ? this.contractSignData.research.duration_bn : ''
          }

          const budgetInstallmentList = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.filter(item => item.status === 1)

          const budgetInstallmentListCustom = []
          response.data.budgets.forEach(item => {
            const budgetInstallmenItem = budgetInstallmentList.find(obj => obj.value === parseInt(item.installment_id))
            if (budgetInstallmenItem !== undefined) {
              budgetInstallmentListCustom.push(budgetInstallmenItem)
            }
          })

          this.budgetInstallmentList = budgetInstallmentListCustom

          this.installmentInfo()

          if (response.data.check_draft === 1) {
            this.buttonDisabled = true
            this.$toast.success({
              title: 'Success',
              message: 'Please Completed previous Draft!!!',
              color: '#D6E09B'
            })
          }

          if (this.contractSignData.rem_amount === 0 && response.data.check_draft === 0) {
            this.buttonDisabled = true
            this.$toast.success({
              title: 'Success',
              message: 'Payment Completed!!!',
              color: '#D6E09B'
            })
          }
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    installmentInfo () {
      const installInfo = this.contractSignData.budgets.find(item => item.installment_id === parseInt(this.form.installment_id))
      this.form.cnt_sign_budget_detail_id = installInfo !== undefined ? installInfo.id : 0
      this.form.installment_amount = installInfo !== undefined ? installInfo.installment_amount : 0
      this.form.rem_install_amount = installInfo !== undefined ? installInfo.installment_amount - installInfo.rcv_amount : 0
      if (this.form.document_type_id === 2) {
        const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
        this.form.prepare_rfp_id = researchId.prepare_rfp_id
      }
      if (this.form.document_type_id === 3) {
        const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
        this.form.research_request_id = researchId.research_request_id
      }
    },
    totRcvOnChange (rcvAmount) {
      if (parseFloat(rcvAmount) > parseFloat(this.form.rem_install_amount)) {
        this.form.rcv_amount = parseFloat(this.form.rem_install_amount)
      }
      if (parseFloat(rcvAmount) < this.form.rem_install_amount) {
        this.form.rcv_amount = parseFloat(rcvAmount)
      }
    },
    vatOnChange () {
      const percentage = parseFloat(this.form.tax_vat) / 100
      const tax = parseFloat(this.form.rcv_amount) * percentage
      this.form.actual_rcv_amount = parseFloat(this.form.rcv_amount) - tax
    }
  }
}
</script>
