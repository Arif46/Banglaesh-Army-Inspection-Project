<template>
  <div class="section-wrapper">
    <b-overlay :show="loading">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
              <!-- <template v-slot:headerTitle>
                <h5 class="card-title" style="font-weight:550;"> {{ $t('report_management.income_expenditure_report') }}</h5>
              </template> -->
              <template v-slot:body>
                  <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
                    <template v-slot:projectNameSlot>
                      {{ }}
                    </template>
                    {{ $t('report_management.con_payment') }}
                  </list-report-head>
                  <b-row>
                    <b-col lg="12" sm="12">
                      <b-table-simple>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('configuration.document_type') }}</b-td>
                          <b-td>:</b-td>
                          <b-td colspan="3">{{ getDocumentTypeName(items.document_type_id) }}</b-td>
                        </b-tr>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('globalTrans.title') }}</b-td>
                          <b-td>:</b-td>
                          <b-td colspan="3">
                            {{ ($i18n.locale === 'bn') ? items.topic_bn : items.topic }}
                          </b-td>
                        </b-tr>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%" >{{ $t('report_management.client') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>
                            {{ ($i18n.locale === 'bn') ? items.client_bn : items.client }}
                          </b-td>
                          <b-td class="font-weight-bold text-right" style="width: 23%">{{ $t('research_execution.project_duration') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ ($i18n.locale === 'bn') ? items.duration_bn : items.duration }}</b-td>
                        </b-tr>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('research_execution.consultant_name') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ ($i18n.locale === 'bn') ? items.resource_pool.name_bn : items.resource_pool.name_en }}</b-td>
                          <b-td class="font-weight-bold text-right" style="width: 23%">{{ $t('report_management.contract_date_from') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ items.date_from | dateFormat }}</b-td>
                        </b-tr>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('report_management.contract_date_to') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ items.date_to | dateFormat }}</b-td>
                          <b-td class="font-weight-bold text-right">{{ $t('researchRequestManagement.contract_amount') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ $n(items.amount, { useGrouping: false }) }}</b-td>
                        </b-tr>
                        <b-tr class="no-border">
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('research_execution.rem_amount') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ $n(remAmount, { useGrouping: false }) }}</b-td>
                          <!-- <b-td class="font-weight-bold" style="width: 23%">{{ $t('researchRequestManagement.contract_amount') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ contract_date|dateFormat }}</b-td> -->
                        </b-tr>
                      </b-table-simple>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="12">
                      <b-table-simple bordered style="border-color:black">
                        <b-tr>
                          <b-td colspan="8" class="text-center" style="border-color:black">{{ $t('report_management.payment_history') }}</b-td>
                        </b-tr>
                        <b-tr>
                          <b-td class="text-center" style="border-color:black">{{ $t('report_management.sl') }}</b-td>
                          <b-td class="text-center" style="border-color:black">{{$t('research_execution.payment_date')}}</b-td>
                          <b-td class="text-center" style="border-color:black">{{ $t('report_management.paid_amount_tk') }}</b-td>
                          <b-td class="text-center" style="border-color:black">{{ $t('research_execution.tax') }}</b-td>
                          <b-td class="text-center" style="border-color:black">{{$t('report_management.tax_amount')}}</b-td>
                          <b-td class="text-center" style="border-color:black">{{ $t('research_execution.total') + ' ' + $t('research_execution.paid_amount') }}</b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $t('report_management.payable_balance') }} </b-td>
                          <b-td class="text-center" style="border-color:black">{{ $t('globalTrans.remarks') }}</b-td>
                        </b-tr>
                        <b-tr v-for="(item, index) in detailsData" :key="index">
                          <b-td class="text-center" style="border-color:black"> {{ $n(index + 1) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ item.payment_date | dateFormat }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(item.paid_amount, { useGrouping: false }) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(item.tax) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(item.tax_amount, { useGrouping: false }) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(item.actual_paid_amount, { useGrouping: false }) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(item.payable_amount, { useGrouping: false }) }} </b-td>
                          <b-td class="text-center" style="border-color:black"> {{ item.remark }} </b-td>
                        </b-tr>
                        <b-tr v-if="detailsData.length > 0">
                          <td colspan="2" class="text-right" style="border-color:black"> {{ $t('globalTrans.total') }} </td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(totPaid, { useGrouping: false })}}</b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(totTax, { useGrouping: false })}}</b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(totTaxAmount, { useGrouping: false })}}</b-td>
                          <b-td class="text-center" style="border-color:black"> {{ $n(totActualPaid, { useGrouping: false })}}</b-td>
                          <b-td class="text-center" style="border-color:black"> </b-td>
                          <b-td class="text-center" style="border-color:black"> </b-td>
                        </b-tr>
                        <b-tr v-if="detailsData.length === 0">
                          <b-td colspan="7" class="text-center" style="border-color:black"> {{ $t('report_management.con_paid_status') }}</b-td>
                        </b-tr>
                      </b-table-simple>
                    </b-col>
                </b-row>
              </template>
            </body-card>
        </b-col>
        <!-- <pre>{{items}}</pre> -->
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { consultantPaymentDetailReportRoute } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'

export default {
  name: 'Details',
  props: ['id', 'items'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      loading: false,
      detailsData: [],
      totPaid: 0,
      totTax: 0,
      totTaxAmount: 0,
      totActualPaid: 0,
      remAmount: 0
    }
  },
  components: {
    ListReportHead
  },
  created () {
    if (this.items) {
      this.getDetailsData()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    async getDetailsData () {
      this.loading = true
      const params = Object.assign({}, { assign_consultant_id: this.items.id })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, consultantPaymentDetailReportRoute, params)
      if (result.success) {
        this.detailsData = result.data
        let totPaid = 0
        let totTax = 0
        let totTaxAmount = 0
        let totActualPaid = 0
        result.data.map(item => {
          totPaid += item.paid_amount
          totTax += item.tax
          totTaxAmount += item.tax_amount
          totActualPaid += item.actual_paid_amount
        })
        this.totPaid = totPaid
        this.totTax = totTax
        this.totTaxAmount = totTaxAmount
        this.totActualPaid = totActualPaid
        this.remAmount = this.items.amount - parseFloat(this.totPaid)
      }
      this.loading = false
    },
    pdfExport () {
      const reportTitle = this.$t('report_management.con_pay_report')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    },
    getDocumentTitle (documentTypeId) {
      if (documentTypeId === 2) {
        return this.$i18n.locale === 'bn' ? this.items.prepare_rfp.rfp_title_bn : this.items.prepare_rfp.rfp_title_en
      }

      if (documentTypeId === 3) {
        return this.$i18n.locale === 'bn' ? this.items.research.topic_bn : this.items.research.topic
      }
    },
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
    }
  }
}
</script>

<style>
  .no-border {
    border-style:hidden;
   }
 </style>
