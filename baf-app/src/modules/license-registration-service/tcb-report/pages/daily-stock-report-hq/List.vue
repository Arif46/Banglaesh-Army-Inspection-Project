<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.daily_stock_report_hq')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row class="mt-4">
          <b-col lg="4" sm="4">
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
          <b-col lg="4" sm="4">
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
          <!-- <b-col lg="4" sm="4">
            <ValidationProvider name="date" vid="date" rules="required" v-slot="{ errors }">
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
            </ValidationProvider>
          </b-col> -->
          <b-col lg="4" sm="4">
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
      <b-overlay :show="loading">
      <b-row class="text-right mb-5 mt-5">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                    {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
      </b-row>
      <!-- table section start -->
    <div>
        <div class="table-wrapper table-responsive">
          <ReportHeading />
          <table class="table table-striped table-hover table-bordered">
            <!-- <tr>
              <td colspan="3" style="border-right-color: #fff;"><div><img src="@/assets/images/logo.png" style="width: 50%;" class="img-fluid" alt="" ></div></td>
              <td colspan="10" style="border-right-color: #fff;"><h5>{{$t('tcb_report.government_text')}}</h5>
                <p style="font-weight: 600;font-size: 20px;margin-top: 25px;">{{$t('tcb_report.trading_corporation_of_bangladesh')}}</p><p style="font-weight: 600;font-size: 12px;">{{$t('tcb_report.tcb_address')}}</p></td>
              <td colspan="3"><img style="width: 100%;" src="@/assets/images/tcb.jpg" class="img-fluid" alt=""></td>
            </tr> -->
          <tr class="bg-primary1" v-if="itemList.length > 0">
            <th colspan="13" style="text-align: left;">
              {{$t('tcb_report.daily_stock_report')}}
              <br/>
              {{$t('tcb_report.head_office')}}
            </th>
            <th colspan="3">{{$t('stock_management.date')}}: {{search_date |dateFormat}}</th>
          </tr>
          <!-- ===============Loop Start=================== -->
          <template v-if="itemList && itemList.length > 0">
            <template v-for="(item, index) in itemList" >
              <tr class="bg-primary1" :key="index">
                <th>{{$t('tcb_report.product_name')}}</th>
                <th colspan="15">{{ currentLocale === 'en'? item.item_name_en : item.item_name_bn}}</th>
              </tr>
              <tr class="bg-primary1" :key="index">
                <th rowspan="3">{{$t('globalTrans.date')}}</th>
                <th rowspan="3">{{$t('tcb_report.initial_stock_a')}}</th>
                <th colspan="4">{{$t('tcb_report.receive')}}</th>
                <th colspan="6">{{$t('tcb_report.distribution')}}</th>
                <th rowspan="3">{{$t('stock_management.stock_out')}} ({{$t('stock_management.approved')}})</th>
                <th rowspan="3">{{$t('stock_management.stock_out')}} ({{$t('stock_management.pending')}})</th>
                <th rowspan="3">{{$t('stock_management.on_transport')}}</th>
                <th rowspan="3">{{$t('tcb_report.closing_stock')}}</th>
              </tr>
              <tr class="bg-primary1" :key="index">
                  <th colspan="2">{{$t('tcb_report.supplier')}}</th>
                  <th rowspan="2">{{$t('tcb_report.inter_warehouse')}}</th>
                  <th rowspan="2">{{$t('tcb_report.total_d')}}</th>
                  <th rowspan="2">{{$t('tcb_report.inter_warehouse')}}</th>
                  <th colspan="2">{{$t('tcb_report.truck_sale')}}</th>
                  <th colspan="2">{{$t('tcb_report.store_allocation')}}</th>
                  <th rowspan="2">{{$t('tcb_report.total_d')}}</th>
              </tr>
              <tr class="bg-primary1" :key="index">
                  <th>{{$t('tcb_report.contact_no')}}</th>
                  <th>{{$t('tcb_report.quantity')}}</th>
                  <th>{{$t('tcb_report.number')}}</th>
                  <th>{{$t('tcb_report.quantity')}}</th>
                  <th>{{$t('tcb_report.number')}}</th>
                  <th>{{$t('tcb_report.quantity')}}</th>
              </tr>
              <tr :key="index">
            <td>{{ $n('1')}}</td>
            <td>{{ $n('2')}}</td>
            <td>{{ $n('3')}}</td>
            <td>{{ $n('4')}}</td>
            <td>{{ $n('5')}}</td>
            <td>{{ $n('6') + ' = (' + $n('4') + '+' + $n('5') + ')' }}</td>
            <td>{{ $n('7')}}</td>
            <td>{{ $n('8')}}</td>
            <td>{{ $n('9')}}</td>
            <td>{{ $n('10')}}</td>
            <td>{{ $n('11')}}</td>
            <td>{{ $n('12') + ' = (' + $n('7') + '+' + $n('9') + '+' + $n('11') + ')' }}</td>
            <td>{{ $n('13')}}</td>
            <td>{{ $n('14')}}</td>
            <td>{{ $n('15')}}</td>
            <td>{{ $n('16') + ' = (' + $n('2') + '+' + $n('6') + ') - (' + $n('12') + '+' + $n('13') + '+' + $n('14') + '+' + $n('15') + ')' }}</td>
          </tr>
              <template v-if="item.contractItems">
              <tr v-for="(sinContract, contIndex) in item.contractItems" :key="contIndex+1" style="margin-bottom: 15px;">
                <td>{{ sinContract.search_date | dateFormat }}</td>
                <td>{{ $n(sinContract.report_initial_stock) }}</td>
                <td>{{ sinContract.contractnum.contract_no}}</td>
                <td>{{ $n(sinContract.report_recive_supplier_contract_quantity)}}</td>
                <td>{{ $n(sinContract.report_receive_inter_warehouse)}}</td>
                <td>{{ $n(sinContract.report_receive_total)}}</td>
                <td>{{ $n(sinContract.report_distribution_inter_warehouse)}}</td>
                <td>{{ $n(sinContract.report_distribution_truck_sale_number)}}</td>
                <td>{{ $n(sinContract.report_distribution_truck_sale_quantity)}}</td>
                <td>{{ $n(sinContract.report_distribution_storeallo_number)}}</td>
                <td>{{ $n(sinContract.report_distribution_storeallo_quantity)}}</td>
                <td>{{ $n(sinContract.report_distribution_total)}}</td>
                <td>{{ $n(sinContract.report_stock_out_approved)}}</td>
                <td>{{ $n(sinContract.report_stock_out_pending)}}</td>
                <td>{{ $n(sinContract.report_on_transport)}}</td>
                <td>{{ $n(sinContract.report_closing_stock)}}</td>
              </tr>
            </template>
            </template>
          </template>
          <!-- ===============Loop End=================== -->
          <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
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
import { dailyStockReportHq } from '../../api/routes'
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
      bn_month: 0,
      date: null,
      days: 0
      },
      customYear: '',
      customMonth: '',
      customDate: '',
      search_date: '',
      valid: null,
      show: false,
      loadData: false,
      itemList: [],
      loading: false
    }
  },
  created () {
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const ficYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === newVal)
        if (this.customMonth !== '' && parseInt(this.customMonth) > 0) {
          let dateArr = []
          if (parseInt(this.customMonth) >= 7 && parseInt(this.customMonth) <= 12) {
              dateArr = ficYear.start_date.split('-')
              this.customYear = dateArr[0]
            } else {
              dateArr = ficYear.end_date.split('-')
              this.customYear = dateArr[0]
            }
        }
      }
    },
    'search.bn_month': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal > 0) {
        if (newVal < 10) {
          this.customMonth = '0' + newVal
        } else {
          this.customMonth = newVal
        }
        if (this.search.fiscal_year_id > 0) {
          const ficYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === this.search.fiscal_year_id)
          let dateArr = []
          if (newVal >= 7 && newVal <= 12) {
            dateArr = ficYear.start_date.split('-')
            this.customYear = dateArr[0]
          } else {
            dateArr = ficYear.end_date.split('-')
            this.customYear = dateArr[0]
          }
        }
      }
    },
    'search.date': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        let dateArr = []
        dateArr = newVal.split('-')
        this.customDate = dateArr[2]
      }
    }
  },
  computed: {
    currentLocale () {
            return this.$i18n.locale
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
    durationList: function () {
      const list = this.$store.state.commonObj.banglaMonthDays
        return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
        })
    }
  },
  methods: {
    pdfExport () {
        Pdf.exportPdfDetails(this, this.itemList)
    },
    async searchData () {
      this.loadData = true
      this.loading = true
      let result = null
      const day = this.search.days < 10 ? '0' + this.search.days : this.search.days
      const searchDate = this.customYear + '-' + this.customMonth + '-' + day
      const params = Object.assign({}, { search_date: searchDate })
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, dailyStockReportHq, params)
      if (result.success) {
        this.search_date = result.search_date
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
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
