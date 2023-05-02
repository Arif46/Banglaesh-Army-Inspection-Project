<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('bazarMonitoring.price_fluctuation_alert') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Price_category_name"
            >
              <template v-slot:label>
                {{ $t('bazarMonitoring.Price_category_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.price_category_id"
                :options="priceCategoryList"
                id="price_category_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="commodity_group_name"
            >
              <template v-slot:label>
                {{ $t('bazarMonitoring.commodity_group_name') }}
              </template>
            <b-form-select
                plain
                v-model="search.commodity_group_id"
                :options="commodityGroupList"
                id="commodity_group_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title">{{ $t('bazarMonitoring.price_fluctuation_alert') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :componentId="3" :searchData="searchData" :paginations="pagination" :actions="actions" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceFluctuationAlertList, priceFluctuationAlertToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      sortBy: '',
      search: {
        price_category_id: 0,
        commodity_group_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'bazarMonitoring.Price_category_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'bazarMonitoring.commodity_group_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'bazarMonitoring.alert_percentage', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'globalTrans.note', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7, thStyle: { width: '10%' } }
      ],
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
          { key: 'Price_category_name_bn' },
          { key: 'commodity_group_name_bn' },
          { key: 'alert_percentage' },
          { key: 'note_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'Price_category_name' },
          { key: 'commodity_group_name' },
          { key: 'alert_percentage' },
          { key: 'note_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('bazarMonitoring.price_fluctuation_alert') + ' ' + this.$t('globalTrans.entry') : this.$t('bazarMonitoring.price_fluctuation_alert') + ' ' + this.$t('globalTrans.modify')
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    commodityGroupList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, bazarMonitoringServiceBaseUrl, priceFluctuationAlertToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceFluctuationAlertList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(priceCategory => priceCategory.value === parseInt(item.price_category_id))
        const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(commodityGroup => commodityGroup.value === parseInt(item.commodity_group_id))
        const priceCategoryData = {}
        const commodityGroupData = {}
            if (typeof priceCategoryObj !== 'undefined') {
                priceCategoryData.Price_category_name = priceCategoryObj.text_en
                priceCategoryData.Price_category_name_bn = priceCategoryObj.text_bn
            } else {
              priceCategoryData.Price_category_name = ''
              priceCategoryData.Price_category_name_bn = ''
            }
            if (typeof commodityGroupObj !== 'undefined') {
              commodityGroupData.commodity_group_name = commodityGroupObj.text_en
              commodityGroupData.commodity_group_name_bn = commodityGroupObj.text_bn
            } else {
              commodityGroupData.commodity_group_name = ''
              commodityGroupData.commodity_group_name_bn = ''
            }
          return Object.assign({}, item, { serial: index }, priceCategoryData, commodityGroupData)
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
