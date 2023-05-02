<template>
  <card>
    <template v-slot:searchHeaderTitle>
      <h4 class="card-title">{{ $t('teaGardenConfig.tea_garden_profile') }}</h4>
    </template>
    <template v-slot:searchBody>
      <b-card>
      <b-tabs small card>
        <!--General Information Tab start -->
        <p class="mt-2 ml-3 font-weight-bold"> {{$t('teaGardenConfig.garden_id_no')}}: {{ formData.garden_id_no }}</p>
        <b-tab :active="tabIndex == 0  ? true : false" :disabled="$route.query.id || tabIndex === 2 || tabIndex === 1 || tabIndex === 0  ? false : true" :title="$t('teaGardenConfig.general_information')">
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(teaGardenProfileUpdate)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Made Tea Type" vid="tea_company_id" rules="required|min_value:1">
                      <b-form-group
                      slot-scope="{ valid, errors }"
                        label-for="tea_company_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.company_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.tea_company_id"
                              :options="teaCompanyList"
                              id="tea_company_id"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Company Address"  rules="required">
                      <b-form-group
                        label-for="company_address"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.company_address')}}
                        </template>
                        <b-form-input
                          readonly
                          v-model="formData.company_address"
                          id="company_address"
                        >
                        </b-form-input>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Tea Garden Name (En)" vid="tea_garden_name_en" rules="required">
                      <b-form-group
                        label-for="tea_garden_name_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.tea_garden_name')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.tea_garden_name_en"
                          id="tea_garden_name_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Tea Garden Name (Bn)" vid="tea_garden_name_bn" rules="required">
                      <b-form-group
                        label-for="tea_garden_name_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.tea_garden_name')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.tea_garden_name_bn"
                          id="tea_garden_name_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Garden Type" vid="garden_type" rules="required|min_value:1">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="garden_type">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.garden_type') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.garden_type"
                              :options="getGardenTypeList"
                              id="garden_type"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Registration No" vid="registration_no_en" rules="required">
                      <b-form-group
                        label-for="registration_no_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.registration_no')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.registration_no_en"
                          id="registration_no_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Has Own Garden" vid="has_own_garden" rules="required|min_value:1">
                          <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="has_own_garden">
                          <template v-slot:label>
                            {{ $t('teaGardenConfig.has_own_garden') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-radio-group
                                :state="errors[0] ? false : (valid ? true : null)"
                                v-model="formData.has_own_garden"
                                :options="manualList">
                          </b-form-radio-group>
                          <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Garden Class (En)" vid="garden_class_en" rules="required">
                      <b-form-group
                        label-for="garden_class_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_class')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.garden_class_en"
                          id="garden_class_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Garden Class (Bn)" vid="garden_class_bn" rules="required">
                      <b-form-group
                        label-for="garden_class_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_class')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.garden_class_bn"
                          id="garden_class_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Valley Name" vid="valley_id" rules="required|min_value:1">
                      <b-form-group
                      slot-scope="{ valid, errors }"
                        label-for="valley_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.valley_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.valley_id"
                              :options="valleyNameList"
                              id="valley_id"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                     <!-- area section start here -->
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="area_type_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.area_type_id"
                              id="area_type_id"
                              :options="getAreaTypeList"
                              @change="getAreaTypeData(formData.area_type_id)"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="ItemShow">
                    <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="division_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.division_id"
                              id="division_id"
                              :options="divisionList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="ItemShow">
                    <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="district_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.district_id"
                              id="district_id"
                              :options="districtList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="PauroshobaItemShow || UnionItemShow">
                    <ValidationProvider name="District" vid="upazila_id">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="upazila_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.upazila') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.upazila_id"
                              id="upazila_id"
                              :options="upazilaList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="UnionItemShow">
                    <ValidationProvider name="Union" vid="union_id">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="union_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.union') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.union_id"
                              id="union_id"
                              :options="unionList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="CityCorpItemShow">
                    <ValidationProvider name="City Corporation" vid="city_corporation_id">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="city_corporation_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.city_corporation') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.city_corporation_id"
                              id="city_corporation_id"
                              :options="cityCorporationList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-show="PauroshobaItemShow">
                    <ValidationProvider name="Municipality" vid="pauroshoba_id">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="pauroshoba_id">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.municipality_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                              plain
                              v-model="formData.pauroshoba_id"
                              id="pauroshoba_id"
                              :options="municipalityList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              <template v-slot:first>
                                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                          </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <!-- area section end  -->
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Garden Address (En)" vid="garden_address_en" rules="required">
                      <b-form-group
                        label-for="garden_address_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_address')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.garden_address_en"
                          id="garden_address_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Garden Address (Bn)" vid="garden_address_bn" rules="required">
                      <b-form-group
                        label-for="garden_address_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_address')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.garden_address_bn"
                          id="garden_address_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Owner Name (En)" vid="owner_name_en" rules="required">
                      <b-form-group
                        label-for="owner_name_en"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.owner_name')}} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.owner_name_en"
                          id="owner_name_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Owner Name (Bn)" vid="owner_name_bn" rules="required">
                      <b-form-group
                        label-for="owner_name_bn"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.owner_name')}} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.owner_name_bn"
                          id="owner_name_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Email" vid="email" rules="required|email">
                      <b-form-group
                        label-for="email"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_authority_email')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          v-model="formData.email"
                          id="email"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Mobile" vid="mobile" rules="digits:11|required">
                      <b-form-group
                        label-for="mobile"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.garden_authority_mobile')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                         type="number"
                          v-model="formData.mobile"
                          id="mobile"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Garden History (En)" vid="garden_history_en">
                      <b-form-group
                        label-for="garden_history_en">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.garden_history') }} {{ $t('globalTrans.en') }}
                        </template>
                        <b-form-textarea
                          id="garden_history_en"
                          v-model="formData.garden_history_en"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Garden History (Bn)" vid="garden_history_bn">
                      <b-form-group
                        label-for="garden_history_bn">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.garden_history') }} {{ $t('globalTrans.bn') }}
                        </template>
                        <b-form-textarea
                          id="garden_history_bn"
                          v-model="formData.garden_history_bn"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="warning" class="mr-2 btn-sm">{{ $t('priceMonitoring.save_as_draft') }}</b-button>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('priceMonitoring.save_next') }}</b-button>
                    <router-link class="btn-sm btn btn-danger" to="tea-garden-profile">{{ $t('globalTrans.cancel') }}</router-link>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-tab>
        <!--General Information Tab End -->

        <!--Lans & Lease Information tab start -->
        <b-tab :active="tabIndex == 1  ? true : false" :disabled="$route.query.id || tabIndex >= 1   ? false : true" :title="$t('teaGardenConfig.land_lease_information')">
          <ValidationObserver ref="form2" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(teaGardenProfileUpdate)" @reset.prevent="reset" autocomplete="off" >
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Total Land" vid="total_land" rules="required">
                      <b-form-group
                        label-for="total_land"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.total_land')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          v-model="formData.land_lease_info.total_land"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Lease Start Date" vid="lease_start_date" rules="required">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="lease_start_date">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.lease_start_date') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="lease_start_date"
                          v-model="formData.land_lease_info.lease_start_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          :class="errors[0] ? 'is-invalid' : ''"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Lease End Date" vid="lease_end_date" rules="required">
                      <b-form-group
                        slot-scope="{ valid, errors }"
                        label-for="lease_end_date">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.lease_end_date') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="lease_end_date"
                          v-model="formData.land_lease_info.lease_end_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          :class="errors[0] ? 'is-invalid' : ''"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Lease Duration" vid="lease_duration" rules="required">
                      <b-form-group
                        label-for="lease_duration"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.lease_duration')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          v-model="formData.land_lease_info.lease_duration"
                          readonly
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Reg. Lease Deed No." vid="reg_lease_deed_no" rules="required">
                      <b-form-group
                        label-for="reg_lease_deed_no"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.reg_lease_deed_no')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          v-model="formData.land_lease_info.reg_lease_deed_no"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Effective From" vid="lease_deed_date" rules="required">
                      <b-form-group
                        class="row"
                        label-for="lease_deed_date"
                        slot-scope="{ valid, errors }">
                        <template v-slot:label>
                          {{ $t('teaGardenConfig.lease_deed_date') }}  <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="lease_deed_date"
                          v-model="formData.land_lease_info.lease_deed_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          :class="errors[0] ? 'is-invalid' : ''"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="warning" class="mr-2 btn-sm">{{ $t('priceMonitoring.save_as_draft') }}</b-button>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('priceMonitoring.save_next') }}</b-button>
                    <router-link class="btn-sm btn btn-danger" to="tea-garden-profile">{{ $t('globalTrans.cancel') }}</router-link>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-tab>
        <!-- Land & Lease Information tab end -->

        <!--Human resource Information tab start -->
          <b-tab :active="tabIndex == 2  ? true : false" :disabled="$route.query.id || tabIndex === 2 ? false : true" :title="$t('teaGardenConfig.human_resource_information')">
          <ValidationObserver ref="form2" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(teaGardenProfileUpdate)" @reset.prevent="reset" autocomplete="off" >
               <!-- register resource information -->
               <p class="p_heading">{{$t('teaGardenConfig.register_info_heading')}}:</p>
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Register Labor Male" vid="register_labor_male" rules="required">
                      <b-form-group
                        label-for="register_labor_male"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.male')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.register_labor_male"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Register Labor Female" vid="register_labor_female" rules="required">
                      <b-form-group
                        label-for="register_labor_female"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.female')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.register_labor_female"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                 <!-- unregister resource information -->
                 <p class="p_heading">{{$t('teaGardenConfig.unregister_info_heading')}}:</p>
                  <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Male" vid="unregister_labor_male" rules="required">
                      <b-form-group
                        label-for="register_labor_male"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.male')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.unregister_labor_male"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Female" vid="unregister_labor_female" rules="required">
                      <b-form-group
                        label-for="unregister_labor_female"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.female')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.unregister_labor_female"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                  <!-- dependent resource information -->
                  <p class="p_heading"> {{$t('teaGardenConfig.dependent_info_heading')}}:</p>
                  <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Male" vid="dependent_labor_male" rules="required">
                      <b-form-group
                        label-for="dependent_labor_male"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.male')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.dependent_labor_male"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Female" vid="dependent_labor_female" rules="required">
                      <b-form-group
                        label-for="dependent_labor_female"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('teaGardenConfig.female')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          type="number"
                          min="0"
                          v-model="formData.human_resource_info.dependent_labor_female"
                          id="shop_no"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                    <b-button type="submit" variant="warning" class="mr-2 btn-sm">{{ $t('priceMonitoring.save_as_draft') }}</b-button>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.submit') }}</b-button>
                    <router-link class="btn-sm btn btn-danger" to="tea-garden-profile">{{ $t('globalTrans.cancel') }}</router-link>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-tab>
        <!-- Human resource Information tab end -->

      </b-tabs>
      </b-card>
    </template>
  </card>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import { teaGardenProfileStore, teaGardenProfileUpdate, calculateLeaseDurationApi, getGardenIdNoApi, teaGardenProfileView } from '../../api/routes'
const today = new Date().toISOString().substr(0, 10)
export default {
  name: 'Form',
  props: ['item'],
    components: {
        ValidationObserver,
        ValidationProvider
    },
  data () {
    return {
      ItemShow: false,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      circularLoading: false,
      formData: {
        id: '',
        garden_id_no: '',
        tea_company_id: 0,
        tea_garden_name_en: '',
        tea_garden_name_bn: '',
        garden_type: 0,
        registration_no_en: '',
        has_own_garden: 2,
        garden_class_en: '',
        garden_class_bn: '',
        valley_id: 0,
        area_type_id: '0',
        city_corporation_id: '0',
        pauroshoba_id: '0',
        ward_id: '0',
        country_id: 1,
        division_id: '0',
        district_id: '0',
        upazila_id: '0',
        union_id: '0',
        garden_address_en: '',
        garden_address_bn: '',
        mobile: '',
        email: '',
        garden_history_en: '',
        garden_history_bn: '',
        land_lease_info: {
          id: '',
          tea_garden_gen_info_id: 0,
          total_land: '',
          lease_start_date: today,
          lease_end_date: '',
          lease_duration: '',
          reg_lease_deed_no: '',
          lease_deed_date: today
        },
        human_resource_info: {
          id: '',
          tea_garden_gen_info_id: '',
          register_labor_male: '',
          register_labor_female: '',
          unregister_labor_male: '',
          unregister_labor_female: '',
          dependent_labor_male: '',
          dependent_labor_female: ''
        }
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      cityCorporationList: [],
      municipalityList: [],
      wardList: [],
      manualList: [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
      ],
      tabIndex: 0,
      userLoading: false
    }
  },
  created () {
    if (this.$route.query.id) {
      this.getTeaGardenProfile(this.$route.query.id)
      if (!this.formData.land_lease_info) {
        this.formData.land_lease_info = {
          id: '',
          tea_garden_gen_info_id: 0,
          total_land: '',
          lease_start_date: today,
          lease_end_date: '',
          lease_duration: '',
          reg_lease_deed_no: '',
          lease_deed_date: today
        }
      }
      if (!this.formData.human_resource_info) {
        this.formData.human_resource_info = {
          id: '',
          tea_garden_gen_info_id: '',
          register_labor_male: '',
          register_labor_female: '',
          unregister_labor_male: '',
          unregister_labor_female: '',
          dependent_labor_male: '',
          dependent_labor_female: ''
        }
      }
      if (this.formData.area_type_id === 1) {
          this.ItemShow = true
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
      } else if (this.formData.area_type_id === 2) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
      } else if (this.formData.area_type_id === 3) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
      }
    } else {
      this.getGardenIdNo()
    }
  },
  computed: {
    loading () {
      return this.$store.state.commonObj.loading
    },
    teaCompanyList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.filter(item => item.status === 1)
    },
    valleyNameList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterValleyList.filter(item => item.status === 1)
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    getAreaTypeList: function () {
      const objectData = this.$store.state.commonObj.areaTypeList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    },
    getGardenTypeList: function () {
      return this.$store.state.TeaGardenService.commonObj.gardenType
    }
  },

  watch: {
    'formData.land_lease_info.lease_end_date': function (newVal, oldVal) {
      if (newVal) {
        this.calculateLeaseDuration()
      }
    },
    'formData.tea_company_id': function (newVal, oldVal) {
      if (newVal && newVal !== 0) {
         const companyInfo = this.$store.state.TeaGardenService.commonObj.masterTeaCompanyList.find(item => item.value === newVal)
         if (companyInfo && this.$i18n.locale === 'bn') {
            this.formData.company_address = companyInfo.address_bn
         } else if (companyInfo && this.$i18n.locale === 'en') {
            this.formData.company_address = companyInfo.address_en
         }
      }
    },
    'formData.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'formData.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'formData.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'formData.city_corporation_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
    },
    'formData.pauroshoba_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByPauroshoba(newVal)
    },
    'formData.union_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByUnion(newVal)
    }
  },
  methods: {
    async getTeaGardenProfile (id) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        result = await RestApi.getData(teaGardenServiceBaseUrl, `${teaGardenProfileView}/${id}`)
        this.formData = result.data
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    getAreaTypeData (typeId) {
      this.ItemShow = true
      if (typeId === 1) {
        this.CityCorpItemShow = true
        this.PauroshobaItemShow = false
        this.UnionItemShow = false
      } else if (typeId === 2) {
        this.CityCorpItemShow = false
        this.PauroshobaItemShow = true
        this.UnionItemShow = false
      } else if (typeId === 3) {
        this.CityCorpItemShow = false
        this.PauroshobaItemShow = false
        this.UnionItemShow = true
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
       return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    },
    getPauroshobaList (upazillaId = null) {
      const objectData = this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.upazila_id === upazillaId)
          return objectData.map((obj, key) => {
              if (this.$i18n.locale === 'bn') {
                  return { value: obj.value, text: obj.text_bn }
              } else {
                  return { value: obj.value, text: obj.text_en }
              }
          })
    },
    getWardListByCityCorportaion (cityCorpId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.city_corporation_id === cityCorpId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByPauroshoba (pauroshobaId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.pauroshoba_id === pauroshobaId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByUnion (unionId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.union_id === unionId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    async getGardenIdNo () {
    let result = null
      result = await RestApi.getData(teaGardenServiceBaseUrl, getGardenIdNoApi)
      if (result) {
        this.formData.garden_id_no = result
      }
    },
    async calculateLeaseDuration () {
    let result = null
    const data = {
      start_date: this.formData.land_lease_info.lease_start_date,
      end_date: this.formData.land_lease_info.lease_end_date
    }
      result = await RestApi.getData(teaGardenServiceBaseUrl, calculateLeaseDurationApi, data)
      if (result) {
        this.formData.land_lease_info.lease_duration = result
      }
    },
    async teaGardenProfileUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
       const loadingState = { loading: false, listReload: false }
      if (this.formData.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${teaGardenProfileUpdate}/${this.formData.id}`, this.formData)
        this.formData.id = result.model.id
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, teaGardenProfileStore, this.formData)
        this.formData.id = result.model.id
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        if (this.tabIndex === 0) {
          this.tabIndex = 1
        } else if (this.tabIndex === 1) {
          this.tabIndex = 2
        } else if (this.tabIndex === 2) {
          this.tabIndex = 3
        }
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        if (this.tabIndex === 3) {
          this.$router.push({ name: 'tea_garden_service.configuration.tea_garden_profile' })
        }
      } else {
        if (result.errors) {
          this.$refs.form.setErrors(result.errors)
        } else {
          this.$toast.error({
            title: 'Error',
            message: result.message,
            color: '#D6E09B'
          })
        }
      }
    }
  }
}
</script>
<style scoped>
  .p_heading{
    font-weight: bold;
  }
</style>
