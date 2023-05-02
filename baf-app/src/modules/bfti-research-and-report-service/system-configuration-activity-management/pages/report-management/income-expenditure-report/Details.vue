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
                    {{ $t('report_management.income_expenditure_report') }}
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
                            {{ getDocumentTitle(items.document_type_id) }}
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
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('researchRequestManagement.contract_amount') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ $n(contract_amount, { useGrouping: false }) }}</b-td>
                          <b-td class="font-weight-bold text-right" style="width: 23%">{{ $t('research_execution.rcv_amount') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ $n(totRcv, { useGrouping: false }) }}</b-td>
                        </b-tr>
                        <b-tr>
                          <b-td class="font-weight-bold" style="width: 23%">{{ $t('report_management.payment_schedule') }}</b-td>
                          <b-td>:</b-td>
                          <b-td>{{ contract_date|dateFormat }}</b-td>
                          <!-- <b-td class="font-weight-bold">{{ $t('report_management.payment_schedule') }}</b-td>
                          <b-td>{{ contract_date|dateFormat }}</b-td> -->
                        </b-tr>
                      </b-table-simple>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="12">
                      <b-table-simple bordered style="width: 50%;float: left;border-color:black">
                        <b-tr>
                          <b-td colspan="4" class="text-center" style="border-color:black">{{ $t('research_execution.rcv_amount') }}</b-td>
                        </b-tr>
                        <b-tr style="border-color:black">
                          <b-td style="border-color:black">{{ $t('report_management.sl') }}</b-td>
                          <b-td style="border-color:black">{{$t('report_management.particular')}}</b-td>
                          <b-td style="border-color:black">{{ $t('report_management.amount') }}</b-td>
                          <b-td style="border-color:black">{{ $t('globalTrans.remarks') }}</b-td>
                        </b-tr>
                        <b-tr v-for="(item, index) in rcvPayment" :key="index" style="border-color:black">
                          <b-td style="border-color:black"> {{ $n(index + 1) }} </b-td>
                          <b-td style="border-color:black"> {{ getInstallmentName(item.installment_id) }} </b-td>
                          <b-td style="border-color:black"> {{ $n(item.actual_rcv_amount, { useGrouping: false }) }} </b-td>
                          <b-td style="border-color:black"> {{ item.remark }} </b-td>
                        </b-tr>
                        <b-tr>
                          <td style="border-color:black">  {{ }} </td>
                          <td class="text-right" style="border-color:black">  {{ $t('globalTrans.total') }} </td>
                          <b-td colspan="2" class="text-left" style="border-color:black"> {{ $n(totRcv, { useGrouping: false })}}</b-td>
                        </b-tr>
                      </b-table-simple>
                      <b-table-simple bordered style="width: 50%;border-color:black">
                        <b-tr>
                          <b-td colspan="3" class="text-center" style="border-color:black">{{$t('report_management.expenditure')}}</b-td>
                        </b-tr>
                        <b-tr>
                          <!-- <b-td>{{ $t('report_management.sl') }}</b-td> -->
                          <b-td style="border-color:black">{{$t('report_management.particular')}}</b-td>
                          <b-td style="border-color:black">{{ $t('report_management.amount') }}</b-td>
                          <b-td style="border-color:black">{{ $t('globalTrans.remarks') }}</b-td>
                        </b-tr>
                        <template v-if="expenseArr.length > 0">
                          <template v-for="(expenditure, index) in expenseArr">
                            <b-tr v-for="(item, index2) in expenditure" :key="index2">
                              <!-- <b-td> {{ index2 + 1 }} </b-td> -->
                              <b-td style="border-color:black"> {{ getExpenditureHeadName(item.expenditure_head_id) }} </b-td>
                              <b-td style="border-color:black"> {{ $n(item.expense_amount, { useGrouping: false }) }} </b-td>
                              <b-td style="border-color:black"> {{ expenditureInfo[index].remark }} </b-td>
                            </b-tr>
                          </template>
                        </template>
                        <b-tr>
                          <td class="text-right" style="border-color:black">  {{ $t('globalTrans.total') }} </td>
                          <b-td colspan="2" class="text-left" style="border-color:black"> {{ $n(totExpense, { useGrouping: false })}}</b-td>
                        </b-tr>
                      </b-table-simple>
                    </b-col>
                </b-row>
              </template>
            </body-card>
        </b-col>
        <!-- <pre>{{expenseArr}}</pre> -->
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { incomeExpenditureDetailReportRoute } from '../../../api/routes'
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
      errors: [],
      detailsData: [],
      detailsItemId: '',
      item: {},
      rcvPayment: [],
      expenditureInfo: {
        expense_details: []
      },
      totRcv: 0,
      totExpense: 0,
      contract_amount: 0,
      expenseArr: [],
      contract_date: ''
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
      const params = Object.assign({}, { document_type_id: this.items.document_type_id, contract_sign_id: this.items.contract_sign_id, research_request_id: this.items.research_request_id })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, incomeExpenditureDetailReportRoute, params)
      if (result.success) {
        this.rcvPayment = result.data.rcvPayment
        this.expenditureInfo = result.data.expenditureInfo
        this.contract_amount = result.data.contract_amount
        this.contract_date = result.data.contract_date
        let totRcv = 0
        this.rcvPayment.forEach(element => {
          totRcv += parseFloat(element.actual_rcv_amount)
        })
        this.totRcv = totRcv
        let totExpense = 0
        const arr = []
        if (this.expenditureInfo.length > 0) {
          this.expenditureInfo.forEach((value, index) => {
            totExpense += parseFloat(value.tot_expense_amount)
            arr.push(value.expense_details)
          })
          this.totExpense = totExpense
          this.expenseArr = arr
        }
      }
      this.loading = false
    },
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    getExpenditureHeadName (headID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.expenditureHeadList.find(head => head.value === headID)
      return data !== undefined ? data.text : ''
    },
    pdfExport () {
      const reportTitle = this.$t('report_management.income_expenditure_report')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.item, this.consultantDetailsData, this.assignConsultantData)
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
  .border-color {
    border: 1px solid;
  }
 </style>
