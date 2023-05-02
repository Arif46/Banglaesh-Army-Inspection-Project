<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('eBizReports.periodical_report')}}</h4>
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
      <!-- table section start -->
      <b-overlay :show="loading">
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
                name="periodical_report.xls">
                <i class="ri-file-excel-line"></i> {{ $t('globalTrans.export_excel') }}
        </export-excel>
          </b-col>
      </b-row>
    <div>
        <div class="table-wrapper table-responsive" >
          <ReportHeading />
          <table class="table table-striped table-hover table-bordered">
          <tr>
            <th colspan="15" style="text-align: center;">{{ $t('eBizReports.periodical_report') }}</th>
          </tr>
          <tr>
            <th rowspan="2">{{$t('globalTrans.sl_no')}}</th>
            <th rowspan="2">{{$t('eBizReports.council')}}</th>
            <th rowspan="2">{{$t('eBizReports.association')}}</th>
            <th colspan="2">{{$t('globalTrans.fiscal_year') + ' ' + $n(1)}}</th>
            <th colspan="2">{{$t('globalTrans.fiscal_year') + ' ' + $n(2)}}</th>
            <th colspan="2">{{$t('globalTrans.fiscal_year') + ' ' +$n(3)}}</th>
          </tr>
            <tr>
              <th>{{$t('eBizReports.actual_budget')}} </th>
              <th>{{$t('eBizReports.actual_expense')}} </th>
              <th>{{$t('eBizReports.actual_budget')}} </th>
              <th>{{$t('eBizReports.actual_expense')}} </th>
              <th>{{$t('eBizReports.actual_budget')}} </th>
              <th>{{$t('eBizReports.actual_expense')}} </th>
            </tr>
            <template v-if="itemList && itemList.length > 0">
            <tr v-for="(item,index) in itemList" :key="index">
              <td>{{ $n(index + 1) }}</td>
              <td>{{ currentLocale == 'en' ? item.council_name_en : item.council_name_bn }}</td>
              <td>{{ currentLocale == 'en' ? item.association_name_en : item.association_name_bn }}</td>
              <td>{{ $n(item.fiscal_year_one_actual_budget) }}</td>
              <td>{{ $n(item.fiscal_year_one_payable) }}</td>
              <td>{{ $n(item.fiscal_year_two_actual_budget) }}</td>
              <td>{{ $n(item.fiscal_year_two_payable) }}</td>
              <td>{{ $n(item.fiscal_year_three_actual_budget) }}</td>
              <td>{{ $n(item.fiscal_year_three_payable) }}</td>
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
import { PeriodicalReport } from '../../api/routes'
import ReportHeading from '../../pages/report-heading/ReportHeading.vue'
import Pdf from './pdf'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ReportHeading
  },
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      search: {
      fiscal_year_id: 0,
      report_type_id: 0,
      council_info_id: 0,
      association_info_id: 0,
      fiscal_year_to_id: 0
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
        headerVal[5] = this.$t('eBizReports.periodical_report')
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('eBizReports.bpc_text')
        headerVal[2] = this.$t('eBizReports.bpc_address')
        headerVal[3] = ''
        headerVal[4] = ''
        headerVal[5] = this.$t('eBizReports.periodical_report')
        headerVal[6] = ''
      }
      return headerVal
    },
    currentLocale () {
        return this.$i18n.locale
    },
     councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
      excelData: function () {
      const listData = this.itemList
      var serial = 0
      const listContractorTwo = []
        if (this.$i18n.locale === 'en') {
          listContractorTwo.push({
              'SL No ': ' ',
              'Council ': ' ',
              'Association ': ' ',
              'Fiscal Year 1 ': 'Actual budget',
              ' ': 'Actual expense',
              'Fiscal Year 2 ': 'Actual budget',
              '  ': 'Actual expense',
              'Fiscal Year 3 ': 'Actual budget',
              '   ': 'Actual expense'
          })
          } else {
          listContractorTwo.push({
              'ক্রমিক নং ': ' ',
              'কাউন্সিল ': ' ',
              'সংগঠন ': ' ',
              'অর্থবছর ১': 'প্রকৃত বাজেট',
              ' ': 'প্রকৃত খরচ',
              'অর্থবছর ২': 'প্রকৃত বাজেট',
              '  ': 'প্রকৃত খরচ',
              'অর্থবছর ৩': 'প্রকৃত বাজেট',
              '   ': 'প্রকৃত খরচ'
          })
          }
      const listContractor = listData.map((item, index) => {
      serial++
          if (this.$i18n.locale === 'en') {
          return {
              'SL No ': serial,
              'Council ': item.council_name_en,
              'Association ': item.association_name_en,
              'Fiscal Year 1 ': item.fiscal_year_one_actual_budget,
              ' ': item.fiscal_year_one_payable,
              'Fiscal Year 2 ': item.fiscal_year_two_actual_budget,
              '  ': item.fiscal_year_two_payable,
              'Fiscal Year 3 ': item.fiscal_year_three_actual_budget,
              '   ': item.fiscal_year_three_payable
          }
          } else {
          return {
              'ক্রমিক নং ': this.$n(serial),
              'কাউন্সিল ': item.council_name_bn,
              'সংগঠন ': item.association_name_bn,
              'অর্থবছর ১': this.$n(item.fiscal_year_one_actual_budget),
              ' ': this.$n(item.fiscal_year_one_payable),
              'অর্থবছর ২': this.$n(item.fiscal_year_two_actual_budget),
              '  ': this.$n(item.fiscal_year_two_payable),
              'অর্থবছর ৩': this.$n(item.fiscal_year_three_actual_budget),
              '   ': this.$n(item.fiscal_year_three_payable)
          }
          }
      })
      listContractorTwo.push(...listContractor)
      return listContractorTwo
    }
  },
  methods: {
    async searchData () {
      this.loadData = true
      this.loading = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(eBizServiceBaseUrl, PeriodicalReport, params)
      if (result.success) {
          this.itemList = result.data.map((item, index) => {
             return Object.assign({}, item, { serial: index })
          })
          this.itemList.map((element) => {
            element.newobj = ''
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
      Pdf.exportPdfDetails(this, this.itemList)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
