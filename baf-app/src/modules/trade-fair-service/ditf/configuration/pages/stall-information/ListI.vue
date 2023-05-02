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
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title">{{ $t('exhibitCircularManagement.fair_exhibition_info') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
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
                  <template v-slot:head(check)>
                    <b-form-checkbox
                      style="display: table-cell"
                      class="col-form-label-sm font-weight-bold mb-0"
                      name="checked"
                      v-model="selectAll"
                      @change="checkAll"
                      :value=true
                      :unchecked-value=false
                    >
                    {{ $t('globalTrans.forward') }}
                    </b-form-checkbox>
                  </template>
                  <template v-slot:cell(check)="data">
                    <b-form-group class="mb-0" v-slot="{ ariaDescribedby }" v-if="data.item.status != 3">
                      <b-form-checkbox-group v-model="selectedItem" style="margin-top: 5px" :aria-describedby="ariaDescribedby">
                        <b-form-checkbox :value="data.item.id" style="margin-right: 0"></b-form-checkbox>
                      </b-form-checkbox-group>
                    </b-form-group>
                  </template>
                  <template v-slot:cell(year)="data">
                    <span>{{ $n(data.item.year, {useGrouping: false}) }}</span>
                  </template>
                  <template v-slot:cell(fair_name)="data">
                    <span>{{ getFairName(data.item.fair_id) }}</span>
                  </template>
                  <template v-slot:cell(circular_type)="data">
                    <span>{{ getCircularType(data.item.circular_type) }}</span>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button :title="$t('globalTrans.details')" v-b-modal.modal-4 variant=" action-btn status" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button :variant="data.item.status === 2 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 2 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="remove(data.item)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
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
    <b-modal id="modal-form" size="xl" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="detailsItemId" :key="detailsItemId"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="$t('tradeFairConfig.stall_category_details')" hide-footer ok-only ok-variant="danger">
      <Details :id="detailsItemId" :key="detailsItemId"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import Form from './Form.vue'
import { stallInfoList, stallInfoToggle } from '../../api/routes'
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
        circular_type: 0,
        fair_id: 0,
        limit: 20
      },
      fairTitleList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'ditfConfig.circular', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'ditfConfig.fair_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '35%' } },
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
          return { value: item, text: this.EngBangNum(item.toString()) }
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
          { key: 'year' },
          { key: 'circular_type' },
          { key: 'fair_name' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'year' },
          { key: 'circular_type' },
          { key: 'fair_name' },
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
    getCircularType (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
    getFairName (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.find(item => item.value === id)
      if (this.currentLocale === 'bn') {
        return dataStallType !== undefined ? dataStallType.text_bn : ''
      } else {
        return dataStallType !== undefined ? dataStallType.text_en : ''
      }
    },
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
    checkAll () {
      if (this.selectAll) {
        this.selectedItem.splice(0, this.selectedItem.length)
        this.listData.filter(el => el.status !== 3).forEach(element => this.selectedItem.push(element.id))
      } else {
        this.selectedItem.splice(0, this.selectedItem.length)
      }
    },
    check () {
      const itemObj = this.listData.find(item => item.is_checked === false)
      if (itemObj === undefined) {
        this.selectAll = true
      } else {
        this.selectAll = false
      }
    },
    resetId () {
      this.detailsItemId = 0
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
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
          const obj = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(el => el.value === item.circular_type)
          const fairObj = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.find(el => el.value === item.fair_id)
          const objectData = {
            circular_type_bn: obj !== undefined ? obj.text_bn : '',
            circular_type_en: obj !== undefined ? obj.text_en : ''
          }
          const fairObjectData = {
            fair_name_bn: obj !== undefined ? fairObj.text_bn : '',
            fair_name_en: obj !== undefined ? fairObj.text_en : ''
          }
          return Object.assign({}, item, { serial: index }, objectData, fairObjectData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    remove (item) {
      this.changeStatus(9, internationalTradeFairServiceBaseUrl, stallInfoToggle, item)
    }
  }
}
</script>
<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
