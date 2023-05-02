<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('ditfConfig.stall_pavilion_restaurant') + ' ' + $t('ditfConfig.info') }} {{ $t('globalTrans.search') }}</h4>
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
                  <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="circular_type"
              >
              <template v-slot:label>
                {{$t('ditfConfig.circular') + ' ' + $t('ditfConfig.type')}}
              </template>
              <b-form-select
                plain
                v-model="search.circular_type"
                :options="circularTypeList"
                id="circular_type"
              >
                <template v-slot:first>
                  <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
              <b-form-group
                label-for="fair_id"
              >
              <template v-slot:label>
                {{ $t('ditfConfig.fair_name') }}
              </template>
              <b-form-select
                plain
                v-model="search.fair_id"
                :options="fairTitleList"
                id="fair_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" class="" @click="searchData">
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
        <h4 class="card-title">{{ $t('ditfConfig.stall_pavilion_restaurant') + ' ' + $t('ditfConfig.info') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <!-- <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template> -->
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
                    <span class="badge badge-danger" v-if="data.item.flag == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-success" v-else>{{$t('globalTrans.active')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.flag === 1" v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="data.item.new_stall_qty > 0 ? $t('globalTrans.edit') : $t('globalTrans.add')"><i :class="data.item.new_stall_qty > 0 ? 'ri-pencil-fill' : 'ri-add-fill'"></i></b-button>
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
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="detailsItemId" :key="detailsItemId"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="$t('tradeFairConfig.stall_info_details')" hide-footer ok-only ok-variant="danger">
      <Details :id="detailsItemId" :key="detailsItemId"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import Form from './Form.vue'
import { stallInfoList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Form
  },
  data () {
    return {
      sortBy: '',
      detailsItemId: '',
      selectAll: false,
      selectedItem: [],
      itemData: [],
      search: {
        year: 0,
        circular_type: 1,
        fair_id: 0,
        limit: 20
      },
      fairTitleList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        // { labels: 'globalTrans.year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        // { labels: 'ditfConfig.circular', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'ditfConfig.fair_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'ditfConfig.stall_category', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'tradeFairConfig.stall_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'ditfConfig.size', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        // { labels: 'ditfConfig.stall_qty', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 9 }
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
    this.search.year = new Date().getFullYear()
    this.loadData()
  },
  watch: {
    'search.year': function (newVal) {
      this.fairTitleList = this.getFairTitle(newVal)
    },
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.$n(item, { useGrouping: false }) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    circularTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.map(item => {
        return Object.assign({}, item, { text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
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
          { key: 'fair_name_bn' },
          { key: 'cat_name_bn' },
          { key: 'stall_type_bn' },
          { key: 'size_bn' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fair_name_en' },
          { key: 'cat_name_en' },
          { key: 'stall_type_en' },
          { key: 'size_en' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.detailsItemId === 0) ? this.$t('ditfConfig.stall_pavilion_restaurant') + ' ' + this.$t('globalTrans.entry') : this.$t('ditfConfig.stall_pavilion_restaurant') + ' ' + this.$t('globalTrans.modify')
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getFairTitle (year) {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === year).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    edit (item) {
      this.detailsItemId = item.id
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    resetId () {
      this.detailsItemId = 0
    },
    detailsData (item) {
      this.detailsItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallInfoList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fairObj = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.find(el => el.value === item.stall_category.fair_id)
          const stallType = this.$store.state.TradeFairService.ditfCommonObj.stallTypeList.find(el => el.value === item.stall_type)
          const fairObjectData = {
            fair_name_bn: fairObj !== undefined ? fairObj.text_bn : '',
            fair_name_en: fairObj !== undefined ? fairObj.text_en : '',
            stall_type_en: stallType !== undefined ? stallType.text_en : '',
            stall_type_bn: stallType !== undefined ? stallType.text_bn : ''
          }
          return Object.assign({}, item, { serial: index }, fairObjectData)
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
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
