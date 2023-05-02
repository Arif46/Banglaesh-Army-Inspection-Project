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
                    <p class="text-center"> <b style="border-bottom: 1px solid #000"> {{ $t('cip.enquiry_form_two') }} </b> </p>
                    <p class="text-center"> {{ $t('cip.enquiry_form_two_headding') }} </p>
                </b-col>
            </b-row>
            <b-row>
                <b-col sm="12">
                    <p class="p-2"> <b style="border-bottom: 1px solid #000"> {{ $t('cip.compnay_data') }} </b> </p>
                </b-col>
            </b-row>
            <b-row>
                <b-col md="5">
                    <div class="p-2">
                        <table width="100%">
                            <tr>
                                <th class="thStyle"> {{ $n(1)}}.{{ $t('cip.title') }} </th>
                            </tr>
                            <tr>
                                <td> {{ 'N/A' }} </td>
                            </tr>
                            <tr>
                                <th class="thStyle"> {{ $n(2)}}.{{ $t('cip.legal_form') }} </th>
                            </tr>
                            <tr>
                                <td> {{ item.org_info.legal_form !== '' ? item.org_info.legal_form : 'N/A' }} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
                <b-col md="7">
                    <div class="p-2">
                        <table width="100%">
                            <tr>
                                <th class="thStyle"> {{ $t('cip.trade_name') }} </th>
                            </tr>
                            <tr>
                                <td> {{ currentLocale === 'bn' ? item.org_info.org_name_bn : item.org_info.org_name_en }} </td>
                            </tr>
                            <tr>
                                <th class="thStyle">  {{ $n(3)}}.{{ $t('cip.tin') }} </th>
                            </tr>
                            <tr>
                                <td> {{ $n(item.tax_info.tin_no, { useGrouping: false }) }} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Permanent Address -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <p> <b style="border-bottom: 1px solid #000"> {{ $t('cip.com_main_per_address')}}: </b> </p>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(4) }}.{{ $t('cip.street_no_name_vill_ps_up')}} </th>
                            </tr>
                            <tr>
                                <td> {{ item.org_address.address_details_bn !== '' || item.org_address.address_details_en !== '' ? item.org_address.address_details_bn !== null || item.org_address.address_details_en !== null ? currentLocale === 'bn' ? item.org_address.address_details_bn : item.org_address.address_details_en : 'N/A' : 'N/A' }} </td>
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
                                <td> {{ item.org_address.district_id ? getDistrictName(item.org_address.district_id) : 'N/A'}}</td>
                                <td> {{ item.org_address.post_code ? $n(parseInt(item.org_address.post_code), { useGrouping: false }) : 'N/A' }}</td>
                                <td> {{ item.org_address.country_id ? countryName(item.org_address.country_id) : 'N/A' }}</td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Additonal Address -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <p> <b style="border-bottom: 1px solid #000"> {{ $t('cip.add_bussness_address') }}: </b> </p>
                        <table width="100%">
                            <tr>
                                <th> {{ $n(5) }}.{{ $t('cip.street_no_name_vill_ps_up')}} </th>
                            </tr>
                            <tr>
                                <td v-if="item.additional_org_address !== null"> {{ item.additional_org_address.address_details_bn !== null || item.additional_org_address.address_details_en !== null ? currentLocale === 'bn' ? item.additional_org_address.address_details_bn !== '' || item.additional_org_address.address_details_en !== '' ? item.additional_org_address.address_details_bn : item.additional_org_address.address_details_en : 'N/A' : 'N/A' }} </td>
                                <td v-else> {{ 'N/A' }} </td>
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
                                <td> {{ item.additional_org_address !== null ? getDistrictName(item.additional_org_address.district_id) : 'N/A' }}</td>
                                <td> {{ item.additional_org_address && item.additional_org_address.postal_code ? $n(item.additional_org_address.postal_code, { useGrouping: false }) : 'N/A' }}</td>
                                <td> {{ item.additional_org_address !== null ? countryName(item.additional_org_address.country_id) : 'N/A' }}</td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
            <!-- Identification -->
            <b-row>
                <b-col sm="12">
                    <div class="p-2">
                        <table width="100%">
                            <tr>
                                <th> {{ $n(6)}}.{{ $t('externalUser.telephone_no') }} </th>
                            </tr>
                            <tr>
                                <td> {{ $n(item.contact_info.telephone_no, { useGrouping: false }) }} </td>
                            </tr>
                        </table>
                    </div>
                </b-col>
            </b-row>
        </body-card>
        <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm mt-2" @click="$bvModal.hide('enquiry-form-two')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
    </div>
</template>
<script>
import { mapGetters } from 'vuex'
import AddressHelper from '@/utils/area-type-address'
import ExportPdf from './enquiry-form-twopdf'

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
        countryName (Id) {
            const Obj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === Id)
            if (typeof Obj !== 'undefined') {
                return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
            } else {
                return ''
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
    .thStyle {
        border:1px solid #000; padding-left: 3px;
    }
</style>
