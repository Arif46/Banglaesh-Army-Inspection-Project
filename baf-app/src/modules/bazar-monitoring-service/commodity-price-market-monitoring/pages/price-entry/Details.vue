<template>
  <div class="inner-section">
    <card>
      <!-- formData section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.product_details') }}</h4>
      </template>
      <template v-slot:searchHeaderAction>
        <a href="javascript:" class="btn-add mr-2" @click="pdfExport">
          {{ $t('globalTrans.print') }}
        </a>
        <router-link class="btn-add" to="/bazar-monitoring-service/commodity-price-market-monitoring/price-entry"><i class="ri-arrow-left-line"></i> {{ $t('priceMonitoring.price') }} {{ $t('globalTrans.list') }}</router-link>
      </template>
      <template v-slot:searchBody>
        <b-overlay :show="loadingState">
           <template>
              <b-row>
                <b-col lg="12" sm="12">
                  <div>
<!--                    <b-table-simple striped bordered small>-->
<!--                      <b-tr>-->
<!--                        <b-th width="20%">{{ $t('globalTrans.division') }}</b-th>-->
<!--                        <b-td width="30%">-->
<!--                          {{ getColumnName($store.state.CommonService.commonObj.divisionList,'value', formData.division_id) }}-->
<!--                        </b-td>-->
<!--                        <b-th width="20%">{{ $t('globalTrans.district') }}</b-th>-->
<!--                        <b-td width="30%">-->
<!--                          {{ getColumnName($store.state.CommonService.commonObj.districtList,'value', formData.district_id) }}-->
<!--                        </b-td>-->
<!--                      </b-tr>-->
<!--                      <b-tr>-->
<!--                        <b-th>{{ $t('bazarMonitoring.market_name') }}</b-th>-->
<!--                        <b-td>{{ getColumnName($store.state.BazarMonitoringService.commonObj.marketDirectoryList,'value', formData.market_directory_id) }}</b-td>-->
<!--                        <b-th>{{ $t('priceMonitoring.price_collection_date') }}</b-th>-->
<!--                        <b-td>{{ formData.price_collection_date | dateFormat }}</b-td>-->
<!--                      </b-tr>-->
<!--                    </b-table-simple>-->

                    <b-table-simple striped bordered small>
                      <b-tr>
                        <b-th width="20%">{{ $t('globalTrans.division') }}</b-th>
                        <b-td width="30%">
                          {{ getColumnName($store.state.CommonService.commonObj.divisionList,'value', formData.division_id) }}
                        </b-td>
                        <b-th width="20%">{{ $t('bazarMonitoring.market_name') }}</b-th>
                        <b-td width="30%">{{ getColumnName($store.state.BazarMonitoringService.commonObj.marketDirectoryList,'value', formData.market_directory_id) }}</b-td>
                      </b-tr>
                      <b-tr>
                        <b-th>{{ $t('globalTrans.district') }}</b-th>
                        <b-td>
                          {{ getColumnName($store.state.CommonService.commonObj.districtList,'value', formData.district_id) }}
                        </b-td>
                        <b-th>{{ $t('priceMonitoring.price_collection_date') }}</b-th>
                        <b-td>{{ formData.price_collection_date | dateFormat }}</b-td>
                      </b-tr>
                    </b-table-simple>
                  </div>
                </b-col>
                </b-row>
              </template>
              <body-card v-if="formData.price_details.length">
                <template v-slot:headerTitle>
                  <h4 class="card-title">{{ $t('priceMonitoring.price_list_details') }}</h4>
                </template>
                <template v-slot:body>
                  <div class="table-wrapper">
                    <b-table-simple hover small responsive bordered>
                      <b-tr style="background: #f3f3f3">
                        <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('globalTrans.sl_no') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" colspan="2" class="text-center">{{ $t('bazarMonitoring.lowest') }}</b-th>
                        <b-th style="width: 5%; vertical-align:middle" colspan="2" class="text-center">{{ $t('bazarMonitoring.highest') }}</b-th>
                      </b-tr>
                      <b-tr style="background: #e9e9e9; text-align: center">
                        <b-th style="width: 5%">{{ $t('bazarMonitoring.lowest') }}</b-th>
                        <b-th style="width: 5%">
                          <i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>
                        </b-th>
                        <b-th style="width: 5%">{{ $t('bazarMonitoring.highest') }}</b-th>
                        <b-th style="width: 5%">
                          <i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>
                        </b-th>
                      </b-tr>
                      <template v-for="(item, index) in formData.price_details">
                        <template v-for="(item1, index1) in item.price_category">
                          <b-tr :key="index + '_' + index1">
                            <b-td style="vertical-align:middle" v-if="index1 === 0" :rowspan="item.price_category.length">{{ $n(index+1) }}</b-td>
                            <b-td style="vertical-align:middle" v-if="index1 === 0" :rowspan="item.price_category.length">
                              {{ getColumnName(commodityGroupList,'value', item.commodity_group_id) }}
                            </b-td>
                            <b-td style="vertical-align:middle" v-if="index1 === 0" :rowspan="item.price_category.length">
                              {{ getColumnName($store.state.BazarMonitoringService.commonObj.commodityNameList,'value', item.commodity_name_id) }}
                            </b-td>
                            <b-td style="vertical-align:middle" v-if="index1 === 0" :rowspan="item.price_category.length">
                              {{ getColumnName($store.state.BazarMonitoringService.commonObj.unitList,'value', item.measurement_unit_id) }}
                            </b-td>
                            <b-td>{{ ($i18n.locale==='bn') ? item1.text_bn : item1.text_en }}</b-td>
                            <b-td>
                              {{ $n(item1.lowest_price_amount) }}
                            </b-td>
                            <b-td>{{ $n(item1.lowest_price_percentage)}}</b-td>
                            <b-td>
                              {{ $n(item1.highest_price_amount) }}
                            </b-td>
                            <b-td>{{ $n(item1.highest_price_percentage)}}</b-td>
                          </b-tr>
                        </template>
                      </template>
                    </b-table-simple>
                  </div>
                </template>
              </body-card>
        </b-overlay>
      </template>
    </card>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { pricepriceSearch, marketDirectoryCategory } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
const today = new Date().toISOString().substr(0, 10)
export default {
  mixins: [ModalBaseMasterList],
  components: {
    // AreaType
  },
  data () {
    return {
      formData: {
        id: 0,
        market_directory_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        ward_id: 0,
        price_collection_date: today,
        price_category_id: [],
        commodity_name: {
          commodity_group_id: 0,
          commodity_name_id: 0,
          measurement_unit_id: 0
        },
        priceCategory: [],
        price_details: []
      },
      editItemId: '',
      sortDesc: true,
      commodityName: false,
      sortDirection: 'desc',
      labelData: [],
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      wardList: [],
      commodityNameList: [],
      unitList: [],
      prevData: [],
      pauroshobaList: [],
      percentage: 10,
      priceCategoryListData: []
    }
  },
  created () {
    const loadingState = { loading: false, listReload: false }
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (this.$route.params.id) {
      this.loadData()
    }
  },
  watch: {
    'formData.area_type_id': function (newVal, oldVal) {
    },
    'formData.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'formData.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'formData.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
        }
    },
    'formData.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
        } else {
          this.wardList = []
        }
    },
    'formData.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getPauroMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'formData.union_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.wardList = this.getWardList(newVal)
        this.marketDirectoryList = this.getUniMarketList(newVal)
      } else {
        this.wardList = []
        this.marketDirectoryList = []
      }
    },
    'formData.market_directory_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getPriceCategory(newVal)
      } else {
        this.priceCategoryList = []
      }
    },
    'formData.ward_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getWordMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'formData.commodity_name.commodity_group_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.commodityNameList = this.getCommodityNameList(newVal)
        this.unitList = this.getMeasurementUnit(newVal)
      } else {
        this.commodityNameList = []
        this.unitList = []
      }
    },
    'formData.commodity_name.measurement_unit_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getCategoryWiseCommodity(newVal)
      } else {
      }
    }
  },
  computed: {
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
    },
    commodityGroupList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
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
    currentLocale () {
      return this.$i18n.locale
    },
    // priceCategoryList () {
    //   return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    // },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    removeItem (index, data) {
      this.formData.price_details.splice(index, 1)
    },
    async getPriceCategory (id) {
      const params = Object.assign({}, { market_directory_id: id })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketDirectoryCategory, params)
      if (result.success) {
        this.formData.price_category_id = []
        const categoryList = []
        const listData = result.data.map((item, index) => {
          const priceCategoryListObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(areaType => areaType.value === parseInt(item.price_category_id))
          const priceCategoryData = {}
          if (typeof priceCategoryListObj !== 'undefined') {
              priceCategoryData.text_en = priceCategoryListObj.text_en
              priceCategoryData.text_bn = priceCategoryListObj.text_bn
              priceCategoryData.value = priceCategoryListObj.value
          }
          categoryList.push(item.price_category_id)
          return Object.assign({}, item, priceCategoryData)
        })
        this.priceCategoryListData = listData
        this.formData.price_category_id = categoryList
      }
    },
    getCategoryWiseCommodity () {
      const priceDataList = []
      this.formData.price_category_id.map((item, index) => {
        const priceData = {
          id: 0,
          commodity_group_id: this.formData.commodity_name.commodity_group_id,
          commodity_name_id: this.formData.commodity_name.commodity_name_id,
          measurement_unit_id: this.formData.commodity_name.measurement_unit_id,
          lowest_price_amount: 0,
          lowest_price_percentage: 0,
          highest_price_amount: 0,
          highest_price_percentage: 0
        }
        const priceCat = this.priceCategoryList.find(item1 => item1.value === item)
        priceData.text_en = typeof priceCat !== 'undefined' ? priceCat.text_en : ''
        priceData.text_bn = typeof priceCat !== 'undefined' ? priceCat.text_bn : ''
        priceData.price_category_id = typeof priceCat !== 'undefined' ? priceCat.value : 0
        priceDataList.push(priceData)
      })
      this.formData.priceCategory = priceDataList
    },
    priceCategoryCustomize () {
      const listData = this.priceCategoryList.map((item, index) => {
        const priceData = {
          lowest_price_amount: 0,
          lowest_price_percentage: 0,
          highest_price_amount: 0,
          highest_price_percentage: 0
        }
        return Object.assign({}, item, priceData)
      })
      this.formData.priceCategory = listData
    },
    commodityReset () {
      this.formData.commodity_name = {
        commodity_group_id: 0,
        commodity_name_id: 0,
        measurement_unit_id: 0
      }
      this.formData.priceCategory = []
      this.$refs.form.reset()
    },
    async loadData () {
      let params = {}
      if (this.formData.market_directory_id && this.formData.price_collection_date) {
        params = {
          market_directory_id: this.formData.market_directory_id,
          price_collection_date: this.formData.price_collection_date
        }
      }
      if (this.$route.params.id) {
        params = {
          id: this.$route.params.id
        }
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, pricepriceSearch, params)
      if (result.success) {
        if (this.$route.params.id) {
          this.formData.id = this.$route.params.id
        } else {
          this.formData.id = result.data.id
        }
        this.formData.area_type_id = result.data.area_type_id
        this.formData.city_corporation_id = result.data.city_corporation_id
        this.formData.pauroshoba_id = result.data.pauroshoba_id
        this.formData.division_id = result.data.division_id
        this.formData.district_id = result.data.district_id
        this.formData.upazila_id = result.data.upazila_id
        this.formData.ward_id = result.data.ward_id
        this.formData.market_directory_id = result.data.market_directory_id
        this.formData.price_collection_date = result.data.price_collection_date
        if (this.$route.params.id) {
          this.formData.price_category_id = result.data.price_category_id
        }
        const commodityNames = this.getCustomDataList(result.data.commodity_names, false)
        this.formData.price_details = commodityNames
      } else {
        this.formData.id = 0
        this.formData.price_details = []
        if (result.data) {
          const commodityNames = this.getCustomDataList(result.data.commodity_names, true)
          this.formData.price_details = commodityNames
        }
      }
      this.prevData = result.prevData
      this.commodityName = true
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getCustomDataList (data, zeroVal) {
      const commodityNames = data.map((item, index) => {
        const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(item => parseInt(item.value) === parseInt(item.commodity_group_id))
        const commodityGroupData = {}
        if (typeof commodityGroupObj !== 'undefined') {
            commodityGroupData.commodity_group_name = commodityGroupObj.text_en
            commodityGroupData.commodity_group_name_bn = commodityGroupObj.text_bn
        } else {
            commodityGroupData.commodity_group_name = ''
            commodityGroupData.commodity_group_name_bn = ''
        }
        const itemCheck = []
        item.price_category.forEach((item1, index1) => {
          this.formData.price_category_id.map((item2, index2) => {
            if (zeroVal) {
              item1.highest_price_percentage = 0
              item1.lowest_price_percentage = 0
            }
            if (parseInt(item2) === parseInt(item1.price_category_id)) {
              const priceCat = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(item3 => parseInt(item3.value) === parseInt(item1.price_category_id))
              item1.text_en = typeof priceCat !== 'undefined' ? priceCat.text_en : ''
              item1.text_bn = typeof priceCat !== 'undefined' ? priceCat.text_bn : ''
              itemCheck.push(item1)
            }
          })
        })
        return Object.assign({}, item, commodityGroupData, { price_category: itemCheck })
      })
      return commodityNames
    },
    getMarketDirectoryList (marketIds) {
        const arr = []
        if (marketIds.constructor === Array) {
            marketIds.forEach(item => {
              const marketId = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(obj => obj.value === item)
              const marketName = this.currentLocale === 'en' ? ' ' + marketId.text_en : ' ' + marketId.text_bn
              arr.push(marketName)
            })
        }
        return arr.toString()
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
    getWardList (id) {
      return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getAreaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === id)
    },
    getUpaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getUniMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.union_id === id)
    },
    getWordMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.ward_id === id)
    },
    getMeasurementUnit (id) {
      const unitData = this.$store.state.BazarMonitoringService.commonObj.unitList.filter(item => item.status === 1 && item.commodity_group_id === id)
      if (unitData.length > 0) {
        this.formData.commodity_name.measurement_unit_id = unitData[0].value
      }
      return unitData
    },
    getCommodityNameList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    getColumnName (list, field, groupId) {
      const obj = list.find(item => item[field] === groupId)
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return obj.text_bn
        } else {
          return obj.text_en
        }
      } else {
        return ''
      }
    },
    setAvgPercentage (item, selectField, increaseField, commodityNameId, priceCategoryId) {
      if (this.prevData) {
        const prevCommodity = this.prevData.find(i => i.commodity_name_id === parseFloat(commodityNameId) && parseInt(i.price_category_id) === parseFloat(priceCategoryId))
        if (typeof prevCommodity !== 'undefined') {
          if (prevCommodity[selectField] > 0) {
            const newPercentage = this.calculatePercentage(prevCommodity[selectField], item[selectField])
            item[increaseField] = parseFloat(newPercentage).toFixed(2)
          }
        }
      }
    },
    calculatePercentage (oldAvg, newAvg) {
      const diffAmt = parseFloat(newAvg) - parseFloat(oldAvg)
      const totalPercentage = (100 * diffAmt) / parseFloat(oldAvg)
      return totalPercentage
    },
    async pdfExport () {
      const params = Object.assign({ id: this.$route.params.id, request_type: 'pdf', local: this.$i18n.locale, org_id: 11 })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(bazarMonitoringServiceBaseUrl, pricepriceSearch, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
<style>
.btn-success {
  background-color: var(--success) !important;
  border-color: var(--success);
}
.btn-danger {
  color: #fff;
  background-color: #dc3545 !important;
  border-color: #dc3545 !important;
}
.form-control {
  background-color: #f2f2f2 !important;
}
</style>
