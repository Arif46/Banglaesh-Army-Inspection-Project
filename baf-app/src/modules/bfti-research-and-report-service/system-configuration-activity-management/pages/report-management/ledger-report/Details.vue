<template>
  <div class="section-wrapper">
    <b-overlay :show="loading">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:500;"> {{ $t('report_management.ledger_report') }}</h5>
            </template>
            <template v-slot:body>
                <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
                  <template v-slot:projectNameSlot>
                    {{ }}
                  </template>
                  {{ $t('report_management.ledger_report') }} {{ $t('globalTrans.details') }}
                </list-report-head>
                <b-row>
                  <b-col lg="12" sm="12">
                   <table class="table table-borderless">
                     <tr>
                       <th style="width: 23%">{{ $t('meeting_management.doc_type')}}</th>
                       <th style="width: 2%">:</th>
                       <td colspan="4">
                         {{ currentLocale === 'en' ? item.document_type_en : item.document_type_bn }}
                        </td>
                     </tr>
                     <tr>
                       <th>{{ $t('research_execution.title_or_topic') }}</th>
                       <th>:</th>
                       <td colspan="4">
                         <!-- {{ ($i18n.locale === 'en') && item.research ? item.research.topic : item.research.topic_bn  }} -->
                        <slot v-if="item.document_type_id === 2">
                          {{ ($i18n.locale === 'bn') ? item.prepare_rfp.rfp_title_bn : item.prepare_rfp.rfp_title_en }}
                        </slot>
                        <slot v-else-if="item.document_type_id === 3">
                          {{ ($i18n.locale === 'bn') ? item.research.topic_bn: item.research.topic }}
                        </slot>
                        </td>
                     </tr>
                     <tr>
                       <th>{{ $t('report_management.client') }}</th>
                       <th>:</th>
                       <td>
                         <!-- <pre>{{item.research}}</pre> -->
                         <!-- {{ ($i18n.locale === 'en') ? item.client_en : item.client_bn }} -->
                        <slot v-if="item.document_type_id === 2">
                          {{ ($i18n.locale === 'bn') ? item.prepare_rfp.client_bn : item.prepare_rfp.client }}
                        </slot>
                        <slot v-else-if="item.document_type_id === 3">
                          {{ ($i18n.locale === 'bn') ? item.research.client_bn: item.research.client }}
                        </slot>
                       </td>
                       <th>{{ $t('research_plan_management.duration') }}</th>
                       <th>:</th>
                       <td>
                          <!-- {{ ($i18n.locale === 'en') && item.research ? item.research.duration : item.research.duration_bn }} -->
                          <slot v-if="item.document_type_id === 2">
                            {{ ($i18n.locale === 'bn') ? item.prepare_rfp.duration : item.prepare_rfp.duration }}
                          </slot>
                          <slot v-else-if="item.document_type_id === 3">
                            {{ ($i18n.locale === 'bn') ? item.research.duration_bn: item.research.duration }}
                          </slot>
                        </td>
                     </tr>
                     <tr>
                       <th>{{ $t('task_activity_monitoring.contract_amount') }}</th>
                       <th>:</th>
                       <td> {{ $n(item.contract_amount) }}</td>
                       <th>{{ $t('research_execution.remaining_amount') }}</th>
                       <th>:</th>
                       <td> {{ $n(item.remaining_amount) }}</td>
                     </tr>
                     <tr>
                       <th>{{ $t('research_execution.contract_date') }}</th>
                       <th>:</th>
                       <td>{{ item.contract_date | dateFormat }}</td>
                     </tr>
                    </table>
                  </b-col>
              </b-row>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:500;"> {{ $t('research_execution.payment_schedule') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered small responsive>
                <b-tr>
                  <b-td>{{ $t('researchRequestManagement.installment') }}</b-td>
                  <b-td>{{ $t('researchRequestManagement.payment_for') }}</b-td>
                  <b-td>{{ $t('researchRequestManagement.installment_amount') }}</b-td>
                  <b-td>{{ $t('research_execution.rcv_amount') }}</b-td>
                  <b-td>{{ $t('research_execution.rem_amount') }}</b-td>
                </b-tr>
                <template v-if="item.budgets.length">
                  <b-tr v-for="(budgetItem, index) in item.budgets" :key="index">
                    <b-td> {{ getInstallmentName(budgetItem.installment_id) }} </b-td>
                    <b-td> {{ budgetItem.payment_for }} </b-td>
                    <b-td class="text-right"> {{ $n(budgetItem.installment_amount) }} </b-td>
                    <b-td class="text-right"> {{ $n(budgetItem.rcv_amount) }} </b-td>
                    <b-td class="text-right"> {{ $n(budgetItem.rem_amount) }} </b-td>
                  </b-tr>
                </template>
                <template v-else>
                  <b-tr>
                    <b-td colspan="5" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                  </b-tr>
                </template>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:500;"> {{ $t('report_management.payment_receive_info') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered small responsive>
                <b-tr>
                  <b-td>{{ $t('globalTrans.sl_no') }}</b-td>
                  <b-td>{{ $t('researchRequestManagement.installment_no') }}</b-td>
                  <b-td>{{ $t('research_execution.ins_amount') }}</b-td>
                  <b-td>{{ $t('research_execution.rcv_amount') }}</b-td>
                  <b-td>{{ $t('research_execution.tax_vat') }}</b-td>
                  <b-td>{{ $t('research_execution.rcv_date') }}</b-td>
                  <b-td>{{ $t('research_execution.actual_rcv_amount') }}</b-td>
                  <b-td>{{ $t('research_execution.receive_through') }}</b-td>
                  <b-td>{{ $t('globalTrans.remarks') }}</b-td>
                </b-tr>
                <template v-if="item.budgets.length">
                  <template v-for="(budgetItem, budgetIndex) in item.budgets">
                    <template v-if="budgetItem.receive_payments.length">
                      <template v-for="(paymentItem, paymentIndex) in budgetItem.receive_payments">
                        <b-tr v-if="paymentIndex === 0" :key="'budget-'+budgetIndex+'-payment-'+paymentIndex">
                          <b-td :rowspan="(budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null">{{ $n(budgetIndex + 1) }}</b-td>
                          <b-td :rowspan="(budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null">{{ getInstallmentName(budgetItem.installment_id) }} </b-td>
                          <b-td :rowspan="(budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null" class="text-right"> {{ $n(budgetItem.installment_amount, { useGrouping: false }) }} </b-td>
                          <b-td class="text-right">{{ $n(paymentItem.rcv_amount) }} </b-td>
                          <b-td class="text-right">{{ $n(paymentItem.tax_vat) }} </b-td>
                          <b-td class="text-right">{{ paymentItem.rcv_date | dateFormat }}</b-td>
                          <b-td class="text-right">{{ $n(paymentItem.actual_rcv_amount) }}</b-td>
                          <b-td class="text-right">{{ paymentItem.rcv_through }}</b-td>
                          <b-td class="text-right">{{ paymentItem.remark }}</b-td>
                        </b-tr>
                        <b-tr v-else :key="'budget-'+budgetIndex+'-payment-'+paymentIndex">
                          <b-td class="text-right">{{ $n(paymentItem.rcv_amount) }} </b-td>
                          <b-td class="text-right">{{ $n(paymentItem.tax_vat) }} </b-td>
                          <b-td class="text-right">{{ paymentItem.rcv_date | dateFormat }}</b-td>
                          <b-td class="text-right">{{ $n(paymentItem.actual_rcv_amount) }}</b-td>
                          <b-td class="text-right">{{ paymentItem.rcv_through }}</b-td>
                          <b-td class="text-right">{{ paymentItem.remark }}</b-td>
                        </b-tr>
                      </template>
                    </template>
                    <template v-else>
                      <b-tr :key="'budget-' + budgetIndex">
                        <b-td>{{ $n(budgetIndex + 1) }} </b-td>
                        <b-td>{{ getInstallmentName(budgetItem.installment_id) }} </b-td>
                        <b-td class="text-right"> {{ $n(budgetItem.installment_amount) }} </b-td>
                        <b-td class="text-right"></b-td>
                        <b-td class="text-right"></b-td>
                        <b-td class="text-right"></b-td>
                        <b-td class="text-right"></b-td>
                        <b-td class="text-right"></b-td>
                        <b-td class="text-right"></b-td>
                      </b-tr>
                    </template>
                  </template>
                </template>
                <template v-else>
                  <b-tr>
                    <b-td colspan="9" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                  </b-tr>
                </template>
              </b-table-simple>
            </template>
          </body-card>
        </b-col>
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { ledgerReportShow } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'

export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      item: {
        research: {},
        budgets: []
      }
    }
  },
  components: {
    ListReportHead
  },
  created () {
    if (this.id) {
      this.getDetailsData()
    }
  },
  computed: {
    loading () {
      return this.$store.state.commonObj.loading
    },
    currentLocale () {
      return this.$i18n.locale
    },
    documentTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    async getDetailsData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, ledgerReportShow + this.id)
      if (result.success) {
        this.item = result.data
        const documentType = this.documentTypeList.find(obj => obj.value === this.item.document_type_id)
        const customItem = {
          document_type_en: documentType?.text_en,
          document_type_bn: documentType?.text_bn
        }
        this.item = Object.assign({}, this.item, customItem)
      } else {
        this.item = {}
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    pdfExport () {
      const reportTitle = this.$t('report_management.ledger_report') + ' ' + this.$t('globalTrans.details')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    }
  }
}
</script>
