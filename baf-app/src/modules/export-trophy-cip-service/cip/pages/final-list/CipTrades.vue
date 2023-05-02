<template>
  <div class="inner-section">
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('cip.cip_trade') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions"/>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { finalListCipTradesApi, cipSectorToggleApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.year, label_bn: i18n.messages.bn.globalTrans.year, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.globalTrans.name, label_bn: i18n.messages.bn.globalTrans.name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.exportTrophyConfig.cip_sector, label_bn: i18n.messages.bn.exportTrophyConfig.cip_sector, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.designation, label_bn: i18n.messages.bn.globalTrans.designation, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } }
]
export default {
  props: ['searchItem'],
  mixins: [ModalBaseMasterList],
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        status: 6,
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      actions: {
        edit: true,
        details: false
      }
    }
  },
  created () {
    this.labelData = this.labelList
    if (this.searchItem) {
      Object.assign(this.search, { type: this.searchItem.app_type, year: this.searchItem.year })
      this.loadData()
    }
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    cipSectorList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.cipSectorList.filter(item => item.cip_category === 2)
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
          { key: 'name_bn' },
          { key: 'sector_bn' },
          { key: 'designation_bn' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'year' },
          { key: 'name_en' },
          { key: 'sector_en' },
          { key: 'designation_en' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('cip.cip_trade') + ' ' + this.$t('globalTrans.entry') : this.$t('cip.cip_trade') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(exportTrophyCIPServiceBaseUrl, cipSectorToggleApi, item)
      }
    },
    searchData () {
      this.loadData()
    },
    tradesSearch (searchItem) {
      Object.assign(this.search, { type: searchItem.app_type, year: searchItem.year })
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, finalListCipTradesApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const cipSectorObj = this.cipSectorList.find(tmp => tmp.value === item.cip_sector_id)
          const yearObj = this.$store.state.commonObj.yearList.find(tmp => tmp.value === item.year)

          const cipSectorData = {
            sector_bn: cipSectorObj !== undefined ? cipSectorObj.text_bn : '',
            sector_en: cipSectorObj !== undefined ? cipSectorObj.text_en : ''
          }

          const yearData = {
            year_bn: yearObj !== undefined ? yearObj.text_bn : '',
            year_en: yearObj !== undefined ? yearObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index }, cipSectorData, yearData)
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
