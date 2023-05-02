<template>
  <div class="section-wrapper">
    <b-overlay :show="loading">
      <b-row>
        <b-col lg="12" sm="12">
          <body-card>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-td class="font-weight-bold">{{ $t('configuration.document_type') }}</b-td>
                  <b-td colspan="3">{{ getDocumentTypeName(item.document_type_id) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-td class="font-weight-bold">{{ $t('globalTrans.title') }}</b-td>
                  <b-td colspan="3">
                    {{ getDocumentTitle(item.document_type_id) }}
                  </b-td>
                </b-tr>
                <b-tr>
                  <b-td class="font-weight-bold">{{ $t('research_execution.client') }}</b-td>
                  <b-td>
                    {{ getClientName(item.document_type_id) }}
                  </b-td>
                  <b-td class="font-weight-bold">{{ $t('research_execution.project_duration') }}</b-td>
                  <b-td>{{ contractSignData.duration }}</b-td>
                </b-tr>
                <b-tr>
                  <b-td class="font-weight-bold">{{ $t('researchRequestManagement.contract_amount') }}</b-td>
                  <b-td>{{ $n(contractSignData.contract_amount, { useGrouping: false }) }}</b-td>
                  <b-td class="font-weight-bold">{{ $t('research_execution.rem_amount') }}</b-td>
                  <b-td>{{ $n(contractSignData.rem_amount, { useGrouping: false }) }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:550;"> {{ $t('research_execution.payment_schedule') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-td>{{ $t('researchRequestManagement.installment') }}</b-td>
                  <b-td>{{$t('researchRequestManagement.payment_for')}}</b-td>
                  <b-td>{{ $t('researchRequestManagement.installment_amount') }}</b-td>
                  <b-td>{{$t('research_execution.rcv_amount')}}</b-td>
                  <b-td>{{$t('research_execution.rem_amount')}}</b-td>
                </b-tr>
                <b-tr v-for="(item, index) in contractSignData.budgets" :key="index">
                <b-td> {{ getInstallmentName(item.installment_id) }} </b-td>
                <b-td> {{ item.payment_for }} </b-td>
                <b-td> {{ $n(item.installment_amount, { useGrouping: false }) }} </b-td>
                <b-td> {{ $n(item.rcv_amount, { useGrouping: false }) }} </b-td>
                <b-td> {{ $n(item.rem_amount, { useGrouping: false }) }} </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:550;"> {{ $t('research_execution.bill_collection') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('researchRequestManagement.installment') }}</b-th>
                  <b-td>{{ getInstallmentName(item.installment_id) }}</b-td>
                  <b-th>{{ $t('research_execution.rcv_amount') }}</b-th>
                  <b-td> {{ $n(item.rcv_amount, { useGrouping: false }) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.tax_vat') }}</b-th>
                  <b-td>{{ $n(item.tax_vat, { useGrouping: false }) }}</b-td>
                  <b-th>{{$t('research_execution.actual_rcv_amount')}}</b-th>
                  <b-td>{{ $n(item.actual_rcv_amount, { useGrouping: false }) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.rcv_date') }}</b-th>
                  <b-td>{{ item.rcv_date | dateFormat }}</b-td>
                  <b-th>{{$t('research_execution.receive_through')}}</b-th>
                  <b-td>{{ item.rcv_through }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.remarks') }}</b-th>
                  <b-td colspan="4">{{ item.remark }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
        </b-col>
        <!-- {{item}} -->
      </b-row>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { rcvPaymentDetails } from '../../api/routes'
import ExportPdf from './export_pdf_details'
export default {
  name: 'Details',
  props: ['item'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      loading: false,
      errors: [],
      detailsData: [],
      detailsItemId: '',
      contractSignData: []
    }
  },
  created () {
    if (this.item) {
      this.contractSigningData()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
    },
    contractSigningData () {
      this.loading = true
      const params = Object.assign({}, { document_type_id: this.item.document_type_id, research_request_id: this.item.research_request_id, contract_sign_id: this.item.contract_sign_id })
      RestApi.getData(bftiResReportServiceBaseUrl, rcvPaymentDetails, params).then(response => {
        if (response.success) {
          if (response.data) {
            this.contractSignData = response.data
            this.contractSignData.client = this.$i18n.locale === 'en' ? this.contractSignData.organization_ministry_division : this.contractSignData.organization_ministry_division_bn

            if (this.contractSignData.prepare_rfp) {
              this.contractSignData.duration = this.contractSignData.prepare_rfp !== undefined ? this.contractSignData.prepare_rfp.duration : ''
            }
            if (this.contractSignData.research) {
              this.contractSignData.duration = this.$i18n.locale === 'en' ? this.contractSignData.research !== undefined ? this.contractSignData.research.duration : '' : this.contractSignData.research !== undefined ? this.contractSignData.research.duration_bn : ''
            }
            this.loading = false

            // if (this.contractSignData.rem_amount === 0) {
            //   this.$toast.success({
            //     title: 'Success',
            //     message: 'Payment Completed!!!',
            //     color: '#D6E09B'
            //   })
            // }
          }
        }
      })
    },
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    pdfExport () {
      const reportTitle = this.$t('research_execution.received_payment_entry')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.item, this.contractSignData)
    },
    getDocumentTitle (documentTypeId) {
      if (documentTypeId === 2) {
        return this.$i18n.locale === 'bn' ? this.item.prepare_rfp.rfp_title_bn : this.item.prepare_rfp.rfp_title_en
      }

      if (documentTypeId === 3) {
        return this.$i18n.locale === 'bn' ? this.item.research.topic_bn : this.item.research.topic
      }
    },
    getClientName (documentTypeId) {
      if (documentTypeId === 2) {
        return this.$i18n.locale === 'bn' ? this.item.prepare_rfp.client_bn : this.item.prepare_rfp.client
      }

      if (documentTypeId === 3) {
        return this.$i18n.locale === 'bn' ? this.item.research.client_bn : this.item.research.client
      }
    }
  }
}
</script>
