<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.market_comparison_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" >
            <b-row>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Price Category Name" vid="price_category_id" rules="required|min_value:1">
                    <b-form-group
                        label-for="price_category_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('bazarMonitoring.Price_category_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="search.price_category_id"
                        :options="priceCategoryList"
                        id="price_category_id"
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
                <ValidationProvider name="Commodity Group">
                  <b-form-group
                      label-for="commodity_group_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('bazarMonitoring.commodity_group')}}
                  </template>
                      <v-select
                        id="commodity_group_id"
                        v-model="search.commodity_group_id"
                        multiple
                        :reduce="op => op.value"
                        :options="commodityGroupList"
                        label="text"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :placeholder="$t('globalTrans.select')"
                        @input="getCommodityNameList(search)"
                      >
                      </v-select>
                    <div class="invalid-feedback d-block">
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
                  <v-select
                    id="commodity_name_id"
                    v-model="search.commodity_name_id"
                    multiple
                    :reduce="op => op.value"
                    :options="commodityNameList"
                    label="text"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select')"
                  >
                  </v-select>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Price Veriation" vid="price_veriation" rules="required|min_value:1">
                  <b-form-group
                    label-for="price_veriation"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('priceMonitoring.price_veriation')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="search.price_veriation"
                    :options="priceVeriationList"
                    id="price_veriation"
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
                  <ValidationProvider name="Division Name" vid="division_id">
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
                  <ValidationProvider name="District Name" vid="district_id">
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
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="0" vid="market_directory_id">
                    <b-form-group
                        label-for="market_directory_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.market_name')}}
                    </template>
                    <v-select
                      id="market_directory_id"
                      v-model="search.market_directory_id"
                      multiple
                      :reduce="op => op.value"
                      :options="marketDirectoryList"
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
                <ValidationProvider name="Date" vid="date" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="date"
                  >
                    <template v-slot:label>
                      {{ $t('globalTrans.date') }}  <span class="text-danger">*</span>
                    </template>
                    <date-picker
                      id="date"
                      class="form-control"
                      v-model="search.date"
                      :class="errors[0] ? 'is-invalid' : ''"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :placeholder="$t('globalTrans.select')"
                      :locale="currentLocale"
                    >
                    </date-picker>
                    <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-button size="sm" type="submit" variant="primary" class="mt-20">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                </b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
    </card>
    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('report.market_comparison_report') }}</h4>
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
              :default-value="searchHeaderData"
              name="market_comparison_report.xls">
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
                    {{ $t('report.market_comparison_report') }}
                  </list-report-head>
                </b-col>
              </b-row>
              <template>
                <div class="text-black mb-4">
                  <b-row>
                    <b-col md="6">
                      {{ $t('bazarMonitoring.Price_category_name') }}: <strong>{{ search.price_category_id  ?  ($i18n.locale === 'en' ? searchHeaderData.priceCategory_name_en : searchHeaderData.priceCategory_name_bn) : $t('globalTrans.all') }}</strong>
                    </b-col>
                    <b-col md="6" class="text-right">
                      {{ $t('globalTrans.date') }}: <strong>{{ search.date|dateFormat }}</strong>
                    </b-col>
                    <b-col md="6">
                      {{ $t('bazarMonitoring.commodity_group') }}: <strong>{{ search.commodity_group_id.length ? commodityGroupCheck(search.commodity_group_id) : $t('globalTrans.all') }}</strong>
                    </b-col>
                    <b-col md="6" class="text-right">
                      <span v-if="search.price_veriation == 1">
                        {{ $t('globalTrans.price') }}: <strong>{{ $t('report.lowest_price_amount') }}</strong>
                      </span>
                      <span v-else>
                        {{ $t('globalTrans.price') }}: <strong>{{ $t('report.highest_price_amount') }}</strong>
                      </span>
                    </b-col>
                    <slot v-if="search.area_type_id">
                      <b-col :md="search.area_type_id === 1 ? '6' : '6'">
                        {{ $t('globalTrans.division') }}: <strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all') }}</strong>
                      </b-col>
                      <b-col class="text-right" :md="search.area_type_id === 1 ? '6' : '6'">
                        {{ $t('globalTrans.district') }}: <strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}</strong>
                      </b-col>
                      <b-col :md="search.area_type_id === 1 ? '6' : '6'" v-if="search.area_type_id === 1">
                        {{ $t('globalTrans.city_corporation') }}: <strong>{{ search.city_corporation_id  ?  ($i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : $t('globalTrans.all') }}</strong>
                      </b-col>
                      <slot v-if="search.area_type_id === 2 || search.area_type_id === 3">
                        <b-col class="text-right" :md="search.area_type_id === 1 ? '6' : '6'">
                          {{ $t('globalTrans.upazila') }}: <strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </slot>
                      <b-col class="text-left" :md="search.area_type_id === 1 ? '12' : '12'">
                        {{ $t('bazarMonitoring.market_name') }}: <strong>{{ search.market_directory_id.length ? getMarketDirectoryList(search.market_directory_id) : $t('globalTrans.all') }}</strong>
                      </b-col>
                    </slot>
                  </b-row>
                </div>
                <div translate="translate" class="bd-example vue-example vue-example-table-sticky-columns">
                  <div>
                    <div class="tableFixHead b-table-sticky-header table-responsive" v-if="datas.length">
                      <table role="table" aria-busy="false" class="table b-table table-hover table-bordered table-sm b-table-caption-top" id="__BVID__1110">
                        <b-thead role="rowgroup" head-variant="primary">
                          <b-tr role="row">
                            <b-th scope="col" role="columnheader" style="width:5% !important" class="position-relative sticky-col first-col underzindex sticky-col first-col topzindex text-center">
                              <div class="text-nowrap">{{ $t('globalTrans.sl_no') }}</div>
                            </b-th>
                            <b-th scope="col" role="columnheader" style="width:20% !important" class="position-relative sticky-col second-col underzindex sticky-col second-col topzindex text-center"><div class="text-nowrap">{{ $t('bazarMonitoring.market_name') }}</div></b-th>
                            <template v-for="(commData, index) in commDatas">
                                <b-th scope="col" role="columnheader" style="width:10% !important" class="text-center" :key="index"><div class="text-nowrap">{{ ($i18n.locale === 'bn') ? commData.text_bn : commData.text_en }}</div></b-th>
                            </template>
                          </b-tr>
                        </b-thead>
                        <tbody role="rowgroup">
                          <slot v-if="datas.length">
                            <b-tr v-for="(info, index) in datas" :key="index">
                              <b-td class="sticky-col first-col underzindex text-center"><div class="text-nowrap">{{ $n(index + 1) }}</div></b-td>
                              <b-td class="text-center sticky-col second-col underzindex"><div class="text-nowrap">{{ ($i18n.locale === 'bn') ? info.market_name_bn : info.market_name }}</div></b-td>
                              <template v-for="(commData, index) in commDatas">
                                  <b-td style="width:30%" class="text-center" :key="index">
                                    {{commDataFn(commData.value, info.list)}}
                                  </b-td>
                              </template>
                            </b-tr>
                          </slot>
                          <slot v-else>
                            <b-tr>
                              <b-td style="color:red;height:50px" class="text-center" :colspan="2 + commDatas.length">
                                {{ $t('globalTrans.noDataFound') }}
                              </b-td>
                            </b-tr>
                          </slot>
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </template>
            </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<style>
.tableFixHead > .tableFixHead  th {
  border: 1px solid black !important;
}
.tableFixHead >.table-bordered thead th, .table-bordered thead td {
  background: white  !important;
  border: 1px solid black !important;
}
.sticky-col {
  position: -webkit-sticky;
  position: sticky;
  background-color: white;
}

.first-col {
  width: 85px;
  min-width: 85px;
  max-width: 85px;
  left: 0px;
  background-color: white !important;
}

.second-col {
  width: 131px;
  min-width: 205px;
  max-width: 205px;
  left: 85px;
  background-color: white !important;
}
.underzindex {
  z-index: 3 !important;
}
.b-table-sticky-header > .table.b-table > thead > tr > th {
  position: sticky !important;
  top: 0;
}
.topzindex {
  z-index: 5 !important;
}
.rightzindex {
  z-index: 4 !important;
}

.tableFixHead >.b-table-sticky-header > .table.b-table > thead > tr > th {
  position: sticky !important;
  top: 0;
  font-size: 15px  !important;
}
.b-table-sticky-header {
  overflow-y: auto;
  max-height: 800px !important;
}
</style>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketComparisonReport } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import ExportPdf from './export_pdf_details'
import { dateFormat } from '@/utils/fliter'
import excel from 'vue-excel-export'
import Vue from 'vue'
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
        market_directory_id: [],
        date: '',
        price_category_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        commodity_group_id: [],
        commodity_name_id: [],
        price_veriation: 0
      },
      editItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      commDatas: [],
      commodityNameList: [],
      datas: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null,
        priceCategory_name_en: '',
        priceCategory_name_bn: '',
        comodity_name: '',
        comodity_name_bn: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: '',
        city_corporation_name: '',
        city_corporation_name_bn: '',
        pauroshoba_name: '',
        pauroshoba_name_bn: '',
        upazila_name: '',
        upazila_name_bn: ''
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
        // this.marketDirectoryList = this.getAreaMarketList(newVal)
      } else {
        // this.marketDirectoryList = []
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
    priceVeriationList: function () {
      const list = this.$store.state.commonObj.priceVariationList
      return list.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      headerVal.push(this.$t('globalTrans.government_republic_of_bangladesh'))
      if (this.$i18n.locale === 'en') {
        headerVal.push(this.searchHeaderData.orgName)
        headerVal.push(this.searchHeaderData.address)
      } else {
        headerVal.push(this.searchHeaderData.orgNameBn)
        headerVal.push(this.searchHeaderData.address_bn)
      }
      headerVal.push(this.$t('report.market_comparison_report'))
      headerVal.push('')
      const category = this.$t('bazarMonitoring.Price_category_name') + ' : ' + (local === 'en' ? this.searchHeaderData.priceCategory_name_en : this.searchHeaderData.priceCategory_name_bn) + ';' + ' ' + ' ' + ' ' + ' '
      const date = ' ' + ' ' + this.$t('globalTrans.date') + ' : ' + dateFormat(this.search.date) + ';   '
      let hedearVal = ''
      let priceName = ''
      hedearVal = category + date
      headerVal.push(hedearVal)
      if (this.search.price_veriation === 1) {
          priceName = this.$t('globalTrans.price') + ' : ' + this.$t('report.lowest_price_amount')
      }
      if (this.search.price_veriation === 2) {
          priceName = this.$t('globalTrans.price') + ' : ' + this.$t('report.highest_price_amount')
      }
      const commodityName = this.$t('bazarMonitoring.commodity_group') + ' : ' + (this.search.commodity_group_id.length ? this.commodityGroupCheck(this.search.commodity_group_id) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      headerVal.push(commodityName + priceName)
      if (this.search.area_type_id) {
        const division = this.$t('globalTrans.division') + ' : ' + (this.search.division_id ? (local === 'en' ? this.searchHeaderData.division_name : this.searchHeaderData.division_name_bn) : this.$t('globalTrans.all')) + ';  '
        const district = this.$t('globalTrans.district') + ' : ' + (this.search.district_id ? (local === 'en' ? this.searchHeaderData.district_name : this.searchHeaderData.district_name_bn) : this.$t('globalTrans.all')) + '; '
        headerVal.push(division + district)
        if (this.search.area_type_id === 1) {
          const cityCorporation = this.$t('globalTrans.city_corporation') + ' : ' + (this.search.city_corporation_id ? (local === 'en' ? this.searchHeaderData.city_corporation_name : this.searchHeaderData.city_corporation_name_bn) : this.$t('globalTrans.all')) + ';  '
          headerVal.push(cityCorporation)
        }
        let upazila = ''
        if (this.search.area_type_id === 2) {
          upazila = this.$t('globalTrans.upazila') + ' : ' + (this.search.upazila_id ? (local === 'en' ? this.searchHeaderData.upazila_name : this.searchHeaderData.upazila_name_bn) : this.$t('globalTrans.all')) + ';  '
          const pouroshova = this.$t('globalTrans.pouroshova') + ' : ' + (this.search.pauroshoba_id ? (local === 'en' ? this.searchHeaderData.pauroshoba_name : this.searchHeaderData.pauroshoba_name_bn) : this.$t('globalTrans.all')) + ';  '
          headerVal.push(upazila + pouroshova)
        }
        if (this.search.area_type_id === 3) {
          upazila = this.$t('globalTrans.upazila') + ' : ' + (this.search.upazila_id ? (local === 'en' ? this.searchHeaderData.upazila_name : this.searchHeaderData.upazila_name_bn) : this.$t('globalTrans.all')) + ';  '
          headerVal.push(upazila)
        }
      }
      const marketName = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id.length ? this.getMarketDirectoryList(this.search.market_directory_id) : this.$t('globalTrans.all')) + ';'
      headerVal.push(marketName)
      headerVal.push('')
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        const label = {
          'ক্রমিক নং': 'serial',
          'বাজারের নাম': 'market_name'
        }
        this.commDatas.forEach((commData, index) => {
          label[commData.text_bn] = commData.value
        })
        return label
      } else {
        const label = {
          'SL No': 'serial',
          'Market Name ': 'market_name'
        }
        this.commDatas.forEach((commData, index) => {
          label[commData.text_en] = commData.value
        })
        return label
      }
    },
    excelData: function () {
      const excelData = []
      this.datas.forEach((info, index) => {
        const thirdRowHeader = {
          serial: this.$n(index + 1),
          market_name: (this.currentLocale === 'en' ? info.market_name : info.market_name_bn)
        }
        this.commDatas.forEach((commData, index) => {
          thirdRowHeader[commData.value] = this.commDataFn(commData.value, info.list)
        })
        excelData.push(thirdRowHeader)
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
    currentLocale () {
      return this.$i18n.locale
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    commodityGroupList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    commodityGroupCheck () {
      const groupData = []
      this.search.commodity_group_id.map((item) => {
        const commNameList = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(item1 => item1.value === item)
        if (typeof commNameList !== 'undefined') {
          if (this.$i18n.locale === 'bn') {
            groupData.push(commNameList.text_bn)
          } else {
            groupData.push(commNameList.text_en)
          }
        }
      })
      return groupData.toString()
    },
    headerDataExcel () {
      RestApi.getData(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail/' + this.orgId).then(response => {
      if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === this.orgId)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          this.searchHeaderData.orgName = orgName
          this.searchHeaderData.orgNameBn = orgNameBn
          this.searchHeaderData.address = response.data.address
          this.searchHeaderData.address_bn = response.data.address_bn
      }
      })
    },
    pdfExport () {
        const reportTitle = this.$t('report.market_comparison_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this.datas, this, this.search, this.searchHeaderData)
    },
    searchData () {
      this.loadData()
    },
    commDataFn (commodityNameId, list) {
      const dataFound = list.find(item1 => item1.commodity_name_id === commodityNameId)
      if (typeof dataFound !== 'undefined') {
        if (this.search.price_veriation === 1) {
          return this.$n(dataFound.lowest_price_amount)
        } else {
          return this.$n(dataFound.highest_price_amount)
        }
      } else {
        return '-'
      }
    },
    async loadData () {
      this.datas = []
      this.commDatas = []
      if (this.search.commodity_name_id.length > 0) {
        this.search.commodity_name_id.map((item) => {
          const commNameList = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(item1 => item1.value === item)
          if (typeof commNameList !== 'undefined') {
            this.commDatas.push(commNameList)
          }
        })
      } else if (this.search.commodity_group_id.length > 0) {
        this.commDatas = this.commodityNameList
      } else {
        this.commDatas = this.$store.state.BazarMonitoringService.commonObj.commodityNameList
      }
      if (this.search.price_category_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === this.search.price_category_id)
        this.searchHeaderData.priceCategory_name_en = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.priceCategory_name_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      if (this.search.commodity_name_id) {
        const comodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(item => item.value === this.search.commodity_name_id)
        this.searchHeaderData.comodity_name = comodityNameObj !== undefined ? comodityNameObj.text_en : ''
        this.searchHeaderData.comodity_name_bn = comodityNameObj !== undefined ? comodityNameObj.text_bn : ''
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
      if (this.search.pauroshoba_id) {
        const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(data => data.value === this.search.pauroshoba_id)
        this.searchHeaderData.pauroshoba_name = pauroshobaObj !== undefined ? pauroshobaObj.text_en : ''
        this.searchHeaderData.pauroshoba_name_bn = pauroshobaObj !== undefined ? pauroshobaObj.text_bn : ''
      }
      if (this.search.upazila_id) {
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === this.search.upazila_id)
        this.searchHeaderData.upazila_name = upazilaObj !== undefined ? upazilaObj.text_en : ''
        this.searchHeaderData.upazila_name_bn = upazilaObj !== undefined ? upazilaObj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketComparisonReport, params)
      if (result.success) {
        this.datas = result.data.map((item) => {
          const marketObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(data => data.value === parseInt(item.market_directory_id))
          const marketData = {}
          if (typeof marketObj !== 'undefined') {
              marketData.market_name = marketObj.text_en
              marketData.market_name_bn = marketObj.text_bn
          } else {
              marketData.market_name = ''
              marketData.market_name_bn = ''
          }
          return Object.assign({}, item, marketData)
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
    getCommodityNameList (search) {
      const commodityNameList = []
      if (search.commodity_group_id) {
        if (search.commodity_group_id.length > 0) {
          search.commodity_group_id.forEach((item, key) => {
            const commodityNameLists = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item1 => item1.commodity_group_id === item)
            commodityNameLists.forEach((item1, key) => {
              commodityNameList.push(item1)
            })
          })
          this.commodityNameList = commodityNameList
        } else {
          this.commodityNameList = []
        }
        const searchData = []
        if (this.commodityNameList.length > 0) {
          this.commodityNameList.forEach((item, key) => {
            this.search.commodity_name_id.map((item1) => {
              if (item1 === item.value) {
                searchData.push(item1)
              }
            })
          })
        }
        this.search.commodity_name_id = searchData
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
