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
                  <b-td>{{ consultantDetailsData.duration }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title" style="font-weight:550;"> {{ $t('research_execution.consultant_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th class="text-left">{{ $t('globalTrans.name') }} </b-th>
                  <b-td class="text-center">{{ name }}</b-td>
                  <b-th class="text-left">{{ $t('globalTrans.designation') }} </b-th>
                  <b-td class="text-center">{{ designation }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th class="text-left">{{ $t('globalTrans.organization') }} </b-th>
                  <b-td class="text-center">{{ organization }}</b-td>
                  <b-th class="text-left">{{ $t('research_execution.contract_date') + ' ' + $t('globalTrans.from') }} </b-th>
                  <b-td class="text-center">{{ assignConsultantData.date_from | dateFormat }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th class="text-left">{{ $t('research_execution.contract_date') + ' ' + $t('globalTrans.to') }} </b-th>
                  <b-td class="text-center">{{ assignConsultantData.date_to | dateFormat }}</b-td>
                  <b-th class="text-left">{{ $t('researchRequestManagement.contract_amount') }} </b-th>
                  <b-td class="text-center">{{ $n(assignConsultantData.amount, { useGrouping: false }) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th class="text-left">{{ $t('research_execution.total') + ' ' + $t('research_execution.paid_amount') }} </b-th>
                  <b-td class="text-center">{{ $n(consultantDetailsData.already_paid_amount, { useGrouping: false }) }}</b-td>
                  <b-th class="text-left">{{ $t('research_execution.rem_contract_amount') }} </b-th>
                  <b-td class="text-center">{{ $n(consultantDetailsData.rem_contract_amount, { useGrouping: false }) }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('research_execution.consultant_payment_info') }}</h5>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('research_execution.paid_amount') }}</b-th>
                  <b-td>{{ $n(consultantDetailsData.paid_amount, { useGrouping: false }) }} </b-td>
                  <b-th>{{ $t('research_execution.tax') }}</b-th>
                  <b-td>{{ $n(consultantDetailsData.tax) }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.paid_amount_without_tax') }}</b-th>
                  <b-td>{{ $n(consultantDetailsData.actual_paid_amount, { useGrouping: false }) }} </b-td>
                  <b-th>{{ $t('research_execution.payment_date') }}</b-th>
                  <b-td>{{ consultantDetailsData.payment_date | dateFormat }}</b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_execution.remarks') }}</b-th>
                  <b-td colspan="3">{{ consultantDetailsData.remark }} </b-td>
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
import { consultantPaymentDetail } from '../../api/routes'
import ExportPdf from './export_pdf_details'
import { dateFormat } from '@/utils/fliter'
export default {
  components: [dateFormat],
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
      consultantDetailsData: [],
      assignConsultantData: []
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
      const params = Object.assign({}, { id: this.item.id, document_type_id: this.item.document_type_id, research_request_id: this.item.research_request_id, contract_sign_id: this.item.contract_sign_id, resource_pool_id: this.item.resource_pool_id })
      RestApi.getData(bftiResReportServiceBaseUrl, consultantPaymentDetail, params).then(response => {
        if (response.success) {
          if (response.data) {
            this.consultantDetailsData = response.data
            this.assignConsultantData = response.assignConsultantData
            this.name = this.$i18n.locale === 'en' ? response.data.resource_pool.name_en : response.data.resource_pool.name_bn
            this.designation = this.$i18n.locale === 'en' ? response.data.resource_pool.designation : response.data.resource_pool.designation_bn
            this.organization = this.$i18n.locale === 'en' ? response.data.resource_pool.organization : response.data.resource_pool.organization_bn
            this.consultantDetailsData.client = this.$i18n.locale === 'en' ? this.consultantDetailsData.organization_ministry_division : this.consultantDetailsData.organization_ministry_division_bn

            if (this.consultantDetailsData.prepare_rfp) {
              this.consultantDetailsData.duration = this.consultantDetailsData.prepare_rfp !== undefined ? this.consultantDetailsData.prepare_rfp.duration : ''
            }
            if (this.consultantDetailsData.research) {
              this.consultantDetailsData.duration = this.consultantDetailsData.research !== undefined ? this.consultantDetailsData.research.duration : ''
            }
            this.loading = false

            // if (this.consultantDetailsData.rem_amount === 0) {
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
      const reportTitle = this.$t('research_execution.consultant_payment')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.item, this.consultantDetailsData, this.assignConsultantData)
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
