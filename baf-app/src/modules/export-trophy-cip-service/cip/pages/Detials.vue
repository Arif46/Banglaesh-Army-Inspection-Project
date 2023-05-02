<template>
    <div class="inner-section">
        <b-row v-if="dataLoad">
            <b-col xs="12" sm="12" md="12" class="text-right mb-2">
                <b-button @click="pdfExport()" class="btn-sm" variant="primary">{{  $t('globalTrans.export_pdf') }}</b-button>
            </b-col>
        </b-row>
        <body-card>
            <template v-slot:body>
                <b-row>
                    <b-col md="3" class="text-right">
                        <img style="width:120px; height: 120px" :src="dataLoad && orgLogo.right_logo ? exportTrophyCIPServiceBaseUrl + 'download-attachment?file=storage/' + orgLogo.right_logo : preview" width="200" height="150"/>
                    </b-col>
                    <b-col md="6">
                        <div class="text-center">
                            <h3>{{ $t('etDetailsView.heading_1') }}</h3>
                            <h5>{{ $t('etDetailsView.heading_bhobon') }}</h5>
                            <h5>{{ $t('etDetailsView.heading_address') }}</h5>
                            <p><span style="border-bottom:1px solid #000"> {{ $t('etDetailsView.heading_web') }} </span></p>
                        </div>
                    </b-col>
                    <b-col md="3" class="text-left">
                        <img class="img-thumbnail" style="width:120px; height: 120px" :src="dataLoad && application.photo ? exportTrophyCIPServiceBaseUrl + 'download-attachment?file=storage/' + application.photo : preview" width="200" height="150"/>
                    </b-col>
                </b-row>
                <b-col v-if="!dataLoad" md="12">
                    <div class="text-center">
                        <p>{{ (currentLocale === 'en') ? 'Loading! Please wait...' : 'লোড হচ্ছে! অনুগ্রহপূর্বক অপেক্ষা করুন...' }}</p>
                        <div class="spinner-grow text-info" role="status"></div>
                    </div>
                </b-col>
                <b-col v-else md="12">
                    <!-- Tab-1: Basic Information -->
                    <b-row class="mb-3" style="margin-top:40px">
                        <div class="bg-primary w-50 m-auto rounded-pill">
                            <h5 class="text-white text-center py-1" v-if="currentLocale === 'bn'"> {{ $t('externalUser.cip_header') }} {{ EngBangNum(application.year.toString()) }} {{ $t('externalUser.cip_header_ex') }}</h5>
                            <h5 class="text-white text-center py-1" v-else> {{ $t('externalUser.cip_header') }} {{ $t('externalUser.cip_header_ex') }} {{ application.year }}</h5>
                        </div>
                    </b-row>
                    <h5 class="header text-center">({{ getPreviousFiscalYear(application.year)}} {{ $t('etDetailsView.application_header') }})</h5>
                    <b-row class="mt-4">
                        <!-- first step-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(1)}})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.export_cip_product_name')  + ' ' + $t('detailsView.circular_wise_product_application') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ productName(application.product_service_sector_id) }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(2) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.cip_application_single') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ getAppType(application.app_type) }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(3) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.exporter') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ getLatentExporter(application.latent_exporter) }}</td>
                                </tr>
                            </tbody>
                        </table>
                         <!-- Personal Information-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td class="text-center"> {{ $n (4) }})</td>
                                    <td colSpan="3" class="text-left"><span style="border-bottom: 1px solid #333"> {{ $t('detailsView.personal_info_cip') }} </span></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{ $t('detailsView.one')}}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.cip_application_full_name') }} i) {{ $t('globalTrans.bn')}}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ application.name_bn }}</td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left"> ii)English (Capital Letter)</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left"><p class="text-uppercase">{{ application.name_en }}</p></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left" colspan="3">{{ $t('detailsView.extra_text') }}</td>
                                </tr>
                            </tbody>
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.two') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.concernned_application') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ currentLocale === 'bn' ? application.designation_bn : application.designation_en }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.three') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.applicant_father_husband_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ currentLocale === 'bn' ? application.father_name_bn : application.father_name_en }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{  $t('detailsView.four') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.applicant_mother_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ currentLocale === 'bn' ? application.mother_name_bn : application.mother_name_en }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.five') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.national_identification_number') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ $n(application.nid, { useGrouping: false }) }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.six') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.present_address_mobile') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.address !== null">{{ currentLocale === 'en' ? application.address.pm_address_details_en : application.address.pm_address_details_bn + ', ' }} <br> {{ application.contact_info.mobile_no | mobileNumber }} <br> {{ $n(application.contact_info.telephone_no, { useGrouping: false }) }}<br>{{ application.contact_info.email }} </td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{  $t('detailsView.seven') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.permanent_address') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.address !== null">{{ AddressHelper.getPermanentAddress(application.address) }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{  $t('detailsView.eight') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.tin') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.tax_info !== null">{{ $n(application.tax_info.tin_no, { useGrouping: false }) }}</td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td>{{ $t('detailsView.circule') }}</td>
                                    <td class="text-center">:</td>
                                    <td class="text-left" v-if="application.tax_info !== null">{{ application.tax_info.tax_circle }}</td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.region') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.tax_info !== null">{{ currentLocale === 'bn' ? application.tax_info.tax_region_bn : application.tax_info.tax_region_en }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- Institute_ Info-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td class="text-center"> {{ $n (5) }})</td>
                                    <td colSpan="3" class="text-left"><span style="border-bottom: 1px solid #333"> {{ $t('detailsView.institute_info') }} </span></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{ $t('detailsView.one')}}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_owner_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ currentLocale === 'bn' ? application.org_info.owner_name_bn : application.org_info.owner_name_en }}</td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.two') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.desination_owner') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ currentLocale === 'bn' ? application.org_info.designation_bn : application.org_info.designation_en }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "2">{{  $t('detailsView.three') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_name_bn') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{  application.org_info.org_name_bn }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">(ii) English (Capital Letter)</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null"><p class="text-uppercase">{{  application.org_info.org_name_en }}</p></td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.four') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_owner_type') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ orgTypeName(application.org_info.org_type) }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{  $t('detailsView.five') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_tin') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_tax_info !== null">{{ $n(application.org_tax_info.tin_no, { useGrouping: false }) }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.circule') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_tax_info !== null">{{ application.org_tax_info.tax_circle }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.region') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_tax_info !== null">{{ currentLocale === 'bn' ? application.org_tax_info.tax_region_bn : application.org_tax_info.tax_region_en }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.six') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_bin') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ $n(application.org_info.bin_no, { useGrouping: false }) }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{  $t('detailsView.seven') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_address') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.office_contact_info !== null">
                                        {{ application.office_contact_info.telephone_no ? $t('externalUser.telephone_no') + ' : ' + EngBangNum(application.office_contact_info.telephone_no) : '' }} <br/>
                                        {{ application.office_contact_info.mobile_no ? $t('globalTrans.mobile') + ' : ' + EngBangNum(application.office_contact_info.mobile_no) : '' }} <br/>
                                        {{ application.office_contact_info.email ? $t('globalTrans.email') + ' : ' + application.office_contact_info.email : '' }}
                                        {{ application.office_contact_info.fax_no ? $t('externalUser.fax_no') + ' : ' + EngBangNum(application.office_contact_info.fax_no) : '' }} <br/>
                                    </td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_company') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.factory_contact_info !== null">
                                        {{ application.factory_contact_info.telephone_no ? $t('externalUser.telephone_no') + ' : ' + EngBangNum(application.factory_contact_info.telephone_no) : '' }} <br/>
                                        {{ application.factory_contact_info.mobile_no ? $t('globalTrans.mobile') + ' : ' + EngBangNum(application.factory_contact_info.mobile_no) : '' }} <br/>
                                        {{ application.factory_contact_info.email ? $t('globalTrans.email') + ' : ' + application.factory_contact_info.email : '' }}
                                        {{ application.factory_contact_info.fax_no ? $t('externalUser.fax_no') + ' : ' + EngBangNum(application.factory_contact_info.fax_no) : '' }} <br/>
                                    </td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_contact_person') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.contact_person_info !== null">
                                        {{ currentLocale === 'en' ? application.contact_person_info.name_en : application.contact_person_info.name_bn }} <br/>
                                        {{ currentLocale === 'bn' ? application.contact_person_info.designation_bn : application.contact_person_info.designation_en + ', ' }} <br/>
                                        {{ application.contact_person_info.mobile ? $t('globalTrans.mobile') + ' : ' + EngBangNum(application.contact_person_info.mobile) : ''}}
                                    </td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                        </table>
                          <!--EPZ Company-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(6) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.epz_company') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ parseInt(application.org_info.bangladeshi_owned_company) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }}</td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                        </table>
                        <!--- Group Name-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center" rowspan="8">{{ $n(7) }})</td>
                                    <td width="60%" class="text-left" colspan="3">{{ $t('detailsView.extra_text_two') }} {{ parseInt(application.applied_group_of_companies) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }}</td>
                                </tr>
                                <tr>
                                    <td width="33%" class="text-left">{{ $t('detailsView.group_name') }}</td>
                                    <td width="33%" class="text-left">{{ $t('detailsView.group_institute_name') }}</td>
                                    <td width="33%" class="text-left" colspan="1">{{ $t('detailsView.export_earning') }}</td>
                                </tr>
                                <template v-if="application.group_based_app.length > 0 && parseInt(application.applied_group_of_companies) === 1">
                                    <tr v-for="(item, index) in application.group_based_app" :key="index">
                                        <td width="5%" class="text-left">{{ currentLocale === 'bn' ? item.group_name_bn : item.group_name_en }}</td>
                                        <td width="5%" class="text-left">{{ currentLocale === 'bn' ? item.org_name_bn : item.org_name_en }}</td>
                                        <td width="45%" class="text-left" colspan="2">{{ $n(item.export_value, { useGrouping: false }) }}</td>
                                    </tr>
                                </template>
                            </tbody>
                        </table>
                        <p class="border border-1 border-dark mb-2">
                            {{ $t('detailsView.extra_text_three') }}
                        </p>
                        <!--bank information-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(8) }})</td>
                                    <td width="35%" class="text-left">{{ $t('detailsView.application_institute_bank_name') }}</td>
                                    <td width="60%" class="text-left" v-if="application.bank.length > 0">
                                        <p v-for="(item, index1) in application.bank" :key="index1">
                                            {{ $n(index1 + 1) + ' ) ' }}
                                            {{ currentLocale === 'bn' ? item.bank_name_bn : item.bank_name_en }}, {{ currentLocale === 'bn' ? item.branch_name_bn : item.branch_name_en }} <br/>
                                            <span style="display:inline-block;margin-left: 25px"> {{ currentLocale === 'bn' ? item.address_bn : item.address_en }} </span>
                                        </p>
                                    </td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- Export Application Description-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="3%" :rowspan="application.product_success_description.length + 2">{{ $n (9) }})</td>
                                    <td colspan="6" class="text-left"> {{ $t('detailsView.export_product_details') }} </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $t('detailsView.exported_name')}}</td>
                                    <td class="text-left">{{ $t('detailsView.fiscal_year_name') }}</td>
                                    <td class="text-center">{{ $t('detailsView.export_volumes')}}</td>
                                    <td class="text-center">{{ $t('detailsView.export_earning_millions')}}</td>
                                    <td class="text-center">{{ $t('detailsView.previous_fiscal_year')}}</td>
                                    <td class="text-center">{{ $t('detailsView.destination')}}</td>
                                </tr>
                                <template v-if="application.product_success_description.length">
                                    <template v-for="(item, index3) in application.product_success_description">
                                        <tr v-if="index3 === 0" :key="index3">
                                            <td class="text-center">{{ productName(item.product_id) }}</td>
                                            <td class="text-center">{{ fiscalYearName(item.fiscal_year_id) }}</td>
                                            <td class="text-center">{{ item.export_volume }}</td>
                                            <td class="text-center">{{ $n(item.export_value_ssd, { useGrouping: false }) }}</td>
                                            <td class="text-center" rowspan="2">{{ $n(application.product_success_description[1].income_growth) }} %</td>
                                            <td class="text-center" rowspan="2">{{ getDesingationData(destinationList) }}</td>
                                        </tr>
                                        <tr v-else :key="index3">
                                            <td class="text-center">{{ productName(item.product_id) }}</td>
                                            <td class="text-center">{{ fiscalYearName(item.fiscal_year_id) }}</td>
                                            <td class="text-center">{{ item.export_volume }}</td>
                                            <td class="text-center">{{ $n(item.export_value_ssd, { useGrouping: false }) }}</td>
                                        </tr>
                                    </template>
                                </template>
                                <tr>
                                    <td width="60%" class="text-left" colspan="7">{{ $t('detailsView.extra_text_four') }}</td>
                                </tr>
                            </tbody>
                        </table>
                          <!-- 2020-2021 fiscal Year-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(10) }})</td>
                                    <td width="60%" class="text-left" colspan="3"> {{ getPreviousFiscalYear(application.year)}}
                                        {{ $t('detailsView.extra_text_ten') }} : <small>{{ application.other_compliance !== null ? parseInt(application.other_compliance.dispute_settled) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') : (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') }} </small><br>
                                        {{ $t('detailsView.extra_test_fourtheen')}}  <small> {{ application.other_compliance === null ? (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') : '' }} </small>
                                        <template v-if="application.other_compliance !== null">
                                            <span v-if="parseInt(application.other_compliance.dispute_settled) === 1">
                                                <a v-if="application.other_compliance.dispute_settled_document" class="btn btn-success btn-sm rounded-pill" target="_blank" :href="baseUrl + 'download-attachment?file=' + application.other_compliance.dispute_settled_document" title="attachment"><i class="ri-download-cloud-fill"></i></a>
                                            </span>
                                        </template>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(11) }})</td>
                                    <td width="60%" class="text-left" colspan="3">
                                        {{ $t('detailsView.extra_text_eleven') }} : <small>{{ application.other_compliance !== null ? parseInt(application.other_compliance.applicant_selected_cip_past_year) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') : (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') }} </small>
                                        <template v-if="application.other_compliance !== null">
                                            <p v-for="(item, index5) in application.cip_selected" :key="index5">
                                                <span v-if="parseInt(application.other_compliance.applicant_selected_cip_past_year) === 1">
                                                    {{ $n(index5 + 1) + ' ) ' }}
                                                    {{ $n(item.selection_year, { useGrouping: false }) }},
                                                    {{ productName(item.product_sector_id) }}<br/>
                                                </span>
                                            </p>
                                        </template>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(12) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.others_info') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-center">{{ application.other_compliance !== null ? application.other_compliance.other_information : '' }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- Attachment -->
                        <table class="table table-bordered table-hover">
                            <tbody v-if="application.attachment_all_doc !== null">
                                <tr>
                                    <td rowspan="9" width="5%">{{ $n (13) }})</td>
                                    <td width="9%"> {{ $t('globalTrans.sl_no') }}</td>
                                    <td class="text-center"> {{ $t('externalUser.attachment') }} </td>
                                    <td width="10%"> {{ $t('globalTrans.download') }}</td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(1) }}</td>
                                    <td class="text-left">{{ $t('externalUser.latest_year_tax_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.latest_year_tax_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.latest_year_tax_certificate" title="Latest year tax certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(2) }}</td>
                                    <td class="text-left">{{ $t('externalUser.vat_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.vat_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.vat_certificate" title="Vat certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(3) }}</td>
                                    <td class="text-left">{{ $t('externalUser.custom_duty_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.custom_duty_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.custom_duty_certificate" title="Custom duty certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(4) }}</td>
                                    <td class="text-left">{{ $t('externalUser.income_tax_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.income_tax_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.income_tax_certificate" title="Custom duty certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(5) }}</td>
                                    <td class="text-left">{{ $t('externalUser.loan_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.loan_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.loan_certificate" title="Loan certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(6) }}</td>
                                    <td class="text-left">{{ $t('externalUser.incorporation_certificate') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.incorporation_certificate">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.incorporation_certificate" title="Incorporation certificate" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(7) }}</td>
                                    <td class="text-left">{{ $t('externalUser.bank_prc_last_fical_year') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.bank_prc_last_fical_year">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.bank_prc_last_fical_year" title="Bank prc last fical year" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="text-center">{{ $n(8) }}</td>
                                    <td class="text-left">{{ $t('externalUser.bank_prc_latest_fical_year') }}</td>
                                    <td class="text-center">
                                        <span v-if="application.attachment_all_doc.bank_prc_latest_fical_year">
                                            <a target="_blank" :href="baseUrl + 'download-attachment?file=' + application.attachment_all_doc.bank_prc_latest_fical_year" title="Bank prc lastest fical year" class="mr-3"> <span class="btn btn-success btn-sm rounded-pill"><i class="ri-download-cloud-fill"></i></span></a>
                                        </span>
                                        <span v-else> {{ $t('externalUser.incomplete_form') }} </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <h5 class="Personal text-left">{{ $t('detailsView.application_rules') }}</h5>
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.one') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.first_rule') }} {{ getPreviousFiscalYearFirst(application.circular.year)}} {{ (currentLocale === 'en' ? 'and' : 'এবং') }} {{ getPreviousFiscalYear(application.circular.year) }} {{ $t('detailsView.first_rule_ex') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.two') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.secound_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.three') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.third_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.four') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.four_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.five') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.five_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.six') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.six_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.seven') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.seven_rule') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.eight') }}</td>
                                    <td width="90%" class="text-left">{{ $t('detailsView.eight_rule') }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!--End Text Extra-->
                        <p> {{ $t('globalTrans.date')}} : <b style="border-bottom:1px dotted #000">{{ EngBangNum(finalSubmitDate(application.updated_at)) }}</b></p>
                        <b-col sm="12">
                            <b-row>
                                <b-col sm="4" offset="8" class="text-center">
                                    <p> {{ application.org_info !== null ? currentLocale === 'bn' ? application.org_info.owner_name_bn : application.org_info.owner_name_en : (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') }} </p>
                                    <p> {{ application.org_info !== null ? currentLocale === 'bn' ? application.org_info.designation_bn : application.org_info.designation_en : (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') }} </p>
                                    <p> {{ application.org_info !== null ? currentLocale === 'bn' ? application.org_info.org_name_bn : application.org_info.org_name_en : (currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে') }} </p>
                                    <img style="width:120px; height: 120px" v-if="application.other_compliance !== null" :src="exportTrophyCIPServiceBaseUrl + 'download-attachment?file=storage/' + application.other_compliance.signature" width="200" height="100"/>
                                    <p v-else>{{ (currentLocale === 'en' ? 'Signature ...............' : 'স্বাক্ষর ...............') }} </p>
                                </b-col>
                            </b-row>
                        </b-col>
                    </b-row>
                </b-col>
            </template>
        </body-card>
        <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm mt-2" @click="$bvModal.hide('modal-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
    </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import NoImage from '../../../../assets/images/user/no-image.jpg'
import { detailsApi } from '../api/routes'
import { mapGetters } from 'vuex'
import AddressHelper from '@/utils/area-type-address'
import ExportPdf from './export-pdf'
import moment from 'moment'

export default {
    props: ['id'],
    components: {},
    data () {
        return {
            AddressHelper: AddressHelper,
            baseUrl: exportTrophyCIPServiceBaseUrl,
            preview: NoImage,
            dataLoad: false,
            orgLogo: '',
            application: {},
            org_address: {},
            destinationList: [],
            exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
        }
    },
    created () {
        if (this.id) {
            this.getCipData()
        }
    },
    watch: {
    },
    computed: {
        ...mapGetters({
            commonProfile: 'Auth/commonProfile',
            authUser: 'Auth/authUser'
        }),
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        finalSubmitDate (date) {
            return moment(date).format('L')
        },
        getPreviousFiscalYear (year) {
            const firstYear = parseInt(year) - 1 // 2021
            const secondYear = firstYear - 1 // 2020
            const fiscalYear = secondYear + '-' + firstYear
            return this.EngBangNum(fiscalYear.toString())
        },
        getPreviousFiscalYearFirst (year) {
            const firstYear = parseInt(year) - 2 // 2020
            const secondYear = firstYear - 1 // 2019
            const fiscalYear = secondYear + '-' + firstYear
            return this.EngBangNum(fiscalYear.toString())
        },
        merchandisingSectorName (Id) {
          const Obj = this.$store.state.ExportTrophyCipService.commonObj.merchandisingTypeList.find(item => item.value === Id)
          if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        productName (Id) {
          const Obj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(item => item.value === Id)
          if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        destinationName (Id) {
          const Obj = this.$store.state.CommonService.commonObj.countryList.find(item => item.value === Id)
          if (typeof Obj !== 'undefined') {
              return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        fiscalYearName (Id) {
          const Obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === Id)
          if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        orgTypeName (Id) {
            const Obj = this.$store.state.ExportTrophyCipService.commonObj.orgTypeList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        countryName (Id) {
            const Obj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        genderName (Id) {
            const Obj = this.$store.state.commonObj.genderList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        getLatentExporter (Id) {
            const Obj = this.$store.state.ExportTrophyCipService.commonObj.latentExporterList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        getAppType (Id) {
            const Obj = this.$store.state.ExportTrophyCipService.commonObj.cipAppTypeList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        async getCipData () {
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, detailsApi, { app_id: this.id })
            if (result.success) {
                this.orgLogo = result.orgLogo
                this.application = result.data
                if (result.data.org_address !== null) {
                    this.org_address = {
                        pr_area_type_id: this.application.org_address.area_type_id,
                        pr_division_id: this.application.org_address.division_id,
                        pr_district_id: this.application.org_address.district_id,
                        pr_upazila_id: this.application.org_address.upazila_id,
                        pr_city_corporation_id: this.application.org_address.city_corporation_id,
                        pr_union_id: this.application.org_address.union_id,
                        pr_ward_id: this.application.org_address.ward_id,
                        pr_pauroshoba_id: this.application.org_address.paurashava_id
                    }
                }
                if (result.data.product_success_description.length > 0) {
                    const arr1 = result.data.product_success_description[0].destination_id.substring(1, result.data.product_success_description[0].destination_id.length - 1).split(',')
                    const arr2 = result.data.product_success_description[1].destination_id.substring(1, result.data.product_success_description[1].destination_id.length - 1).split(',')
                    const merged = [...arr1, ...arr2]
                    const uniqueDestination = merged.filter((x, i, a) => a.indexOf(x) === i)
                    this.destinationList = uniqueDestination
                }
                this.dataLoad = true
            } else {
                this.dataLoad = false
            }
        },
        EngBangNum (n) {
            if (this.$i18n.locale === 'bn') {
                return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
            } else {
                return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
            }
        },
        getDesingationData (data) {
            const arr = []
            if (data.length > 0) {
                data.map((item) => {
                    const countryObj = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(item))
                    if (countryObj !== undefined) {
                        const countryName = this.currentLocale === 'en' ? countryObj?.text_en : countryObj?.text_bn
                        arr.push(' ' + countryName)
                    }
                })
            }
            return arr.toString()
        },
        pdfExport () {
            // const reportTitle = this.$t('externalUser.cip_application') + ' ' + this.$t('globalTrans.details')
            ExportPdf.exportPdfDetails(this)
        }
    }
}
</script>
<style scoped>
    .header {
        font-size: 17px;
    }
    .Personal {
        font-size: 25px;
    }
    .break {
        flex-basis: 100%;
        height: 0;
    }
</style>
