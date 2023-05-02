<template>
  <div class="inner-section">
    <card>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('dealer.allocation') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial +1) }}
                  </template>
                  <template v-slot:cell(allocation_letter_id)="data">
                    {{ $n(data.item.allocation_letter_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(letter_date)="data">
                    {{ data.item.letter_date | dateFormat }}
                  </template>
                  <template v-slot:cell(ado_no)="data">
                    <span v-if="data.item.status > 2 && data.item.status !== 4">{{ $n(data.item.do_no) }}</span>
                    <span v-else> {{ '' }}</span>
                  </template>
                  <template v-slot:cell(total_price)="data">
                    {{ $n(data.item.total_price, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(payable_amount)="data">
                    {{ $n(data.item.selling_amount + data.item.tax_amount, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-success" v-if="data.item.status == 2">{{$t('globalTrans.paid')}}</span>
                    <span class="badge badge-warning" v-if="data.item.status == 3">{{$t('dealer.assigned_warehouse')}}</span>
                    <span class="badge badge-danger" v-if="data.item.status == 4">{{$t('dealer.cancelled')}}</span>
                    <span class="badge badge-success" v-if="data.item.status == 5">{{$t('dealer.recieved')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="data.item.status === 1" @click="editMethodInParent(data.item,3)" class="action-btn active view mx-2" v-b-modal.details> <i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status > 2 && data.item.status !== 4" @click="editMethodInParent(data.item,3)" class="action-btn active view mx-2" v-b-modal.doLetter> <i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status === 1" @click="editMethodInParent(data.item, 2)" v-b-modal.payment class="btn-sm" variant="warning">{{ $t('dealer.pay') }}</b-button>&nbsp;
                    <b-button v-if="data.item.status !== 1" @click="editMethodInParent(data.item, 2)" v-b-modal.receipt class="btn-sm" variant="primary">{{ $t('dealer.receipt') }}</b-button>&nbsp;
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
    <b-modal id="payment" size="lg" :title="$t('dealer.payment')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Payment :application="editItem" />
    </b-modal>
    <b-modal id="receipt" size="lg" :title="$t('dealer.receipt')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Receipt :application="editItem" />
    </b-modal>
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="editItem" :key="editItem.id"/>
    </b-modal>
    <b-modal id="doLetter" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Doletter :items="editItem" :key="editItem.id"/>
    </b-modal>
  </div>
</template>
<script>
import Payment from './Payment.vue'
import Receipt from './Receipt.vue'
import Details from './Details.vue'
import Doletter from './DoLetter.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allocationList, tcbPaymentStatusUpdate } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import { EventBus } from '@/EventBusLayout'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Payment,
    Receipt,
    Details,
    Doletter
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        office_id: 0,
        complain_id: '',
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'dealer.allocation_letter_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'dealer.letter_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '' } },
        { labels: 'tcb_report.do_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '' } },
        { labels: 'tcb_report.total_price', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '' } },
        { labels: 'allocation_management.payable_amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      items: '',
      editItem: '',
      viewTitle: this.$t('dealer.allocation') + ' ' + this.$t('globalTrans.details')
    }
  },
  created () {
    this.loadData()
    this.paymentStatusUpdate()
    EventBus.$on('offlinePaymentSubmit', this.loadData)
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'allocation_letter_id' },
          { key: 'letter_date' },
          { key: 'ado_no' },
          { key: 'total_price' },
          { key: 'payable_amount' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'allocation_letter_id' },
          { key: 'letter_date' },
          { key: 'ado_no' },
          { key: 'total_price' },
          { key: 'payable_amount' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('dealer.complain') + ' ' + this.$t('globalTrans.entry') : this.$t('dealer.complain') + ' ' + this.$t('globalTrans.details')
    },
    getRegionalOfficeList (orgId = null) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
        })
      return officeList
    },
    serviceList () {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.filter(item => item.status === 1)
    }
  },
  methods: {
    async paymentStatusUpdate () {
      if (this.$route.params.status && this.$route.query.transId) {
        const status = this.$route.params.status
        const tranId = this.$route.query.transId
        await RestApi.getData(licenseRegistrationServiceBaseUrl, tcbPaymentStatusUpdate + status, { transId: tranId }).then(response => {
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
        this.$router.push('/dealer-panel/allocation-letter')
      }
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.editItem = item
      } else {
        this.editItem = item
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allocationList, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(law => law.value === parseInt(item.office_id))
           const officeData = {}
            if (typeof officeObj !== 'undefined') {
                officeData.office_name = officeObj.text_en
                officeData.office_name_bn = officeObj.text_bn
            } else {
              officeData.office_name = ''
              officeData.office_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, officeData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
