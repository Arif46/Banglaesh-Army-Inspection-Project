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
                  <b-td>{{ contractSignData.contract_amount > 0 ? $n(contractSignData.contract_amount, { useGrouping: false }) : '' }}</b-td>
                  <b-td class="font-weight-bold">{{ $t('research_execution.rcv_amount') }}</b-td>
                  <b-td>{{ contractSignData.rcv_amount > 0 ? $n(contractSignData.rcv_amount, { useGrouping: false }) : '' }}</b-td>
                </b-tr>
                <b-tr>
                  <b-td class="font-weight-bold">{{ $t('research_execution.rem_rcv_amount') }}</b-td>
                  <b-td>{{ contractSignData.rem_amount > 0 ? $n(contractSignData.rem_amount, { useGrouping: false }) : '' }}</b-td>
                  <b-td class="font-weight-bold">{{ $t('research_execution.current_amount') }}</b-td>
                  <b-td>{{ contractSignData.usable_amount > 0 ? $n(contractSignData.usable_amount, { useGrouping: false }) : $n(0) }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:550;"> {{ $t('research_execution.expenditure_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-td class="text-center">{{ $t('globalTrans.sl_no') }} </b-td>
                  <b-td class="text-center">{{ $t('research_execution.expenditure_head') }}</b-td>
                  <b-td class="text-center">{{$t('research_execution.expense_amount')}}</b-td>
                </b-tr>
                <b-tr v-for="(item, index) in contractSignData.expense_details" :key="index">
                  <b-td class="text-center"> {{ $n(index + 1) }} </b-td>
                  <b-td class="text-center"> {{ getExpenditureHeadName(item.expenditure_head_id) }} </b-td>
                  <b-td class="text-center"> {{ $n(item.expense_amount, { useGrouping: false }) }} </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('research_execution.expense_date') }}</b-th>
                  <b-td>{{ contractSignData.expense_date | dateFormat }} </b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.remarks') }}</b-th>
                  <b-td>{{ contractSignData.remark }}</b-td>
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
import { expenditureInfoDetails } from '../../api/routes'
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
      this.DetailsData()
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
    DetailsData () {
      this.loading = true
      const params = Object.assign({}, { id: this.item.id, document_type_id: this.item.document_type_id, research_request_id: this.item.research_request_id, contract_sign_id: this.item.contract_sign_id })
      RestApi.getData(bftiResReportServiceBaseUrl, expenditureInfoDetails, params).then(response => {
        if (response.success) {
          if (response.data) {
            this.contractSignData = response.data
            this.contractSignData.client = this.$i18n.locale === 'en' ? this.contractSignData.organization_ministry_division : this.contractSignData.organization_ministry_division_bn

            if (this.contractSignData.prepare_rfp) {
              this.contractSignData.duration = this.contractSignData.prepare_rfp !== undefined ? this.contractSignData.prepare_rfp.duration : ''
            }
            if (this.contractSignData.research) {
              this.contractSignData.duration = this.contractSignData.research !== undefined ? this.contractSignData.research.duration : ''
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
    getExpenditureHeadName (headID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.expenditureHeadList.find(head => head.value === headID)
      return data !== undefined ? data.text : ''
    },
    pdfExport () {
      const reportTitle = this.$t('research_execution.expenditure_information')
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
