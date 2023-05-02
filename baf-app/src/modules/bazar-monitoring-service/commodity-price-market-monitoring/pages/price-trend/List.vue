<template>
  <div class="inner-section" style="overflow-x: hidden;">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('priceMonitoring.price_trend') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-card>
          <b-tabs v-model="tabIndex">
            <b-row>
              <b-tab :title="$t('priceMonitoring.commodity_price_growth')" class="mt-3">
                <ValidationProvider name="Price Collection Date" vid="price_collection_date" rules="required|min_value:1">
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                      <b-form-group
                      class="row"
                      label-cols-sm="4"
                      label-for="price_collection_date"
                      >
                      <template v-slot:label>
                          {{ $t('priceMonitoring.price_collection_date') }} <span class="text-danger">*</span>
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
                </ValidationProvider>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Duration" vid="duration" rules="required|min_value:1">
                      <b-form-group
                          label-for="duration"
                          slot-scope="{ valid, errors }"
                          class="row"
                          label-cols-sm="4"
                      >
                      <template v-slot:label>
                          {{$t('priceMonitoring.duration')}} <span class="text-danger">*</span>
                      </template>
                      <span> {{$t('priceMonitoring.last')}}  </span>
                      <b-form-select
                          plain
                          v-model="search.duration"
                          :options="durationList"
                          id="duration"
                          :state="errors[0] ? false : (valid ? true : null)"
                          style="display: inline-block; width:70%"
                      >
                          <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                      </b-form-select>
                        <span> {{$t('priceMonitoring.day')}}  </span>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Price Veriation" vid="price_veriation" rules="required" v-slot="{ errors }">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="activity"
                          >
                          <template v-slot:label>
                          {{ $t('priceMonitoring.price_veriation') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-radio-group
                                v-model="search.price_veriation"
                                :options="priceVeriationList"
                                class="mb-3"
                                value-field="value"
                                text-field="text"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-radio-group>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="commodity_group_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.commodity_group')}} <span class="text-danger">*</span>
                    </template>
                        <v-select
                            id="commodity_group_id"
                            v-model="search.commodity_group_id"
                            multiple
                            :reduce="op => op.value"
                            :options="commodityGroupList"
                            label="text"
                            v-on:input="limiterCommodityGroup"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :placeholder="$t('globalTrans.select')"
                            @input="getCommodityNameList()"
                        >
                        </v-select>
                        <p style="color:red">{{ messageLimit }}</p>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Commodity Name" vid="commodity_name_id" rules="required|min_value:1" v-slot="{ errors }">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="commodity_name_id"
                          >
                          <template v-slot:label>
                          {{ $t('bazarMonitoring.commodity_name') }} <span class="text-danger">*</span>
                          </template>
                            <div v-for="(itemList, index) in loopArray" :key="index">
                              <b-form-checkbox-group
                              v-model="search.commodity_name_id"
                              :options="itemList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              class="label-checkbox mb-1"
                              ></b-form-checkbox-group>
                           </div>
                          <div style="background: #eee;margin-top: 10px;padding: 5px 10px;border-radius: 4px">{{ $t('priceMonitoring.selected')}} : {{ getCommodityNames(search.commodity_name_id) }}</div>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Diagram Type" vid="diagram_type" rules="required|min_value:1" v-slot="{ errors }">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="diagram"
                          >
                          <template v-slot:label>
                          {{ $t('priceMonitoring.diagram') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-radio-group
                                v-model="search.diagram_type"
                                :options="diagramTypeList"
                                class="mb-3"
                                value-field="value"
                                text-field="text"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-radio-group>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" style="margin-left: 700px">
                  <b-button size="sm" variant="primary" @click="searchData">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                  </b-button>
                </b-col>
              </b-tab>
            </b-row>
            <b-row>
              <b-tab :title="$t('priceMonitoring.graphical_comparison')" class="mt-3">
                <ValidationProvider name="Price Collection Date" vid="price_collection_date" rules="required|min_value:1">
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                    <b-form-group
                    class="row"
                    label-cols-sm="4"
                    label-for="price_collection_date"
                    >
                    <template v-slot:label>
                        {{ $t('priceMonitoring.price_collection_date') }} <span class="text-danger">*</span>
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
                </ValidationProvider>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Duration" vid="duration" rules="required|min_value:1">
                      <b-form-group
                          label-for="duration"
                          slot-scope="{ valid, errors }"
                          class="row"
                          label-cols-sm="4"
                      >
                      <template v-slot:label>
                          {{$t('priceMonitoring.duration')}}  <span class="text-danger">*</span>
                      </template>
                      <span> {{$t('priceMonitoring.last')}}  </span>
                      <b-form-select
                          plain
                          v-model="search.duration"
                          :options="durationList"
                          id="duration"
                          :state="errors[0] ? false : (valid ? true : null)"
                          style="display: inline-block; width:70%"
                      >
                          <template v-slot:first>
                          <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                      </b-form-select>
                        <span> {{$t('priceMonitoring.day')}}  </span>
                      <div class="invalid-feedback">
                          {{ errors[0] }}
                      </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                    <ValidationProvider name="Price Veriation" vid="price_veriation" rules="required" v-slot="{ errors }">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="activity"
                            >
                            <template v-slot:label>
                            {{ $t('priceMonitoring.price_veriation') }}  <span class="text-danger">*</span>
                            </template>
                            <b-form-radio-group
                                  v-model="search.price_veriation"
                                  :options="priceVeriationList"
                                  class="mb-3"
                                  value-field="value"
                                  text-field="text"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-radio-group>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Commodity Group" vid="commodity_group_id" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="commodity_group_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('bazarMonitoring.commodity_group')}} <span class="text-danger">*</span>
                    </template>
                        <v-select
                            id="commodity_group_id"
                            v-model="search.commodity_group_id"
                            multiple
                            :reduce="op => op.value"
                            :options="commodityGroupList"
                            label="text"
                            v-on:input="limiterCommodityGroup"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :placeholder="$t('globalTrans.select')"
                            @input="getCommodityNameList()"
                        >
                        </v-select>
                        <p style="color:red">{{ messageLimit }}</p>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
               <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Commodity Name" vid="commodity_name_id" rules="required|min_value:1" v-slot="{ errors }">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="commodity_name_id"
                          >
                          <template v-slot:label>
                          {{ $t('bazarMonitoring.commodity_name') }} <span class="text-danger">*</span>
                          </template>
                            <div v-for="(itemList, index) in loopArray" :key="index">
                              <b-form-checkbox-group
                              v-model="search.commodity_name_id"
                              :options="itemList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              class="label-checkbox mb-1"
                              ></b-form-checkbox-group>
                           </div>
                          <div class="mt-3">{{ $t('priceMonitoring.selected')}} : {{ getCommodityNames(search.commodity_name_id) }}</div>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Division" vid="division_id">
                      <b-form-group
                          label-for="division_id"
                          slot-scope="{ valid, errors }"
                          class="row"
                          label-cols-sm="4"
                      >
                      <template v-slot:label>
                          {{$t('globalTrans.division')}}
                      </template>
                      <b-form-select
                          plain
                          v-model="search.division_id"
                          :options="divisionList"
                          id="division"
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
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Disrict" vid="district_id">
                      <b-form-group
                          label-for="district_id"
                          slot-scope="{ valid, errors }"
                          class="row"
                          label-cols-sm="4"
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
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" offset="2">
                  <ValidationProvider name="Diagram Type" vid="diagram_type" rules="required" v-slot="{ errors }">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="diagram"
                          >
                          <template v-slot:label>
                          {{ $t('priceMonitoring.diagram') }}  <span class="text-danger">*</span>
                          </template>
                          <b-form-radio-group
                                v-model="search.diagram_type"
                                :options="diagramTypeList"
                                class="mb-3"
                                value-field="value"
                                text-field="text"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-radio-group>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" style="margin-left: 700px">
                  <b-button size="sm" variant="primary" @click="searchData">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                  </b-button>
                </b-col>
              </b-tab>
            </b-row>
            <b-row>
              <b-tab :title="$t('priceMonitoring.market_comparison')" class="mt-3">
                <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                  <b-form @submit.prevent="handleSubmit(searchDataR)" @reset.prevent="reset" >
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
                                v-model="searchR.price_category_id"
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
                              v-model="searchR.commodity_group_id"
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
                            v-model="searchR.commodity_name_id"
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
                            v-model="searchR.price_veriation"
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
                        <ValidationProvider name="Date" vid="date" rules="required" v-slot="{ errors }">
                          <b-form-group
                            label-for="date"
                          >
                            <template v-slot:label>
                              {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                            </template>
                            <date-picker
                              id="date"
                              class="form-control"
                              v-model="searchR.date"
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
                        <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                            <b-form-group
                                label-for="area_type_id"
                                slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                                plain
                                v-model="searchR.area_type_id"
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
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 1 || searchR.area_type_id === 2 || searchR.area_type_id === 3">
                          <ValidationProvider name="Division Name" vid="division_id" rules="required|min_value:1">
                              <b-form-group
                                  label-for="division_id"
                                  slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                  plain
                                  v-model="searchR.division_id"
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
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 1 || searchR.area_type_id === 2 || searchR.area_type_id === 3">
                          <ValidationProvider name="District Name" vid="district_id" rules="required|min_value:1">
                              <b-form-group
                                  label-for="district_id"
                                  slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                                  {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                                  plain
                                  v-model="searchR.district_id"
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
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 1">
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
                                  v-model="searchR.city_corporation_id"
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
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 2 || searchR.area_type_id === 3">
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
                                v-model="searchR.upazila_id"
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
                      <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 2">
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
                                  v-model="searchR.pauroshoba_id"
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
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="searchR.area_type_id === 3">
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
                                  v-model="searchR.union_id"
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
                      </b-col> -->
                      <b-col xs="12" sm="12" md="8" lg="8" xl="8" v-if="searchR.district_id">
                        <ValidationProvider name="0" vid="market_directory_id" rules="required">
                            <b-form-group
                              label-for="market_directory_id"
                              slot-scope="{ valid, errors }"
                              class="row"
                            >
                            <template v-slot:label>
                                {{$t('bazarMonitoring.market_name')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-checkbox-group
                              v-model="searchR.market_directory_id"
                              :options="marketDirectoryList"
                              :state="state"
                              >
                              <b-form-invalid-feedback :state="state">{{$t('priceMonitoring.maximum_select')}}</b-form-invalid-feedback>
                              <!-- <b-form-valid-feedback :state="state">Thank you</b-form-valid-feedback> -->
                              </b-form-checkbox-group>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                            </b-form-group>
                        </ValidationProvider>
                      </b-col>
                      <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="text-right">
                        <b-button size="sm" type="submit" variant="primary" class="mt-20">
                          <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                        </b-button>
                      </b-col>
                    </b-row>
                  </b-form>
                </ValidationObserver>
              </b-tab>
            </b-row>
          </b-tabs>
        </b-card>
      </template>
      <!-- search section end -->
    </card>
    <b-row v-if="tabIndex !== 2">
      <b-col>
        <b-col md="12" v-if="showData">
        <!-- <b-col md="12"> -->
          <b-overlay :show="loaderLine">
            <b-row>
              <b-col v-show="search.diagram_type === 1">
                <body-card style="min-height: 200px">
                  <div id="chart">
                    <apexchart type="line" height="350" :options="linechartOptions" :series="lineSeries"></apexchart>
                  </div>
                  <!-- <div>
                    <p>{{$t('bazarMonitoring.commodity_name')}} : {{getCommodityNames(this.search.commodity_name_id)}}</p>
                  </div> -->
                </body-card>
              </b-col>
              <b-col v-show="search.diagram_type === 2">
                <body-card style="min-height: 200px">
                  <div id="chart">
                    <apexchart type="bar" height="350" :options="barChartOption" :series="barSeries"></apexchart>
                  </div>
                </body-card>
              </b-col>
            </b-row>
          </b-overlay>
        </b-col>
      </b-col>
    </b-row>
    <b-row v-if="tabIndex === 2">
      <b-col md="12" v-if="reportData">
        <b-overlay :show="dataReport">
          <b-row>
            <b-col>
              <body-card style="min-height: 200px">
                <div class="text-black mr-2 mt-2 ml-2 mb-2">
                  <b-row>
                    <b-col md="6" v-if="searchR.price_category_id">
                      {{ $t('bazarMonitoring.Price_category_name') }}: <strong>{{ searchR.price_category_id ? ($i18n.locale === 'en' ? searchHeaderData.priceCategory_name_en : searchHeaderData.priceCategory_name_bn) : $t('globalTrans.all') }}</strong>
                    </b-col>
                    <b-col md="6" class="text-right" v-if="searchR.date">
                      {{ $t('globalTrans.date') }}: <strong>{{ searchR.date|dateFormat }}</strong>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col md="6" v-if="searchR.commodity_name_id">
                      {{ $t('bazarMonitoring.commodity_name') }}: <strong>{{ searchR.commodity_name_id ? ($i18n.locale === 'en' ? searchHeaderData.comodity_name : searchHeaderData.comodity_name_bn) : $t('globalTrans.all') }}</strong>
                    </b-col>
                    <b-col md="6" class="text-right" v-if="searchR.price_veriation">
                      <span v-if="searchR.price_veriation == 1">
                        {{ $t('globalTrans.price') }}: <strong>{{ $t('report.lowest_price_amount') }}</strong>
                      </span>
                      <span v-else>
                        {{ $t('globalTrans.price') }}: <strong>{{ $t('report.highest_price_amount') }}</strong>
                      </span>
                    </b-col>
                  </b-row>
                </div>
                <div id="chart">
                  <apexchart type="bar" height="350" :options="optionsData" :series="seriesBar"></apexchart>
                </div>
              </body-card>
            </b-col>
          </b-row>
        </b-overlay>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { priceTrendList, marketComparisonGraph } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import BodyCard from '../../../../../components/BodyCard.vue'
const today = new Date().toISOString().substr(0, 10)

export default {
  components: { BodyCard },
  mixins: [ModalBaseMasterList],
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        price_collection_date: today,
        duration: 0,
        price_veriation: 0,
        commodity_group_id: [],
        commodity_name_id: [],
        division_id: 0,
        district_id: 0,
        diagram_type: 1
      },
      searchR: {
        market_directory_id: [],
        date: '',
        tabTwo: '',
        tabOne: '',
        tabThree: '',
        price_veriation: 0,
        price_category_id: 0,
        area_type_id: 0,
        city_corporation_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        commodity_group_id: 0,
        commodity_name_id: 0
      },
      sortDesc: true,
      sortDirection: 'desc',
      labelData: [],
      marketDirectoryList: [],
      districtList: [],
      upazilaList: [],
      corporationList: [],
      commodityNameList: [],
      tabIndex: 0,
      showData: false,
      reportData: false,
      messageLimit: '',
      loaderLine: false,
      valid: '',
      datas: [],
      dataReport: false,
      dateRangeList: [],
      lineSeries: [],
      barSeries: [],
      barSeriesReport: [],
      loopArray: [],
      market_name: [],
      market_name_bn: [],
      marketNameData: [],
      tmpArray: [],
      seriesBar: [{
        name: 'series-1',
        // data: [30, 40, 45, 50, 49, 60, 70, 91]
        data: []
      }],
      searchHeaderData: {
        priceCategory_name_en: '',
        priceCategory_name_bn: '',
        comodity_name: '',
        comodity_name_bn: ''
      }
    }
  },
  created () {
    // this.loadDataReport()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.marketList = this.getMarketDirectoryList(newVal)
      } else {
        this.upazilaList = []
        this.marketList = []
      }
    },
    'searchR.area_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        // this.marketDirectoryList = this.getAreaMarketList(newVal)
      } else {
        // this.marketDirectoryList = []
      }
    },
    'searchR.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
        this.marketDirectoryList = this.getDivMarketList(newVal)
      } else {
        this.districtList = []
        this.marketDirectoryList = []
      }
    },
    'searchR.district_id': function (newVal, oldVal) {
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
    'searchR.upazila_id': function (newVal, oldVal) {
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
    'searchR.commodity_group_id': function (newVal, oldVal) {
      if (newVal) {
          this.commodityNameList = this.getCommodityNameListR(newVal)
      } else {
          this.commodityNameList = []
      }
    },
    'searchR.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getCityMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'searchR.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getPauroMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'searchR.union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getUniMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loopArray = []
        this.loopArray = this.tmpArray.map(item => {
          return item.map(el => {
              return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
          })
        })
      }
    }
  },
  computed: {
    state () {
      return this.searchR.market_directory_id.length >= 1 && this.searchR.market_directory_id.length <= 10
    },
    linechartOptions: function () {
      return {
        chart: {
          height: 350,
          type: 'line',
          // dropShadow: {
          //   enabled: true,
          //   color: '#000',
          //   top: 18,
          //   left: 7,
          //   blur: 10,
          //   opacity: 0.2
          // },
          toolbar: {
            show: false
          }
        },
        colors: ['#77B6EA', '#B90E03', '#034092', '#F9EB17', '#172FF9', '#17F939', '#7D0EDA', '#755D58', '#2F2C61', '#9F4E40'],
        dataLabels: {
          enabled: true
        },
        stroke: {
          curve: 'smooth'
        },
        grid: {
          borderColor: '#e7e7e7',
          row: {
            colors: ['#f3f3f3', 'transparent'], // takes an array which will be repeated on columns
            opacity: 0.5
          }
        },
        markers: {
          size: 1
        },
        xaxis: {
          title: {
            text: this.$t('bazarMonitoring.commodity_name') + ' : ' + this.getCommodityNames(this.search.commodity_name_id) + '\n'
          },
          categories: this.dateRangeList
        },
        yaxis: {
          title: {
            text: this.$t('bazarMonitoring.price')
          }
        },
        legend: {
          position: 'top',
          horizontalAlign: 'right',
          floating: true,
          offsetY: -25,
          offsetX: -5
        }
      }
    },
    barChartOption: function () {
      return {
        chart: {
            type: 'bar',
            height: 350,
            stacked: true,
            toolbar: {
              show: true
            },
            zoom: {
              enabled: true
            }
          },
          responsive: [{
            breakpoint: 480,
            options: {
              legend: {
                position: 'bottom',
                offsetX: -10,
                offsetY: 0
              }
            }
          }],
          plotOptions: {
            bar: {
              horizontal: false,
              borderRadius: 10
            }
          },
          xaxis: {
            categories: this.dateRangeList
          },
          yaxis: {
            title: {
              text: this.$t('bazarMonitoring.price')
            }
          },
          legend: {
            position: 'right',
            offsetY: 40
          },
          fill: {
            opacity: 1
          }
      }
    },
    optionsData () {
      return {
        chart: {
          id: 'vuechart-example1',
          type: 'bar'
        },
        plotOptions: {
          bar:
          {
            barHeight: '300px',
            columnWidth: '40%',
            distributed: true,
            horizontal: false,
            dataLabels: {
              position: 'top',
              horizontalAlign: 'center'
            }
          }
        },
        xaxis: {
          // categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
          categories: this.marketNameList
        },
        yaxis: {
          title: {
            text: this.$t('bazarMonitoring.price')
          }
        }
      }
    },
    priceTrendType: function () {
      const list = [
          { id: 1, text: this.$i18n.locale === 'en' ? 'Commodity Price Growth' : 'দ্রব্যমূল্য বৃদ্ধি' },
          { id: 2, text: this.$i18n.locale === 'en' ? 'Graphical Comparison of Commodity Price' : 'পণ্য মূল্যের গ্রাফিক্যাল তুলনা' }
      ]
      return list
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
    marketNameList: function () {
        if (this.$i18n.locale === 'bn') {
          return this.market_name_bn.map(item => {
            return item
          })
        } else {
          return this.market_name.map(item => {
            return item
          })
        }
    },
    durationList: function () {
      const list = this.$store.state.commonObj.fifteenDayList
        return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
        })
    },
    diagramTypeList: function () {
        const data = [
            { value: 1, text: this.$i18n.locale === 'en' ? 'Line Diagram' : 'লাইন ডায়াগ্রাম' },
            { value: 2, text: this.$i18n.locale === 'en' ? 'Bar Diagram' : 'বার ডায়াগ্রাম' }
        ]
        return data
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
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    commodityGroupList: function () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityGroupList.filter(item => item.status === 1)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    limiterCommodityGroup (e) {
      if (e.length > 5) {
        this.messageLimit = this.$t('priceMonitoring.message_limit')
        e.pop()
      }
    },
    searchData () {
      this.loadData()
    },
    searchDataR () {
      this.loadDataReport()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      this.reportData = false
      this.showData = true
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, priceTrendList, params)
      if (result.success) {
        this.loaderLine = true
        this.datas = result.data
        this.dateRangeList = result.arryDateRange
        const serielsData = []
        this.search.commodity_name_id.map(item => {
          const nameCommodityGroupObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(item1 => item1.value === item)
          const dateValue = []
          this.dateRangeList.map(item3 => {
            if (this.search.price_veriation === 1) {
                const isThereLowestPrice = this.datas.find(item2 => item2.commodity_name_id === item && String(item2.price_collection_date) === String(item3))
              if (typeof isThereLowestPrice !== 'undefined') {
                dateValue.push(isThereLowestPrice.lowest_price_amount)
              } else {
                dateValue.push(0)
              }
            } else {
                const isThereHighestPrice = this.datas.find(item2 => item2.commodity_name_id === item && String(item2.price_collection_date) === String(item3))
                if (typeof isThereHighestPrice !== 'undefined') {
                  dateValue.push(isThereHighestPrice.highest_price_amount)
                } else {
                  dateValue.push(0)
                }
            }
          })
          const data = {
            name: this.$i18n.locale === 'bn' ? nameCommodityGroupObj.text_bn : nameCommodityGroupObj.text_en,
            data: dateValue
          }
          serielsData.push(data)
        })
        this.lineSeries = serielsData
        this.barSeries = serielsData
      } else {
        this.datas = []
      }
      // this.showData = false
      this.loaderLine = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async loadDataReport () {
      if (this.searchR.price_category_id) {
        const priceCategoryObj = this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.find(data => data.value === this.searchR.price_category_id)
        this.searchHeaderData.priceCategory_name_en = priceCategoryObj !== undefined ? priceCategoryObj.text_en : ''
        this.searchHeaderData.priceCategory_name_bn = priceCategoryObj !== undefined ? priceCategoryObj.text_bn : ''
      }
      if (this.searchR.commodity_name_id) {
        const comodityNameObj = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(item => item.value === this.searchR.commodity_name_id)
        this.searchHeaderData.comodity_name = comodityNameObj !== undefined ? comodityNameObj.text_en : ''
        this.searchHeaderData.comodity_name_bn = comodityNameObj !== undefined ? comodityNameObj.text_bn : ''
      }

      this.showData = false
      this.reportData = true
      this.dataReport = true
      const params = Object.assign({}, this.searchR, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, marketComparisonGraph, params)
      if (result.success) {
        this.dataReport = false
        this.datas = result.data
        const marketListEn = []
        const marketListBn = []
        const dataChat = []
        this.datas.map(item => {
          const marketObj = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(data => data.value === parseInt(item.market_directory_id))
            if (this.searchR.price_veriation === 1) {
                const isThereLowestPrice = this.datas.find(data => data.market_directory_id === marketObj.value)
              if (typeof isThereLowestPrice !== 'undefined') {
                dataChat.push(isThereLowestPrice.lowest_price_amount)
              } else {
                dataChat.push(0)
              }
            }
            if (this.searchR.price_veriation === 2) {
              const isThereHighestPrice = this.datas.find(data => data.market_directory_id === marketObj.value)
              if (typeof isThereHighestPrice !== 'undefined') {
                dataChat.push(isThereHighestPrice.highest_price_amount)
              } else {
                dataChat.push(0)
              }
            }
          this.seriesBar = [{
            name: 'Total:',
            data: dataChat
          }]
          marketListEn.push(marketObj.text_en)
          marketListBn.push(marketObj.text_bn)
        })
        this.market_name = marketListEn
        this.market_name_bn = marketListBn
      } else {
        this.dataReport = false
        this.datas = []
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
    getCommodityNameList () {
      const commodityGroupIdArr = this.search.commodity_group_id
      this.loopArray = []
      this.tmpArray = []
      if (commodityGroupIdArr.length > 0) {
        commodityGroupIdArr.map(el => {
          const list = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.commodity_group_id === el)
          this.loopArray.push(list)
        })
      }
      this.tmpArray = [...this.loopArray]
    },
    getCommodityNameListR (id) {
        return this.$store.state.BazarMonitoringService.commonObj.commodityNameList.filter(item => item.status === 1 && item.commodity_group_id === id)
    },
    getCommodityNames (datas) {
      return datas.map(item => {
        const comDit = this.$store.state.BazarMonitoringService.commonObj.commodityNameList.find(tmp => tmp.value === item)
        if (this.$i18n.locale === 'bn') {
          return typeof comDit !== 'undefined' ? comDit.text_bn : ''
        } else {
          return typeof comDit !== 'undefined' ? comDit.text_en : ''
        }
      })
    }
  }
}
</script>
<style scoped>
.label-checkbox {
  border: 1px solid #4273DE;
  box-sizing: border-box;
  border-radius: 10px;
  padding: 5px 10px;
  font-family: Roboto;
  font-style: normal;
  font-weight: normal;
  font-size: 14px;
  line-height: 16px;
  color: #0b0b0c;
}
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
