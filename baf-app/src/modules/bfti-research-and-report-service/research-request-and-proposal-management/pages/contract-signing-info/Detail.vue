<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.contract_signing_basic_info') }}</h4>
            </template>
            <template v-slot:body>
                <b-table-simple bordered>
                  <b-tr>
                    <b-th>{{ $t('configuration.document_type') }}</b-th>
                    <b-td colspan="3">{{ getDocumentTypeName(form.document_type_id) }}</b-td>
                  </b-tr>
                    <b-tr>
                    <b-th>{{ $t('globalTrans.title') }}</b-th>
                    <b-td colspan="3">
                      {{ getDocumentTitle(form.document_type_id) }}
                    </b-td>
                  </b-tr>
                  <b-tr>
                    <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                    <b-td colspan="3">{{ ($i18n.locale === 'bn') ? form.organization_ministry_division_bn : form.organization_ministry_division }}</b-td>
                  </b-tr>
                  <b-tr><b-th>{{ $t('researchRequestManagement.contract_sign') + ' ' + $t('globalTrans.date')}}</b-th>
                    <b-td colspan="3">{{ form.contract_date|dateFormat }}</b-td>
                  </b-tr>
                </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.budget_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th> {{ $t('researchRequestManagement.contract_amount') }}</b-th>
                  <b-th colspan="2"> {{ $n(form.contract_amount, { useGrouping: false }) }}</b-th>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('researchRequestManagement.installment') }}</b-th>
                  <b-th>{{$t('researchRequestManagement.payment_for')}}</b-th>
                  <b-th>{{ $t('researchRequestManagement.installment_amount') }}</b-th>
                </b-tr>
                <b-tr v-for="(item, index) in form.budgets" :key="index">
                <b-td> {{ getInstallmentName(item.installment_id) }} </b-td>
                <b-td> {{ item.payment_for }} </b-td>
                <b-td> {{ $n(item.installment_amount, { useGrouping: false }) }} </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.document_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('meeting_management.document_title') }}</b-th>
                  <b-th>{{$t('globalTrans.attachment')}}</b-th>
                </b-tr>
                <b-tr v-for="(item, index) in form.documents" :key="index">
                <b-td> {{ item.document_name }} </b-td>
                <b-td>
                  <b-button variant="success" class="btn-sm" target="_blank" :href="bftiResReportServiceBaseUrl + item.attachment">{{ $t('bfti.attachment_down') }}</b-button>
                  <!-- <a target="_blank" v-if="item.attachment" :href="bftiResReportServiceBaseUrl + item.attachment">{{ $t('bfti.attachment_down')}}</a>  -->
                </b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <!-- {{ form }} -->
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { contractSignDetailsApi } from '../../api/routes'
import ExportPdf from './export_pdf_details'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      userList: [],
      userLoading: false,
      form: {
        document_type_id: 0,
        contract_date: ''
      }
    }
  },
  watch: {
  },
  created () {
    if (this.id) {
      const tmp = this.DetailsData()
      this.form = tmp
    }
  },
  computed: {
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    DetailsData () {
      const loadingState = { loading: true, listReload: true }
      this.$store.dispatch('mutateCommonProperties', loadingState)
      const params = Object.assign({}, { id: this.id })
      RestApi.getData(bftiResReportServiceBaseUrl, contractSignDetailsApi, params).then(response => {
        if (response.success) {
          this.form = response.data
        }
        const loadingState = { loading: false, listReload: false }
        this.$store.dispatch('mutateCommonProperties', loadingState)
      })
    },
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
    },
    getInstallmentName (installmentID) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.budgetInstallmentList.find(installment => installment.value === installmentID)
      return data !== undefined ? data.text : ''
    },
    getDocumentTitle (documentTypeId) {
      if (documentTypeId === 1) {
        return this.$i18n.locale === 'bn' ? this.form.prepare_eoi.title_bn : this.form.prepare_eoi.title
      }

      if (documentTypeId === 2) {
        return this.$i18n.locale === 'bn' ? this.form.prepare_rfp.rfp_title_bn : this.form.prepare_rfp.rfp_title_en
      }

      if (documentTypeId === 3) {
        return this.$i18n.locale === 'bn' ? this.form.research.topic_bn : this.form.research.topic
      }

      if (documentTypeId === 4) {
        return this.$i18n.locale === 'bn' ? this.policy.policy_title_bn : this.form.policy.policy_title
      }
    },
    pdfExport () {
      const reportTitle = this.$t('researchRequestManagement.contract_signing')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this, this.form)
    }
  }
}
</script>
