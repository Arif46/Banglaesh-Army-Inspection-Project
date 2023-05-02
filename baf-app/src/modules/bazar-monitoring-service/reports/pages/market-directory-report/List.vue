<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.market_directory_report') }}</h4>
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
                      v-model="search.city_corporation_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 2">
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
                      v-model="search.pauroshoba_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 3">
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
                      v-model="search.union_id"
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
          <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.area_type_id === 1 || search.area_type_id === 2 || search.area_type_id === 3">
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
                      v-model="search.ward_id"
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
          </b-col> -->
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
                      v-model="search.market_directory_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="0" vid="price_categorie_id">
                  <b-form-group
                      label-for="price_categorie_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('bazarMonitoring.Price_category_name')}}
                  </template>
                  <b-form-select
                      plain
                      v-model="search.price_categorie_id"
                      :options="priceCategoryList"
                      id="price_categorie_id"
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
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('report.market_directory_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <!-- <b-button @click="pdfExport" class="btn-add">
                  {{  $t('globalTrans.print') }}
                </b-button> -->
                <a href="javascript:" class="btn-add" @click="pdfExport">
                   {{ $t('globalTrans.print') }}
                </a>
                <!-- <a href="javascript:" class="btn-add" @click="pdfExport" v-b-modal.modal-form><i class="fas fa-print"></i> {{  $t('globalTrans.print') }}</a> -->
                <export-excel
                  class="btn-add ml-2"
                  :data="excelData"
                  :title="headerValue"
                  :fields=excelFields
                  worksheet="Report Sheet"
                  :default-value="headerExcelDefault"
                  name="market_directory_report.xls">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel>
              </template>
              <template v-slot:body>
                <b-overlay :show="loadingState">
                  <!-- <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" /> -->
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('report.market_directory_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black mb-4">
                      <b-row>
                        <b-col md="4">
                          {{ $t('globalTrans.division') }}: <strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3">
                          {{ $t('globalTrans.district') }}: <strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="5" v-if="search.area_type_id === 1">
                          {{ $t('globalTrans.city_corporation') }}: <strong>{{ search.city_corporation_id  ?  ($i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="5" v-if="search.area_type_id === 2 || search.area_type_id === 3">
                          {{ $t('globalTrans.upazila') }}: <strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </b-row>
                      <b-row>
                        <b-col md="4">
                          {{ $t('bazarMonitoring.Price_category_name') }}: <strong>{{ search.price_categorie_id  ?  ($i18n.locale === 'en' ? searchHeaderData.priceCategory_name_en : searchHeaderData.priceCategory_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="4">
                          {{ $t('bazarMonitoring.market_name') }}: <strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="4" v-if="search.area_type_id === 2">
                          {{ $t('globalTrans.pouroshova') }}: <strong>{{ search.pauroshoba_id ? ($i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="4" v-if="search.area_type_id === 3">
                          {{ $t('globalTrans.union') }}: <strong>{{ search.union_id ? ($i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </b-row>
                    </div>
                    <div v-for="(infoData, parentIndex) in datas" :key="parentIndex">
                      <h4 class="mb-1" style="font-size:1rem"><b>{{ $t('globalTrans.division') }} : {{ $i18n.locale === 'en' ? infoData.division_name : infoData.division_name_bn }}</b></h4>
                      <div v-for="(infoData1, parentIndex1) in infoData.district_info" :key="parentIndex1">
                        <h6 class="mb-1"  style="font-size:0.95rem"><b>{{ $t('globalTrans.district') }} : {{ $i18n.locale === 'en' ? infoData1.district_name : infoData1.district_name_bn }}</b></h6>
                        <div v-for="(infoData2, parentIndex2) in infoData1.city_upazila_info" :key="parentIndex2">
                          <h6 style="font-size:0.85rem" v-if="infoData2.city_corporation_id"><b>{{ $t('globalTrans.city_corporation') }} : {{ $i18n.locale === 'en' ? infoData2.city_corporation : infoData2.city_corporation_bn }}</b></h6>
                          <h6 style="font-size:0.8rem" v-if="infoData2.upazila_id"><b>{{ $t('globalTrans.upazila') }} : {{ $i18n.locale === 'en' ? infoData2.upazila_name : infoData2.upazila_name_bn }}</b></h6>
                          <div class="table-responsive">
                            <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                              <b-thead>
                                <b-tr>
                                  <b-th style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                  <b-th style="width:15%" class="text-center">{{ $t('bazarMonitoring.market_name') }}</b-th>
                                  <b-th style="width:15%" class="text-center">{{ $t('orgProfile.thana') }}</b-th>
                                  <b-th style="width:30%" class="text-center">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                                  <b-th style="width:15%" class="text-center">{{ $t('bazarMonitoring.commodity_stall') }}</b-th>
                                </b-tr>
                              </b-thead>
                              <b-tbody>
                                <b-tr v-for="(info, index) in infoData2.market_info" :key="index">
                                  <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                  <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.market_name_bn : info.market_name_en }}</b-td>
                                  <b-td class="text-center">{{ getThanaName(info.thana_id) }}</b-td>
                                  <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.categories_bn : info.categories }}</b-td>
                                  <b-td class="text-center">{{ $n(info.essential_commodity_stall) }}</b-td>
                                </b-tr>
                              </b-tbody>
                            </b-table-simple>
                          </div>
                        </div>
                      </div>
                    </div>
                  </template>
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketDirectoryReportList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
// import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
// import axios from 'axios'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList, bazarMonitoringServiceMixin],
  components: {
    ListReportHead
  },
  data () {
    return {
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl,
      sortBy: '',
      search: {
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
        limit: 20
      },
      editItemId: '',
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
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        aria_name: '',
        aria_name_bn: '',
        market_name_bn: '',
        market_name_en: '',
        priceCategory_name_en: '',
        priceCategory_name_bn: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: ''
      },
      showData: false
    }
  },
  created () {
    // this.listData = this.labelList
    // this.loadData()
  },
  mounted () {
    this.headerDataExcel()
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
    // if (this.$store.state.Auth.activeRoleId === 1 || this.loggedUserPrivilege.area_type_id) {
    //   this.loadData()
    // }
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.area_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getAreaMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
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
        if (newVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
          this.marketDirectoryList = this.getUpaMarketList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
          this.marketDirectoryList = this.getDefaultMarketList(this.search)
        }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getCityMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getPauroMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'search.union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getUniMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
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
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report.market_directory_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.market_directory_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      }
      const division = this.$t('globalTrans.division') + ' : ' + (this.search.division_id ? (local === 'en' ? this.searchHeaderData.division_name : this.searchHeaderData.division_name_bn) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const district = ' ' + ' ' + this.$t('globalTrans.district') + ' : ' + (this.search.district_id ? (local === 'en' ? this.searchHeaderData.district_name : this.searchHeaderData.district_name_bn) : this.$t('globalTrans.all')) + ';   '
      let hedearVal = ''
      hedearVal = division + district
      if (this.search.area_type_id === 1) {
        const cityCorporation = this.$t('globalTrans.city_corporation') + ' : ' + (this.search.city_corporation_id ? (local === 'en' ? this.searchHeaderData.city_corporation_name : this.searchHeaderData.city_corporation_name_bn) : this.$t('globalTrans.all')) + ' ' + ';  '
        hedearVal = hedearVal + cityCorporation
      }
      if (this.search.area_type_id === 2 || this.search.area_type_id === 3) {
        const upazila = this.$t('globalTrans.upazila') + ' : ' + (this.search.upazila_id ? (local === 'en' ? this.searchHeaderData.upazila_name : this.searchHeaderData.upazila_name_bn) : this.$t('globalTrans.all')) + ';  '
        hedearVal = hedearVal + upazila
      }
      if (this.search.area_type_id === 2) {
        const pouroshova = this.$t('globalTrans.pouroshova') + ' : ' + (this.search.pauroshoba_id ? (local === 'en' ? this.searchHeaderData.pauroshoba_name : this.searchHeaderData.pauroshoba_name_bn) : this.$t('globalTrans.all')) + ';  '
        hedearVal = hedearVal + pouroshova
      }
      if (this.search.area_type_id === 3) {
        const unionName = this.$t('globalTrans.union') + ' : ' + (this.search.union_id ? (local === 'en' ? this.searchHeaderData.union_name : this.searchHeaderData.union_name_bn) : this.$t('globalTrans.all')) + ';  '
        hedearVal = hedearVal + unionName
      }
      headerVal[5] = hedearVal
      const PriceCategoryName = this.$t('bazarMonitoring.Price_category_name') + ' : ' + (this.search.price_categorie_id ? (local === 'en' ? this.searchHeaderData.priceCategory_name_en : this.searchHeaderData.priceCategory_name_bn) : this.$t('globalTrans.all')) + ';   '
      const market = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id ? (local === 'en' ? this.searchHeaderData.market_name_en : this.searchHeaderData.market_name_bn) : this.$t('globalTrans.all'))
      headerVal[6] = PriceCategoryName + market
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          ' ': 'space',
          'ক্রমিক নং': 'serial',
          'বাজারের নাম': 'market_name',
          'থানা ': 'thana',
          'মূল্য বিভাগ ': 'price_category',
          'নিত্যপ্রয়োজনীয় পণ্যের স্টল ': 'e_commidity_stall'
        }
      } else {
        return {
          ' ': 'space',
          'SL No': 'serial',
          'Market Name ': 'market_name',
          'Thana ': 'thana',
          'Price Category ': 'price_category',
          'Essential Commodity Stall ': 'e_commidity_stall'
        }
      }
    },
    excelData: function () {
      const excelData = []
      this.datas.forEach((infoData, firstIndex) => {
        const divName = this.$t('globalTrans.division') + ':' + (this.currentLocale === 'en' ? infoData.division_name : infoData.division_name_bn)
        excelData.push({
          space: divName,
          serial: ' ',
          market_name: ' ',
          thana: ' ',
          price_category: ' ',
          e_commidity_stall: ' '
        })
        infoData.district_info.forEach((infoData1) => {
          const disName = this.$t('globalTrans.district') + ':' + (this.currentLocale === 'en' ? infoData1.district_name : infoData1.district_name_bn)
          excelData.push({
            space: disName,
            serial: ' ',
            market_name: ' ',
            thana: ' ',
            price_category: ' ',
            e_commidity_stall: ' '
          })
          infoData1.city_upazila_info.forEach((infoData2) => {
            let cityUpazila = []
            if (infoData2.city_corporation_id) {
              cityUpazila = this.$t('globalTrans.city_corporation') + ':' + (this.currentLocale === 'en' ? infoData2.city_corporation : infoData2.city_corporation_bn)
            }
            if (infoData2.upazila_id) {
              cityUpazila = this.$t('globalTrans.upazila') + ':' + (this.currentLocale === 'en' ? infoData2.upazila_name : infoData2.upazila_name_bn)
            }
            excelData.push({
              space: cityUpazila,
              serial: ' ',
              market_name: ' ',
              thana: ' ',
              price_category: ' ',
              e_commidity_stall: ' '
            })
            infoData2.market_info.forEach((info, index) => {
              excelData.push({
                space: ' ',
                serial: this.$n(index + 1),
                market_name: (this.currentLocale === 'en' ? info.market_name_en : info.market_name_bn),
                thana: (info.thana_id ? this.getThanaName(info.thana_id) : ' '),
                price_category: (this.currentLocale === 'en' ? info.categories : info.categories_bn),
                e_commidity_stall: this.$n(info.essential_commodity_stall)
              })
            })
          })
        })
      })
      return excelData
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
    formTitle () {
      return (this.editItemId === 0) ? this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.entry') : this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.modify')
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
    headerDataExcel () {
      RestApi.getData(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail/' + this.orgId).then(response => {
      if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === this.orgId)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          this.headerExcelDefault.orgName = orgName
          this.headerExcelDefault.orgNameBn = orgNameBn
          this.headerExcelDefault.address = response.data.address
          this.headerExcelDefault.address_bn = response.data.address_bn
        }
      })
    },
    async pdfExport () {
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: this.orgId }, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(bazarMonitoringServiceBaseUrl, marketDirectoryReportList, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.area_type_id) {
        const ariaTypeObj = this.$store.state.commonObj.areaTypeList.find(data => data.value === this.search.area_type_id)
        this.searchHeaderData.aria_name = ariaTypeObj !== undefined ? ariaTypeObj.text_en : ''
        this.searchHeaderData.aria_name_bn = ariaTypeObj !== undefined ? ariaTypeObj.text_bn : ''
      }
      if (this.search.market_directory_id) {
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === this.search.market_directory_id)
        this.searchHeaderData.market_name_en = marketDirectoryObj !== undefined ? marketDirectoryObj.text_en : ''
        this.searchHeaderData.market_name_bn = marketDirectoryObj !== undefined ? marketDirectoryObj.text_bn : ''
      }
      if (this.search.price_categorie_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === this.search.price_categorie_id)
        this.searchHeaderData.priceCategory_name_en = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.priceCategory_name_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      if (this.search.division_id) {
        const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === this.search.division_id)
        this.searchHeaderData.division_name = divisionObj !== undefined ? divisionObj.text_en : ''
        this.searchHeaderData.division_name_bn = divisionObj !== undefined ? divisionObj.text_bn : ''
      }
      if (this.search.district_id) {
        const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === this.search.district_id)
        this.searchHeaderData.district_name = districtObj !== undefined ? districtObj.text_en : ''
        this.searchHeaderData.district_name_bn = districtObj !== undefined ? districtObj.text_bn : ''
      }
      if (this.search.city_corporation_id) {
        const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(data => data.value === this.search.city_corporation_id)
        this.searchHeaderData.city_corporation_name = cityCorporationObj !== undefined ? cityCorporationObj.text_en : ''
        this.searchHeaderData.city_corporation_name_bn = cityCorporationObj !== undefined ? cityCorporationObj.text_bn : ''
      }
      if (this.search.upazila_id) {
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(data => data.value === this.search.upazila_id)
        this.searchHeaderData.upazila_name = upazilaObj !== undefined ? upazilaObj.text_en : ''
        this.searchHeaderData.upazila_name_bn = upazilaObj !== undefined ? upazilaObj.text_bn : ''
      }
      if (this.search.pauroshoba_id) {
        const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(data => data.value === this.search.pauroshoba_id)
        this.searchHeaderData.pauroshoba_name = pauroshobaObj !== undefined ? pauroshobaObj.text_en : ''
        this.searchHeaderData.pauroshoba_name_bn = pauroshobaObj !== undefined ? pauroshobaObj.text_bn : ''
      }
      if (this.search.union_id) {
        const unionObj = this.$store.state.CommonService.commonObj.unionList.find(data => data.value === this.search.union_id)
        this.searchHeaderData.union_name = unionObj !== undefined ? unionObj.text_en : ''
        this.searchHeaderData.union_name_bn = unionObj !== undefined ? unionObj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketDirectoryReportList, params)
      if (result.success) {
        this.datas = result.data.map((item) => {
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
          if (typeof divisionObj !== 'undefined') {
              divisionData.division_name = divisionObj.text_en
              divisionData.division_name_bn = divisionObj.text_bn
          } else {
              divisionData.division_name = ''
              divisionData.division_name_bn = ''
          }
          item.district_info = item.district_info.map((item1) => {
            const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item1.district_id))
            const districtData = {}
            if (typeof districtObj !== 'undefined') {
                districtData.district_name = districtObj.text_en
                districtData.district_name_bn = districtObj.text_bn
            } else {
                districtData.district_name = ''
                districtData.district_name_bn = ''
            }
            item1.city_upazila_info = item1.city_upazila_info.map((item2) => {
              // if (item2.city_corporation_id != '') {
                const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(corporation => corporation.value === parseInt(item2.city_corporation_id))
                const cityCorporationData = {}
                if (typeof cityCorporationObj !== 'undefined') {
                  cityCorporationData.city_corporation = cityCorporationObj.text_en
                  cityCorporationData.city_corporation_bn = cityCorporationObj.text_bn
                } else {
                  cityCorporationData.city_corporation = ' '
                  cityCorporationData.city_corporation_bn = ' '
                }
              // }
              // if (item2.upazila_id != '') {
                const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(dataItem => dataItem.value === parseInt(item2.upazila_id))
                const upazilaData = {}
                if (typeof upazilaObj !== 'undefined') {
                  upazilaData.upazila_name = upazilaObj.text_en
                  upazilaData.upazila_name_bn = upazilaObj.text_bn
                } else {
                  upazilaData.upazila_name = ''
                  upazilaData.upazila_name_bn = ''
                }
              // }
              item2.market_info = item2.market_info.map((item3, index) => {
                let criteriaData = item3.price_categories.map(criteriaItem => {
                  return criteriaItem.category_name_en
                })
                criteriaData = criteriaData.join(', ')
                let criteriaDataBn = item3.price_categories.map(criteriaItem => {
                  return criteriaItem.category_name_bn
                })
                criteriaDataBn = criteriaDataBn.join(', ')
                return Object.assign({}, item3, { serial: index + 1 }, { categories: criteriaData }, { categories_bn: criteriaDataBn })
              })
              return Object.assign({}, item2, cityCorporationData, upazilaData)
            })
            return Object.assign({}, item1, districtData)
          })
          return Object.assign({}, item, divisionData)
        })
        this.$store.dispatch('setList', this.datas)
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
    getThanaName (id) {
      const thana = this.$store.state.CommonService.commonObj.thanaList.find(obj => obj.value === parseInt(id))
      if (typeof thana !== 'undefined') {
        return this.$i18n.locale === 'en' ? thana.text_en : thana.text_bn
      } else {
        return ''
      }
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
    getDefaultMarketList (data) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === data.area_type_id && item.division_id === data.division_id && item.district_id === data.district_id)
    }
  }
}
</script>
