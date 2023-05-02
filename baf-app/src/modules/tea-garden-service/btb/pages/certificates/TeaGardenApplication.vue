<template>
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
<!--        <body-card>-->
<!--          <template v-slot:body>-->
            <div size="A4" class="page" id="print-area" ref="printArea">
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
                                <td>{{ detailsData.land_ownership_info.mouja }}</td>
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
                  <p style="text-align:justify;">{{ $n(1) }}) {{ $t('teaGardenPanel.condition1') }};</p>
                  <p style="text-align:justify;">{{ $n(2) }}) {{ $t('teaGardenPanel.condition2') }};
                  </p>
                  <p style="text-align:justify;">{{ $n(3) }}) {{ $t('teaGardenPanel.condition3') }};</p>
                  <p style="text-align:justify;">{{ $n(4) }}) {{ $t('teaGardenPanel.condition4') }};</p>
                  <p style="text-align:justify;">{{ $n(5) }}) {{ $t('teaGardenPanel.condition5') }};</p>
                  <p style="text-align:justify;">{{ $n(6) }}) {{ $t('teaGardenPanel.condition6') }}
                  </p>
                  <table style="width:100%; margin-top: 5rem;">
                      <tbody>
                          <tr>
                              <td style="width:33.33%">
<!--                                  <img src="../../../../../assets/images/qr.jpg" width="100px" alt="">-->
                                <vue-qrcode :value="getQrCodeContent()" :width="120"/>
                              </td>
                              <td style="width:33.33%"></td>
                              <td style="width:33.33%">
                                  <div>
                                      <img src="../../../../../assets/images/signature.png" width="100px" alt="">
                                      <p>{{ $t('globalTrans.name') }}: <span
                                              style="text-decoration-style: dotted; text-decoration-line: underline;">{{ $t('teaGardenPanel.signatory_name') }}</span>
                                      </p>
                                      <p>{{ $t('globalTrans.designation') }}: <span
                                              style="text-decoration-style: dotted; text-decoration-line: underline;">{{ $t('teaGardenPanel.signatory_designation') }}</span></p>
                                      <p>{{ $t('globalTrans.date') }} <span
                                              style="text-decoration-style: dotted; text-decoration-line: underline;">{{ $t('teaGardenPanel.signatory_date') }}</span>
                                      </p>
                                  </div>
                              </td>
                          </tr>
                      </tbody>
                  </table>
                </b-overlay>
              </div>
          </div>
<!--          </template>-->
<!--        </body-card>-->
      </b-col>
    </b-row>
  </div>
</template>
<script>
import { teaGardenServiceBaseUrl } from '@/config/api_config'
import TeaGardenReportHead from '@/components/custom/TeaGardenReportHead'
import VueQrcode from 'vue-qrcode'
import Pdf from './tea-garden-application-certificate-pdf'
export default {
  name: 'Certificate',
  props: ['id'],
  components: { TeaGardenReportHead, VueQrcode },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      valid: null,
      loading: false,
      detailsData: {},
      detailsItemId: '',
      color: { dark: '#000000ff', light: '#ffffffff' },
      type: 'image/png',
      dataUrl: null
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  created () {
      this.detailsData = this.getFormData()
  },
  methods: {
      getFormData () {
          const tmpData = this.$store.state.list.find(item => item.id === this.id)
          return JSON.parse(JSON.stringify(tmpData))
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
      onDataUrlChange (dataUrl) {
        this.dataUrl = dataUrl
      },
      pdfExport () {
        const reportTitle = this.$t('teaGardenPanel.tea_garden_registration') + ' ' + this.$t('globalTrans.certificate')
        Pdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this)
      },
      getQrCodeContent () {
        let content
        if (this.currentLocale === 'en') {
          content = this.$t('globalTrans.application_id', 'en') + ' : ' + this.detailsData.application.app_id + ',' + this.$t('teaGardenConfig.tea_garden_name', 'en') + ' : ' + this.detailsData.tea_garden_name_en + ',' + this.$t('globalTrans.division', 'en') + ' : ' + this.getDivisionName(this.detailsData.division_id) + ',' + this.$t('globalTrans.district', 'en') + ' : ' + this.getDistrictName(this.detailsData.district_id) + ',' + this.$t('teaGardenPanel.amount_of_land', 'en') + ' : ' + this.$n(this.detailsData.land_ownership_info.total_grant_area)
        } else {
          content = this.$t('globalTrans.application_id', 'bn') + ' : ' + this.detailsData.application.app_id + ',' + this.$t('teaGardenConfig.tea_garden_name', 'bn') + ' : ' + this.detailsData.tea_garden_name_en + ',' + this.$t('globalTrans.division', 'bn') + ' : ' + this.getDivisionName(this.detailsData.division_id) + ',' + this.$t('globalTrans.district', 'bn') + ' : ' + this.getDistrictName(this.detailsData.district_id) + ',' + this.$t('teaGardenPanel.amount_of_land', 'bn') + ' : ' + this.$n(this.detailsData.land_ownership_info.total_grant_area)
        }
        return content
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
    height: 34.7cm;
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
