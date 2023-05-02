<template>
  <div class="inner-section">
    <card>
      <!-- formData section start -->
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
                    v-model="formData.area_type_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
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
                      v-model="formData.division_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
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
                      v-model="formData.district_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1">
              <ValidationProvider name="City Corporation" vid="city_corporation_id">
                  <b-form-group
                      label-for="city_corporation_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.city_corporation')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="formData.city_corporation_id"
                      :options="corporationList"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2 || formData.area_type_id === 3">
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
                    v-model="formData.upazila_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2">
              <ValidationProvider name="Pauroshoba" vid="pauroshoba_id">
                  <b-form-group
                      label-for="pauroshoba_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.pouroshova')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="formData.pauroshoba_id"
                      :options="pauroshobaList"
                      id="pauroshoba_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 3">
              <ValidationProvider name="Union" vid="union_id">
                  <b-form-group
                      label-for="union_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.union')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="formData.union_id"
                      :options="unionList"
                      id="union_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
              <ValidationProvider name="0" vid="ward_id">
                  <b-form-group
                      label-for="ward_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.ward')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="formData.ward_id"
                      :options="wardList"
                      id="ward_id"
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
              <ValidationProvider name="0" vid="market_directory_id">
                  <b-form-group
                      label-for="market_directory_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('bazarMonitoring.market_name')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="formData.market_directory_id"
                      :options="marketDirectoryList"
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
          <b-col sm="4">
            <b-form-group
              label-for="price_collection_date"
            >
              <template v-slot:label>
                {{ $t('priceMonitoring.price_collection_date') }}
              </template>
                <date-picker
                      id="price_collection_date"
                      v-model="formData.price_collection_date"
                      class="form-control"
                      :placeholder="$t('globalTrans.select')"
                      :locale="currentLocale"
                    >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Market" vid="market_directory_ids" rules="required|min_value:1">
                <b-form-group
                  label-for="market_directory_ids"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('bazarMonitoring.Price_category')}} <span class="text-danger">*</span>
                </template>
                  <v-select
                      id="price_category_id"
                      v-model="formData.price_category_id"
                      multiple
                      :reduce="op => op.value"
                      :options="priceCategoryList"
                      label="text"
                      :state="errors[0] ? false : (valid ? true : null)"
                  >
                  </v-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-button size="sm" variant="primary" class="mt-20" @click="formDataData">
              <i class="ri-formData-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- formData section end -->
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.price') }}  {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-table-simple style="width: 100%" hover small caption-top responsive bordered>
            <b-tr>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('globalTrans.sl_no') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.Price_category') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle">{{ $t('bazarMonitoring.lowest') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" >{{ $t('bazarMonitoring.highest') }}</b-th>
              <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('globalTrans.action') }}</b-th>
            </b-tr>
            <b-tr>
              <b-th style="width: 5%">{{ $t('bazarMonitoring.lowest') }}</b-th>
              <b-th style="width: 5%">{{ $t('bazarMonitoring.highest') }}</b-th>
            </b-tr>
            <template v-for="(item, index) in formData.details">
              <b-tr :key="index">
                <b-td></b-td>
                <b-td></b-td>
                <b-td></b-td>
                <b-td></b-td>
              </b-tr>
            </template>
          </b-table-simple>
          <pre>{{formData}}</pre>
          <pre>{{marketDirectoryList}}</pre>
        </b-overlay>
      </template>
    </body-card>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketDirectoryReportList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import AreaType from './AreaType'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    // AreaType
  },
  data () {
    return {
      sortBy: '',
      formData: {
        market_directory_id: 0,
        price_categorie_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        ward_id: 0,
        price_details: [
          {
            commodity_group_id: 0,
            commodity_name_id: 0,
            measurement_unit_id: 0,
            price_category: [
              {
                price_category_id: 0,
                lowest_price_amount: 0,
                lowest_price_percentage: 0,
                highest_price_amount: 0,
                highest_price_percentage: 0
              }
            ]
          }
        ]
      },
      editItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      unionList: [],
      wardList: [],
      pauroshobaList: []
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
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
    'formData.ward_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getWordMarketList(newVal)
      } else {
        this.marketDirectoryList = []
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
    currentLocale () {
      return this.$i18n.locale
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    formDataData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.formData)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketDirectoryReportList, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(areaType => areaType.value === parseInt(item.area_type_id))
          const areaTypeData = {}
          if (typeof areaTypeObj !== 'undefined') {
              areaTypeData.areaType_name = areaTypeObj.text_en
              areaTypeData.areaType_name_bn = areaTypeObj.text_bn
          } else {
              areaTypeData.areaType_name = ''
              areaTypeData.areaType_name_bn = ''
          }
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
          const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(dataItem => dataItem.value === parseInt(item.upazila_id))
          const upazilaData = {}
          if (typeof upazilaObj !== 'undefined') {
              upazilaData.upazila_name = upazilaObj.text_en
              upazilaData.upazila_name_bn = upazilaObj.text_bn
          } else {
              upazilaData.upazila_name = ''
              upazilaData.upazila_name_bn = ''
          }
          const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(dataItem => dataItem.value === parseInt(item.pauroshoba_id))
          const pauroshobaData = {}
          if (typeof pauroshobaObj !== 'undefined') {
              pauroshobaData.pauroshoba_name = pauroshobaObj.text_en
              pauroshobaData.pauroshoba_name_bn = pauroshobaObj.text_bn
          } else {
              pauroshobaData.pauroshoba_name = ''
              pauroshobaData.pauroshoba_name_bn = ''
          }
          const unionObj = this.$store.state.CommonService.commonObj.unionList.find(dataItem => dataItem.value === parseInt(item.union_id))
          const unionData = {}
          if (typeof unionObj !== 'undefined') {
              unionData.union_name = unionObj.text_en
              unionData.union_name_bn = unionObj.text_bn
          } else {
              unionData.union_name = ''
              unionData.union_name_bn = ''
          }
          const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(corporation => corporation.value === parseInt(item.city_corporation_id))
          const cityCorporationData = {}
          if (typeof cityCorporationObj !== 'undefined') {
              cityCorporationData.city_corporation = cityCorporationObj.text_en
              cityCorporationData.city_corporation_bn = cityCorporationObj.text_bn
          } else {
              cityCorporationData.city_corporation = ' '
              cityCorporationData.city_corporation_bn = ' '
          }
          return Object.assign({}, item, { serial: index + 1 }, areaTypeData, divisionData, districtData, cityCorporationData, upazilaData, pauroshobaData, unionData)
        })
        this.$store.dispatch('setList', listData)
      } else {
        this.$store.dispatch('setList', [])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
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
    }
  }
}
</script>
