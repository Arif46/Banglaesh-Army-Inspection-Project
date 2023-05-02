<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairProposalManagement.fair_proposal_management') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('tradeFairProposalManagement.fair_proposal_management') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link href="javascript:" to="/trade-fair-service/itf/fair-proposal-management/fair-calendar-info-form" class="btn-add"><i class="ri-add-fill"></i> {{  $t('globalTrans.add_new') }}</router-link>
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
                  <template v-slot:cell(total_application)="data">
                    {{ $n(data.item.total_application) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.isForwardCount === 0">
                      {{$t('globalTrans.pending')}}
                    </span>
                    <span class="badge badge-info" v-if="data.item.isForwardCount > 0 && data.item.isApproveCount === 0">
                      {{ $t('globalTrans.forward') }}
                    </span>
                    <span class="badge badge-success" v-if="data.item.isApproveCount > 0">
                      {{ $t('globalTrans.approved') }}
                    </span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="data.item.isForwardCount !== 0" v-b-modal.modal-form-forward-details variant="iq-bg-info mr-1" size="sm" @click="forwardDetails(data.item)" class="action-btn edit" :title="$t('exportTrophyGazette.forward_comment')"><i class="ri-message-2-line"></i></b-button>
                    <b-button v-if="data.item.isForwardCount === 0" variant="iq-bg-success" class="action-btn delete" size="sm" @click="sorting(data.item)" :title="$t('tradeFairProposalManagement.sorting')"><i class="ri-filter-line"></i></b-button>
                    <b-button v-if="data.item.isForwardCount === 0 && new Date().toISOString().substr(0, 10) > data.item.submission_deadline" v-b-modal.modal-forward variant="iq-bg-success" size="sm" @click="forward(data.item)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-share-forward-line"></i></b-button>
                    <b-button v-b-modal.modal-final variant="iq-bg-success" size="sm" @click="view(data.item)" class="action-btn active" :title="$t('tradeFairProposalManagement.finalcalendar')"><i class="ri-eye-line"></i></b-button>
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
    <b-modal id="modal-form-forward-details" size="lg" :title="forwardComment" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ForwardDetails :items="itemData"/>
    </b-modal>
    <b-modal id="modal-forward" size="lg" :title="$t('globalTrans.forward')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Forward :items="itemData"/>
    </b-modal>
    <b-modal id="modal-final" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Final :items="itemData" :status="4"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Forward from './Forward'
import Final from './Final'
import ForwardDetails from './ForwardDetails'
import { itfFairCalenderProposalInfoList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Forward, Final, ForwardDetails
  },
  data () {
    return {
      sortBy: '',
      itemData: [],
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'tradeFairInfoManagement.circular_memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'tradeFairProposalManagement.circular', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
        { labels: 'tradeFairProposalManagement.total_appliction', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 7 }
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
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
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
          { key: 'circular_memo_number' },
          { key: 'subject_bn' },
          { key: 'total_application' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_number' },
          { key: 'subject_en' },
          { key: 'total_application' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    },
    typeOfFair () {
      return this.$store.state.TradeFairService.commonObj.typeOfFair.map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    countryList () {
      return this.$store.state.CommonService.commonObj.countryList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    forwardComment () {
      return this.$t('exportTrophyGazette.forward_comment')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    sorting (item) {
      this.$router.push({ path: '/trade-fair-service/itf/fair-proposal-management/collected-fair-calendars-fiscal-year-circular-wise', query: { fiscal_year: item.fiscal_year_id } })
    },
    forward (item) {
      this.itemData = item
    },
    forwardDetails (item) {
      this.itemData = item
    },
    view (item) {
      this.itemData = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, itfFairCalenderProposalInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const customItem = {
            fiscal_year_en: fiscalYearData.text_en,
            fiscal_year_bn: fiscalYearData.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
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
