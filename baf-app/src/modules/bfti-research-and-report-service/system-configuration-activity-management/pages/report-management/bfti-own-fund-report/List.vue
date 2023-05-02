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
        <h4 class="card-title">{{ $t('report_management.bfti_own_fund') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="pdfExportList">
            {{ $t('globalTrans.print') }}
        </a>
        <export-excel
          class="btn-add ml-2 cursor-pointer"
          :data="excelData"
          :title="headerValue"
          :fields=excelFields
          worksheet="Report Sheet"
          :default-value="headerExcelDefault"
          name="bfti_own_fund_report.xls">
          {{ $t('globalTrans.export_excel') }}
        </export-excel>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('report_management.bfti_own_fund') }}
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
            <template v-slot:cell(usable_amount)="data">
              {{ $n(data.item.usable_amount, { useGrouping: false }) }}
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
          </b-table>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { BFTIOwnFundApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportListPdf from './export_pdf_list'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList],
  components: {
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
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'survey_management.research_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'research_execution.client', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'research_execution.project_duration', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } },
        { labels: 'globalTrans.amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '15%' } }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      },
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      }
    }
  },
  created () {
    this.headerDataExcel()
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
          { key: 'usable_amount' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type_id' },
          { key: 'topic' },
          { key: 'client' },
          { key: 'duration' },
          { key: 'usable_amount' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    researchRequestList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.researchRequestList.filter(item => item.status === 1)
    },
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report_management.ledger_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report.fine_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
        headerVal[7] = ''
      }
      const docType = this.$t('bfti.doc_type') +
          ' : ' + (this.search.document_type_id ? (local === 'en' ? this.searchHeaderData.document_type_en : this.searchHeaderData.document_type_bn) : this.$t('globalTrans.all')) + ' '
      const topic = this.$t('research_execution.title_or_topic') + ' : ' + (this.search.topic ? this.searchHeaderData.topic : this.$t('globalTrans.all'))
      headerVal[5] = docType + topic
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          // ' ': 'space',
          'ক্রমিক নং': 'serial',
          'নথিপত্রের ধরণ': 'document_type',
          'শিরোনাম/বিষয়': 'topic',
          'ক্লায়েন্ট (মন্ত্রণালয়/সংস্থা/বিভাগ)': 'client',
          সময়কাল: 'duration',
          'টাকার পরিমাণ': 'usable_amount'
        }
      } else {
        return {
          // ' ': 'space',
          'SL No': 'serial',
          'Document Type': 'document_type',
          'Topic/Title': 'topic',
          'Client(Organization/Ministry/Division) ': 'client',
          Duration: 'duration',
          Amount: 'usable_amount'
        }
      }
    },
    excelData: function () {
      const excelData = []
      this.reportData.forEach((item, index) => {
        let title = ''
        let client = ''
        let duration = ''
        let usableAmount = ''
        title = this.$i18n.locale === 'en' ? item.topic : item.topic_bn
        client = this.$i18n.locale === 'en' ? item.client : item.client_bn
        duration = this.$i18n.locale === 'en' ? item.duration : item.duration_bn
        usableAmount = this.$n(item.usable_amount, { useGrouping: false })
        excelData.push({
          serial: this.$n(index + 1),
          document_type: this.getDocumentTypeName(item.document_type_id),
          topic: title,
          client: client,
          duration: duration,
          usable_amount: usableAmount
        })
      })
      return excelData
    }
  },
  methods: {
    headerDataExcel () {
      RestApi.getData(bftiResReportServiceBaseUrl, '/configuration/report-head/detail/10').then(response => {
        if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === 10)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          this.headerExcelDefault.orgName = orgName
          this.headerExcelDefault.orgNameBn = orgNameBn
          this.headerExcelDefault.address = response.data.address
          this.headerExcelDefault.address_bn = response.data.address_bn
        }
      })
    },
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
        const reportTitle = this.$t('report_management.bfti_own_fund')
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
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, BFTIOwnFundApi, params)
      if (result.success) {
        const listData = result.data.map((item, index) => {
          const topicData = {}
            topicData.topic = item.topic
            topicData.topic_bn = item.topic_bn
            topicData.client = item.client
            topicData.client_bn = item.client_bn
            topicData.duration = item.duration
            topicData.duration_bn = item.duration_bn
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
