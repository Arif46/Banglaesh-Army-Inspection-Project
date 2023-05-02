<template>
    <div size="A4" class="page">
        <div v-if="loading">
            <Loading />
        </div>
        <!-- <b-overlay :show="loading"> -->
        <template v-else>
            <div class="text-right">
            <b-button @click="pdfExport" variant="primary" class="mb-3" size="sm">
            <i class="ri-printer-fill"></i>
            {{ $t('teaGardenConfig.Print') }}
        </b-button>
        </div>
        <div style="border: 1px double #222; padding: 1rem; height: 100%">
            <TeaGardenReportHead :baseUrl="teaGardenServiceBaseUrl" :uri="'/configuration/report-heading/detail'" :orgId="5" :loadingState="false">
                {{ $t('teaGardenPanel.tea_factory_service') + ' ' + $t('globalTrans.certificate') }}
            </TeaGardenReportHead>
            <table class="report-info">
                <tbody>
                    <tr>
                        <td>{{ $t('teaGardenConfig.registration_no') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td v-if="application.application.registration_no">{{ application.application.registration_no }}</td>
                    </tr>
                    <tr v-if="application.factory_type_id === 1 && application.garden_id">
                        <td>{{ $t('teaGardenConfig.garden_name') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getGardenName(application.garden_id) }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('teaGardenPanel.factory_name') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ currentLocale === 'en' ? application.factory_info.factory_name_en : application.factory_info.factory_name_bn }}</td>
                    </tr>
                    <tr>
                        <td><strong>{{ $t('teaGardenService.factory_address_label') }}</strong></td>
                    </tr>
                    <tr>
                        <td>{{ $t('globalTrans.division') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getDivisionName(application.factory_info.division_id) }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('globalTrans.district') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getDistrictName(application.factory_info.district_id) }}</td>
                    </tr>
                    <tr v-if="application.factory_info.city_corporation_id && application.factory_info.city_corporation_id !== 0">
                        <td>{{ $t('globalTrans.city_corporation') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getCityCorporationName(application.factory_info.city_corporation_id) }}</td>
                    </tr>
                    <tr v-if="application.factory_info.upazila_id && application.factory_info.upazila_id !== 0">
                        <td>{{ $t('globalTrans.upazila') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getUpzillaName(application.factory_info.upazila_id) }}</td>
                    </tr>
                    <tr v-if="application.factory_info.paurashoba_id && application.factory_info.paurashoba_id !== 0">
                        <td>{{ $t('globalTrans.municipality_name') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getPauroshobaName(application.factory_info.paurashoba_id) }}</td>
                    </tr>
                    <tr v-if="application.factory_info.union_id && application.factory_info.union_id !== 0">
                        <td>{{ $t('globalTrans.union') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ getUnionName(application.factory_info.union_id) }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('teaGardenPanel.address') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ currentLocale === 'en' ? application.factory_info.address_en : application.factory_info.address_bn }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('teaGardenService.factory_total_land') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ $n(application.factory_info.total_land_factory_established) }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('teaGardenService.issue_date') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ application.application.issue_date | dateFormat }}</td>
                    </tr>
                    <tr>
                        <td>{{ $t('teaGardenService.expire_date') }}</td>
                        <td>&emsp;:&nbsp;</td>
                        <td>{{ application.application.expired_date | dateFormat }}</td>
                    </tr>
                </tbody>
            </table>
            <slot v-if="application.application.service_instruction">
                <strong style="margin-top:2rem; display: block;">{{ $t('teaGardenPanel.conditions') }}</strong>
                <div class="text-justify" v-html="currentLocale === 'en' ? application.application.service_instruction.instruction_en : application.application.service_instruction.instruction_bn"></div>
            </slot>
            <table style="width:100%; margin-top: 5rem;">
                <tbody>
                    <tr>
                        <td style="width:33.33%">
                            <!-- <img src="../../../../../assets/images/qr.jpg" width="100px" alt=""> -->
                            <vue-qrcode :value="getQrCodeContent()" :width="120"/>
                        </td>
                        <td style="width:33.33%"></td>
                        <td>
                            <div>
                                <img v-if="application.application.document_signatory && signatory_user_info.signature && application.application.document_signatory.show_signature" :src="authServiceBaseUrl + 'storage/' + signatory_user_info.signature" width="100px" alt="">
                                <img v-else-if="approve_user_info.signature" :src="authServiceBaseUrl + 'storage/' + approve_user_info.signature" width="100px" alt="">
                                <p v-if="application.application.document_signatory || application.application.approver_name_en">{{ $t('globalTrans.name') }}:
                                    <span v-if="application.application.document_signatory && application.application.document_signatory.name_en && application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.text_en : signatory_user_info.text_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.text_en : approve_user_info.text_bn }}</span>
                                </p>
                                <p v-if="application.application.document_signatory || application.application.approver_designation_en">{{ $t('globalTrans.designation') }}:
                                    <span v-if="application.application.document_signatory && application.application.document_signatory.designation_en && application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.designation_en : signatory_user_info.designation_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.designation_en : approve_user_info.designation_bn }}</span>
                                </p>
                                <p v-if="application.application.document_signatory && application.application.document_signatory.email">{{ $t('globalTrans.email') }}:
                                    <span v-if="application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ signatory_user_info.email }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ approve_user_info.email }}</span>
                                </p>
                                <p v-if="application.application.document_signatory && application.application.document_signatory.mobile">{{ $t('globalTrans.mobile') }}:
                                    <span v-if="application.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(signatory_user_info.mobile) }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(approve_user_info.mobile) }}</span>
                                </p>
                                <p>{{ $t('globalTrans.date') }} <span
                                        style="text-decoration-style: dotted; text-decoration-line: underline;">{{ application.application.approved_date | dateFormat }}</span>
                                </p>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="text-left mt-3">
            <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
        </div>
        </template>
        <!-- </b-overlay> -->
    </div>
</template>
<script>
import TeaGardenReportHead from '@/components/custom/TeaGardenReportHead'
import Loading from './../loading/Details.vue'
import RestApi, { teaGardenServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { factoryInfoDetailsApi, TeaFactoryViewPdf, AuthUserInfo } from '../../api/routes'
import VueQrcode from 'vue-qrcode'
import { mapGetters } from 'vuex'
export default {
  name: 'Certificate',
  components: {
    Loading,
    TeaGardenReportHead,
    VueQrcode
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      authServiceBaseUrl: authServiceBaseUrl,
      application: {},
      approve_user_info: {},
      signatory_user_info: {}
    }
  },
  created () {
     this.getAppDetail()
  },
  computed: {
    ...mapGetters({
       authUser: 'Auth/authUser'
    }),
    appId () {
      return this.$route.params.id
    },
    currentLocale () {
        return this.$i18n.locale
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    back () {
      this.$router.go(-1)
    },
    async getAppDetail () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, factoryInfoDetailsApi, { app_id: this.$route.params.id })
        if (result.success) {
          this.application = result.data
           // document signatory load
           if (this.application.application.document_signatory && this.application.application.document_signatory.user_id) {
                this.getSignatoryUserInfo(this.application.application.document_signatory.user_id)
            }
            if (this.application.application.approver_id) {
                this.getApproveUserInfo(this.application.application.approver_id)
            }
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
            return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
            return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    getOrgName (id) {
        const org = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === id)
        if (org && this.$i18n.locale === 'bn') {
            return org.text_bn
        } else if (org && this.$i18n.locale === 'en') {
            return org.text_en
        }
    },
    async pdfExport () {
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 5, app_id: this.appId, show_certificate: 1 })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, TeaFactoryViewPdf, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getQrCodeContent () {
        let content
        if (this.currentLocale === 'en') {
            content = this.$t('teaGardenService.application_id', 'en') + ' : ' + this.application.application.app_id + ',' + this.$t('teaGardenPanel.factory_name', 'en') + ' : ' + this.application.factory_info.factory_name_en + ',' + this.$t('globalTrans.division', 'en') + ' : ' + this.getDivisionName(this.application.factory_info.division_id) + ',' + this.$t('globalTrans.district', 'en') + ' : ' + this.getDistrictName(this.application.factory_info.district_id)
        } else {
            content = this.$t('teaGardenService.application_id', 'bn') + ' : ' + this.application.application.app_id + ',' + this.$t('teaGardenPanel.factory_name', 'bn') + ' : ' + this.application.factory_info.factory_name_bn + ',' + this.$t('globalTrans.division', 'bn') + ' : ' + this.getDivisionName(this.application.factory_info.division_id) + ',' + this.$t('globalTrans.district', 'bn') + ' : ' + this.getDistrictName(this.application.factory_info.district_id)
        }
        return content
    },
    getDivisionName  (id) {
    const division = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
        if (division && this.$i18n.locale === 'bn') {
            return division.text_bn
        } else if (division && this.$i18n.locale === 'en') {
            return division.text_en
        }
    },
    getDistrictName (id) {
    const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
        if (district && this.$i18n.locale === 'bn') {
            return district.text_bn
        } else if (district && this.$i18n.locale === 'en') {
            return district.text_en
        }
    },
    getCityCorporationName (id) {
    const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
        if (cityCorporation && this.$i18n.locale === 'bn') {
            return cityCorporation.text_bn
        } else if (cityCorporation && this.$i18n.locale === 'en') {
            return cityCorporation.text_en
        }
    },
    getUpzillaName (id) {
    const upzilla = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
        if (upzilla && this.$i18n.locale === 'bn') {
            return upzilla.text_bn
        } else if (upzilla && this.$i18n.locale === 'en') {
            return upzilla.text_en
        }
    },
    getPauroshobaName (id) {
    const municipality = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
        if (municipality && this.$i18n.locale === 'bn') {
            return municipality.text_bn
        } else if (municipality && this.$i18n.locale === 'en') {
            return municipality.text_en
        }
    },
    getUnionName (id) {
    const union = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
        if (union && this.$i18n.locale === 'bn') {
            return union.text_bn
        } else if (union && this.$i18n.locale === 'en') {
            return union.text_en
        }
    },
    getOfficeName (id) {
      const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getQrCodeFitWidth () {
        return this.$i18n.locale === 'bn' ? '125' : '120'
    },
    getGardenName (id) {
        var gardenInfo
        if (this.authUser.user_type === 1) {
            gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
        } else {
            gardenInfo = this.$store.state.ExternalUserService.teaGarden.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
        }
        if (gardenInfo && this.$i18n.locale === 'bn') {
            return gardenInfo.text_bn
        } else if (gardenInfo && this.$i18n.locale === 'en') {
            return gardenInfo.text_en
        }
    },
    async getSignatoryUserInfo (id) {
        const result = await RestApi.getData(authServiceBaseUrl, AuthUserInfo + id)
        if (result.success) {
          this.signatory_user_info = result.data
          if (this.signatory_user_info) {
             this.getDesignationNameSignatory(this.signatory_user_info.designation_id)
             this.getOfficeNameSignatory(this.signatory_user_info.office_id)
          }
        }
    },
    async getApproveUserInfo (id) {
        const result = await RestApi.getData(authServiceBaseUrl, AuthUserInfo + id)
        if (result.success) {
          this.approve_user_info = result.data
          if (this.approve_user_info) {
             this.getDesignationNameApprove(this.approve_user_info.designation_id)
             this.getOfficeNameApprove(this.approve_user_info.office_id)
          }
        }
    },
    getDesignationNameSignatory (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      if (obj) {
        this.signatory_user_info.designation_en = obj.text_en
        this.signatory_user_info.designation_bn = obj.text_bn
      }
      return true
    },
    getOfficeNameSignatory (id) {
      const obj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(id))
      if (obj) {
        this.signatory_user_info.office_en = obj.text_en
        this.signatory_user_info.office_bn = obj.text_bn
      }
      return true
    },
    getDesignationNameApprove (id) {
      const obj = this.$store.state.CommonService.commonObj.designationList.find(item => item.value === parseInt(id))
      if (obj) {
        this.approve_user_info.designation_en = obj.text_en
        this.approve_user_info.designation_bn = obj.text_bn
      }
      return true
    },
    getOfficeNameApprove (id) {
      const obj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(id))
      if (obj) {
        this.approve_user_info.office_en = obj.text_en
        this.approve_user_info.office_bn = obj.text_bn
      }
      return true
    }
  }
}
</script>
<style scoped>
.page {
    background: white;
    padding: .5in;
    margin: 0 auto;
    margin-bottom: 0.5cm;
}

.page[size="A4"] {
    width: 21cm;
    min-height: 29.7cm;
    height: auto;
}

.report-table {
    margin-top: 1rem;
    width: 100%;
}

.report-table td,
.report-table th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 4px;
}

@media print {

    body,
    .page {
        margin: 0;
        box-shadow: 0;
    }
}
</style>
