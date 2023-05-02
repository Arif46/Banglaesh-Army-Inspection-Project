<template>
  <div class="inner-section">
  <card>
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
                 <template v-slot:cell(proposal_id)="data">
                    {{ data.item.program?.proposal?.proposal_id }}
                  </template>
                 <template v-slot:cell(program_no)="data">
                    {{ $n(data.item.proposal_detail_id, {useGrouping:false}) }}
                  </template>
                 <template v-slot:cell(program_name)="data">
                    {{ currentLocale == 'en' ? data.item.program?.programe_name_en : data.item.program?.programe_name_bn }}
                  </template>
                  <template v-slot:cell(start_date)="data">
                    {{ data.item.start_date | dateFormat }}
                  </template>
                  <template v-slot:cell(end_date)="data">
                    {{ data.item.end_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary">{{statusText(data.item.bill?.status)}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.modal-details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.bill?.status == 1" v-b-modal.submit-bill-form @click="submitBill(data.item)" class="btn btn-sm btn-warning"><i class="ri-edit-circle-fill"></i> {{ $t('associationPnl.edit_bill') }}
                    </b-button>
                    <b-button v-if="data.item.bill === null" v-b-modal.submit-bill-form @click="submitBill(data.item)" class="btn btn-sm btn-success"><i class="ri-file-line"></i> {{ $t('associationPnl.submit_bill')}}
                    </b-button>
                    <b-button v-if="data.item.bill?.status >= 2" v-b-modal.view-bill @click="viewBill(data.item)" class="btn btn-sm btn-success"> <i class="ri-eye-fill"></i> {{  $t('associationPnl.view_bill') }}
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
    <b-modal id="submit-bill-form" size="lg" :title="submitBillTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FormSubmitBill :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="view-bill" size="lg" :title="viewBillTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <viewBill :items="items" :key="viewitemId"/>
    </b-modal>
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import FormSubmitBill from './Submit-bill-form.vue'
import viewBill from './view-bill.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { billableProgramList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, FormSubmitBill, viewBill
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        search: {
          user_id: this.$store.state.Auth.authUser.user_id,
          association_info_id: 0,
          council_info_id: 0,
          limit: 10
        },
        profile: this.$store.state.ExternalUserService.eBizPanel.associationProfile,
        labelData: [
          { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
          { labels: 'associationPnl.proposal_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
          { labels: 'associationPnl.program_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
          { labels: 'associationPnl.program_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
          { labels: 'associationPnl.start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
          { labels: 'associationPnl.end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
          { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
          { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '25%' } }
      ],
      items: [],
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
          { key: 'proposal_id' },
          { key: 'program_no' },
          { key: 'program_name' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'proposal_id' },
          { key: 'program_no' },
          { key: 'program_name' },
          { key: 'start_date' },
          { key: 'end_date' },
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
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.view') : this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.modify')
    },
    viewBillTitle () {
      return this.$t('associationPnl.final_bill') + ' ' + this.$t('globalTrans.view')
    },
    submitBillTitle () {
      return this.$t('associationPnl.submit_bill')
    },
    finalSaveTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save') : this.$t('associationPnl.program_request') + ' ' + this.$t('associationPnl.final_save')
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('associationPnl.program_request') + ' ' + this.$t('globalTrans.entry') : this.$t('associationPnl.program_request') + ' ' + this.$t('globalTrans.modify')
    },
    billStatusList: function () {
      const list = [
          { value: 1, text: this.$i18n.locale === 'en' ? 'Bill Not Submitted' : 'বিল জমা দেওয়া হয়নি' },
          { value: 2, text: this.$i18n.locale === 'en' ? 'Bill Submitted' : 'বিল জমা দেওয়া হয়েছে' },
          { value: 3, text: this.$i18n.locale === 'en' ? 'Bill Approved' : 'বিল অনুমোদিত' },
          { value: 4, text: this.$i18n.locale === 'en' ? 'Bill Rejected' : 'বিল প্রত্যাখ্যাত' }
      ]
      return list
    },
    councilInfoList () {
      return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    submitBill (item) {
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
     statusText (sta = 1) {
          const reqStatusObj = this.billStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
     },
    async loadData () {
      this.search.council_info_id = this.profile.council_info_id
      this.search.association_info_id = this.profile.association_info_id
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, billableProgramList, params)
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
