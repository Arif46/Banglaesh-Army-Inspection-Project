<template>
  <div>
    <b-overlay :show="loading">
      <b-row v-if="isLoad">
        <b-col sm="12" v-if="!noticeActive">
          <div class="text-center mb-4 mt-2">
            <h5 class="card-title text-danger">{{ $t('dealer.notice_wait') }}</h5>
          </div>
        </b-col>
        <b-col sm="12" v-else>
           <div class="text-center mb-4 mt-2">
            <h5 class="card-title" style="border-bottom: 2px solid gray;font-weight: 600">{{ $t('dealer.application_form') }}</h5>
          </div>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
              <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Applicant Name (EN)" vid="applicant_name" rules="required">
                    <b-form-group
                      class="row"
                      label-for="applicant_name"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('dealer.applicant_name_en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="applicant_name"
                        v-model="form.applicant_name"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Applicant Name (BN)" vid="applicant_name_bn" rules="required">
                    <b-form-group
                      class="row"
                      label-for="applicant_name_bn"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('dealer.applicant_name_bn') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="applicant_name_bn"
                        v-model="form.applicant_name_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Father/ Spouse Name (EN)" vid="father_spouse_name" rules="required">
                    <b-form-group
                      class="row"
                      label-for="father_spouse_name"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('dealer.father_spouse_name_en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="father_spouse_name"
                        v-model="form.father_spouse_name"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Father/ Spouse Name (EN)" vid="father_spouse_name_bn" rules="required">
                    <b-form-group
                      class="row"
                      label-for="father_spouse_name_bn"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('dealer.father_spouse_name_bn') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="father_spouse_name_bn"
                        v-model="form.father_spouse_name_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                  <ValidationProvider name="Mobile" vid="mobile" rules="required|min:11|max:11">
                    <b-form-group
                      class="row"
                      label-for="mobile"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('dealer.mobile') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="mobile"
                        type="number"
                        v-model="form.mobile"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Dealer Status" vid="dealer_previous_record">
                        <b-form-group
                          class
                          label-for="dealer_previous_record"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          <div style="font-weight: bold">
                            {{ $t('dealer.have_you_ever_been_dealer') }}
                          </div>
                        </template>
                        <!-- <b-form-checkbox
                          style="margin-top:5px"
                          v-model="form.dealer_previous_record"
                          :state="errors[0] ? false : (valid ? true : null)"
                          value=1
                          unchecked-value=0
                        >
                        <span class="text-black">{{ $t('globalTrans.yes') }}</span>
                        </b-form-checkbox> -->
                        <b-form-radio-group
                          style="margin-top:5px;"
                          :id="dealer_previous_record"
                          v-model="form.dealer_previous_record"
                          :options="valueOptions"
                        ></b-form-radio-group>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="family license Status" vid="other_family_license">
                        <b-form-group
                            class
                            label-for="other_family_license"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            <div style="font-weight: bold">
                                {{ $t('dealer.dealer_condition_msg') }}
                            </div>
                        </template>
                        <!-- <b-form-checkbox
                            style="margin-top:5px"
                            v-model="form.other_family_license"
                            :state="errors[0] ? false : (valid ? true : null)"
                            value=1
                            unchecked-value=0
                        >
                        <span class="text-black">{{ $t('globalTrans.yes') }}</span>
                        </b-form-checkbox> -->
                        <b-form-radio-group
                          style="margin-top:5px;"
                          :id="other_family_license"
                          v-model="form.other_family_license"
                          :options="valueOptions"
                        ></b-form-radio-group>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                   <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="form.dealer_previous_record == 1">
                    <ValidationProvider name="reason" vid="reason" v-slot="{ errors }">
                      <b-form-group
                        class="row"
                        :label-cols-sm="12"
                        label-for="reason"
                      >
                        <template v-slot:label>
                            {{$t('dealer.cancel_reason')}}
                        </template>
                        <b-form-textarea
                            v-model="form.reason"
                            rows="3"
                            max-rows="2"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <template v-if="form.other_family_license == 0">
                    <b-col v-if="form.other_family_license == 1" md="12" sm="12">
                      <b-row>
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Dealership Name (En)" vid="other_dealer_name" rules="required">
                            <b-form-group
                              class="row"
                              label-for="other_dealer_name"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.dealer_name_en') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="other_dealer_name"
                                v-model="form.other_dealer_name"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Dealership Name (BN)" vid="other_dealer_name_bn" rules="required">
                            <b-form-group
                              class="row"
                              label-for="other_dealer_name_bn"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.dealer_name_bn') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="other_dealer_name_bn"
                                v-model="form.other_dealer_name_bn"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Company Name (EN)" vid="other_company_name" rules="required">
                            <b-form-group
                              class="row"
                              label-for="other_company_name"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.company_name_en') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="other_company_name"
                                v-model="form.other_company_name"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Company Name (BN)" vid="other_company_name_bn" rules="required">
                            <b-form-group
                              class="row"
                              label-for="other_company_name_bn"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.company_name_bn') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="other_company_name_bn"
                                v-model="form.other_company_name_bn"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col xl="4" lg="4" md="4" sm="12">
                            <ValidationProvider name="Division" vid="other_company_division_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="other_company_division_id"
                                    slot-scope="{ valid, errors }">
                                    <template v-slot:label>
                                        {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="form.other_company_division_id"
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
                        <b-col xl="4" lg="4" md="4" sm="12">
                            <ValidationProvider name="District" vid="other_company_district_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="other_company_district_id"
                                    slot-scope="{ valid, errors }">
                                    <template v-slot:label>
                                        {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="form.other_company_district_id"
                                        :options="otherDistrictList"
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
                        <b-col xl="4" lg="4" md="4" sm="12">
                          <ValidationProvider name="Upazilla" vid="other_company_upazilla_id" rules="required|min_value:1">
                            <b-form-group
                                class="row"
                                label-for="other_company_upazilla_id"
                                slot-scope="{ valid, errors }">
                                <template v-slot:label>
                                    {{ $t('globalTrans.upazila')}} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                    plain
                                    v-model="form.other_company_upazilla_id"
                                    :options="otherUpazillaList"
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
                      </b-row>
                    </b-col>
                    <b-col md="12" sm="12">
                      <b-row>
                        <b-col xl="4" lg="4" md="4" sm="12">
                          <ValidationProvider name="Dealer Type" vid="dealer_type" rules="required|min_value:1">
                              <b-form-group
                                  class="row"
                                  label-for="dealer_type"
                                  slot-scope="{ valid, errors }">
                                  <template v-slot:label>
                                      {{ $t('allocation_management.dealer_type')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                      plain
                                      v-model="form.dealer_type"
                                      :options="sellerTypeList"
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
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Company Name (EN)" vid="company_name" rules="required">
                            <b-form-group
                              class="row"
                              label-for="company_name"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.company_name_en') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="company_name"
                                v-model="form.company_name"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col md="4" sm="12">
                          <ValidationProvider name="Company Name (BN)" vid="company_name_bn" rules="required">
                            <b-form-group
                              class="row"
                              label-for="company_name_bn"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('dealer.company_name_bn') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="company_name_bn"
                                v-model="form.company_name_bn"
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
                            <b-col lg="4" sm="12">
                              <ValidationProvider name="Area Type" vid="company_area_type_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="company_area_type_id "
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                        {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.company_area_type_id"
                                    id="company_area_type_id"
                                    :options="getCompAreaTypeList"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                    <template v-slot:first>
                                        <b-form-select-option value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                    {{ errors[0] }}
                                    </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col lg="4" sm="12" v-if="comItemShow">
                              <ValidationProvider name="Division" vid="company_division_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="company_division_id"
                                    slot-scope="{ valid, errors }"
                                    >
                                    <template v-slot:label>
                                    {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    v-model="form.company_division_id"
                                    :options="divisionNList"
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
                            <b-col lg="4" sm="12" v-if="comItemShow">
                                <ValidationProvider name="District" vid="company_district_id" rules="required|min_value:1">
                                    <b-form-group
                                        class="row"
                                        label-for="company_district_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                        {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_district_id"
                                        :options="comDistrictList"
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
                            <b-col lg="4" sm="12" v-if="comPauroshobaItemShow || comUnionItemShow">
                                <ValidationProvider name="Upazila" vid="company_upazilla_id">
                                    <b-form-group
                                        class="row"
                                        label-for="company_upazilla_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                        {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_upazilla_id"
                                        :options="comUpazillaList"
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
                            <b-col lg="4" sm="12" v-if="comUnionItemShow">
                                <ValidationProvider name="Union" vid="company_union_id">
                                    <b-form-group
                                        class="row"
                                        label-for="company_union_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                        {{ $t('orgProfile.union')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_union_id"
                                        :options="comUnionList"
                                        id="company_union_id"
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
                            <b-col lg="4" sm="12" v-if="comCityCorpItemShow">
                                <ValidationProvider name="City Corporation" vid="company_city_corporation_id">
                                    <b-form-group
                                        class="row"
                                        label-for="company_city_corporation_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                            {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_city_corporation_id"
                                        :options="comCityCorporationList"
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
                            <b-col lg="4" sm="12" v-if="comPauroshobaItemShow">
                                <ValidationProvider name="Municipality" vid="company_pauroshoba_id">
                                    <b-form-group
                                        class="row"
                                        label-for="company_pauroshoba_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                            {{ $t('orgProfile.municipality_name') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_pauroshoba_id"
                                        :options="comMunicipalityList"
                                        id="company_pauroshoba_id"
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
                            <!-- <b-col lg="4" sm="12" v-if="comItemShow">
                                <ValidationProvider name="Ward" vid="company_ward_id">
                                    <b-form-group
                                        class="row"
                                        label-for="company_ward_id"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                            {{ $t('orgProfile.ward') }}
                                        </template>
                                        <b-form-select
                                        plain
                                        v-model="form.company_ward_id"
                                        :options="comWardList"
                                        id="company_ward_id"
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
                            </b-col> -->
                          </b-row>
                        </b-col>
                        <!-- <b-col xl="4" lg="4" md="4" sm="12">
                            <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
                                <b-form-group
                                    class="row"
                                    label-for="office_id"
                                    slot-scope="{ valid, errors }"
                                >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.office')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        v-model="form.office_id"
                                        :options="officeList"
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
                        </b-col> -->
                      </b-row>
                    </b-col>
                    <b-col md="12" sm="12">
                      <b-row>
                        <b-col sm="4">
                          <h6 class="mb-3 tag">{{ $t('dealer.permanent_address') }}</h6>
                        </b-col>
                        <b-col sm="6">
                            <b-form-group
                                class="row"
                                label-for="is_same"
                            >
                            <b-form-checkbox
                                style="margin-top:5px"
                                v-model="same_as_profile"
                            >
                            <span class="text-black">{{ $t('dealer.same_as_profile') }}</span>
                            </b-form-checkbox>
                            </b-form-group>
                        </b-col>
                        <b-col md="12" sm="12">
                          <b-row>
                              <b-col lg="4" sm="12">
                                  <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-for="area_type_id "
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.area_type_id"
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
                              <b-col lg="4" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-for="division_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.division_id"
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
                              <b-col lg="4" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                      <b-form-group
                                          class="row"
                                          label-for="district_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.district_id"
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
                              <b-col lg="4" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                                  <ValidationProvider name="Upazila" vid="upazilla_id">
                                      <b-form-group
                                          class="row"
                                          label-for="upazilla_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.upazilla_id"
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
                              <b-col lg="4" sm="12" v-if="UnionItemShow">
                                  <ValidationProvider name="Union" vid="union_id">
                                      <b-form-group
                                          class="row"
                                          label-for="union_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                          {{ $t('orgProfile.union')}} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.union_id"
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
                              <b-col lg="4" sm="12" v-if="CityCorpItemShow">
                                  <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                      <b-form-group
                                          class="row"
                                          label-for="city_corporation_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.city_corporation_id"
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
                              <b-col lg="4" sm="12" v-if="PauroshobaItemShow">
                                  <ValidationProvider name="Municipality" vid="pauroshoba_id">
                                      <b-form-group
                                          class="row"
                                          label-for="pauroshoba_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.municipality_name') }} <span class="text-danger">*</span>
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.pauroshoba_id"
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
                              <b-col lg="4" sm="12" v-if="ItemShow">
                                  <ValidationProvider name="Ward" vid="ward_id">
                                      <b-form-group
                                          class="row"
                                          label-for="ward_id"
                                          slot-scope="{ valid, errors }"
                                          >
                                          <template v-slot:label>
                                              {{ $t('orgProfile.ward') }}
                                          </template>
                                          <b-form-select
                                          plain
                                          v-model="form.ward_id"
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
                              <b-col md="4" sm="12" v-if="UnionItemShow">
                                <ValidationProvider name="Village (EN)" vid="village" rules="">
                                  <b-form-group
                                    class="row"
                                    label-for="village">
                                    <template v-slot:label>
                                      {{ $t('dealer.village_en') }}
                                    </template>
                                    <b-form-input
                                      id="village"
                                      v-model="form.village"
                                    ></b-form-input>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col md="4" sm="12" v-if="UnionItemShow">
                                <ValidationProvider name="Village (BN)" vid="village_bn" rules="">
                                  <b-form-group
                                    class="row"
                                    label-for="village_bn">
                                    <template v-slot:label>
                                      {{ $t('dealer.village_bn') }}
                                    </template>
                                    <b-form-input
                                      id="village_bn"
                                      v-model="form.village_bn"
                                    ></b-form-input>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                          </b-row>
                        </b-col>
                      </b-row>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Date Of Bitrh" vid="dob" rules="required">
                        <b-form-group
                          class="row"
                          label-for="dob"
                          slot-scope="{ valid, errors }">
                          <template v-slot:label>
                            {{ $t('dealer.dob') }}  <span class="text-danger">*</span>
                          </template>
                          <date-picker
                            id="dob"
                            v-model="form.dob"
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
                    <b-col md="4" sm="12">
                      <ValidationProvider name="NID No" vid="nid_no" rules="required">
                        <b-form-group
                          class="row"
                          label-for="nid_no"
                          slot-scope="{ valid, errors }">
                          <template v-slot:label>
                            {{ $t('dealer.nid_no') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="nid_no"
                            type="number"
                            v-model="form.nid_no"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="4" sm="12">
                      <ValidationProvider name="Merital Status" vid="marital_status" rules="required">
                          <b-form-group
                              class
                              label-for="marital_status"
                              slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                            <div >
                              {{ $t('dealer.marital_status') }} <span class="text-danger">*</span>
                            </div>
                          </template>
                            <b-form-radio-group
                              id="marital_status"
                              v-model="form.marital_status"
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
                    <b-col md="4" sm="12" v-if="form.marital_status == 1">
                        <ValidationProvider name="Spouse NID" vid="spouse_nid_no" rules="required">
                          <b-form-group
                            class="row"
                            label-for="spouse_nid_no"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.spouse_nid_no') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="spouse_nid_no"
                              type="number"
                              v-model="form.spouse_nid_no"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col md="4" sm="12" v-if="form.marital_status == 2">
                        <ValidationProvider name="Spouse NID" vid="father_nid_no" rules="required">
                          <b-form-group
                            class="row"
                            label-for="father_nid_no"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.father_nid_no') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="father_nid_no"
                              type="number"
                              v-model="form.father_nid_no"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col md="4" sm="12">
                        <ValidationProvider name="Email" vid="email" rules="">
                          <b-form-group
                            class="row"
                            label-for="email"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.email') }}
                            </template>
                            <b-form-input
                              id="email"
                              v-model="form.email"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col md="4" sm="12">
                        <ValidationProvider name="TIN No" vid="tin_no" rules="required">
                          <b-form-group
                            class="row"
                            label-for="tin_no"
                            slot-scope="{ valid, errors }">
                            <template v-slot:label>
                              {{ $t('dealer.tin_no') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-input
                              id="tin_no"
                              v-model="form.tin_no"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
                    </b-col>
                    <b-col md="12">
                      <h6 class="m-0 tag mb-3">{{ $t('dealer.important_document') }}  <span style="font-size:12px" class="text-danger">{{ $t('dealer.max_upload') }}</span> <span style="font-size:12px" class="text-danger">{{ $t('dealer.upload_type') }}</span></h6>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Applicant Photo" vid="applicant_image" :rules="required">
                        <b-form-group
                          label-for="applicant_image"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                            {{ $t('dealer.applicant_image') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                            <b-form-file
                              name="applicant_image"
                              accept=".pdf,.jpeg,.jpg"
                              v-model="form.applicant_image"
                              @change="onChange($event, 'applicantImage')"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-file>
                              <b-input-group-append v-if="form.applicant_image_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.applicant_image_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.applicantImage }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Trade License (Grocery business)" vid="trade_license">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="trade_license">
                          <template v-slot:label>
                            {{ $t('dealer.trade_license') }}
                          </template>
                          <b-input-group>
                          <b-form-file
                            name="trade_license"
                            v-model="form.trade_license"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'tradeLicense')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.trade_license_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.trade_license_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.tradeLicense }}</span>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Bank Solvency Certificate" vid="bank_solvency" :rules="required">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="bank_solvency">
                          <template v-slot:label>
                            {{ $t('dealer.bank_solvency') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                          <b-form-file
                           id="bank_solvency"
                            name="bank_solvency"
                            v-model="form.bank_solvency"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'bankSolvency')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.bank_solvency_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.bank_solvency_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.bankSolvency }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="NID Copy" vid="nid" :rules="required">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="nid">
                          <template v-slot:label>
                            {{ $t('dealer.nid') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                          <b-form-file
                            id="nid"
                            name="nid"
                            v-model="form.nid"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'nid')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.nid_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.nid_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.nid }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="TIN Certificate" vid="tin" :rules="required">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="tin">
                          <template v-slot:label>
                            {{ $t('dealer.tin') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                          <b-form-file
                            id="tin"
                            name="tin"
                            v-model="form.tin"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'tin')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.tin_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.tin_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.tin }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Shop Rent/Ownership Document" vid="shop_document" :rules="required">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="shop_document">
                          <template v-slot:label>
                            {{ $t('dealer.shop_document') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                          <b-form-file
                            id="shop_document"
                            name="shop_document"
                            v-model="form.shop_document"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'shopDocument')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.shop_document_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.shop_document_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.shopDocument }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="VAT Registration Certificate (If)" vid="vat_certificate">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="vat_certificate">
                          <template v-slot:label>
                            {{ $t('dealer.vat_certificate') }}
                          </template>
                          <b-input-group>
                          <b-form-file
                            id="vat_certificate"
                            name="vat_certificate"
                            v-model="form.vat_certificate"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'vatCertificate')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.vat_certificate_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.vat_certificate_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.vatCertificate }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                      <ValidationProvider name="Citizenship Certificate" vid="citizen_certificate" :rules="required">
                        <b-form-group
                          slot-scope="{ valid, errors }"
                          label-for="citizen_certificate">
                          <template v-slot:label>
                            {{ $t('dealer.citizen_certificate') }} <span class="text-danger">*</span>
                          </template>
                          <b-input-group>
                          <b-form-file
                            id="citizen_certificate"
                            name="citizen_certificate"
                            v-model="form.citizen_certificate"
                            accept=".pdf,.jpeg,.jpg"
                            @change="onChange($event, 'citizenCertificate')"
                            :state="errors[0] ? false : (valid ? true : null)"
                          ></b-form-file>
                            <b-input-group-append v-if="form.citizen_certificate_url">
                              <a target="_blank" :href="licenseRegistrationServiceBaseUrl+form.citizen_certificate_url" style="padding: 2px 10px;" class="btn btn-primary btn-sm" ><i class="ri-download-2-line"></i></a>
                            </b-input-group-append>
                          </b-input-group>
                          <span class="text-danger">{{ errMessage.citizenCertificate }}</span>
                          <div class="d-block invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <!--import notice license-->
                    <b-row>
                      <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                        <ValidationProvider name="Condition required" vid="punitive_action" v-slot="{ errors }" rules="required|min_value:1">
                          <b-form-group
                            label-for="punitive_action"
                          >
                          <b-form-checkbox
                            v-model="form.punitive_action"
                            name="punitive_action"
                            style="margin-top:5px"
                            :state="errors[0] ? false : (valid ? true : null)"
                            value=1
                            unchecked-value=0
                          >
                          <span class="text-black">{{ $t('dealer.application_text_two') }}</span>
                          </b-form-checkbox>
                          <div class="invalid-feedback d-block">
                              {{ errors[0] }}
                          </div>
                          </b-form-group>
                        </ValidationProvider>
                      </b-col>
                    </b-row>
                  </template>
                  <template v-if="form.other_family_license == 1">
                    <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                      <h6 class="m-0 mb-3"><span style="font-size:20px;" class="text-danger">{{ $t('dealer.delar_license_notice') }}</span></h6>
                    </b-col>
                  </template>
              </b-row>
              <b-row class="text-right mt-4">
                <b-col v-if="form.other_family_license == 0">
                    <b-button type="submit" @click="form.save_status = 2" variant="primary" class="mr-2">{{ $t('dealer.submit') }}</b-button>
                    <!-- <b-button type="submit" @click="finalSave()" variant="primary" class="mr-2">{{ $t('dealer.submit') }}</b-button> -->
                    &nbsp;
                    <b-button type="submit" @click="form.save_status = 1" variant="warning" class="mr-2">{{ $t('dealer.save_draft') }}</b-button>
                    <b-button type="button" variant="danger" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                  </b-col>
              </b-row>
            </b-form>
          </ValidationObserver>
        </b-col>
      </b-row>
      <slot v-else>
        <br/>
        <br/>
        <div class="text-center">{{ $t('dealer.application_form') }} {{ $t('globalTrans.loading') }} ......</div>
        <br/>
        <br/>
      </slot>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { applicationStore, applicationUpdate, noticeRecuirmentNoticeList } from '../../api/routes'
// import moment from 'moment'
export default {
  name: 'Form',
  props: ['appDetail', 'isRenew'],
  components: {
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      loading: false,
      required: 'required',
      isLoad: false,
      same_as_profile: false,
      noticeActive: false,
      ItemShow: false,
      locationShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      UnionItemPerShow: false,
      districtLoading: false,
      comItemShow: false,
      comlocationShow: false,
      comCityCorpItemShow: false,
      comPauroshobaItemShow: false,
      comUnionItemShow: false,
      comUnionItemPerShow: false,
      comdistrictLoading: false,
      form: {
        org_id: 0,
        region_id: 0,
        notice_id: 0,
        applicant_name: '',
        applicant_name_bn: '',
        fasp_name: '',
        fasp_name_bn: '',
        mobile: '',
        other_family_license: '',
        dealer_previous_record: '',
        punitive_action: 0,
        reason: '',
        other_dealer_name: '',
        other_dealer_name_bn: '',
        other_company_name: '',
        other_company_name_bn: '',
        other_company_division_id: 0,
        other_company_district_id: 0,
        other_company_upazilla_id: 0,
        company_name: '',
        company_name_bn: '',
        company_division_id: 0,
        company_district_id: 0,
        company_upazilla_id: 0,
        company_union_id: 0,
        company_area_type_id: 0,
        company_city_corporation_id: 0,
        company_pauroshoba_id: 0,
        company_ward_id: 0,
        office_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: 0,
        union_id: 0,
        village: '',
        village_bn: '',
        dob: '',
        nid_no: '',
        marital_status: 1,
        father_nid_no: '',
        spouse_nid_no: '',
        email: '',
        tin_no: '',
        applicant_image: [],
        trade_license: [],
        bank_solvency: [],
        nid: [],
        tin: [],
        shop_document: [],
        vat_certificate: [],
        citizen_certificate: [],
        save_status: 2,
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        ward_id: 0
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      otherDistrictList: [],
      otherUpazillaList: [],
      officeList: [],
      divisionNList: [],
      wardList: [],
      municipalityList: [],
      cityCorporationList: [],
      buttonState: false,
      valid: '',
      BankSolvencyValidation: '',
      nidValidationMes: '',
      errMessage: {
        nid: '',
        bankSolvency: ''
      },
      areaTypeList: [],
      companydistrictList: [],
      companyCityCorporationList: [],
      companyUpazillaList: [],
      companyMunicipalityList: [],
      companyUnionList: [],
      comDistrictList: [],
      comUpazillaList: [],
      comCityCorporationList: [],
      comMunicipalityList: [],
      comUnionList: [],
      valueOptions: [
          { value: 1, text: this.$i18n.locale === 'en' ? 'Yes' : 'হ্যাঁ' },
          { value: 0, text: this.$i18n.locale === 'en' ? 'No' : 'না' }
      ]
    }
  },
  created () {
    if (!this.isRenew) {
      this.noticeActive = false
      this.getNoticeActive()
    } else {
      this.getDivision(this.appDetail)
      this.form = this.getEditData(this.appDetail)
      this.noticeActive = true
      this.isLoad = true
    }
    if (this.appDetail) {
      this.required = ''
    } else {
      this.required = 'required'
    }
    // this.noticeActive = false
    // this.getNoticeActive()
    // if (this.appDetail) {
    //   this.required = ''
    // } else {
    //   this.required = 'required'
    // }
  },
  watch: {
    same_as_profile: function (n, o) {
      if (n) {
        this.form.area_type_id = this.commonProfile.pm_area_type_id
        this.form.city_corporation_id = this.commonProfile.pm_city_corporation_id
        this.form.division_id = this.commonProfile.pm_division_id
        this.form.district_id = this.commonProfile.pm_district_id
        this.form.upazilla_id = this.commonProfile.pm_upazilla_id
        this.form.pauroshoba_id = this.commonProfile.pm_pauroshoba_id
        this.form.union_id = this.commonProfile.pm_union_id
        this.form.ward_id = this.commonProfile.pm_ward_id
        this.form.village = this.commonProfile.pm_address_details_en
        this.form.village_bn = this.commonProfile.pm_address_details_bn
      } else {
        this.form.area_type_id = 0
        this.form.city_corporation_id = 0
        this.form.division_id = 0
        this.form.district_id = 0
        this.form.upazilla_id = 0
        this.form.pauroshoba_id = 0
        this.form.union_id = 0
        this.form.ward_id = 0
        this.form.village = ''
        this.form.village_bn = ''
      }
    },
    'form.area_type_id': function (n, o) {
      if (o !== n) {
        this.getAreaTypeData(n)
      }
    },
    'form.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
    },
    'form.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazillaList(newVal)
    },
    'form.upazilla_id': function (newVal, oldVal) {
      this.unionList = this.getUnionList(newVal)
      this.municipalityList = this.getPauroshobaList(newVal)
    },
    'form.city_corporation_id': function (newVal, oldVal) {
      if (this.form.area_type_id === 1) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
      }
    },
    'form.pauroshoba_id': function (newVal, oldVal) {
      if (this.form.area_type_id === 2) {
        this.wardList = this.getWardListByPauroshoba(newVal)
      }
    },
    'form.union_id': function (newVal, oldVal) {
      if (this.form.area_type_id === 3) {
        this.wardList = this.getWardListByUnion(newVal)
      }
    },
    'form.company_area_type_id': function (n, o) {
      if (o !== n) {
        this.getComAreaTypeData(n)
      }
    },
    'form.company_division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getCompanyDistrictList(newVal)
      }
    },
    'form.company_district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.comCityCorporationList = this.getCompanyCityCorporationList(newVal)
        this.getCompanyUpazillaList(newVal)
        this.officeList = this.getOfficeList(newVal)
      }
    },
    'form.company_upazilla_id': function (newVal, oldVal) {
      this.comUnionList = this.getCompanyUnionList(newVal)
      this.comMunicipalityList = this.getCompanyPauroshobaList(newVal)
    },
    'form.company_city_corporation_id': function (newVal, oldVal) {
        if (this.form.company_area_type_id === 1) {
          this.comWardList = this.getWardListByCityCorportaion(newVal)
        }
    },
    'form.company_pauroshoba_id': function (newVal, oldVal) {
      if (this.form.company_area_type_id === 2) {
        this.comWardList = this.getWardListByPauroshoba(newVal)
      }
    },
    'form.company_union_id': function (newVal, oldVal) {
      if (this.form.company_area_type_id === 3) {
        this.comWardList = this.getWardListByUnion(newVal)
      }
    },
    'form.other_company_division_id': function (n, o) {
      if (o !== n) {
        this.otherDistrictList = this.getDistrictList(n)
      }
    },
    'form.other_company_district_id': function (n, o) {
      if (o !== n) {
        this.otherUpazillaList = this.getUpazillaList(n)
      }
    }
  },
  computed: {
    getAreaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getCompAreaTypeList: function () {
      const list = this.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
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
    orgList: function () {
      return this.$store.state.CommonService.commonObj.componentOrgList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    sellerTypeList: function () {
      const type = this.$store.state.ExternalUserService.dealerPanel.commonObj.sellerTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { text: item.text_bn, value: item.value }
        } else {
          return { text: item.text_en, value: item.value }
        }
      })
      return type
    },
    commonProfile () {
      return this.$store.state.Auth.commonProfile
    }
  },
  methods: {
    finalSave () {
      this.$swal({
        title: this.$t('dealer.final_save_msg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          // this.saveUpdate()
        }
      })
    },
    getComAreaTypeData (typeId) {
      if (typeId) {
        this.comItemShow = true
        if (typeId === 1) {
          this.comCityCorpItemShow = true
          this.comPauroshobaItemShow = false
          this.comUnionItemShow = false
        } else if (typeId === 2) {
          this.comCityCorpItemShow = false
          this.comPauroshobaItemShow = true
          this.comUnionItemShow = false
        } else if (typeId === 3) {
          this.comCityCorpItemShow = false
          this.comPauroshobaItemShow = false
          this.comUnionItemShow = true
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
    async getNoticeActive () {
      this.noticeActive = false
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, noticeRecuirmentNoticeList)
      if (result.success) {
        this.form.notice_id = result.data.id
        this.noticeActive = true
        this.getDivision(result.data)
        if (this.appDetail) {
          this.form = this.getEditData(this.appDetail)
        }
        this.isLoad = true
      } else {
        this.isLoad = true
      }
    },
    getDivision (allData) {
      const areaTypeList = this.$store.state.commonObj.areaTypeList
      if (allData.area_type_id) {
        this.areaTypeList = areaTypeList.filter(item => item.value === allData.area_type_id)
      } else {
        this.areaTypeList = areaTypeList
      }
      this.divisionNList = this.customizeData(this.$store.state.CommonService.commonObj.divisionList, allData.division_id)
      this.companydistrictList = this.customizeData(this.$store.state.CommonService.commonObj.districtList, allData.district_id)
      this.companyCityCorporationList = this.customizeData(this.$store.state.CommonService.commonObj.cityCorporationList, allData.city_corporation_id)
      this.companyUpazillaList = this.customizeData(this.$store.state.CommonService.commonObj.upazilaList, allData.upazila_id)
      this.companyMunicipalityList = this.customizeData(this.$store.state.CommonService.commonObj.municipalityList, allData.pauroshoba_id)
      this.companyUnionList = this.customizeData(this.$store.state.CommonService.commonObj.unionList, allData.union_id)
    },
    customizeData (dataAll, dataId) {
      let data = []
      if (dataId) {
        if (dataId.length > 0) {
          dataId.forEach((item, key) => {
            const dataItem = dataAll.find(item1 => item1.value === parseInt(item))
            data.push(dataItem)
          })
        } else {
          data = dataAll
        }
      } else {
        data = dataAll
      }
      return data
    },
    getCompanyDistrictList (divisionId) {
      const comDistrictList = this.companydistrictList.filter(item => item.status === 1 && item.division_id === divisionId)
      this.comDistrictList = comDistrictList
    },
    getCompanyUpazillaList (districtId) {
      const comUpazillaList = this.companyUpazillaList.filter(item => item.status === 1 && item.district_id === districtId)
      this.comUpazillaList = comUpazillaList
    },
    getCompanyCityCorporationList (districtId) {
      return this.companyCityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
    },
    getCompanyUnionList (upazillaId) {
      const unionList = this.companyUnionList.filter(item => item.upazila_id === upazillaId)
      return unionList
    },
    getCompanyPauroshobaList (upazillaId) {
      const pauroshobaList = this.companyMunicipalityList.filter(item => item.upazila_id === upazillaId)
      return pauroshobaList
    },
    onChange (e, type) {
      const selectedFile = e.target.files[0]
      if (selectedFile.size > 1024 * 1024) {
        e.preventDefault()
        this.errMessage[type] = this.$t('dealer.max_upload')
      } else {
        this.errMessage[type] = ''
        const reader = new FileReader()
        reader.onload = (event) => {
          this.form[e.target.name] = event.target.result
        }
        reader.readAsDataURL(selectedFile)
      }
    },
    saveUpdate () {
      const saveStatus = this.form.save_status
      if (saveStatus === 2) {
          this.$swal({
          title: this.$t('dealer.final_save_msg'),
          showCancelButton: true,
          confirmButtonText: this.$t('globalTrans.yes'),
          cancelButtonText: this.$t('globalTrans.no'),
          focusConfirm: false
        }).then((result) => {
          if (result.isConfirmed) {
            this.submitForm()
          }
        })
      } else {
        this.submitForm()
      }
    },
    async submitForm () {
      var formData = new FormData()
      Object.keys(this.form).map(key => {
        formData.append(key, this.form[key])
      })
      let result = null
      this.loading = true
      if (this.isRenew && this.appDetail && this.appDetail.agreement_no) {
        formData.append('type', 2)
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, applicationStore, formData)
      } else if (this.appDetail) {
        formData.append('_method', 'PUT')
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, `${applicationUpdate}/${this.appDetail.tcb_application_id}`, formData)
      } else {
        formData.append('type', 1)
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, applicationStore, formData)
      }
      this.loading = false
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.appDetail ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$emit('submitForm')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getUpazillaList (districtId) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
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
    getEditData (item) {
      const finalItem = Object.assign(item, Object.assign(item.details,
      {
        applicant_image_url: item.details.applicant_image,
        trade_license_url: item.details.trade_license,
        bank_solvency_url: item.details.bank_solvency,
        nid_url: item.details.nid,
        tin_url: item.details.tin,
        shop_document_url: item.details.shop_document,
        vat_certificate_url: item.details.vat_certificate,
        citizen_certificate_url: item.details.citizen_certificate,
        applicant_image: [],
        trade_license: [],
        bank_solvency: [],
        nid: [],
        tin: [],
        shop_document: [],
        vat_certificate: [],
        citizen_certificate: []
      }))
      return JSON.parse(JSON.stringify(finalItem))
    }
  }
}
</script>
<style scoped>
  .tag {
    font-weight: 600;
    border-left: 4px solid #1c4261;
    padding-left: 6px;
  }
</style>
