<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.price_fluctuation_report') }}</h4>
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
                    <ValidationProvider name="0" vid="frequency_type_id">
                      <b-form-group
                        label-for="frequency_type_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('report.frequency_type')}}
                      </template>
                        <v-select
                            id="frequency_type_id"
                            v-model="search.frequency_type_id"
                            multiple
                            :reduce="op => op.value"
                            :options="frequencyTypeList"
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
                    <ValidationProvider name="Price Category" vid="price_category_id">
                      <b-form-group
                        label-for="price_category_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('bazarMonitoring.Price_category')}}
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
                            id="price_collection_date"
                            v-model="search.price_collection_date"
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
        </b-row>
      </template>
      <!-- search section end -->
    </card>
    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('report.price_fluctuation_report') }}</h4>
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
                  class="btn-add ml-2 cursor-pointer"
                   :fields=excelFieldsOther
                  worksheet="Report Sheet"
                  :data=excelData
                  :before-generate = "headerDataExcel"
                  :title="headerValue"
                  name="price-fluctuation-report.xls">
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
                        {{ $t('report.price_fluctuation_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black">
                      <b-row>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'">
                          {{ $t('globalTrans.division') }}: <strong>{{ search.division_id ? ($i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'">
                         {{ $t('globalTrans.district') }}: <strong>{{ search.district_id  ?  ($i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'" v-if="search.area_type_id === 1">
                          {{ $t('globalTrans.city_corporation') }}: <strong>{{ search.city_corporation_id  ?  ($i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'" v-if="search.area_type_id === 2 || search.area_type_id === 3">
                          {{ $t('globalTrans.upazila') }}: <strong>{{ search.upazila_id  ?  ($i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'" v-if="search.area_type_id === 2">
                          {{ $t('globalTrans.pouroshova') }}: <strong>{{ search.pauroshoba_id ? ($i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'" v-if="search.area_type_id === 3">
                          {{ $t('globalTrans.union') }}: <strong>{{ search.union_id ? ($i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'">
                          {{ $t('bazarMonitoring.market_name') }}: <strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'">
                          {{ $t('bazarMonitoring.Price_category') }}: <strong>{{ search.price_category_id ? ($i18n.locale === 'en' ? searchHeaderData.price_category : searchHeaderData.price_category_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col :md="search.area_type_id === 1 ? '4' : '3'">
                          {{ $t('globalTrans.date') }}: <strong>{{ search.price_collection_date|dateFormat }}</strong>
                        </b-col>
                      </b-row>
                    </div>
                    <b-row >
                      <b-col>
                        <br/>
                        <slot v-if="datas.length>0">
                          <b-row  v-for="(data, firstIndex) in datas" :key="firstIndex" class="mt-r">
                            <b-col>
                              <h6><b>{{ $t('bazarMonitoring.market_name') }} : {{ $i18n.locale === 'en' ? data.market_directory : data.market_directory_bn }}</b></h6>
                              <b-table-simple class="tg mt-3 report-table" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                                <b-thead>
                                  <b-tr>
                                    <b-th rowspan="2" style="width:6%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                    <b-th rowspan="2" style="width:10%" class="text-center">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                                    <b-th rowspan="2" style="width:10%" class="text-center">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                                    <b-th rowspan="2" style="width:10%" class="text-center">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                                    <template v-for="(search, index) in search.frequency_type_id_check">
                                      <b-th style="width:17%" v-if="search === 1" colspan="4" :key="'day' + index" class="text-center">
                                        {{ $t('report.day_price') }} <br/> {{ dateList[0] | dateFormat }}
                                      </b-th>
                                      <b-th style="width:17%" v-else-if="search === 2" colspan="4" :key="'week' + index" class="text-center">
                                        {{ $t('report.week_price') }} <br/> {{ dateList[1] | dateFormat }}
                                      </b-th>
                                      <b-th style="width:17%" v-else-if="search === 3" colspan="4" :key="'month' + index" class="text-center">
                                        {{ $t('report.month_price') }} <br/> {{ dateList[2] | dateFormat }}
                                      </b-th>
                                      <b-th style="width:17%" v-else-if="search === 4" colspan="4" :key="'year' + index" class="text-center">
                                        {{ $t('report.year_price') }} <br/> {{ dateList[3] | dateFormat }}
                                      </b-th>
                                    </template>
                                  </b-tr>
                                  <b-tr>
                                    <template v-for="(search, index) in search.frequency_type_id_check">
                                      <b-th style="width:4%" class="text-center" :key="'L' + index">{{ $t('report.l') }}</b-th>
                                      <b-th style="width:4%" class="text-center" :key="'F' + index">{{ $t('report.h') }}</b-th>
                                      <b-th style="width:4%" class="text-center" :key="'tk' + index">{{ $t('report.tk') }}</b-th>
                                      <b-th style="width:4%" class="text-center" :key="'%' + index">{{ $t('report.%') }}</b-th>
                                    </template>
                                  </b-tr>
                                </b-thead>
                                <b-tbody>
                                  <template v-for="(group, index) in data.group">
                                    <template v-for="(commodity, index1) in group.commodity">
                                      <b-tr v-for="(info, index2) in commodity.list" :key="firstIndex + '_' + index + '_' + index1 + '_' + index2">
                                        <slot v-if="index1 == 0 && index2 == 0">
                                          <b-td class="text-center" :rowspan="group.rowspan" >{{ $n(index + 1) }}</b-td>
                                          <b-td class="text-center"  :rowspan="group.rowspan">{{ ($i18n.locale === 'bn') ? group.commodity_group_bn : group.commodity_group }}</b-td>
                                        </slot>
                                        <slot v-if="index2 == 0">
                                          <td class="text-center align-middle" :rowspan="commodity.list.length">
                                            {{ ($i18n.locale === 'bn') ? commodity.commodity_name_bn : commodity.commodity_name }}
                                          </td>
                                        </slot>
                                        <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.price_category_bn : info.price_category }}</b-td>
                                        <template v-for="search in search.frequency_type_id_check">
                                          <slot v-if="search === 1">
                                            <b-td class="text-center">{{ $n(info.lowest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center">{{ $n(info.highest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.today_taka_increase">
                                                <slot v-if="info.today_taka_increase < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.today_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.today_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.today_percenatage">
                                                <slot v-if="info.today_percenatage < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.today_percenatage.toFixed(2) )}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.today_percenatage.toFixed(2) )}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                          </slot>
                                          <slot v-else-if="search === 2">
                                            <b-td class="text-center">{{ $n(info.weekly_lowest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center">{{ $n(info.weekly_highest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.weekly_taka_increase">
                                                <slot v-if="info.weekly_taka_increase < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.weekly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.weekly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.weekly_percentage">
                                                <slot v-if="info.weekly_percentage < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.weekly_percentage.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.weekly_percentage.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                          </slot>
                                          <slot v-else-if="search === 3">
                                            <b-td class="text-center">{{ $n(info.monthly_lowest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center">{{ $n(info.monthly_highest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.monthly_taka_increase">
                                                <slot v-if="info.monthly_taka_increase < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.monthly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.monthly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.monthly_percentage">
                                                <slot v-if="info.monthly_percentage < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.monthly_percentage.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.monthly_percentage.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                          </slot>
                                          <slot v-else-if="search === 4">
                                            <b-td class="text-center">{{ $n(info.yearly_lowest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center">{{ $n(info.yearly_highest_price_amount.toFixed(2)) }}</b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.yearly_taka_increase">
                                                <slot v-if="info.yearly_taka_increase < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.yearly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.yearly_taka_increase.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                            <b-td class="text-center" style="width:150px !important; padding: 5px 0px 5px 0px">
                                              <slot v-if="info.yearly_percentage">
                                                <slot v-if="info.yearly_percentage < 0">
                                                  <span style="color: var(--success)">▼ {{$n(info.yearly_percentage.toFixed(2))}}</span>
                                                </slot>
                                                <slot v-else>
                                                  <span style="color: #FF0000;">▲ {{$n(info.yearly_percentage.toFixed(2))}}</span>
                                                </slot>
                                              </slot>
                                              <slot v-else><span>{{$n(0.00.toFixed(2))}}</span></slot>
                                            </b-td>
                                          </slot>
                                        </template>
                                      </b-tr>
                                    </template>
                                  </template>
                                </b-tbody>
                              </b-table-simple>
                            </b-col>
                          </b-row>
                        </slot>
                        <h4 v-else class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</h4>
                      </b-col>
                    </b-row>
                  </template>
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<style scoped>
.report-table  th,td {
  font-size: 11px;
  padding-left: 5px;
  padding-right: 5px;
}
.cursor-pointer{
  cursor: pointer;
}
</style>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceFluctuationReport, groupCategory } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
import { dateFormat } from '@/utils/fliter'
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
        commodity_group_id: 0,
        commodity_name_id: 0,
        market_directory_id: 0,
        frequency_type_id: [1, 2, 3, 4],
        frequency_type_id_check: [],
        price_category_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        price_collection_date: today
      },
      datas: [],
      searchHeaderData: {
        city_corporation_name: '',
        city_corporation_name_bn: '',
        pauroshoba_name: '',
        pauroshoba_name_bn: '',
        division_name: '',
        division_name_bn: '',
        district_name: '',
        district_name_bn: '',
        upazila_name: '',
        upazila_name_bn: '',
        union_name: '',
        union_name_bn: '',
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
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      showData: false,
      dateList: []
    }
  },
  created () {
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        divisionList: JSON.stringify(this.loggedUserPrivilege.division_id),
        districtList: JSON.stringify(this.loggedUserPrivilege.district_id),
        upazilaList: JSON.stringify(this.loggedUserPrivilege.upazila_id)
      })
    }
    this.headerDataExcel()
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
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report.price_fluctuation_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.price_fluctuation_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      }
      const division = this.$t('globalTrans.division') + ' : ' + (this.search.division_id ? (local === 'en' ? this.searchHeaderData.division_name : this.searchHeaderData.division_name_bn) : this.$t('globalTrans.all')) + ';  '
      const district = this.$t('globalTrans.district') + ' : ' + (this.search.district_id ? (local === 'en' ? this.searchHeaderData.district_name : this.searchHeaderData.district_name_bn) : this.$t('globalTrans.all')) + ';  '
      let hedearVal = ''
      hedearVal = division + district
      if (this.search.area_type_id === 1) {
        const cityCorporation = this.$t('globalTrans.city_corporation') + ' : ' + (this.search.city_corporation_id ? (local === 'en' ? this.searchHeaderData.city_corporation_name : this.searchHeaderData.city_corporation_name_bn) : this.$t('globalTrans.all')) + ';  '
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
      const market = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id ? (local === 'en' ? this.searchHeaderData.market_name_en : this.searchHeaderData.market_name_bn) : this.$t('globalTrans.all')) + ';  '
      const category = this.$t('bazarMonitoring.Price_category') + ' : ' + (this.search.price_category_id ? (local === 'en' ? this.searchHeaderData.price_category : this.searchHeaderData.price_category_bn) : this.$t('globalTrans.all')) + ';  '
      const priceCollection = this.$t('bazarMonitoring.Price_category') + ' : ' + (this.search.price_category_id ? (local === 'en' ? this.searchHeaderData.price_category : this.searchHeaderData.price_category_bn) : this.$t('globalTrans.all'))
      headerVal[6] = market + category + priceCollection
      return headerVal
    },
    excelFieldsOther: function () {
      let column = []
      if (this.$i18n.locale === 'bn') {
        column = {
          '': 'sl_no',
          ' ': 'commodity_group',
          '  ': 'commodity_name',
          '   ': 'price_category'
        }
      } else {
        column = {
          '': 'sl_no',
          ' ': 'commodity_group',
          '  ': 'commodity_name',
          '   ': 'price_category'
        }
      }
      this.search.frequency_type_id.forEach((search, index) => {
        if (search === 1) {
          column[this.currentLocale === 'en' ? 'Today’s Price (Tk.)' : 'আজকের দাম (টাকা)'] = 'cat_today_l'
          if (this.$i18n.locale === 'bn') {
            column.তারিখ = 'cat_today_h'
          } else {
            column.Date = 'cat_today_h'
          }
          column[':'] = 'cat_today_tk'
          column[dateFormat(this.dateList[0])] = 'cat_today_p'
        } else if (search === 2) {
          column[this.currentLocale === 'en' ? 'Week Price (Tk.)' : 'গত সপ্তাহের দাম (টাকা)'] = 'cat_week_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ '] = 'cat_week_h'
          } else {
            column['Date '] = 'cat_week_h'
          }
          column[': '] = 'cat_week_tk'
          column[dateFormat(this.dateList[1])] = 'cat_week_p'
        } else if (search === 3) {
          column[this.currentLocale === 'en' ? 'Month’s Price (Tk.)' : 'গত মাসের দাম (টাকা)'] = 'cat_month_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ  '] = 'cat_month_h'
          } else {
            column['Date  '] = 'cat_month_h'
          }
          column[dateFormat(this.dateList[2])] = 'cat_month_p'
        } else if (search === 4) {
          column[this.currentLocale === 'en' ? 'Year"s Price (Tk.)' : 'গত বছরের দাম (টাকা)'] = 'cat_year_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ   '] = 'cat_year_h'
          } else {
            column['Date   '] = 'cat_year_h'
          }
          column[':   '] = 'cat_year_tk'
          column[dateFormat(this.dateList[3])] = 'cat_year_p'
        }
      })
      return column
    },
    excelData: function () {
      if (this.datas.length <= 0) return []
        const excelData = []
        const firstData = {
          sl_no: this.currentLocale === 'en' ? 'SL No' : 'ক্রমিক নং',
          commodity_group: this.currentLocale === 'en' ? 'Commodity' : 'পণ্যের গ্রুপ',
          commodity_name: this.currentLocale === 'en' ? 'Commodity Name' : 'পণ্যের নাম',
          price_category: this.currentLocale === 'en' ? 'Price Category' : 'মূল্যের ধরণ'
        }
        this.search.frequency_type_id.forEach((search, index) => {
          if (search === 1) {
            firstData.cat_today_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
            firstData.cat_today_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
            firstData.cat_today_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
            firstData.cat_today_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
          } else if (search === 2) {
            firstData.cat_week_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
            firstData.cat_week_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
            firstData.cat_week_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
            firstData.cat_week_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
          } else if (search === 3) {
            firstData.cat_month_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
            firstData.cat_month_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
            firstData.cat_month_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
            firstData.cat_month_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
          } else if (search === 4) {
            firstData.cat_year_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
            firstData.cat_year_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
            firstData.cat_year_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
            firstData.cat_year_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
          }
        })
        excelData.push(firstData)
        this.datas.forEach((data, firstIndex) => {
          const market = (this.currentLocale === 'bn' ? data.market_directory_bn : data.market_directory)
          excelData.push({
            sl_no: this.currentLocale === 'en' ? 'Market Name : ' : 'বাজারের নাম : ',
            commodity_group: market
          })
          data.group.forEach((group, index) => {
            group.commodity.forEach((commodity, index1) => {
              commodity.list.forEach((info, index2) => {
                const newLoop = []
                if (index1 === 0 && index2 === 0) {
                  newLoop.sl_no = this.$n(index + 1)
                  newLoop.commodity_group = (this.currentLocale === 'bn' ? group.commodity_group_bn : group.commodity_group)
                } else {
                  newLoop.sl_no = ''
                  newLoop.commodity_group = ''
                }
                if (index2 === 0) {
                  newLoop.commodity_name = (this.currentLocale === 'bn' ? commodity.commodity_name_bn : commodity.commodity_name)
                } else {
                  newLoop.commodity_name = ''
                }
                newLoop.price_category = (this.currentLocale === 'bn' ? info.price_category_bn : info.price_category)
                this.search.frequency_type_id.forEach((search) => {
                  if (search === 1) {
                    newLoop.cat_today_l = this.$n(info.lowest_price_amount.toFixed(2))
                    newLoop.cat_today_h = this.$n(info.lowest_price_amount.toFixed(2))
                    newLoop.cat_today_tk = this.takaIncreament(info.today_taka_increase)
                    newLoop.cat_today_p = this.takaIncreament(info.today_percenatage)
                  } else if (search === 2) {
                    newLoop.cat_week_l = this.$n(info.weekly_lowest_price_amount.toFixed(2))
                    newLoop.cat_week_h = this.$n(info.weekly_highest_price_amount.toFixed(2))
                    newLoop.cat_week_tk = this.takaIncreament(info.weekly_taka_increase)
                    newLoop.cat_week_p = this.takaIncreament(info.weekly_percentage)
                  } else if (search === 3) {
                    newLoop.cat_month_l = this.$n(info.monthly_lowest_price_amount.toFixed(2))
                    newLoop.cat_month_h = this.$n(info.monthly_highest_price_amount.toFixed(2))
                    newLoop.cat_month_tk = this.takaIncreament(info.monthly_taka_increase)
                    newLoop.cat_month_p = this.takaIncreament(info.monthly_percentage)
                  } else if (search === 4) {
                    newLoop.cat_year_l = this.$n(info.yearly_lowest_price_amount.toFixed(2))
                    newLoop.cat_year_h = this.$n(info.yearly_highest_price_amount.toFixed(2))
                    newLoop.cat_year_tk = this.takaIncreament(info.yearly_taka_increase)
                    newLoop.cat_year_p = this.takaIncreament(info.yearly_percentage)
                  }
                })
                excelData.push(newLoop)
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
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    commodityGroupList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    },
    frequencyTypeList: function () {
       return this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList
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
    takaIncreament (dataField) {
      let takaIncrease = 0.00.toFixed(2)
      if (dataField) {
        if (dataField < 0) {
          takaIncrease = this.$n(dataField.toFixed(2))
        } else {
          takaIncrease = '+' + this.$n(dataField.toFixed(2))
        }
      }
      return takaIncrease
    },
    headerDataExcel () {
      RestApi.getData(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail/' + this.orgId).then(response => {
        if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === this.orgId)
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
        const reportTitle = this.$t('report.price_fluctuation_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this, this.datas, this.search, this.searchHeaderData)
    },
    searchData () {
      this.loadData()
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
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      if (this.search.commodity_group_id) {
        const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(data => data.value === this.search.commodity_group_id)
        this.searchHeaderData.commodity_group = commodityGroupObj !== undefined ? commodityGroupObj.text_en : ''
        this.searchHeaderData.commodity_group_bn = commodityGroupObj !== undefined ? commodityGroupObj.text_bn : ''
      }
      if (this.search.commodity_name_id) {
        const commodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(data => data.value === this.search.commodity_name_id)
        this.searchHeaderData.commodity_name = commodityNameObj !== undefined ? commodityNameObj.text_en : ''
        this.searchHeaderData.commodity_name_bn = commodityNameObj !== undefined ? commodityNameObj.text_bn : ''
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
      if (this.search.price_category_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(priceCategoryList => priceCategoryList.value === this.search.price_category_id)
        this.searchHeaderData.price_category = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.price_category_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceFluctuationReport, params)
      if (result.success) {
        this.search.frequency_type_id_check = this.search.frequency_type_id
        const weekPrice = result.data.weeks
        const monthPrice = result.data.months
        const yearPrice = result.data.years
        this.datas = []
        this.datas = result.data.givenDateReports.map((item) => {
          const marketDirectoryObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(data => data.value === parseInt(item.market_directory_id))
          const marketDirectoryData = {}
          if (typeof marketDirectoryObj !== 'undefined') {
            marketDirectoryData.market_directory = marketDirectoryObj.text_en
            marketDirectoryData.market_directory_bn = marketDirectoryObj.text_bn
          } else {
            marketDirectoryData.market_directory = ''
            marketDirectoryData.market_directory_bn = ''
          }
          item.group = item.group.map((item1) => {
            const commodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.find(data => data.value === parseInt(item1.commodity_group_id))
            const commodityGroupData = {}
            if (typeof marketDirectoryObj !== 'undefined') {
              commodityGroupData.commodity_group = commodityGroupObj.text_en
              commodityGroupData.commodity_group_bn = commodityGroupObj.text_bn
            } else {
              commodityGroupData.commodity_group = ''
              commodityGroupData.commodity_group_bn = ''
            }
            commodityGroupData.rowspan = this.checkAllRowSpan(item1.commodity)
            item1.commodity = item1.commodity.map((item2) => {
              const commodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(data2 => data2.value === parseInt(item2.commodity_name_id))
              const commodityNameData = {}
              if (typeof marketDirectoryObj !== 'undefined') {
                commodityNameData.commodity_name = commodityNameObj.text_en
                commodityNameData.commodity_name_bn = commodityNameObj.text_bn
              } else {
                commodityNameData.commodity_name = ''
                commodityNameData.commodity_name_bn = ''
              }
              item2.list = item2.list.map((item3) => {
                const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === parseInt(item3.price_category_id))
                const priceCategoryData = {}
                if (typeof marketDirectoryObj !== 'undefined') {
                    priceCategoryData.price_category = priceCategoryObj.text_en
                    priceCategoryData.price_category_bn = priceCategoryObj.text_bn
                } else {
                    priceCategoryData.price_category = ''
                    priceCategoryData.price_category_bn = ''
                }
                const todayPrice = {
                  today_avg: (item3.lowest_price_amount + item3.highest_price_amount) / 2,
                  today_percenatage: (parseFloat(item3.lowest_price_percentage) + parseFloat(item3.highest_price_percentage)) / 2
                }
                todayPrice.today_taka_increase = this.calculatePercentageTaka(todayPrice.today_avg, todayPrice.today_percenatage)
                const weekObj = weekPrice.find(weekPrice => parseInt(weekPrice.market_directory_id) === parseInt(item3.market_directory_id) && parseInt(weekPrice.commodity_name_id) === parseInt(item3.commodity_name_id) && parseInt(weekPrice.price_category_id) === parseInt(item3.price_category_id))
                const weekData = {}
                if (typeof weekObj !== 'undefined') {
                  weekData.weekly_lowest_price_amount = weekObj.lowest_price_amount
                  weekData.weekly_highest_price_amount = weekObj.highest_price_amount
                  weekData.weekly_avg = weekObj.average_price
                  weekData.weekly_percentage = this.calculatePercentage(todayPrice.today_avg, weekData.weekly_avg)
                  weekData.weekly_taka_increase = weekData.weekly_avg - todayPrice.today_avg
                } else {
                  weekData.weekly_lowest_price_amount = 0
                  weekData.weekly_highest_price_amount = 0
                  weekData.weekly_avg = 0
                  weekData.weekly_percentage = 0
                  weekData.weekly_taka_increase = 0
                }
                const monthObj = monthPrice.find(monthPrice => parseInt(monthPrice.market_directory_id) === parseInt(item3.market_directory_id) && parseInt(monthPrice.commodity_name_id) === parseInt(item3.commodity_name_id) && parseInt(monthPrice.price_category_id) === parseInt(item3.price_category_id))
                const monthData = {}
                if (typeof monthObj !== 'undefined') {
                  monthData.monthly_lowest_price_amount = monthObj.lowest_price_amount
                  monthData.monthly_highest_price_amount = monthObj.highest_price_amount
                  monthData.monthly_avg = monthObj.average_price
                  monthData.monthly_percentage = this.calculatePercentage(todayPrice.today_avg, monthData.monthly_avg)
                  monthData.monthly_taka_increase = monthData.monthly_avg - todayPrice.today_avg
                } else {
                  monthData.monthly_lowest_price_amount = 0
                  monthData.monthly_highest_price_amount = 0
                  monthData.monthly_avg = 0
                  monthData.monthly_percentage = 0
                  monthData.monthly_taka_increase = 0
                }
                const yearObj = yearPrice.find(yearPrice => parseInt(yearPrice.market_directory_id) === parseInt(item3.market_directory_id) && parseInt(yearPrice.commodity_name_id) === parseInt(item3.commodity_name_id) && parseInt(yearPrice.price_category_id) === parseInt(item3.price_category_id))
                const yearData = {}
                if (typeof yearObj !== 'undefined') {
                  yearData.yearly_lowest_price_amount = yearObj.lowest_price_amount
                  yearData.yearly_highest_price_amount = yearObj.highest_price_amount
                  yearData.yearly_avg = yearObj.average_price
                  yearData.yearly_percentage = this.calculatePercentage(todayPrice.today_avg, yearData.yearly_avg)
                  yearData.yearly_taka_increase = yearData.yearly_avg - todayPrice.today_avg
                } else {
                  yearData.yearly_lowest_price_amount = 0
                  yearData.yearly_highest_price_amount = 0
                  yearData.yearly_avg = 0
                  yearData.yearly_percentage = 0
                  yearData.yearly_taka_increase = 0
                }
                return Object.assign({}, item3, priceCategoryData, weekData, monthData, yearData, todayPrice)
              })
              return Object.assign({}, item2, commodityNameData)
            })
            return Object.assign({}, item1, commodityGroupData)
          })
          return Object.assign({}, item, marketDirectoryData)
        })
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        this.dateList = result.dateList
      } else {
        this.datas = []
        this.dateList = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    calculatePercentageTaka (oldAvg, newAvg) {
      const totalTaka = (oldAvg * newAvg) / 100
      return totalTaka
    },
    calculatePercentage (oldAvg, newAvg) {
      const diffAmt = parseFloat(newAvg) - parseFloat(oldAvg)
      const totalPercentage = (100 * diffAmt) / parseFloat(oldAvg)
      return totalPercentage
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
    getAreaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === id)
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
