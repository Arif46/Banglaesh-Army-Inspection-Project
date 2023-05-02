<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="4">
                            <ValidationProvider name="Factory Type" vid="factory_type_id" rules="required|min_value:1">
                                <b-form-group
                                    slot-scope="{ valid, errors }"
                                    label-for="factory_type_id">
                                    <template v-slot:label>
                                        {{ $t('teaGardenConfig.factory_type') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        :disabled="isRenew"
                                        plain
                                        v-model="application.factory_type_id"
                                        id="area_type_id"
                                        :options="getFactoryTypeList"
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
                        <b-col sm="8">
                            <ValidationProvider name="Manufacturing Methods" vid="manufacturing_methods" rules="required">
                                <b-form-group
                                    :disabled="isRenew"
                                    slot-scope="{ valid, errors }"
                                    label-for="manufacturing_method"
                                    label-class="font-weight-bold pt-0" class="mb-0">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.manufacturing_method') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-checkbox-group :disabled="isRenew"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        class="custom-control-inline-wrapper" size="lg" v-model="application.manufacturing_methods" :options="getMadeTeaTypeList">
                                    </b-form-checkbox-group>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <!-- garden load  -->
                        <b-col sm="4" v-if="application.factory_type_id === 1">
                            <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
                                <b-form-group
                                    slot-scope="{ valid, errors }"
                                    label-for="factory_type_id">
                                    <template v-slot:label>
                                        {{ $t('teaGardenConfig.garden_name') }}<span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        :disabled="isRenew"
                                        plain
                                        v-model="application.garden_id"
                                        id="area_type_id"
                                        :options="getGardenList"
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
                        <!-- applicant info section  -->
                        <b-col sm="12" v-if="application.factory_type_id === 2 || application.factory_type_id === 3">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.applicant_label')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                             <!-- applicant name  -->
                                             <b-col sm="6">
                                                <ValidationProvider name="Applicant's Name (En)" vid="applicant_name_en" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_name_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.applicant_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="text"
                                                            v-model="application.applicant_name_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant's Name (Bn)" vid="applicant_name_bn" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_name_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.applicant_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="text"
                                                            v-model="application.applicant_name_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- email  -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Email" vid="applicant_email" rules="email">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_email">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.email') }}
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="email"
                                                            v-model="application.applicant_email"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- mobile  -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Mobile No." vid="applicant_mobile" rules="required|min:11|max:11">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_mobile">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.mobile') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="application.applicant_mobile"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- NID  -->
                                            <b-col sm="6">
                                                <ValidationProvider name="NID" vid="applicant_nid" rules="required|min:10|max:17">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_nid">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenService.nid') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="number"
                                                            v-model="application.applicant_nid"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <!-- applicant type  -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Applicant Type" vid="applicant_type" rules="min_value: 1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="applicant_nid">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.applicant_type') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.applicant_type"
                                                            id="area_type_id"
                                                            :options="getApplicantTypeList"
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
                                            <b-col sm="6">
                                                <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="area_type_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.area_type_id"
                                                            id="area_type_id"
                                                            :options="getAreaTypeList"
                                                            @change="getAreaTypeData(application.area_type_id)"
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="division_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.division_id"
                                                            id="division_id"
                                                            :options="divisionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="district_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.district_id"
                                                            id="district_id"
                                                            :options="districtList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="PauroshobaItemShow || UnionItemShow">
                                                <ValidationProvider name="District" vid="upazila_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="upazila_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.upazila') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.upazila_id"
                                                            id="upazila_id"
                                                            :options="upazilaList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="UnionItemShow">
                                                <ValidationProvider name="Union" vid="union_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="union_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.union') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.union_id"
                                                            id="union_id"
                                                            :options="unionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="CityCorpItemShow">
                                                <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="city_corporation_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.city_corporation') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.city_corporation_id"
                                                            id="city_corporation_id"
                                                            :options="cityCorporationList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="PauroshobaItemShow">
                                                <ValidationProvider name="Municipality" vid="paurashoba_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="paurashoba_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.municipality_name') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.paurashoba_id"
                                                            id="paurashoba_id"
                                                            :options="municipalityList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                              <!-- address  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Address (En)" vid="address_en" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="address_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="application.address_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <b-col sm="6">
                                                <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="address_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="application.address_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        <!-- garden info section  -->
                        <b-overlay :show="garden_loaded">
                        <b-col sm="12" v-if="application.factory_type_id === 1">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.garden_address')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <!-- area section start here -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="area_type_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.area_type_id"
                                                            id="area_type_id"
                                                            :options="getGardenAreaTypeList"
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
                                            <b-col sm="6" v-show="GardenItemShow">
                                                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="division_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.division_id"
                                                            id="division_id"
                                                            :options="garden_divisionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="GardenItemShow">
                                                <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="district_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.district_id"
                                                            id="district_id"
                                                            :options="garden_districtList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="GardenPauroshobaItemShow || GardenUnionItemShow">
                                                <ValidationProvider name="District" vid="upazila_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="upazila_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.upazila') }}
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.upazila_id"
                                                            id="upazila_id"
                                                            :options="garden_upazilaList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="GardenUnionItemShow">
                                                <ValidationProvider name="Union" vid="union_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="union_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.union') }}
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.union_id"
                                                            id="union_id"
                                                            :options="garden_unionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="GardenCityCorpItemShow">
                                                <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="city_corporation_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.city_corporation') }}
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.city_corporation_id"
                                                            id="city_corporation_id"
                                                            :options="garden_cityCorporationList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="GardenPauroshobaItemShow">
                                                <ValidationProvider name="Municipality" vid="pauroshoba_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="pauroshoba_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.municipality_name') }}
                                                        </template>
                                                        <b-form-select
                                                            disabled
                                                            plain
                                                            v-model="gardenInfoData.pauroshoba_id"
                                                            id="pauroshoba_id"
                                                            :options="garden_municipalityList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                        </b-row>
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                        </b-overlay>
                    </b-row>
                </b-overlay>
            </b-form>
        </ValidationObserver>
    </b-col>
</b-row>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { gardenInfoDetails, factoryInfoApplicantInfoStoreApi } from '../../api/routes'
import { mapGetters } from 'vuex'
export default {
    props: ['app_id', 'applicantFormData', 'isShow', 'baseUrl', 'isRenew'],
    data () {
      return {
            ItemShow: false,
            garden_loaded: false,
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            CityCorpItemShow: false,
            PauroshobaItemShow: false,
            UnionItemShow: false,
            // for garden show purpose
            GardenItemShow: false,
            GardenCityCorpItemShow: false,
            GardenPauroshobaItemShow: false,
            GardenUnionItemShow: false,
            fieldObj: {
                xl: 6,
                lg: 6,
                md: 6,
                sm: 12,
                labelCols: 5,
                noAddress: false
            },
            application: {
            factory_type_id: 0,
            garden_id: 0,
            applicant_type: 0,
            parent_id: null,
            app_id: 0,
            user_id: 0,
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            country_id: 1,
            factory_info: {
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0
            }
            },
            valid: null,
            loading: false,
            districtList: [],
            upazilaList: [],
            unionList: [],
            cityCorporationList: [],
            municipalityList: [],
            garden_districtList: [],
            garden_upazilaList: [],
            garden_unionList: [],
            garden_cityCorporationList: [],
            garden_municipalityList: [],
            gardenInfoData: {}
        }
    },
    created () {
        this.application = this.applicantFormData
        if (this.$route.query.id) {
            if (this.application.area_type_id === 1) {
            this.ItemShow = true
            this.CityCorpItemShow = true
            this.PauroshobaItemShow = false
            this.UnionItemShow = false
            } else if (this.application.area_type_id === 2) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = true
                this.UnionItemShow = false
            } else if (this.application.area_type_id === 3) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = false
                this.UnionItemShow = true
            }
        }
        this.application.user_id = this.authUser.user_id
    },
    computed: {
        ...mapGetters({
            authUser: 'Auth/authUser'
        }),
        currentLocale () {
            return this.$i18n.locale
        },
        divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        garden_divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        getFactoryTypeList () {
            if (this.authUser.user_type === 1) {
               return this.$store.state.TeaGardenService.commonObj.masterFactoryTypeList.filter(item => item.status === 1)
            } else {
                return this.$store.state.ExternalUserService.teaGarden.commonObj.masterFactoryTypeList.filter(item => item.status === 1)
            }
        },
        getApplicantTypeList () {
            if (this.authUser.user_type === 1) {
                return this.$store.state.TeaGardenService.commonObj.factoryApplicationApplicantType
            } else {
                return this.$store.state.ExternalUserService.teaGarden.commonObj.factoryApplicationApplicantType
            }
        },
        getMadeTeaTypeList () {
            if (this.authUser.user_type === 1) {
                return this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList
            } else {
                return this.$store.state.ExternalUserService.teaGarden.commonObj.masterMadeTeaTypeList.filter(item => item.status === 1)
            }
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
        getGardenAreaTypeList: function () {
            const objectData = this.$store.state.commonObj.areaTypeList
            return objectData.map((obj, key) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.value, text: obj.text_bn }
                } else {
                    return { value: obj.value, text: obj.text_en }
                }
            })
        },
        getGardenList () {
            if (this.authUser.user_type === 1) {
                return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => (item.status === 1))
            } else {
                return this.$store.state.ExternalUserService.teaGarden.commonObj.masterTeaGardenGenInfoList.filter(item => (item.status === 1))
            }
        }
    },
    methods: {
    async submit () {
        var check = await this.$refs.form.validate()
        if (check) {
            this.loading = true
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            const loadingState = { loading: false, listReload: false }
            this.application.app_id = this.app_id
            if (this.$route.params.parent_id) {
            this.application.parent_id = this.$route.params.parent_id
            } else {
            this.application.parent_id = null
            }
            const result = await RestApi.postData(teaGardenServiceBaseUrl, factoryInfoApplicantInfoStoreApi, this.application)
            loadingState.listReload = true
            this.$store.dispatch('mutateCommonProperties', loadingState)
            this.loading = false
            if (result.success) {
                this.$toast.success({
                    title: 'Success',
                    message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })
                return result
            } else {
                this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                })
            }
        }
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
    getGardenAreaTypeData (typeId) {
      this.GardenItemShow = true
      if (typeId === 1) {
        this.GardenCityCorpItemShow = true
        this.GardenPauroshobaItemShow = false
        this.GardenUnionItemShow = false
      } else if (typeId === 2) {
        this.GardenCityCorpItemShow = false
        this.GardenPauroshobaItemShow = true
        this.GardenUnionItemShow = false
      } else if (typeId === 3) {
        this.GardenCityCorpItemShow = false
        this.GardenPauroshobaItemShow = false
        this.GardenUnionItemShow = true
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
    // for garden data show purpose
    gardenGetDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    gardenGetUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    gardenGetUnionList (upazilaId) {
       return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    gardenGetCityCorporationList (districtId) {
      const objectData = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    },
    gardenGetPauroshobaList (upazillaId = null) {
      const objectData = this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.upazila_id === upazillaId)
          return objectData.map((obj, key) => {
              if (this.$i18n.locale === 'bn') {
                  return { value: obj.value, text: obj.text_bn }
              } else {
                  return { value: obj.value, text: obj.text_en }
              }
          })
    },
    async getGardenInfo (id) {
        this.garden_loaded = true
        const result = await RestApi.getData(teaGardenServiceBaseUrl, gardenInfoDetails, { garden_id: id })
        if (result.success) {
            this.gardenInfoData = result.data
            this.garden_loaded = false
        } else {
            this.garden_loaded = true
        }
    }
    },
    watch: {
    'application.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'application.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'application.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    // for garden data show
    'gardenInfoData.area_type_id': function (newVal, oldVal) {
        this.getGardenAreaTypeData(newVal)
    },
    'gardenInfoData.division_id': function (newVal, oldVal) {
        this.garden_districtList = this.gardenGetDistrictList(newVal)
    },
    'gardenInfoData.district_id': function (newVal, oldVal) {
        this.garden_cityCorporationList = this.gardenGetCityCorporationList(newVal)
        this.garden_upazilaList = this.gardenGetUpazilaList(newVal)
    },
    'gardenInfoData.upazila_id': function (newVal, oldVal) {
        this.garden_unionList = this.gardenGetUnionList(newVal)
        this.garden_municipalityList = this.gardenGetPauroshobaList(newVal)
    },
    'application.garden_id': function (newVal, oldVal) {
        if (newVal) {
           this.getGardenInfo(newVal)
        }
    },
    'application.factory_type_id': function (newVal, oldVal) {
        if (newVal === 1) {
           this.application.applicant_type = ''
           this.application.applicant_email = ''
           this.application.applicant_mobile = ''
           this.application.applicant_name_en = ''
           this.application.applicant_name_bn = ''
           this.application.area_type_id = 0
           this.application.division_id = 0
           this.application.district_id = 0
           this.application.upazila_id = 0
           this.application.union_id = 0
           this.application.paurashava_id = 0
           this.application.city_corporation_id = 0
           this.application.country_id = 0
        } else {
            this.application.garden_id = 0
            this.application.country_id = 1
        }
    },
    currentLocale: function () {
      if (this.application.division_id) {
        this.districtList = this.getDistrictList(this.application.division_id)
      }
      if (this.gardenInfoData.division_id) {
        this.garden_districtList = this.gardenGetDistrictList(this.gardenInfoData.division_id)
      }
    }
  }
}
</script>

<style>

</style>
