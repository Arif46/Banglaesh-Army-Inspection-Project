<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col xs="12" sm="12" md="6" >
                <b-form-group
                    label-for="document_type_id"
                >
                    <template v-slot:label>
                        {{ $t('bfti.doc_type') }}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.document_type_id"
                        :options="documentTypeList"
                        id="document_type_id"
                    >
                        <template v-slot:first>
                            <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                </b-form-group>
            </b-col>
          <b-col sm="6">
            <b-form-group
            label-for="topic"
            >
            <template v-slot:label>
              {{ $t('research_execution.title_or_topic') }}
            </template>
            <b-form-input
            id="topic"
            type="text"
            v-model="search.topic"
            ></b-form-input>
            </b-form-group>
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

    <div v-if="showData">
      <b-overlay :show="loading">
        <body-card>
          <!-- table section start -->
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('report_management.ledger_report') }}</h4>
          </template>
          <template v-slot:headerAction>
            <b-button class="btn-add" variant=" iq-bg-primary" @click="pdfExport">
                {{ $t('globalTrans.print') }}
            </b-button>
            <export-excel
                class="btn-add ml-2 cursor-pointer"
                :data="excelData"
                :title="headerValue"
                :fields=excelFields
                worksheet="Report Sheet"
                :default-value="headerExcelDefault"
                name="ledger_report.xls">
              {{ $t('globalTrans.export_excel') }}
            </export-excel>
          </template>
          <template v-slot:body>
              <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
                <template v-slot:projectNameSlot>
                  {{ }}
                </template>
                {{ $t('report_management.ledger_report') }}
              </list-report-head>
              <b-row>
                <b-col md="6">
                  <span>{{ $t('bfti.doc_type') }}</span>:
                  <strong>{{ search.document_type_id ? ($i18n.locale === 'en' ? searchHeaderData.document_type_en : searchHeaderData.document_type_bn) : $t('globalTrans.all') }}</strong>
                </b-col>
                <b-col md="6">
                  <span>{{ $t('research_execution.title_or_topic') }}</span>:
                  <strong>{{ search.topic ? searchHeaderData.topic : $t('globalTrans.all') }}</strong>
                </b-col>
              </b-row>
              <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                  <b-thead>
                      <b-tr>
                          <b-th style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th style="width:13%" class="text-center">{{ $t('meeting_management.doc_type') }}</b-th>
                          <b-th style="width:13%" class="text-center">{{ $t('research_execution.title_or_topic') }}</b-th>
                          <b-th style="width:13%" class="text-center">{{ $t('report_management.client') }}</b-th>
                          <b-th style="width:13%" class="text-center">{{ $t('research_plan_management.duration') }}</b-th>
                          <b-th style="width:7%" class="text-center">{{ $t('globalTrans.action') }}</b-th>
                      </b-tr>
                  </b-thead>
                  <b-tbody>
                      <template v-if="reportData.length">
                          <b-tr v-for="(item, index) in reportData" :key="index">
                              <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                              <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.document_type_en : item.document_type_bn }}</b-td>
                              <b-td class="text-center">
                                <!-- {{ ($i18n.locale === 'en') ? item.topic : item.topic_bn }} -->
                                <slot v-if="item.document_type_id === 2">
                                  {{ ($i18n.locale === 'bn') ? item.prepare_rfp.rfp_title_bn : item.prepare_rfp.rfp_title_en }}
                                </slot>
                                <slot v-else-if="item.document_type_id === 3">
                                  {{ ($i18n.locale === 'bn') ? item.research.topic_bn: item.research.topic }}
                                </slot>
                              </b-td>
                              <b-td class="text-center">
                                <slot v-if="item.document_type_id === 2">
                                  {{ ($i18n.locale === 'bn') ? item.prepare_rfp.client_bn : item.prepare_rfp.client }}
                                </slot>
                                <slot v-else-if="item.document_type_id === 3">
                                  {{ ($i18n.locale === 'bn') ? item.research.client_bn: item.research.client }}
                                </slot>
                              </b-td>
                              <b-td class="text-center">
                                <slot v-if="item.document_type_id === 2">
                                  {{ ($i18n.locale === 'bn') ? item.prepare_rfp.duration : item.prepare_rfp.duration }}
                                </slot>
                                <slot v-else-if="item.document_type_id === 3">
                                  {{ ($i18n.locale === 'bn') ? item.research.duration_bn: item.research.duration }}
                                </slot>
                              </b-td>
                              <b-td class="text-center">
                                  <b-button v-b-modal.details variant=" iq-bg-success mr-1" size="sm" :title="$t('globalTrans.view')"  @click="details(item)" class="action-btn active view">
                                      <i class="ri-eye-line m-0 "></i>
                                  </b-button>
                              </b-td>
                          </b-tr>
                      </template>
                      <template v-else>
                          <b-tr>
                              <b-td class="text-center" colspan="6">{{ $t('globalTrans.noDataFound') }}</b-td>
                          </b-tr>
                      </template>
                  </b-tbody>
              </b-table-simple>
          </template>
          <!-- table section end -->
        </body-card>
     </b-overlay>
    </div>
    <b-modal id="details" size="xl" title=""  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow-1">
        {{ $t('report_management.ledger_report') }} {{ $t('globalTrans.details') }}
        <b-button variant="info" @click="pdfExportDetails" class="mr-2 float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="editItemId" :key="editItemId" ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { ledgerReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_list'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
  components: {
    Details,
    ListReportHead
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        document_type_id: 3,
        topic: '',
        document_type_en: '',
        document_type_bn: ''
      },
      searchHeaderData: {
        topic: '',
        document_type_en: '',
        document_type_bn: ''
      },
      editItemId: 0,
      item: {},
      showData: false,
      reportData: [],
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
  },
  watch: {
  },
  computed: {
    documentTypeList () {
        return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.value === 2 || item.value === 3)
    },
    loading () {
      return this.$store.state.commonObj.loading
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
          সময়কাল: 'duration'
        }
      } else {
        return {
          // ' ': 'space',
          'SL No': 'serial',
          'Document Type': 'document_type',
          'Topic/Title': 'topic',
          'Mobile ': 'client',
          Duration: 'duration'
        }
      }
    },
    excelData: function () {
      const excelData = []
      this.reportData.forEach((item, index) => {
        let title = ''
        let client = ''
        let duration = ''
        if (item.document_type_id === 2) {
          title = this.$i18n.locale === 'en' ? item.prepare_rfp.rfp_title : item.prepare_rfp.rfp_title_bn
          client = this.$i18n.locale === 'en' ? item.prepare_rfp.client : item.prepare_rfp.client_bn
          duration = this.$i18n.locale === 'en' ? item.prepare_rfp.duration : item.prepare_rfp.duration
        }
        if (item.document_type_id === 3) {
          title = this.$i18n.locale === 'en' ? item.research.topic : item.research.topic_bn
          client = this.$i18n.locale === 'en' ? item.research.client : item.research.client_bn
          duration = this.$i18n.locale === 'en' ? item.research.duration : item.research.duration
        }
        excelData.push({
          serial: this.$n(index + 1),
          document_type: this.$i18n.locale === 'en' ? item?.document_type_en : item?.document_type_bn,
          topic: title,
          client: client,
          duration: duration
        })
      })
      return excelData
    }
  },
  methods: {
    details (item) {
      this.item = item
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    headerDataExcel () {
      RestApi.getData(bftiResReportServiceBaseUrl, '/configuration/report-head/detail/10').then(response => {
        if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === 11)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          this.headerExcelDefault.orgName = orgName
          this.headerExcelDefault.orgNameBn = orgNameBn
          this.headerExcelDefault.address = response.data.address
          this.headerExcelDefault.address_bn = response.data.address_bn
        }
      })
    },
    pdfExport () {
        const reportTitle = this.$t('report_management.ledger_report')
        ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    },
    pdfExportDetails () {
      this.$refs.details.pdfExport()
    },
    async loadData () {
      this.showData = true
      if (this.search.document_type_id) {
        const documentType = this.documentTypeList.find(obj => obj.value === this.search.document_type_id)
        const customItem = {
          document_type_en: documentType?.text_en,
          document_type_bn: documentType?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      if (this.search.topic) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { topic: this.search.topic })
      }
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, ledgerReportList, params)
      if (result.success) {
        const listData = result.data.map(item => {
          const documentType = this.documentTypeList.find(obj => obj.value === item.document_type_id)
          const customItem = {
            document_type_en: documentType?.text_en,
            document_type_bn: documentType?.text_bn
          }
          return Object.assign({}, item, customItem)
        })
        this.reportData = listData
      } else {
          this.reportData = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false })
    }
  }
}
</script>

<style>
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
