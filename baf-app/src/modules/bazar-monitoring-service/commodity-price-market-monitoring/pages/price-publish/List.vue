<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.price_publish') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Area Type" vid="area_type_id">
                  <b-form-group
                      label-for="area_type_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('bazarMonitoring.area_type')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="search.area_type_id"
                      :options="areaTypeList"
                      id="area_type_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                  >
                      <template v-slot:first>
                      <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                  </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
                <ValidationProvider name="Division" vid="division_id">
                    <b-form-group
                        label-for="division_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.division')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.division_id"
                        :options="divisionList"
                        id="division_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
                <ValidationProvider name="District" vid="district_id">
                    <b-form-group
                        label-for="district_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.district')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.district_id"
                        :options="districtList"
                        id="district_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1">
                <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1">
                    <b-form-group
                        label-for="city_corporation_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="search.city_corporation_id"
                        :options="cityCorporationList"
                        id="city_corporation_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2 || search.area_type_id === 3">
                <ValidationProvider name="Upazila" vid="upazila_id">
                    <b-form-group
                        label-for="upazila_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.upazila')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.upazila_id"
                        :options="upazilaList"
                        id="upazila_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Market Diretory" vid="market_directory_id">
                    <b-form-group
                        label-for="market_directory_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.market_name')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.market_directory_id"
                        :options="marketList"
                        id="market_directory_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Commodity Group" vid="commodity_group_id">
                    <b-form-group
                        label-for="commodity_group_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.commodity_group')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.commodity_group_id"
                        :options="commodityGroupList"
                        id="market_directory_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Commodity Name" vid="commodity_name_id">
                    <b-form-group
                        label-for="commodity_name_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.commodity_name')}}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.commodity_name_id"
                        :options="commodityNameList"
                        id="commodity_name_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                    >
                        <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
                label-for="price_collection_date"
                >
                <template v-slot:label>
                    {{ $t('priceMonitoring.price_collection_date') }}
                </template>
                    <date-picker
                      id="price_collection_date"
                      v-model="search.price_collection_date"
                      class="form-control"
                      :placeholder="$t('globalTrans.select')"
                      :locale="currentLocale"
                    >
                    </date-picker>
                </b-form-group>
            </b-col>
            <b-col sm="4" class="mt-4">
                <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('priceMonitoring.price_publish') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col sm="12">
              <div class="quick-filter-wrapper">
                <div class="quick-filter-left">
                  <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
                    <b-dropdown-form>
                      <div
                        class="form-group"
                        v-for="(field, index) in labelData"
                        :key="index"
                        >
                          <b-form-checkbox
                            :id="'checkbox-' + field.label_en"
                            v-model="field.show"
                            :name="'checkbox-' + field.label_en"
                            value=1
                            unchecked-value=0
                          >
                            {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
                          </b-form-checkbox>
                      </div>
                    </b-dropdown-form>
                  </b-dropdown>
                </div>
                <div class="quick-filter-right">
                  <b-form-group
                    :label="$t('menu.perpage')"
                    label-for="per-page-select"
                  >
                    <b-form-select
                      id="per-page-select"
                      v-model="search.limit"
                      :options="pageOptions"
                      size="sm"
                    ></b-form-select>
                  </b-form-group>
                </div>
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-danger" v-if="data.item.status == 2">{{$t('priceMonitoring.unpublish')}}</span>
                    <span class="badge badge-success" v-if="data.item.status == 3">{{$t('priceMonitoring.published')}}</span>
                  </template>
                   <template v-slot:cell(price_collection_date)="data">
                      {{ data.item.price_collection_date | dateFormat }}
                    </template>
                  <template v-slot:cell(action)="data">
                    <!-- <router-link class="action-btn edit" :title="$t('globalTrans.edit')" :to="{ name: 'bazar_monitoring_service.configuration.price_form', params: { id: data.item.id, latitude: data.item.latitude, longitude: data.item.longitude }}" size="sm">
                      <i class="ri-pencil-fill"></i>
                    </router-link> -->
                    <router-link class="action-btn edit" v-if="data.item.status == 2" variant=" iq-bg-success mr-1" :title="$t('globalTrans.edit')" :to="`/bazar-monitoring-service/commodity-price-market-monitoring/form/${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>
                    <b-button variant=" iq-bg-info" v-if="data.item.status == 2" size="sm" @click="publishStatus(data.item)" class="action-btn approve" :title="$t('globalTrans.publish')"><i class="ri-check-fill"></i></b-button>
                    <!-- <b-button class="mr-2" title="details" v-b-modal.modal-4 variant=" action-btn status mr-1" size="sm" @click="detailsData(data.item)"><i class="ri-eye-fill"></i></b-button> -->
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" :title="$t('globalTrans.view')" :to="`/bazar-monitoring-service/commodity-price-market-monitoring/price-publish-detail/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
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
    <b-modal id="modal-form" size="xl" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
     <b-modal id="modal-4" size="lg" :title="$t('globalTrans.details')" hide-footer ok-only ok-variant="danger">
        <Details :id="detailsItemId" :item="item"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceUnpublishList, pricePublishUpdate } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'
import Store from '@/store'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.division, label_bn: i18n.messages.bn.globalTrans.division, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.globalTrans.district, label_bn: i18n.messages.bn.globalTrans.district, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
  { label_en: i18n.messages.en.bazarMonitoring.market_name, label_bn: i18n.messages.bn.bazarMonitoring.market_name, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.priceMonitoring.price_collection_date, label_bn: i18n.messages.bn.priceMonitoring.price_collection_date, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '18%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-left', show: '1', order: 7, thStyle: { width: '12%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        market_directory_id: 0,
        price_collection_date: 0,
        commodity_group_id: 0,
        commodity_name_id: 0,
        limit: 20
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      marketList: [],
      pauroshobaList: [],
      commodityNameList: [],
      item: '',
      detailsItemId: ''
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.marketList = this.getMarketDirectoryList(newVal)
      } else {
        this.upazilaList = []
        this.marketList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
        }
    },
    'search.commodity_group_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.search.commodity_name_id = 0
            this.commodityNameList = this.getCommodityNameList(newVal)
        } else {
            this.commodityNameList = []
        }
    }
  },
  computed: {
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    cityCorporationList: function () {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    commodityGroupList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
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
          { key: 'division_name_bn' },
          { key: 'district_name_bn' },
          { key: 'market_name_bn' },
          { key: 'price_collection_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'division_name' },
          { key: 'district_name' },
          { key: 'market_name_en' },
          { key: 'price_collection_date' },
          { key: 'status' },
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
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceUnpublishList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
            if (typeof divisionObj !== 'undefined') {
              divisionData.division_name = divisionObj.text_en
              divisionData.division_name_bn = divisionObj.text_bn
            } else {
              divisionData.division_name = ' '
              divisionData.division_name_bn = ' '
            }
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.district_id))
        const districtData = {}
          if (typeof districtObj !== 'undefined') {
            districtData.district_name = districtObj.text_en
            districtData.district_name_bn = districtObj.text_bn
          } else {
            districtData.district_name = ''
            districtData.district_name_bn = ''
          }
        const upazillaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazilla => upazilla.value === parseInt(item.upazila_id))
        const upazillaData = {}
          if (typeof upazillaObj !== 'undefined') {
              upazillaData.upazila_name = upazillaObj.text_en
              upazillaData.upazila_name_bn = upazillaObj.text_bn
          } else {
              upazillaData.upazila_name = ' '
              upazillaData.upazila_name_bn = ' '
          }
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === parseInt(item.market_directory_id))
        const marketData = {}
          if (typeof marketDirectoryObj !== 'undefined') {
              marketData.market_name_en = marketDirectoryObj.text_en
              marketData.market_name_bn = marketDirectoryObj.text_bn
          } else {
              marketData.market_name_en = ' '
              marketData.market_name_bn = ' '
          }
        const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(commodity => commodity.value === parseInt(item.commodity_group_id))
        const commodityGroupData = {}
          if (typeof commodityGroupObj !== 'undefined') {
              commodityGroupData.commodity_group_en = commodityGroupObj.text_en
              commodityGroupData.commodity_group_bn = commodityGroupObj.text_bn
          } else {
              commodityGroupData.commodity_group_en = ' '
              commodityGroupData.commodity_group_bn = ' '
          }
        const commodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(commodityName => commodityName.value === parseInt(item.commodity_name_id))
        const commodityNameData = {}
          if (typeof commodityNameObj !== 'undefined') {
              commodityNameData.commodity_name_en = commodityNameObj.text_en
              commodityNameData.commodity_name_bn = commodityNameObj.text_bn
          } else {
              commodityNameData.commodity_name_en = ' '
              commodityNameData.commodity_name_bn = ' '
          }
        const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(areaType => areaType.value === parseInt(item.area_type_id))
        const areaTypeData = {}
          if (typeof areaTypeObj !== 'undefined') {
              areaTypeData.area_type_en = areaTypeObj.text_en
              areaTypeData.area_type_bn = areaTypeObj.text_bn
          } else {
              areaTypeData.area_type_en = ''
              areaTypeData.area_type_bn = ''
          }
        const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(cityCorporation => cityCorporation.value === parseInt(item.city_corporation_id))
        const cityCOrporationData = {}
          if (typeof cityCorporationObj !== 'undefined') {
              cityCOrporationData.city_corporation_en = cityCorporationObj.text_en
              cityCOrporationData.city_corporation_bn = cityCorporationObj.text_bn
          } else {
              cityCOrporationData.city_corporation_en = ''
              cityCOrporationData.city_corporation_bn = ''
          }
        const pourosoabaObj = this.$store.state.CommonService.commonObj.municipalityList.find(pouroshova => pouroshova.value === parseInt(item.pauroshoba_id))
        const pouroshobaData = {}
          if (typeof pourosoabaObj !== 'undefined') {
              pouroshobaData.pourosova_name = pourosoabaObj.text_en
              pouroshobaData.pourosova_name_bn = pourosoabaObj.text_bn
          } else {
              pouroshobaData.pourosova_name = ''
              pouroshobaData.pourosova_name_bn = ''
          }
          return Object.assign({}, item, { serial: index }, divisionData, districtData, upazillaData, marketData, commodityGroupData, commodityNameData, areaTypeData, cityCOrporationData, pouroshobaData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getWardList (id) {
      return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getMarketDirectoryList (id) {
        return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.district_id === id)
    },
    getCommodityNameList (id) {
        return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    changeStatus (baseUrl, uri, item, destination = null, dropdownName = null) {
        Store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
            if (response.success) {
            if (destination !== null && dropdownName !== null) {
                Store.dispatch('toggleDropdownItemStatus', { itemId: item.id, destination: destination, dropdownName: dropdownName })
            }
            window.vm.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.$t('globalTrans.update_msg'),
                color: '#D6E09B'
            })
            } else {
                window.vm.$toast.error({
                title: 'Error',
                message: 'Operation failed! Please, try again.'
            })
            }
            Store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
        })
    },
    publishStatus (item) {
        window.vm.$swal({
            title: window.vm.$t('priceMonitoring.publish_status'),
            showCancelButton: true,
            confirmButtonText: window.vm.$t('globalTrans.yes'),
            cancelButtonText: window.vm.$t('globalTrans.no'),
            focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
             this.changeStatus(bazarMonitoringServiceBaseUrl, pricePublishUpdate, item)
            }
        })
    }
  }
}
</script>
