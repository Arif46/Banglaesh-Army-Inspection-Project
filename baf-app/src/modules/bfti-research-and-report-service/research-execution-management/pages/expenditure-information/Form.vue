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
                  <ValidationProvider name="Remaining Amount" vid="rcv_amount">
                    <b-form-group
                      label-for="rcv_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rcv_amount') }}
                      </template>
                      <b-form-input
                        id="rcv_amount"
                        v-model="contractSignData.rcv_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remaining Amount" vid="rem_amount">
                    <b-form-group
                      label-for="rem_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.rem_rcv_amount') }}
                      </template>
                      <b-form-input
                        id="rem_amount"
                        v-model="contractSignData.rem_amount"
                        disabled
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Remaining Amount" vid="rem_amount">
                    <b-form-group
                      label-for="rem_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.current_amount') }}
                      </template>
                      <b-form-input
                        id="rem_amount"
                        v-model="contractSignData.usable_amount"
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
              <h5 class="card-title"> {{ $t('research_execution.expenditure_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Expenditure Head" vid="expenditure_head_id">
                    <b-form-group
                    class="row"
                      label-for="expenditure_head_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('research_execution.expenditure_head')}} <span class="text-danger" v-if="!closeButtonStatus">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="expense_details.expenditure_head_id"
                      :options="expenditureHeadList"
                      id="expenditure_head_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="closeButtonStatus"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <p class="text-danger" style="font-size: 10px"> {{ headErrorShow + ' ' + alreadyAddedMsg }} </p>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Installment Amount" vid="expense_amount" v-slot="{ errors }">
                    <b-form-group
                    class="row"
                      label-for="expense_amount">
                      <template v-slot:label>
                        {{ $t('research_execution.expense_amount') }} <span class="text-danger" v-if="!closeButtonStatus">*</span>
                      </template>
                      <b-form-input
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        @keyup="AmountCalculated(expense_details.expense_amount)"
                        id="expense_amount"
                        v-model="expense_details.expense_amount"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :disabled="buttonDisabled || closeButtonStatus"
                      ></b-form-input>
                      <p class="text-danger" style="font-size: 10px"> {{ amountErrorShow }} </p>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <div class="w-100 h-100 d-grid">
                    <span class="m-auto">
                    <b-button v-if="locationIndex !== ''" variant="danger" class="mr-1 btn-xs" @click="cancelLocation()">{{ $t('globalTrans.cancel') }}</b-button>
                    <b-button variant="success" class="m-auto btn-sm" @click="addItem()" :disabled="buttonDisabled || closeButtonStatus">{{ locationIndex !== '' ? $t('globalTrans.update') : $t('globalTrans.add')}}</b-button></span>
                  </div>
                </b-col>
              </b-row>
              <hr>
              <b-row>
                <b-col xl="12" lg="8" sm="8">
                  <b-table-simple bordered>
                    <thead class="text-white bg-primary">
                      <tr>
                        <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                        <th scope="col">{{ $t('research_execution.expenditure_head') }}</th>
                        <th scope="col">{{ $t('research_execution.expense_amount') }}</th>
                        <th class="text-center">{{ $t('globalTrans.action') }}</th>
                      </tr>
                    </thead>
                    <b-tbody>
                      <b-tr v-for="(item, index) in budget" :key="index">
                        <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                        <b-td> {{ getExpenditureHeadName(item.expenditure_head_id) }} </b-td>
                        <b-td> {{ $n(item.expense_amount, { useGrouping: false }) }} </b-td>
                        <b-td class="text-center">
                          <span class="d-flex text-center">
                            <b-button @click="editLocation(item, index)" title="Location Edit" class="btn btn-success btn-sm mr-1"><i class="ri-ball-pen-fill m-0"></i></b-button>
                            <b-button type="button" @click="deleteItem(index)" class="m-auto btn-sm" variant="danger"><i class="ri-close-fill p-0 m-0"></i></b-button>
                          </span>
                        </b-td>
                      </b-tr>
                      <!-- <b-tr v-if="nodata">
                          <td colspan="7" class="text-center">
                              <span class="text-black">{{ (currentLocale === 'bn') ? 'কোন তথ্য পাওয়া যায়নি!' : 'No Data Found' }}</span>
                          </td>
                      </b-tr> -->
                    </b-tbody>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:body>
              <b-row>
                 <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Receive Date" vid="expense_date" :rules="expenseDate" v-slot="{ errors }">
                    <b-form-group
                      label-for="expense_date">
                      <template v-slot:label>
                        {{ $t('research_execution.expense_date') }} <span class="text-danger" v-if="!closeButtonStatus">*</span>
                      </template>
                      <date-picker
                        id="expense_date"
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        v-model="form.expense_date"
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
              </b-row>
            </template>
          </body-card>
          <b-row>
            <b-col xs="12" sm="12" md="7">
              <ValidationProvider name="no_rem_rcv_msg" v-if="contractSignData.rem_amount === 0">
                  <b-form-group
                    label-for="no_rem_rcv_msg">
                    <b-form-checkbox
                    id="no_rem_rcv_msg"
                    v-model="no_rem_rcv_msg"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <p style="color:red;padding-top: 2px;">{{ $t('research_execution.no_rem_rcv_msg') }}</p>
                  </b-form-checkbox>
                  </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="5">
              <b-button v-if="closeButtonStatus" type="submit" @click="form.status = 3" variant="primary" style="margin-right:2px">{{$t('research_execution.closeExpenditure')}}</b-button>
              <b-button v-if="!closeButtonStatus" type="submit" @click="form.status = 2 " variant="primary" style="margin-right:1px" :disabled="buttonDisabled">{{$t('configuration.final_save')}}</b-button>
              <b-button v-if="!closeButtonStatus" type="submit" @click="form.status = 1 " variant="warning" style="margin-right:1px" :disabled="buttonDisabled">{{$t('configuration.save_draft')}}</b-button>
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
import { expenditureInfoStoreApi, contractSigningApi, contractSignedLists, expenditureCloseApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      no_rem_rcv_msg: false,
      closeButtonStatus: false,
      headErrorShow: '',
      amountErrorShow: '',
      alreadyAddedMsg: '',
      titleLoad: false,
      buttonDisabled: false,
      budget: [],
      locationIndex: '',
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        id: '',
        document_type_id: 0,
        contract_sign_id: 0,
        duration: '',
        user_id: this.$store.state.Auth.authUser.user_id,
        tot_expense_amount: 0,
        research_request_id: null,
        prepare_rfp_id: null
      },
      expense_details: {
        expenditure_head_id: 0,
        expense_amount: ''
      },
      RFPResearchList: [],
      researchRequestData: {},
      contractSignData: {}
    }
  },
  created () {
    if (this.item) {
      this.form = this.item
      this.contractSigningData()
      this.budget = this.item.expense_details
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
    no_rem_rcv_msg: function (newVal, oldVal) {
      this.headErrorShow = ''
      this.amountErrorShow = ''
      this.alreadyAddedMsg = ''
      this.no_rem_rcv_msg === true ? this.closeButtonStatus = true : this.closeButtonStatus = false
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
    },
    expenditureHeadList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.expenditureHeadList.filter(item => item.status === 1)
    },
    expenseDate: function () {
      return this.closeButtonStatus ? '' : 'required'
    }
  },
  methods: {
    closeButtonMethod () {
      this.closeButtonStatus = true
    },
    AmountCalculated (amount) {
      const totUsableAmount = parseInt(this.contractSignData.usable_amount)
      if (this.budget) {
        let expenseAmount = 0

        this.budget.map((item, index) => {
          if (this.locationIndex !== index) {
            expenseAmount += parseInt(item.expense_amount)
          }
        })

        const individualInstallmentAmount = parseInt(this.expense_details.expense_amount)
        const totIndvInstallmentAmount = expenseAmount + individualInstallmentAmount
        if (totIndvInstallmentAmount > totUsableAmount) {
          this.expense_details.expense_amount = 0
        }
        if (totIndvInstallmentAmount < totUsableAmount) {
          this.expense_details.expense_amount = amount
        }
      }
    },
    titleTopicList () {
      this.titleLoad = true
      const params = Object.assign({}, { document_type_id: this.form.document_type_id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignedLists, params).then(response => {
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
        this.contractSignData = {}
        this.titleLoad = false
      })
    },
    saveUpdate () {
      if (this.form.status === 3) {
        this.closeExpenditure()
      } else {
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
      }
    },
    async Approval () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const params = Object.assign({}, { form: this.form, budget: this.budget })
      result = await RestApi.postData(bftiResReportServiceBaseUrl, expenditureInfoStoreApi, params)

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
    async closeExpenditure () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const closeData = {
        contract_sign_id: this.form.contract_sign_id,
        document_type_id: this.contractSignData.document_type_id,
        prepare_eoi_id: this.contractSignData.prepare_eoi_id,
        prepare_rfp_id: this.contractSignData.prepare_rfp_id,
        policy_request_id: this.contractSignData.policy_request_id,
        research_request_id: this.contractSignData.research_request_id,
        contract_amount: this.contractSignData.contract_amount,
        received_amount: this.contractSignData.rcv_amount,
        rem_rcv_amount: this.contractSignData.rem_amount,
        usable_amount: this.contractSignData.usable_amount
      }
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, expenditureCloseApi, closeData)

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
      const params = Object.assign({}, { document_type_id: this.form.document_type_id, contract_sign_id: this.form.contract_sign_id, research_request_id: this.form.research_request_id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSigningApi, params).then(response => {
        if (response.success) {
          this.contractSignData = response.data
          this.contractSignData.client = this.$i18n.locale === 'en' ? this.contractSignData.organization_ministry_division : this.contractSignData.organization_ministry_division_bn

          if (this.contractSignData.prepare_rfp) {
            this.contractSignData.duration = this.contractSignData.prepare_rfp !== undefined ? this.contractSignData.prepare_rfp.duration : ''
          }
          if (this.contractSignData.research) {
            this.contractSignData.duration = this.contractSignData.research !== undefined ? this.contractSignData.research.duration : ''
          }

          if (response.data.rcv_amount_status === 1) {
            this.buttonDisabled = true
            this.$toast.success({
              title: 'Success',
              message: 'Payment not Received!!!',
              color: '#D6E09B'
            })
          }

          if (this.contractSignData.usable_amount === 0 && response.data.rcv_amount_status === 0) {
            this.$toast.success({
              title: 'Success',
              message: this.$t('research_execution.usable_amount_not_available'),
              color: '#D6E09B'
            })
            this.buttonDisabled = true
          }
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    getExpenditureHeadName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.expenditureHeadList.find(head => head.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    cancelLocation () {
      this.expense_details = {}
      this.locationIndex = ''
      this.$refs.form.reset()
    },
    editLocation (item, index) {
      this.expense_details = Object.assign({}, item)
      this.locationIndex = index
    },
    deleteItem (index) {
      this.budget.splice(index, 1)
      if (this.budget.length === 0) {
        this.nodata = true
      }
      if (this.nodata === true) {
        this.expenditureHeadList = this.expenditureHeadList()
      }
    },
    async addItem () {
      if (this.expense_details.expenditure_head_id && this.expense_details.expense_amount > 0) {
        this.amountErrorShow = ''
        this.headErrorShow = ''
        this.alreadyAddedMsg = ''
        const checkExitingHead = this.budget.find(headItem => headItem.expenditure_head_id === this.expense_details.expenditure_head_id)

        if (typeof checkExitingHead === 'undefined' || this.locationIndex !== '') {
          this.validated = 1
          const d = this.expense_details.expenditure_head_id
          let result = []
          if (this.locationIndex !== '') {
              const editList = [...this.budget]
              editList.splice(parseInt(this.locationIndex), 1)
              result = [...editList]
          } else {
              result = this.budget
          }

          const newData = result.find(item => item.expenditure_head_id === d)
          if (typeof newData === 'undefined') {
              if (this.locationIndex !== '') {
                this.budget[parseInt(this.locationIndex)] = this.expense_details
              } else {
                this.budget.push(JSON.parse(JSON.stringify(this.expense_details)))
              }

              this.expense_details = {}
              this.locationIndex = ''
          } else {
                if (this.locationIndex !== '') {
                  this.budget[parseInt(this.locationIndex)] = this.expense_details
              } else {
                  this.budget.push(JSON.parse(JSON.stringify(this.expense_details)))
              }

              this.expense_details = {}
              this.locationIndex = ''
          }
          this.nodata = false
          if (this.nodata === false) {
            this.expenditureHeadList = this.$store.state.BftiResearchAndReportService.commonObj.expenditureHeadList.filter(item => item.value === d)
            this.expense_details.expenditure_head_id = d
          } else {
              this.expenditureHeadList = this.expenditureHeadList()
          }
          this.expense_details = {
            expenditure_head_id: 0,
            expense_amount: ''
          }
          this.$refs.form.reset()
          if (this.form.document_type_id === 2) {
            const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
            this.form.prepare_rfp_id = researchId.prepare_rfp_id
          }
          if (this.form.document_type_id === 3) {
            const researchId = this.RFPResearchList.find(item => item.value === this.form.contract_sign_id)
            this.form.research_request_id = researchId.research_request_id
          }
        } else {
          this.alreadyAddedMsg = 'Already Added!!!'
        }
      } else {
        this.alreadyAddedMsg = ''
        this.amountErrorShow = this.expense_details.expense_amount ? ' ' : 'Required'
        this.headErrorShow = this.expense_details.expenditure_head_id > 0 ? '' : 'Required'
      }
    }

  }
}
</script>
