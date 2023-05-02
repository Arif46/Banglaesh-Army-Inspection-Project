<template>
  <div class="inner-section">
    <b-row>
      <b-col md="12">
        <card>
              <!-- table section start -->
              <template v-slot:searchHeaderTitle>
                <h4 class="card-title">{{ $t('priceMonitoring.daily_price_chart') }}</h4>
              </template>
              <template v-slot:searchBody>
                <b-overlay :show="loading">
                  <template>
                    <b-row>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <ValidationProvider name="Date of Conviction" vid="date_of_conviction" rules="required" v-slot="{ errors }">
                          <b-form-group
                            label-for="date_of_conviction">
                            <template v-slot:label>
                              {{ $t('globalTrans.date') }}
                            </template>
                            <date-picker
                              id="date_of_conviction"
                              v-model="search.price_collection_date"
                              class="form-control"
                              :placeholder="$t('globalTrans.select')"
                              :locale="currentLocale"
                              :state="errors[0] ? false : (valid ? true : null)"
                            >
                            </date-picker>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                        <b-button size="sm" variant="primary" class="mt-20" @click="loadData">
                          <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                        </b-button>
                      </b-col>
                    </b-row>
                    <b-row class="mt-r">
                      <b-col>
                        <b-table-simple sticky-header class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                          <b-thead>
                            <b-tr>
                              <!-- <b-th style="width:5%; font-size: 14px;" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th> -->
                              <b-th style="width:10%; font-size: 14px;" class="text-center">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                              <b-th style="width:10%; font-size: 14px;" class="text-center">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                              <b-th style="width:10%; font-size: 14px;" class="text-center">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                              <b-th style="width:10%; font-size: 14px;" class="text-center">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
                              <template v-for="(division, index) in divisionList">
                                <b-th :key="index" style="font-size: 14px;" class="text-center">
                                  {{ ($i18n.locale === 'bn') ? division.text_bn : division.text_en }}
                                </b-th>
                              </template>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <slot v-if="datas.length>0">
                              <template v-for="(data) in datas">
                                <template v-for="(commodity, index1) in data.commodity">
                                  <b-tr v-for="(info, index2) in commodity.list" :key="index2">
                                    <slot v-if="index1 == 0 && index2 == 0">
                                      <!-- <b-td :rowspan="data.rowspan" class="text-center" style="font-size: 12px;">{{ $n(index + 1) }}</b-td> -->
                                      <b-td :rowspan="data.rowspan" class="text-center" style="font-size: 12px;">{{ ($i18n.locale === 'bn') ? data.commodity_group_bn : data.commodity_group }}</b-td>
                                    </slot>
                                    <slot v-if="index2 == 0">
                                      <b-td :rowspan="commodity.list.length" class="text-center" style="font-size: 12px;">{{ ($i18n.locale === 'bn') ? commodity.commodity_name_bn : commodity.commodity_name }}</b-td>
                                    </slot>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.price_category_bn : info.price_category }}</b-td>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.unit_name_bn : info.unit_name }}</b-td>
                                    <slot v-for="(division, index) in divisionList">
                                      <b-td :key="index" style="font-size: 14px;" class="text-center">
                                        {{ avgDivisionPrice(commodity.commodity_name_id, info.price_category_id, division.value) }}
                                      </b-td>
                                    </slot>
                                  </b-tr>
                                </template>
                              </template>
                            </slot>
                            <slot v-else>
                              <b-tr>
                                <b-th colspan=12 class="text-center text-danger">
                                  <br/>
                                  <h4>{{$t('globalTrans.noDataFound')}}</h4>
                                  <br/>
                                </b-th>
                              </b-tr>
                            </slot>
                          </b-tbody>
                        </b-table-simple>
                      </b-col>
                    </b-row>
                  </template>
                </b-overlay>
                <!-- <pre>{{datas}}</pre>
                <pre>{{divDatas}}</pre> -->
              </template>
        </card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { dailyPriceChartList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

const today = new Date().toISOString().substr(0, 10)
export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl,
      sortBy: '',
      search: {
        // price_collection_date: '2022-06-20',
        price_collection_date: today,
        division_id: '',
        limit: 20
      },
      editItemId: '',
      officer: {},
      sortDesc: true,
      sortDirection: 'desc',
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      wardList: [],
      pauroshobaList: [],
      datas: [],
      divDatas: [],
      testdatas: [],
      commodityNameList: [],
      priceCategoryListData: [],
      loading: false,
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      dateList: [],
      formData: {
        date_of_conviction: new Date().toISOString().substr(0, 10)
      }
    }
  },
  created () {
    this.loadData()
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        division_id: this.addressCustomUser.division_id,
        divisionList: JSON.stringify(this.loggedUserPrivilege.division_id)
      })
    }
    if (this.$store.state.Auth.activeRoleId === 1 || this.loggedUserPrivilege.area_type_id) {
      this.loadData()
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    currentLocale () {
      return this.$i18n.locale
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    commodityGroupList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    },
    frequencyTypeList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList
    },
    priceCategoryList: function () {
      const listObject = this.priceCategoryListData
      const tmpList = listObject.map((obj, index) => {
        if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn, text_en: obj.text_en, text_bn: obj.text_bn }
        } else {
            return { value: obj.value, text: obj.text_en, text_en: obj.text_en, text_bn: obj.text_bn }
        }
      })
      return tmpList
    }
  },
  watch: {
    // 'search.limit': function (newVal, oldVal) {
    //   if (newVal !== oldVal) {
    //     this.loadData()
    //   }
    // },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.marketDirectoryList = this.getDivMarketList(newVal)
      } else {
        this.districtList = []
        this.marketDirectoryList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
        this.marketDirectoryList = this.getDisMarketList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
        this.marketDirectoryList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
        this.marketDirectoryList = this.getUpaMarketList(newVal)
      } else {
        this.unionList = []
        this.pauroshobaList = []
        this.marketDirectoryList = []
      }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getCityMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getPauroMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'search.union_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getUniMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    }
  },
  methods: {
    avgDivisionPrice (commodityNameId, priceCategoryId, divisionId) {
      let divAverage = 0
      const divObj = this.divDatas.find(data => data.commodity_name_id === parseInt(commodityNameId) && data.price_category_id === parseInt(priceCategoryId) && data.division_id === parseInt(divisionId))
      if (typeof divObj !== 'undefined') {
        divAverage = this.$n(divObj.average_price.toFixed(2))
      } else {
        divAverage = 0
      }
      return divAverage
    },
    checkAllRowSpan (datas) {
      let total = 0
      datas.forEach((element, key) => {
        element.list.forEach((element1, key) => {
          total++
        })
      })
      return total
    },
    async loadData () {
      this.loading = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, dailyPriceChartList, params)
      if (result.success) {
        this.loading = false
        this.search.frequency_type_id_check = this.search.frequency_type_id
        this.divDatas = result.divDatas
        this.datas = result.data.map((item) => {
          const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(data => data.value === parseInt(item.commodity_group_id))
          const commodityGroupData = {}
          if (typeof commodityGroupObj !== 'undefined') {
            commodityGroupData.commodity_group = commodityGroupObj.text_en
            commodityGroupData.commodity_group_bn = commodityGroupObj.text_bn
          } else {
            commodityGroupData.commodity_group = ''
            commodityGroupData.commodity_group_bn = ''
          }
          commodityGroupData.rowspan = this.checkAllRowSpan(item.commodity)
          item.commodity = item.commodity.map((item1) => {
            const commodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(data2 => data2.value === parseInt(item1.commodity_name_id))
            const commodityNameData = {}
            if (typeof commodityNameObj !== 'undefined') {
              commodityNameData.commodity_name = commodityNameObj.text_en
              commodityNameData.commodity_name_bn = commodityNameObj.text_bn
            } else {
              commodityNameData.commodity_name = ''
              commodityNameData.commodity_name_bn = ''
            }
            item1.list = item1.list.map((item2) => {
              const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === parseInt(item2.price_category_id))
              const priceCategoryData = {}
              if (typeof priceCategoryObj !== 'undefined') {
                priceCategoryData.price_category = priceCategoryObj.text_en
                priceCategoryData.price_category_bn = priceCategoryObj.text_bn
              } else {
                priceCategoryData.price_category = ''
                priceCategoryData.price_category_bn = ''
              }
              const measurementUnitObj = this.$store.state.BazarMonitoringService.commonObj.unitList.find(unit => unit.value === parseInt(item2.measurement_unit_id))
              const unitData = {}
              if (typeof measurementUnitObj !== 'undefined') {
                unitData.unit_name = measurementUnitObj.text_en
                unitData.unit_name_bn = measurementUnitObj.text_bn
              } else {
                unitData.unit_name = ''
                unitData.unit_name_bn = ''
              }
              // const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item2.division_id))
              // const divisionData = {}
              // if (typeof divisionObj !== 'undefined') {
              //   divisionData.div_average += item2.average_price
              // } else {
              //   divisionData.div_average = 0
              // }
              // const divisionObj = this.$store.state.CommonService.commonObj.divisionList.map((divData) => {
              //   const divisionData = {}
              //   if (divData.value === item2.division_id) {
              //     divisionData.divAverage += item2.average_price
              //   } else {
              //     divisionData.divAverage = 0
              //   }
              //   return Object.assign({}, divData, divisionData)
              // })
              return Object.assign({}, item2, priceCategoryData, unitData)
            })
            return Object.assign({}, item1, commodityNameData)
          })
          return Object.assign({}, item, commodityGroupData)
        })
        this.loading = false
        this.$store.dispatch('setList', this.datas)
        this.dateList = result.dateList
      } else {
        this.dateList = []
        this.datas = []
        this.loading = false
        this.$store.dispatch('setList', [])
      }
      this.loading = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getDivMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.division_id === id)
    },
    getDisMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUpaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getUniMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.union_id === id)
    },
    getPauroMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.pauroshoba_id === id)
    },
    getCityMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getCommodityNameList (id) {
        return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    getTotalFineAmount (sections) {
      let totalAmount = 0
      sections.forEach(item => {
        totalAmount += item.fine_amount
      })
      return totalAmount
    }
  }
}
</script>
