<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.daily_stock_report_regional')}}</h4>
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
                  :options="regionOfficeList"
                  id="org_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  @change="getWarehouse($event)"
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
      <!-- table section start -->
    <div>
      <b-row class="text-right mb-5 mt-5">
        <b-col>
            <b-button variant="primary" @click="pdfExport" class="mr-2">
                  {{  $t('globalTrans.print') }}
            </b-button>
        </b-col>
      </b-row>
      <report-heading/>
      <p class="mb-4 text-center mt-4">{{ $t('tcb_report.regional_office_camp') }} : {{ getOfficeName() }}</p>
      <b-overlay :show="loadData">
        <div style="width:100%;overflow-x:auto;">
          <table class="table-sm">
            <!-- <tr>
              <th colspan="21" style="border-right: 1px solid grey;border-left: 1px solid grey;border-top: 1px solid grey;"></th>
            </tr> -->
            <tr>
              <th colspan="6" style="text-align:left;border-right: 1px solid white;border-left: 1px solid grey;">{{ $t('tcb_report.date_a') }} : {{ this.search.search_date | dateFormat }}</th>
              <th colspan="15" style="text-align:right;border-right: 1px solid grey;">{{ $t('tcb_report.tcb_big_text') }}</th>
            </tr>
            <tr>
              <th rowspan="3">{{ $t('globalTrans.sl_no') }}</th>
              <th rowspan="3">{{ $t('tcb_report.product_name') }}</th>
              <th rowspan="3">{{ $t('tcb_report.brand_name') }}</th>
              <th rowspan="3">{{ $t('tcb_report.contact_no') }}</th>
              <th rowspan="3">{{ $t('tcb_report.initial_stock_a') }}</th>
              <th rowspan="3">{{ $t('tcb_report.receive_amount') }}</th>
              <th rowspan="3">{{ $t('tcb_report.total_stock_quantity') }}</th>
              <th rowspan="3">{{ $t('tcb_report.sending_to_different_warehouse') }}</th>
              <th rowspan="3">{{$t('stock_management.on_transport')}}</th>
              <th colspan="4">{{ $t('tcb_report.sales_volume_a') }}</th>
              <th rowspan="3">{{ $t('tcb_report.total_sales_amount') }}</th>
              <th rowspan="3">{{$t('stock_management.stock_out')}} ({{$t('stock_management.approved')}})</th>
              <th rowspan="3">{{$t('stock_management.stock_out')}} ({{$t('stock_management.pending')}})</th>
              <th rowspan="3">{{ $t('tcb_report.per_kg_liter_price') }}</th>
              <th rowspan="3">{{ $t('tcb_report.total_sell_price_taka') }}</th>
              <th rowspan="3">{{ $t('tcb_report.retail_salesCenter_reserves') }}</th>
              <th rowspan="3">{{ $t('tcb_report.closing_stock') }}</th>
              <th rowspan="3">{{ $t('tcb_report.comment') }}</th>
            </tr>
            <tr>
              <th colspan="2">{{ $t('tcb_report.truck_sale') }}</th>
              <th colspan="2">{{ $t('tcb_report.general_allotment') }}</th>
            </tr>
            <tr>
              <th>{{ $t('tcb_report.number') }}</th>
              <th>{{ $t('tcb_report.quantity') }}</th>
              <th>{{ $t('tcb_report.number') }}</th>
              <th>{{ $t('tcb_report.quantity') }}</th>
            </tr>
            <slot v-for="(item, index) in itemList">
              <tr :key="index + 1">
                  <td :rowspan="item.contractItems.length+1">{{ $n(index+1)}}</td>
                  <td :rowspan="item.contractItems.length+1">{{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}</td>
              </tr>
              <slot v-for="(innerItem, indx) in item.contractItems">
                <tr :key="index+ indx+ 2">
                  <td>{{  $i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name }}</td>
                  <td>{{ $n(innerItem.contractnum.contract_no) }}</td>
                  <td>{{ $n(innerItem.report_initial_stock) }}</td>
                  <td>{{ $n(innerItem.report_receive_total)}}</td>
                  <td>{{ $n(innerItem.report_initial_stock + innerItem.report_receive_total) }}</td>
                  <td>{{ $n(innerItem.report_distribution_inter_warehouse) }}</td>
                  <td>{{ $n(innerItem.report_on_transport)}}</td>
                  <td>{{ $n(innerItem.report_distribution_truck_sale_number)}}</td>
                  <td>{{ $n(innerItem.report_distribution_truck_sale_quantity)}}</td>
                  <td>{{ $n(innerItem.report_distribution_storeallo_number)}}</td>
                  <td>{{ $n(innerItem.report_distribution_storeallo_quantity)}}</td>
                  <td>{{ $n(innerItem.report_distribution_truck_sale_quantity + innerItem.report_distribution_storeallo_quantity + innerItem.report_distribution_inter_warehouse) }}</td>
                  <td>{{ $n(innerItem.report_stock_out_approved)}}</td>
                  <td>{{ $n(innerItem.report_stock_out_pending)}}</td>
                  <td>{{ $n(innerItem.selling_price) }}</td>
                  <td>{{ $n(innerItem.selling_price * innerItem.report_distribution_total) }}</td>
                  <td>{{ $n(0) }}</td>
                  <td>{{ $n(innerItem.report_closing_stock)}}</td>
                  <td></td>
                  <!-- <td>{{ $n(innerItem.report_receive_inter_warehouse)}}</td> -->
                </tr>
              </slot>
            </slot>
          </table>
        </div>
      </b-overlay>
    </div>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dailyStockReportRegion } from '../../api/routes'
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
      regional_office: 0,
      month: 0,
      date: 0,
      days: 0,
      warehouseList: [],
      search_date: ''
      },
      customYear: '',
      customMonth: '',
      customDate: '',
      show: false,
      loadData: false,
      itemList: []
    }
  },
  created () {
    // this.searchData()
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
    'search.month': function (newVal, oldVal) {
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
    regionOfficeList () {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
      return officeList
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
      const reportTitle = this.$t('li_step.expiration_passed_report')
      Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.itemList, this)
    },
    getOfficeName () {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(this.search.regional_office))
      if (typeof office !== 'undefined') {
        return office.text
      } else {
        return ''
      }
    },
    getWarehouse (officeId) {
      const warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === officeId)
      this.search.warehouseList = []
      warehouseList.forEach(item => {
        this.search.warehouseList.push(item.value)
      })
    },
    async searchData () {
       let result = null
      // const params = Object.assign({}, this.search)
      const day = this.search.days < 10 ? '0' + this.search.days : this.search.days
      const searchDate = this.customYear + '-' + this.customMonth + '-' + day
      this.search.search_date = searchDate
      const params = Object.assign({}, { search_date: searchDate, warehouseList: this.search.warehouseList })
      this.loadData = true
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, dailyStockReportRegion, params)
      this.loadData = false
      if (result.success) {
          this.itemList = result.data.map((item, index) => {
              return Object.assign({}, item, { serial: index })
          })
          this.show = true
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
@import '../../style.css';
</style>
