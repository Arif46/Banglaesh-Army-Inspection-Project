<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.allocation_report')}}</h4>
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
                  :options="getRegionalOfficeList"
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
            <ValidationProvider name="Month" vid="bn_month" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="bn_month"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.month')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.bn_month"
                  :options="banglaMonthList"
                  id="bn_month"
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
                  id="bn_month"
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
            <!-- <ValidationProvider name="date" vid="date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="date">
                <template v-slot:label>
                  {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                </template>
                <b-form-datepicker b-form-datepicker
                  id="date"
                  v-model="search.date"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                </b-form-datepicker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider> -->
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
      <b-overlay :show="loading">
        <div>
            <div class="table-wrapper table-responsive" >
              <ReportHeading />
              <table class="table table-striped table-hover table-bordered" v-if="proItemList.length > 0">
              <tr>
                <th colspan="15" style="text-align: center;">{{ $t('tcb_report.allocation_report') }}</th>
              </tr>
              <tr>
                <th>{{$t('globalTrans.sl_no')}}</th>
                <th>{{$t('globalTrans.date')}}</th>
                <th>{{$t('tcb_report.company_name')}}</th>
                <th>{{$t('tcb_report.truck_no')}}</th>
                <th>{{$t('tcb_report.d_o_no')}}</th>
                <template v-if="proItemList && proItemList.length > 0">
                  <th v-for="(sinProItem, itemIndex) in proItemList" :key="itemIndex">{{currentLocale === 'en'? sinProItem.item_name_en : sinProItem.item_name_bn}}</th>
                </template>

                <th>{{$t('tcb_report.total_taka')}}</th>
                <th>{{$t('tcb_report.comment')}}</th>
              </tr>
              <template v-if="itemList && itemList.length > 0">
                <tr v-for="(sinItem, index) in itemList" :key="index">
                  <td>{{ $n(index+1) }}</td>
                  <td>{{ sinItem.letter_date | dateFormat }}</td>
                  <td>{{ currentLocale === 'en'? sinItem.company_name : sinItem.company_name_bn }}</td>
                  <td>--</td>
                  <td>{{ $n(sinItem.do_no) }}</td>
                  <template v-if="sinItem.itemArr && sinItem.itemArr.length > 0">
                  <td v-for="(sinExtItem, itemExtIndex) in sinItem.itemArr" :key="itemExtIndex+1">{{$n(sinExtItem)}}</td>
                </template>
                <td>{{ $n(sinItem.item_total_amt) }}</td>
                <td>--</td>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allcationReport } from '../../api/routes'
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
      date: null,
      bn_month: 0,
      customYear: '',
      customMonth: '',
      customDate: ''
      },
      proItemList: [],
      itemList: [],
      show: false,
      loading: false
    }
  },
  created () {
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const ficYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === newVal)
        if (this.search.customMonth !== '' && parseInt(this.search.customMonth) > 0) {
          let dateArr = []
          if (parseInt(this.search.customMonth) >= 7 && parseInt(this.search.customMonth) <= 12) {
              dateArr = ficYear.start_date.split('-')
              this.search.customYear = dateArr[0]
            } else {
              dateArr = ficYear.end_date.split('-')
              this.search.customYear = dateArr[0]
            }
        }
      }
    },
    'search.bn_month': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal > 0) {
        if (newVal < 10) {
          this.search.customMonth = '0' + newVal
        } else {
          this.search.customMonth = newVal
        }
        if (this.search.fiscal_year_id > 0) {
          const ficYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === this.search.fiscal_year_id)
          let dateArr = []
          if (newVal >= 7 && newVal <= 12) {
            dateArr = ficYear.start_date.split('-')
            this.search.customYear = dateArr[0]
          } else {
            dateArr = ficYear.end_date.split('-')
            this.search.customYear = dateArr[0]
          }
        }
      }
    },
    'search.date': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        let dateArr = []
        dateArr = newVal.split('-')
        this.search.customDate = dateArr[2]
      }
    }
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
    // getRegionalOfficeList (orgId = null) {
    //   const officeList = this.$store.state.CommonService.commonObj.officeList.map(item => {
    //     if (this.$i18n.locale === 'bn') {
    //       return { value: item.value, text: item.text_bn }
    //     } else {
    //       return { value: item.value, text: item.text_en }
    //     }
    //     })
    //   return officeList
    // },
    getRegionalOfficeList (orgId = null) {
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
    banglaMonthList () {
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
      this.loading = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allcationReport, params)
      if (result.success) {
        this.proItemList = result.proItemList
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
  EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    getOfficeName (id) {
      const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
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
    getMonthName (id) {
      const data = this.$store.state.commonObj.monthList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
      }
    },
    getReportTypeName (id) {
      return this.reportTypeList.find(item => item.value === id)
    },
    pdfExport () {
      Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.itemList, this.proItemList, this.search, this)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
