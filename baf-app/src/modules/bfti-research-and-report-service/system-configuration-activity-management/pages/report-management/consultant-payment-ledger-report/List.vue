<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Document" vid="doc_type">
              <b-form-group
                label-for="doc_type"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('bfti.doc_type')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.document_type_id"
                  :options="docTypeList"
                  id="doc_type"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Title" vid="title">
              <b-form-group
                label-for="title"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('research_execution.title_or_topic')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.title_id"
                  :options="titleList"
                  id="title_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0> {{ load ? 'Loading ....' : $t('globalTrans.select') }} </b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('report_management.con_pay_report') + ' ' + $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="pdfExportList">
            {{ $t('globalTrans.print') }}
        </a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('report_management.con_pay_report') }}
          </list-report-head>
          <b-row>
            <b-col md="6">
              <span>{{ $t('bfti.doc_type') }}</span>:
              <strong>{{ search.document_type_id ? ($i18n.locale === 'en' ? searchHeaderData.document_type_en : searchHeaderData.document_type_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="6">
              <span>{{ $t('research_execution.title_or_topic') }}</span>:
              <strong>{{ search.title_id ? ($i18n.locale === 'en' ? searchHeaderData.title_en : searchHeaderData.title_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
          </b-row>
          <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="reportData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
            <template v-slot:cell(serial)="data">
              {{ $n(data.index + pagination.slOffset) }}
            </template>
            <template v-slot:cell(document_type_id)="data">
              {{ getDocumentTypeName(data.item.document_type_id) }}
            </template>
            <template v-slot:cell(client)="data">
              <slot v-if="data.item.document_type_id === 2">
                {{ ($i18n.locale === 'bn') ? data.item.prepare_rfp.client_bn : data.item.prepare_rfp.client }}
              </slot>
              <slot v-else-if="data.item.document_type_id === 3">
                {{ ($i18n.locale === 'bn') ? data.item.research.client_bn : data.item.research.client }}
              </slot>
            </template>
            <template v-slot:cell(title)="data">
              <slot v-if="data.item.document_type_id === 1">
                {{ ($i18n.locale === 'bn') ? data.item.prepare_eoi.title_bn : data.item.prepare_eoi.title }}
              </slot>
              <slot v-else-if="data.item.document_type_id === 2">
                {{ ($i18n.locale === 'bn') ? data.item.prepare_rfp.rfp_title_bn : data.item.prepare_rfp.rfp_title_en }}
              </slot>
              <slot v-else-if="data.item.document_type_id === 3">
                {{ ($i18n.locale === 'bn') ? data.item.research.topic_bn: data.item.research.topic }}
              </slot>
              <slot v-else-if="data.item.document_type_id === 4">
                {{ ($i18n.locale === 'bn') ? data.item.policy.policy_title_bn: data.item.policy.policy_title }}
              </slot>
            </template>
            <template v-slot:cell(date_from)="data">
              {{data.item.date_from|dateFormat}}
            </template>
            <template v-slot:cell(date_to)="data">
              {{data.item.date_to|dateFormat}}
            </template>
            <template v-slot:cell(amount)="data">
              {{ $n(data.item.amount, { useGrouping: false }) }}
            </template>
            <template v-slot:cell(action)="data">
                <b-button v-b-modal.details variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
            </template>
          </b-table>
          <!-- <base-table :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions"  /> -->
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="details" size="xl" :title="$t('report_management.con_payment') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <b-button @click="pdfExportDetails" class="ml-4 btn-success download-pdf-button">
        {{  $t('globalTrans.print') }}
      </b-button>
      <Details :items="item" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { consultantPaymentListReportRoute } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportListPdf from './export_pdf_list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    ListReportHead
  },
  data () {
    return {
      reportData: [],
      titleListData: [],
      load: false,
      item: {},
      sortDesc: true,
      sortDirection: 'desc',
      valid: false,
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        document_type_id: 0,
        title_id: 0
      },
      searchHeaderData: {
        title_en: '',
        title_bn: '',
        document_type_en: '',
        document_type_bn: ''
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'survey_management.research_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'report_management.client', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'research_execution.project_duration', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'research_execution.consultant_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'report_management.contract_date_from', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'report_management.contract_date_to', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '10%' } },
        { labels: 'task_activity_monitoring.contract_amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 10 }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.document_type_id': function (newVal, oldVal) {
      if (newVal) {
        this.documentWiseTitle()
      }
    }
  },
  computed: {
    titleList: function () {
      const listObject = this.titleListData
      const tmpList = listObject.map((obj, index) => {
        if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
        } else {
            return { value: obj.value, text: obj.text_en }
        }
      })
      return tmpList
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'document_type_id' },
          { key: 'topic_bn' },
          { key: 'client_bn' },
          { key: 'duration_bn' },
          { key: 'consultant_name_bn' },
          { key: 'date_from' },
          { key: 'date_to' },
          { key: 'amount' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type_id' },
          { key: 'topic' },
          { key: 'client' },
          { key: 'duration' },
          { key: 'consultant_name' },
          { key: 'date_from' },
          { key: 'date_to' },
          { key: 'amount' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    researchRequestList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.researchRequestList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
      this.item = item
    },
    async documentWiseTitle () {
      this.load = true
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, 'master-list', this.search)
      if (result.success) {
        this.titleListData = result.data
        this.load = false
      } else {
        this.titleListData = []
        this.load = false
      }
    },
    searchData () {
      this.loadData()
    },
    pdfExportList () {
        const reportTitle = this.$t('report_management.con_pay_report')
        ExportListPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    },
    pdfExportDetails () {
      this.$refs.details.pdfExport()
    },
    async loadData () {
      if (this.search.document_type_id) {
        const documentType = this.docTypeList.find(obj => obj.value === this.search.document_type_id)
        const customItem = {
          document_type_en: documentType?.text_en,
          document_type_bn: documentType?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      if (this.search.title_id) {
        const titleObj = this.titleListData.find(obj => obj.value === this.search.title_id)
        const titleData = {
          title_en: titleObj?.text_en,
          title_bn: titleObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, titleData)
      }
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, consultantPaymentListReportRoute, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const topicData = {}
          topicData.consultant_name = item.resource_pool.name_en
          topicData.consultant_name_bn = item.resource_pool.name_bn
          if (item.document_type_id === 2) {
            topicData.topic = item.prepare_rfp.rfp_title_en
            topicData.topic_bn = item.prepare_rfp.rfp_title_bn
            topicData.client = item.prepare_rfp.client
            topicData.client_bn = item.prepare_rfp.client_bn
            topicData.duration = item.prepare_rfp.duration
            topicData.duration_bn = item.prepare_rfp.duration // duration bn is not available in DB
          }
          if (item.document_type_id === 3) {
            topicData.topic = item.research.topic
            topicData.topic_bn = item.research.topic_bn
            topicData.client = item.research.client
            topicData.client_bn = item.research.client_bn
            topicData.duration = item.research.duration
            topicData.duration_bn = item.research.duration_bn
          }
          return Object.assign({}, item, { serial: index }, topicData)
        })
        this.reportData = listData
      } else {
        this.reportData = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
    }
  }
}
</script>
