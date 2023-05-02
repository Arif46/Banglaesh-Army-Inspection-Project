<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.market_wise_price_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col lg="12" sm="12">
              <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" >
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
                        <b-form-group
                        label-for="price_collection_date"
                        >
                        <template v-slot:label>
                            {{ $t('globalTrans.date') }}<span class="text-danger">*</span>
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
                      <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                          <b-button  type="submit" size="sm" variant="primary float-right">
                          <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                          </b-button>
                      </b-col>
                  </b-row>
                </b-form>
              </ValidationObserver>
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
            <h4 class="card-title">{{ $t('report.market_wise_price_report') }} {{ $t('globalTrans.list')}}</h4>
          </template>
          <template v-slot:headerAction>
            <!-- <b-button @click="pdfExport" class="btn-add">
              {{  $t('globalTrans.print') }}
            </b-button> -->
            <a href="javascript:" class="btn-add" @click="pdfExport">
              {{ $t('globalTrans.print') }}
            </a>
              <export-excel
                class="btn btn-add ml-2"
                :title="headerValue"
                :fields="excelFieldsOther"
                :data="excelData"
                worksheet="Report Sheet"
                name="market_wise_price_report.xls">
                {{ $t('globalTrans.export_excel') }}
              </export-excel>
          </template>
          <template v-slot:body>
            <b-overlay :show="loadingState">
              <b-col md="12" class="table-responsive">
                <div style="border: 2px solid black;margin:10px;padding:10px">
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('report.market_wise_price_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black">
                        <b-row>
                          <b-col>
                            <strong>{{ $t('globalTrans.division') }}: </strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all')  }}
                          </b-col>
                          <b-col>
                            <strong>{{ $t('globalTrans.district') }}: </strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}
                          </b-col>
                            <b-col>
                            <strong>{{ $t('bazarMonitoring.market_name') }}: </strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}
                          </b-col>
                          <b-col>
                            <strong>{{ $t('report.date') }}: </strong>{{ search.price_collection_date | dateFormat }}
                          </b-col>
                        </b-row>
                        <b-row>
                          <b-col v-if="search.area_type_id === 1">
                            <strong>{{ $t('globalTrans.city_corporation') }}: </strong>{{ search.city_corporation_id ? ($i18n.locale === 'en' ? searchHeaderData.city_corporation : searchHeaderData.city_corporation_bn) : $t('globalTrans.all')  }}
                          </b-col>
                          <b-col v-if="search.area_type_id === 2">
                            <strong>{{ $t('globalTrans.pouroshova') }}: </strong>{{ search.pauroshoba_id ? ($i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : $t('globalTrans.all')  }}
                          </b-col>
                           <b-col v-if="search.area_type_id === 2 || search.area_type_id === 3">
                            <strong>{{ $t('globalTrans.upazila') }}: </strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}
                          </b-col>
                          <b-col v-if="search.area_type_id === 3">
                            <strong>{{ $t('globalTrans.union') }}: </strong>{{ search.union_id ? ($i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : $t('globalTrans.all') }}
                          </b-col>
                        </b-row>
                      </div>
                    <b-row >
                      <b-col>
                        <b-table-simple sticky-header class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                          <b-thead>
                            <b-tr>
                              <b-th stickyColumn rowspan="3" style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th stickyColumn rowspan="3" style="width:13%" class="text-center">{{ $t('bazarMonitoring.commodity_group_name') }}</b-th>
                              <b-th stickyColumn rowspan="3" style="width:12%" class="text-center">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                              <b-th stickyColumn rowspan="3" style="width:12%" class="text-center">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
                              <b-th stickyColumn :colspan="priceCategoryArr.length*4" style="width:20%" class="text-center z-index-5">{{ $t('report.price') }}</b-th>
                            </b-tr>
                            <b-tr>
                                <b-th class="top-38 z-index-4" stickyColumn v-for="(priceCategory, index) in priceCategoryArr" :colspan="4" :key="index" style="text-align: center;vertical-align: middle;">{{ ($i18n.locale === 'bn') ? priceCategory.price_category_bn : priceCategory.price_category }}</b-th>
                            </b-tr>
                            <b-tr>
                              <template v-for="(priceCategory, index) in priceCategoryArr">
                                <b-th stickyColumn :key="index+1000" class="z-index-3" :class="currentLocale === 'bn' ? 'top-80' : 'top-95'"  style="text-align: center;vertical-align: middle;">{{ $t('report.l') }}</b-th>
                                <b-th stickyColumn :key="index+2000" class="z-index-3" :class="currentLocale === 'bn' ? 'top-80' : 'top-95'"  style="text-align: center;vertical-align: middle;">{{ $t('report.h') }}</b-th>
                                <b-th stickyColumn :key="index+3000" class="z-index-3" :class="currentLocale === 'bn' ? 'top-80' : 'top-95'"  style="text-align: center;vertical-align: middle;">{{ $t('report.tk') }}</b-th>
                                <b-th stickyColumn :key="index+4000" class="z-index-3" :class="currentLocale === 'bn' ? 'top-80' : 'top-95'"  style="text-align: center;vertical-align: middle;">{{ $t('report.%') }}</b-th>
                              </template>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <template v-for="(info, index) in datas">
                              <b-tr :key="index">
                                <b-td stickyColumn :rowspan="info.commodity_name_info.length + 1" class="text-center first-column">{{ $n(index + 1) }}</b-td>
                                <b-td stickyColumn :rowspan="info.commodity_name_info.length + 1" class="text-center second-column">{{ ($i18n.locale === 'bn') ? info.commodity_group_bn : info.commodity_group }}</b-td>
                              </b-tr>
                              <template v-for="(info1, index2) in info.commodity_name_info">
                                <b-tr :key="index + '_' + index2">
                                  <b-td stickyColumn class="text-center third-column">{{ ($i18n.locale === 'bn') ? info1.commodity_name_bn : info1.commodity_name }}</b-td>
                                  <b-td stickyColumn class="text-center fourth-column">{{ ($i18n.locale === 'bn') ? info1.unit_name_bn : info1.unit_name }}</b-td>
                                  <template v-for="(priceCategory, index3) in priceCategoryArr">
                                    <slot>
                                    <b-td class="text-center" :key="index + '_' +index3+1000">
                                      {{ getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined ? $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_amount): ($i18n.locale == 'bn') ? '০' : '0' }}
                                    </b-td>
                                    <b-td class="text-center" :key="index + '_' +index3+2000">
                                      {{ getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined ? $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_amount): ($i18n.locale == 'bn') ? '০' : '0' }}
                                    </b-td>
                                    <!-- <b-td class="text-center" :key="index + '_' +index3+3000">
                                      {{ getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined ? $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_percentage): ($i18n.locale == 'bn') ? '০' : '0' }}
                                      </b-td> -->
                                    <!-- <b-td class="text-center" :key="index + '_' +index3+4000">
                                      {{ getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined ? $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_percentage): ($i18n.locale == 'bn') ? '০' : '0' }}
                                    </b-td> -->
                                      <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
                                      <slot v-if="info1.price_category_info">
                                        <slot v-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined">
                                          <slot v-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_percentage < 0">
                                          <span style="color: var(--success)">▼ {{ $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_percentage) }}</span>
                                          </slot>
                                          <slot v-else-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_percentage > 0">
                                            <span style="color: #FF0000;">▲ {{ $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).lowest_price_percentage) }}</span>
                                          </slot>
                                          <slot v-else>
                                            {{$n(0.00.toFixed(2))}}
                                          </slot>
                                        </slot>
                                        <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                      </slot>
                                      <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                    </b-td>
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
                                      <slot v-if="info1.price_category_info">
                                        <slot v-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info) !== undefined">
                                          <slot v-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_percentage < 0">
                                            <span style="color: var(--success)">▼ {{ $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_percentage) }}</span>
                                          </slot>
                                          <slot v-else-if="getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_percentage > 0">
                                            <span style="color: #FF0000;">▲ {{ $n(getPriceCategoryInfo(priceCategory.value, info1.price_category_info).highest_price_percentage) }}</span>
                                          </slot>
                                          <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                        </slot>
                                        <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                      </slot>
                                      <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                    </b-td>
                                    </slot>
                                  </template>
                                  </b-tr>
                              </template>
                            </template>
                             <template v-if="datas.length === 0">
                              <tr>
                                <th colspan="7" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                              </tr>
                            </template>
                          </b-tbody>
                        </b-table-simple>
                      </b-col>
                      <!-- <pre>{{excelFieldsOther}}</pre>
                      <pre>{{priceCategoryArr}}</pre> -->
                    </b-row>
                  </template>
                </div>
              </b-col>
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
import { marketWisePriceReportList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import { dateFormat } from '@/utils/fliter'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

const today = new Date().toISOString().substr(0, 10)

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
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        market_directory_id: 0,
        price_collection_date: today
      },
      searchHeaderData: {
        area_type: '',
        area_type_bn: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: '',
        city_corporation: '',
        city_corporation_bn: '',
        upazila_name: '',
        upazila_name_bn: '',
        union_name: '',
        union_name_bn: '',
        market_name_en: '',
        market_name_bn: '',
        pauroshoba_name: '',
        pauroshoba_name_bn: '',
        price_collection_date: ''
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
      showData: false,
      priceCategoryArr: []
    }
  },
  created () {
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        area_type_id: this.addressCustomUser.area_type_id,
        city_corporation_id: this.addressCustomUser.city_corporation_id,
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        union_id: this.addressCustomUser.union_id,
        pauroshoba_id: this.addressCustomUser.pauroshoba_id,
        areaTypeList: JSON.stringify(this.loggedUserPrivilege.area_type_id),
        cityCorporationList: JSON.stringify(this.loggedUserPrivilege.city_corporation_id),
        divisionList: JSON.stringify(this.loggedUserPrivilege.division_id),
        districtList: JSON.stringify(this.loggedUserPrivilege.district_id),
        upazilaList: JSON.stringify(this.loggedUserPrivilege.upazila_id),
        unionList: JSON.stringify(this.loggedUserPrivilege.union_id),
        pauroshobaList: JSON.stringify(this.loggedUserPrivilege.pauroshoba_id)
      })
    }
    this.headerDataExcel()
  },
  watch: {
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
      headerVal[0] = this.$t('report.govt_info')
      headerVal[1] = this.headerExcelDefault.orgName
      headerVal[2] = this.headerExcelDefault.address
      headerVal[3] = this.$t('report.market_wise_price_report')
      headerVal[4] = ''
      headerVal[5] = ''
      headerVal[6] = ''
      headerVal[7] = ''
      } else {
      headerVal[0] = this.$t('report.govt_info')
      headerVal[1] = this.headerExcelDefault.orgNameBn
      headerVal[2] = this.headerExcelDefault.address_bn
      headerVal[3] = this.$t('report.market_wise_price_report')
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
      const dates = this.$t('globalTrans.date') + ' : ' + dateFormat(this.search.price_collection_date)
      headerVal[6] = market + dates
      return headerVal
    },
    excelFieldsOther: function () {
      let column = []
      if (this.$i18n.locale === 'bn') {
        column = {
          'SL No': 'sl_no',
          'Commodity Group Name': 'commodity_group',
          'Commodity Name': 'commodity_name',
          'Measurement Unit': 'measurement_unit'
        }
      } else {
        column = {
          'SL No': 'sl_no',
          'Commodity Group Name': 'commodity_group',
          'Commodity Name': 'commodity_name',
          'Measurement Unit': 'measurement_unit'
        }
      }
      this.priceCategoryArr.forEach((search, index) => {
        const val = search.value
        column[search.price_category + ' - Lowest'] = 'lowest_' + val
        column[search.price_category + ' - Hightest'] = 'highest_' + val
        column[search.price_category + ' - TK'] = 'tk_' + val
        column[search.price_category + ' - Percentage'] = 'percentage_' + val
      })
      return column
    },
    excelData: function () {
      if (this.datas.length <= 0) return []
        const excelData = []
        this.datas.forEach((item, optionIndex) => {
          item.commodity_name_info.forEach((info, index2) => {
            const newLoop = []
            if (index2 === 0) {
              newLoop.sl_no = this.$n(optionIndex + 1)
              newLoop.commodity_group = (this.currentLocale === 'bn' ? item.commodity_group_bn : item.commodity_group)
            } else {
              newLoop.sl_no = ''
              newLoop.commodity_group = ''
            }
            newLoop.commodity_name = (this.currentLocale === 'bn' ? info.commodity_name_bn : info.commodity_name)
            newLoop.measurement_unit = (this.currentLocale === 'bn' ? info.unit_name_bn : info.unit_name)
            this.priceCategoryArr.forEach((priceItem) => {
              const val = priceItem.value
              newLoop['lowest_' + val] = this.getPriceCategoryInfo(priceItem.value, info.price_category_info) !== undefined ? this.$n(this.getPriceCategoryInfo(priceItem.value, info.price_category_info).lowest_price_amount) : (this.$i18n.locale === 'bn') ? '০' : '0'
              newLoop['highest_' + val] = this.getPriceCategoryInfo(priceItem.value, info.price_category_info) !== undefined ? this.$n(this.getPriceCategoryInfo(priceItem.value, info.price_category_info).highest_price_amount) : (this.$i18n.locale === 'bn') ? '০' : '0'
              newLoop['tk_' + val] = this.getPriceCategoryInfo(priceItem.value, info.price_category_info) !== undefined ? this.$n(this.getPriceCategoryInfo(priceItem.value, info.price_category_info).lowest_price_percentage) : (this.$i18n.locale === 'bn') ? '০' : '0'
              newLoop['percentage_' + val] = this.getPriceCategoryInfo(priceItem.value, info.price_category_info) !== undefined ? this.$n(this.getPriceCategoryInfo(priceItem.value, info.price_category_info).highest_price_percentage) : (this.$i18n.locale === 'bn') ? '০' : '0'
            })
            excelData.push(newLoop)
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
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  methods: {
    pdfExport () {
      const reportTitle = this.$t('report.market_wise_price_report')
      ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this, this.datas, this.priceCategoryArr, this.getPriceCategoryInfo, this.search, this.searchHeaderData)
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
    async searchData () {
       if (this.search.area_type_id) {
        const areaTypeObj = this.$store.state.commonObj.areaTypeList.find(areaType => areaType.value === this.search.area_type_id)
        this.searchHeaderData.area_type = areaTypeObj !== undefined ? areaTypeObj.text_en : ''
        this.searchHeaderData.area_type_bn = areaTypeObj !== undefined ? areaTypeObj.text_bn : ''
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
      if (this.search.upazila_id) {
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === this.search.upazila_id)
        this.searchHeaderData.upazila_name = upazilaObj !== undefined ? upazilaObj.text_en : ''
        this.searchHeaderData.upazila_name_bn = upazilaObj !== undefined ? upazilaObj.text_bn : ''
      }
      if (this.search.city_corporation_id) {
        const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(cityCor => cityCor.value === this.search.city_corporation_id)
        this.searchHeaderData.city_corporation = cityCorporationObj !== undefined ? cityCorporationObj.text_en : ''
        this.searchHeaderData.city_corporation_bn = cityCorporationObj !== undefined ? cityCorporationObj.text_bn : ''
      }
      if (this.search.union_id) {
        const unionObj = this.$store.state.CommonService.commonObj.unionList.find(union => union.value === this.search.union_id)
        this.searchHeaderData.union_name = unionObj !== undefined ? unionObj.text_en : ''
        this.searchHeaderData.union_name_bn = unionObj !== undefined ? unionObj.text_bn : ''
      }
      if (this.search.pauroshoba_id) {
        const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(pauroshoba => pauroshoba.value === this.search.pauroshoba_id)
        this.searchHeaderData.pauroshoba_name = pauroshobaObj !== undefined ? pauroshobaObj.text_en : ''
        this.searchHeaderData.pauroshoba_name_bn = pauroshobaObj !== undefined ? pauroshobaObj.text_bn : ''
      }
      if (this.search.market_directory_id) {
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === this.search.market_directory_id)
        this.searchHeaderData.market_name_en = marketDirectoryObj !== undefined ? marketDirectoryObj.text_en : ''
        this.searchHeaderData.market_name_bn = marketDirectoryObj !== undefined ? marketDirectoryObj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketWisePriceReportList, params)
      if (result.success) {
        this.datas = this.getRelationData(result.data)
        this.priceCategoryArr = this.getRelationPriceCategory(result.price_category_arr)
      } else {
        this.datas = []
        this.priceCategoryArr = []
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
    },
    getRelationData (data) {
      const listData = data.map(item => {
        const commodityObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(commodityGroup => commodityGroup.value === parseInt(item.commodity_group_id))
        const commodityData = {
          commodity_group: commodityObj !== undefined ? commodityObj.text_en : '',
          commodity_group_bn: commodityObj !== undefined ? commodityObj.text_bn : ''
        }
        item.commodity_name_info = item.commodity_name_info.map(item2 => {
          const commodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(commodityName => commodityName.value === item2.commodity_name_id)
          const commodityNameData = {
            commodity_name: commodityNameObj !== undefined ? commodityNameObj.text_en : '',
            commodity_name_bn: commodityNameObj !== undefined ? commodityNameObj.text_bn : ''
          }
          const measurementUnitObj = this.$store.state.BazarMonitoringService.commonObj.unitList.find(unit => unit.value === item2.measurement_unit_id)
          const unitData = {
            unit_name: measurementUnitObj !== undefined ? measurementUnitObj.text_en : '',
            unit_name_bn: measurementUnitObj !== undefined ? measurementUnitObj.text_bn : ''
          }
          return Object.assign({}, item2, commodityNameData, unitData)
        })
        return Object.assign({}, item, commodityData)
      })
      return listData
    },
    getRelationPriceCategory (data) {
      const dataRelation = data.map(item => {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(price => price.value === item)
        const data = {
          value: priceCategoryObj !== undefined ? priceCategoryObj.value : '',
          price_category: priceCategoryObj !== undefined ? priceCategoryObj.text_en : '',
          price_category_bn: priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
        }
        return Object.assign({}, item, data)
      })
      return dataRelation
    },
    getPriceCategoryInfo (priceCategoryId, priceCategoryArr) {
      const priceCategory = priceCategoryArr.find(item => item.price_category_id === parseInt(priceCategoryId))
      return priceCategory
    }
  }
}
</script>
<style scoped>
  .table-responsive {
    max-height: 400px;
    overflow-y: scroll;
  }
  .top-38 {
    top: 38px !important;
  }
  .top-80 {
    top: 80px !important;
  }
  .top-95 {
    top: 95px !important;
  }
  z-index-5 {
    z-index: 5 !important;
  }
  z-index-4 {
    z-index: 4 !important;
  }
  z-index-3 {
    z-index: 3 !important;
  }
  .first-column {
    width: 85px;
    min-width: 85px;
    max-width: 85px;
    left: 0px;
    background-color: white !important;
    z-index: 3;
  }

  .second-column {
    width: 165px;
    min-width: 165px;
    max-width: 165px;
    left: 65px !important;
    background-color: white !important;
    z-index: 3;
  }

  .third-column {
    width: 205px;
    min-width: 205px;
    max-width: 205px;
    left: 230px !important;
    background-color: white !important;
    z-index: 3;
  }
  .fourth-column {
    width: 131px;
    min-width: 131px;
    max-width: 131px;
    left: 430px !important;
    background-color: white !important;
    z-index: 3;
  }
</style>
