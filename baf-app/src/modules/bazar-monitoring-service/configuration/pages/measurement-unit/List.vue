<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('bazarMonitoring.measurement_unit') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="commodity_name_id"
            >
              <template v-slot:label>
                 {{$t('bazarMonitoring.commodity_name')}}
              </template>
            <b-form-select
                plain
                v-model="search.commodity_name_id"
                :options="commodityNameList"
                id="commodity_name_id"
                >
            <template v-slot:first>
                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
            </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="unit_name_en"
            >
              <template v-slot:label>
                {{ $t('bazarMonitoring.measurement_unit') }}
              </template>
              <b-form-input
                  id="unit_name_en"
                  type="text"
                  v-model="search.unit_name_en"
              ></b-form-input>
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
        <h4 class="card-title">{{ $t('bazarMonitoring.measurement_unit') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :componentId="3" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" />
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
import { measurementUnitList, measurementUnitToggle } from '../../api/routes'
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
        unit_name_en: '',
        commodity_group_id: 0,
        commodity_name_id: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
        { labels: 'bazarMonitoring.commodity_group', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'bazarMonitoring.commodity_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'bazarMonitoring.measurement_unit', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 5, thStyle: { width: '15%' } }
      ],
      commodityNameList: [],
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
    },
    'search.commodity_group_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.commodityNameList = this.getCommodityNameList(newVal)
      } else {
        this.commodityNameList = []
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
          { key: 'commodity_group_name_bn' },
          { key: 'commodity_name_bn' },
          { key: 'unit_name_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'commodity_group_name' },
          { key: 'commodity_name' },
          { key: 'unit_name_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('bazarMonitoring.measurement_unit') + ' ' + this.$t('globalTrans.entry') : this.$t('bazarMonitoring.measurement_unit') + ' ' + this.$t('globalTrans.modify')
    },
    commodityGroupList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    }
  },
  methods: {
    getCommodityNameList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(3, bazarMonitoringServiceBaseUrl, measurementUnitToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, measurementUnitList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(commodityGroup => commodityGroup.value === parseInt(item.commodity_group_id))
          const commodityGroupData = {}
          if (typeof commodityGroupObj !== 'undefined') {
            commodityGroupData.commodity_group_name = commodityGroupObj.text_en
            commodityGroupData.commodity_group_name_bn = commodityGroupObj.text_bn
          } else {
            commodityGroupData.commodity_group_name = ''
            commodityGroupData.commodity_group_name_bn = ''
          }
          const commodityNameListObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(commodityName => commodityName.value === parseInt(item.commodity_name_id))
          const commodityNameData = {}
          if (typeof commodityNameListObj !== 'undefined') {
            commodityNameData.commodity_name = commodityNameListObj.text_en
            commodityNameData.commodity_name_bn = commodityNameListObj.text_bn
          } else {
            commodityNameData.commodity_name = ''
            commodityNameData.commodity_name_bn = ''
          }
          return Object.assign({}, item, { serial: index }, commodityGroupData, commodityNameData)
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
