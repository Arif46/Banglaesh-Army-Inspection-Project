<template>
  <body-card>
    <template v-slot:headerTitle>
      <h4 class="card-title">{{ $t('report_management.progress_report') }}</h4>
    </template>
    <template v-slot:headerAction>
      <a href="javascript:" class="btn-add" @click="pdfExport">
        {{ $t('globalTrans.print') }}
      </a>
      <export-excel
        class="btn btn-add btn-success ml-2"
        :title=headerValue
        :data=excelData
        :fields=excelFields
        worksheet="Report Sheet"
        name="progress-report.xls">
        {{ $t('globalTrans.export_excel') }}
      </export-excel>
    </template>
    <template v-slot:body>
      <b-row style="font-size: 13px">
        <b-col>
          <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('report_management.progress_report') }}
          </list-report-head>
          <b-row style="font-size:13  px">
            <b-col md="4">
              <span>{{ $t('bfti.doc_type') }}</span>:
              <strong>{{ search.document_type_id ? getColumnName($store.state.BftiResearchAndReportService.commonObj.documentTypeList, 'value', search.document_type_id)  : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4">
              <span>{{ $t('research_execution.title_or_topic') }}</span>:
              <strong>{{ search.title_id ? getColumnName(titleListData, 'value', search.title_id) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4">
              <span>{{ $t('globalTrans.start_date') }}</span>:
              <strong>
                <slot v-if="search.start_date">
                  {{search.start_date | dateFormat}}
                </slot>
                <slot v-else>
                  {{$t('globalTrans.all')}}
                </slot>
              </strong>
            </b-col>
            <b-col md="4">
              <span>{{ $t('globalTrans.end_date') }}</span>:
              <strong>
                <slot v-if="search.end_date">
                  {{search.end_date | dateFormat}}
                </slot>
                <slot v-else>
                  {{$t('globalTrans.all')}}
                </slot>
              </strong>
            </b-col>
            <b-col md="4">
              <span>{{ $t('globalTrans.status') }}</span>:
              <strong>{{ search.status ? getColumnName(statusList, 'value', search.status) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4">
              <span>{{ $t('globalTrans.contract_status') }}</span>:
              <strong>{{ search.contract_status ? getColumnName(yesNo, 'value', search.contract_status) : $t('globalTrans.all') }}</strong>
            </b-col>
          </b-row>
        </b-col>
      </b-row>
      <b-row>
        <b-col>
          <div class="table-responsive">
            <b-table-simple class="tg mt-3 report-table" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
              <b-thead>
                <b-tr>
                  <b-th style="width:7% !important" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.title') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.date_of_request') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.contact_person_name') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.contact_no') }}</b-th>
                  <b-th style="width:9% !important" class="text-center">{{ $t('globalTrans.contract_status') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('bfti.budget') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.status') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.date_of_status') }}</b-th>
                  <b-th style="width:10% !important" class="text-center">{{ $t('globalTrans.remarks') }}</b-th>
                </b-tr>
              </b-thead>
              <b-tbody>
                <template v-if="reportData.length">
                  <b-tr v-for="(item, index) in reportData" :key="index">
                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                    <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.topic : item.topic_bn }}</b-td>
                    <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.organization : item.organization_bn }}</b-td>
                    <b-td class="text-center">{{ item.submission_date| dateFormat }}</b-td>
                    <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.name : item.name_bn }}</b-td>
                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(item.contact_no, { useGrouping: false }) }}</b-td>
                    <b-td class="text-center">
                      <span class="badge badge-success" v-if="item.contact_status === 2">{{$t('globalTrans.yes')}}</span>
                      <span class="badge badge-danger" v-else>{{$t('globalTrans.no')}}</span>
                    </b-td>
                    <b-td class="text-center">
                      <slot v-if="item.contact_status === 2">
                        {{ $n(item.contract_amount, { useGrouping: false }) }}
                      </slot>
                    </b-td>
                    <b-td class="text-center">
                      <span class="badge badge-danger" v-if="item.document_approve_status == 5">{{$t('globalTrans.cancel')}}</span>
                      <span class="badge badge-danger" v-else-if="item.document_approve_status == 4">{{$t('research_execution.non_awarded')}}</span>
                      <span class="badge badge-success" v-else-if="item.document_approve_status == 3">{{$t('research_execution.awarded')}}</span>
                      <span class="badge badge-info" v-else-if="item.document_approve_status == 2">{{$t('globalTrans.submitted')}}</span>
                      <span class="badge badge-primary" v-else>{{$t('globalTrans.pending')}}</span>
                    </b-td>
                    <b-td class="text-center">
                      <slot v-if="item.document_approve_status == 5">{{ item.cancel_date| dateFormat }}</slot>
                      <slot v-else-if="item.document_approve_status == 4">{{ item.non_awarded_date| dateFormat }}</slot>
                      <slot v-else-if="item.document_approve_status == 3">{{ item.awarded_date| dateFormat }}</slot>
                      <slot v-else-if="item.document_approve_status == 2">{{ item.submit_date| dateFormat }}</slot>
                    </b-td>
                    <b-td class="text-center">
                      <slot v-if="item.document_approve_status == 5">{{ item.cancel_comment }}</slot>
                      <slot v-else-if="item.document_approve_status == 4">{{ item.non_awarded_comment }}</slot>
                      <slot v-else-if="item.document_approve_status == 3">{{ item.awarded_comment }}</slot>
                      <slot v-else-if="item.document_approve_status == 2">{{ item.submit_comment }}</slot>
                    </b-td>
                  </b-tr>
                </template>
                <template v-else>
                  <b-tr>
                    <b-td class="text-center text-danger" colspan="12">{{ $t('globalTrans.noDataFound') }}</b-td>
                  </b-tr>
                </template>
              </b-tbody>
            </b-table-simple>
          </div>
        </b-col>
      </b-row>
    </template>
  </body-card>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { progressReportApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './research_export_pdf_list'
import excel from 'vue-excel-export'
import { dateFormat } from '@/utils/fliter'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList],
  props: ['search', 'reportData', 'headerExcelDefault', 'statusList', 'yesNo', 'titleListData'],
  components: {
    ListReportHead
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      editItemId: 0,
      item: {},
      showData: false,
      load: false
    }
  },
  mounted () {
    // this.loadData()
  },
  watch: {
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (local === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report_management.progress_report')
        headerVal[4] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report_management.progress_report')
        headerVal[4] = ''
      }
      const doctype = this.$t('bfti.doc_type') + ' : ' + (this.search.document_type_id ? this.getColumnName(this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList, 'value', this.search.document_type_id) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const titleOrTopic = this.$t('research_execution.title_or_topic') + ' : ' + (this.search.title_id ? this.getColumnName(this.titleListData, 'value', this.search.title_id) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const startDate = this.$t('globalTrans.start_date') + ' : ' + (this.search.start_date ? dateFormat(this.search.start_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const endDate = this.$t('globalTrans.end_date') + ' : ' + (this.search.end_date ? dateFormat(this.search.end_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const status = this.$t('globalTrans.status') + ' : ' + (this.search.status ? this.getColumnName(this.statusList, 'value', this.search.status) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const contractStatus = this.$t('globalTrans.contract_status') + ' : ' + (this.search.contract_status ? this.getColumnName(this.yesNo, 'value', this.search.contract_status) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      headerVal[5] = doctype + titleOrTopic + startDate
      headerVal[6] = endDate + status + contractStatus
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          'ক্রমিক নং': 'serial',
          শিরোনাম: 'title',
          'মন্ত্রণালয়/সংস্থা/বিভাগ ': 'organization',
          'অনুরোধ তারিখ ': 'submission_date',
          'যোগাযোগ ব্যক্তিগত নাম': 'name',
          'যোগাযোগের নম্বর': 'contact_no',
          'চুক্তি বিবরণ ': 'contract_status',
          'বাজেট ': 'contract_amount',
          অবস্থা: 'status',
          'স্ট্যাটাসের তারিখ': 'status_date',
          'মন্তব্য ': 'comment'
        }
      } else {
        return {
          'SL No': 'serial',
          Title: 'title',
          'Organization/Ministry/Division': 'organization',
          'Date of Request': 'submission_date',
          'Contact Person No': 'name',
          'Contact No': 'contact_no',
          'Contract Status': 'contract_status',
          'Budget ': 'contract_amount',
          Status: 'status',
          'Date of Status': 'status_date',
          Remarks: 'comment'
        }
      }
    },
    excelData: function () {
      const excelData = []
      if (this.reportData.length > 0) {
        this.reportData.forEach((item, firstIndex) => {
          let status = ''
          if (item.document_approve_status === 5) {
            status = 'globalTrans.cancel'
          } else if (item.document_approve_status === 4) {
            status = 'research_execution.non_awarded'
          } else if (item.document_approve_status === 3) {
            status = 'research_execution.awarded'
          } else if (item.document_approve_status === 2) {
            status = 'globalTrans.submitted'
          } else {
            status = 'globalTrans.pending'
          }
          let statusDate = ''
          if (item.document_approve_status === 5) {
            statusDate = dateFormat(item.cancel_date)
          } else if (item.document_approve_status === 4) {
            statusDate = dateFormat(item.non_awarded_date)
          } else if (item.document_approve_status === 3) {
            statusDate = dateFormat(item.awarded_date)
          } else if (item.document_approve_status === 2) {
            statusDate = dateFormat(item.submit_date)
          }
          let statusComment = ''
          if (item.document_approve_status === 5) {
            statusComment = item.cancel_comment
          } else if (item.document_approve_status === 4) {
            statusComment = item.non_awarded_comment
          } else if (item.document_approve_status === 3) {
            statusComment = item.awarded_comment
          } else if (item.document_approve_status === 2) {
            statusComment = item.submit_comment
          }
          let contractStatus = 'No'
          if (item.contact_status === 2) {
            contractStatus = 'Yes'
          }
          let contactAmount = ''
          if (item.contact_status === 2) {
            contactAmount = this.$n(item.contract_amount, { useGrouping: false })
          }
          excelData.push({
            serial: this.$n(firstIndex + 1),
            title: (this.$i18n.locale === 'en') ? item.topic : item.topic_bn,
            organization: (this.$i18n.locale === 'en') ? item.organization : item.organization_bn,
            submission_date: dateFormat(item.submission_date),
            name: (this.$i18n.locale === 'en') ? item.name : item.name_bn,
            contact_no: '০' + this.$n(item.contact_no, { useGrouping: false }),
            contract_status: contractStatus,
            contract_amount: contactAmount,
            status: this.$t(status),
            status_date: statusDate,
            comment: statusComment
          })
        })
        return excelData
      } else {
        excelData.push({
          serial: '',
          title: '',
          organization: '',
          submission_date: '',
          name: '',
          contact_no: '',
          contract_status: '',
          contract_amount: '',
          status: '',
          status_date: '',
          comment: ''
        })
        return excelData
      }
    }
  },
  methods: {
    getColumnName (list, field, groupId) {
      const obj = list.find(item => parseInt(item[field]) === parseInt(groupId))
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return obj.text_bn
        } else {
          return obj.text_en
        }
      } else {
        return ''
      }
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
    details (item) {
      this.item = item
      this.editItemId = item.id
    },
    searchData () {
      this.loadData()
    },
    pdfExport () {
      const reportTitle = this.$t('report_management.progress_report')
      ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    },
    async loadData () {
      this.showData = true
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, progressReportApi, params)
      if (result.success) {
        this.reportData = result.data
      } else {
        this.reportData = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
