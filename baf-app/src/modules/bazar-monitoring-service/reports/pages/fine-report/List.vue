<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.fine_report') }}</h4>
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
              <ValidationProvider name="0" vid="date_from">
                <b-form-group
                  label-for="date_from"
                >
                  <template v-slot:label>
                    {{ $t('globalTrans.date_from') }}
                  </template>
                    <date-picker
                      id="date_from"
                      v-model="search.date_from"
                      class="form-control"
                      :placeholder="$t('globalTrans.select')"
                      :locale="currentLocale"
                    >
                    </date-picker>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="0" vid="date_to">
                <b-form-group
                  label-for="date_to"
                >
                  <template v-slot:label>
                    {{ $t('globalTrans.date_to') }}
                  </template>
                    <date-picker
                      id="date_to"
                      v-model="search.date_to"
                      class="form-control"
                      :placeholder="$t('globalTrans.select')"
                      :locale="currentLocale"
                    >
                    </date-picker>
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
                <h4 class="card-title">{{ $t('report.fine_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <!-- <b-button @click="pdfExport" class="btn-add">
                  {{  $t('globalTrans.print') }}
                </b-button> -->
                <a href="javascript:" class="btn-add" @click="pdfExport">
                   {{ $t('globalTrans.print') }}
                </a>
                <export-excel
                  class="btn-add ml-2"
                  :data="excelData"
                  :title="headerValue"
                  :fields=excelFields
                  worksheet="Report Sheet"
                  :default-value="headerExcelDefault"
                  name="fine_report.xls">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel>
              </template>
              <template v-slot:body>
                <b-overlay :show="loadingState">
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('report.fine_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black mb-4">
                      <b-row>
                        <b-col md="3">
                          {{ $t('globalTrans.division') }}: <strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3">
                          {{ $t('globalTrans.district') }}: <strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="6" v-if="search.area_type_id === 1">
                          {{ $t('globalTrans.city_corporation') }}: <strong>{{ search.city_corporation_id  ?  ($i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3" v-if="search.area_type_id === 2 || search.area_type_id === 3">
                          {{ $t('globalTrans.upazila') }}: <strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3" v-if="search.area_type_id === 2">
                          {{ $t('globalTrans.pouroshova') }}: <strong>{{ search.pauroshoba_id ? ($i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3" v-if="search.area_type_id === 3">
                          {{ $t('globalTrans.union') }}: <strong>{{ search.union_id ? ($i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </b-row>
                      <b-row>
                        <b-col md="3">
                          <slot v-if="search.date_from">
                            {{ $t('globalTrans.date_from') }}: <strong>{{ search.date_from | dateFormat }}</strong>
                          </slot>
                          <slot v-else>
                            {{ $t('globalTrans.date_from') }}: <strong>{{ $t('globalTrans.all') }}</strong>
                          </slot>
                        </b-col>
                        <b-col md="3">
                          <slot v-if="search.date_to">
                            {{ $t('globalTrans.date_to') }}: <strong>{{ search.date_to | dateFormat }}</strong>
                          </slot>
                          <slot v-else>
                            {{ $t('globalTrans.date_to') }}: <strong>{{ $t('globalTrans.all') }}</strong>
                          </slot>
                        </b-col>
                        <b-col md="6">
                          {{ $t('bazarMonitoring.market_name') }}: <strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
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
                                  <b-th style="width:13%" class="text-center">{{ $t('priceMonitoring.accused_person_org') }}</b-th>
                                  <b-th style="width:12%" class="text-center">{{ $t('priceMonitoring.complain_no') }}</b-th>
                                  <b-th style="width:20%" class="text-center">{{ $t('globalTrans.mobile') }}</b-th>
                                  <b-th style="width:12%" class="text-center">{{ $t('priceMonitoring.date_of_conviction') }}</b-th>
                                  <b-th style="width:15%" class="text-center">{{ $t('report.arbiter_information') }}</b-th>
                                  <b-th style="width:15%" class="text-center">{{ $t('report.section') }}</b-th>
                                  <b-th style="width:17%" class="text-center">{{ $t('report.fine_amount_tk') }}</b-th>
                                  <b-th style="width:17%" class="text-center">{{ $t('report.total_tk') }}</b-th>
                                </b-tr>
                              </b-thead>
                              <b-tbody>
                                <template v-for="(info, index) in infoData2.market_info">
                                <template v-for="(info1, index1) in info.sections_data">
                                  <b-tr :key="index + '_' + index1">
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ $n(index + 1) }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ ($i18n.locale === 'bn') ? info.accused_person_name_bn : info.accused_person_name_en }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ (info.case_number) }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(info.mobile_no, { useGrouping: false }) }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ info.date_of_conviction|dateFormat }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">
                                      <slot v-if="info.officer_name_bn">
                                      {{ ($i18n.locale === 'bn') ? info.officer_name_bn : info.officer_name }},
                                      </slot>
                                      {{ ($i18n.locale === 'bn') ? info.designation_name_bn : info.designation_name }}
                                    </b-td>
                                    <b-td class="text-center">{{ $n(info1.section_number) }}</b-td>
                                    <b-td class="text-center">{{ $n(info1.fine_amount) }}</b-td>
                                    <b-td v-if="index1 === 0" :rowspan="info.sections_data.length" class="text-center">{{ $n(getTotalFineAmount(info.sections_data)) }}</b-td>
                                  </b-tr>
                                </template>
                              </template>
                              <b-tr>
                                <b-th class="text-right" colspan=8>{{ $t('report.total_fine_amount') }}</b-th>
                                <b-th>{{ $n(getTotalAmount(infoData2.market_info)) }}</b-th>
                              </b-tr>
                              </b-tbody>
                            </b-table-simple>
                          </div>
                        </div>
                      </div>
                    </div>
                  </template>
                    <!-- <pre>{{datas}}</pre> -->
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { fineReportList, userListByDesignWise } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import { dateFormat } from '@/utils/fliter'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
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
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        date_from: '',
        date_to: '',
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
      testdatas: [],
      userList: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        market_name_bn: '',
        market_name_en: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: '',
        date_from: '',
        date_to: ''
      },
      showData: false
    }
  },
  created () {
    this.getUsers()
  },
  mounted () {
    this.headerDataExcel()
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        city_corporation_id: this.addressCustomUser.city_corporation_id,
        pauroshoba_id: this.addressCustomUser.pauroshoba_id,
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_id: this.addressCustomUser.market_id,
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
        headerVal[3] = this.$t('report.fine_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.fine_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      }
      const division = this.$t('globalTrans.division') + ' : ' + (this.search.division_id ? (local === 'en' ? this.searchHeaderData.division_name : this.searchHeaderData.division_name_bn) : this.$t('globalTrans.all')) + '; '
      const district = this.$t('globalTrans.district') + ' : ' + (this.search.district_id ? (local === 'en' ? this.searchHeaderData.district_name : this.searchHeaderData.district_name_bn) : this.$t('globalTrans.all')) + '; '
      const upazila = this.$t('globalTrans.upazila') + ' : ' + (this.search.upazila_id ? (local === 'en' ? this.searchHeaderData.upazila_name : this.searchHeaderData.upazila_name_bn) : this.$t('globalTrans.all')) + '; '
      const union = this.$t('globalTrans.union') + ' : ' + (this.search.union_id ? (local === 'en' ? this.searchHeaderData.union_name : this.searchHeaderData.union_name_bn) : this.$t('globalTrans.all'))
      headerVal[5] = division + district + upazila + union
      const market = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id ? (local === 'en' ? this.searchHeaderData.market_name_en : this.searchHeaderData.market_name_bn) : this.$t('globalTrans.all')) + '; '
      const dateTo = this.$t('globalTrans.date_to') + ' : ' + (this.search.date_to ? dateFormat(this.search.date_to) : this.$t('globalTrans.all')) + '; '
      const dateFrom = this.$t('globalTrans.date_from') + ' : ' + (this.search.date_from ? dateFormat(this.search.date_from) : this.$t('globalTrans.all'))
      headerVal[6] = market + dateTo + dateFrom
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          ' ': 'space',
          'ক্রমিক নং': 'serial',
          'অভিযুক্ত ব্যক্তি/সংস্থা ': 'accused_persons',
          'অভিযোগ নম্বর ': 'complain',
          'মোবাইল ': 'mobile',
          'দোষী সাব্যস্ত হওয়ার তারিখ ': 'date_convication',
          'আরবিটার তথ্য ': 'arbiter_info',
          'ধারা ': 'section',
          'জরিমানা পরিমাণ (টাকা) ': 'fine_amount',
          'মোট (টাকা) ': 'total_tk'
        }
      } else {
        return {
          ' ': 'space',
          'SL No': 'serial',
          'Accused Persons/Org. ': 'accused_persons',
          'Complain No ': 'complain',
          'Mobile ': 'mobile',
          'Date of Conviction ': 'date_convication',
          'Arbiter Information ': 'arbiter_info',
          'Sections ': 'section',
          'Fine Amount (Tk.) ': 'fine_amount',
          'Total (Tk.) ': 'total_tk'
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
          accused_persons: ' ',
          complain: ' ',
          mobile: ' ',
          date_convication: ' ',
          arbiter_info: ' ',
          section: ' ',
          fine_amount: ' ',
          total_tk: ' '
        })
        infoData.district_info.forEach((infoData1) => {
          const disName = this.$t('globalTrans.district') + ':' + (this.currentLocale === 'en' ? infoData1.district_name : infoData1.district_name_bn)
          excelData.push({
            space: disName,
            serial: ' ',
            accused_persons: ' ',
            complain: ' ',
            mobile: ' ',
            date_convication: ' ',
            arbiter_info: ' ',
            section: ' ',
            fine_amount: ' ',
            total_tk: ' '
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
              accused_persons: ' ',
              complain: ' ',
              mobile: ' ',
              date_convication: ' ',
              arbiter_info: ' ',
              section: ' ',
              fine_amount: ' ',
              total_tk: ' '
            })
            infoData2.market_info.forEach((info, index) => {
              info.sections_data.forEach((info1, index1) => {
                let serial = []
                let person = []
                let complain = []
                let mobile = []
                let dateConvication = []
                let arbiterInfo = []
                let totalTk = []
                if (index1 === 0) {
                  serial = this.$n(index + 1)
                  person = (this.currentLocale === 'en' ? info.accused_person_name_en : info.accused_person_name_bn)
                  complain = info.case_number
                  mobile = info.mobile_no
                  dateConvication = info.date_of_conviction
                  arbiterInfo = (this.currentLocale === 'en' ? info.officer_name : info.officer_name_bn) + ', ' + (this.currentLocale === 'en' ? info.designation_name : info.designation_name_bn)
                  totalTk = this.$n(this.getTotalFineAmount(info.sections_data))
                } else {
                  serial = ' '
                  person = ' '
                  complain = ' '
                  mobile = ' '
                  dateConvication = ' '
                  arbiterInfo = ' '
                  totalTk = ' '
                }
                excelData.push({
                  space: ' ',
                  serial: serial,
                  accused_persons: person,
                  complain: complain,
                  mobile: mobile,
                  date_convication: dateConvication,
                  arbiter_info: arbiterInfo,
                  section: this.$n(info1.section_number),
                  fine_amount: this.$n(info1.fine_amount),
                  total_tk: totalTk
                })
              })
            })
              excelData.push({
                space: ' ',
                serial: ' ',
                accused_persons: ' ',
                complain: ' ',
                mobile: ' ',
                date_convication: ' ',
                arbiter_info: ' ',
                section: ' ',
                fine_amount: this.$t('report.total_fine_amount'),
                total_tk: this.$n(this.getTotalAmount(infoData2.market_info))
              })
          })
        })
      })
      return excelData
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
    }
  },
  methods: {
    getUsers () {
      RestApi.getData(authServiceBaseUrl, userListByDesignWise, null).then(response => {
        if (response.success) {
          this.userList = response.data
        }
      })
    },
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
    pdfExport () {
        const reportTitle = this.$t('report.fine_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this, this.search, this.searchHeaderData)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.market_directory_id) {
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === this.search.market_directory_id)
        this.searchHeaderData.market_name_en = marketDirectoryObj !== undefined ? marketDirectoryObj.text_en : ''
        this.searchHeaderData.market_name_bn = marketDirectoryObj !== undefined ? marketDirectoryObj.text_bn : ''
      }
      if (this.search.area_type_id) {
        const ariaTypeObj = this.$store.state.commonObj.areaTypeList.find(data => data.value === this.search.area_type_id)
        this.searchHeaderData.aria_name = ariaTypeObj !== undefined ? ariaTypeObj.text_en : ''
        this.searchHeaderData.aria_name_bn = ariaTypeObj !== undefined ? ariaTypeObj.text_bn : ''
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
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, fineReportList, params)
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
                const userObj = this.userList.find(data => data.id === parseInt(item3?.fine_details?.user_id))
                const userData = {}
                  if (typeof userObj !== 'undefined') {
                    userData.officer_name = userObj.name
                    userData.officer_name_bn = userObj.name_bn
                  } else {
                      userData.officer_name = ''
                      userData.officer_name_bn = ''
                  }
                const designationObj = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === parseInt(userObj?.designation_id))
                const designationData = {}
                if (typeof designationObj !== 'undefined') {
                    designationData.designation_name = designationObj.text_en
                    designationData.designation_name_bn = designationObj.text_bn
                } else {
                    designationData.designation_name = ''
                    designationData.designation_name_bn = ''
                }
                return Object.assign({}, item3, { serial: index + 1 }, userData, designationData)
              })
              return Object.assign({}, item2, cityCorporationData, upazilaData)
            })
            return Object.assign({}, item1, districtData)
          })
          return Object.assign({}, item, divisionData)
        })
        this.datas = result.data.map((item, index) => {
          const divisionObj = this.$store.state.CommonService.commonObj.divisionList.find(division => division.value === parseInt(item.division_id))
          const divisionData = {}
          if (typeof divisionObj !== 'undefined') {
              divisionData.division_name = divisionObj.text_en
              divisionData.division_name_bn = divisionObj.text_bn
          } else {
              divisionData.division_name = ''
              divisionData.division_name_bn = ''
          }
          const userObj = this.userList.find(data => data.id === parseInt(item?.fine_details?.user_id))
          const userData = {}
            if (typeof userObj !== 'undefined') {
              userData.officer_name = userObj.name
              userData.officer_name_bn = userObj.name_bn
            } else {
                userData.officer_name = ''
                userData.officer_name_bn = ''
            }
          const designationObj = this.$store.state.CommonService.commonObj.designationList.find(designation => designation.value === parseInt(userObj?.designation_id))
          const designationData = {}
          if (typeof designationObj !== 'undefined') {
              designationData.designation_name = designationObj.text_en
              designationData.designation_name_bn = designationObj.text_bn
          } else {
              designationData.designation_name = ''
              designationData.designation_name_bn = ''
          }
          return Object.assign({}, item, { serial: index + 1 }, divisionData, userData, designationData)
        })
        this.$store.dispatch('setList', this.datas)
      } else {
        // this.datas = []
        this.$store.dispatch('setList', [])
      }
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
    },
    getTotalFineAmount (sections) {
      let totalAmount = 0
      sections.forEach(item => {
        totalAmount += item.fine_amount
      })
      return totalAmount
    },
    getTotalAmount (data) {
      let totalAmount = 0
      data.forEach(item => {
        let totalFineAmount = 0
        item.sections_data.forEach(item1 => {
          totalFineAmount += item1.fine_amount
        })
      totalAmount += totalFineAmount
      })
      return totalAmount
    }
  }
}
</script>
