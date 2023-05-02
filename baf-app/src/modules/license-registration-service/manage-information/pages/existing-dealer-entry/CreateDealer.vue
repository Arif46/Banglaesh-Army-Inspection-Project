<template>
  <div class="inner-section">
    <bread-cumb />
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('manage_information.existing_dealer_entry') }}  {{  id > 0 ? $t('globalTrans.edit') : $t('globalTrans.add') }}</h4>
      </template>
      <template v-slot:headerAction>
          <b-link v-if="profile.id" class="btn-add" to="/external-user/profile">
            <i class="ri-eye-fill"></i>{{ ' ' + $t('globalTrans.details') }}
        </b-link>
      </template>
      <template v-slot:body>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                    <b-row>
                        <b-row>
                         <b-col md="12" sm="12">
                            <b-row>
                                <b-col>
                                    <div style="font-size:15px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                        <h6 class="text-white text-left" :style="banglaTitle">
                                            {{ $t('manage_information.dealer_info') }}
                                        </h6>
                                    </div>
                                <hr>
                                </b-col>
                            </b-row>
                        </b-col>
                        <b-col lg="6" sm="12">
                            <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                label-for="name_bn"
                                label-cols-sm="5"
                                >
                                <template v-slot:label>
                                    {{ $t('globalTrans.name_bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="name_bn"
                                    v-model="profile.name_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="6" sm="12">
                            <ValidationProvider name="Name (En)" vid="name" rules="required" v-slot="{ errors }">
                                <b-form-group
                                label-for="name"
                                label-cols-sm="5"
                                >
                                <template v-slot:label>
                                    {{ $t('globalTrans.name_en') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="name"
                                    v-model="profile.name"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                         <b-col lg="6" sm="12">
                            <ValidationProvider name="Father/Husband Name (Bn)" vid="father_name_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="father_name_bn"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.father_or_husband_name') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="profile.father_name_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col lg="6" sm="12">
                            <ValidationProvider name="Father/Husband Name (En)" vid="father_name_en" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="father_name_en"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.father_or_husband_name') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="profile.father_name_en"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                         <b-col lg="6" sm="12">
                            <ValidationProvider name="Date Of Birth" vid='dob' rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="dob"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.dob') }} <span class="text-danger">*</span>
                                    </template>
                                   <date-picker
                                    id="dob"
                                    v-model="profile.dob"
                                    class="form-control"
                                    :placeholder="$t('globalTrans.select_date')"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    :class="errors[0] ? 'is-invalid' : ''"
                                >
                                </date-picker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="NID No" vid="nid_no"
                            :rules="'max:'+(invalidNid ? 0 : (10|13|17))+'|min:10|numeric|required'"
                            v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="nid"
                                >
                                <template v-slot:label>
                                    {{ $t('globalTrans.nid') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="profile.nid_no"
                                        @input="nidRules($event)"
                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                         <b-col lg="6" sm="12">
                            <ValidationProvider name="Gender" vid='gender' rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="gender"
                                >
                                <template v-slot:label>
                                    {{ $t('globalTrans.gender') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                    plain
                                    v-model="profile.gender"
                                    :options="genderList"
                                    id="gender"
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
                    <b-col xl="6" lg="6" sm="12">
                      <ValidationProvider name="Mobile" vid="mobile" v-slot="{ errors }" rules="required|min:11|max:11">
                            <b-form-group
                                label-cols-sm="5"
                                label-for="mobile"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.mobile') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    v-model="profile.mobile"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Email" vid="email" rules="required" v-slot="{ errors }">
                            <b-form-group
                                class="row"
                                label-cols-sm="5"
                                label-for="email"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.email') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                id="org_bn"
                                type="email"
                                v-model="profile.email"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                      <ValidationProvider name="Marital Status" vid="marital_status" rules="required">
                          <b-form-group
                              class
                              label-for="marital_status"
                              label-cols-sm="5"
                              slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                            <div >
                              {{ $t('dealer.marital_status') }} <span class="text-danger">*</span>
                            </div>
                          </template>
                            <b-form-radio-group
                              id="marital_status"
                              v-model="profile.marital_status"
                              value="1"
                              :options="options"
                              name="Merital Status"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-radio-group>
                            <div class="invalid-feedback">
                                {{ errors[0] }}
                            </div>
                          </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12" v-if="profile.marital_status == 1">
                        <ValidationProvider name="Husband/Wife NID NO" vid="spouse_nid_no" :rules="'max:'+(invalidNid ? 0 : (10|13|17))+'|min:10|numeric|required'">
                          <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="spouse_nid_no"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.spouse_nid_no') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="spouse_nid_no"
                              type="number"
                              v-model="profile.spouse_nid_no"
                               @input="nidRules($event)"
                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12" v-if="profile.marital_status == 2">
                        <ValidationProvider name="Father NID NO" vid="father_nid_no" :rules="'max:'+(invalidNid ? 0 : (10|13|17))+'|min:10|numeric|required'">
                          <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="father_nid_no"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.father_nid_no') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="father_nid_no"
                              type="number"
                              v-model="profile.father_nid_no"
                               @input="nidRules($event)"
                               oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12">
                        <ValidationProvider name="Agreement No." vid="agreement_no" rules="required" v-slot="{ errors }">
                            <b-form-group
                                class="row"
                                label-cols-sm="5"
                                label-for="agreement_no"
                            >
                            <template v-slot:label>
                                {{ $t('manage_information.agreement_no') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                id="agreement_no"
                                type="text"
                                v-model="profile.agreement_no"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                        <b-col md="12" sm="12">
                          <b-row>
                              <b-col xl="6" lg="6" sm="12">
                                  <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="area_type_id "
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.area_type_id"
                                          id="area_type_id"
                                          :options="getAreaTypeList"
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
                              <b-col xl="6" lg="6" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="division_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.division_id"
                                          :options="divisionList"
                                          id="division_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="district_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.district_id"
                                          :options="districtList"
                                          id="district_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                                  <ValidationProvider name="Upazila" vid="upazilla_id">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="upazilla_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.upazilla_id"
                                          :options="upazilaList"
                                          id="upazilla_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="UnionItemShow">
                                  <ValidationProvider name="Union" vid="union_id">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="union_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.union')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.union_id"
                                          :options="unionList"
                                          id="union_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="CityCorpItemShow">
                                  <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="city_corporation_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.city_corporation_id"
                                          :options="cityCorporationList"
                                          id="city_corporation_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="PauroshobaItemShow">
                                  <ValidationProvider name="Municipality" vid="pauroshoba_id">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="pauroshoba_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.municipality_name') }} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.pauroshoba_id"
                                          :options="municipalityList"
                                          id="pauroshoba_id"
                                          :state="errors[0] ? false : (valid ? true : null)"
                                          >
                                          <template v-slot:first>
                                              <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                                          </template>
                                          </b-form-select>
                                          <div class="invalid-feedback">
                                          {{ errors[0] }}
                                          </div>
                                      </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                              <b-col xl="6" lg="6" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="Ward" vid="ward_id">
                                      <b-form-group
                                          class="row"
                                          label-cols-sm="5"
                                          label-for="ward_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.ward') }}
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.ward_id"
                                          :options="wardList"
                                          id="ward_id"
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
                              <b-col xl="6" lg="6" sm="12" v-if="UnionItemShow">
                                <ValidationProvider name="Village (EN)" vid="village" rules="">
                                  <b-form-group
                                    class="row"
                                    label-cols-sm="5"
                                    label-for="village">
                                    <template v-slot:label>
                                      {{ $t('dealer.village_en') }}
                                    </template>
                                    <b-form-input
                                      id="village"
                                      v-model="profile.village"
                                    ></b-form-input>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                             <b-col xl="6" lg="6" sm="12" v-if="UnionItemShow">
                                <ValidationProvider name="Village (BN)" vid="village_bn" rules="">
                                  <b-form-group
                                    class="row"
                                    label-cols-sm="5"
                                    label-for="village_bn">
                                    <template v-slot:label>
                                      {{ $t('dealer.village_bn') }}
                                    </template>
                                    <b-form-input
                                      id="village_bn"
                                      v-model="profile.village_bn"
                                    ></b-form-input>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                          </b-row>
                        </b-col>
                        <b-col md="12" sm="12">
                            <b-row>
                                <b-col>
                                    <div style="font-size:15px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                        <h6 class="text-white text-left" :style="banglaTitle">
                                            {{ $t('manage_information.company_info') }}
                                        </h6>
                                    </div>
                                <hr>
                                </b-col>
                            </b-row>
                        </b-col>
                        <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="Regional Office" vid="regional_office" rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="5"
                                    label-for="regional_office"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.regional_office') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="profile.office_id"
                                        :options="regionalOfficeList"
                                        id="regional_office"
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
                          <b-col lg="6" sm="12">
                          </b-col>
                     <b-col lg="6" sm="12">
                            <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                label-for="company_name_bn"
                                label-cols-sm="5"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.company_name_bn') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="company_name_bn"
                                    v-model="profile.company_name_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                           <b-col lg="6" sm="12">
                            <ValidationProvider name="Company Name (En)" vid="company_name" rules="required" v-slot="{ errors }">
                                <b-form-group
                                label-for="company_name"
                                label-cols-sm="5"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.company_name_en') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="company_name"
                                    v-model="profile.company_name"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="Area Type" vid="company_area_type_id" rules="required|min_value:1">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="5"
                                        label-for="company_area_type_id "
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                            {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="profile.company_area_type_id"
                                        id="company_area_type_id"
                                        :options="getAreaTypeList"
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
                            <b-col xl="6" lg="6" sm="12" v-if="companyItemShow">
                                  <ValidationProvider name="Division" vid="company_division_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-for="company_division_id"
                                           label-cols-sm="5"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="profile.company_division_id"
                                          :options="companyDivisionList"
                                          id="company_division_id"
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
                        <b-col xl="6" lg="6" sm="12" v-if="companyItemShow">
                            <ValidationProvider name="District" vid="company_district_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="company_district_id"
                                    label-cols-sm="5"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="profile.company_district_id"
                                    :options="companyDistrictList"
                                    id="company_district_id"
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
                        <b-col xl="6" lg="6" sm="12" v-if="companyPauroshobaItemShow || companyUnionItemShow">
                            <ValidationProvider name="Upazila" vid="company_upazilla_id">
                                <b-form-group
                                    class="row"
                                    label-for="company_upazilla_id"
                                    label-cols-sm="5"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="profile.company_upazilla_id"
                                    :options="companyUpazilaList"
                                    id="company_upazilla_id"
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
                        <b-col xl="6" lg="6" sm="12" v-if="companyCityCorpItemShow">
                            <ValidationProvider name="City Corporation" vid="company_city_corporation_id">
                                <b-form-group
                                    class="row"
                                    label-for="company_city_corporation_id"
                                    label-cols-sm="5"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                        {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="profile.company_city_corporation_id"
                                    :options="companyCityCorporationList"
                                    id="company_city_corporation_id"
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
                        <b-col xl="6" lg="6" sm="12" v-if="!companyItemShow">
                        </b-col>
                         <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="Company Address (Bn)" vid="company_address_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="5"
                                    label-for="company_address_bn"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.company_address') }} {{$t('globalTrans.bn')}}<span class="text-danger">*</span>
                                    </template>
                                 <b-form-textarea
                                        id="company_address_bn"
                                        rows="2"
                                        v-model="profile.company_address_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="Company Address (En)" vid="company_address" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    class="row"
                                    label-cols-sm="5"
                                    label-for="company_address"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.company_address') }} {{$t('globalTrans.en')}}<span class="text-danger">*</span>
                                    </template>
                                 <b-form-textarea
                                        id="company_address"
                                        rows="2"
                                        v-model="profile.company_address"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col xl="6" lg="6" sm="12">
                            <ValidationProvider name="Security Amount" vid="security_amount" v-slot="{ errors }" rules="required">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="security_amount"
                                >
                                <template v-slot:label>
                                    {{ $t('manage_information.security_amount') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="profile.security_amount"
                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>

                         <b-col lg="6" sm="12">
                            <ValidationProvider name="Deposit Date" vid='deposite_date' rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="deposite_date"
                                >
                                    <template v-slot:label>
                                        {{ $t('manage_information.deposite_date') }} <span class="text-danger">*</span>
                                    </template>
                                   <date-picker
                                    id="deposite_date"
                                    v-model="profile.deposite_date"
                                    class="form-control"
                                    :placeholder="$t('globalTrans.select_date')"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    :class="errors[0] ? 'is-invalid' : ''"
                                >
                                </date-picker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>

                        <b-col lg="6" sm="12">
                            <ValidationProvider name="Contract Execution Date" vid='contract_execution_date' rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="contract_execution_date"
                                >
                                    <template v-slot:label>
                                        {{ $t('manage_information.contract_execution_date') }} <span class="text-danger">*</span>
                                    </template>
                                   <date-picker
                                    id="contract_execution_date"
                                    v-model="profile.contract_execution_date"
                                    class="form-control"
                                    :placeholder="$t('globalTrans.select_date')"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    :class="errors[0] ? 'is-invalid' : ''"
                                >
                                </date-picker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>

                        <b-col lg="6" sm="12">
                            <ValidationProvider name="Contract Expiration Date" vid='contract_expiration_date' rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="contract_expiration_date"
                                >
                                    <template v-slot:label>
                                        {{ $t('manage_information.contract_expiration_date') }} <span class="text-danger">*</span>
                                    </template>
                                   <date-picker
                                    id="contract_expiration_date"
                                    v-model="profile.contract_expiration_date"
                                    class="form-control"
                                    :placeholder="$t('globalTrans.select_date')"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    :class="errors[0] ? 'is-invalid' : ''"
                                >
                                </date-picker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                         <b-col lg="12" md="12" sm="12">
                            <ValidationProvider name="Distance from TCB Godown to Sales Center" vid='distance_from_tcb' rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="5"
                                    label-for="distance_from_tcb"
                                >
                                    <template v-slot:label>
                                        {{ $t('manage_information.distance_from_tcb') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-checkbox-group
                                        v-model="profile.distance_from_tcb"
                                        :options="tcbDistanceList"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                    </b-form-checkbox-group>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                         <b-col xl="6" lg="6" sm="12" v-if="!isShow">
                        <ValidationProvider name="Password" :rules="passwordRules">
                            <b-form-group
                                class="row"
                                label-cols-sm="5"
                                label-for="password"
                                slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('userManagement.password')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                type="password"
                                id="password"
                                v-model="profile.password"
                                autocomplete="new-password"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                {{ errors[0] }}
                                </div>
                            </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col xl="6" lg="6" sm="12" v-if="!isShow">
                        <ValidationProvider name="Repeat Password" vid="password_confirmation" :rules="passwordConfirmRules">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="password_confirmation"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('userManagement.password_confirmation')}}<span class="text-danger">*</span>
                            </template>
                            <b-form-input
                            type="password"
                            id="password_confirmation"
                            v-model="profile.password_confirmation"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    </b-row>
                    </b-row>
                    <!-- Present Address -->
                    <b-row class="text-right">
                        <b-col>
                            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ id > 0 ? $t('globalTrans.update') : $t('globalTrans.save')}}</b-button>
                            <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                        </b-col>
                    </b-row>
                </b-form>
            </b-overlay>
        </ValidationObserver>
      </template>
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import BreadCumb from '../../../../../components/BreadCumb.vue'
import { existingDealerStore, existingDealerUpdate, getRegionDvision } from '../../api/routes'
import { mapGetters } from 'vuex'
export default {
  components: { BreadCumb },
  name: 'DealerForm',
  props: ['id'],
  data () {
    return {
        fieldObj: {
            xl: 6,
            lg: 6,
            md: 6,
            sm: 12,
            labelCols: 5
        },
        banglaTitle: 'font-size:1.2rem!important',
        isShow: false,
        baseUrl: 'http://moc-auth-service.local/',
        valid: null,
        // preview: NoImage,
        saveBtnName: this.$t('globalTrans.save'),
        errors: [],
        organization: {},
        nidError: '',
        profile: {
            email: '',
            mobile: '',
            name: '',
            dob: '',
            name_bn: '',
            is_same: '0',
            nid_no: '',
            marital_status: 1,
            father_nid_no: '',
            spouse_nid_no: '',
            father_name_en: '',
            father_name_bn: '',
            agreement_no: '',
            dealer_address: '',
            gender: 0,
            office_id: 0,
            company_city_corporation_id: 0,
            company_upazilla_id: 0,
            company_district_id: 0,
            company_division_id: 0,
            company_area_type_id: 0,
            company_address: '',
            company_address_bn: '',
            company_name: '',
            company_name_bn: '',
            city_corporation_id: 0,
            upazilla_id: 0,
            district_id: 0,
            division_id: 0,
            area_type_id: 0,
            ward_id: 0,
            union_id: 0,
            pauroshoba_id: 0,
            village: '',
            village_bn: '',
            post_code: '',
            security_amount: '',
            deposite_date: '',
            deposite_type: 0,
            contract_execution_date: '',
            contract_expiration_date: '',
            distance_from_tcb: 0,
            password: '',
            password_confirmation: '',
            notice_id: 0
        },
        companyDivisionList: [],
        companyDistrictList: [],
        companyUpazilaList: [],
        companyCityCorporationList: [],
        companyItemShow: false,
        locationShow: false,
        companyCityCorpItemShow: false,
        companyPauroshobaItemShow: false,
        companyUnionItemShow: false,
        municipalityList: [],
        cityCorporationList: [],
        districtList: [],
        upazilaList: [],
        wardList: [],
        ItemShow: false,
        CityCorpItemShow: false,
        PauroshobaItemShow: false,
        UnionItemShow: false,
        UnionItemPerShow: false,
        districtLoading: false,
        invalidNid: 1
    }
  },
  created () {
    if (this.id != null && this.id > 0) {
      this.loadData(this.id)
    }
  },
  computed: {
    options () {
      const datas = this.$store.state.ExternalUserService.dealerPanel.commonObj.maritalStatusList
      return datas.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { text: item.text_bn, value: item.value }
        } else {
          return { text: item.text_en, value: item.value }
        }
      })
    },
     depositeDetailList () {
      let depositeType = [
        {
          value: 1,
          text_en: 'Pay Order',
          text_bn: 'পে-অর্ডার'
        },
        {
          value: 2,
          text_en: 'Bank Cash Deposit',
          text_bn: 'বাংকে নগদ জমা'
        }
      ]
      depositeType = depositeType.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return depositeType
    },
    relationList () {
      let relationType = [
        {
          value: 1,
          text_en: 'Wife',
          text_bn: 'স্ত্রী'
        },
        {
          value: 2,
          text_en: 'Husband',
          text_bn: 'স্বামী'
        },
        {
          value: 3,
          text_en: 'Sister',
          text_bn: 'বোন'
        },
        {
          value: 4,
          text_en: 'Brother',
          text_bn: 'ভাই'
        }
      ]
      relationType = relationType.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return relationType
    },
    tcbDistanceList () {
      let distanceType = [
        {
          value: 1,
          text_en: '0-50 km',
          text_bn: '০-৫০ কিঃ মিঃ'
        },
        {
          value: 2,
          text_en: '51-100 km',
          text_bn: '৫১-১০০ কিঃ মিঃ'
        },
        {
          value: 3,
          text_en: '100+ km',
          text_bn: '১০০+ কিঃ মিঃ'
        }
      ]
      distanceType = distanceType.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return distanceType
    },
    getAreaTypeList: function () {
      const objectData = this.$store.state.commonObj.typeList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.id, text: obj.name_bn }
          } else {
            return { value: obj.id, text: obj.name }
          }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    genderList: function () {
        return this.$store.state.commonObj.genderList.map(el => {
            return Object.assign({ value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    },
    loading: function () {
        return this.$store.state.commonObj.loading
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.id === 7)
    },
    passwordRules: function () {
      return this.id ? '' : 'required|min:6'
    },
    passwordConfirmRules: function () {
      return this.id ? '' : 'required|min:6'
    },
    regionalOfficeList (orgId = 7) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.org_id === 7) && item.is_regional_office === 1)
    },
    ...mapGetters({
        authUser: 'Auth/authUser'
    })
  },
  watch: {
    'profile.office_id': function (n, o) {
      if (o !== n) {
        this.getRegionDivision(n)
      }
    },
    'profile.company_area_type_id': function (n, o) {
      if (o !== n) {
        this.getCompanyAreaTypeData(n)
      }
    },
    'profile.company_division_id': function (newVal, oldVal) {
        if (oldVal !== newVal) {
            const disIds = []
            this.divDistrictList[newVal].forEach(element => {
                    disIds.push(element.district_id)
            })
            this.companyDistrictList = this.$store.state.CommonService.commonObj.districtList.filter(item => disIds.includes(item.value))
        }
    },
    'profile.company_district_id': function (newVal, oldVal) {
      this.companyCityCorporationList = this.getCityCorporationList(newVal)
      this.companyUpazilaList = this.getUpazillaList(newVal)
    },
   'profile.area_type_id': function (n, o) {
      if (o !== n) {
        this.getAreaTypeData(n)
      }
    },
    'profile.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
    },
    'profile.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazillaList(newVal)
    },
    'profile.upazilla_id': function (newVal, oldVal) {
      this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'profile.city_corporation_id': function (newVal, oldVal) {
      if (this.profile.area_type_id === 1) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
      }
    },
    'profile.pauroshoba_id': function (newVal, oldVal) {
      if (this.profile.area_type_id === 2) {
        this.wardList = this.getWardListByPauroshoba(newVal)
      }
    },
    'profile.union_id': function (newVal, oldVal) {
      if (this.profile.area_type_id === 3) {
        this.wardList = this.getWardListByUnion(newVal)
      }
    }
  },
  methods: {
    nidRules (e) {
      if (e.length) {
        this.invalidNid = (parseInt(e.length) === 10 || parseInt(e.length) === 13 || parseInt(e.length) === 17) ? 0 : 1
      } else {
        this.invalidNid = 1
      }
    },
    getCompanyAreaTypeData (typeId) {
      if (typeId) {
        this.companyItemShow = true
        if (typeId === 1) {
          this.companyCityCorpItemShow = true
          this.companyPauroshobaItemShow = false
          this.companyUnionItemShow = false
        } else if (typeId === 2) {
          this.companyCityCorpItemShow = false
          this.companyPauroshobaItemShow = true
          this.companyUnionItemShow = false
        } else if (typeId === 3) {
          this.companyCityCorpItemShow = false
          this.companyPauroshobaItemShow = false
          this.companyUnionItemShow = true
        }
      }
    },
    getAreaTypeData (typeId) {
      if (typeId) {
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
      }
    },
    getDistrictList (divisionId) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === divisionId)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getOfficeList (districtId) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.district_id === districtId) && (item.is_regional_office === 1 && item.org_id === 7))
    },
    getUpazillaList (districtId) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
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
      // if (upazillaId) {
          return objectData.map((obj, key) => {
              if (this.$i18n.locale === 'bn') {
                return { value: obj.value, text: obj.text_bn }
              } else {
                return { value: obj.value, text: obj.text_en }
              }
          })
      // }
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
    async getRegionDivision (officeId) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `${getRegionDvision}/${officeId}`)
        if (result.success) {
            const divIds = []
            const divWiseDistrict = {}
            result.data.map((item, index) => {
                divIds.push(item.division_id)
                divWiseDistrict[item.division_id] = item.district_details
            })
            this.divDistrictList = divWiseDistrict
            this.companyDivisionList = this.$store.state.CommonService.commonObj.divisionList.filter(item => divIds.includes(item.value))
            if (this.profile.company_division_id > 0) {
                const disIds = []
                this.divDistrictList[this.profile.company_division_id].forEach(element => {
                    disIds.push(element.district_id)
                })
                this.companyDistrictList = this.$store.state.CommonService.commonObj.districtList.filter(item => disIds.includes(item.value))
            }
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    cancel () {
        this.$router.push({ path: '/license-registration-service/manage-information/existing-dealer-entry' })
    },
    async loadData (userId) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `/manage-information/existing-dealer/${userId}/edit`)
        if (result.success) {
            const applicant = result.data
            this.id = applicant.id
            this.isShow = true
            this.profile.email = applicant.details.email
            this.profile.mobile = applicant.details.mobile
            this.profile.name = applicant.details.applicant_name
            this.profile.name_bn = applicant.details.applicant_name_bn
            this.profile.nid_no = applicant.details.nid_no
            this.profile.dob = applicant.details.dob
            this.profile.marital_status = applicant.details.marital_status
            this.profile.father_nid_no = applicant.details.father_nid_no
            this.profile.spouse_nid_no = applicant.details.spouse_nid_no
            this.profile.father_name_en = applicant.details.father_spouse_name
            this.profile.father_name_bn = applicant.details.father_spouse_name_bn
            this.profile.agreement_no = applicant.agreement_no
            this.profile.gender = applicant.details.gender
            this.profile.city_corporation_id = applicant.details.city_corporation_id
            this.profile.upazilla_id = applicant.details.upazilla_id
            this.profile.district_id = applicant.details.district_id
            this.profile.division_id = applicant.details.division_id
            this.profile.area_type_id = applicant.details.area_type_id
            this.profile.ward_id = applicant.details.ward_id
            this.profile.union_id = applicant.details.union_id
            this.profile.pauroshoba_id = applicant.details.pauroshoba_id
            this.profile.village = applicant.details.village
            this.profile.village_bn = applicant.details.village_bn
            this.profile.office_id = applicant.office_id
            this.profile.company_area_type_id = applicant.details.company_area_type_id
            this.profile.company_division_id = applicant.details.company_division_id
            this.profile.company_district_id = applicant.details.company_district_id
            this.profile.company_upazilla_id = applicant.details.company_upazilla_id
            this.profile.company_city_corporation_id = applicant.details.company_city_corporation_id
            this.profile.company_name = applicant.details.company_name
            this.profile.company_name_bn = applicant.details.company_name_bn
            this.profile.company_address = applicant.details.company_address
            this.profile.company_address_bn = applicant.details.company_address_bn
            this.profile.security_amount = applicant.payment.amount
            this.profile.deposite_date = applicant.payment.pay_date
            this.profile.contract_execution_date = applicant.agreement_date
            this.profile.contract_expiration_date = applicant.expire_date
            this.profile.distance_from_tcb = applicant.distance_id
        } else {
            this.isShow = true
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    async saveUpdate () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }
        if (this.id) {
            result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${existingDealerUpdate}/${this.id}`, this.profile)
        } else {
            result = await RestApi.postData(licenseRegistrationServiceBaseUrl, existingDealerStore, this.profile)
        }

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
            this.$store.dispatch('mutateCommonProperties', { hasDropdownLoaded: false })
            this.$toast.success({
                title: this.$t('globalTrans.success'),
                message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
            })
            this.$router.push({ path: '/license-registration-service/manage-information/existing-dealer-entry' })
        } else {
            this.$refs.form.setErrors(result.errors)
        }
    },
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>

<style>
.font-bn label {
  font-size: 1rem!important;
  font-weight: normal!important;
}
</style>
