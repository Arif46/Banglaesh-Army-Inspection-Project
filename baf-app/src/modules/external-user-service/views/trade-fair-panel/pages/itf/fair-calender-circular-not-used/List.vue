<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tradeFairInfoManagement.fair_calender_circular') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('tradeFairInfoManagement.fair_calender_circular') }} {{ $t('globalTrans.list') }}</h4>
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
                    <span class="badge badge-success" v-if="data.item.status === 5">{{$t('globalTrans.published')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-detail variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn active view" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button @click="apply(data.item)" v-if="parseInt(data.item.submission_deadline) >= parseInt(currentDate)" size="sm" class="action-btn status" :title="$t('globalTrans.apply')"><i class="ri-add-fill"></i></b-button>
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
    <b-modal id="modal-detail" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import { itfTradeFairList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      currentDate: '',
      sortBy: '',
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tradeFairInfoManagement.circular_memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'tradeFairInfoManagement.subject', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6 }
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
    this.currentDate = Math.round(new Date().getTime() / (1000 * 60 * 60 * 24)) * (1000 * 60 * 60 * 24)
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
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_number' },
          { key: 'subject_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('research_plan_management.assign_task_coordinator') + ' ' + this.$t('globalTrans.entry') : this.$t('research_plan_management.assign_task_coordinator') + ' ' + this.$t('globalTrans.modify')
    }
  },
  mounted () {
    this.search = Object.assign({}, this.search, { fiscal_year_id: this.$store.state.currentFiscalYearId })
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
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, itfTradeFairList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearData = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const customItem = {
            fiscal_year_en: fiscalYearData?.text_en,
            fiscal_year_bn: fiscalYearData?.text_bn
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
    },
    apply (item) {
      this.$router.push(`/trade-fair-panel/fair-calendar-info-form?circular_id=${item.id}`)
    }
  }
}
</script>
