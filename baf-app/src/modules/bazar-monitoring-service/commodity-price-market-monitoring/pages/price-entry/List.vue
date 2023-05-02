<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.price') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('priceMonitoring.price') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <router-link  class="btn-add" to="form"><i class="ri-add-fill"></i>{{ $t('globalTrans.add_new') }}</router-link>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(price_collection_date)="data">
                    {{ data.item.price_collection_date | dateFormat }}
                  </template>
                  <template v-slot:cell(market_directory_ids)="data">
                    {{ getMarketDirectoryList(data.item.market_directory_ids) }}
                  </template>
                  <template v-slot:cell(no_of_cases)="data">
                    {{ $n(data.item.no_of_cases, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(inspection_date)="data">
                    {{ data.item.inspection_date| dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status == 2">{{$t('globalTrans.submitted')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('priceMonitoring.published')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" v-if="data.item.status == 1" variant=" iq-bg-success mr-1" :title="$t('globalTrans.edit')"  :to="`/bazar-monitoring-service/commodity-price-market-monitoring/form/${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>
                    <b-button class="action-btn btn-success" v-if="data.item.status == 1" @click="remove(data.item)" :title="$t('globalTrans.submit')" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" :title="$t('globalTrans.view')" :to="`/bazar-monitoring-service/commodity-price-market-monitoring/detail/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
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
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceEntryList, priceEntryTogle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        market_directory_id: 0,
        price_collection_date: '',
        divisionList: [],
        districtList: [],
        upazillaList: [],
        marketList: [],
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '10%' } },
        { labels: 'globalTrans.division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'bazarMonitoring.market_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'priceMonitoring.price_collection_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '18%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '12%' } }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      marketList: [],
      cityCorporationList: [],
      pauroshobaList: []
    }
  },
  created () {
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        area_type_id: this.addressCustomUser.area_type_id,
        city_corporation_id: this.addressCustomUser.city_corporation_id,
        pauroshoba_id: this.addressCustomUser.pauroshoba_id,
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_id: this.addressCustomUser.market_id,
        areaTypeList: JSON.stringify(this.loggedUserPrivilege.area_type_id),
        cityCorporationList: JSON.stringify(this.loggedUserPrivilege.city_corporation_id),
        pauroshobaList: JSON.stringify(this.loggedUserPrivilege.pauroshoba_id),
        divisionList: JSON.stringify(this.loggedUserPrivilege.division_id),
        districtList: JSON.stringify(this.loggedUserPrivilege.district_id),
        upazilaList: JSON.stringify(this.loggedUserPrivilege.upazila_id),
        marketList: JSON.stringify(this.loggedUserPrivilege.market_id)
      })
    }
    if (this.$store.state.Auth.activeRoleId === 1 || this.loggedUserPrivilege.area_type_id) {
      this.loadData()
    } else {
      this.$store.dispatch('setList', [])
    }
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.area_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketList = this.getAreaMarketList(newVal)
      } else {
        this.marketList = []
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.marketList = this.getDivMarketList(newVal)
      } else {
        this.districtList = []
        this.marketList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.marketList = this.getMarketDirectoryList(newVal)
        this.cityCorporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.marketList = []
        this.cityCorporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
        if (newVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
          this.marketList = this.getUpaMarketList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
          this.marketList = this.getDefaultMarketList(this.search)
        }
    },
    'search.commodity_group_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.search.commodity_name_id = 0
            this.commodityNameList = this.getCommodityNameList(newVal)
        } else {
            this.commodityNameList = []
        }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.marketList = this.getCityMarketList(newVal)
        } else {
          this.marketList = []
        }
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
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
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
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
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(bazarMonitoringServiceBaseUrl, priceEntryTogle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceEntryList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
          if (typeof divisionObj !== 'undefined') {
            divisionData.division_name = divisionObj.text_en
            divisionData.division_name_bn = divisionObj.text_bn
          } else {
            divisionData.division_name = ''
            divisionData.division_name_bn = ''
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
          return Object.assign({}, item, { serial: index + 0 }, divisionData, districtData, upazillaData, marketData, areaTypeData, cityCOrporationData, pouroshobaData)
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
    getAreaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === id)
    },
    getDivMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getCityMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getDefaultMarketList (data) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === data.area_type_id && item.division_id === data.division_id && item.district_id === data.district_id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    // remove (item) {
    //   this.changeStatus(3, bazarMonitoringServiceBaseUrl, priceEntryTogle, item)
    // }
    remove (item) {
      window.vm.$swal({
        title: window.vm.$t('globalTrans.statusChangeMsgPrice'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.changeStatus(3, bazarMonitoringServiceBaseUrl, priceEntryTogle, item)
        }
      })
    }
  }
}
</script>

<style>
.btn-success {
  background-color: var(--success) !important;
  border-color: var(--success);
}
</style>
