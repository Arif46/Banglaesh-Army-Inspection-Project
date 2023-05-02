<template>
    <b-overlay :show="loadingState">
    <div class="form-wrapper tea-garden-profile-wrapper">
        <b-row>
            <b-col lg="12" sm="12">
                <body-card>
                    <template v-slot:body>
                        <b-row>
                            <b-col lg="12" sm="12">
                                <template>
                                    <div class="mb-2 d-flex justify-content-end"><b-button variant="primary" @click="pdfExport" size="sm"><i class="ri-printer-fill text-right"></i>{{
                                    $t('teaGardenConfig.ExportPDF') }} </b-button></div>
                                </template>
                                <template>
                                    <div
                                        style="font-size:12px; font-color:white; background-color: #dddddd; padding:6px">
                                        <h5 class="card-title text-center"
                                            style="margin-bottom: 0;color: #214162;font-size: 1.40rem;"> {{
                                            $t('teaGardenConfig.Worker_Details') }} {{ $t('globalTrans.details') }}</h5>
                                    </div>
                                </template>
                                <table v-if="detailsData.id" class="table table-borderless">
                                    <tr>
                                        <th style="width: 25%">{{$t('teaGardenConfig.garden_name')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ getTeaGardenName(detailsData.garden_id) }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%">{{$t('teaGardenConfig.pf_id')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ EngBangNum(detailsData.pf_id) }}</td>
                                    </tr>
                                     <tr>
                                        <th style="width: 25%"> {{$t('teaGardenConfig.worker_name')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ ($i18n.locale === 'bn') ? detailsData.worker_name_bn : detailsData.worker_name_en }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%"> {{$t('teaGardenConfig.designation')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ ($i18n.locale === 'bn') ? detailsData.designation_bn : detailsData.designation_en
                                        }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%"> {{$t('teaGardenConfig.father_name')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ ($i18n.locale === 'bn') ? detailsData.father_name_bn : detailsData.father_name_en}}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%">{{$t('teaGardenConfig.gender')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ getGenderName(detailsData.gender) }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%">{{$t('teaGardenConfig.nid')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ EngBangNum(detailsData.nid) }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%">{{$t('teaGardenConfig.mobile')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ EngBangNum(detailsData.mobile) }}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%"> {{$t('teaGardenConfig.address')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ ($i18n.locale === 'bn') ? detailsData.address_bn : detailsData.address_en}}</td>
                                    </tr>
                                    <tr>
                                        <th style="width: 25%"> {{$t('teaGardenConfig.worker_type')}}</th>
                                        <th style="width: 2%">:</th>
                                        <td style="width: 70%">{{ ($i18n.locale === 'bn') ? detailsData.worker_type_bn : detailsData.worker_type_en}}</td>
                                    </tr>
                                </table>
                            </b-col>
                        </b-row>
                    </template>
                </body-card>
            </b-col>
        </b-row>
    </div>
    </b-overlay>
</template>
<script>
import ExportPdf from './export_pdf'
import { teaGardenServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'Details',
    props: ['id'],
    data () {
        return {
            teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
            valid: null,
            loading: false,
            errors: [],
            detailsData: {}
        }
    },
    created () {
        if (this.id) {
            const tmp = this.getworkerInformation()
            this.detailsData = tmp
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        EngBangNum (n) {
            if (this.$i18n.locale === 'bn') {
                return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
            } else {
                return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
            }
        },
        getGenderName (id) {
            const Gender = this.$store.state.TeaGardenService.commonObj.gender.find(el => el.value === parseInt(id))
            if (Gender !== undefined) {
                return this.$i18n.locale === 'en' ? Gender.text_en : Gender.text_bn
            }
        },
        getDesignation (id) {
            const designation = this.$store.state.TeaGardenService.commonObj.masterDesignationList.find(item => item.value === id)
            if (designation && this.$i18n.locale === 'bn') {
                return designation.text_bn
            } else if (designation && this.$i18n.locale === 'en') {
                return designation.text_en
            }
        },
        getworkerInformation () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        pdfExport () {
            const reportTitle = this.$t('teaGardenConfig.worker_informations')
            ExportPdf.exportPdfDetails(reportTitle, this)
        },
        getTeaGardenName (id) {
        const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            if (gardenInfo && this.$i18n.locale === 'bn') {
                return gardenInfo.text_bn
            } else if (gardenInfo && this.$i18n.locale === 'en') {
                return gardenInfo.text_en
            }
        }
    }
}
</script>
