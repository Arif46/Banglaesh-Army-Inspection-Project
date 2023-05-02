<template>
  <div class="inner-section">
    <card>
      <!-- formData section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.price') }} {{ $t('globalTrans.entry') }}</h4>
      </template>
      <!-- <template v-slot:searchHeaderAction>
         <router-link class="btn-add" to="/bazar-monitoring-service/commodity-price-market-monitoring/price-entry"><i class="ri-arrow-left-line"></i> {{ $t('priceMonitoring.price') }} {{ $t('globalTrans.list') }}</router-link>
      </template> -->
      <template v-slot:searchBody>
        <b-overlay :show="loadingState">
          <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form class="price-entry" id="form" @submit.prevent="handleSubmit(loadData)" @reset.prevent="reset" >
              <b-overlay :show="loading">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
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
                  <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
                      <ValidationProvider name="ward" vid="ward_id">
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
                  </b-col> -->
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Market Name" vid="market_directory_id" rules="required|min_value:1">
                          <b-form-group
                              label-for="market_directory_id"
                              slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{$t('bazarMonitoring.market_name')}}  <span class="text-danger">*</span>
                          </template>
                          <!-- <v-select :options="options" :filter-by="myFilter"></v-select> -->
                          <v-select name="cip_sector_id"
                            v-model="formData.market_directory_id"
                            label="text"
                            :reduce="item => item.value"
                            :options= marketDirectoryList
                            :placeholder="$t('globalTrans.select')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="$route.params.id ? true : false"
                            :filter-by="myFilter"
                          />
                          <!-- <b-form-select
                                plain
                                v-model="formData.market_directory_id"
                                :options="marketDirectoryList"
                                id="market_directory_id"
                                :state="errors[0] ? false : (valid ? true : null)"
                                :disabled="$route.params.id ? true : false"
                            >
                              <template v-slot:first>
                              <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select> -->
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col sm="4">
                    <ValidationProvider name="Price Collection Date" vid="price_collection_date" rules="required">
                    <b-form-group
                      label-for="price_collection_date"
                      slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{ $t('priceMonitoring.price_collection_date') }}  <span class="text-danger">*</span>
                      </template>
                        <date-picker
                          id="price_collection_date"
                          v-model="formData.price_collection_date"
                          class="form-control"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :placeholder="$t('globalTrans.select')"
                          :locale="currentLocale"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block" v-if="errors.length">
                          {{ errors[0] }}
                        </div>
                    </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Price Category" vid="Price_category" rules="required|min_value:1">
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
                        <div class="invalid-feedback d-block">
                          {{ errors[0] }}
                        </div>
                        </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="my-3">
                    <b-button type="submit" variant="success" class="btn-sm"><i class="ri-formData-line"></i> {{ $t('globalTrans.search') }}</b-button>
                  </b-col>
                </b-row>
              </b-overlay>
              <body-card v-if="commodityName">
                <template v-slot:headerTitle>
                  <h4 class="card-title">{{ $t('bazarMonitoring.commodity_name') }} {{ $t('globalTrans.search')}}</h4>
                </template>
                <template v-slot:body>
                  <b-row class="p-2">
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Commodity Group" vid="commodity_group_id">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="commodity_group_id">
                          <template v-slot:label>
                            {{ $t('bazarMonitoring.commodity_group') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="commodity_group_id"
                            :options="commodityGroupList"
                            v-model="formData.commodity_name.commodity_group_id"
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
                      <ValidationProvider name="Commodity Name" vid="commodity_name_id">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="commodity_name_id">
                          <template v-slot:label>
                            {{ $t('bazarMonitoring.commodity_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="commodity_name_id"
                            :options="commodityNameList"
                            v-model="formData.commodity_name.commodity_name_id"
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
                      <ValidationProvider name="Measurement Unit" vid="measurement_unit_id">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="measurement_unit_id">
                          <template v-slot:label>
                            {{ $t('bazarMonitoring.measurement_unit') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            id="measurement_unit_id"
                            :options="unitList"
                            v-model="formData.commodity_name.measurement_unit_id"
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
                  </b-row>
                </template>
              </body-card>
              <body-card v-if="formData.commodity_name.measurement_unit_id">
                <template v-slot:headerTitle>
                  <h4 class="card-title">{{ $t('priceMonitoring.category_wise_price_entry') }}</h4>
                </template>
                <template v-slot:body>
                  <b-table-simple style="width: 100%" hover small caption-top responsive bordered>
                    <template v-for="(item, index) in formData.priceCategory">
                      <b-tr :key='"header" + index'>
                        <b-th colspan="2" style="text-align:center;background: #eee;color: #283891">{{ ($i18n.locale==='bn') ? item.text_bn : item.text_en }}</b-th>
                      </b-tr>
                      <b-tr :key='"body" + index'>
                        <b-th style="text-align:center;line-height: 1rem;">
                          <ValidationProvider :vid="'lowest_pirce' + index" rules="required" name="Lowest Price Amount">
                            <b-form-group
                              class="mb-0"
                              slot-scope="{ valid, errors }"
                              label-cols-lg="3"
                              content-cols-lg="9"
                              :label="$t('priceMonitoring.lowest_price')"
                              label-for="lowest_price_amount">
                              <b-form-input
                                @input="setAvgPercentage(item, 'lowest_price_amount','lowest_price_percentage', item.commodity_name_id, item.price_category_id)"
                                :id="'lowest_price_amount' + index"
                                v-model="item.lowest_price_amount"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-th>
                        <b-th style="text-align:center;line-height: 1rem;">
                          <ValidationProvider :vid="'highest_price_amount' + index" rules="required" name="Lowest Price Amount">
                            <b-form-group
                              class="mb-0"
                              slot-scope="{ valid, errors }"
                              label-cols-lg="3"
                              content-cols-lg="9"
                              :label="$t('priceMonitoring.highest_price')"
                              label-for="highest_price_amount">
                              <b-form-input
                                @input="setAvgPercentage(item, 'highest_price_amount','highest_price_percentage', item.commodity_name_id, item.price_category_id)"
                                :id="'highest_price_amount' + index"
                                v-model="item.highest_price_amount"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-th>
                      </b-tr>
                    </template>
                    <b-tr :key='"footer"'>
                      <b-td colspan="2">
                        <button
                          @click="addMore"
                          class="btn btn-sm btn-success float-right my-2"
                          type="button"
                        ><i class="ri-add-fill"></i> {{$t('globalTrans.add_more')}}</button>
                      </b-td>
                    </b-tr>
                  </b-table-simple>
                </template>
              </body-card>
              <body-card v-if="formData.price_details.length">
                <template v-slot:headerTitle>
                  <h4 class="card-title">{{ $t('priceMonitoring.price') }} {{ $t('globalTrans.list')}}</h4>
                </template>
                <template v-slot:body>
                  <b-table-simple class="mb-0" hover small caption-top responsive bordered>
                    <b-tr style="background: #f9f9f9">
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('globalTrans.sl_no') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_group') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.commodity_name') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.measurement_unit') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('bazarMonitoring.Price_category') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" colspan="2" class="text-center">{{ $t('bazarMonitoring.lowest') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" colspan="2" class="text-center">{{ $t('bazarMonitoring.highest') }}</b-th>
                      <b-th style="width: 5%; vertical-align:middle" rowspan="2">{{ $t('globalTrans.action') }}</b-th>
                    </b-tr>
                    <b-tr style="background: #eee">
                      <b-th style="width: 5%">{{ $t('priceMonitoring.price_tk') }}</b-th>
                      <b-th style="width: 5%">
                        <i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>
                      </b-th>
                      <b-th style="width: 5%">{{ $t('priceMonitoring.price_tk') }}</b-th>
                      <b-th style="width: 5%">
                        <i class="text-success ri-arrow-down-line"></i><i class="text-danger ri-arrow-up-line"></i>
                      </b-th>
                    </b-tr>
                    <template v-for="(item, index) in formData.price_details">
                      <template v-for="(item1, index1) in item.price_category">
                        <b-tr :key="index + '_' + index1">
                          <b-td style="vertical-align:middle;text-align: center" v-if="index1 === 0" :rowspan="item.price_category.length">{{ $n(index+1) }}</b-td>
                          <b-td style="vertical-align:middle;text-align: center" v-if="index1 === 0" :rowspan="item.price_category.length">
                            {{ getColumnName(commodityGroupList,'value', item.commodity_group_id) }}
                          </b-td>
                          <b-td style="vertical-align:middle;text-align: center" v-if="index1 === 0" :rowspan="item.price_category.length">
                            {{ getColumnName($store.state.BazarMonitoringService.commonObj.commodityNameList,'value', item.commodity_name_id) }}
                          </b-td>
                          <b-td style="vertical-align:middle;text-align: center" v-if="index1 === 0" :rowspan="item.price_category.length">
                            {{ getColumnName($store.state.BazarMonitoringService.commonObj.unitList,'value', item.measurement_unit_id) }}
                          </b-td>
                          <b-td>
                            {{ getColumnName($store.state.BazarMonitoringService.commonObj.priceCategoryList,'value', parseInt(item1.price_category_id)) }}
                          </b-td>
                          <b-td :class="checkPercentage(item1.lowest_price_percentage, item.commodity_group_id, item1.price_category_id)">
                            <b-form-input
                              id="lowest_price_amount"
                              v-model="item1.lowest_price_amount"
                              @input="setAvgPercentage(item1, 'lowest_price_amount','lowest_price_percentage', item.commodity_name_id, item1.price_category_id)"
                            >
                            </b-form-input>
                          </b-td>
                          <b-td :class="checkPercentage(item1.lowest_price_percentage, item.commodity_group_id, item1.price_category_id)">{{item1.lowest_price_percentage}}</b-td>
                          <b-td :class="checkPercentage(item1.highest_price_percentage, item.commodity_group_id, item1.price_category_id)">
                            <!-- {{item1.highest_price_amount}} -->
                            <b-form-input
                              id="highest_price_amount"
                              v-model="item1.highest_price_amount"
                              @input="setAvgPercentage(item1, 'highest_price_amount','highest_price_percentage', item.commodity_name_id, item1.price_category_id)"
                            >
                            </b-form-input>
                          </b-td>
                          <b-td :class="checkPercentage(item1.highest_price_percentage, item.commodity_group_id, item1.price_category_id)">{{item1.highest_price_percentage}}</b-td>
                          <b-td style="vertical-align: middle;text-align: center;" v-if="index1 === 0" :rowspan="item.price_category.length">
                            <button variant="danger" @click="removeItem(index, item)" class="btn btn-danger" type="button">
                              <i class="ri-delete-bin-2-line"></i>
                            </button>
                          </b-td>
                        </b-tr>
                      </template>
                    </template>
                  </b-table-simple>
                </template>
              </body-card>
              <b-row class="text-right" v-if="formData.price_details.length">
                <b-col>
                  <b-button size="sm" variant="success" class="mt-20" @click="createData">
                    {{ saveBtnName }}
                  </b-button>
                  <router-link class="btn-sm btn btn-danger mt-20 ml-2" to="/bazar-monitoring-service/commodity-price-market-monitoring/price-entry">{{ $t('globalTrans.cancel') }}</router-link>
                </b-col>
              </b-row>
            </b-form>
          </ValidationObserver>
        </b-overlay>
      </template>
    </card>
  </div>
</template>
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
.price-entry .form-control {
  margin-bottom: 0px !important;
}
</style>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { pricepriceSearch, marketDirectoryCategory, priceEntryStore, groupCategory } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
// import AreaType from './AreaType'
const today = new Date().toISOString().substr(0, 10)
export default {
  mixins: [ModalBaseMasterList],
  components: {
    // AreaType
  },
  data () {
    return {
      saveBtnName: this.$route.params.id ? this.$t('globalTrans.update') : this.$t('globalTrans.submit'),
      formData: {
        id: 0,
        market_directory_id: null,
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
      myFilter: (option, text, search) => {
        const temp = search.toLowerCase()
        return option.text_en.toLowerCase().indexOf(temp) > -1 ||
        option.text_bn.toLowerCase().indexOf(temp) > -1
      },
      priceCategoryListData: []
    }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.formData = Object.assign({}, this.formData, {
        area_type_id: this.addressCustomUser.area_type_id,
        city_corporation_id: this.addressCustomUser.city_corporation_id,
        pauroshoba_id: this.addressCustomUser.pauroshoba_id,
        division_id: this.addressCustomUser.division_id,
        district_id: this.addressCustomUser.district_id,
        upazila_id: this.addressCustomUser.upazila_id,
        market_id: this.addressCustomUser.market_id
      })
    }
    const loadingState = { loading: false, listReload: false }
    this.$store.dispatch('mutateCommonProperties', loadingState)
    if (this.$route.params.id) {
      this.loadData(true)
    }
  },
  watch: {
    'formData.area_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.marketDirectoryList = this.getAreaMarketList(newVal)
      } else {
        this.marketDirectoryList = []
      }
    },
    'formData.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.marketDirectoryList = this.getDivMarketList(newVal)
      } else {
        this.districtList = []
        this.marketDirectoryList = []
      }
    },
    'formData.district_id': function (newVal, oldVal) {
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
    'formData.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
          this.marketDirectoryList = this.getUpaMarketList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
          this.marketDirectoryList = this.getDisMarketList(this.formData.district_id)
        }
    },
    'formData.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getCityMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'formData.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getPauroMarketList(newVal)
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
        if (newVal) {
          this.groupCategoryList(newVal)
        }
        this.commodityNameList = this.getCommodityNameList(newVal)
      } else {
        this.commodityNameList = []
      }
    },
    'formData.commodity_name.commodity_name_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unitList = this.getMeasurementUnit(newVal)
      } else {
        this.unitList = []
      }
    },
    'formData.commodity_name.measurement_unit_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getCategoryWiseCommodity(newVal)
      }
    }
  },
  computed: {
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
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
    async createData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bazarMonitoringServiceBaseUrl, priceEntryStore, this.formData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.params.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push('/bazar-monitoring-service/commodity-price-market-monitoring/price-entry')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    removeItem (index, data) {
      this.formData.price_details.splice(index, 1)
    },
    async getPriceCategory (id) {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = Object.assign({}, { market_directory_id: id })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketDirectoryCategory, params)
      if (result.success) {
        if (!this.$route.params.id) {
          this.formData.price_category_id = []
        }
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
        if (!this.$route.params.id) {
          this.formData.price_category_id = categoryList
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      } else {
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
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
    priceCategoryCustomize (groupWiseCategory) {
      const listData = []
      this.priceCategoryList.map((item, index) => {
        const priceCat = groupWiseCategory.find(item1 => item1.price_category_id === item.value)
        if (typeof priceCat !== 'undefined') {
          const newData = item
          item.lowest_price_amount = 0
          item.lowest_price_percentage = 0
          item.highest_price_amount = 0
          item.highest_price_percentage = 0
          item.price_category_id = priceCat.price_category_id
          listData.push(newData)
        }
      })
      this.formData.priceCategory = listData
    },
    addMore () {
      const isThere = this.formData.price_details.find(item1 => item1.commodity_name_id === this.formData.commodity_name.commodity_name_id)
      if (typeof isThere !== 'undefined') {
        const dataThere = this.formData.price_details.filter(function (element) {
          return element.commodity_name_id !== isThere.commodity_name_id
        })
        this.formData.price_details = dataThere
      }
      const newData = {
        commodity_group_id: this.formData.commodity_name.commodity_group_id,
        commodity_name_id: this.formData.commodity_name.commodity_name_id,
        measurement_unit_id: this.formData.commodity_name.measurement_unit_id,
        price_category: this.formData.priceCategory
      }
      this.formData.price_details.push(newData)
      this.commodityReset()
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
    async loadData (checkType = false) {
      let params = {}
      if (this.formData.market_directory_id && this.formData.price_collection_date) {
        params = {
          market_directory_id: this.formData.market_directory_id,
          price_collection_date: this.formData.price_collection_date,
          price_category: this.formData.price_category_id
        }
      }
      if (this.$route.params.id) {
        params = {
          id: this.$route.params.id,
          price_category: this.formData.price_category_id
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
        if (checkType) {
          this.formData.price_category_id = result.data.price_category_id
          const categoryList = []
          const listData = this.formData.price_category_id.map((item, index) => {
            const priceCategoryListObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(areaType => areaType.value === parseInt(item))
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
        // const commodityNames = this.getCustomDataList(result.data.commodity_names, false)
        this.formData.price_details = result.data.commodity_names
        this.commodityName = true
      } else {
        if (!result.validation) {
          this.formData.price_details = []
          this.$refs.form.setErrors(result.errors)
        } else {
          this.formData.id = 0
          this.formData.price_details = []
          if (result.data) {
            // const commodityNames = this.getCustomDataList(result.data.commodity_names, true)
            this.formData.price_details = result.data.commodity_names
          }
          this.commodityName = true
        }
      }
      this.prevData = result.prevData
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getCustomDataList (data, zeroVal) {
      const commodityNames = data.map((item, index) => {
        const itemCheck = []
        let formCategory = []
        this.formData.price_category_id.forEach(item5 => {
          const priceCat = this.groupCategory.find(item6 => item6.price_category_id === item5 && item6.commodity_group_id === item.commodity_group_id)
          if (typeof priceCat !== 'undefined') {
            formCategory.push(item5)
          }
        })
        const allreadyCat = []
        item.price_category.forEach((item1, index1) => {
          if (zeroVal) {
            item1.highest_price_percentage = 0
            item1.lowest_price_percentage = 0
          } else {
            formCategory = this.formData.price_category_id
          }
          formCategory.map((item2, index2) => {
            if (zeroVal) {
              item1.highest_price_percentage = 0
              item1.lowest_price_percentage = 0
            }
            if (parseInt(item2) === parseInt(item1.price_category_id)) {
              const priceCat = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(item3 => parseInt(item3.value) === parseInt(item1.price_category_id))
              item1.text_en = typeof priceCat !== 'undefined' ? priceCat.text_en : ''
              item1.text_bn = typeof priceCat !== 'undefined' ? priceCat.text_bn : ''
              itemCheck.push(item1)
              allreadyCat.push(item1.price_category_id)
            }
          })
        })
        const differences = formCategory.filter(x => !allreadyCat.includes(x))
        differences.forEach(item5 => {
          const newData = {}
          newData.price_category_id = item5
          newData.pecn_id = item.id
          const priceCat = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(item3 => parseInt(item3.value) === parseInt(item5))
          newData.text_en = typeof priceCat !== 'undefined' ? priceCat.text_en : ''
          newData.text_bn = typeof priceCat !== 'undefined' ? priceCat.text_bn : ''
          newData.lowest_price_amount = 0
          newData.lowest_price_percentage = 0
          newData.highest_price_amount = 0
          newData.highest_price_percentage = 0
          itemCheck.push(newData)
        })
        return Object.assign({}, item, { price_category: itemCheck })
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
    getWordMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.ward_id === id)
    },
    getMeasurementUnit (id) {
      return this.$store.state.BazarMonitoringService.commonObj.unitList.filter(item => item.status === 1 && item.commodity_name_id === id)
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
    checkPercentage (percentage, commodityGroupId, priceCategoryId) {
      const alertPercentage = this.$store.state.BazarMonitoringService.commonObj.alertList.find(alertList => alertList.price_category_id === parseFloat(priceCategoryId) && parseInt(alertList.commodity_group_id) === parseFloat(commodityGroupId))
      if (typeof alertPercentage !== 'undefined') {
        if (percentage >= alertPercentage.alert_percentage || percentage <= -alertPercentage.alert_percentage) {
          return 'bg-danger'
        }
      }
      return false
    },
    calculatePercentage (oldAvg, newAvg) {
      const diffAmt = parseFloat(newAvg) - parseFloat(oldAvg)
      const totalPercentage = (100 * diffAmt) / parseFloat(oldAvg)
      return totalPercentage
    },
    groupCategoryList (id) {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      RestApi.getData(bazarMonitoringServiceBaseUrl, groupCategory + id, null).then(response => {
        if (response.success) {
          const groupWiseCategory = response.data
          this.priceCategoryCustomize(groupWiseCategory)
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      })
    }
  }
}
</script>
