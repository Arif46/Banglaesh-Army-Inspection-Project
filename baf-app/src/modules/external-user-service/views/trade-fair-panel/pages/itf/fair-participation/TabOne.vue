<template>
    <b-row>
        <b-col sm="12">
            <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                    <b-overlay :show="unitLoad">
                        <b-row class="mb-3">
                            <div class="bg-dark w-50 m-auto rounded-pill">
                                <h6 class="text-white text-center py-1">{{ $t('externalTradeFair.company_info') }}</h6>
                            </div>
                        </b-row>
                        <div class="application-form-wrapper">
                            <div class="application-itmes">
                                <b-row>
                                    <b-col sm="12">
                                        <div class="jumbotron" style="padding: 1rem">
                                            <p><b class="text-alt">{{ $t('exportTrophyCircular.circular') }} :</b> <span class="lead">{{ circular_name }}</span></p>
                                        </div>
                                        <!-- <ValidationProvider name="Circular Title" vid="circular_name" rules="required" v-slot="{ errors }">
                                            <b-form-group label-cols-sm="12" label-for="circular_name">
                                                <template v-slot:label>
                                                    {{ $t('exportTrophyCircular.circular') }} <span class="text-danger">*</span>
                                                </template>
                                                <b-form-input v-model="circular_name" disabled
                                                    :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider> -->
                                    </b-col>
                                </b-row>
                                <b-row>
                                    <b-col sm="12">
                                        <div class="group-form-card">
                                            <b-card>
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.company_basic_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Fair Sector" vid="fair_sector_id" rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="fair_sector_id">
                                                                    <template v-slot:label>
                                                                        {{ $t('tradeFairConfig.fair_sector') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain id="fair_sector_id" v-model="application.applied_sector_id" :options="fairSectorList"
                                                                        @change="firstThreeLetofSector(application.applied_sector_id)"
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
                                                    </b-row>
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') + ' [' + $t('externalTradeFair.company_name') + ']'
                                                                        }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.name_en" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="name_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn') + ' [' + $t('externalTradeFair.company_name') +
                                                                        ']' }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.name_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Address (En)" vid="address_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="address_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.address') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.address_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="address_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.address') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.address_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Factory Address (En)" vid="factory_address_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="factory_address_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.factory_address') + ' ' + $t('globalTrans.en')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.factory_address_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Factory Address (Bn)" vid="factory_address_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="factory_address_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.factory_address') + ' ' + $t('globalTrans.bn')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.factory_address_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Web Page (Url)" vid="web_page_url">
                                                                <b-form-group label-for="web_page_url">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.web_page') }}
                                                                    </template>
                                                                    <b-form-input v-model="application.web_page_url"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Phone No." vid="phone_no" rules="required|max:11" v-slot="{ errors }">
                                                                <b-form-group label-for="phone_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.phone_no') + ' [' + $t('globalTrans.office') + ']' }} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.phone_no" :state="errors[0] ? false : (valid ? true : null)"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
                                                                <b-form-group label-for="email">
                                                                    <template v-slot:label>
                                                                        {{ $t('globalTrans.email') }}
                                                                    </template>
                                                                    <b-form-input id="org_bn" type="email" v-model="application.email"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
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
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.exporter_business_entity_info')" label-size="lg"
                                                    label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Type of Company / Exporter / Business Entity" vid="company_type"
                                                                rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="company_type">
                                                                    <template v-slot:label>
                                                                        {{$t('externalTradeFair.type_of_company')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain v-model="application.company_type" :options="companyTypeList"
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
                                                        <b-col sm="6" v-if="application.company_type == 4">
                                                            <ValidationProvider name="Other Company Type (En)" vid="other_comp_type_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="other_comp_type_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.other_comp_type') + ' ' + $t('globalTrans.en')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.other_comp_type_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6" v-if="application.company_type == 4">
                                                            <ValidationProvider name="Other Company Type (Bn)" vid="other_comp_type_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="other_comp_type_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.other_comp_type') + ' ' + $t('globalTrans.bn')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.other_comp_type_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <!-- end company type -->
                                                        <!-- nature of company  -->
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Nature of Company / Exporter / Business Entity" vid="company_nature"
                                                                rules="required|min_value:1" v-slot="{ errors }">
                                                                <b-form-group label-for="company_nature">
                                                                    <template v-slot:label>
                                                                        {{$t('externalTradeFair.nature_of_company')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain v-model="application.company_nature" :options="companyNatureList"
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
                                                        <b-col sm="6" v-if="application.company_nature == 5">
                                                            <ValidationProvider name="Other Company Nature (En)" vid="other_comp_nature_en" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="other_comp_nature_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.other_comp_nature') + ' ' + $t('globalTrans.en')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.other_comp_nature_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6" v-if="application.company_nature == 5">
                                                            <ValidationProvider name="Other Company Nature (Bn)" vid="other_comp_nature_bn" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="other_comp_nature_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.other_comp_nature') + ' ' + $t('globalTrans.bn')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.other_comp_nature_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <!-- end nature of company -->
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Year of Establishment" vid="establishment_year" rules="required|min_value:1"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="establishment_year">
                                                                    <template v-slot:label>
                                                                        {{$t('externalTradeFair.establishment_year')}} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-select plain v-model="application.establishment_year" :options="yearList"
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
                                                            <ValidationProvider name="TIN No." vid="erc_no" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="erc_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.erc_no') }}
                                                                    </template>
                                                                    <b-form-input v-model="application.erc_no"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="TIN No." vid="tin_no" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="tin_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalUser.tin_no') }}
                                                                    </template>
                                                                    <b-form-input v-model="application.tin_no"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Bin No" vid="bin_no" rules="" v-slot="{ errors }">
                                                                <b-form-group label-for="bin_no">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalUser.bin_no') }}
                                                                    </template>
                                                                    <b-form-input v-model="application.bin_no"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Product To Be Displayed (En)" vid="display_product_en" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="display_product_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.products_to_displayed') + ' ' + $t('globalTrans.en')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.display_product_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Product To Be Displayed (Bn)" vid="display_product_bn" rules="required"
                                                                v-slot="{ errors }">
                                                                <b-form-group label-for="display_product_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.products_to_displayed') + ' ' + $t('globalTrans.bn')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.display_product_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Production Capacity" vid="production_capacity" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="production_capacity">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.production_capacity') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.production_capacity"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Number of Employees" vid="employee_number" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="employee_number">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.no_of_employess') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.employee_number"
                                                                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Main Markets (En)" vid="main_market_en" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="main_market_en">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.main_markets') + ' ' + $t('globalTrans.en')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.main_market_en"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                                    <div class="invalid-feedback">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Main Markets (Bn)" vid="main_market_bn" rules="required" v-slot="{ errors }">
                                                                <b-form-group label-for="main_market_bn">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.main_markets') + ' ' + $t('globalTrans.bn')}} <span
                                                                            class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-input v-model="application.main_market_bn"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
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
                                                <b-form-group label-cols-lg="3" :label="$t('externalTradeFair.export_performance_last')"
                                                    label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                                    <b-row>
                                                        <b-col sm="6">
                                                            <ValidationProvider name="Have You Exported" vid="is_exported" rules="required|min_value:1">
                                                                <b-form-group label-for="is_exported" slot-scope="{ valid, errors }">
                                                                    <template v-slot:label>
                                                                        {{ $t('externalTradeFair.is_exported') }} <span class="text-danger">*</span>
                                                                    </template>
                                                                    <b-form-radio-group v-model="application.is_exported"
                                                                        :options="[{ value: 1, text: $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }, { value: 2, text: $i18n.locale == 'en' ? 'No' : 'না' }]"
                                                                        value-field="value" text-field="text"
                                                                        :state="errors[0] ? false : (valid ? true : null)"></b-form-radio-group>
                                                                    <div class="invalid-feedback d-block">
                                                                        {{ errors[0] }}
                                                                    </div>
                                                                </b-form-group>
                                                            </ValidationProvider>
                                                        </b-col>
                                                        <!-- <b-col sm="12" v-if="parseInt(application.is_exported) === 1">
                                                            <add-exports :dataArray="prev_exports" :unitList="unitList" />
                                                        </b-col> -->
                                                    </b-row>
                                                </b-form-group>
                                            </b-card>
                                        </div>
                                    </b-col>
                                </b-row>
                            </div>
                        </div>
                        <!-- <b-row class="mt-2">
                            <b-col lg="12" sm="12">
                                <ValidationProvider name="Circular Title" vid="circular_name" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="12"
                                        label-for="circular_name"
                                    >
                                    <template v-slot:label>
                                        {{ $t('exportTrophyCircular.circular') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="circular_name"
                                        disabled
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Fair Sector" vid="fair_sector_id" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                    label-cols-sm="5"
                                    label-for="fair_sector_id"
                                    >
                                    <template v-slot:label>
                                        {{ $t('tradeFairConfig.fair_sector') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                        plain
                                        id="fair_sector_id"
                                        v-model="application.applied_sector_id"
                                        :options="fairSectorList"
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
                        </b-row> -->
                        <!-- <b-row>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Name (En)" vid="name_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="name_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.en') + ' [' + $t('externalTradeFair.company_name') + ']' }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.name_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="name_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.name') + ' ' + $t('globalTrans.bn')  + ' [' + $t('externalTradeFair.company_name') + ']' }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.name_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Address (En)" vid="address_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="address_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.address') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.address_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="address_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.address') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.address_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Factory Address (En)" vid="factory_address_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="factory_address_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.factory_address') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.factory_address_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Factory Address (Bn)" vid="factory_address_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="factory_address_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.factory_address') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.factory_address_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                             <b-col lg="6" sm="12">
                                <ValidationProvider name="Web Page (Url)" vid="web_page_url">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="web_page_url"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.web_page') }}
                                    </template>
                                    <b-form-input
                                        v-model="application.web_page_url"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Phone No." vid="phone_no" rules="required|max:11" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="phone_no"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.phone_no') + ' [' + $t('globalTrans.office') + ']' }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            v-model="application.phone_no"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
                                    <b-form-group
                                        class="row"
                                        label-cols-sm="5"
                                        label-for="email"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.email') }}
                                        </template>
                                        <b-form-input
                                            id="org_bn"
                                            type="email"
                                            v-model="application.email"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Type of Company / Exporter / Business Entity" vid="company_type" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="company_type"
                                        label-cols-sm="5"
                                    >
                                        <template v-slot:label>
                                            {{$t('externalTradeFair.type_of_company')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            v-model="application.company_type"
                                            :options="companyTypeList"
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
                            <b-col v-if="application.company_type == 4" lg="6" sm="12">
                                <ValidationProvider name="Other Company Type (En)" vid="other_comp_type_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="other_comp_type_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.other_comp_type') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.other_comp_type_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col v-if="application.company_type == 4" lg="6" sm="12">
                                <ValidationProvider name="Other Company Type (Bn)" vid="other_comp_type_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="other_comp_type_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.other_comp_type') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.other_comp_type_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Nature of Company / Exporter / Business Entity" vid="company_nature" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="company_nature"
                                        label-cols-sm="5"
                                    >
                                        <template v-slot:label>
                                            {{$t('externalTradeFair.nature_of_company')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            v-model="application.company_nature"
                                            :options="companyNatureList"
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
                            <b-col v-if="application.company_nature == 5" lg="6" sm="12">
                                <ValidationProvider name="Other Company Nature (En)" vid="other_comp_nature_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="other_comp_nature_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.other_comp_nature') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.other_comp_nature_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col v-if="application.company_nature == 5" lg="6" sm="12">
                                <ValidationProvider name="Other Company Nature (Bn)" vid="other_comp_nature_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="other_comp_nature_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.other_comp_nature') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.other_comp_nature_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Year of Establishment" vid="establishment_year" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group
                                        label-for="establishment_year"
                                        label-cols-sm="5"
                                    >
                                        <template v-slot:label>
                                            {{$t('externalTradeFair.establishment_year')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            v-model="application.establishment_year"
                                            :options="yearList"
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
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="TIN No." vid="erc_no" rules="" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="erc_no"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.erc_no') }}
                                        </template>
                                        <b-form-input
                                            v-model="application.erc_no"
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
                                <ValidationProvider name="TIN No." vid="tin_no" rules="" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="tin_no"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalUser.tin_no') }}
                                        </template>
                                        <b-form-input
                                            v-model="application.tin_no"
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
                                <ValidationProvider name="Bin No" vid="bin_no" rules="" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="bin_no"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalUser.bin_no') }}
                                        </template>
                                        <b-form-input
                                            v-model="application.bin_no"
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
                                <ValidationProvider name="Product To Be Displayed (En)" vid="display_product_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="display_product_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.products_to_displayed') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.display_product_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Product To Be Displayed (Bn)" vid="display_product_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="display_product_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.products_to_displayed') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.display_product_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xl="6" lg="6" sm="12">
                                <ValidationProvider name="Production Capacity" vid="production_capacity" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="production_capacity"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.production_capacity') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            v-model="application.production_capacity"
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
                                <ValidationProvider name="Number of Employees" vid="employee_number" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="employee_number"
                                    >
                                    <template v-slot:label>
                                    {{ $t('externalTradeFair.no_of_employess') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.employee_number"
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
                                <ValidationProvider name="Have You Exported" vid="is_exported" rules="required|min_value:1">
                                    <b-form-group
                                        class="row"
                                        label-for="is_exported"
                                        label-cols-sm="5"
                                        slot-scope="{ valid, errors }"
                                        >
                                        <template v-slot:label>
                                        {{ $t('externalTradeFair.is_exported') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-radio-group
                                            v-model="application.is_exported"
                                            :options="[{ value: 1, text: $i18n.locale == 'en' ? 'Yes' : 'হ্যাঁ' }, { value: 2, text: $i18n.locale == 'en' ? 'No' : 'না' }]"
                                            value-field="value"
                                            text-field="text"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-radio-group>
                                        <div class="invalid-feedback d-block">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Main Markets (En)" vid="main_market_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="main_market_en"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.main_markets') + ' ' + $t('globalTrans.en')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.main_market_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col lg="6" sm="12">
                                <ValidationProvider name="Main Markets (Bn)" vid="main_market_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                        label-cols-sm="5"
                                        label-for="main_market_bn"
                                    >
                                    <template v-slot:label>
                                        {{ $t('externalTradeFair.main_markets') + ' ' + $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="application.main_market_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                        </b-row> -->
                    </b-overlay>
                </b-form>
            </ValidationObserver>
        </b-col>
            <b-col v-if="parseInt(application.is_exported) === 1" xl="12" lg="12" sm="12">
                <add-exports :dataArray="prev_exports" :unitList="unitList" />
            </b-col>
    </b-row>
</template>
<script>
import AddExports from './AddExports'
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairPartStoreOneApi } from '../../../api/routes'
import { mapGetters } from 'vuex'

export default {
    props: ['app_id', 'application', 'prev_exports', 'circular', 'unitList'],
    components: { AddExports },
    data () {
        return {
            errors: [],
            valid: null,
            unitLoad: false,
            fairSectorList: [],
            circular_name: ''
        }
    },
    created () {
        this.circular_name = this.$i18n.locale === 'bn' ? this.circular.subject_bn : this.circular.subject_en
        this.getFairSectorList()
    },
    watch: {
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.circular_name = this.$i18n.locale === 'bn' ? this.circular.subject_bn : this.circular.subject_en
                this.getFairSectorList()
            }
        }
    },
    computed: {
        yearList () {
            return this.$store.state.commonObj.yearList.map(el => {
                return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'en' ? el : this.$n(el, { useGrouping: false }) })
            })
        },
        companyTypeList () {
            return this.$store.state.TradeFairService.commonObj.companyTypeList.map(el => {
                return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
            })
        },
        companyNatureList () {
            return this.$store.state.TradeFairService.commonObj.companyNatureList.map(el => {
                return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
            })
        },
        ...mapGetters({
            commonProfile: 'Auth/commonProfile',
            authUser: 'Auth/authUser'
        }),
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        getFairSectorList () {
            const fairObj = this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.find(el => el.value === parseInt(this.circular.fair_name_id))
            this.application.applied_sector_id = fairObj.fair_sector_id
            if (typeof fairObj !== 'undefined') {
                this.fairSectorList = this.$store.state.ExternalUserService.tradeFair.commonObj.fairSectorList.filter(item => item.status === 1 && (item.value === fairObj.fair_sector_id || item.text_en === 'Others'))
                // first three letter of applied sector
                this.firstThreeLetofSector(this.application.applied_sector_id)
            } else {
                this.fairSectorList = []
            }
        },
        firstThreeLetofSector (Id) {
            const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.fairSectorList.find(el => el.value === parseInt(Id))
            this.application.sector_letter = Obj.text_en.substring(0, 3)
        },
        async submit () {
            var check = await this.$refs.form.validate()
            if (check) {
                this.unitLoad = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.application.app_id = this.app_id
                this.application.prev_exports = this.prev_exports
                const result = await RestApi.postData(internationalTradeFairServiceBaseUrl, fairPartStoreOneApi, this.application)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.unitLoad = false
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
                        message: result.message,
                        color: '#ee5253'
                    })
                    this.$refs.form.setErrors(result.errors)
                }
            }
        }
    }
}
</script>
