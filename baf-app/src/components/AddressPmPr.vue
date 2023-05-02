<template>
    <div>
        <b-row v-if="addressType === 'present'" class="mt-4">
            <!-- Country -->
            <b-col v-if="!param.noCountry" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Country" vid="pr_country_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="pr_country_id"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.country')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="pr_address.pr_country_id"
                        :options="countryList"
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
            <!-- Area Type -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Area Type" vid="pr_area_type_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_area_type_id"
                    >
                        <template v-slot:label>
                            {{$t('globalTrans.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_area_type_id"
                            :options="areaTypeList"
                            @change="getAreaTypeData(pr_address.pr_area_type_id)"
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

            <!-- Division -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Division" vid="pr_division_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_division_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_division_id"
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

            <!-- District -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="District" vid="pr_district_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_district_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_district_id"
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

            <!-- City Corporation -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="CityCorpItemShow">
                <ValidationProvider name="City Corporation" vid="pr_city_corporation_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_city_corporation_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.city_corporation') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_city_corporation_id"
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

            <!-- Upazila -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                <ValidationProvider name="Upazila" vid="pr_upazila_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_upazila_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_upazila_id"
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

            <!-- Pourashava -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow">
                <ValidationProvider name="Pourashava" vid="pr_pauroshoba_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_pauroshoba_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.pouroshova') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_pauroshoba_id"
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

            <!-- Union -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="UnionItemShow">
                <ValidationProvider name="Union" vid="pr_union_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_union_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.union')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_union_id"
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

            <!-- Ward -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="ItemShow">
                <ValidationProvider name="Ward" vid="pr_ward_id" rules="" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_ward_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.ward') }}
                        </template>
                        <b-form-select
                            plain
                            v-model="pr_address.pr_ward_id"
                            :options="wardList"
                            @change="dataReturn"
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
            <b-col v-if="!param.noPostalCode" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Postal Code" vid="pr_postal_code" rules="required" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="postal_code"
                    >
                    <template v-slot:label>
                        {{$t('externalUser.postal_code')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        v-model="pr_address.pr_postal_code"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <!-- Present Address Details -->
        <b-row v-if="addressType === 'present'">
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (En)" vid="pr_address_details_en" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="pr_address_details_en"
                    >
                    <template v-slot:label>
                        {{$t('externalUser.address_details') + ' ' + $t('globalTrans.en')}}
                    </template>
                        <b-form-textarea
                        v-model="pr_address.pr_address_details_en"
                        @change="dataReturn"
                        rows="1"
                        max-rows="2"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (Bn)" vid="pr_address_details_bn" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pr_address_details_bn"
                    >
                        <template v-slot:label>
                            {{$t('externalUser.address_details') + ' ' + $t('globalTrans.bn')}}
                        </template>
                        <b-form-textarea
                            v-model="pr_address.pr_address_details_bn"
                            @change="dataReturn"
                            rows="1"
                            max-rows="2"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <!-- Permanent Address -->
        <b-row v-if="addressType === 'permanent'">
            <!-- Country -->
            <b-col v-if="!param.noCountry" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Country" vid="pm_country_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="pm_country_id"
                    >
                    <template v-slot:label>
                        {{$t('globalTrans.country')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                        plain
                        v-model="pm_address.pm_country_id"
                        :options="countryList"
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
            <!-- Area Type -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Area Type" vid="pm_area_type_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_area_type_id"
                    >
                        <template v-slot:label>
                            {{$t('globalTrans.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_area_type_id"
                            :options="areaTypeList"
                            @change="getAreaTypeData(pm_address.pm_area_type_id)"
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
            <!-- Division -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Division" vid="pm_division_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_division_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_division_id"
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
            <!-- District -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="District" vid="pm_district_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_district_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_district_id"
                            :options="pmDistrictList"
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
            <!-- City Corporation -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="CityCorpItemShow">
                <ValidationProvider name="City Corporation" vid="pm_city_corporation_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_city_corporation_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.city_corporation') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_city_corporation_id"
                            :options="pmCityCorporationList"
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
            <!-- Upazila -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                <ValidationProvider name="Upazila" vid="pm_upazila_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_upazila_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_upazila_id"
                            :options="pmUpazilaList"
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
            <!-- Pourashava -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow">
                <ValidationProvider name="Pourashava" vid="pm_pauroshoba_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_pauroshoba_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.pouroshova') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_pauroshoba_id"
                            :options="pmMunicipalityList"
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
            <!-- Union -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="UnionItemShow">
                <ValidationProvider name="Union" vid="pm_union_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_union_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.union')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_union_id"
                            :options="pmUnionList"
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
            <!-- Ward -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="ItemShow">
                <ValidationProvider name="Ward" vid="pm_ward_id" rules="" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_ward_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.ward') }}
                        </template>
                        <b-form-select
                            plain
                            v-model="pm_address.pm_ward_id"
                            :options="pmWardList"
                            @change="dataReturn"
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
            <b-col v-if="!param.noPostalCode" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Postal Code" vid="pm_postal_code" rules="required" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="postal_code"
                    >
                    <template v-slot:label>
                        {{$t('externalUser.postal_code')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        v-model="pm_address.pm_postal_code"
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <!-- Permanent Address Details -->
        <b-row v-if="addressType === 'permanent'">
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (En)" vid="pm_address_details_en" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="pm_address_details_en"
                    >
                    <template v-slot:label>
                        {{ $t('externalUser.address_details') + ' ' + $t('globalTrans.en')}}
                    </template>
                        <b-form-textarea
                        v-model="pm_address.pm_address_details_en"
                        @change="dataReturn"
                        rows="1"
                        max-rows="2"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (Bn)" vid="pm_address_details_bn" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_address_details_bn"
                    >
                        <template v-slot:label>
                            {{$t('externalUser.address_details') + ' ' + $t('globalTrans.bn')}}
                        </template>
                        <b-form-textarea
                            v-model="pm_address.pm_address_details_bn"
                            @change="dataReturn"
                            rows="1"
                            max-rows="2"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>

        <!-- Only Address Details -->
        <b-row v-if="addressType === 'address'">
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (En)" vid="pm_address_details_en" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="pm_address_details_en"
                    >
                    <template v-slot:label>
                        {{ $t('externalUser.address_details') + ' ' + $t('globalTrans.en')}}
                    </template>
                        <b-form-textarea
                        v-model="pm_address.pm_address_details_en"
                        @change="dataReturn"
                        rows="1"
                        max-rows="2"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (Bn)" vid="pm_address_details_bn" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="pm_address_details_bn"
                    >
                        <template v-slot:label>
                            {{$t('externalUser.address_details') + ' ' + $t('globalTrans.bn')}}
                        </template>
                        <b-form-textarea
                            v-model="pm_address.pm_address_details_bn"
                            @change="dataReturn"
                            rows="1"
                            max-rows="2"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
    </div>
</template>
<script>
import { ValidationProvider } from 'vee-validate'
import { EventBus } from '@/EventBusLayout'

export default {
    props: ['data', 'addressType', 'param'],
    components: {
        ValidationProvider
    },
    data () {
        return {
            valid: null,
            ItemShow: false,
            CityCorpItemShow: false,
            PauroshobaItemShow: false,
            UnionItemShow: false,
            pr_address: {
                pr_country_id: 0,
                pr_area_type_id: 0,
                pr_division_id: 0,
                pr_district_id: 0,
                pr_city_corporation_id: 0,
                pr_pauroshoba_id: 0,
                pr_upazila_id: 0,
                pr_union_id: 0,
                pr_postal_code: '',
                pr_ward_id: 0,
                pr_address_details_en: '',
                pr_address_details_bn: ''
            },
            pm_address: {
                pm_country_id: 0,
                pm_area_type_id: 0,
                pm_division_id: 0,
                pm_district_id: 0,
                pm_city_corporation_id: 0,
                pm_pauroshoba_id: 0,
                pm_upazila_id: 0,
                pm_union_id: 0,
                pm_ward_id: 0,
                pm_postal_code: '',
                pm_address_details_en: '',
                pm_address_details_bn: ''
            },
            districtList: [],
            cityCorporationList: [],
            upazilaList: [],
            municipalityList: [],
            unionList: [],
            wardList: [],
            pmDistrictList: [],
            pmCityCorporationList: [],
            pmUpazilaList: [],
            pmMunicipalityList: [],
            pmUnionList: [],
            pmWardList: [],
            tmpWardList: []
        }
    },
    watch: {
        'pr_address.pr_division_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.districtList = this.getDistrictList(newVal)
                this.dataReturn()
            }
        },
        'pr_address.pr_district_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.cityCorporationList = this.getCityCorporationList(newVal)
                this.upazilaList = this.getUpazilaList(newVal)
                this.dataReturn()
            }
        },
        'pr_address.pr_upazila_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.unionList = this.getUnionList(newVal)
                this.municipalityList = this.getPauroshobaList(newVal)
                this.dataReturn()
            }
        },
        'pr_address.pr_city_corporation_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByCityCorporation(newVal)
                this.dataReturn()
            }
        },
        'pr_address.pr_paurasabha_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByPauroshoba(newVal)
                this.dataReturn()
            }
        },
        'pr_address.pr_union_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByUnion(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_division_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmDistrictList = this.getDistrictList(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_district_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmCityCorporationList = this.getCityCorporationList(newVal)
                this.pmUpazilaList = this.getUpazilaList(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_upazila_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmUnionList = this.getUnionList(newVal)
                this.pmMunicipalityList = this.getPauroshobaList(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_city_corporation_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmWardList = this.getWardListByCityCorporation(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_paurasabha_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmWardList = this.getWardListByPauroshoba(newVal)
                this.dataReturn()
            }
        },
        'pm_address.pm_union_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.pmWardList = this.getWardListByUnion(newVal)
                this.dataReturn()
            }
        },
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.changeEnBn()
            }
        }
    },
    mounted () {
        if (this.data && Object.values(this.data).length > 0) {
            if (this.addressType === 'present') {
                this.changesAreaTypes(this.data.pr_area_type_id)
                this.pr_address.pr_country_id = this.data.pr_country_id
                this.pr_address.pr_area_type_id = this.data.pr_area_type_id
                this.pr_address.pr_division_id = this.data.pr_division_id
                this.pr_address.pr_district_id = this.data.pr_district_id
                this.pr_address.pr_upazila_id = this.data.pr_upazila_id
                this.pr_address.pr_city_corporation_id = this.data.pr_city_corporation_id
                this.pr_address.pr_union_id = this.data.pr_union_id
                this.pr_address.pr_ward_id = this.data.pr_ward_id
                this.pr_address.pr_postal_code = this.data.pr_postal_code
                this.pr_address.pr_pauroshoba_id = this.data.pr_pauroshoba_id
                this.pr_address.pr_address_details_en = this.data.pr_address_details_en
                this.pr_address.pr_address_details_bn = this.data.pr_address_details_bn
            } else {
                this.changesAreaTypes(this.data.pm_area_type_id)
                this.pm_address.pm_country_id = this.data.pm_country_id
                this.pm_address.pm_area_type_id = this.data.pm_area_type_id
                this.pm_address.pm_division_id = this.data.pm_division_id
                this.pm_address.pm_district_id = this.data.pm_district_id
                this.pm_address.pm_upazila_id = this.data.pm_upazila_id
                this.pm_address.pm_city_corporation_id = this.data.pm_city_corporation_id
                this.pm_address.pm_union_id = this.data.pm_union_id
                this.pm_address.pm_ward_id = this.data.pm_ward_id
                this.pm_address.pm_postal_code = this.data.pm_postal_code
                this.pm_address.pm_pauroshoba_id = this.data.pm_pauroshoba_id
                this.pm_address.pm_address_details_en = this.data.pm_address_details_en
                this.pm_address.pm_address_details_bn = this.data.pm_address_details_bn
            }
            this.dataReturn()
        }
    },
    computed: {
        countryList: function () {
            return this.$store.state.CommonService.commonObj.countryList.map(el => {
                return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
            })
        },
        areaTypeList: function () {
            return this.$store.state.commonObj.areaTypeList.map(el => {
                return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
            })
        },
        divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    created () {
        EventBus.$on('SAME_ADDRESS', this.changeIsSame)
    },
    methods: {
        changeEnBn () {
            if (this.addressType === 'present') {
                if (Object.values(this.pr_address).length > 0) {
                    this.districtList = this.getDistrictList(parseInt(this.pr_address.pr_division_id))
                    this.cityCorporationList = this.getCityCorporationList(parseInt(this.pr_address.pr_district_id))
                    this.upazilaList = this.getUpazilaList(parseInt(this.pr_address.pr_district_id))
                    this.municipalityList = this.getPauroshobaList(parseInt(this.pr_address.pr_upazila_id))
                    this.unionList = this.getUnionList(parseInt(this.pr_address.pr_upazila_id))
                    if (this.pr_address.pr_area_type_id === 1) {
                        this.wardList = this.getWardListByCityCorporation(this.pr_address.pr_city_corporation_id)
                    } else if (this.pr_address.pr_area_type_id === 2) {
                        this.wardList = this.getWardListByPauroshoba(this.pr_address.pr_city_corporation_id)
                    } else {
                        this.wardList = this.getWardListByUnion(this.pr_address.pr_city_corporation_id)
                    }
                }
            } else {
                if (Object.values(this.pr_address).length > 0) {
                    this.pmDistrictList = this.getDistrictList(parseInt(this.pm_address.pm_division_id))
                    this.pmCityCorporationList = this.getCityCorporationList(parseInt(this.pm_address.pm_district_id))
                    this.pmUpazilaList = this.getUpazilaList(parseInt(this.pm_address.pm_district_id))
                    this.pmMunicipalityList = this.getPauroshobaList(parseInt(this.pm_address.pm_upazila_id))
                    this.pmUnionList = this.getUnionList(parseInt(this.pm_address.pm_upazila_id))
                    if (this.pm_address.pm_area_type_id === 1) {
                        this.pmWardList = this.getWardListByCityCorporation(this.pm_address.pm_city_corporation_id)
                    } else if (this.pm_address.pm_area_type_id === 2) {
                        this.pmWardList = this.getWardListByPauroshoba(this.pm_address.pm_city_corporation_id)
                    } else {
                        this.pmWardList = this.getWardListByUnion(this.pm_address.pm_city_corporation_id)
                    }
                }
            }
        },
        changeIsSame (item) {
            if (item.pr_address) {
                if (item.is_same === '1') {
                    this.changesAreaTypes(item.pr_address.pr_area_type_id)
                    this.pm_address.pm_country_id = item.pr_address.pr_country_id
                    this.pm_address.pm_area_type_id = item.pr_address.pr_area_type_id
                    this.pm_address.pm_division_id = item.pr_address.pr_division_id
                    this.pm_address.pm_district_id = item.pr_address.pr_district_id
                    this.pm_address.pm_upazila_id = item.pr_address.pr_upazila_id
                    this.pm_address.pm_city_corporation_id = item.pr_address.pr_city_corporation_id
                    this.pm_address.pm_union_id = item.pr_address.pr_union_id
                    this.pm_address.pm_pauroshoba_id = item.pr_address.pr_pauroshoba_id
                    this.pm_address.pm_address_details_en = item.pr_address.pr_address_details_en
                    this.pm_address.pm_address_details_bn = item.pr_address.pr_address_details_bn
                    this.pm_address.pm_ward_id = item.pr_address.pr_ward_id
                    this.pm_address.pm_postal_code = item.pr_address.pr_postal_code
                } else {
                    this.pm_address.pm_country_id = 0
                    this.pm_address.pm_area_type_id = 0
                    this.pm_address.pm_division_id = 0
                    this.pm_address.pm_district_id = 0
                    this.pm_address.pm_upazila_id = 0
                    this.pm_address.pm_city_corporation_id = 0
                    this.pm_address.pm_union_id = 0
                    this.pm_address.pm_pauroshoba_id = 0
                    this.pm_address.pm_address_details_en = ''
                    this.pm_address.pm_address_details_bn = ''
                    this.pm_address.pm_ward_id = 0
                    this.pm_address.pm_postal_code = 0
                }
            }
            if (item.pm_address) {
                if (item.is_same === '1') {
                    this.changesAreaTypes(item.pm_address.pm_area_type_id)
                    this.pr_address.pr_country_id = item.pm_address.pm_country_id
                    this.pr_address.pr_area_type_id = item.pm_address.pm_area_type_id
                    this.pr_address.pr_division_id = item.pm_address.pm_division_id
                    this.pr_address.pr_district_id = item.pm_address.pm_district_id
                    this.pr_address.pr_upazila_id = item.pm_address.pm_upazila_id
                    this.pr_address.pr_city_corporation_id = item.pm_address.pm_city_corporation_id
                    this.pr_address.pr_union_id = item.pm_address.pm_union_id
                    this.pr_address.pr_pauroshoba_id = item.pm_address.pm_pauroshoba_id
                    this.pr_address.pr_address_details_en = item.pm_address.pm_address_details_en
                    this.pr_address.pr_address_details_bn = item.pm_address.pm_address_details_bn
                    this.pr_address.pr_ward_id = item.pm_address.pm_ward_id
                    this.pr_address.pr_postal_code = item.pm_address.pm_postal_code
                } else {
                    this.pr_address.pr_country_id = 0
                    this.pr_address.pr_area_type_id = 0
                    this.pr_address.pr_division_id = 0
                    this.pr_address.pr_district_id = 0
                    this.pr_address.pr_upazila_id = 0
                    this.pr_address.pr_city_corporation_id = 0
                    this.pr_address.pr_union_id = 0
                    this.pr_address.pr_pauroshoba_id = 0
                    this.pr_address.pr_address_details_en = ''
                    this.pr_address.pr_address_details_bn = ''
                    this.pr_address.pr_ward_id = 0
                    this.pr_address.pr_ward_id = 0
                    this.pr_address.pr_postal_code = 0
                }
            }
            // this.$emit('pm-address-data', this.pm_address)
        },
        dataReturn () {
            if (this.addressType === 'permanent') {
                this.$emit('pm-address-data', this.pm_address)
            } else {
                this.$emit('pr-address-data', this.pr_address)
            }
        },
        reset () {
            this.pr_address.pr_city_corporation_id = 0
            this.pr_address.pr_upazila_id = 0
            this.pr_address.pr_pauroshoba_id = 0
            this.pr_address.pr_union_id = 0
            this.pr_address.pr_ward_id = 0
        },
        changesAreaTypes (typeId) {
            /**
             * 1 - City Corporation (City-Coporation, Ward)
             * 2 - Pauroshoba (Upazila, Pourosoba, Ward)
             * 3 - Union (Upazila, Pourosoba, Ward)
             */
            this.ItemShow = true
            if (typeId === 1) {
                this.ItemShow = true
                this.CityCorpItemShow = true
                this.PauroshobaItemShow = false
                this.UnionItemShow = false
            } else if (typeId === 2) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = true
                this.UnionItemShow = false
            } else if (typeId === 3) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = false
                this.UnionItemShow = true
            }
        },
        getAreaTypeData (typeId) {
            this.changesAreaTypes(typeId)
            this.reset()
        },
        getDistrictList (divisionId = null) {
            if (divisionId) {
                const objectData = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === divisionId)
                return objectData.map((obj, key) => {
                    if (this.$i18n.locale === 'bn') {
                        return { value: obj.value, text: obj.text_bn }
                    } else {
                        return { value: obj.value, text: obj.text_en }
                    }
                })
            } else {
                return []
            }
        },
        getCityCorporationList (districtId = null) {
            if (districtId) {
                return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
            } else {
                return []
            }
        },
        getUpazilaList (districtId = null) {
            if (districtId) {
                return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
            } else {
                return []
            }
        },
        getUnionList (upazillaId = null) {
            if (upazillaId) {
                return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazillaId)
            } else {
                return []
            }
        },
        getPauroshobaList (upazillaId = null) {
            if (upazillaId) {
                return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === upazillaId)
            } else {
                return []
            }
        },
        getWardListByCityCorporation (cityCorpId) {
            if (cityCorpId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.city_corporation_id === cityCorpId && item.status === 1).map(el => {
                    return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
                })
            } else {
                return []
            }
        },
        getWardListByPauroshoba (pauroshobaId) {
            if (pauroshobaId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.pauroshoba_id === pauroshobaId && item.status === 1).map(el => {
                    return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
                })
            } else {
                return []
            }
        },
        getWardListByUnion (unionId) {
            if (unionId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.union_id === unionId && item.status === 1).map(el => {
                    return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
                })
            } else {
                return []
            }
        }
    }
}
</script>
