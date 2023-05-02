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
            <b-form-group
            label-for="policy_title"
            >
            <template v-slot:label>
              {{ $t('research_execution.title_or_topic') }}
            </template>
            <b-form-input
            id="policy_title"
            type="text"
            v-model="search.policy_title"
            ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4">
              <ValidationProvider name="Start date" vid="start_date" >
                <b-form-group label-for="start_date">
                <template v-slot:label>
                  {{ $t('globalTrans.date_from') }}
                </template>
                <date-picker
                  id="start_date"
                  v-model="search.start_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                >
                </date-picker>
                </b-form-group>
              </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="End date" vid="end_date" rules="''" >
                <b-form-group label-for="end_date">
                  <template v-slot:label>
                    {{ $t('globalTrans.date_to') }}
                  </template>
                  <date-picker
                  id="end_date"
                  v-model="search.end_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  >
                  </date-picker>
                </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Status" vid="status">
                  <b-form-group
                    label-for="status"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.status')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.status"
                      :options="statusList"
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
            <h4 class="card-title">{{ $t('report_management.policy_review_rocument_report') }}</h4>
          </template>
          <template v-slot:headerAction>
            <b-button class="btn-add" variant=" iq-bg-primary" @click="pdfExport">
                {{ $t('globalTrans.print') }}
            </b-button>
            <export-excel
            class="btn btn-add btn-success ml-2"
                :data="excelData"
                :title="headerValue"
                :fields=excelFields
                worksheet="Report Sheet"
                :default-value="headerExcelDefault"
                name="policy_review_rocument_report.xls">
              {{ $t('globalTrans.export_excel') }}
            </export-excel>
          </template>
          <template v-slot:body>
              <list-report-head :base-url="bftiResReportServiceBaseUrl" uri="/configuration/report-head/detail" :org-id="10">
                <template v-slot:projectNameSlot>
                  {{ }}
                </template>
                {{ $t('report_management.policy_review_rocument_report') }}
              </list-report-head>
              <b-row>
                <b-col md="6">
                  <span>{{ $t('research_execution.title_or_topic') }}</span>:
                  <strong>{{ search.policy_title ? searchHeaderData.policy_title : $t('globalTrans.all') }}</strong>
                </b-col>
                <b-col md="3">
                <span>{{ $t('globalTrans.date_from') }}</span>:
                  <strong>
                    <slot v-if="search.start_date">
                      {{search.start_date | dateFormat}}
                    </slot>
                    <slot v-else>
                      {{$t('globalTrans.all')}}
                    </slot>
                  </strong>
                </b-col>
                <b-col md="3">
                <span>{{ $t('globalTrans.date_to') }}</span>:
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
                            <b-th style="width:10%" class="text-center">{{ $t('report_management.client') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('policy_advocacy.policy_title') }}</b-th>
                            <b-th style="width:10%" class="text-center">{{ $t('report_management.date_request') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('policy_advocacy.focal_point_name') }}</b-th>
                            <b-th style="width:13%" class="text-center">{{ $t('policy_advocacy.focal_point_designation') }}</b-th>
                            <b-th style="width:9%" class="text-center">{{ $t('bfti.contact_number') }}</b-th>
                            <b-th style="width:7%" class="text-center">{{ $t('globalTrans.status') }}</b-th>
                            <b-th style="width:9%" class="text-center">{{ $t('report_management.date_status') }}</b-th>
                            <b-th style="width:7%" class="text-center">{{ $t('globalTrans.remarks') }}</b-th>
                      </b-tr>
                  </b-thead>
                  <b-tbody>
                      <template v-if="reportData.length">
                          <b-tr v-for="(item, index) in reportData" :key="index">
                                <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.organization : item.organization_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.policy_title : item.policy_title_bn }}</b-td>
                                <b-td class="text-center">{{ item.submission_date|dateFormat }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.name : item.name_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'en') ? item.designation : item.designation_bn }}</b-td>
                                <b-td class="text-center">{{ ($i18n.locale === 'bn') ? '০' : '0' }}{{ $n(item.contact_no, { useGrouping: false }) }}</b-td>
                                <b-td class="text-center">
                                  <span class="badge badge-success" v-if="item.status == 2">{{$t('globalTrans.approved')}}</span>
                                  <span class="badge badge-danger" v-else-if="item.status == 3">{{$t('globalTrans.rejected')}}</span>
                                  <span class="badge badge-info" v-else-if="item.status == 4">{{$t('research_execution.submitted')}}</span>
                                  <span class="badge badge-primary" v-else>{{$t('globalTrans.pending')}}</span>
                                </b-td>
                                <b-td class="text-center">
                                  <slot v-if="item.status === 1 || item.status === 2 || item.status === 3">
                                    {{ item.updated_at |dateFormat }}
                                  </slot>
                                  <slot v-else>
                                    <slot v-if="item.document_approve_status === 2">
                                      {{ item.submit_date |dateFormat }}
                                    </slot>
                                  </slot>
                                </b-td>
                                <b-td class="text-center">
                                   <slot v-if="item.status === 1 || item.status === 2 || item.status === 3">
                                    {{ item.remarks }}
                                  </slot>
                                  <slot v-else>
                                    <slot v-if="item.document_approve_status === 2">
                                      {{ item.submit_comment }}
                                    </slot>
                                  </slot>
                                </b-td>
                          </b-tr>
                      </template>
                      <template v-else>
                          <b-tr>
                              <b-td class="text-center" colspan="10">{{ $t('globalTrans.noDataFound') }}</b-td>
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
import { policyReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_list'
import excel from 'vue-excel-export'
import { dateFormat, mobileNumber } from '@/utils/fliter'
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
        policy_title: '',
        start_date: '',
        end_date: '',
        status: 0
      },
      searchHeaderData: {
        policy_title: '',
        start_date: '',
        end_date: '',
        status: 0
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
    statusList () {
      let statusList = [
        {
            value: 1,
            text_en: 'Pending',
            text_bn: 'মুলতুবি'
        },
        {
          value: 2,
          text_en: 'Approve',
          text_bn: 'অনুমোদন করুন'
        },
        {
          value: 3,
          text_en: 'Rejected',
          text_bn: 'বাতিল'
        },
        {
          value: 4,
          text_en: 'Submit',
          text_bn: 'জমা দিন'
        }
      ]
      statusList = statusList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return statusList
    },
    documentTypeList () {
        return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    loading () {
      return this.$store.state.commonObj.loading
    },
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (local === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('report_management.policy_review_rocument_report')
        headerVal[4] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('report_management.policy_review_rocument_report')
        headerVal[4] = ''
      }
      const policy = this.$t('research_execution.title_or_topic') + ' : ' + (this.search.policy_title ? this.searchHeaderData.policy_title : this.$t('globalTrans.all'))
      const startDate = this.$t('globalTrans.start_date') + ' : ' + (this.search.start_date ? dateFormat(this.search.start_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      const endDate = this.$t('globalTrans.end_date') + ' : ' + (this.search.end_date ? dateFormat(this.search.end_date) : this.$t('globalTrans.all')) + ';' + ' ' + ' ' + ' ' + ' '
      headerVal[5] = policy
      headerVal[6] = startDate + endDate
      return headerVal
    },
    excelFields: function () {
      if (this.$i18n.locale === 'bn') {
        return {
          // ' ': 'space',
          'ক্রমিক নং': 'serial',
          'ক্লায়েন্ট (মন্ত্রণালয়/সংস্থা/বিভাগ)': 'organization',
          'পলিসির শিরোনাম': 'policy_title',
          'অনুরোধের তারিখ': 'submission_date',
          'ফোকাল পয়েন্ট নাম': 'name',
          'ফোকাল পয়েন্ট পদবী': 'designation',
          'যোগাযোগকারী ব্যক্তির নম্বর': 'contact_no',
          অবস্থা: 'status',
          'অবস্থার তারিখ': 'updated_at',
          মন্তব্য: 'remarks'
        }
      } else {
        return {
          // ' ': 'space',
          'SL No': 'serial',
          'Client(Organization/Ministry/Division)': 'organization',
          'Policy Title': 'policy_title',
          'Date of Request': 'submission_date',
          'Focal Point Name': 'name',
          'Focal Point Designation': 'designation',
          'Contact Number': 'contact_no',
          Status: 'status',
          'Date of Status': 'updated_at',
          Remarks: 'remarks'
        }
      }
    },
    excelData: function () {
      const excelData = []
      this.reportData.forEach((item, index) => {
        let status = ''
          if (item.status === 5) {
            status = 'globalTrans.cancel'
          } else if (item.status === 2) {
            status = 'globalTrans.approved'
          } else if (item.status === 3) {
            status = 'globalTrans.rejected'
          } else if (item.status === 4) {
            status = 'globalTrans.submitted'
          } else {
            status = 'globalTrans.pending'
          }
        excelData.push({
          serial: this.$n(index + 1),
          organization: this.$i18n.locale === 'en' ? item?.organization : item?.organization_bn,
          policy_title: item?.policy_title ? (this.$i18n.locale === 'en' ? item?.policy_title : item?.policy_title_bn) : ' ',
          submission_date: dateFormat(item.submission_date),
          name: item?.name ? (this.$i18n.locale === 'en' ? item?.name : item?.name_bn) : ' ',
          designation: item?.designation ? (this.$i18n.locale === 'en' ? item?.designation : item?.designation_bn) : ' ',
          contact_no: mobileNumber(item.contact_no),
          status: this.$t(status),
          updated_at: dateFormat(item.updated_at),
          remarks: item?.remarks ? item.remarks : ' '

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
        const reportTitle = this.$t('report_management.policy_review_rocument_report')
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
      if (this.search.policy_title) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { policy_title: this.search.policy_title })
      }
      if (this.search.start_date) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { start_date: this.search.start_date })
      }
      if (this.search.end_date) {
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, { end_date: this.search.end_date })
      }
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, policyReportList, params)
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
