<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('eBizReports.evaluation_report')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row class="mt-4">
          <b-col lg="4" sm="4">
            <ValidationProvider name="Council" vid="council_info_id" rules="required|min_value:1">
                <b-form-group
                  label-for="council_info_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizReports.council')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="search.council_info_id"
                  :options="councilInfoList"
                  id="council_info_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col lg="4" sm="4">
            <ValidationProvider name="Association" vid="association_info_id" rules="">
                <b-form-group
                  label-for="association_info_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizReports.association')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.association_info_id"
                  :options="associationList"
                  id="association_info_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
          </ValidationProvider>
          </b-col>
           <b-col lg="4" sm="4">
              <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
            <b-form-group
              label-for="fiscal_year_id"
              slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fiscal_year_id"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
              </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{$t('globalTrans.search')}}</b-button>
          </b-col>
        </b-row>
        </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>
    <body-card style="overflow-x: clip;">
      <!-- <b-row class="text-right mb-5 mt-5">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                    {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
        </b-row> -->
      <!-- table section start -->
      <b-overlay :show="loading">
    <div>
          <b-row class="text-right mt-2">
          <b-col>
            <b-button @click="pdfExport" class="btn btn-success btn-md">
              <i class="ri-file-pdf-line"></i>  {{  $t('globalTrans.pdf') }}
            </b-button>
            <export-excel
                    class="btn btn-primary ml-2 mr-2"
                    :title="headerValue"
                    default-value="headerExcelDefault"
                    :data="excelData"
                    worksheet="Report Sheet"
                    name="evaluation_report.xls">
                    <i class="ri-file-excel-line"></i> {{ $t('globalTrans.export_excel') }}
            </export-excel>
          </b-col>
        </b-row>
        <div class="table-wrapper table-responsive" >
          <ReportHeading />
          <table class="table table-striped table-hover table-bordered">
          <tr>
            <th colspan="15" style="text-align: center;">{{ $t('eBizReports.evaluation_report') }}</th>
          </tr>
          <tr>
            <th>{{$t('globalTrans.sl_no')}}</th>
            <th>{{$t('globalTrans.fiscal_year')}}</th>
            <th>{{$t('eBizReports.proposal_no')}}</th>
            <th>{{$t('eBizReports.program_id')}}</th>
            <th>{{$t('eBizReports.program_name')}}</th>
            <th>{{$t('eBizReports.investigator_name')}}</th>
            <th>{{$t('globalTrans.remarks')}}</th>
          </tr>
            <template v-if="itemList && itemList.length > 0">
            <tr v-for="(item,index) in itemList" :key="index">
              <td>{{ $n(index + 1) }}</td>
              <td>{{ getFiscalYear(item.fiscal_year_id) }}</td>
              <td>{{ item.proposal_id }}</td>
              <td>{{ $n(item.program_id) }}</td>
              <td>{{ currentLocale == 'en' ? item.programe_name_en : item.programe_name_bn }}</td>
              <td>{{ currentLocale == 'en' ? item.investigator_name : item.investigator_name_bn }}</td>
              <td>{{ item.comment }}</td>
            </tr>
            </template>
             <template v-else>
                <tr>
                    <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                </tr>
            </template>
        </table>
        </div>
    </div>
      <!-- table section end -->
    </b-overlay>
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { MonitoringReport } from '../../api/routes'
import ReportHeading from '../../pages/report-heading/ReportHeading.vue'
import Pdf from './pdf'
import excel from 'vue-excel-export'
import Vue from 'vue'
import { dateFormat } from '@/utils/fliter'
Vue.use(excel)
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ReportHeading
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      dateFormat: dateFormat,
      search: {
      fiscal_year_id: 0,
      report_type_id: 0,
      council_info_id: 0,
      association_info_id: 0,
      fiscal_year_to_id: 0,
      is_monitor: 0
      },
      itemListGroup: [],
      itemList: [],
      associationList: [],
      show: false,
      loading: false
    }
  },
  created () {
  },
  watch: {
     'search.council_info_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
       this.associationList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === newVal)
      }
    }
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('eBizReports.bpc_text')
        headerVal[2] = this.$t('eBizReports.bpc_address')
        headerVal[3] = ''
        headerVal[4] = ''
        headerVal[5] = this.$t('eBizReports.evaluation_report')
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('eBizReports.bpc_text')
        headerVal[2] = this.$t('eBizReports.bpc_address')
        headerVal[3] = ''
        headerVal[4] = ''
        headerVal[5] = this.$t('eBizReports.evaluation_report')
        headerVal[6] = ''
      }
      return headerVal
    },
  excelData: function () {
      const listData = this.itemList
      var serial = 0
      const listContractor = listData.map(item => {
      serial++
          if (this.$i18n.locale === 'en') {
          return {
              'SL ': serial,
              'Fiscal Year': this.getFiscalYear(item.fiscal_year_id),
              'Proposal No': item.proposal_id,
              'Program No': this.$n(item.program_id),
              'Program Name': item.programe_name_en,
              'Investigator Name': item.investigator_name,
              'Comment ': item.comment
          }
          } else {
          return {
              'ক্রমিক নং ': this.$n(serial),
              'অর্থবছর ': this.getFiscalYear(item.fiscal_year_id),
              'প্রপোজাল নং': item.proposal_id,
              'প্রোগ্রাম আইডি ': this.$n(item.program_id),
              'প্রোগ্রামের নাম ': item.programe_name_bn,
              'তদন্তকারীর নাম ': item.investigator_name_bn,
              'মন্তব্য ': item.comment
          }
          }
      })
      return listContractor
    },
    currentLocale () {
        return this.$i18n.locale
    },
    reportType () {
      let typeList = [
        {
          value: '1',
          text_en: 'Numerical',
          text_bn: 'সংখ্যাসূচক'
        },
        {
            value: '2',
            text_en: 'Graph',
            text_bn: 'গ্রাফ'
        }
      ]
       typeList = typeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return typeList
    },
     councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    }
  },
  methods: {
    async searchData () {
      this.loadData = true
      this.loading = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(eBizServiceBaseUrl, MonitoringReport, params)
      if (result.success) {
          this.itemList = result.data.map((item, index) => {
             return Object.assign({}, item, { serial: index })
          })
          this.loadData = false
          this.show = true
          this.loading = false
      } else {
          this.loadData = false
          this.loading = false
      }
  },
  getFiscalYear (id) {
    const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
    if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
    } else {
        return ''
    }
  },
    pdfExport () {
      Pdf.exportPdfDetails(eBizServiceBaseUrl, '/configuration/report-heading/detail', 2, this.itemList, 0, this.search, this)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
