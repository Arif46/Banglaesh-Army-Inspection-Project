<template>
    <card>
        <template v-slot:searchHeaderTitle>
            <h4 class="card-title">{{ $t('externalTradeFair.fairCalenderInfo') }} {{ isEdit ? $t('globalTrans.modify') :  $t('globalTrans.entry') }}</h4>
        </template>
        <template v-slot:searchBody>
            <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                <b-overlay :show="loading">
                    <b-form @submit.prevent="handleSubmit(save)" @reset.prevent="reset" autocomplete="off">
                        <div class="application-form-wrapper">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.notice_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="fiscal_year_id">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="fiscal_year_id" :options="fiscalYearList" v-model="formData.fiscal_year_id"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
                                                                        <template v-slot:first>
                                                                            <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                                                        </template>
                                                                    </b-form-select>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Circular" vid="circular_id" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="circular_id">
                                                                    <template v-slot:label>
                                                                        {{ $t('tradeFairProposalManagement.circular') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="circular_id" :options="calendarcircularList" v-model="formData.circular_id"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
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
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Subject" vid="subject" rules="required">
                                                                <b-form-group label-for="date_to">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.circular_memo_no') }}
                                                                    </template>
                                                                    <b-form-input id="circular_memo_number" v-model="formData.circular_memo_number" disabled
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
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
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fair_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Type of Fair" vid="type_of_fair" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="type_of_fair">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.type_of_fair') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="type_of_fair" :options="typeOfFair" v-model="formData.type_of_fair"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
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
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Fair sector" vid="fair_sector_id" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="fair_sector_id">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.fair_sector') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="fair_sector_id" :options="fairSectorList" v-model="formData.fair_sector_id"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
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
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Fair name (En)" vid="fair_name" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="fair_name">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.fair_name') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="fair_name" v-model="formData.fair_name"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
                                                                    </b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Fair name (Bn)" vid="fair_name_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="fair_name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.fair_name') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="fair_name_bn" v-model="formData.fair_name_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
                                                                    </b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Date From" vid="date_from" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="date_from">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.date_from') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <date-picker id="date_from" class="form-control" v-model="formData.date_from"
                                                                        :class="errors[0] ? 'is-invalid' : ''" :state="errors[0] ? false : (valid ? true : null)"
                                                                        :placeholder="$t('globalTrans.select')">
                                                                    </date-picker>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Date To" vid="date_to" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="date_to">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.date_to') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <date-picker id="date_to" class="form-control" v-model="formData.date_to"
                                                                        :class="errors[0] ? 'is-invalid' : ''" :state="errors[0] ? false : (valid ? true : null)"
                                                                        :placeholder="$t('globalTrans.select')">
                                                                    </date-picker>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Duration" vid="duration" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="date_to">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.duration') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="duration" v-model="duration" disabled
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Country" vid="country_id" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="country_id">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.country') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="country_id" :options="countryList" v-model="formData.country_id"
                                                                        :state="errors[0] ? false : (valid ? true : null)">
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
                                                        <b-col sm="6">
                                                            <ValidationProvider name="City (En)" vid="city" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="city">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="city" v-model="formData.city"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="City (Bn)" vid="city_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="city_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="city_bn" v-model="formData.city_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Product and service exhibited (En)" vid="product_service_exhibited" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="product_service_exhibited">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.product_service_exhibited') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="product_service_exhibited" v-model="formData.product_service_exhibited"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Product and service exhibited (Bn)" vid="product_service_exhibited_bn" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="product_service_exhibited_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.product_service_exhibited') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="product_service_exhibited_bn" v-model="formData.product_service_exhibited_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
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
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fair_company_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name of Organizer (En)" vid="name_of_organizer" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_of_organizer">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.name_of_organizer') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="name_of_organizer" v-model="formData.name_of_organizer"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name of Organizer (Bn)" vid="name_of_organizer_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_of_organizer_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.name_of_organizer') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="name_of_organizer_bn" v-model="formData.name_of_organizer_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Proposed by" vid="proposed_by" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="proposed_by">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.proposed_by') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="proposed_by" v-model="formData.proposed_by"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Proposed by (Bn)" vid="proposed_by_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="proposed_by_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.proposed_by') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="proposed_by_bn" v-model="formData.proposed_by_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Organizer Profile (En)" vid="organizer_profile" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="organizer_profile">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.organizer_profile') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="organizer_profile" v-model="formData.organizer_profile"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Organizer Profile (Bn)" vid="organizer_profile_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="organizer_profile_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.organizer_profile') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="organizer_profile_bn" v-model="formData.organizer_profile_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Prospect of Bangladeshi Exhibitors (Short Description) (En)"
                                                                vid="prospect_bangladeshi_exhibitors" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="prospect_bangladeshi_exhibitors">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.prospect_bangladeshi_exhibitors') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="prospect_bangladeshi_exhibitors" v-model="formData.prospect_bangladeshi_exhibitors"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Prospect of Bangladeshi Exhibitors (Short Description) (Bn)"
                                                                vid="prospect_bangladeshi_exhibitors_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="prospect_bangladeshi_exhibitors_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.prospect_bangladeshi_exhibitors') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-textarea id="prospect_bangladeshi_exhibitors_bn"
                                                                        v-model="formData.prospect_bangladeshi_exhibitors_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Remarks" vid="remarks">
                                                                <b-form-group label-for="remarks">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.remarks') + ' ' + $t('globalTrans.en') }}
                                                                    </template>
                                                                    <b-form-textarea id="remarks" v-model="formData.remarks"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Remarks (Bn)" vid="remarks_bn">
                                                                <b-form-group label-for="remarks_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.remarks') + ' ' + $t('globalTrans.bn') }}
                                                                    </template>
                                                                    <b-form-textarea id="remarks_bn" v-model="formData.remarks_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-textarea>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Costs of Space Shell Scheme Stands and Services" vid="costs_scheme_stands_services"
                                                                rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="costs_scheme_stands_services">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.costs_scheme_stands_services') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input id="costs_scheme_stands_services" v-model="formData.costs_scheme_stands_services"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Attachment" vid="attachment" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="attachment">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="formData.attachment"
                                                                            :href="internationalTradeFairServiceBaseUrl + 'storage/calender-info/attachment/' + formData.attachment">{{
                                                                            $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                                                                    </template>
                                                                    <b-form-file id="attachment" v-model="formData.file" v-on:change="onFileChange" accept=".doc,.docx,.pdf"
                                                                        class="mt-2" plain :state="errors[0] ? false : (valid ? true : null)"></b-form-file>
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
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fair_other_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Visitors profile of last year event (En)" vid="visitors_profile_of_last_year_event"
                                                                rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="visitors_profile_of_last_year_event">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.visitors_profile_of_last_year_event') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <vue-editor id="visitors_profile_of_last_year_event" v-model="formData.visitors_profile_of_last_year_event"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></vue-editor>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Visitors profile of last year event (Bn)" vid="visitors_profile_of_last_year_event_bn"
                                                                rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="visitors_profile_of_last_year_event_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.visitors_profile_of_last_year_event') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <vue-editor id="visitors_profile_of_last_year_event_bn"
                                                                        v-model="formData.visitors_profile_of_last_year_event_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></vue-editor>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Exhibitors Profile of Last Year's Event (En)" vid="exhibitors_profile_of_last_year_event"
                                                                rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="exhibitors_profile_of_last_year_event">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.exhibitors_profile_of_last_year_event') + ' ' + $t('globalTrans.en') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <vue-editor id="exhibitors_profile_of_last_year_event"
                                                                        v-model="formData.exhibitors_profile_of_last_year_event"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></vue-editor>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Exhibitors Profile of Last Year's Event (Bn)"
                                                                vid="exhibitors_profile_of_last_year_event_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="exhibitors_profile_of_last_year_event_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.exhibitors_profile_of_last_year_event') + ' ' + $t('globalTrans.bn') }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <vue-editor id="exhibitors_profile_of_last_year_event_bn"
                                                                        v-model="formData.exhibitors_profile_of_last_year_event_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></vue-editor>
                                                                    <div class="invalid-feedback d-block">
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
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.fairCalenderGiverInfo')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (En)" vid="formData.name">
                                                                <b-form-group label-for="formData.name">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') }}
                                                                    </template>
                                                                    <b-form-input id="formData.name" v-model="formData.name"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (Bn)" vid="formData.name_bn">
                                                                <b-form-group label-for="formData.name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn') }}
                                                                    </template>
                                                                    <b-form-input id="formData.name_bn" v-model="formData.name_bn"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Mobile no" vid="formData.mobile_no" rules="min:11|max:11" v-slot="{ errors }">
                                                                <b-form-group label-for="formData.mobile_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.mobile') }}
                                                                    </template>
                                                                    <b-form-input id="formData.mobile_no"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        v-model="formData.mobile_no" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                </b-form-group>
                                                                <div class="invalid-feedback d-block">
                                                                    {{ errors[0] }}
                                                                </div>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Email" vid="formData.email" rules="email" v-slot="{ errors }">
                                                                <b-form-group label-for="formData.email">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.email') }}
                                                                    </template>
                                                                    <b-form-input id="formData.email" v-model="formData.email"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                </b-form-group>
                                                                <div class="invalid-feedback d-block">
                                                                    {{ errors[0] }}
                                                                </div>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Organization Name (En)" vid="org_name">
                                                                <b-form-group label-for="org_name">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.org_name') + ' ' + $t('globalTrans.en') }}
                                                                    </template>
                                                                    <b-form-input id="org_name" v-model="formData.org_name"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Organization Name (Bn)" vid="org_name_bn">
                                                                <b-form-group label-for="org_name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.org_name') + ' ' + $t('globalTrans.bn') }}
                                                                    </template>
                                                                    <b-form-input id="org_name_bn" v-model="formData.org_name_bn"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Designation (En)" vid="designation">
                                                                <b-form-group label-for="designation">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.designation') + ' ' + $t('globalTrans.en') }}
                                                                    </template>
                                                                    <b-form-input id="designation" v-model="formData.designation"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Designation (Bn)" vid="designation_bn">
                                                                <b-form-group label-for="designation_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.designation') + ' ' + $t('globalTrans.bn') }}
                                                                    </template>
                                                                    <b-form-input id="designation_bn" v-model="formData.designation_bn"></b-form-input>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </div>
                        <b-row>
                            <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="fiscal_year_id">
                                        <template v-slot:label>
                                            {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            id="fiscal_year_id"
                                            :options="fiscalYearList"
                                            v-model="formData.fiscal_year_id"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        <template v-slot:first>
                                            <b-form-select-option disabled :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                        </template>
                                        </b-form-select>
                                            <div class="invalid-feedback">
                                        {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Circular" vid="circular_id" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="circular_id">
                                        <template v-slot:label>
                                        {{ $t('tradeFairProposalManagement.circular') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            id="circular_id"
                                            :options="calendarcircularList"
                                            v-model="formData.circular_id"
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
                                <ValidationProvider name="Subject" vid="subject" rules="required">
                                    <b-form-group label-for="date_to">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.circular_memo_no') }}
                                        </template>
                                        <b-form-input
                                            id="circular_memo_number"
                                            v-model="formData.circular_memo_number"
                                            disabled
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col> -->
                            <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Type of Fair" vid="type_of_fair" rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-for="type_of_fair">
                                    <template v-slot:label>
                                    {{ $t('externalTradeFair.type_of_fair') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                    plain
                                    id="type_of_fair"
                                    :options="typeOfFair"
                                    v-model="formData.type_of_fair"
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
                                <ValidationProvider name="Fair sector" vid="fair_sector_id" rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-for="fair_sector_id">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.fair_sector') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        id="fair_sector_id"
                                        :options="fairSectorList"
                                        v-model="formData.fair_sector_id"
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
                            <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Fair Sector" vid="sectors" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="sectors">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.fair_sector') }} <span class="text-danger">*</span>
                                    </template>
                                    <v-select
                                        id="sectors"
                                        v-model="formData.fair_sector_id"
                                        :reduce="op => op.value"
                                        multiple
                                        :options="fairSectorList"
                                        label="text"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                    </v-select>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col> -->
                            <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Fair name (En)" vid="fair_name" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="fair_name">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.fair_name') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="fair_name"
                                        v-model="formData.fair_name"
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
                                <ValidationProvider name="Fair name (Bn)" vid="fair_name_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="fair_name_bn">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.fair_name') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="fair_name_bn"
                                        v-model="formData.fair_name_bn"
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
                                <ValidationProvider name="Date From" vid="date_from" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="date_from"
                                >
                                    <template v-slot:label>
                                    {{ $t('externalTradeFair.date_from') }}  <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                        id="date_from"
                                        class="form-control"
                                        v-model="formData.date_from"
                                        :class="errors[0] ? 'is-invalid' : ''"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        :placeholder="$t('globalTrans.select')"
                                    >
                                    </date-picker>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Date To" vid="date_to" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="date_to"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.date_to') }}  <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                        id="date_to"
                                        class="form-control"
                                        v-model="formData.date_to"
                                        :class="errors[0] ? 'is-invalid' : ''"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        :placeholder="$t('globalTrans.select')"
                                    >
                                    </date-picker>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Duration" vid="duration" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="date_to"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.duration') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="duration"
                                        v-model="duration"
                                        disabled
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Country" vid="country_id" rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-for="country_id">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.country') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        id="country_id"
                                        :options="countryList"
                                        v-model="formData.country_id"
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
                                <ValidationProvider name="City (En)" vid="city" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="city"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.en') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="city"
                                        v-model="formData.city"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="City (Bn)" vid="city_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="city_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.city') + ' ' + $t('globalTrans.bn') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="city_bn"
                                        v-model="formData.city_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Product and service exhibited (En)" vid="product_service_exhibited" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="product_service_exhibited"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.product_service_exhibited') + ' ' + $t('globalTrans.en')  }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                        id="product_service_exhibited"
                                        v-model="formData.product_service_exhibited"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Product and service exhibited (Bn)" vid="product_service_exhibited_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="product_service_exhibited_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.product_service_exhibited') + ' ' + $t('globalTrans.bn') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-textarea
                                        id="product_service_exhibited_bn"
                                        v-model="formData.product_service_exhibited_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-textarea>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col> -->
                            <!-- <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Name of Organizer (En)" vid="name_of_organizer" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="name_of_organizer"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.name_of_organizer') + ' ' + $t('globalTrans.en')  }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="name_of_organizer"
                                        v-model="formData.name_of_organizer"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Name of Organizer (Bn)" vid="name_of_organizer_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="name_of_organizer_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.name_of_organizer') + ' ' + $t('globalTrans.bn')  }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="name_of_organizer_bn"
                                        v-model="formData.name_of_organizer_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Proposed by" vid="proposed_by" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="proposed_by"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.proposed_by') + ' ' + $t('globalTrans.en') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="proposed_by"
                                        v-model="formData.proposed_by"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Proposed by (Bn)" vid="proposed_by_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="proposed_by_bn"
                                >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.proposed_by') + ' ' + $t('globalTrans.bn') }}  <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        id="proposed_by_bn"
                                        v-model="formData.proposed_by_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Organizer Profile (En)" vid="organizer_profile" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="organizer_profile"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.organizer_profile') + ' ' + $t('globalTrans.en') }}  <span class="text-danger">*</span>
                                        </template>
                                        <b-form-textarea
                                            id="organizer_profile"
                                            v-model="formData.organizer_profile"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Organizer Profile (Bn)" vid="organizer_profile_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="organizer_profile_bn"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.organizer_profile') + ' ' + $t('globalTrans.bn') }}  <span class="text-danger">*</span>
                                        </template>
                                        <b-form-textarea
                                            id="organizer_profile_bn"
                                            v-model="formData.organizer_profile_bn"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Costs of Space Shell Scheme Stands and Services" vid="costs_scheme_stands_services" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="costs_scheme_stands_services"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.costs_scheme_stands_services') }}  <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            id="costs_scheme_stands_services"
                                            v-model="formData.costs_scheme_stands_services"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Prospect of Bangladeshi Exhibitors (Short Description) (En)" vid="prospect_bangladeshi_exhibitors" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="prospect_bangladeshi_exhibitors"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.prospect_bangladeshi_exhibitors') + ' ' + $t('globalTrans.en')  }}  <span class="text-danger">*</span>
                                        </template>
                                        <b-form-textarea
                                            id="prospect_bangladeshi_exhibitors"
                                            v-model="formData.prospect_bangladeshi_exhibitors"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Prospect of Bangladeshi Exhibitors (Short Description) (Bn)" vid="prospect_bangladeshi_exhibitors_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="prospect_bangladeshi_exhibitors_bn"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.prospect_bangladeshi_exhibitors') + ' ' + $t('globalTrans.bn')  }}  <span class="text-danger">*</span>
                                        </template>
                                        <b-form-textarea
                                            id="prospect_bangladeshi_exhibitors_bn"
                                            v-model="formData.prospect_bangladeshi_exhibitors_bn"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Remarks" vid="remarks">
                                    <b-form-group
                                        label-for="remarks"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.remarks') + ' ' + $t('globalTrans.en') }}
                                        </template>
                                        <b-form-textarea
                                            id="remarks"
                                            v-model="formData.remarks"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Remarks (Bn)" vid="remarks_bn">
                                    <b-form-group
                                        label-for="remarks_bn"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.remarks') + ' ' + $t('globalTrans.bn') }}
                                        </template>
                                        <b-form-textarea
                                            id="remarks_bn"
                                            v-model="formData.remarks_bn"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-textarea>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Attachment" vid="attachment" rules="" v-slot="{ errors }">
                                <b-form-group
                                    label-for="attachment">
                                    <template v-slot:label>
                                        {{ $t('globalTrans.attachment') }} <a target="_blank" v-if="formData.attachment" :href="internationalTradeFairServiceBaseUrl + 'storage/calender-info/attachment/' + formData.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a>
                                    </template>
                                    <b-form-file id="attachment"
                                        v-model="formData.file"
                                        v-on:change="onFileChange"
                                        accept=".doc,.docx,.pdf"
                                        class="mt-2" plain
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-file>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col> -->
                            <!-- <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                                <ValidationProvider name="Visitors profile of last year event (En)" vid="visitors_profile_of_last_year_event" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="visitors_profile_of_last_year_event">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.visitors_profile_of_last_year_event') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <vue-editor
                                        id="visitors_profile_of_last_year_event"
                                        v-model="formData.visitors_profile_of_last_year_event"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></vue-editor>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                                <ValidationProvider name="Visitors profile of last year event (Bn)" vid="visitors_profile_of_last_year_event_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="visitors_profile_of_last_year_event_bn">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.visitors_profile_of_last_year_event') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <vue-editor
                                        id="visitors_profile_of_last_year_event_bn"
                                        v-model="formData.visitors_profile_of_last_year_event_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></vue-editor>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                                <ValidationProvider name="Exhibitors Profile of Last Year's Event (En)" vid="exhibitors_profile_of_last_year_event" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="exhibitors_profile_of_last_year_event">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.exhibitors_profile_of_last_year_event') + ' ' + $t('globalTrans.en')  }} <span class="text-danger">*</span>
                                    </template>
                                    <vue-editor
                                        id="exhibitors_profile_of_last_year_event"
                                        v-model="formData.exhibitors_profile_of_last_year_event"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></vue-editor>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
                                <ValidationProvider name="Exhibitors Profile of Last Year's Event (Bn)" vid="exhibitors_profile_of_last_year_event_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                    label-for="exhibitors_profile_of_last_year_event_bn">
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.exhibitors_profile_of_last_year_event') + ' ' + $t('globalTrans.bn')  }} <span class="text-danger">*</span>
                                    </template>
                                    <vue-editor
                                        id="exhibitors_profile_of_last_year_event_bn"
                                        v-model="formData.exhibitors_profile_of_last_year_event_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></vue-editor>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                                </ValidationProvider>
                            </b-col> -->
                        </b-row>
                        <!-- <b-row>
                            <b-col xs="12" sm="12" md="12" lg="12" xl="12"> <b style="border-bottom: 2px solid #ddd;"> {{ $t('externalTradeFair.fairCalenderGiverInfo') }} </b> </b-col>
                        </b-row>
                        <b-row>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Name (En)" vid="formData.name">
                                    <b-form-group
                                        label-for="formData.name"
                                    >
                                        <template v-slot:label>
                                            {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') }}
                                        </template>
                                        <b-form-input
                                            id="formData.name"
                                            v-model="formData.name"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Name (Bn)" vid="formData.name_bn">
                                    <b-form-group
                                        label-for="formData.name_bn"
                                    >
                                        <template v-slot:label>
                                            {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn') }}
                                        </template>
                                        <b-form-input
                                            id="formData.name_bn"
                                            v-model="formData.name_bn"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Mobile no" vid="formData.mobile_no" rules="min:11|max:11" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="formData.mobile_no"
                                    >
                                        <template v-slot:label>
                                            {{ $t('globalTrans.mobile') }}
                                        </template>
                                        <b-form-input
                                            id="formData.mobile_no"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                            v-model="formData.mobile_no"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                    </b-form-group>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Email" vid="formData.email" rules="email" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="formData.email"
                                    >
                                        <template v-slot:label>
                                            {{ $t('globalTrans.email') }}
                                        </template>
                                        <b-form-input
                                            id="formData.email"
                                            v-model="formData.email"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                    </b-form-group>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Organization Name (En)" vid="org_name">
                                    <b-form-group
                                        label-for="org_name"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.org_name')  + ' ' + $t('globalTrans.en') }}
                                        </template>
                                        <b-form-input
                                            id="org_name"
                                            v-model="formData.org_name"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                                <ValidationProvider name="Organization Name (Bn)" vid="org_name_bn">
                                    <b-form-group
                                        label-for="org_name_bn"
                                    >
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.org_name')  + ' ' + $t('globalTrans.bn') }}
                                        </template>
                                        <b-form-input
                                            id="org_name_bn"
                                            v-model="formData.org_name_bn"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Designation (En)" vid="designation">
                                    <b-form-group label-for="designation">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.designation')  + ' ' + $t('globalTrans.en') }}
                                        </template>
                                        <b-form-input
                                            id="designation"
                                            v-model="formData.designation"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Designation (Bn)" vid="designation_bn">
                                    <b-form-group label-for="designation_bn">
                                        <template v-slot:label>
                                            {{ $t('externalTradeFair.designation')  + ' ' + $t('globalTrans.bn') }}
                                        </template>
                                        <b-form-input
                                            id="designation_bn"
                                            v-model="formData.designation_bn"
                                        ></b-form-input>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row> -->
                        <b-row class="text-right">
                            <b-col>
                                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                                <router-link :title="$t('globalTrans.cancel')" variant="danger" to='/trade-fair-service/itf/fair-proposal-management/collect-fair-calendar' class="btn btn-danger btn-sm">{{ $t('globalTrans.cancel') }}</router-link>
                            </b-col>
                        </b-row>
                    </b-form>
                </b-overlay>
            </ValidationObserver>
        </template>
    </card>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { getCalenderProposalInfo, itfFairCalenderProposalInfoStore, itfFairCalenderProposalInfoUpdate } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
import moment from 'moment'
export default {
  name: 'Details',
  components: {
    VueEditor
  },
  props: ['circular_id'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      isEdit: this.$route.query.id ? this.$route.query.id : 0,
      errors: [],
      tmpCircular: [],
      duration: '',
      calendarcircularList: [],
      formData: {
        file: [],
        fiscal_year_id: this.$store.state.currentFiscalYearId,
        circular_memo_number: '',
        circular_id: 0,
        fair_name: '',
        fair_name_bn: '',
        // sectors: [],
        fair_sector_id: 0,
        type_of_fair: 0,
        country_id: 0,
        city: '',
        city_bn: '',
        date_from: '',
        date_to: '',
        product_service_exhibited: '',
        product_service_exhibited_bn: '',
        name_of_organizer: '',
        name_of_organizer_bn: '',
        proposed_by: '',
        proposed_by_bn: '',
        visitors_profile_of_last_year_event: '',
        visitors_profile_of_last_year_event_bn: '',
        exhibitors_profile_of_last_year_event: '',
        exhibitors_profile_of_last_year_event_bn: '',
        organizer_profile: '',
        organizer_profile_bn: '',
        costs_scheme_stands_services: '',
        prospect_bangladeshi_exhibitors: '',
        prospect_bangladeshi_exhibitors_bn: '',
        remarks: '',
        remarks_bn: '',
        attachment: '',
        created_by: 0,
        name: '',
        name_bn: '',
        org_name: '',
        org_name_bn: '',
        designation: '',
        designation_bn: '',
        mobile_no: '',
        email: '',
        flag: 2
      }
      // sectorsError: ''
    }
  },
  watch: {
    'formData.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.calendarcircularList = this.getCircularListByFiscalyear(newVal)
      }
      if (oldVal !== 0) {
        this.formData.circular_id = 0
      }
    },
    'formData.circular_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const circularObj = this.$store.state.TradeFairService.commonObj.calendarCircularList.find(el => el.value === parseInt(newVal))
        if (circularObj !== undefined) {
            this.formData.circular_memo_number = circularObj.circular_memo_number
        } else {
            this.formData.circular_memo_number = ''
        }
      }
    },
    'formData.date_to': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.duration = this.getDuration()
      }
    },
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.duration = this.getDuration()
        }
    }
  },
  created () {
    this.calendarcircularList = this.getCircularListByFiscalyear(this.formData.fiscal_year_id)
    if (this.$route.query.id) {
      this.getCalenderInfo(this.$route.query.id)
    } else {
        this.formData.created_by = this.$store.state.Auth.authUser.user_id
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    },
    typeOfFair () {
      return this.$store.state.TradeFairService.commonObj.typeOfFair.map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    countryList () {
        return this.$store.state.CommonService.commonObj.countryList.map(el => {
            return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    },
    fairSectorList () {
        return this.$store.state.TradeFairService.commonObj.fairSectorList.map(el => {
            return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    }
  },
  methods: {
    /* getCircularList (fiscalYear) {
        this.formData.circular_id = 0
        this.calendarcircularList = this.getCircularListByFiscalyear(fiscalYear)
    }, */
    getCircularListByFiscalyear (fiscalYear) {
        return this.$store.state.TradeFairService.commonObj.calendarCircularList.filter(item => item.fiscal_year_id === fiscalYear).map(item => {
            return Object.assign({}, item, { text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en })
        })
    },
    getDuration () {
        const start = moment(this.formData.date_from, 'YYYY-MM-DD')
        const end = moment(this.formData.date_to, 'YYYY-MM-DD')
        const numberOfDays = end.diff(start, 'days')
        if (numberOfDays > 0) {
            const years = Math.floor(numberOfDays / 365)
            const months = Math.floor(numberOfDays % 365 / 30)
            const days = Math.floor(numberOfDays % 365 % 30)

            const yearsDisplay = years > 0 ? this.currentLocale === 'bn' ? this.$n(years) + ' বছর ' : years + (years === 1 ? ' year, ' : ' years, ') : ''
            const monthsDisplay = months > 0 ? this.currentLocale === 'bn' ? this.$n(months) + ' মাস ' : months + (months === 1 ? ' month, ' : ' months, ') : ''
            const daysDisplay = days > 0 ? this.currentLocale === 'bn' ? this.$n(days) + ' দিন ' : days + (days === 1 ? ' day' : ' days') : ''
            return yearsDisplay + monthsDisplay + daysDisplay
        } else {
            this.formData.date_from = ''
            this.formData.date_to = ''
        }
    },
    getCalenderInfo (id) {
        this.loading = true
        RestApi.getData(internationalTradeFairServiceBaseUrl, `${getCalenderProposalInfo}/${id}`).then(response => {
            if (response.success) {
                this.tmpCircular = response.data.circular
                this.formData = response.data
                // this.formData.sectors = response.sectors
                this.loading = false
            }
        })
    },
    onFileChange (event) {
        /* const bytesize = event.target.files[0].size
        const kbsize = bytesize / 1024
        if (kbsize > 50) {
            if (!this.$router.query.id) {
                this.formData.attachment = ''
            }
            this.formData.file = []
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('externalUser.filesize'),
                color: '#ee5253'
            })
            return
        } */
        const input = event.target
        if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
            this.formData.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
        } else {
            this.formData.attachment = ''
        }
    },
    async save () {
        /* if (this.formData.sectors.length === 0) {
            this.sectorsError = 'Sectors is not valid.'
            return
        } */
        this.loading = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }

        if (this.$route.query.id) {
            result = await RestApi.postData(internationalTradeFairServiceBaseUrl, `${itfFairCalenderProposalInfoUpdate}/${this.$route.query.id}`, this.formData)
        } else {
            result = await RestApi.postData(internationalTradeFairServiceBaseUrl, itfFairCalenderProposalInfoStore, this.formData)
        }

        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.warning) {
            this.$toast.error({
                title: 'Warning',
                message: result.message,
                color: '#e77171'
            })
            return
        }

        if (result.success) {
            if (this.$route.query.id) {
                this.$router.push({ path: '/trade-fair-service/itf/fair-proposal-management/collected-fair-calendars-fiscal-year-circular-wise', query: { fiscal_year: result.data.fiscal_year_id } })
            } else {
                this.$router.push('/trade-fair-service/itf/fair-proposal-management/collect-fair-calendar')
            }
        } else {
            /* if (result.errors.sectors.length) {
                this.sectorsError = result.errors.sectors[0]
            } */
            this.$refs.form.setErrors(result.errors)
            this.loading = false
        }
    }
  }
}
</script>
