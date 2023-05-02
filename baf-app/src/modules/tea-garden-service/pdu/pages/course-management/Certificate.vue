<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
            <div size="A4" class="page" id="print-area" ref="printArea">
            <div v-if="loading">
                <Loading />
            </div>
            <template v-else>
              <div class="text-right">
                <b-button @click="pdfExport" variant="primary" class="mb-3" size="sm">
                  <i class="ri-printer-fill"></i>
                  {{ $t('teaGardenConfig.Print') }}
                </b-button>
              </div>
              <div style="border: 1px double #222; padding: 1rem; height: 100%">
                <b-overlay :show="loading">
                  <TeaGardenReportHead :baseUrl="teaGardenServiceBaseUrl" :uri="'/configuration/report-heading/detail'" :orgId="5" :loadingState="false">
                      {{ $t('teaGardenPanel.tea_garden_registration') + ' ' + $t('globalTrans.certificate') }}
                  </TeaGardenReportHead>
                  <div class="table-responsive mt-5">
                    <table class="report-info">
                        <tbody>
                            <tr>
                              <td>{{ $t('teaGardenPanel.registration_no') }}</td>
                              <td>&emsp;:&nbsp;</td>
                              <td>{{ detailsData.application.registration_no }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenConfig.tea_garden_name') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ currentLocale === 'en' ? detailsData.tea_garden_name_en : detailsData.tea_garden_name_bn }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenConfig.division') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getDivisionName(detailsData.division_id) }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenConfig.district') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getDistrictName(detailsData.district_id) }}</td>
                            </tr>
                            <tr v-if="detailsData.area_type_id === 1">
                                <td>{{ $t('teaGardenConfig.city_corporation') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getCityCorName(detailsData.city_corporation_id) }}</td>
                            </tr>
                            <tr v-else>
                                <td>{{ $t('teaGardenConfig.upazila') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getUpazillaName(detailsData.upazila_id) }}</td>
                            </tr>
                            <tr v-if="detailsData.area_type_id === 2">
                                <td>{{ $t('teaGardenConfig.pouroshova') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getPouroName(detailsData.pauroshoba_id) }}</td>
                            </tr>
                            <tr v-if="detailsData.area_type_id === 3">
                                <td>{{ $t('teaGardenConfig.union') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getUnionName(detailsData.union_id) }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('globalTrans.ward') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ getWardName(detailsData.ward_id) }}</td>
                            </tr>
                            <template v-if="detailsData.proprietor_identity.owners.length">
                                <template v-for="(item, index) in detailsData.proprietor_identity.owners">
                                    <tr :key="'gwn-' + index">
                                        <td>{{ (detailsData.proprietor_identity.owners.length > 1 ? $n(index + 1)+ ') ' : '') + $t('teaGardenPanel.owner_name') }}</td>
                                        <td>&emsp;:&nbsp;</td>
                                        <td>{{ currentLocale === 'en' ? item.garden_owner_name_en : item.garden_owner_name_bn }}</td>
                                    </tr>
                                    <tr :key="'gwfn-' + index">
                                        <td>{{ (detailsData.proprietor_identity.owners.length > 1 ? $n(index + 1)+ ') ' : '') + $t('globalTrans.father_name') }}</td>
                                        <td>&emsp;:&nbsp;</td>
                                        <td>{{ currentLocale === 'en' ? item.garden_owner_father_name_en : item.garden_owner_father_name_bn }}</td>
                                    </tr>
                                </template>
                            </template>
                            <tr>
                                <td>{{ $t('teaGardenPanel.amount_of_land') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ $n(detailsData.land_ownership_info.total_grant_area) }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('externalUser.issue_date') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ detailsData.application.issue_date | dateFormat }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('externalLrcpn.expire_date') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ detailsData.application.expired_date | dateFormat }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenPanel.schedule_of_land') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenPanel.mouja') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ currentLocale === 'en' ? detailsData.land_ownership_info.mouja_en : detailsData.land_ownership_info.mouja_bn }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenPanel.khotian') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{ $n(detailsData.land_ownership_info.khotian_no, { useGrouping: false }) }}</td>
                            </tr>
                            <tr>
                                <td>{{ $t('teaGardenPanel.dag_no') }}</td>
                                <td>&emsp;:&nbsp;</td>
                                <td>{{  $n(detailsData.land_ownership_info.dag_no, { useGrouping: false }) }}</td>
                            </tr>
                        </tbody>
                    </table>
                  </div>
                  <strong style="margin-top:2rem; display: block;">{{ $t('teaGardenPanel.conditions') }}</strong>
                  <div class="text-justify" v-html="currentLocale === 'en' ? detailsData.application.service_instruction.instruction_en : detailsData.application.service_instruction.instruction_bn"></div>
                  <table style="width:100%; margin-top: 5rem;">
                      <tbody>
                          <tr>
                              <td style="width:33.33%">
                                <vue-qrcode :value="getQrCodeContent()" :width="120"/>
                              </td>
                              <td style="width:33.33%"></td>
                              <td>
                                <div>
                                <img v-if="detailsData.application.document_signatory && signatory_user_info.signature && detailsData.application.document_signatory.show_signature" :src="authServiceBaseUrl + 'storage/' + signatory_user_info.signature" width="100px" alt="">
                                <img v-else-if="approve_user_info.signature" :src="authServiceBaseUrl + 'storage/' + approve_user_info.signature" width="100px" alt="">
                                <p v-if="detailsData.application.document_signatory || detailsData.application.approver_name_en">{{ $t('globalTrans.name') }}:
                                    <span v-if="detailsData.application.document_signatory && detailsData.application.document_signatory.name_en && detailsData.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.text_en : signatory_user_info.text_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.text_en : approve_user_info.text_bn }}</span>
                                </p>
                                <p v-if="detailsData.application.document_signatory || detailsData.application.approver_designation_en">{{ $t('globalTrans.designation') }}:
                                    <span v-if="detailsData.application.document_signatory && detailsData.application.document_signatory.designation_en && detailsData.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? signatory_user_info.designation_en : signatory_user_info.designation_bn }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ currentLocale === 'en' ? approve_user_info.designation_en : approve_user_info.designation_bn }}</span>
                                </p>
                                <p v-if="detailsData.application.document_signatory && detailsData.application.document_signatory.email">{{ $t('globalTrans.email') }}:
                                    <span v-if="detailsData.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ signatory_user_info.email }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ approve_user_info.email }}</span>
                                </p>
                                <p v-if="detailsData.application.document_signatory && detailsData.application.document_signatory.mobile">{{ $t('globalTrans.mobile') }}:
                                    <span v-if="detailsData.application.document_signatory.show_name" style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(signatory_user_info.mobile) }}</span>
                                    <span v-else style="text-decoration-style: dotted; text-decoration-line: underline;">{{ EngBangNum(approve_user_info.mobile) }}</span>
                                </p>
                                <p>{{ $t('globalTrans.date') }} <span
                                        style="text-decoration-style: dotted; text-decoration-line: underline;">{{ detailsData.application.approved_date | dateFormat }}</span>
                                </p>
                            </div>
                              </td>
                          </tr>
                      </tbody>
                  </table>
                </b-overlay>
              </div>
              <div class="text-left mt-3">
                <b-button @click="back" class="ml-3"><i class="ri-arrow-go-back-fill"></i>  {{ $t('teaGardenConfig.back') }}</b-button>
              </div>
            </template>
          </div>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { AuthUserInfo } from '../../api/routes'
import Loading from '@/components/loading/Details.vue'
import TeaGardenReportHead from '@/components/custom/TeaGardenReportHead'
import VueQrcode from 'vue-qrcode'
// import Pdf from './certificate-pdf'
export default {
  name: 'Certificate',
  props: ['id'],
  components: { TeaGardenReportHead, VueQrcode, Loading },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      authServiceBaseUrl: authServiceBaseUrl,
      valid: null,
      detailsData: {
        application: {
          registration_no: '',
          proprietor_identity: {
            owners: []
          }
        }
      },
      detailsItemId: '',
      dataUrl: null,
      approve_user_info: {},
      signatory_user_info: {}
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading () {
      return this.$store.state.commonObj.loading
    }
  },
  created () {
      this.getFormData()
  },
  methods: {
      back () {
        this.$router.go(-1)
      },
      async getFormData () {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          const result = await RestApi.getData(teaGardenServiceBaseUrl, 'tea-garden-panel/tea-garden-application/garden-info/show/' + parseInt(this.$route.params.id))
          if (result.success) {
            this.detailsData = Object.assign({}, this.detailsData, result.data)
             // document signatory load
           if (this.detailsData.application.document_signatory && this.detailsData.application.document_signatory.user_id) {
                this.getSignatoryUserInfo(this.detailsData.application.document_signatory.user_id)
            }
            if (this.detailsData.application.approver_id) {
                this.getApproveUserInfo(this.detailsData.application.approver_id)
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
      getDivisionName (id) {
          const data = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getDistrictName (id) {
          const data = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getCityCorName (id) {
          const data = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getUpazillaName (id) {
          const data = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getPouroName (id) {
          const data = this.$store.state.CommonService.commonObj.municipalityList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getUnionName (id) {
          const data = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      getWardName (id) {
          const data = this.$store.state.CommonService.commonObj.wardList.find(item => item.value === id)
          if (typeof data !== 'undefined') {
              return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
          } else {
              return ''
          }
      },
      // pdfExport () {
      //   const reportTitle = this.$t('teaGardenPanel.tea_garden_registration') + ' ' + this.$t('globalTrans.certificate')
      //   Pdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this)
      // },
      async pdfExport () {
        const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 5, app_id: this.appId, show_certificate: 1 })
        this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
        const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, 'tea-garden-panel/tea-garden-application/garden-info/show/' + this.detailsData.id, params)
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
          content = this.$t('teaGardenPanel.registration_no', 'en') + ' : ' + this.detailsData.application.registration_no + ',' + this.$t('teaGardenConfig.tea_garden_name', 'en') + ' : ' + this.detailsData.tea_garden_name_en + ',' + this.$t('globalTrans.division', 'en') + ' : ' + this.getDivisionName(this.detailsData.division_id) + ',' + this.$t('globalTrans.district', 'en') + ' : ' + this.getDistrictName(this.detailsData.district_id) + ',' + this.$t('teaGardenPanel.amount_of_land', 'en') + ' : ' + this.$n(this.detailsData.land_ownership_info.total_grant_area)
        } else {
          content = this.$t('teaGardenPanel.registration_no', 'bn') + ' : ' + this.detailsData.application.registration_no + ',' + this.$t('teaGardenConfig.tea_garden_name', 'bn') + ' : ' + this.detailsData.tea_garden_name_en + ',' + this.$t('globalTrans.division', 'bn') + ' : ' + this.getDivisionName(this.detailsData.division_id) + ',' + this.$t('globalTrans.district', 'bn') + ' : ' + this.getDistrictName(this.detailsData.district_id) + ',' + this.$t('teaGardenPanel.amount_of_land', 'bn') + ' : ' + this.$n(this.detailsData.land_ownership_info.total_grant_area)
        }
        return content
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
    min-height: 34.7cm;
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
