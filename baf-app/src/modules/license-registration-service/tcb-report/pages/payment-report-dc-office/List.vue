<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.payment_report')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
          <b-row class="mt-4">
          <b-col lg="4" sm="4">
              <ValidationProvider name="Regional Office" vid="regional_office" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="regional_office"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('organogram.regional_office_name')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.regional_office"
                    :options="regionalOfficeList"
                    id="org_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4">
              <ValidationProvider name="Report type" vid="report_type" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="report_type"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.report_type')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.report_type"
                    :options="reportTypeList"
                    id="org_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4" v-if="parseInt(search.report_type) === 1 || parseInt(search.report_type) === 2">
              <ValidationProvider name="Fiscal Year id" vid="fiscal_year_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="fiscal_year_id"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.fiscal_year_id"
                    :options="fiscalYearList"
                    @change="fiscalYearCahnge($event)"
                    id="fiscal_year_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4" v-if="parseInt(search.report_type) === 1 || parseInt(search.report_type) === 2">
              <ValidationProvider name="Month" vid="month" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="month"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.month')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.month"
                    :options="monthList"
                    id="month"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4" v-if="parseInt(search.report_type) === 2">
              <ValidationProvider name="Days" vid="days" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="days"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.days')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.days"
                    :options="durationList"
                    id="month"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4">
              <ValidationProvider name="DO no" vid="do_no">
                <b-form-group
                  class="row"
                  label-for="do_no"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.do_no')}}
                    </template>
                  <b-form-input
                    id="do_no"
                    v-model="search.do_no"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4">
              <ValidationProvider name="Agreement no" vid="agreement_no">
                <b-form-group
                  class="row"
                  label-for="agreement_no"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.agreement_no')}}
                    </template>
                  <b-form-input
                    id="agreement_no"
                    v-model="search.agreement_no"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="4" sm="4">
              <ValidationProvider name="Status" vid="status" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="status"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.status')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.status"
                    :options="statusList"
                    id="status"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
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
        <b-row class="text-right mb-5 mt-5">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                    {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
        </b-row>
      <!-- table section start -->
      <b-overlay :show="loader">
        <div>
            <div style="width:100%;overflow-x:auto;">
            <report-heading/>
            <table class="table-sm" style="margin:auto;" v-if="itemList.length > 0">
              <tr>
                <th colspan="15">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
              </tr>
              <tr>
                <th colspan="15" style="text-align: center;">{{ $t('tcb_report.payment_report') }}</th>
              </tr>
              <tr>
                <th rowspan="2">{{$t('globalTrans.sl_no')}}</th>
                <th rowspan="2">{{$t('globalTrans.date')}}</th>
                <th rowspan="2">{{$t('tcb_report.d_o_no')}}</th>
                <th rowspan="2">{{$t('tcb_report.institute_name')}}</th>
                <template v-if="proItemList && proItemList.length > 0">
                  <th colspan="2" v-for="(sinProItem, itemIndex) in proItemList" :key="itemIndex">{{currentLocale === 'en'? sinProItem.item_name_en : sinProItem.item_name_bn}}</th>
                </template>
                <th rowspan="2">{{$t('tcb_report.product_price')}}</th>
                <th rowspan="2">{{$t('tcb_report.selling_amount')}}</th>
                <th rowspan="2">{{$t('tcb_report.income_tax')}}</th>
                <th rowspan="2">{{$t('tcb_report.total_price')}}</th>
                <th rowspan="2">{{$t('tcb_report.money_receipt')}}</th>
                <th rowspan="2">{{$t('tcb_report.deposit_date')}}</th>
              </tr>
              <tr>
                <slot v-for="(sinExtItem, itemExtIndex) in proItemList">
                      <th :key="itemExtIndex+1">{{$t('tcb_report.quantity')}}</th>
                      <th :key="itemExtIndex + Math.floor(Math.random() * 10)">{{$t('tcb_report.price_a')}}</th>
                </slot>
              </tr>
              <template v-if="itemList && itemList.length > 0">
                <tr v-for="(report, index) in itemList" :key="index">
                  <td>{{$n(index+1)}}</td>
                  <td>{{report.letter_date | dateFormat}}</td>
                  <td>{{ $n(report.do_no) }}</td>
                  <td>{{report.company_name}}</td>
                    <template v-if="report.itemArr && report.itemArr.length > 0">
                       <td v-for="(sinExtItem, itemExtIndex) in report.itemArr" :key="itemExtIndex+1">{{$n(sinExtItem)}}</td>
                    </template>
                  <td>{{$n(report.total_price)}}</td>
                  <td>{{$n(report.selling_amount)}}</td>
                  <td>{{$n(report.tax_amount)}}</td>
                  <td>{{$n(report.selling_amount + report.tax_amount) }}</td>
                  <td>{{ report.transaction_no }}</td>
                  <td>{{ report.pay_date | dateFormat }}</td>
                </tr>
               </template>
            </table>
            </div>
        </div>
      </b-overlay>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paymentReport } from '../../api/routes'
import ReportHeading from '../../components/ReportHeading.vue'
import Pdf from './pdf'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ReportHeading
  },
  data () {
    return {
      search: {
      fiscal_year_id: 0,
      do_no: '',
      agreement_no: '',
      report_type: 0,
      status: 0,
      regional_office: 0,
      days: 0,
      start_date: '',
      end_date: '',
      month: 0
      },
      loader: false,
      fiscalYear: {},
      // reports: [],
      proItemList: [],
      itemList: [],
      show: false
    }
  },
  created () {
  },
  watch: {
  },
  computed: {
    currentLocale () {
        return this.$i18n.locale
    },
    durationList: function () {
      const list = this.$store.state.commonObj.banglaMonthDays
        return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
        })
    },
    regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    monthList () {
      return this.$store.state.commonObj.monthList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    reportTypeList () {
      let reportTypeList = [{
          value: '1',
          text_en: 'Monthly',
          text_bn: 'মাসিক'
      },
      {
          value: '2',
          text_en: 'Daily',
          text_bn: 'দৈনিক'
      }]
       reportTypeList = reportTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return reportTypeList
    },
    statusList () {
      let statusList = [
        {
            value: '1',
            text_en: 'Pending',
            text_bn: 'মুলতুবি'
        },
        {
            value: '2',
            text_en: 'Paid',
            text_bn: 'প্রদেয়'
        },
        {
            value: '3',
            text_en: 'Distribute',
            text_bn: 'বিতরণ'
        },
        {
            value: '4',
            text_en: 'Cancelled',
            text_bn: 'বাতিল'
        },
        {
            value: '5',
            text_en: 'Distributed',
            text_bn: 'বিতরণ করা হয়েছে'
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
    }
  },
  methods: {
   async searchData () {
      this.loadData = true
      this.loader = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, paymentReport, params)
      if (result.success) {
        this.proItemList = result.proItemList
          this.itemList = result.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
      })
          this.loadData = false
          this.show = true
          this.loader = false
      } else {
          this.loadData = false
          this.loader = false
      }
  },
  EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
  },
  fiscalYearCahnge (event) {
      this.fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === event)
      this.search.start_date = this.fiscalYear.start_date
      this.search.end_date = this.fiscalYear.end_date
  },
   getItemName (itemId) {
        const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
          if (itemObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return itemObj.text_bn
            } else {
                return itemObj.text_en
            }
        }
    },
  pdfExport () {
      const reportTitle = this.$t('li_step.expiration_passed_report')
      Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.monthlyReport, this, this.initial_stock, this.search, this.proItemList, this.itemList)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
