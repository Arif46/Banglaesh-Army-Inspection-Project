<template>
  <div class="inner-section">
  <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizProgram.program_list') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="fiscal_year"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fiscal_year"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
         <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Council Name" vid="council_info_id" rules="">
                  <b-form-group
                      label-for="council_info_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('eBizProgram.council_name')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.council_info_id"
                      :options="councilInfoList"
                      id="council_info_id"
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
          <b-col md="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
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
        <h4 class="card-title">{{ $t('associationPnl.program') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                 <template v-slot:cell(fiscal_year)="data">
                    {{ getFiscalYear(data.item.fiscal_year_id) }}
                  </template>
                 <template v-slot:cell(association)="data">
                    {{ getAssociationName(data.item.association_info_id) }}
                  </template>
                 <template v-slot:cell(proposal_id)="data">
                    {{ data.item.program?.program?.proposal?.proposal_id }}
                  </template>
                 <template v-slot:cell(program_no)="data">
                    {{ $n(data.item.proposal_detail_id, {useGrouping: false}) }}
                  </template>
                 <template v-slot:cell(program_name)="data">
                    {{ currentLocale == 'en' ? data.item.program.program.programe_name_en : data.item.program.program.programe_name_bn }}
                  </template>
                  <template v-slot:cell(program_budget)="data">
                    {{ $n(data.item.program.program.amount) }}
                  </template>
                  <template v-slot:cell(paid)="data">
                    {{ $n(getProgramPaidAmount(data.item)) }}
                  </template>
                  <template v-slot:cell(remaining)="data">
                    {{ (data.item.program.payment?.status != 1) ? `${currentLocale == 'en' ? 'Unpaid' : 'অপরিশোধিত'}` : `${currentLocale == 'en' ? 'Paid' : 'পরিশোধিত'}` }}
                    <!-- {{ (data.item.program.payment?.status == 1 && currentLocale == 'bn') ? 'অপরিশোধিত ' : 'পরিশোধিত' }} -->
                  </template>
                  <template v-slot:cell(status)="data">
                    <span :class="`badge ${data.item.program.payment?.status === 0 || data.item.program.payment == null ? 'badge-danger' : 'badge-primary'}`">{{statusText(data.item.program.payment?.status)}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.modal-details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.program.payment?.status != 1" v-b-modal.payment-form variant="action-btn status mr-1" size="sm" @click="paymentSubmit(data.item)" class="action-btn status btn-success" :title="$t('globalTrans.payment')"> <i class="ri-bank-card-line"></i>
                    </b-button>
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
    <b-modal id="payment-form" size="lg" :title="paymentTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <PaymentForm :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import PaymentForm from './PaymentForm.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programPaymentList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    PaymentForm
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        search: {
        fiscal_year_id: 0,
        council_info_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'associationPnl.association', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'associationPnl.proposal_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'associationPnl.program_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'associationPnl.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'associationPnl.program_budget', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'globalTrans.paid', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'eBizProgram.remaining', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '25%' } }
      ],
      items: [],
      associationInfo: {},
      viewitemId: 0,
      actions: {
        edit: true,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
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
          { key: 'fiscal_year' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'program_no' },
          { key: 'program_name' },
          { key: 'program_budget' },
          { key: 'paid' },
          { key: 'remaining' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'association' },
          { key: 'proposal_id' },
          { key: 'program_no' },
          { key: 'program_name' },
          { key: 'program_budget' },
          { key: 'paid' },
          { key: 'remaining' },
          { key: 'status' },
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
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
     viewBillTitle () {
      return this.$t('associationPnl.final_bill') + ' ' + this.$t('globalTrans.view')
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.view') : this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.modify')
    },
    paymentTitle () {
      return this.$t('globalTrans.payment')
    },
    finalSaveTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save') : this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save')
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.modify')
    },
    billStatusList: function () {
      const list = [
          { value: 0, text: this.$i18n.locale === 'en' ? 'Payment Pending' : 'পেমেন্ট পেন্ডিং' },
          { value: 1, text: this.$i18n.locale === 'en' ? 'Payment Done' : 'পেমেন্ট সম্পন্ন' }
      ]
      return list
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    getFiscalYear (yearId) {
      const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
      if (cateObj !== undefined) {
          if (this.$i18n.locale === 'bn') {
              return cateObj.text_bn
          } else {
              return cateObj.text_en
          }
      }
    },
    getAssociationName (associationId) {
        const cateObj = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1).find(item => item.value === associationId)
        if (cateObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return cateObj.text_bn
            } else {
                return cateObj.text_en
            }
        }
    },
    getProgramPaidAmount (item) {
      return item.program.adv_payments.reduce((sum = 0, item) => sum + item.amount, 0)
    },
    paymentSubmit (item) {
      this.items = item
    },
    viewBill (item) {
      this.items = item
    },
    details (item) {
        this.items = item
    },
    edit (item) {
      this.items = item
    },
    finalSave (item) {
        this.items = item
    },
     editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
        this.items = item
      } else if (type === 2) {
        // this.changeStatus(3, eBizServiceBaseUrl, budgetEntryToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
     statusText (sta = 0) {
          const reqStatusObj = this.billStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
     },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, programPaymentList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fisalYearObj = {
          serial: index
        }
          return Object.assign({}, item, fisalYearObj, { serial: index })
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
