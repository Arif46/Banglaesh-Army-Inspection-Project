<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('externalTradeFair.circular_fair_participation') }} {{ $t('globalTrans.search') }}</h4>
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
              label-for="fair_name_id"
            >
              <template v-slot:label>
                {{ $t('externalTradeFair.fair_name') }}
              </template>
              <b-form-select
                plain
                id="fair_name_id"
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
        <h4 class="card-title">{{ $t('externalTradeFair.circular_fair_participation') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(deadline)="data">
                    <span>{{ data.item.deadline | dateFormat }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button class="mb-1" :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.deadline >= current_date" class="mb-1 btn btn-info btn-sm ml-1" type="button" @click="apply(data.item)" :title="$t('globalTrans.apply')">{{ $t('globalTrans.apply') }}</b-button>
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
    </body-card>
    <b-modal id="modal-4" size="lg" :title="$t('externalTradeFair.circular_fair_participation') + ' ' + $t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.circular_fair_participation') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" :item="item" :key="detailsItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairParticipationCalenderList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

const today = new Date().toISOString().substr(0, 10)
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      current_date: today,
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'externalTradeFair.circular_memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.fair_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '25%' } },
        { labels: 'tradeFairInfoManagement.submission_deadline', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 6, thStyle: { width: '12%' } }
      ],
      sortBy: '',
      item: '',
      detailsItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      fairNameList: []
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
          { key: 'circular_memo_no' },
          { key: 'fair_name_bn' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_no' },
          { key: 'fair_name_en' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
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
    apply (item) {
      this.$router.push(`/trade-fair-panel/fair-participation-form?circular_id=${item.id}`).catch(() => {})
    },
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairParticipationCalenderList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const fairName = this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.find(obj => obj.value === parseInt(item.fair_name_id))
          const customItem = {
            fiscal_year_en: fiscalYear?.text_en,
            fiscal_year_bn: fiscalYear?.text_bn,
            fair_name_en: fairName?.text_en,
            fair_name_bn: fairName?.text_bn
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
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
