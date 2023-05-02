<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.commodity_wise_price_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-overlay :show="loading">
            <b-col lg="12" sm="12">
              <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" >
                  <b-row>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="commodity_group_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('bazarMonitoring.commodity_group')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="search.commodity_group_id"
                            :options="commodityGroupList"
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
                      <ValidationProvider name="Commodity Name" vid="commodity_name_id" rules="required|min_value:1">
                        <b-form-group
                          label-for="commodity_name_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.commodity_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="search.commodity_name_id"
                          :options="commodityNameList"
                          id="commodity_name_id"
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
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" rules="required|min_value:1">
                      <ValidationProvider name="0" vid="price_category_id">
                        <b-form-group
                          label-for="price_category_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{$t('bazarMonitoring.Price_category')}}
                        </template>
                          <v-select
                              id="price_category_id"
                              v-model="search.price_category_id"
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
                      <ValidationProvider name="0" vid="date">
                        <b-form-group
                          label-for="date"
                        >
                          <template v-slot:label>
                            {{ $t('globalTrans.date') }}
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
                <h4 class="card-title">{{ $t('report.commodity_wise_price_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <!-- <b-button @click="pdfExport" class="btn-add">
                  {{  $t('globalTrans.print') }}
                </b-button> -->
                <a href="javascript:" class="btn-add" @click="pdfExport"> {{ $t('globalTrans.print') }}</a>

                <!-- <a href="javascript:" class="btn-add" @click="pdfExport" v-b-modal.modal-form><i class="fas fa-print"></i> {{  $t('globalTrans.print') }}</a> -->
                <export-excel
                  class="btn-add ml-2"
                  :fields=excelFieldsOther
                  :data="excelData"
                  :title="headerValue"
                  worksheet="Report Sheet"
                  :default-value="headerExcelDefault"
                  name="commodity-wise-price-report.xls">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel>
              </template>
              <template v-slot:body>
                <b-overlay :show="loading">
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="bazarMonitoringServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="orgId">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('report.commodity_wise_price_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black mb-4">
                      <b-row>
                        <b-col>
                          {{ $t('bazarMonitoring.commodity_group') }}: <strong>{{ search.commodity_group_id ? ($i18n.locale === 'en' ? searchHeaderData.commodity_group : searchHeaderData.commodity_group_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          {{ $t('bazarMonitoring.commodity_name') }}: <strong>{{ search.commodity_name_id  ?  ($i18n.locale === 'en' ? searchHeaderData.commodity_name : searchHeaderData.commodity_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          {{ $t('bazarMonitoring.market_name') }}: <strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          {{ $t('globalTrans.date') }}: <strong>{{ search.price_collection_date|dateFormat }}</strong>
                        </b-col>
                      </b-row>
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
                    </div>
                    <b-row  v-for="(infoData, parentIndex) in datas" :key="parentIndex" class="mt-r">
                      <b-col>
                        <h5><b>{{ $t('bazarMonitoring.market_name') }} : {{ $i18n.locale === 'en' ? infoData.market_directory : infoData.market_directory_bn }}</b></h5>
                        <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                          <b-thead>
                            <b-tr>
                              <b-th rowspan="2" style="width:6%; font-size: 14px;" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th rowspan="2" style="width:12%; font-size: 14px;" class="text-center">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                              <template v-for="(search, index) in search.frequency_type_id_check">
                                <b-th v-if="search === 1" colspan="4" :key="index" style="width:20%; font-size: 14px;" class="text-center">
                                  {{ $t('report.day_price') }} <br/> {{ dateList[0] | dateFormat }}
                                </b-th>
                                <b-th v-else-if="search === 2" colspan="4" :key="index" style="width:20%" class="text-center">
                                  {{ $t('report.week_price') }} <br/> {{ dateList[1] | dateFormat }}
                                </b-th>
                                <b-th v-else-if="search === 3" colspan="4" :key="index" style="width:20%" class="text-center">
                                  {{ $t('report.month_price') }} <br/> {{ dateList[2] | dateFormat }}
                                </b-th>
                                <b-th v-else-if="search === 4" colspan="4" :key="index" style="width:20%" class="text-center">
                                  {{ $t('report.year_price') }} <br/> {{ dateList[3] | dateFormat }}
                                </b-th>
                              </template>
                            </b-tr>
                            <b-tr>
                              <template v-for="(search, index) in search.frequency_type_id_check">
                                <b-th class="text-center" :key="'L' + index">{{ $t('report.l') }}</b-th>
                                <b-th class="text-center" :key="'H' + index">{{ $t('report.h') }}</b-th>
                                <b-th class="text-center" :key="'tk' + index" style="width:150px !important; padding: 5px 0px 5px 0px">{{ $t('report.tk') }}</b-th>
                                <b-th class="text-center" :key="'%' + index" style="width:150px !important; padding: 5px 0px 5px 0px">{{ $t('report.%') }}</b-th>
                              </template>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <template>
                              <b-tr v-for="(info, index) in infoData.list" :key="index">
                                <b-td class="text-center" style="font-size: 12px;">{{ index + 1 }}</b-td>
                                <b-td class="text-center" style="font-size: 12px;">{{ ($i18n.locale === 'bn') ? info.price_category_bn : info.price_category }}</b-td>
                                <template v-for="search in search.frequency_type_id_check">
                                  <slot v-if="search === 1">
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.lowest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.highest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.weekly_lowest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.weekly_highest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.monthly_lowest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.monthly_highest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.yearly_lowest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;">{{ $n(info.yearly_highest_price_amount.toFixed(2)) }}</b-td>
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                                    <b-td class="text-center" style="font-size: 12px;width:150px !important; padding: 5px 0px 5px 0px">
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
                          </b-tbody>
                        </b-table-simple>
                      </b-col>
                    </b-row>
                  </template>
                    <!-- <span>
                        <hr>
                        <div class="text-center">
                          {{ $t('globalTrans.noDataFound') }}
                      </div>
                    </span> -->
                    <pre>{{searchHeader}}</pre>
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
import { CommodityWisePriceReportList, groupCategory } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import { dateFormat } from '@/utils/fliter'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
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
        commodity_group_id: 0,
        commodity_name_id: 0,
        market_directory_id: 0,
        frequency_type_id: [1, 2, 3, 4],
        frequency_type_id_check: [],
        price_category_id: [],
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        price_collection_date: today,
        limit: 20
      },
      searchHeaderData: {
        commodity_group: '',
        commodity_group_bn: '',
        commodity_name: '',
        commodity_name_bn: '',
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
      datas: [],
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
      dateList: []
    }
  },
  created () {
  },
  mounted () {
    this.headerDataExcel()
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_id: this.addressCustomUser.market_id,
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
      if (local === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report.commodity_wise_price_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.commodity_wise_price_report')
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
      const commodityGroup = this.$t('bazarMonitoring.commodity_group') + ' : ' + (this.search.commodity_group_id ? (this.$i18n.locale === 'en' ? this.searchHeaderData.commodity_group : this.searchHeaderData.commodity_group_bn) : this.$t('globalTrans.all')) + ';   '
      const commodityName = this.$t('bazarMonitoring.commodity_name') + ' : ' + (this.search.commodity_name_id ? (local === 'en' ? this.searchHeaderData.commodity_name : this.searchHeaderData.commodity_name_bn) : this.$t('globalTrans.all')) + ';   '
      const market = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id ? (local === 'en' ? this.searchHeaderData.market_name_en : this.searchHeaderData.market_name_bn) : this.$t('globalTrans.all')) + ';   '
      const dates = this.$t('globalTrans.date') + ' : ' + dateFormat(this.search.price_collection_date)
      headerVal[6] = commodityGroup + commodityName + market + dates
      return headerVal
    },
    excelFieldsOther: function () {
      let column = []
      if (this.$i18n.locale === 'bn') {
        column = {
          ' ': 'sl_no',
          '  ': 'price_category'
        }
      } else {
        column = {
          ' ': 'sl_no',
          '  ': 'price_category'
        }
      }
      this.search.frequency_type_id.forEach((search, index) => {
        if (this.$i18n.locale === 'bn') {
          if (search === 1) {
            column['আজকের দাম (টাকা)'] = 'cat_today_l'
            column.তারিখ = 'cat_today_h'
            column[':'] = 'cat_today_tk'
            column[dateFormat(this.dateList[0])] = 'cat_today_p'
          } else if (search === 2) {
            column['গত সপ্তাহের দাম (টাকা)'] = 'cat_week_l'
            column['তারিখ '] = 'cat_week_h'
            column[': '] = 'cat_week_tk'
            column[dateFormat(this.dateList[1])] = 'cat_week_p'
          } else if (search === 3) {
            column['গত মাসের দাম (টাকা)'] = 'cat_month_l'
            column['তারিখ  '] = 'cat_month_h'
            column[':  '] = 'cat_month_tk'
            column[dateFormat(this.dateList[2])] = 'cat_month_p'
          } else if (search === 4) {
            column['গত বছরের দাম (টাকা)'] = 'cat_year_l'
            column['তারিখ   '] = 'cat_year_h'
            column[':   '] = 'cat_year_tk'
            column[dateFormat(this.dateList[3])] = 'cat_year_p'
          }
        } else {
          if (search === 1) {
            column['Today’s Price (Tk.)'] = 'cat_today_l'
            column.Date = 'cat_today_h'
            column[':'] = 'cat_today_tk'
            column[dateFormat(this.dateList[0])] = 'cat_today_p'
          } else if (search === 2) {
            column['Week Price (Tk.)'] = 'cat_week_l'
            column['Date '] = 'cat_week_h'
            column[': '] = 'cat_week_tk'
            column[dateFormat(this.dateList[1])] = 'cat_week_p'
          } else if (search === 3) {
            column['Month’s Price (Tk.)'] = 'cat_month_l'
            column['Date  '] = 'cat_month_h'
            column[':  '] = 'cat_month_tk'
            column[dateFormat(this.dateList[2])] = 'cat_month_p'
          } else if (search === 4) {
            column['Year"s Price (Tk.)'] = 'cat_year_l'
            column['Date   '] = 'cat_year_h'
            column[':   '] = 'cat_year_tk'
            column[dateFormat(this.dateList[3])] = 'cat_year_p'
          }
        }
      })
      return column
    },
    excelData: function () {
      if (this.datas.length <= 0) return []
        const excelData = []
          const firstData = []
          if (this.$i18n.locale === 'bn') {
            firstData.sl_no = 'ক্রমিক নং'
            firstData.price_category = 'মূল্য বিভাগ'
          } else {
            // firstData.market = 'Market'
            firstData.sl_no = 'SL No'
            firstData.price_category = 'Price Category'
          }
          this.search.frequency_type_id.forEach((search, index) => {
            if (this.$i18n.locale === 'bn') {
              if (search === 1) {
                firstData.cat_today_l = 'সর্বনিম্ন'
                firstData.cat_today_h = 'সর্বোচ্চ'
                firstData.cat_today_tk = 'টাকা'
                firstData.cat_today_p = 'শতাংশ(%)'
              } else if (search === 2) {
                firstData.cat_week_l = 'সর্বনিম্ন'
                firstData.cat_week_h = 'সর্বোচ্চ'
                firstData.cat_week_tk = 'টাকা'
                firstData.cat_week_p = 'শতাংশ(%)'
              } else if (search === 3) {
                firstData.cat_month_l = 'সর্বনিম্ন'
                firstData.cat_month_h = 'সর্বোচ্চ'
                firstData.cat_month_tk = 'টাকা'
                firstData.cat_month_p = 'শতাংশ(%)'
              } else if (search === 4) {
                firstData.cat_year_l = 'সর্বনিম্ন'
                firstData.cat_year_h = 'সর্বোচ্চ'
                firstData.cat_year_tk = 'টাকা'
                firstData.cat_year_p = 'শতাংশ(%)'
              }
            } else {
              if (search === 1) {
                firstData.cat_today_l = 'Lowest'
                firstData.cat_today_h = 'Highest'
                firstData.cat_today_tk = 'Tk'
                firstData.cat_today_p = 'Percentage(%)'
              } else if (search === 2) {
                firstData.cat_week_l = 'Lowest'
                firstData.cat_week_h = 'Highest'
                firstData.cat_week_tk = 'Tk'
                firstData.cat_week_p = 'Percentage(%)'
              } else if (search === 3) {
                firstData.cat_month_l = 'Lowest'
                firstData.cat_month_h = 'Highest'
                firstData.cat_month_tk = 'Tk'
                firstData.cat_month_p = 'Percentage(%)'
              } else if (search === 4) {
                firstData.cat_year_l = 'Lowest'
                firstData.cat_year_h = 'Highest'
                firstData.cat_year_tk = 'Tk'
                firstData.cat_year_p = 'Percentage(%)'
              }
            }
          })
          excelData.push(firstData)
        this.datas.forEach((data, firstIndex) => {
          const market = (this.currentLocale === 'bn' ? data.market_directory_bn : data.market_directory)
          const topRow = {
            sl_no: this.currentLocale === 'en' ? 'Market Name : ' : 'বাজারের নাম : ',
            price_category: market
          }
          this.search.frequency_type_id.forEach((search, index) => {
            if (search === 1) {
              topRow.cat_today_l = '  '
              topRow.cat_today_h = '  '
              topRow.cat_today_tk = '  '
              topRow.cat_today_p = '  '
            } else if (search === 2) {
              topRow.cat_week_l = '  '
              topRow.cat_week_h = '  '
              topRow.cat_week_tk = '  '
              topRow.cat_week_p = '  '
            } else if (search === 3) {
              topRow.cat_month_l = '  '
              topRow.cat_month_h = '  '
              topRow.cat_month_tk = '  '
              topRow.cat_month_p = '  '
            } else if (search === 4) {
              topRow.cat_year_l = '  '
              topRow.cat_year_h = '   '
              topRow.cat_year_tk = '  '
              topRow.cat_year_p = '  '
            }
          })
          excelData.push(topRow)
          data.list.forEach((info, index) => {
            const newLoop = []
            // newLoop.market = market
            newLoop.sl_no = this.$n(index + 1)
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
      return excelData
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.entry') : this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.modify')
    },
    currentLocale () {
      return this.$i18n.locale
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
        const reportTitle = this.$t('report.commodity_wise_price_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this, this.datas, this.search, this.searchHeaderData)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.loading = true
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
      if (this.search.upazila_id) {
        const upazilaObj = this.$store.state.CommonService.commonObj.upazilaList.find(upazila => upazila.value === this.search.upazila_id)
        this.searchHeaderData.upazila_name = upazilaObj !== undefined ? upazilaObj.text_en : ''
        this.searchHeaderData.upazila_name_bn = upazilaObj !== undefined ? upazilaObj.text_bn : ''
      }
      if (this.search.pauroshoba_id) {
        const pauroshobaObj = this.$store.state.CommonService.commonObj.municipalityList.find(data => data.value === this.search.pauroshoba_id)
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
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, CommodityWisePriceReportList, params)
      if (result.success) {
        this.loading = false
        this.search.frequency_type_id_check = this.search.frequency_type_id
        const weekPrice = result.data.weeks
        const monthPrice = result.data.months
        const yearPrice = result.data.years
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
          item.list = item.list.map((item1) => {
            const todayPrice = {
              today_avg: (item1.lowest_price_amount + item1.highest_price_amount) / 2,
              today_percenatage: (parseFloat(item1.lowest_price_percentage) + parseFloat(item1.highest_price_percentage)) / 2
            }
            todayPrice.today_taka_increase = this.calculatePercentageTaka(todayPrice.today_avg, todayPrice.today_percenatage)
            const weekObj = weekPrice.find(weekPrice => parseInt(weekPrice.price_category_id) === parseInt(item1.price_category_id) && parseInt(weekPrice.market_directory_id) === parseInt(item1.market_directory_id) && parseInt(weekPrice.commodity_name_id) === parseInt(item1.commodity_name_id))
            const weekData = {}
            if (typeof weekObj !== 'undefined') {
              weekData.weekly_price_collection_date = weekObj.price_collection_date
              weekData.weekly_lowest_price_amount = weekObj.lowest_price_amount
              weekData.weekly_highest_price_amount = weekObj.highest_price_amount
              weekData.weekly_avg = weekObj.average_amount
              weekData.weekly_percentage = this.calculatePercentage(todayPrice.today_avg, weekData.weekly_avg)
              weekData.weekly_taka_increase = weekData.weekly_avg - todayPrice.today_avg
            } else {
              weekData.weekly_price_collection_date = ''
              weekData.weekly_lowest_price_amount = 0
              weekData.weekly_highest_price_amount = 0
              weekData.weekly_avg = 0
              weekData.weekly_percentage = 0
              weekData.weekly_taka_increase = 0
            }
            const monthObj = monthPrice.find(monthPrice => parseInt(monthPrice.price_category_id) === parseInt(item1.price_category_id) && parseInt(monthPrice.market_directory_id) === parseInt(item1.market_directory_id) && parseInt(monthPrice.commodity_name_id) === parseInt(item1.commodity_name_id))
            const monthData = {}
            if (typeof monthObj !== 'undefined') {
              monthData.monthly_price_collection_date = monthObj.price_collection_date
              monthData.monthly_lowest_price_amount = monthObj.lowest_price_amount
              monthData.monthly_highest_price_amount = monthObj.highest_price_amount
              monthData.monthly_avg = monthObj.average_amount
              monthData.monthly_percentage = this.calculatePercentage(todayPrice.today_avg, monthData.monthly_avg)
              monthData.monthly_taka_increase = monthData.monthly_avg - todayPrice.today_avg
            } else {
              monthData.monthly_price_collection_date = ''
              monthData.monthly_lowest_price_amount = 0
              monthData.monthly_highest_price_amount = 0
              monthData.monthly_avg = 0
              monthData.monthly_percentage = 0
              monthData.monthly_taka_increase = 0
            }
            const yearObj = yearPrice.find(yearPrice => parseInt(yearPrice.price_category_id) === parseInt(item1.price_category_id) && parseInt(yearPrice.market_directory_id) === parseInt(item1.market_directory_id) && parseInt(yearPrice.commodity_name_id) === parseInt(item1.commodity_name_id))
            const yearData = {}
            if (typeof yearObj !== 'undefined') {
              yearData.yearly_price_collection_date = yearObj.price_collection_date
              yearData.yearly_lowest_price_amount = yearObj.lowest_price_amount
              yearData.yearly_highest_price_amount = yearObj.highest_price_amount
              yearData.yearly_avg = yearObj.average_amount
              yearData.yearly_percentage = this.calculatePercentage(todayPrice.today_avg, yearData.yearly_avg)
              yearData.yearly_taka_increase = yearData.yearly_avg - todayPrice.today_avg
            } else {
              yearData.yearly_price_collection_date = ''
              yearData.yearly_lowest_price_amount = 0
              yearData.yearly_highest_price_amount = 0
              yearData.yearly_avg = 0
              yearData.yearly_percentage = 0
              yearData.yearly_taka_increase = 0
            }
            const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === parseInt(item1.price_category_id))
            const priceCategoryData = {}
            if (typeof marketDirectoryObj !== 'undefined') {
                priceCategoryData.price_category = priceCategoryObj.text_en
                priceCategoryData.price_category_bn = priceCategoryObj.text_bn
            } else {
                priceCategoryData.price_category = ''
                priceCategoryData.price_category_bn = ''
            }
            return Object.assign({}, item1, priceCategoryData, weekData, monthData, yearData, todayPrice)
          })
          return Object.assign({}, item, marketDirectoryData)
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
