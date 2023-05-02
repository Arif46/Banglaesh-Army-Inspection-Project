<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template>
            <b-overlay :show="loader">
              <b-row>
                <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
                  <template v-slot:projectNameSlot>
                    {{ }}
                  </template>
                  {{ $t('externalTradeFair.exhibit_information') + ' ' + $t('globalTrans.details') }}
                </list-report-head>
                <b-col lg="12" sm="12" v-if="detailsData">
                    <table class="table table-borderless">
                    <tr>
                      <th style="width: 20%; padding-bottom: 0"> {{$t('globalTrans.fiscal_year')}}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 78%; padding-bottom: 0">{{ getFiscalYearName(detailsData.fiscal_year_id) }}</td>
                    </tr>
                    <tr>
                      <th style="width: 20%; padding-bottom: 0"> {{ $t('exhibitCircularManagement.circular_memo') }}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 78%; padding-bottom: 0">{{ detailsData.exhibit_circular.circular_memo_no }}</td>
                    </tr>
                    <tr>
                      <th style="width: 20%; padding-bottom: 0"> {{ $t('externalTradeFair.exhibition_id') }}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 78%; padding-bottom: 0">{{ detailsData.exhibit_auto_id }}</td>
                    </tr>
                    <tr>
                      <th style="width: 20%; padding-bottom: 0">{{ $t('exhibitCircularManagement.subject') }}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 78%; padding-bottom: 0">{{ $i18n.locale === 'en' ? detailsData.exhibit_circular.subject_en : detailsData.exhibit_circular.subject_bn }}</td>
                    </tr>
                    <tr>
                      <th style="width: 20%; padding-bottom: 0">{{ $t('exhibitCircularManagement.company_name') }}</th>
                      <th style="width: 2%; padding-bottom: 0">:</th>
                      <td style="width: 78%; padding-bottom: 0">{{ $i18n.locale === 'en' ? detailsData.fair_parti.name_en : detailsData.fair_parti.name_bn }}</td>
                    </tr>
                    <tr>
                      <th style="width: 20%">{{ $t('exhibitCircularManagement.company_type') }}</th>
                      <th style="width: 2%">:</th>
                      <td style="width: 78%">{{getCompanyTypeName(detailsData.fair_parti.company_type)}}</td>
                    </tr>
                    </table>
                    <b-table-simple bordered hover small>
                      <thead>
                        <tr>
                          <b-th colspan="8" class="text-center p-2" style="background: #e3e3e3">{{ $t('exhibitCircularManagement.fair_exhibition_info') }}</b-th>
                        </tr>
                        <tr class="bg-primary text-align-center">
                          <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:10%">{{ $t('exhibitCircularManagement.description_exhibit') }}</th>
                          <th style="width:10%">{{ $t('exhibitCircularManagement.hs_code_no') }}</th>
                          <th style="width:10%">{{ $t('exhibitCircularManagement.quantity') }}</th>
                          <th style="width:10%">{{ $t('exhibitCircularManagement.unit_price') }}</th>
                          <th style="width:10%">{{ $t('exhibitCircularManagement.total_price') }}</th>
                          <th style="width:10%">{{ $t('externalTradeFair.exporter_name') }}</th>
                        </tr>
                      </thead>
                      <b-tbody v-if="detailsData?.details?.length > 0">
                          <b-tr v-for="(item, index) in detailsData.details" :key="index">
                              <b-td>{{ index + 1 }}</b-td>
                              <b-td>{{ $i18n.locale === 'en' ? item.exhibit_desc_en : item.exhibit_desc_bn }}</b-td>
                              <b-td>{{ $n(item.hs_code) }}</b-td>
                              <b-td>{{ $n(item.quantity, { minimumFractionDigits: 2 }) }}</b-td>
                              <b-td>{{ $n(item.unit_price, { minimumFractionDigits: 2 }) }}</b-td>
                              <b-td>{{ $n(item.total_price, { minimumFractionDigits: 2 }) }}</b-td>
                              <b-td>{{ $i18n.locale === 'en' ? item.exporter_name_en : item.exporter_name_bn }}</b-td>
                          </b-tr>
                      </b-tbody>
                    </b-table-simple>
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairExhibitInfoShow } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'
export default {
    name: 'Details',
    props: ['id'],
    components: {
      ListReportHead
    },
    data () {
      return {
        baseUrl: internationalTradeFairServiceBaseUrl,
        loader: false,
        detailsData: null
      }
    },
    created () {
      if (this.id) {
       this.getExhibitionInfo()
      }
    },
    methods: {
      getFiscalYearName (Id) {
        const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(Id))
        if (typeof fiscalYear !== 'undefined') {
          return this.$i18n.locale === 'en' ? fiscalYear.text_en : fiscalYear.text_bn
        } else {
          return ''
        }
      },
      getCompanyTypeName (id) {
        const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
        if (typeof companyType !== 'undefined') {
          return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
        } else {
          return ''
        }
      },
     async getExhibitionInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairExhibitInfoShow + '/' + this.id)
        if (resultData.success) {
          this.detailsData = resultData.data
          this.loader = false
        } else {
          this.detailsData = {}
        }
      },
      pdfExport () {
        const reportTitle = this.$t('externalTradeFair.exhibit_information') + ' ' + this.$t('globalTrans.details')
        ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/itf-configuration/report-head/detail', 2, reportTitle, this)
      }
    }
}
</script>
