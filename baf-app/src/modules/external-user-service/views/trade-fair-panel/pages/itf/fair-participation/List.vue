<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('externalTradeFair.fair_participation_payment') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{ $t('globalTrans.fiscal_year') }}
              </template>
              <b-form-select
                plain
                id="fiscal_year_id"
                :options="fiscalYearList"
                v-model="search.fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
                label-for="fair_name"
              >
                <template v-slot:label>
                  {{ $t('externalTradeFair.fair_name') }}
                </template>
              <b-form-select
                plain
                id="fair_name"
                :options="fairNameList"
                v-model="search.fair_name_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('externalTradeFair.fair_participation_payment') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span v-if="data.item.flag == 1" class="badge badge-danger">{{ $t('globalTrans.draft') }}</span>
                    <span v-else>
                      <span class="badge badge-info" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                      <span class="badge badge-success" v-if="data.item.status == 2">{{$t('globalTrans.approved')}}</span>
                      <span class="badge badge-danger" v-if="data.item.status == 3">{{$t('globalTrans.rejected')}}</span>
                      <span class="badge badge-warning" v-if="data.item.status == 4">{{$t('globalTrans.returned')}}</span>
                      <span class="badge badge-info" v-if="data.item.status == 5">{{$t('globalTrans.resubmit')}}</span>
                    </span>
                  </template>
                  <template v-slot:cell(pay_status)="data">
                    <span class="badge badge-success" v-if="data.item.pay_status == 1">{{$t('globalTrans.paid')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.pay_status == 2">{{$t('globalTrans.refund')}}</span>
                    <span class="badge badge-warning blink_me" v-else>{{$t('globalTrans.unpaid')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant=" iq-bg-primary" size="sm" @click="detailsData(data.item)" class="action-btn edit mr-1" :title="$t('globalTrans.view')"><i class="ri-eye-line"></i></b-button>
                    <b-button v-if="data.item.flag === 1 || data.item.status == 4" variant=" iq-bg-success" size="sm" @click="editData(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="data.item.flag === 2 && data.item.pay_status === 0" v-b-modal.modal-payment @click="payment(data.item)" variant=" iq-bg-success" size="sm" class="action-btn edit" :title="$t('globalTrans.payment')"><i class="ri-secure-payment-line"></i></b-button>
                    <b-button v-if="data.item.flag === 2 && data.item.pay_status !== 0" v-b-modal.modal-payment-details @click="paymentDetails(data.item)" variant=" iq-bg-success" size="sm" class="action-btn edit" :title="$t('globalTrans.payment') + ' ' + $t('globalTrans.receipt')"><i class="ri-booklet-line"></i></b-button>
                    <b-button v-if="data.item.status == 2 && data.item.is_visa_ready == 0" @click="updateVisa()" variant="iq-bg-info" size="sm" class="action-btn edit blink_me" :title="$t('externalTradeFair.update_visa')"><i class="ri-visa-line"></i></b-button>
                  </template>
                </b-table>
              </slot>
              <div class="pagination-wrapper mt-3" v-if="columns.filter(item => item.show === '1').length > 0">
                <b-pagination
                  v-model="pagination.currentPage"
                  :perPage="search.limit"
                  :total-rows="pagination.totalRows"
                  @input="searchData"
                />
               </div>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.fair_participation_payment') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" :items="itemData" ref="details"/>
    </b-modal>
    <b-modal id="modal-payment" size="lg" :title="$t('globalTrans.payment') + ' ' + $t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Payment :id="detailsItemId"/>
    </b-modal>
    <b-modal id="modal-payment-details" size="lg" :title="$t('globalTrans.payment') + ' ' + $t('globalTrans.receipt')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.fair_participation_payment') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExportPayment" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <PaymentDetails :id="payDetailsItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details'
import Payment from './payment/PaymentModal'
import PaymentDetails from './payment/PaymentDetailsModal'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartListApi, paymentUpdateStatusApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Payment, PaymentDetails
  },
  data () {
    return {
      sortBy: '',
      detailsItemId: 0,
      payDetailsItemId: 0,
      itemData: [],
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        limit: 20
      },
      allDesignationList: [],
      fairNameList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'externalTradeFair.fair_name', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'externalTradeFair.comp_name', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'externalTradeFair.participation_id', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.payment_status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 8 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
    this.loadData()
    this.paymentStatusUpdate()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (this.search.fiscal_year_id) {
        this.fairNameList = this.getFairNameList()
      }
    }
  },
  computed: {
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_bn' },
          { key: 'fair_name_bn' },
          { key: 'name_bn' },
          { key: 'app_auto_id' },
          { key: 'status' },
          { key: 'pay_status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'fair_name_en' },
          { key: 'name_en' },
          { key: 'app_auto_id' },
          { key: 'status' },
          { key: 'pay_status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    }
  },
  methods: {
    getFairNameList () {
      return this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    payment (item) {
      this.detailsItemId = item.id
    },
    paymentDetails (item) {
      this.payDetailsItemId = item.id
    },
    updateVisa () {
      this.$router.push('/trade-fair-panel/visa-processing-info-list')
    },
    editData (item) {
      this.$router.push(`/trade-fair-panel/fair-participation-form?id=${item.id}`)
    },
    detailsData (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    async paymentStatusUpdate () {
      if (this.$route.params.status && this.$route.query.transId) {
        const status = this.$route.params.status
        const tranId = this.$route.query.transId
        await RestApi.getData(internationalTradeFairServiceBaseUrl, paymentUpdateStatusApi + status, { transId: tranId }).then(response => {
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
          this.loadData()
          this.$router.push('/trade-fair-panel/fair-participation')
        })
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairPartListApi, params)
      if (result.success) {
        const listData = this.getRelationalData(result.data.data)
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
        const listData = data.map((item, index) => {
            const tmpFiscal = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fair_circular.fiscal_year_id))
            const tmpFair = this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.find(obj => obj.value === parseInt(item.fair_circular.fair_name_id))
            const customItem = {
              fiscal_year_en: tmpFiscal !== undefined ? tmpFiscal.text_en : '',
              fiscal_year_bn: tmpFiscal !== undefined ? tmpFiscal.text_bn : '',
              fair_name_en: tmpFair !== undefined ? tmpFair.text_en : '',
              fair_name_bn: tmpFair !== undefined ? tmpFair.text_bn : ''
            }
            return Object.assign({}, item, { serial: index }, customItem)
        })
        return listData
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    },
    pdfExportPayment () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style scoped>
  .modal-title {
    flex-grow: 1 !important;
  }
  .blink_me {
    animation: blinker 2.5s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      /* background-color: green; */
    }
  }
</style>
