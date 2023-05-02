<template>
  <div class="inner-section">
  <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('eBizProgram.program') }} {{ $t('globalTrans.search')}}</h4>
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
        <h4 class="card-title">{{ $t('associationPnl.program_request') }} {{ $t('globalTrans.list') }}</h4>
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
                    {{ data.item.program?.program?.proposal?.proposal_id }}
                  </template>
                 <template v-slot:cell(program_no)="data">
                    {{ $n(data.item.proposal_detail_id, {useGrouping: false}) }}
                  </template>
                 <template v-slot:cell(program_name)="data">
                    {{ currentLocale == 'en' ? data.item.program.program.programe_name_en : data.item.program.program.programe_name_bn }}
                  </template>
                  <template v-slot:cell(start_date)="data">
                    {{ data.item.program.start_date | dateFormat }}
                  </template>
                  <template v-slot:cell(end_date)="data">
                    {{ data.item.program.end_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span :class="`badge ${data.item.status === 4 ? 'badge-danger' : 'badge-primary'}`">{{statusText(data.item.status)}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button  v-b-modal.modal-details variant="action-btn status mr-1" size="sm" @click="details(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status === 2" v-b-modal.approve-bill-form @click="approveBill(data.item)" class="btn btn-sm btn-success"> <i class="ri-file-line"></i> {{ $t('associationPnl.approve_bill')}}
                    </b-button>
                    <b-button v-if="data.item.status === 3" v-b-modal.view-bill @click="viewBill(data.item)" class="btn btn-sm btn-success"> <i class="ri-eye-fill"></i> {{  $t('associationPnl.view_bill') }}
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
    <b-modal id="approve-bill-form" size="lg" :title="approveTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <FormApproveBill :items="items" :key="viewitemId"/>
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
import FormApproveBill from './Approve-bill-form.vue'
import viewBill from './view-bill.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { approveBillProgramList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    FormApproveBill,
    viewBill
  },
  data () {
    return {
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        sortBy: '',
        sortDesc: true,
        sortDirection: 'desc',
        search: {
        user_id: this.$store.state.Auth.authUser.user_id,
        fiscal_year_id: 0,
        council_info_id: 0,
        limit: 10
      },
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
     viewBillTitle () {
      return this.$t('associationPnl.final_bill') + ' ' + this.$t('globalTrans.view')
    },
    viewTitle () {
      return (this.viewitemId === 0) ? this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.view') : this.$t('associationPnl.program') + ' ' + this.$t('globalTrans.modify')
    },
    approveTitle () {
      return this.$t('eBizProgram.approve_bill_title')
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
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  methods: {
    approveBill (item) {
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
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(eBizServiceBaseUrl, approveBillProgramList, params)
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
