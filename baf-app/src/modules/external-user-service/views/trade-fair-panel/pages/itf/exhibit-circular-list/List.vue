<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('externalTradeFair.circular_exhibition') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('externalTradeFair.circular_exhibition') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(country_city)="data">
                    {{ ($i18n.locale === 'bn' ? data.item.city_bn : data.item.city) + ', ' + ($i18n.locale === 'bn' ? data.item.country_name_bn : data.item.country_name_en) }}
                  </template>
                  <template v-slot:cell(deadline)="data">
                    <span>{{ data.item.deadline | dateFormat }}</span>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-secondary" v-else-if="data.item.status == 2">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 4">{{$t('globalTrans.return')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 5">{{$t('globalTrans.publish')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <router-link :title="$t('globalTrans.apply')" :to="`/trade-fair-panel/exhibit-information-form?exb_circular_id=${data.item.id}`" class="btn btn-info btn-sm ml-1" >{{ $t('globalTrans.apply') }}</router-link>
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
    <b-modal id="modal-4" size="lg" :title="$t('externalTradeFair.circular_exhibition') + ' ' + $t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('externalTradeFair.circular_exhibition') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" :item="item" :key="detailsItemId" ref="details"/>
    </b-modal>
    <!-- <b-modal id="modal-form" centered class="text-center" size="xl" :title="formTitle" hide-footer ok-only ok-variant="danger">
      <Form :id="detailsItemId" :item="item" :key="detailsItemId" />
    </b-modal> -->
  </div>
</template>
<script>
import Details from './Details.vue'
// import Form from '../exhibit-information/Form.vue'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { circularExhibitionList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      search: {
        fiscal_year_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'externalTradeFair.circular_memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'externalTradeFair.subject', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'externalTradeFair.country_city', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'tradeFairInfoManagement.submission_deadline', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        // { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7, thStyle: { width: '20%' } }
      ],
      sortBy: '',
      item: '',
      detailsItemId: '',
      sortDesc: true,
      sortDirection: 'desc'
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
          { key: 'subject_bn' },
          { key: 'country_city' },
          { key: 'deadline' },
          // { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'circular_memo_no' },
          { key: 'subject_en' },
          { key: 'country_city' },
          { key: 'deadline' },
          // { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return this.$t('externalTradeFair.exhibit_information') + ' ' + this.$t('globalTrans.entry')
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
    detailsData (item) {
      this.detailsItemId = item.id
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    exhibition (item) {
      this.item = item
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, circularExhibitionList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const country = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(item.country_id))
          const customItem = {
            fiscal_year_en: fiscalYear?.text_en,
            fiscal_year_bn: fiscalYear?.text_bn,
            country_name_en: country?.text_en,
            country_name_bn: country?.text_bn
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
