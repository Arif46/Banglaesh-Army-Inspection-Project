<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('eBizReports.YearWiseBAReports')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row class="mt-4">
          <b-col lg="4" sm="4">
            <ValidationProvider name="Report Type" vid="report_type_id" rules="required|min_value:1">
                <b-form-group
                  label-for="report_type_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('eBizReports.report_type')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="search.report_type_id"
                  :options="reportType"
                  id="report_type_id"
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
                name="year_wise_budget_approve_report.xls">
                <i class="ri-file-excel-line"></i> {{ $t('globalTrans.export_excel') }}
        </export-excel>
          </b-col>
      </b-row>
    <div>
        <div class="table-wrapper table-responsive" >
          <ReportHeading />
          <table class="table table-striped table-hover table-bordered">
          <tr>
            <th colspan="15" style="text-align: center;">{{ $t('eBizReports.YearWiseBAReports') }}</th>
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
              <th>{{$t('eBizReports.demand_budget')}} </th>
              <th>{{$t('eBizReports.approve_budget')}} </th>
              <th>{{$t('eBizReports.demand_budget')}} </th>
              <th>{{$t('eBizReports.approve_budget')}} </th>
              <th>{{$t('eBizReports.demand_budget')}} </th>
              <th>{{$t('eBizReports.approve_budget')}} </th>
            </tr>
            <template v-if="itemList && itemList.length > 0">
            <tr v-for="(item,index) in itemList" :key="index">
              <td>{{ $n(index + 1) }}</td>
              <td>{{ currentLocale == 'en' ? item.council_name_en : item.council_name_bn }}</td>
              <td>{{ currentLocale == 'en' ? item.association_name_en : item.association_name_bn }}</td>
              <td>{{ $n(item.demand_budget_one) }}</td>
              <td>{{ $n(item.approve_budget_one) }}</td>
              <td>{{ $n(item.demand_budget_two) }}</td>
              <td>{{ $n(item.approve_budget_two) }}</td>
              <td>{{ $n(item.demand_budget_three) }}</td>
              <td>{{ $n(item.approve_budget_three) }}</td>
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
import { yearWiseBudgetApproveReport } from '../../api/routes'
import ReportHeading from '../../pages/report-heading/ReportHeading.vue'
import Pdf from './pdf'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)
// import Pdf from './pdf'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ReportHeading
  },
  data () {
    return {
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
        headerVal[5] = this.$t('eBizReports.YearWiseBAReports')
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('eBizReports.bpc_text')
        headerVal[2] = this.$t('eBizReports.bpc_address')
        headerVal[3] = ''
        headerVal[4] = ''
        headerVal[5] = this.$t('eBizReports.YearWiseBAReports')
        headerVal[6] = ''
      }
      return headerVal
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
              'Fiscal Year 1 ': 'Demand Budget',
              ' ': 'Approve Budget',
              'Fiscal Year 2 ': 'Demand Budget',
              '  ': 'Approve Budget',
              'Fiscal Year 3 ': 'Demand Budget',
              '   ': 'Approve Budget'
          })
          } else {
          listContractorTwo.push({
              'ক্রমিক নং ': ' ',
              'কাউন্সিল ': ' ',
              'সংগঠন ': ' ',
              'অর্থবছর ১': 'চাহিদা বাজেট',
              ' ': 'বাজেট অনুমোদন',
              'অর্থবছর ২': 'চাহিদা বাজেট',
              '  ': 'বাজেট অনুমোদন',
              'অর্থবছর ৩': 'চাহিদা বাজেট',
              '   ': 'বাজেট অনুমোদন'
          })
          }
      const listContractor = listData.map((item, index) => {
      serial++
          if (this.$i18n.locale === 'en') {
          return {
              'SL No ': serial,
              'Council ': item.council_name_en,
              'Association ': item.association_name_en,
              'Fiscal Year 1 ': item.demand_budget_one,
              ' ': item.approve_budget_one,
              'Fiscal Year 2 ': item.demand_budget_two,
              '  ': item.approve_budget_two,
              'Fiscal Year 3 ': item.demand_budget_three,
              '   ': item.approve_budget_three
          }
          } else {
          return {
              'ক্রমিক নং ': this.$n(serial),
              'কাউন্সিল ': item.council_name_bn,
              'সংগঠন ': item.association_name_bn,
              'অর্থবছর ১': this.$n(item.demand_budget_one, { useGrouping: false }),
              ' ': this.$n(item.approve_budget_one, { useGrouping: false }),
              'অর্থবছর ২': this.$n(item.demand_budget_two, { useGrouping: false }),
              '  ': this.$n(item.approve_budget_two, { useGrouping: false }),
              'অর্থবছর ৩': this.$n(item.demand_budget_three, { useGrouping: false }),
              '   ': this.$n(item.approve_budget_three, { useGrouping: false })
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
      result = await RestApi.getData(eBizServiceBaseUrl, yearWiseBudgetApproveReport, params)
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
      Pdf.exportPdfDetails(this, this.itemList)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
