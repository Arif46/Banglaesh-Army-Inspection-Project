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
                        <div>
                            <h5 class="text-center py-1" v-if="currentLocale === 'bn'"> <span style="border-bottom: 1px solid #000"> {{ $t('etDetailsView.et_header') }} {{ getPreviousFiscalYear(application.circular.year)}} {{ $t('etDetailsView.et_header_ex') }} </span></h5>
                            <h5 class="text-center py-1" v-if="currentLocale === 'en'">{{ getPreviousFiscalYear(application.circular.year) }} {{ $t('etDetailsView.et_header') }} {{ $t('etDetailsView.et_header_ex') }}</h5>
                        </div>
                    </b-row>
                    <h5 class="header text-center" v-if="currentLocale === 'bn'">( {{ getPreviousFiscalYear(application.circular.year)}} {{ $t('etDetailsView.application_header') }} )</h5>
                    <h5 class="header text-center" v-if="currentLocale === 'en'">( {{ $t('etDetailsView.application_header') }} {{ getPreviousFiscalYear(application.circular.year)}} )</h5>
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
                                    <td class="text-center"> {{ $n (3) }})</td>
                                    <td colSpan="3" class="text-left">  {{ $t('detailsView.institute_info') }} </td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "8">{{ $t('detailsView.one')}}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_owner_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.owner_info !== null">{{ currentLocale === 'bn' ? application.owner_info.owner_name_bn : application.owner_info.owner_name_en }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left"> {{ $t('detailsView.desination_owner') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.owner_info !== null"><p class="text-uppercase">{{ currentLocale === 'bn' ? application.owner_info.designation_bn : application.owner_info.designation_en }}</p></td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left"> {{ $t('etDetailsView.applicant_father_husband_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.owner_info !== null"><p class="text-uppercase">{{ currentLocale === 'bn' ? application.owner_info.father_husband_name_bn : application.owner_info.father_husband_name_en }}</p></td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.applicant_mother_name') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.owner_info !== null">{{ currentLocale === 'bn' ? application.owner_info.mother_name_bn : application.owner_info.mother_name_en }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('detailsView.present_address_mobile') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.contact_info !== null && application.address !== null">{{ AddressHelper.getPresentAddress(application.address) }} <br> {{ application.contact_info.mobile_no | mobileNumber }}, {{ $n(application.contact_info.telephone_no, { useGrouping: false }) }} <br> {{ application.contact_info.email }} </td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('detailsView.permanent_address') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.address !== null">{{ AddressHelper.getPermanentAddress(application.address) }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.national_identification_number') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.owner_info !== null">
                                        {{ $n(application.owner_info.nid_no, { useGrouping: false }) }} <br>
                                        {{ $t('externalUser.issuing_country') + ' : ' + countryName(application.passport_info.country_id) }} <br>
                                        {{ $t('externalUser.issue_date') + ' : ' + application.passport_info.issue_date | dateFormat }} <br>
                                        {{ $t('externalUser.duration') + ' : ' + $n(application.passport_info.duration, { useGrouping: false }) }}
                                        </td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "3">{{  $t('detailsView.two') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.tin') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.tax_info !== null">{{ $n(application.tax_info.tin_no, { useGrouping: false }) }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td>{{ $t('detailsView.circule') }}</td>
                                    <td class="text-center">:</td>
                                    <td class="text-left" v-if="application.tax_info">{{ application.tax_info.tax_circle }}</td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <!-- <td></td> -->
                                    <td width="60%" class="text-left">{{ $t('detailsView.region') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.tax_info !== null">{{ currentLocale === 'bn' ? application.tax_info.tax_region_bn : application.tax_info.tax_region_en }}</td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "2">{{  $t('detailsView.three') }}</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_name_bn') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ application.org_info.org_name_bn }}</td>
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
                                        {{ $n(application.office_contact_info.telephone_no, { useGrouping: false }) + ', ' }}
                                        {{ application.office_contact_info.mobile_no | mobileNumber }} {{ ', ' }}
                                        {{ application.office_contact_info.fax_no !== null ? EngBangNum(application.office_contact_info.fax_no.toString()) : '' }}
                                        {{ application.office_contact_info.email }} </td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_company') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left"  v-if="application.factory_contact_info !== null">
                                        {{ application.factory_contact_info.telephone_no ? $n(application.factory_contact_info.telephone_no, { useGrouping: false }) : ''}} ,
                                        {{ application.factory_contact_info.mobile_no | mobileNumber }} {{ ', ' }}
                                        {{ application.factory_contact_info.fax_no !== '' ? EngBangNum(application.factory_contact_info.fax_no.toString()): '' }}
                                        {{ application.factory_contact_info.email }} </td>
                                    <td v-else></td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('detailsView.institute_contact_person') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left"  v-if="application.contact_person_info !== null">{{ currentLocale === 'en' ? application.contact_person_info.name_en : application.contact_person_info.name_bn + ', ' }} {{ currentLocale === 'bn' ? application.contact_person_info.designation_bn : application.contact_person_info.designation_en + ', ' }} {{ application.contact_person_info.mobile | mobileNumber }}</td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                        </table>
                         <!-- Female Enterpunor -->
                        <table class="table table-bordered table-hover">
                            <tbody v-if="application.entrepreneurs !== null">
                                <tr>
                                    <td width="5%" class="text-center" rowspan= "5">{{  $n(4) }})</td>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs') }} <br/> <span style="font-size:12px">{{ $t('etDetailsView.female_entrepreneurs_ex') }}</span></td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ currentLocale === 'bn' ? application.entrepreneurs.name_bn : application.entrepreneurs.name_en }}, {{ currentLocale === 'bn' ? application.entrepreneurs.designation_bn : application.entrepreneurs.designation_en }} </td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs_1') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ application.entrepreneurs.license }} </td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs_2') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ application.entrepreneurs.license_no }}</td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs_3') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ parseInt(application.entrepreneurs.directly_involced_business) === 1 && application.passport_info !== null ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }}</td>
                                </tr>
                                <tr>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs_4') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ getProductServiceList(application.entrepreneurs.product_service_name_details) }}</td>
                                </tr>
                            </tbody>
                            <tbody v-else>
                                <tr>
                                    <td width="5%" class="text-center">{{  $n(4) }})</td>
                                    <td width="60%" class="text-left">{{ $t('etDetailsView.female_entrepreneurs') }} <br/> <span style="font-size:12px">{{ $t('etDetailsView.female_entrepreneurs_ex') }}</span></td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left">{{ (currentLocale === 'en' ? 'No' : 'না') }} </td>
                                </tr>
                            </tbody>
                        </table>
                          <!--EPZ Company-->
                        <table class="table table-bordered table-hover">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(5) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.epz_company') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-left" v-if="application.org_info !== null">{{ parseInt(application.org_info.bangladeshi_owned_company) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }}</td>
                                    <td v-else></td>
                                </tr>
                            </tbody>
                        </table>
                        <!--bank information-->
                        <table class="table table-bordered table-hover" v-if="application.bank.length > 0">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(6) }})</td>
                                    <td width="35%" class="text-left">{{ $t('detailsView.application_institute_bank_name') }}</td>
                                    <td width="60%" class="text-left">
                                        <span v-for="(item, index1) in application.bank" :key="index1">
                                            {{ $n(index1 + 1) + ' ) ' }}
                                            {{ currentLocale === 'bn' ? item.bank_name_bn : item.bank_name_en }}, {{ currentLocale === 'bn' ? item.branch_name_bn : item.branch_name_en }},
                                            {{ currentLocale === 'bn' ? item.address_bn : item.address_en }}<br/>
                                        </span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- Export Application Description-->
                        <table class="table table-bordered table-hover">
                            <tbody v-if="application.product_success_description !== null">
                                <tr> <td>{{ $n (7) }})</td><td colSpan="5" class="text-left"> {{ $t('detailsView.export_product_details') }} </td></tr>
                                <tr>
                                    <td class="text-center">{{ $t('detailsView.exported_name')}}</td>
                                    <td class="text-left">{{ $t('detailsView.fiscal_year_name') }}</td>
                                    <td class="text-center">{{ $t('detailsView.export_volumes')}}</td>
                                    <td class="text-center">{{ $t('detailsView.export_earning_millions')}}</td>
                                    <td class="text-center">{{ $t('detailsView.previous_fiscal_year')}}</td>
                                    <td class="text-center">{{ $t('detailsView.destination')}}</td>
                                </tr>
                                <template v-if="application.product_success_description.length">
                                    <tr v-for="(item, index3) in application.product_success_description" :key="index3">
                                        <td class="text-center">{{ productName(item.product_id) }}</td>
                                        <td class="text-center">{{ fiscalYearName(item.fiscal_year_id) }}</td>
                                        <td class="text-center">{{ item.export_volume }}</td>
                                        <td class="text-center">{{ $n(item.export_value_ssd, { useGrouping: false }) }}  {{ $t('etDetailsView.million')}}</td>
                                        <td class="text-center">{{ $n(item.income_growth) }} %</td>
                                        <td class="text-center">{{ getDesingationData(item.destination_id) }}</td>
                                    </tr>
                                </template>
                                <tr>
                                    <td width="60%" class="text-left" colspan="6">{{ $t('detailsView.extra_text_four') }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(8)}})</td>
                                    <td width="95%" class="text-left">{{ getPreviousFiscalYear(application.circular.year)}} {{ $t('etDetailsView.compliance_given') }} <b> {{ parseInt(application.other_compliance.merchandising_sector) === 1 ? (currentLocale === 'en' ? 'Textile Factory' : 'টেক্সটাইল ফ্যাক্টরি') : (currentLocale === 'en' ? 'Others' : 'অন্যান্য') }} </b></td>
                                </tr>
                                <tr>
                                    <td class="text-left" colSpan="2">{{ $t('etDetailsView.compliance_given_ex') }} <a v-if="application.other_compliance.report" class="btn btn-success btn-sm rounded-pill" target="_blank" :href="baseUrl + 'download-attachment?file=' + application.other_compliance.report" title="attachment"><i class="ri-download-cloud-fill"></i></a></td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(9)}})</td>
                                    <td width="95%" class="text-left">{{ getPreviousFiscalYear(application.circular.year)}} {{ $t('etDetailsView.new_destination') }} <b> {{ parseInt(application.other_compliance.export_destination_add) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }} </b></td>
                                </tr>
                                <tr>
                                    <td class="text-left" colSpan="2">{{ $t('etDetailsView.new_destination_ex') }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td>{{ $t('etDetailsView.country_org_name') }}</td>
                                    <td>{{ $t('etDetailsView.prc_no_date') }}</td>
                                    <td>{{ $t('etDetailsView.export_income_fob_mmd') }}</td>
                                    <td>{{ $t('etDetailsView.relization_date') }}</td>
                                </tr>
                                <template v-if="parseInt(application.other_compliance.export_destination_add) === 1">
                                <tr v-for="(item, index) in application.export_destination" :key="index">
                                    <td class="text-left">{{ countryName(item.country_id) }}, {{ currentLocale === 'en' ? item.buyer_org_name_en : item.buyer_org_name_bn }}</td>
                                    <td class="text-left">{{ $n(item.prc_no, { useGrouping: false }) }}, {{ item.prc_date | dateFormat }}</td>
                                    <td class="text-left">{{ $n(item.export_value_usd, { useGrouping: false }) }}</td>
                                    <td class="text-left">{{ item.realization_date | dateFormat }}</td>
                                </tr>
                                </template>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(10)}})</td>
                                    <td width="95%" class="text-left">{{ getPreviousFiscalYear(application.circular.year)}} {{ $t('etDetailsView.new_product') }} <b> {{ parseInt(application.other_compliance.export_products_add) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }} </b></td>
                                </tr>
                                <tr>
                                    <td class="text-left" colSpan="2">{{ $t('etDetailsView.new_product_ex') }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td>{{ $t('externalUser.product_name') }}</td>
                                    <td>{{ $t('etDetailsView.hs_code') }}</td>
                                    <td>{{ $t('etDetailsView.prc_no_date') }}</td>
                                    <td>{{ $t('etDetailsView.export_income_fob_mmd') }}</td>
                                    <td>{{ $t('etDetailsView.relization_date') }}</td>
                                </tr>
                                <template v-if="parseInt(application.other_compliance.export_products_add) === 1">
                                <tr v-for="(item, index) in application.export_product" :key="index">
                                    <td class="text-left">{{ productName(item.product_id) }}</td>
                                    <td class="text-left">{{ item.hs_code }}</td>
                                    <td class="text-left">{{ $n(item.prc_no, { useGrouping: false }) }}, {{ item.prc_date | dateFormat }}</td>
                                    <td class="text-left">{{ $n(item.export_value_usd, { useGrouping: false }) }}</td>
                                    <td class="text-left">{{ item.realization_date | dateFormat }}</td>
                                </tr>
                                </template>
                            </tbody>
                        </table>
                          <!-- 2020-2021 fiscal Year-->
                        <table class="table table-bordered table-hover" v-if="application.other_compliance !== null">
                            <tbody>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(11) }})</td>
                                    <td width="60%" class="text-left" colspan="3"> {{ getPreviousFiscalYear(application.circular.year)}}
                                        {{ $t('detailsView.extra_text_ten') }} : <b>{{ parseInt(application.other_compliance.dispute_settled) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }} </b>
                                        {{ $t('detailsView.extra_test_fourtheen')}}
                                        <span v-if="parseInt(application.other_compliance.dispute_settled) === 1">
                                            <a v-if="application.other_compliance.dispute_settled_document" class="btn btn-success btn-sm rounded-pill" target="_blank" :href="baseUrl + 'download-attachment?file=' + application.other_compliance.dispute_settled_document" title="attachment"><i class="ri-download-cloud-fill"></i></a>
                                        </span>
                                    </td>
                                </tr>
                                <tr v-if="parseInt(application.other_compliance.applicant_selected_et_past_year) === 1">
                                    <td width="5%" class="text-center">{{ $n(12) }})</td>
                                    <td width="60%" class="text-left" colspan="3">
                                        {{ $t('detailsView.extra_text_eleven')}} <b> {{ parseInt(application.other_compliance.applicant_selected_et_past_year) === 1 ? (currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (currentLocale === 'en' ? 'No' : 'না') }} </b><br/>
                                        <span v-for="(item, index5) in application.et_selected" :key="index5">
                                            <span v-if="parseInt(application.other_compliance.applicant_selected_et_past_year) === 1">
                                                {{ $n(index5 + 1) + ' ) ' }}
                                                {{ $n(item.selection_year, { useGrouping: false }) }},
                                                {{ productName(item.product_sector_id) }}<br/>
                                            </span>
                                        </span>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $n(13) }})</td>
                                    <td width="60%" class="text-left">{{ $t('detailsView.others_info') }}</td>
                                    <td width="5%" class="text-center">:</td>
                                    <td width="30%" class="text-center">{{ application.other_compliance.other_information }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!-- Attachment -->
                        <table class="table table-bordered table-hover">
                            <tbody v-if="application.attachment_all_doc !== null">
                                <tr>
                                    <td rowspan="9" width="5%">{{ $n (14) }})</td>
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
                        <p class="font-weight-bold text-left">{{ $t('detailsView.application_rules') }}</p>
                        <table class="table table-bordered table-hover" v-if="application.circular.year">
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
                                    <td width="90%" class="text-left">{{ $t('etDetailsView.rules_four') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.five') }}</td>
                                    <td width="90%" class="text-left">{{ $t('etDetailsView.rules_five') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.six') }}</td>
                                    <td width="90%" class="text-left">{{ $t('etDetailsView.rules_six') }}</td>
                                </tr>
                                <tr>
                                    <td width="5%" class="text-center">{{ $t('detailsView.seven') }}</td>
                                    <td width="90%" class="text-left">{{ $t('etDetailsView.rules_seven') }}</td>
                                </tr>
                            </tbody>
                        </table>
                        <!--End Text Extra-->
                        <h5 class="header text-left">{{ $t('detailsView.end_extra_text')}}</h5>
                        <p> {{ $t('globalTrans.date')}} : <b style="border-bottom:1px dotted #000">{{ application.updated_at | dateFormat }}</b></p>
                        <b-col sm="12">
                            <b-row>
                                <b-col sm="4" offset="8" class="text-center">
                                    <p> {{ $t('etDetailsView.signature_txt')}} </p>
                                    <p> {{ $t('etDetailsView.signature_txt_ex')}} </p>
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
            <b-button variant="danger" class="btn-sm mt-2" @click="$bvModal.hide('modal-detail')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
    </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import NoImage from '../../../../../../assets/images/user/no-image.jpg'
import { etApplicationDetailsApi } from '../../api/routes'
import { mapGetters } from 'vuex'
import AddressHelper from '@/utils/area-type-address'
import ExportPdf from './export-pdf'
import moment from 'moment'
// import ListReportHead from '@/components/custom/CipExportTrophyReportHead.vue'

export default {
    props: ['id'],
    components: {
    },
    data () {
        return {
            AddressHelper: AddressHelper,
            baseUrl: exportTrophyCIPServiceBaseUrl,
            preview: NoImage,
            dataLoad: false,
            orgLogo: '',
            application: {},
            org_address: {},
            exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
        }
    },
    created () {
        if (this.id) {
            this.getEtData()
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
            const fiscalYear = secondYear + '-' + firstYear // 2020-2021
            return this.EngBangNum(fiscalYear.toString())
        },
        getPreviousFiscalYearFirst (year) {
            const firstYear = parseInt(year) - 2 // 2020
            const secondYear = firstYear - 1 // 2019
            const fiscalYear = secondYear + '-' + firstYear
            return this.EngBangNum(fiscalYear.toString())
        },
        merchandisingSectorName (Id) {
          const Obj = this.$store.state.ExternalUserService.cipPanel.merchandisingTypeList.find(item => item.value === Id)
          if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
          } else {
            return ''
          }
        },
        productName (Id) {
          const Obj = this.$store.state.ExternalUserService.cipPanel.commonObj.exportSectorList.find(item => item.value === Id)
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
            const Obj = this.$store.state.ExternalUserService.cipPanel.orgTypeList.find(el => el.value === Id)
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
            const Obj = this.$store.state.ExternalUserService.cipPanel.latentExporterList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        getAppType (Id) {
            const Obj = this.$store.state.ExternalUserService.cipPanel.cipAppTypeList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
            }
        },
        async getEtData () {
            const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, etApplicationDetailsApi, { app_id: this.id })
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
        getProductServiceList (items) {
            const obj = []
            items.forEach(element => {
                if (this.currentLocale === 'bn') {
                    obj.push(element.name_bn)
                } else {
                    obj.push(element.name_en)
                }
            })
            return obj.join()
        },
        getDesingationData (val) {
            const data = val.substring(1, val.length - 1).split(',')
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
