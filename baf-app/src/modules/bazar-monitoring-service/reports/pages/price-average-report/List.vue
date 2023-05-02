<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('report.price_average_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-overlay>
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
                        <v-select
                            id="frequency_type"
                            v-model="search.frequency_type"
                            multiple
                            :reduce="op => op.value"
                            :options="frequencyTypeList"
                            label="text"
                            :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </v-select>
<!--                        <b-form-select-->
<!--                          plain-->
<!--                          v-model="search.frequency_type"-->
<!--                          :options="frequencyTypeList"-->
<!--                          id="frequency_type"-->
<!--                          :state="errors[0] ? false : (valid ? true : null)"-->
<!--                        >-->
<!--                          <template v-slot:first>-->
<!--                            <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>-->
<!--                          </template>-->
<!--                        </b-form-select>-->
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Price Category" vid="price_category_id" rules="">
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
                    <ValidationProvider name="Commodity Group">
                      <b-form-group
                        label-for="commodity_group_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{ $t('bazarMonitoring.commodity_group') }}
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
                <h4 class="card-title">{{ $t('report.price_average_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <a href="javascript:" class="btn-add" @click="pdfExport">
                   {{ $t('globalTrans.print') }}
                </a>
<!--                <a class="btn-add ml-2" target="_blank" :href="bazarMonitoringServiceBaseUrl + priceAverageReport + '?action=export-excel&lang='+currentLocale+'&report_title='+$t('report.price_average_report')+'&org_name='+org_name+'&org_name_bn='+org_name_bn+'&price_category_id='+ search.price_category_id+'&area_type_id='+search.area_type_id+'&division_id='+search.division_id+'&district_id='+search.district_id+'&upazila_id='+search.upazila_id+'&city_corporation_id='+search.city_corporation_id+'&pauroshoba_id='+search.pauroshoba_id+'&union_id='+search.union_id+'&market_directory_id='+search.market_directory_id+'&price_category_id='+search.price_category_id+'&frequency_type='+search.frequency_type+'&date='+search.date+'&search_header_data='+JSON.stringify(searchHeaderData)">-->
<!--                  {{  $t('globalTrans.export_excel') }}-->
<!--                </a>-->
                <!-- <b-button @click="pdfExport" class="btn-add">
                  {{  $t('globalTrans.print') }}
                </b-button> -->
                <!-- <a href="javascript:" class="btn-add" @click="pdfExport" v-b-modal.modal-form><i class="fas fa-print"></i> {{  $t('globalTrans.print') }}</a> -->
                <export-excel
                  class="btn-add ml-2"
                  :fields=excelFields
                  :data="excelData"
                  :title="headerValue"
                  worksheet="Report Sheet"
                  :before-generate = "headerDataExcel"
                  name="price_average_report.xls">
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
                        {{ $t('report.price_average_report') }}
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
                      <b-row class="mt-3">
                        <b-col>
                          <span>{{ $t('bazarMonitoring.market_name') }}: </span><strong>{{ search.market_directory_id ? ($i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('report.frequency_type') }}: </span><strong>{{ search.frequency_type.length ? ($i18n.locale === 'en' ? searchHeaderData.frequency_name : searchHeaderData.frequency_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('bazarMonitoring.Price_category') }}: </span><strong>{{ search.price_category_id  ?  ($i18n.locale === 'en' ? searchHeaderData.price_category_name : searchHeaderData.price_category_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col>
                          <span>{{ $t('globalTrans.date') }}: </span><strong>{{ search.date|dateFormat }}</strong>
                        </b-col>
                      </b-row>
                      <b-row class="mt-3">
                        <b-col md="3" lg="3">
                          <span>{{ $t('bazarMonitoring.commodity_group') }}: </span><strong>{{ search.commodity_group_id.length ? ($i18n.locale === 'en' ? searchHeaderData.commodity_group_name_en : searchHeaderData.commodity_group_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="3" lg="3">
                          <span>{{ $t('bazarMonitoring.commodity_name') }}: </span><strong>{{ search.commodity_name_id.length ? ($i18n.locale === 'en' ? searchHeaderData.commodity_name_en : searchHeaderData.commodity_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </b-row>
                    </div>
                    <b-row >
                      <b-col>
                        <b-table-simple sticky-header class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                          <b-thead>
                            <b-tr>
                              <b-th stickyColumn rowspan="2" style="width:7%" class="text-center first-column">{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th stickyColumn rowspan="2" style="width:13%" class="text-center second-column">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                              <b-th stickyColumn rowspan="2" style="width:13%" class="text-center third-column">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                              <b-th stickyColumn rowspan="2" style="width:13%" class="text-center fourth-column">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                              <template v-for="(info, index) in frequencyDateArr">
                                <b-th stickyColumn colspan="4" :key="index" style="width:20%" class="text-center rightzindex">
                                  {{ currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn }} {{ info.frequency_date | dateFormat }}
                                </b-th>
                              </template>
                            </b-tr>
                            <b-tr>
                              <template v-for="(info, index) in frequencyDateArr">
                                <b-th stickyColumn class="text-center underzindex" :class="currentLocale === 'bn' ? 'top-75' : 'top-58'" :key="'L' + index">{{ $t('report.l') }}</b-th>
                                <b-th stickyColumn class="text-center underzindex" :class="currentLocale === 'bn' ? 'top-75' : 'top-58'" :key="'F' + index">{{ $t('report.h') }}</b-th>
                                <b-th stickyColumn class="text-center underzindex" :class="currentLocale === 'bn' ? 'top-75' : 'top-58'" :key="'tk' + index"><i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>{{ $t('report.tk') }}</b-th>
                                <b-th stickyColumn class="text-center underzindex" :class="currentLocale === 'bn' ? 'top-75' : 'top-58'" :key="'%' + index"><i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>{{ $t('report.%') }}</b-th>
                              </template>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <template v-if="listData.length">
                              <template v-for="(item, index) in listData">
                                <template v-for="(commodityNameInfo, commodityNameInfoIndex) in item.commodity_name_info">
                                  <template v-for="(priceCategoryInfo, priceCategoryInfoIndex) in commodityNameInfo.price_category_info">
                                    <b-tr :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex">
                                      <slot v-if="commodityNameInfoIndex === 0 && priceCategoryInfoIndex === 0">
                                        <b-td stickyColumn class="text-center first-column" :rowspan="(item.total_rows > 1 ? item.total_rows : null)">{{ $n(index + 1) }}</b-td>
                                        <b-td stickyColumn class="text-center second-column" :rowspan="(item.total_rows > 1 ? item.total_rows : null)">{{ ($i18n.locale === 'en') ? item.commodity_group_name_en : item.commodity_group_name_bn }}</b-td>
                                      </slot>
                                      <b-td stickyColumn v-if="priceCategoryInfoIndex === 0" class="text-center third-column" :rowspan="(commodityNameInfo.price_category_info.length > 1 ? commodityNameInfo.price_category_info.length : null)">{{ ($i18n.locale === 'en') ? commodityNameInfo.commodity_name_en : commodityNameInfo.commodity_name_bn }}</b-td>
                                      <b-td stickyColumn class="text-center fourth-column">{{ ($i18n.locale === 'en') ? priceCategoryInfo.price_category_name_en : priceCategoryInfo.price_category_name_bn }}</b-td>
                                      <template v-for="(frequencyItem, frequencyIndex) in priceCategoryInfo.frequency_type_info">
                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-1-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.lowest_price_amount) }}</b-td>
                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-2-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.highest_price_amount) }}</b-td>
<!--                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-3-'+frequencyIndex" class="text-center">{{ getFluctuationRate(frequencyItem) }}</b-td>-->
                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-3-'+frequencyIndex" class="text-center">
                                            <span v-if="frequencyItem.fluctuation_rate > 0" style="color: #FF0000;">▲ {{ $n(frequencyItem.fluctuation_rate) }}</span>
                                            <span v-else-if="frequencyItem.fluctuation_rate < 0" style="color: var(--success)">▼ {{ $n(frequencyItem.fluctuation_rate) }}</span>
                                            <span v-else>{{ $n(frequencyItem.fluctuation_rate) }}</span>
                                        </b-td>
<!--                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-4-'+frequencyIndex" class="text-center">{{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</b-td>-->
                                        <b-td :key="'I-' + index + '-N-' + commodityNameInfoIndex + '-C-' + priceCategoryInfoIndex + '-f-4-'+frequencyIndex" class="text-center">
                                          <span v-if="frequencyItem.fluctuation_rate_percentage > 0" style="color: #FF0000;">▲ {{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</span>
                                          <span v-else-if="frequencyItem.fluctuation_rate_percentage < 0" style="color: var(--success)">▼ {{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</span>
                                          <span v-else>{{ $n(frequencyItem.fluctuation_rate_percentage) + '%' }}</span>
                                        </b-td>
                                      </template>
                                    </b-tr>
                                  </template>
                                </template>
                              </template>
                            </template>
                            <template v-else>
                              <b-tr>
                                <b-td class="text-center" :colspan="4 + (4 * frequencyDateArr.length)">{{ $t('globalTrans.noDataFound') }}</b-td>
                              </b-tr>
                            </template>
                          </b-tbody>
                        </b-table-simple>
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
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceAverageReport, groupCategory } from '../../api/routes'
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
        commodity_group_id: [],
        commodity_name_id: [],
        market_directory_id: 0,
        frequency_type: [1, 2, 3, 4, 5, 6],
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
        commodity_group_name_en: '',
        commodity_group_name_bn: '',
        commodity_name_en: '',
        commodity_name_bn: '',
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
      // loading: false,
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      showData: false,
      frequencyDateArr: [],
      listData: [],
      priceAverageReport: priceAverageReport,
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
    loading () {
      return this.$store.state.commonObj.loading
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
      } else {
        const upazila = this.$t('globalTrans.upazila') + ' : ' + (this.search.upazila_id ? (local === 'en' ? this.searchHeaderData.upazila_name : this.searchHeaderData.upazila_name_bn) : this.$t('globalTrans.all')) + ';  '
        hedearVal = hedearVal + upazila
        if (this.search.area_type_id === 2) {
          const pouroshova = this.$t('globalTrans.pouroshova') + ' : ' + (this.search.pauroshoba_id ? (local === 'en' ? this.searchHeaderData.pauroshoba_name : this.searchHeaderData.pauroshoba_name_bn) : this.$t('globalTrans.all')) + ';  '
          hedearVal = hedearVal + pouroshova
        } else {
          const unionName = this.$t('globalTrans.union') + ' : ' + (this.search.union_id ? (local === 'en' ? this.searchHeaderData.union_name : this.searchHeaderData.union_name_bn) : this.$t('globalTrans.all')) + ';  '
          hedearVal = hedearVal + unionName
        }
      }
      headerVal[5] = hedearVal
      const market = this.$t('bazarMonitoring.market_name') + ' : ' + (this.search.market_directory_id ? (local === 'en' ? this.searchHeaderData.market_name_en : this.searchHeaderData.market_name_bn) : this.$t('globalTrans.all')) + ';  '
      const frequency = this.$t('report.frequency_type') + ' : ' + (this.search.frequency_type.length ? (local === 'en' ? this.searchHeaderData.frequency_name : this.searchHeaderData.frequency_name_bn) : this.$t('globalTrans.all')) + ';  '
      const category = this.$t('bazarMonitoring.Price_category') + ' : ' + (this.search.price_category_id ? (local === 'en' ? this.searchHeaderData.price_category : this.searchHeaderData.price_category_bn) : this.$t('globalTrans.all')) + ';  '
      const dateInfo = this.$t('globalTrans.date') + ' : ' + this.$options.filters.dateFormat(this.search.date)
      headerVal[6] = market + frequency + category + dateInfo
      const commodityGroupInfo = this.$t('bazarMonitoring.commodity_group') + ' : ' + (this.search.commodity_group_id.length ? (local === 'en' ? this.searchHeaderData.commodity_group_name_en : this.searchHeaderData.commodity_group_name_bn) : this.$t('globalTrans.all')) + ';  '
      const commodityNameInfo = this.$t('bazarMonitoring.commodity_name') + ' : ' + (this.search.commodity_name_id.length ? (local === 'en' ? this.searchHeaderData.commodity_name_en : this.searchHeaderData.commodity_name_bn) : this.$t('globalTrans.all')) + ';  '
      headerVal[7] = commodityGroupInfo + commodityNameInfo
      return headerVal
    },
    excelFields: function () {
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
      this.frequencyDateArr.forEach((info, index) => {
        if (info.frequency_type === 1) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_today_l'
          if (this.$i18n.locale === 'bn') {
            column.তারিখ = 'cat_today_h'
          } else {
            column.Date = 'cat_today_h'
          }
          column[':'] = 'cat_today_tk'
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_today_p'
        } else if (info.frequency_type === 2) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_week_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ '] = 'cat_week_h'
          } else {
            column['Date '] = 'cat_week_h'
          }
          column[': '] = 'cat_week_tk'
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_week_p'
        } else if (info.frequency_type === 3) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_month_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ  '] = 'cat_month_h'
          } else {
            column['Date  '] = 'cat_month_h'
          }
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_month_p'
        } else if (info.frequency_type === 4) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_quarter_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ    '] = 'cat_quarter_h'
          } else {
            column['Date    '] = 'cat_quarter_h'
          }
          column[':    '] = 'cat_quarter_tk'
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_quarter_p'
        } else if (info.frequency_type === 5) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_half_year_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ     '] = 'cat_half_year_h'
          } else {
            column['Date     '] = 'cat_half_year_h'
          }
          column[':     '] = 'cat_half_year_tk'
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_half_year_p'
        } else if (info.frequency_type === 6) {
          column[this.currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn] = 'cat_year_l'
          if (this.$i18n.locale === 'bn') {
            column['তারিখ      '] = 'cat_year_h'
          } else {
            column['Date      '] = 'cat_year_h'
          }
          column[':      '] = 'cat_year_tk'
          column[this.$options.filters.dateFormat(info.frequency_date)] = 'cat_year_p'
        }
      })
      return column
    },
    excelData: function () {
      if (this.listData.length <= 0) return []
      const excelData = []
      const firstData = {
        sl_no: this.currentLocale === 'en' ? 'SL No' : 'ক্রমিক নং',
        commodity_group: this.currentLocale === 'en' ? 'Commodity' : 'পণ্যের গ্রুপ',
        commodity_name: this.currentLocale === 'en' ? 'Commodity Name' : 'পণ্যের নাম',
        price_category: this.currentLocale === 'en' ? 'Price Category' : 'মূল্যের ধরণ'
      }
      this.frequencyDateArr.forEach((info, index) => {
        if (info.frequency_type === 1) {
          firstData.cat_today_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_today_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_today_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_today_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        } else if (info.frequency_type === 2) {
          firstData.cat_week_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_week_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_week_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_week_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        } else if (info.frequency_type === 3) {
          firstData.cat_month_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_month_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_month_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_month_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        } else if (info.frequency_type === 4) {
          firstData.cat_quarter_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_quarter_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_quarter_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_quarter_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        } else if (info.frequency_type === 5) {
          firstData.cat_half_year_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_half_year_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_half_year_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_half_year_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        } else if (info.frequency_type === 6) {
          firstData.cat_year_l = this.currentLocale === 'en' ? 'Lowest' : 'সর্বনিম্ন'
          firstData.cat_year_h = this.currentLocale === 'en' ? 'Highest' : 'সর্বোচ্চ'
          firstData.cat_year_tk = this.currentLocale === 'en' ? 'Tk' : 'টাকা'
          firstData.cat_year_p = this.currentLocale === 'en' ? 'Percentage' : 'শতাংশ(%)'
        }
      })
      excelData.push(firstData)
      this.listData.forEach((item, index) => {
        item.commodity_name_info.forEach((commodityNameInfo, commodityNameInfoIndex) => {
          commodityNameInfo.price_category_info.forEach((priceCategoryInfo, priceCategoryInfoIndex) => {
            const rowItem = {}
            if (commodityNameInfoIndex === 0 && priceCategoryInfoIndex === 0) {
              rowItem.sl_no = this.$n(index + 1)
              rowItem.commodity_group = (this.currentLocale === 'en' ? item.commodity_group_name_en : item.commodity_group_name_bn)
            } else {
              rowItem.sl_no = ' '
              rowItem.commodity_group = ' '
            }
            if (priceCategoryInfoIndex === 0) {
              rowItem.commodity_name = (this.currentLocale === 'en' ? commodityNameInfo.commodity_name_en : commodityNameInfo.commodity_name_bn)
            } else {
              rowItem.commodity_name = ' '
            }
            rowItem.price_category = (this.currentLocale === 'en' ? priceCategoryInfo.price_category_name_en : priceCategoryInfo.price_category_name_bn)
            priceCategoryInfo.frequency_type_info.forEach((frequencyItem, frequencyIndex) => {
              if (frequencyItem.frequency_type === 1) {
                rowItem.cat_today_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_today_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_today_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_today_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              } else if (frequencyItem.frequency_type === 2) {
                rowItem.cat_week_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_week_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_week_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_week_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              } else if (frequencyItem.frequency_type === 3) {
                rowItem.cat_month_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_month_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_month_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_month_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              } else if (frequencyItem.frequency_type === 4) {
                rowItem.cat_quarter_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_quarter_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_quarter_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_quarter_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              } else if (frequencyItem.frequency_type === 5) {
                rowItem.cat_half_year_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_half_year_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_half_year_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_half_year_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              } else if (frequencyItem.frequency_type === 6) {
                rowItem.cat_year_l = this.$n(frequencyItem.lowest_price_amount)
                rowItem.cat_year_h = this.$n(frequencyItem.highest_price_amount)
                rowItem.cat_year_tk = this.getFluctuationRate(frequencyItem, 'fluctuation_rate')
                rowItem.cat_year_p = this.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage')
              }
            })
            excelData.push(rowItem)
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
       return this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList2
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
        this.corporationList = this.getCityCorporationList(newVal)
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
        const reportTitle = this.$t('report.price_average_report')
        ExportPdf.exportPdfDetails(bazarMonitoringServiceBaseUrl, '/configuration/report-head/detail', this.orgId, reportTitle, this)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: true })
      if (this.search.price_category_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === this.search.price_category_id)
        this.searchHeaderData.price_category_name = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.price_category_name_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      if (this.search.frequency_type.length) {
        const arrEn = []
        const arrBn = []
        this.search.frequency_type.forEach(item => {
          const frequencyType = this.$store.state.BazarMonitoringService.commonObj.frequencyTypeList2.find(data => data.value === parseInt(item))
          if (frequencyType !== undefined) {
            arrEn.push(frequencyType.text_en)
            arrBn.push(frequencyType.text_bn)
          }
        })
        this.searchHeaderData.frequency_name = arrEn.toString()
        this.searchHeaderData.frequency_name_bn = arrBn.toString()
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
      if (this.search.commodity_group_id.length) {
        const arrEn = []
        const arrBn = []
        this.search.commodity_group_id.forEach(item => {
          const commodityGroup = this.commodityGroupList.find(obj => obj.value === parseInt(item))
          if (commodityGroup !== undefined) {
            arrEn.push(commodityGroup.text_en)
            arrBn.push(commodityGroup.text_bn)
          }
        })
        this.searchHeaderData.commodity_group_name_en = arrEn.toString()
        this.searchHeaderData.commodity_group_name_bn = arrBn.toString()
      }
      if (this.search.commodity_name_id.length) {
        const arrEn = []
        const arrBn = []
        this.search.commodity_name_id.forEach(item => {
          const commodityName = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(obj => obj.value === parseInt(item))
          if (commodityName !== undefined) {
            arrEn.push(commodityName.text_en)
            arrBn.push(commodityName.text_bn)
          }
        })
        this.searchHeaderData.commodity_name_en = arrEn.toString()
        this.searchHeaderData.commodity_name_bn = arrBn.toString()
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      // this.loading = true
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceAverageReport, params)
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
                frequency_text_en: this.$t('report.last_quarter_price_tk', 'en'),
                frequency_text_bn: this.$t('report.last_quarter_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            } else if (parseInt(frequency) === 5) {
              frequencyItem = {
                frequency_type: parseInt(frequency),
                frequency_text_en: this.$t('report.last_half_years_price_tk', 'en'),
                frequency_text_bn: this.$t('report.last_half_years_price_tk', 'bn'),
                frequency_date: frequencyDate
              }
              frequencyArr.push(frequencyItem)
            } else if (parseInt(frequency) === 6) {
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
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      // this.loading = false
    },
    getCustomizedList (data) {
      const list = data.map(item => {
        item.commodity_name_info = item.commodity_name_info.map(commodityNameInfo => {
          commodityNameInfo.price_category_info = commodityNameInfo.price_category_info.map(priceCategoryInfo => {
            const frequencyTypeInfo = []
            this.frequencyDateArr.forEach((frequencyItem, frequencyIndex) => {
              let frequencyInfo
              frequencyInfo = priceCategoryInfo.frequency_type_info.find(obj => parseInt(obj.frequency_type) === parseInt(frequencyItem.frequency_type))
              if (frequencyInfo === undefined) {
                frequencyInfo = {
                  frequency_type: parseInt(frequencyItem.frequency_type),
                  lowest_price_amount: 0,
                  highest_price_amount: 0,
                  fluctuation_rate: 0,
                  fluctuation_rate_percentage: 0
                }
              }
              frequencyTypeInfo.push(frequencyInfo)
            })
            priceCategoryInfo.frequency_type_info = frequencyTypeInfo
            const priceCategory = this.priceCategoryList.find(obj => obj.value === parseInt(priceCategoryInfo.price_category_id))
            const customItem = {
              price_category_name_en: priceCategory?.text_en,
              price_category_name_bn: priceCategory?.text_bn
            }
            return Object.assign({}, priceCategoryInfo, customItem)
          })
          const commodityName = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(obj => obj.value === parseInt(commodityNameInfo.commodity_name_id))
          const customItem = {
            commodity_name_en: commodityName?.text_en,
            commodity_name_bn: commodityName?.text_bn
          }
          return Object.assign({}, commodityNameInfo, customItem)
        })
        const commodityGroup = this.commodityGroupList.find(obj => obj.value === parseInt(item.commodity_group_id))
        const customItem = {
          commodity_group_name_en: commodityGroup?.text_en,
          commodity_group_name_bn: commodityGroup?.text_bn
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
    getCityCorporationList (id) {
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
          if (this.search.commodity_name_id.length) {
            const idArr = []
            this.search.commodity_name_id.forEach(id => {
              const commodityName = this.commodityNameList.find(obj => obj.value === parseInt(id))
              if (commodityName !== undefined) {
                idArr.push(parseInt(commodityName.value))
              }
            })
            this.search.commodity_name_id = idArr
          }
        } else {
          this.commodityNameList = []
          this.search.commodity_name_id = []
        }
      }
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
    getFluctuationRate (frequencyItem, property) {
      return (frequencyItem[property] > 0 ? '+' : '') + this.$n(frequencyItem[property])
    }
  }
}
</script>
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

.first-colulm {
  width: 85px;
  min-width: 85px;
  max-width: 85px;
  left: 0px;
  background-color: white !important;
  z-index: 3;
}

.second-column {
  width: 131px;
  min-width: 205px;
  max-width: 205px;
  left: 42px !important;
  background-color: white !important;
  z-index: 3;
}

.third-column {
  width: 131px;
  min-width: 205px;
  max-width: 205px;
  left: 240px !important;
  background-color: white !important;
  z-index: 3;
}
.fourth-column {
  width: 131px;
  min-width: 205px;
  max-width: 205px;
  left: 430px !important;
  background-color: white !important;
  z-index: 3;
}
.underzindex {
  z-index: 3 !important;
}
.top-75 {
  top: 75px !important;
}
.top-58 {
  top: 58px !important;
}
/* .b-table-sticky-header > .table.b-table > thead > tr > th {
  position: sticky !important;
  top: 0;
} */
.topzindex {
  z-index: 5 !important;
}
.rightzindex {
  z-index: 4 !important;
}

/* .tableFixHead >.b-table-sticky-header > .table.b-table > thead > tr > th {
  position: sticky !important;
  top: 0;
  font-size: 15px  !important;
} */
.b-table-sticky-header {
  overflow-y: auto;
  max-height: 400px !important;
}
</style>
