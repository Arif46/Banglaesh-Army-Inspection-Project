<template>
    <div class="inner-section">
        <b-row>
            <b-col xs="12" sm="12" md="12" class="text-right mb-2">
                <b-button @click="pdfExport()" class="btn-sm" variant="primary">{{  $t('globalTrans.export_pdf') }}</b-button>
            </b-col>
        </b-row>
        <body-card>
            <b-row>
                <b-col sm="12">
                    <p class="text-center"> <b style="border-bottom: 1px solid #000"> {{ $t('cip.enquiry_form_one') }} </b> </p>
                    <p class="text-center"> {{ $t('cip.for_individual') }} </p>
                </b-col>
            </b-row>
            <b-row>
                <b-col sm="12">
                    <p class="p-2"> <b style="border-bottom: 1px solid #000"> {{ $t('cip.individual') }} </b> </p>
                </b-col>
            </b-row>
            <b-row>
                <b-col md="5">
                    <div class="p-2">
                        <table width="100%">
                            <tr>
                                <th> {{ $n(1)}}.{{ $t('cip.title') }} </th>
                            </tr>
                            <tr>
                                <td> {{ currentLocale === 'bn' ? item.owner_info.designation_bn : item.owner_info.designation_en }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(2)}}.{{ $t('cip.father_title') }} </th>
                            </tr>
                            <tr>
                                <td> {{ (item.owner_info.father_title_en !== '' || item.owner_info.father_title_bn !== '') ? (item.owner_info.father_title_en !== null || item.owner_info.father_title_bn !== null) ? currentLocale === 'bn' ? item.owner_info.father_title_bn : item.owner_info.father_title_en : 'N/A' : 'N/A' }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(3)}}.{{ $t('cip.mother_title') }} </th>
                            </tr>
                            <tr>
                                <td> {{ (item.owner_info.mother_title_en !== '' || item.owner_info.mother_title_bn !== '') ? (item.owner_info.mother_title_en !== null || item.owner_info.mother_title_bn !== null) ? currentLocale === 'bn' ? item.owner_info.mother_title_bn : item.owner_info.mother_title_en : 'N/A'  : 'N/A' }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(4)}}.{{ $t('cip.husband_title') }} </th>
                            </tr>
                            <tr>
                                <td> {{ item.owner_info.husband_title_en !== '' || item.owner_info.husband_title_bn !== '' ? (item.owner_info.husband_title_en !== null || item.owner_info.husband_title_bn !== null) ? currentLocale === 'bn' ? item.owner_info.husband_title_bn : item.owner_info.husband_title_en : 'N/A' : 'N/A'}} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(5)}}.{{ $t('cip.nid_number') }} </th>
                            </tr>
                            <tr>
                                <td> {{ EngBangNum(item.owner_info.nid_no) }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(7)}}.{{ $t('cip.date_of_birth') }} </th>
                            </tr>
                            <tr>
                                <td> {{ $d(new Date(item.owner_info.dob)) }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(9)}}.{{ $t('cip.district_of_birth') }} </th>
                            </tr>
                            <tr>
                                <td> {{ item.owner_info.district_of_birth !== '' ? item.owner_info.district_of_birth : 'N/A'}} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
                <b-col md="7">
                    <div class="p-2">
                        <table width="100%">
                            <tr>
                                <th> {{ $t('cip.name') }} </th>
                            </tr>
                            <tr>
                                <td> {{ currentLocale === 'bn' ? item.owner_info.owner_name_bn : item.owner_info.owner_name_en }} </td>
                            </tr>
                            <tr>
                                <th> {{ $t('cip.father_name') }} </th>
                            </tr>
                            <tr>
                                <td> {{ currentLocale === 'bn' ? item.owner_info.father_husband_name_bn : item.owner_info.father_husband_name_en }} </td>
                            </tr>
                            <tr>
                                <th> {{ $t('cip.mother_name') }} </th>
                            </tr>
                            <tr>
                                <td> {{ currentLocale === 'bn' ? item.owner_info.mother_name_bn : item.owner_info.mother_name_en }} </td>
                            </tr>
                            <tr>
                                <th> {{ $t('cip.husband_name') }} </th>
                            </tr>
                            <tr>
                                <td> {{ (item.owner_info.husband_name_en !== '' || item.owner_info.husband_name_bn !== '') ? (item.owner_info.husband_name_en !== null || item.owner_info.husband_name_bn !== null) ? currentLocale === 'bn' ? item.owner_info.husband_name_bn : item.owner_info.husband_name_en : 'N/A' : 'N/A'}} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(6) }}.{{ $t('cip.tin') }} </th>
                            </tr>
                            <tr>
                                <td> {{ EngBangNum(item.org_tax_info.tin_no) }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(8) }}.{{ $t('globalTrans.gender') }} </th>
                            </tr>
                            <tr>
                                <td> {{ item.owner_info.gender ? genderName(item.owner_info.gender) : 'N/A' }} </td>
                            </tr>
                            <tr>
                                <th> {{ $n(10) }}.{{ $t('cip.country_of_birth') }} </th>
                            </tr>
                            <tr>
                                <td> {{ item.owner_info.country_of_birth !== '' ? item.owner_info.country_of_birth : 'N/A' }} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Permanent Address -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <p> <b style="border-bottom: 1px solid #000"> {{ $t('cip.main_per_address')}}: </b> </p>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(11) }}.{{ $t('cip.street_no_name_vill_ps_up')}} </th>
                            </tr>
                            <tr>
                                <td> {{  currentLocale === 'bn' ? (item.address.pm_address_details_bn ? item.address.pm_address_details_bn : 'N/A') :  (item.address.pm_address_details_en ? item.address.pm_address_details_en : 'N/A') }} </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pl-2 pr-2 pb-2">
                        <table width="100%">
                            <tr>
                                <th> {{ $t('globalTrans.district')}} </th>
                                <th> {{ $t('cip.postal_code')}} </th>
                                <th> {{ $t('globalTrans.country')}} </th>
                            </tr>
                            <tr>
                                <td> {{ getDistrictName(item.address.pm_district_id) }}</td>
                                <td> {{ EngBangNum(item.address.pm_postal_code) }}</td>
                                <td> {{ countryName(item.address.pm_country_id) }}</td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Present Address -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <p> <b style="border-bottom: 1px solid #000"> {{ $t('cip.additional_pre_address') }}: </b> </p>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(12) }}.{{ $t('cip.street_no_name_vill_ps_up')}} </th>
                            </tr>
                            <tr>
                                <td> {{  currentLocale === 'bn' ? (item.address.pr_address_details_bn ? item.address.pr_address_details_bn : 'N/A') :  (item.address.pr_address_details_en ? item.address.pr_address_details_en : 'N/A') }} </td>
                            </tr>
                        </table>
                    </div>
                    <div class="pl-2 pr-2 pb-2">
                        <table width="100%">
                            <tr>
                                <th> {{ $t('globalTrans.district')}} </th>
                                <th> {{ $t('cip.postal_code')}} </th>
                                <th> {{ $t('globalTrans.country')}} </th>
                            </tr>
                            <tr>
                                <td> {{ getDistrictName(item.address.pr_district_id) }}</td>
                                <td> {{ EngBangNum(item.address.pr_postal_code) }}</td>
                                <td> {{ countryName(item.address.pr_country_id) }}</td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Identification -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <p> <b style="border-bottom: 1px solid #000"> {{ $t('cip.identification_document_data') }}: </b> </p>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(13)}}.{{ $t('cip.id_type') }} </th>
                            </tr>
                            <tr>
                                <td> {{ EngBangNum(item.passport_info.passport_no) }} </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <th width="50%"> {{ $t('cip.issue_date') }}</th>
                                <th width="50%"> {{ $t('cip.issue_country') }} </th>
                            </tr>
                            <tr>
                                <td> {{ $d(new Date(item.passport_info.issue_date)) }} </td>
                                <td> {{ countryName(item.passport_info.country_id) }} </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(14)}}.{{ $t('externalUser.telephone_no') }} </th>
                            </tr>
                            <tr>
                                <td> {{ EngBangNum(item.office_contact_info.telephone_no) }} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
        </body-card>
        <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm mt-2" @click="$bvModal.hide('enquiry-form-one')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
import AddressHelper from '@/utils/area-type-address'
import ExportPdf from './enquiry-form-onepdf'

export default {
    props: ['item'],
    components: {},
    data () {
        return {
            AddressHelper: AddressHelper
        }
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
        getFatherTitle (item) {
            if (this.currentLocale === 'bn') {
                return item.owner_info.father_title_bn !== null ? item.owner_info.father_title_bn : 'N/A'
            } else {
                return item.owner_info.father_title_en !== null ? item.owner_info.father_title_en : 'N/A'
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
        EngBangNum (n) {
            if (this.$i18n.locale === 'bn') {
                return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
            } else {
                return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
            }
        },
        getDistrictName (id) {
            if (id) {
                const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
                if (this.$i18n.locale === 'bn') {
                    return obj.text_bn
                } else {
                    return obj.text_en
                }
            }
        },
        pdfExport () {
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
    td {
        border: 1px solid;
        padding: 2px;
    }
</style>
