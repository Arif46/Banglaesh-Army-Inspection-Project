<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
            <b-col xs="4" sm="4" md="4" >
                <b-form-group
                    label-for="program_type_id"
                >
                    <template v-slot:label>
                        {{ $t('meeting_management.program_type_id') }}
                    </template>
                    <b-form-select
                        plain
                        v-model="search.program_type_id"
                        :options="programTypeList"
                        id="program_type_id"
                    >
                        <template v-slot:first>
                            <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                    </b-form-select>
                </b-form-group>
            </b-col>
            <b-col xs="4" sm="4" md="4" >
            <b-form-group
            label-for="title"
            >
            <template v-slot:label>
              {{ $t('research_execution.title_or_topic') }}
            </template>
            <b-form-input
            id="title"
            type="text"
            v-model="search.title"
            ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="4" sm="4" md="4" >
           <b-form-group
              label-for="start_date">
              <template v-slot:label>
                {{ $t('globalTrans.start_date') }}
              </template>
              <date-picker
                id="start_date"
                v-model="search.start_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
              >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="4" sm="4" md="4" >
           <b-form-group
              label-for="end_date">
              <template v-slot:label>
                {{ $t('globalTrans.end_date') }}
              </template>
              <date-picker
                id="end_date"
                v-model="search.end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
              >
              </date-picker>
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
            <h4 class="card-title">{{ $t('report_management.program_report') }}</h4>
          </template>
          <template v-slot:headerAction>
            <b-button class="btn-add" variant=" iq-bg-info" @click="pdfExport">
                {{ $t('globalTrans.print') }}
            </b-button>
            <export-excel
                class="btn btn-add btn-success ml-2"
                :data="excelData"
                :title="headerValue"
                :fields=excelFields
                worksheet="Report Sheet"
                :default-value="headerExcelDefault"
                name="program-report.xls">
              {{ $t('globalTrans.export_excel') }}
            </export-excel>
          </template>
          <template v-slot:body>
              <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
                <template v-slot:projectNameSlot>
                  {{ }}
                </template>
                {{ $t('report_management.program_report') }}
              </list-report-head>
              <b-row>
                <b-col md="6">
                  <span>{{ $t('meeting_management.program_type_id') }}</span>:
                  <strong>{{ search.program_type_id ? ($i18n.locale === 'en' ? searchHeaderData.rogram_type_en : searchHeaderData.rogram_type_bn) : $t('globalTrans.all') }}</strong>
                </b-col>
                <b-col md="6">
                  <span>{{ $t('research_execution.title_or_topic') }}</span>:
                  <strong>{{ search.title ? searchHeaderData.title : $t('globalTrans.all') }}</strong>
                </b-col>
                <b-col md="6">
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
                <b-col md="6">
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
              </b-row>
              <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                  <b-thead>
                      <b-tr>
                        <b-th style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                            <b-th style="width:10%" class="text-center">{{ $t('meeting_management.program_type_id') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('meeting_management.title') }}</b-th>
                            <b-th style="width:10%" class="text-center">{{ $t('meeting_management.organized_by') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('meeting_management.venue') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('meeting_management.total_participant') }}</b-th>
                            <b-th style="width:9%" class="text-center">{{ $t('meeting_management.program_date') }}</b-th>
                            <b-th style="width:7%" class="text-center">{{ $t('globalTrans.remarks') }}</b-th>
                      </b-tr>
                  </b-thead>
                  <b-tbody>
                      <template v-if="reportData.length">
                          <b-tr v-for="(item, index) in reportData" :key="index">
                                <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.rogram_type_en : item.rogram_type_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.title : item.title_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.organized_by : item.organized_by_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.venue : item.venue_bn }}</b-td>
                                <b-td class="text-center">{{ $n(item.total_participant) }}</b-td>
                                <b-td class="text-center">{{ item.program_date|dateFormat }}</b-td>
                                <b-td class="text-center">{{ item.remarks }}</b-td>
                          </b-tr>
                          <b-tr>
                            <b-th class="text-center" colspan="5">{{ $t('meeting_management.total_participant') }}</b-th>
                            <b-td class="text-left" colspan="3">{{ $n(getTotal(reportData)) }}</b-td>
                          </b-tr>
                      </template>
                      <template v-else>
                          <b-tr>
                              <b-td class="text-center" colspan="8">{{ $t('globalTrans.noDataFound') }}</b-td>
                          </b-tr>
                      </template>
                  </b-tbody>
              </b-table-simple>
          </template>
          <!-- table section end -->
        </body-card>
     </b-overlay>
    </div>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { programReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_list'
import excel from 'vue-excel-export'
import { dateFormat } from '@/utils/fliter'
import Vue from 'vue'
Vue.use(excel)

export default {
  components: {
    ListReportHead
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        program_type_id: 0,
        title: '',
        end_date: '',
        start_date: ''
      },
      searchHeaderData: {
        title: '',
        program_type_id: 0,
        rogram_type_en: '',
        rogram_type_bn: '',
        end_date: '',
        start_date: ''
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
    programTypeList () {
        return this.$store.state.BftiResearchAndReportService.commonObj.programTypeList.filter(item => item.status === 1)
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
        headerVal[3] = this.$t('report_management.program_report')
        headerVal[4] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report_management.program_report')
        headerVal[4] = ''
      }
      const docType = this.$t('meeting_management.program_type_id') +
          ' : ' + (this.search.program_type_id ? (local === 'en' ? this.searchHeaderData.rogram_type_en : this.searchHeaderData.rogram_type_bn) : this.$t('globalTrans.all')) + ' '
      const title = this.$t('research_execution.title_or_topic') + ' : ' + (this.search.title ? this.searchHeaderData.title : this.$t('globalTrans.all'))
      const startDate = this.$t('globalTrans.start_date') + ' : ' + (this.search.start_date ? dateFormat(this.search.start_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const endDate = this.$t('globalTrans.end_date') + ' : ' + (this.search.end_date ? dateFormat(this.search.end_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      headerVal[5] = docType + title
      headerVal[6] = startDate + endDate
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          // ' ': 'space',
          'ক্রমিক নং': 'serial',
          'প্রোগ্রামের ধরন': 'rogram_type',
          'প্রোগ্রামের শিরোনাম': 'title',
          'কার্যক্রম সংঘঠক': 'organized_by',
          স্থান: 'venue',
          'মোট অংশগ্রহণকারী': 'total_participant',
          'প্রোগ্রামের তারিখ': 'program_date',
          মন্তব্য: 'remarks'
        }
      } else {
        return {
          // ' ': 'space',
          'SL No': 'serial',
          'Document Type': 'rogram_type',
          'Topic/Title': 'title',
          'Mobile ': 'organized_by',
          Venue: 'venue',
          'Total Participant': 'total_participant',
          'Program Date': 'program_date',
          Remarks: 'remarks'
        }
      }
    },
    excelData: function () {
      const excelData = []
      this.reportData.forEach((item, index) => {
        excelData.push({
          serial: this.$n(index + 1),
          rogram_type: item?.rogram_type_en ? (this.$i18n.locale === 'en' ? item?.rogram_type_en : item?.rogram_type_bn) : ' ',
          title: item?.title ? (this.$i18n.locale === 'en' ? item?.title : item?.title_bn) : ' ',
          organized_by: item?.organized_by ? (this.$i18n.locale === 'en' ? item?.organized_by : item?.organized_by_bn) : ' ',
          venue: item?.venue ? (this.$i18n.locale === 'en' ? item?.venue : item?.venue_bn) : ' ',
          total_participant: this.$n(item.total_participant),
          program_date: dateFormat(item.program_date),
          remarks: item.remarks
        })
      })
      excelData.push({
        serial: ' ',
        rogram_type: ' ',
        title: ' ',
        organized_by: ' ',
        venue: this.$t('meeting_management.total_participant'),
        total_participant: this.$n(this.getTotal(this.reportData)),
        program_date: ' ',
        remarks: ' '
      })
      return excelData
    }
  },
  methods: {
    details (item) {
      this.item = item
      this.editItemId = item.id
    },
    getTotal (items) {
        let totalprice = 0
        Object.entries(items).forEach(([key, value]) => {
            totalprice = totalprice + parseInt(value.total_participant)
        })
        return totalprice
    },
    searchData () {
      this.loadData()
    },
    getProgramName (rogramTypeId) {
    const data = this.$store.state.BftiResearchAndReportService.commonObj.programTypeList.find(doc => doc.value === rogramTypeId)
    return data !== undefined ? data.text : ''
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
        const reportTitle = this.$t('report_management.program_report')
        ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this)
    },
    pdfExportDetails () {
      this.$refs.details.pdfExport()
    },
    async loadData () {
      this.showData = true
      if (this.search.program_type_id) {
        const rogramType = this.programTypeList.find(obj => obj.value === this.search.program_type_id)
        const customItem = {
          rogram_type_en: rogramType?.text_en,
          rogram_type_bn: rogramType?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      if (this.search.title) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { title: this.search.title })
      }
      if (this.search.start_date) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { start_date: this.search.start_date })
      }
      if (this.search.end_date) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { end_date: this.search.end_date })
      }
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, programReportList, params)
      if (result.success) {
        const listData = result.data.map(item => {
          const rogramType = this.programTypeList.find(obj => obj.value === item.program_type_id)
          const customItem = {
            rogram_type_en: rogramType?.text_en,
            rogram_type_bn: rogramType?.text_bn
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
