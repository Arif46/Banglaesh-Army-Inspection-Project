<template>
  <b-container fluid>
    <div class="inner-section">
      <Search @LOAD_DATA="getSearchData" :key="componentKey" :menuId="menuInfo.id"/>
      <b-row>
        <b-col md="12">
            <body-card>
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ checkBn ? menuInfo.grid_title_bn : menuInfo.grid_title_en }}</h4>
              </template>
              <template v-slot:headerAction>
                <router-link :to="`application-form`" :title="$t('externalLrcpn.apply_here')" size="sm">
                  <b-button variant="primary">
                    {{  $t('externalLrcpn.apply_here') }}
                  </b-button>
                </router-link>
              </template>
              <template v-slot:body>
                <b-overlay :show="listLoading">
                  <b-row>
                    <b-col md="12" class="table-responsive dataList">
                      <b-table :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :tbody-tr-class="rowClass">
                        <template v-slot:cell(index)="data">
                          {{ $n(data.index + 1) }}
                        </template>
                        <template v-slot:cell(org_id)="data">
                          {{ getStoreData('CommonService', 'orgProfileList', data.item.org_id) }}
                        </template>
                        <template v-slot:cell(service_id)="data">
                          {{ getStoreDataLrcpn('serviceNamesList', data.item.service_id) }}
                        </template>
                        <template v-slot:cell(status)="data">
                          <!-- data.item.status === 7 mean Application ReSubmit -->
                          <span v-if="data.item.status === 7">
                          <span> {{ $t('externalLrcpn.application_resubmit') }} </span>
                          </span>
                          <span v-else>
                          {{ getStepName(data.item.current_step) + ' ' + ServiceLastStepCheck(data.item.service_id, data.item.current_step, data.item.status) }}
                          </span>
                        </template>
                        <template v-slot:cell(type)="data">
                          <span class="badge pay-status badge-success w-100 text-white font-weight-bold" v-if="data.item.type === 2">
                            {{ $t('globalTrans.renew') }}
                          </span>
                          <span class="badge pay-status badge-primary w-100 text-white font-weight-bold" v-if="data.item.type === 1">
                            {{ $t('globalTrans.new') }}
                          </span>
                        </template>
                        <template v-slot:cell(expire_date)="data">
                          <span v-if="data.item.expire_date">
                            {{ data.item.expire_date | dateFormat }}
                          </span>
                        </template>
                        <template v-slot:cell(payment_status)="data">
                          <div v-if="parseInt(data.item.save_status) === 2">
                            <!-- <span v-if="servicePayment(data.item.service_id).application_fee" :class="data.item.type_pay_status ? `badge pay-status badge-success` : ` badge pay-status blink_me badge-warning`">{{ $t('externalLrcpn.application_fee') }}</span> -->
                            <span v-if="paymentCheck(data.item.service_id, data.item.current_step) && data.item.type === 1" :class="paymentStatus(data.item) ? `badge pay-status badge-success font-weight-bold w-100` : `blink_me badge pay-status badge-warning font-weight-bold w-100`">{{ $t('externalLrcpn.payments') }} {{ paymentStatus(data.item) ? $t('globalTrans.paid') : '' }}</span>
                            <span v-if="paymentCheck(data.item.service_id, data.item.current_step) && servicePayment(data.item.service_id).renew && data.item.type === 2" :class="data.item.renew_pay_status ? `badge pay-status badge-success font-weight-bold w-100` : `blink_me badge pay-status badge-warning font-weight-bold w-100`">{{ $t('externalLrcpn.renew_fee') }}</span>
                            <span v-if="checkLabPayment(data.item.service_id, data.item.current_step) && data.item.type === 1" :class="paymentStatus(data.item) ? `badge pay-status badge-success` : `blink_me badge pay-status badge-info font-weight-bold w-100 button-css`">{{ $t('externalLrcpn.payments') }} {{ paymentStatus(data.item) ? $t('globalTrans.paid') : '' }}</span>
                          </div>
                        </template>
                        <template v-slot:cell(action)="data">
                          <!-- Application edit -->  <!-- data.item.status === 7 mean Application ReSubmit -->
                          <span v-if="data.item.save_status === 1">
                            <router-link  :title="$t('globalTrans.edit')" :to="`/lrcpn-panel/application-form-edit?application_id=${data.item.application_id}&step_id=${data.item.current_step}&service_id=${data.item.service_id}&org_id=${data.item.org_id}`" class="btn btn-success btn-sm"><i class="ri-edit-box-line"></i></router-link>
                          </span>
                          <span v-else>
                            <span v-if="data.item.status === 7">
                              <router-link  :title="$t('globalTrans.edit')" :to="`/lrcpn-panel/application-form-resubmit?application_id=${data.item.application_id}&step_id=${data.item.current_step}&service_id=${data.item.service_id}&org_id=${data.item.org_id}`" class="btn btn-success btn-sm"><i class="ri-edit-box-line"></i></router-link>
                            </span>
                            <span v-else>
                              <!-- Application View (Details) -->
                              <router-link :to="`/lrcpn-panel/application-form-view?application_id=${data.item.application_id}&step_id=${data.item.current_step}&service_id=${data.item.service_id}&org_id=${data.item.org_id}`" :title="$t('globalTrans.details')" class="btn btn-secondary m-1 btn-sm"><i class="ri-eye-line"></i></router-link>
                              <!-- payment receipt-->
                              <b-button v-if="paymentReceiptStatus(data.item) > 0 || data.item.renew_pay_status === 1" class="btn btn-warning m-1 btn-sm" :title="$t('externalLrcpn.payment_receipt')" v-b-modal.modal-payment-receipt @click="setupReceipt(data.item)"><i class="fas fa-receipt"></i></b-button>
                              <!-- All Payment -->
                              <b-button v-if="paymentCheck(data.item.service_id, data.item.current_step) && paymentStatus(data.item) === 0 && data.item.type === 1" class="btn btn-warning m-1 btn-sm" title="Service Step Payment" v-b-modal.modal-payment style="padding:4px 3px !important" @click="paymentData(data.item)">{{ $t('externalLrcpn.pay') }}</b-button>
                              <!-- renew payment -->
                              <b-button v-if="paymentCheck(data.item.service_id, data.item.current_step) && servicePayment(data.item.service_id).renew && data.item.renew_pay_status === 0 && data.item.type === 2" class="btn btn-warning m-1 btn-sm" :title="$t('externalLrcpn.renew_payment')" v-b-modal.modal-payment-renew @click="setupPayment(data.item)" style="padding:4px 3px !important">{{ $t('globalTrans.pay') }}</b-button>
                              <!-- lab payment -->
                              <b-button v-if="checkLabPayment(data.item.service_id, data.item.current_step) && paymentStatus(data.item) === 0 && data.item.type === 1" class="btn btn-warning m-1 btn-sm" title="Service Step Payment" v-b-modal.modal-payment style="padding:4px 3px !important" @click="paymentData(data.item)">{{ $t('externalLrcpn.pay') }}</b-button>
                              <!-- lost payment -->
                              <!-- <b-button v-if="servicePayment(data.item.service_id).lost && data.item.lost_pay_status === 0 && data.item.status === 1" class="btn btn-warning m-1 btn-sm" :title="$t('externalLrcpn.lost_payment')" v-b-modal.modal-payment-lost @click="setupPayment(data.item)" style="padding:4px 3px !important">{{ $t('globalTrans.pay') }}</b-button> -->
                              <!-- Renew -->
                              <router-link v-if="(servicePayment(data.item.service_id).renew && expiredDateCheck(data.item.expire_date) && data.item.type === 1 && data.item.type !== 3)" :to="`/lrcpn-panel/application-form-edit?application_id=${data.item.application_id}&step_id=${data.item.current_step}&service_id=${data.item.service_id}&org_id=${data.item.org_id}&type=2`" class="btn btn-success m-1 btn-sm" :title="$t('globalTrans.renew')"><i class="ri-restart-line"></i></router-link>
                              <!-- Document View -->
                              <router-link v-if="data.item.generate_id && data.item.attachment === null" :to="`/lrcpn-panel/document-view?application_id=${data.item.application_id}&step_id=${data.item.current_step}&service_id=${data.item.service_id}`" class="btn btn-success m-1 btn-sm" :title="$t('externalLrcpn.document_view')"><i class="ri-file-line"></i></router-link>
                              <!-- Publish Document -->
                              <a class="btn btn-success m-1 btn-sm" target = '_blank'  :href="licenseRegistrationServiceBaseUrl + 'uploads/lrcpn/' + data.item.attachment" download v-if="data.item.attachment !== null" :title="$t('globalTrans.doc_download')"><i class="fa fa-download" aria-hidden="true"></i></a>
                              <!-- Approve Amount Show In Modal For "Bor Hybrid -> Static" -->
                              <b-button v-if="data.item.org_id === 1 && data.item.service_id === 22 && data.item.status === 1" class="btn btn-success m-1 btn-sm" :title="$t('boro_import.meeting_resulation')" v-b-modal.approve-amount-show @click="approveAmountSHow(data.item)">{{ $t('boro_import.approved_amount_to_import') }}</b-button>
                            </span>
                          </span>
                        </template>
                      </b-table>
                      <b-pagination
                        v-model="pagination.currentPage"
                        :per-page="pagination.perPage"
                        :total-rows="pagination.totalRows"
                        @input="searchData"
                        />
                    </b-col>
                  </b-row>
                </b-overlay>
              </template>
            </body-card>
        </b-col>
      </b-row>
    </div>
    <b-modal id="approve-amount-show" size="lg" :title="$t('globalTrans.details')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <b-button @click="pdfExport" class="ml-4 btn-success water-test-pdf-button">
        {{  $t('globalTrans.export_pdf') }}
      </b-button>
      <ApproveAmount :approveAmount="approveAmount" ref="approveAmount"/>
    </b-modal>
    <b-modal id="modal-payment-receipt" size="lg" :title="$t('externalLrcpn.payment_receipt')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <PaymentReceipt :payment="payReceipt" />
    </b-modal>
    <b-modal id="modal-payment" size="lg" :title="$t('globalTrans.payment')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <PaymentAll :payment="payment" />
    </b-modal>
    <b-modal id="modal-payment-renew" size="lg" :title="$t('externalLrcpn.renew_payment')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <RenewPayment :payment="otherPayment" />
    </b-modal>
    <b-modal id="modal-payment-lab" size="lg" :title="$t('step_assign.lab_fee')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <LabPayment :payment="payment" />
    </b-modal>
    <b-modal id="modal-payment-lost" size="md" :title="$t('externalLrcpn.lost_payment')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <LostPayment :payment="otherPayment" />
    </b-modal>
    <b-modal id="modal-reject" size="md" :title="$t('globalTrans.note')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Reject :item="notes"/>
    </b-modal>
  </b-container>
</template>
<script>
import Search from './components/search'
import PaymentAll from './PaymentAll'
import RenewPayment from './PaymentRenew'
import LabPayment from './LabPayment'
import PaymentReceipt from './PaymentReceipt'
import LostPayment from './LostPayment'
import Reject from './Reject'
import ApproveAmount from './ApproveAmount'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { applicationList, userEntryForm } from './../../api/routes'
import routeBaseMasterList from '@/mixins/list'
import common from '@/mixins/common-lrcpn'
import payment from '@/mixins/payment'

export default {
  mixins: [routeBaseMasterList, common, payment],
  components: {
    Search,
    PaymentAll,
    PaymentReceipt,
    RenewPayment,
    LostPayment,
    Reject,
    LabPayment,
    ApproveAmount
  },
  data () {
    return {
      componentKey: 0,
      step_id: 0,
      listLoading: false,
      stepChange: {
        application_id: 0,
        step_id: 0,
        service_id: 0,
        org_id: 0
      },
      search: {},
      columns: [],
      allData: {},
      payment: {},
      otherPayment: {},
      notes: {},
      form: [],
      payReceipt: {},
      gridLangData: '',
      gridData: false,
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      approveAmount: {}
    }
  },
  created () {
    this.setCommonGrid()
    this.loadData()
    this.paymentStatusUpdate()
  },
  computed: {
    formTitle () {
      return (this.editItemId === 0) ? this.$t('step_name.step_name_entry') : this.$t('step_name.step_name') + ' ' + this.$t('globalTrans.modify')
    },
    menuInfo () {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.menuWiseStepList.find(menu => menu.public_menu === 'application')
    },
    listLoad () {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.listLoad
    },
    local: function () {
        return this.$i18n.locale
    }
  },
  watch: {
    listLoad: function (newVal, oldValue) {
      if (newVal !== oldValue) {
        this.loadData()
      }
    },
    local: function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.getLanguageWiseData()
          this.componentKey = this.componentKey + 1
      }
    }
  },
  methods: {
    rowClass (item, type) {
        if (!item || type !== 'row') return
        if (item.status === 7) return 'table-danger'
    },
    paymentStatus (data) {
      return data.payment.filter(item => item.step_id === data.current_step).length
    },
    paymentReceiptStatus (data) {
      return data.payment.length
    },
    getLanguageWiseData () {
      this.setCommonGrid()
      if (this.gridData === true) {
        this.setGridData(this.gridLangData)
      }
    },
    getStepName (stId) {
      const step = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepNamesList.find(item => item.value === stId)
      return step.text
    },
    servicePayment (serId) {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.find(item => item.value === parseInt(serId))
    },
    expiredDateCheck (expiredDate) {
      if (expiredDate === null) {
        return false
      }
      const currentDate = this.currentDate()
      const noOfDay = this.getNumberOfDays(currentDate, expiredDate)
      if (noOfDay > 31) {
        return false
      } else {
        return true
      }
    },
    currentDate () {
      const current = new Date()
      const date = `${current.getFullYear()}-${current.getMonth() + 1}-${current.getDate()}`
      return date
    },
    getNumberOfDays (start, end) {
      const date1 = new Date(start)
      const date2 = new Date(end)

      // One day in milliseconds
      const oneDay = 1000 * 60 * 60 * 24

      // Calculating the time difference between two dates
      const diffInTime = date2.getTime() - date1.getTime()

      // Calculating the no. of days between two dates
      const diffInDays = Math.round(diffInTime / oneDay)
      return diffInDays
    },
    paymentCheck (serviceId, currentStep) {
      const steps = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepFeeList.find(item => item.service_id === serviceId && item.step_id === currentStep && item.fee_id !== 0)
      const stepFee = typeof steps !== 'undefined' ? steps : { fee_id: '' }
      const otherPay = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => item.step_id === currentStep && item.service_id === serviceId)
      const otherFee = typeof otherPay !== 'undefined' ? otherPay : { checkbox_payment: false, field_payment: false }
      if (stepFee.fee_id || (otherFee.checkbox_payment.length > 1) || (otherFee.field_payment.length > 1)) {
        return true
      } else {
        return false
      }
    },
    checkLabPayment (serviceId, currentStep) {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => item.step_id === currentStep && item.service_id === serviceId && item.lab_fee === 1)
        return typeof tmp === 'undefined' ? 0 : 1
    },
    searchData () {
      this.loadData()
    },
    loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage, step_id: this.step_id, service_ids: [], user_id: this.$store.state.Auth.authUser.user_id })
      this.listLoading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, applicationList, params).then(response => {
        if (response.success) {
          this.$store.dispatch('setList', response.data.data)
          this.paginationData(response.data)
        }
        this.listLoading = false
      })
    },
    getSearchData (res) {
      this.loadFrom(res.service_id)
      this.step_id = res.step_id
      if (res.type === 2) {
        this.allData = res.data
        this.search = res.searchData
        if (res.data.success) {
          const dynamicGrid = res.data.grid_field.map(item => {
            const tmpData = JSON.parse(item.data)
            return { text_en: tmpData.label, text_bn: tmpData.label_bn, value: tmpData.field_name, langType: typeof tmpData.lang_type !== 'undefined' ? tmpData.lang_type : '' }
          })
          if (res.data.grid_field.length) {
            this.gridLangData = dynamicGrid
            this.gridData = true
            this.setGridData(dynamicGrid)
          } else {
            this.setCommonGrid()
          }
        } else {
          this.setCommonGrid()
        }
      } else {
        this.search = res.data
      }
      this.loadData()
    },
    setGridData (data) {
      const newArray = data.map(item => {
        if ((this.local === 'en' && item.langType === 'en') || (this.local === 'en' && item.langType === '')) {
          return { label: item.text_en, label_en: item.text_en, class: 'text-left', key: item.value }
        } else if ((this.local === 'bn' && item.langType === 'bn') || (this.local === 'bn' && item.langType === '')) {
          return { label: item.text_bn, label_en: item.text_bn, class: 'text-left', key: item.value }
        }
      })
      this.columns = newArray
      this.setSlAction()
    },
    setCommonGrid () {
      this.columns = [
          { label: this.$t('globalTrans.org_name'), class: 'text-left', key: 'org_id' },
          { label: this.$t('service_name.service_name'), class: 'text-left', key: 'service_id' }
        ]
      this.setSlAction()
    },
    setSlAction () {
      this.columns = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-left', key: 'index' },
          { label: this.$t('externalLrcpn.app_id'), class: 'text-left', key: 'application_id' }
        ].concat(this.columns)
      this.columns.push({ label: this.$t('externalLrcpn.type'), class: 'text-left', key: 'type' })
      this.columns.push({ label: this.$t('externalLrcpn.expired_date'), class: 'text-left', key: 'expire_date' })
      this.columns.push({ label: this.$t('globalTrans.status'), class: 'text-left', key: 'status' })
      this.columns.push({ label: this.$t('externalLrcpn.pay_status'), class: 'text-left', key: 'payment_status' })
      this.columns.push({ label: this.$t('globalTrans.action'), class: 'text-left', key: 'action' })
    },
    setupReceipt (data) {
      this.payReceipt =
      {
        application_id: data.application_id,
        service_id: data.service_id
      }
    },
    setupPayment (data) {
      this.otherPayment =
      {
        org_id: data.org_id,
        application_id: data.application_id,
        step_id: data.current_step,
        service_id: data.service_id,
        application_type: data.type,
        expire_date: data.old_expire_date
      }
    },
    approveAmountSHow (data) {
      this.approveAmount =
      {
        application_id: data.application_id,
        step_id: data.current_step,
        service_id: data.service_id
      }
    },
    paymentData (data) {
      this.payment = Object.assign(this.payment,
      {
        org_id: data.org_id,
        application_id: data.application_id,
        step_id: data.current_step,
        service_id: data.service_id,
        application_type: data.type,
        expire_date: data.old_expire_date
      })
    },
    // findRenewExpireDate () {
    //   let expireDate = ''
    //   if (oldAppId) {
    //     const app = this.$store.state.list.find(item => item.application_id === oldAppId)
    //     expireDate = (typeof app === 'undefined') ? '' : app.expire_date
    //   }
    //   return expireDate
    // },
    rejectList (item) {
      this.notes = item
    },
    async paymentStatusUpdate () {
      if (this.$route.params.status && this.$route.query.transId) {
        const status = this.$route.params.status
        const tranId = this.$route.query.transId
        this.$bvModal.show('modal-processing')
        await RestApi.getData(licenseRegistrationServiceBaseUrl, '/application/payment/' + status, { transId: tranId }).then(response => {
          this.$bvModal.hide('modal-processing')
          if (response.success) {
            this.$toast.success({
              title: 'Success',
              message: response.message,
              color: '#D6E09B'
            })
          } else {
            this.$toast.error({
              title: 'Error',
              message: response.message
            })
          }
        })
        this.$router.push('/lrcpn/application')
        this.$store.dispatch('ExternalLrcpn/setLaodList', true)
      }
    },
    loadFrom (serviceId) {
      const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      const formId = formData.form_id
      const params = {
        id: formId
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, userEntryForm, params).then(response => {
        if (response.success) {
          this.form = JSON.parse(JSON.stringify(response.data)).tabs
        } else {
          this.form = []
        }
      })
    },
    ServiceLastStepCheck (serviceId, stepId, status) {
      const tmpStepList = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
      const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(stepId))
      const order = tmpIndVStepList.order
      const orderCheck = tmpStepList.find(item => item.order === order + 1)
      if (status === 0) {
        return this.$t('globalTrans.processing')
      } else if (status === 2) {
        return this.$t('globalTrans.rejected')
      } else if (typeof orderCheck !== 'undefined') {
        return this.$t('globalTrans.pending')
      } else {
        return this.$t('globalTrans.completed')
      }
    },
    pdfExport () {
      this.$refs.approveAmount.pdfExport()
    }
  }
}
</script>
<style scope='css'>
  .dataList .btn {
    font-size: 11px !important;
    padding: 3px 8px !important;
  }
  .dataList .btn i {
      margin-right: 0px !important;
  }
  .dataList .pay-status {
    color: black !important;
    padding: 4px !important;
    margin: 2px !important;
    font-size: 10px !important;
  }
  .blink_me {
    animation: blinker 1.3s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      background-color: green;
    }
  }
  .button-css {
    font-size: 150%;
  }
</style>
