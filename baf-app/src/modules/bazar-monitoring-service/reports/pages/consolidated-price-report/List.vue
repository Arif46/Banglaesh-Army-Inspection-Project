<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.consolidated_price_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-overlay :show="loading">
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
                    <ValidationProvider name="0" vid="frequency_type">
                      <b-form-group
                        label-for="frequency_type"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('report.frequency_type')}}
                      </template>
<!--                        <v-select-->
<!--                            id="frequency_type"-->
<!--                            v-model="search.frequency_type"-->
<!--                            multiple-->
<!--                            :reduce="op => op.value"-->
<!--                            :options="frequencyTypeList"-->
<!--                            label="text"-->
<!--                            :state="errors[0] ? false : (valid ? true : null)"-->
<!--                        >-->
<!--                        </v-select>-->
                        <b-form-select
                          plain
                          v-model="search.frequency_type"
                          :options="frequencyTypeList"
                          id="frequency_type"
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
                    <ValidationProvider name="Price Category" vid="price_category_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="price_category_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('bazarMonitoring.Price_category')}} <span class="text-danger">*</span>
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
                    <ValidationProvider name="Date" vid="date" rules="required">
                      <b-form-group
                        label-for="date"
                      >
                        <template v-slot:label>
                          {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                        </template>
                          <date-picker
                            id="date"
                            v-model="search.date"
                            class="form-control"
                            :placeholder="$t('globalTrans.select')"
                            :locale="currentLocale"
                          >
                          </date-picker>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <b-button type="submit" size="sm" variant="primary" class="mt-20">
                      <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                    </b-button>
                  </b-col>
                </b-row>
              </b-form>
            </ValidationObserver>
          </b-col>
          </b-overlay>
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('report.consolidated_price_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <a href="javascript:" class="btn-add" @click="pdfExport">
                   {{ $t('globalTrans.print') }}
                </a>
                <a class="btn-add ml-2" target="_blank" :href="bazarMonitoringServiceBaseUrl + consolidatedPriceReport + '?action=export-excel&lang='+currentLocale+'&report_title='+$t('report.consolidated_price_report')+'&org_name='+org_name+'&org_name_bn='+org_name_bn+'&price_category_id='+ search.price_category_id+'&area_type_id='+search.area_type_id+'&division_id='+search.division_id+'&district_id='+search.district_id+'&upazila_id='+search.upazila_id+'&city_corporation_id='+search.city_corporation_id+'&pauroshoba_id='+search.pauroshoba_id+'&union_id='+search.union_id+'&market_directory_id='+search.market_directory_id+'&price_category_id='+search.price_category_id+'&frequency_type='+search.frequency_type+'&date='+search.date+'&search_header_data='+JSON.stringify(searchHeaderData)">
                  {{  $t('globalTrans.export_excel') }}
                </a>
                <!-- <b-button @click="pdfExport" class="btn-add">
                  {{  $t('globalTrans.print') }}
                </b-button> -->
                <!-- <a href="javascript:" class="btn-add" @click="pdfExport" v-b-modal.modal-form><i class="fas fa-print"></i> {{  $t('globalTrans.print') }}</a> -->
                <!-- <export-excel
                  class="btn-add ml-2"
                  :data="excelData"
                  :title="headerValue"
                  worksheet="Report Sheet"
                  :default-value="headerExcelDefault"
                  name="stall_status_report.xls">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel> -->
              </template>
              <template v-slot:body>
                <b-overlay :show="loading">
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('report.consolidated_price_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black">
                      <b-row>
                        <b-col md="3" lg="3">
                          <span>{{ $t('globalTrans.division') }}: </span><strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3" lg="3">
                          <span>{{ $t('globalTrans.district') }}: </span><strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <template v-if="search.area_type_id === 1">
                          <b-col md="3" lg="3">
                            <span>{{ $t('globalTrans.city_corporation') }}: </span><strong>{{ search.city_corporation_id  ?  ($i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                        </template>
                        <template v-else>
                          <b-col md="3" lg="3">
                            <span>{{ $t('globalTrans.upazila') }}: </span><strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3" lg="3" v-if="search.area_type_id === 2">
                            <span>{{ $t('globalTrans.pouroshova') }}: </span><strong>{{ search.pauroshoba_id ? ($i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3" lg="3" v-else>
                            <span>{{ $t('globalTrans.union') }}: </span><strong>{{ search.union_id ? ($i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                        </template>
                      </b-row>
                      <b-row>
                        <b-col>
                          <span>{{ $t('bazarMonitoring.market_name') }}: </span><strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('report.frequency_type') }}: </span><strong>{{ search.frequency_type ? ($i18n.locale === 'en' ? searchHeaderData.frequency_name : searchHeaderData.frequency_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('bazarMonitoring.Price_category') }}: </span><strong>{{ search.price_category_id  ?  ($i18n.locale === 'en' ? searchHeaderData.price_category_name : searchHeaderData.price_category_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('globalTrans.date') }}: </span><strong>{{ search.date|dateFormat }}</strong>
                        </b-col>
                      </b-row>
                    </div>
                    <b-row >
                      <b-col>
<!--                        <pre>{{ listData }}</pre>-->
                        <template v-if="listData.length">
                          <template v-for="(marketDirectory, marketDirectoryIndex) in listData">
                            <div class="market-area mt-3" :key="marketDirectoryIndex">
                            <h5>{{ $t('bazarMonitoring.market_name') }}: {{ currentLocale === 'en' ? marketDirectory.market_directory_name_en : marketDirectory.market_directory_name_bn }}</h5>
                            <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                              <b-thead>
                                <b-tr>
                                  <b-th rowspan="2" style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                  <b-th rowspan="2" style="width:13%" class="text-center">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                                  <b-th rowspan="2" style="width:13%" class="text-center">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                                  <b-th rowspan="2" style="width:13%" class="text-center">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
                                  <template v-for="(info, index) in frequencyDateArr">
                                    <b-th colspan="4" :key="index" style="width:20%" class="text-center">
                                      {{ currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn }} {{ info.frequency_date | dateFormat }}
                                    </b-th>
                                  </template>
                                </b-tr>
                                <b-tr>
                                  <template v-for="(info, index) in frequencyDateArr">
                                    <b-th class="text-center" :key="'L' + index">{{ $t('report.l') }}</b-th>
                                    <b-th class="text-center" :key="'F' + index">{{ $t('report.h') }}</b-th>
                                    <b-th class="text-center" :key="'tk' + index"><i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>{{ $t('report.tk') }}</b-th>
                                    <b-th class="text-center" :key="'%' + index"><i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>{{ $t('report.%') }}</b-th>
                                  </template>
                                </b-tr>
                              </b-thead>
                              <b-tbody>
                                <template v-for="(commodityGroup, commodityGroupIndex) in marketDirectory.commodity_group_info">
                                <template v-for="(commodityName, commodityNameIndex) in commodityGroup.commodity_name_info">
                                  <template v-if="commodityNameIndex === 0">
                                    <b-tr :key="'G-' + commodityGroupIndex + '-N-' + commodityNameIndex">
                                      <b-td class="text-center" :rowspan="(commodityGroup.commodity_name_info.length > 1 ? commodityGroup.commodity_name_info.length : null)">{{ $n(commodityGroupIndex + 1) }}</b-td>
                                      <b-td class="text-center" :rowspan="(commodityGroup.commodity_name_info.length > 1 ? commodityGroup.commodity_name_info.length : null)">{{ ($i18n.locale === 'en') ? commodityGroup.commodity_group_name_en : commodityGroup.commodity_group_name_bn }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'en') ? commodityName.commodity_name_en : commodityName.commodity_name_bn }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'en') ? commodityName.unit_name_en : commodityName.unit_name_bn }}</b-td>
                                      <template v-for="(frequencyItem, frequencyIndex) in commodityName.frequency_type_info">
                                        <b-td :key="'f-1-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.lowest_price_amount) }}</b-td>
                                        <b-td :key="'f-2-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.highest_price_amount) }}</b-td>
                                        <b-td :key="'f-3-'+frequencyIndex" class="text-center">{{ getFluctuationRate(frequencyItem) }}</b-td>
                                        <b-td :key="'f-4-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</b-td>
                                      </template>
                                    </b-tr>
                                  </template>
                                  <template v-else>
                                    <b-tr :key="'G-' + commodityGroupIndex + '-N-' + commodityNameIndex">
                                      <b-td class="text-center">{{ ($i18n.locale === 'en') ? commodityName.commodity_name_en : commodityName.commodity_name_bn }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'en') ? commodityName.unit_name_en : commodityName.unit_name_bn }}</b-td>
                                      <template v-for="(frequencyItem, frequencyIndex) in commodityName.frequency_type_info">
                                        <b-td :key="'f-1-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.lowest_price_amount) }}</b-td>
                                        <b-td :key="'f-2-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.highest_price_amount) }}</b-td>
                                        <b-td :key="'f-3-'+frequencyIndex" class="text-center">{{ getFluctuationRate(frequencyItem) }}</b-td>
                                        <b-td :key="'f-4-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</b-td>
                                      </template>
                                    </b-tr>
                                  </template>
                                </template>
                                </template>
                              </b-tbody>
                            </b-table-simple>
                            </div>
                          </template>
                        </template>
                        <template v-else>
                          <h3 class="text-center mt-5">{{ $t('globalTrans.noDataFound') }}</h3>
                        </template>
                      </b-col>
                    </b-row>
                  </template>
                    <!-- <span>
                        <hr>
                        <div class="text-center">
                          {{ $t('globalTrans.noDataFound') }}
                      </div>
                    </span> -->
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
import { consolidatedPriceReport, groupCategory } from '../../api/routes'
// import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

const today = new Date().toISOString().substr(0, 10)
export default {
  mixins: [bazarMonitoringServiceMixin],
  components: {
    ListReportHead
  },
  data () {
    return {
      bazarMonitoringServiceBaseUrl: bazarMonitoringServiceBaseUrl,
      sortBy: '',
      search: {
        commodity_group_id: 0,
        commodity_name_id: 0,
        market_directory_id: 0,
        frequency_type: 0,
        frequency_type_check: [],
        price_category_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        date: today,
        limit: 20,
        action: ''
      },
      searchHeaderData: {
        price_category_name: '',
        price_category_name_bn: '',
        frequency_name: '',
        frequency_name_bn: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: '',
        city_corporation_name: '',
        city_corporation_name_bn: '',
        upazila_name: '',
        upazila_name_bn: '',
        union_name: '',
        union_name_bn: '',
        pauroshoba_name: '',
        pauroshoba_name_bn: '',
        market_name_en: '',
        market_name_bn: '',
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
      showData: false,
      frequencyDateArr: [],
      listData: [],
      consolidatedPriceReport: consolidatedPriceReport,
      org_name: '',
      org_name_bn: ''
    }
  },
  created () {
    const org = this.$store.state.CommonService.commonObj.orgProfileList.find(obj => obj.value === this.orgId)
    this.org_name = org?.text_en
    this.org_name_bn = org?.text_bn
  },
  mounted () {
    this.headerDataExcel()
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_directory_id: this.addressCustomUser.market_id
      })
    }
  },
  computed: {
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    headerValue: function () {
      const headerVal = []
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report.consolidated_price_report')
        headerVal[4] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.consolidated_price_report')
        headerVal[4] = ''
      }
      return headerVal
    },
    excelData: function () {
      const listData = this.datas
      var serial = 0
      const listContractor = listData.map(keyItem => {
      serial++
        if (this.$i18n.locale === 'en') {
          return {
            'sl ': serial,
            'Area Type': keyItem.areaType_name,
            'Division ': keyItem.division_name,
            'District ': keyItem.district_name,
            'Market Name': keyItem.market_name_en,
            'Price Category': keyItem.categories,
            'Essential Commodity Stall ': keyItem.essential_commodity_stall
          }
        } else {
          return {
            'ক্রমিক সংখ্যা': this.$n(serial),
            'এলাকার ধরণ': keyItem.areaType_name_bn,
            'বিভাগ ': keyItem.division_name_bn,
            'জেলা ': keyItem.district_name_bn,
            'বাজারের নাম': keyItem.market_name_bn,
            'মূল্য বিভাগ': keyItem.categories,
            'নিত্যপ্রয়োজনীয় পণ্যের স্টল': this.$n(keyItem.essential_commodity_stall)
          }
        }
      })
      return listContractor
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
    },
    commodityGroupList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    },
    frequencyTypeList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList
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
    },
    'search.commodity_group_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.search.commodity_name_id = 0
          this.commodityNameList = this.getCommodityNameList(newVal)
          this.groupCategoryList(newVal)
      } else {
          this.commodityNameList = []
          this.priceCategoryList = []
      }
    }
  },
  methods: {
    headerDataExcel () {
      RestApi.getData(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail/' + this.orgId).then(response => {
      if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === 1)
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
        const reportTitle = this.$t('report.consolidated_price_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.price_category_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === this.search.price_category_id)
        this.searchHeaderData.price_category_name = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.price_category_name_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      if (this.search.frequency_type) {
        const frequencyType = this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList.find(data => data.value === this.search.frequency_type)
        this.searchHeaderData.frequency_name = frequencyType !== undefined ? frequencyType.text_en : ''
        this.searchHeaderData.frequency_name_bn = frequencyType !== undefined ? frequencyType.text_bn : ''
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
        const cityCorporationObj = this.$store.state.CommonService.commonObj.cityCorporationList.find(obj => obj.value === this.search.city_corporation_id)
        this.searchHeaderData.city_corporation_name = cityCorporationObj !== undefined ? cityCorporationObj.text_en : ''
        this.searchHeaderData.city_corporation_name_bn = cityCorporationObj !== undefined ? cityCorporationObj.text_bn : ''
      }
      if (this.search.upazila_id) {
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === this.search.upazila_id)
        this.searchHeaderData.upazila_name = upazilaObj !== undefined ? upazilaObj.text_en : ''
        this.searchHeaderData.upazila_name_bn = upazilaObj !== undefined ? upazilaObj.text_bn : ''
      }
      if (this.search.pauroshoba_id) {
        const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(obj => obj.value === this.search.pauroshoba_id)
        this.searchHeaderData.pauroshoba_name = pauroshobaObj !== undefined ? pauroshobaObj.text_en : ''
        this.searchHeaderData.pauroshoba_name_bn = pauroshobaObj !== undefined ? pauroshobaObj.text_bn : ''
      }
      if (this.search.union_id) {
        const unionObj = this.$store.state.CommonService.commonObj.unionList.find(union => union.value === this.search.union_id)
        this.searchHeaderData.union_name = unionObj !== undefined ? unionObj.text_en : ''
        this.searchHeaderData.union_name_bn = unionObj !== undefined ? unionObj.text_bn : ''
      }
      if (this.search.market_directory_id) {
        const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(market => market.value === this.search.market_directory_id)
        this.searchHeaderData.market_name_en = marketDirectoryObj !== undefined ? marketDirectoryObj.text_en : ''
        this.searchHeaderData.market_name_bn = marketDirectoryObj !== undefined ? marketDirectoryObj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      // this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: true })
      this.loading = true
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, consolidatedPriceReport, params)
      if (result.success) {
        const frequencyArr = []
        for (const frequency in result.frequency_date_info) {
          if (Object.prototype.hasOwnProperty.call(result.frequency_date_info, frequency)) {
            const frequencyDate = result.frequency_date_info[frequency]
            let frequencyItem = {}
            if (parseInt(frequency) === 1) {
              frequencyItem = {
                frequency_type: parseInt(frequency),
                frequency_text_en: this.$t('report.todays_price_tk', 'en'),
                frequency_text_bn: this.$t('report.todays_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            } else if (parseInt(frequency) === 2) {
              frequencyItem = {
                frequency_type: parseInt(frequency),
                frequency_text_en: this.$t('report.last_weeks_price_tk', 'en'),
                frequency_text_bn: this.$t('report.last_weeks_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            } else if (parseInt(frequency) === 3) {
              frequencyItem = {
                frequency_type: parseInt(frequency),
                frequency_text_en: this.$t('report.last_months_price_tk', 'en'),
                frequency_text_bn: this.$t('report.last_months_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            } else if (parseInt(frequency) === 4) {
              frequencyItem = {
                frequency_type: parseInt(frequency),
                frequency_text_en: this.$t('report.last_years_price_tk', 'en'),
                frequency_text_bn: this.$t('report.last_years_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            }
          }
        }
        this.frequencyDateArr = frequencyArr
        this.search.frequency_type_check = this.search.frequency_type
        // this.$store.dispatch('setList', this.getCustomizedList(result.data))
        this.listData = this.getCustomizedList(result.data)
      } else {
        // this.$store.dispatch('setList', [])
        this.listData = []
      }
      // this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      this.loading = false
    },
    getCustomizedList (data) {
      const list = data.map(item => {
        item.commodity_group_info = item.commodity_group_info.map(commodityGroupInfo => {
          commodityGroupInfo.commodity_name_info = commodityGroupInfo.commodity_name_info.map(commodityNameInfo => {
            const frequencyTypeInfo = []
            this.frequencyDateArr.forEach((frequencyItem, frequencyIndex) => {
              let frequencyInfo
              frequencyInfo = commodityNameInfo.frequency_type_info.find(obj => parseInt(obj.frequency_type) === parseInt(frequencyItem.frequency_type))
              if (frequencyInfo === undefined) {
                frequencyInfo = {
                  frequency_type: parseInt(frequencyItem.frequency_type),
                  lowest_price_amount: 0,
                  highest_price_amount: 0,
                  fluctuation_rate: 0,
                  fluctuation_rate_percentage: 0
                  // info: {
                  //   lowest_price_amount: 0,
                  //   highest_price_amount: 0,
                  //   fluctuation_rate: 0,
                  //   fluctuation_rate_percentage: 0
                  // }
                }
              }
              frequencyTypeInfo.push(frequencyInfo)
            })
            commodityNameInfo.frequency_type_info = frequencyTypeInfo
            const commodityName = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(obj => obj.value === parseInt(commodityNameInfo.commodity_name_id))
            const unit = this.$store.state.BazarMonitoringService.commonObj.unitList.find(obj => obj.value === parseInt(commodityNameInfo.measurement_unit_id))
            const customItem = {
              commodity_name_en: commodityName?.text_en,
              commodity_name_bn: commodityName?.text_bn,
              unit_name_en: unit?.text_en,
              unit_name_bn: unit?.text_bn
            }
            return Object.assign({}, commodityNameInfo, customItem)
          })
          const commodityGroup = this.commodityGroupList.find(obj => obj.value === parseInt(commodityGroupInfo.commodity_group_id))
          const customItem = {
            commodity_group_name_en: commodityGroup?.text_en,
            commodity_group_name_bn: commodityGroup?.text_bn
          }
          return Object.assign({}, commodityGroupInfo, customItem)
        })
        const marketDirectory = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(obj => obj.value === parseInt(item.market_directory_id))
        const customItem = {
          market_directory_name_en: marketDirectory?.text_en,
          market_directory_name_bn: marketDirectory?.text_bn
        }
        return Object.assign({}, item, customItem)
      })
      return list
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
    getCommodityNameList (id) {
        return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    groupCategoryList (id) {
      this.loading = true
      RestApi.getData(bazarMonitoringServiceBaseUrl, groupCategory + id, null).then(response => {
        if (response.success) {
          this.search.price_category_id = []
          const categoryList = []
          this.loading = false
          const listData = response.data.map((item, index) => {
            const priceCategoryListObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === parseInt(item.price_category_id))
            // return {
            //   value: priceCategory?.value,
            //   text: this.$i18n.locale === 'bn' ? priceCategory?.text_bn : priceCategory?.text_en
            // }
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
          this.search.price_category_id = categoryList
        }
        this.loading = false
      })
    },
    getFluctuationRate (frequencyItem) {
      return (frequencyItem.fluctuation_rate > 0 ? '+' : (frequencyItem.fluctuation_rate < 0 ? '' : '')) + (this.$n(frequencyItem.fluctuation_rate))
    },
    exportExcel () {
      this.search.action = 'export-xcl'
      this.loadData()
    }
  }
}
</script>
<style scoped>
  .table-responsive {
    max-height: 300px;
    overflow-y: scroll;
  }
</style>
