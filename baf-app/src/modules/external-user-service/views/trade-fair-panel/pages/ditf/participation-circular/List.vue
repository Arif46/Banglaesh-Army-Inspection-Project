<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="year"
            >
            <template v-slot:label>
              {{$t('globalTrans.year')}}
            </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="yearList"
                id="year"
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
        <h4 class="card-title">{{ $t('exportTrophyCircular.circular') }} {{ $t('globalTrans.list') }}</h4>
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
                  <template v-slot:cell(year)="data">
                    <span>{{ $n(data.item.year, { useGrouping: false }) }}</span>
                  </template>
                  <template v-slot:cell(deadline)="data">
                    <span>{{ data.item.deadline | dateFormat }}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success" size="sm" class="btn btn-primary" @click="details(data.item)" :title="$t('globalTrans.view')">{{ $t('globalTrans.view') }}</b-button>
                    <!-- <b-button type="button" class="btn btn-success" variant="iq-bg-success ml-1" size="sm" @click="setServiceUrl(data.item)" :title="$t('globalTrans.apply')">{{ $t('globalTrans.apply') }}</b-button> -->
                  </template>
                </b-table>
              </slot>
              <div class="pagination-wrapper mt-3">
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
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title>
        {{ $t('exportTrophyCircular.circular') + ' ' + $t('globalTrans.details') }}
        <b-button variant="primary" @click="pdfExport" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="editItemId" :item="item" :key="editItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { DitfCircularParticipationList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.year, label_bn: i18n.messages.bn.globalTrans.year, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.circular_memo_no, label_bn: i18n.messages.bn.tradeFairInfoManagement.circular_memo_no, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.ditfTradeFairManages.circular_type, label_bn: i18n.messages.bn.ditfTradeFairManages.circular_type, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.subject, label_bn: i18n.messages.bn.tradeFairInfoManagement.subject, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.tradeFairInfoManagement.submission_deadline, label_bn: i18n.messages.bn.tradeFairInfoManagement.submission_deadline, class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 6, thStyle: { width: '20%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      sortBy: '',
      search: {
        year: 0,
        limit: 20
      },
      userDetails: [],
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      item: [],
      editItemId: '',
      service_name: ''
    }
  },
  components: {
    Details
  },
  created () {
    window.scrollTo(0, 0)
    this.labelData = this.labelList
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
    currentLocale () {
      return this.$i18n.locale
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'year' },
          { key: 'circular_memo_no' },
          { key: 'circular_type_bn' },
          { key: 'title_bn' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'year' },
          { key: 'circular_memo_no' },
          { key: 'circular_type_en' },
          { key: 'title_en' },
          { key: 'deadline' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    detailsTitle () {
      return this.$t('exportTrophyCircular.circular') + ' ' + this.$t('globalTrans.details')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    }
  },
  methods: {
    checkServiceName () {
      return this.currentLocale === 'bn' ? this.$route.params.name_bn : this.$route.params.name
    },
    searchData () {
      this.loadData()
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, DitfCircularParticipationList, params)
      if (result.success) {
        this.userList = result.userDetails
        const listData = result.data.data.map((item, index) => {
          const circularTypeObj = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(tmp => tmp.value === item.circular_type)

          const circularTypeData = {
            circular_type_bn: circularTypeObj !== undefined ? circularTypeObj.text_bn : '',
            circular_type_en: circularTypeObj !== undefined ? circularTypeObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index }, circularTypeData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    details (item) {
      this.editItemId = item.id
      this.item = item
    },
    setServiceUrl (item) {
      this.$router.push(`/portal/itf-calendar-info-form?circular_id=${item.id}`).catch(() => {})
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
<style>
  .apply_btn{
    font-size: 13px;
    padding: 3px 5px;
  }
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
