<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.product_wise_monthly_report')}}</h4>
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
                  @change="getWarehouse($event)"
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
            <ValidationProvider name="Item Category" vid="item_category" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="item_category"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.item_category')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.item_category"
                  :options="itemCategoryList"
                  id="item_category"
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
            <ValidationProvider name="Item" vid="item" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="item"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.item')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.item"
                  :options="itemList"
                  id="item"
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
                  :options="MonthList"
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
        <report-heading/>
        <b-row>
        <b-col>
           {{$t('organogram.regional_office_name')}} : <strong>{{getOfficeName(search.regional_office) }} </strong>
        </b-col>
        <b-col>
          {{ $t('globalTrans.fiscal_year') }}: <strong>{{getFiscalYear(search.fiscal_year_id)}}</strong>
        </b-col>
        <b-col>
          {{ $t('tcb_report.month') }}: <strong> {{getMonthName(search.month)}} </strong>
        </b-col>
      </b-row>
        <table style="width:100%;padding:10px;margin-top:10px;" v-if="monthlyReport.length > 0">
          <tr>
            <th colspan="6">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th colspan="6" style="text-align: center;">{{ $t('tcb_report.product_wise_monthly_report') }}</th>
          </tr>
          <tr>
            <th>{{$t('globalTrans.sl_no')}}</th>
            <th>{{$t('globalTrans.date')}}</th>
            <th>{{$t('tcb_report.early')}}</th>
            <th>{{$t('tcb_report.receive')}}</th>
            <th>{{$t('tcb_report.supply')}}</th>
            <th>{{$t('tcb_report.conclusion')}}</th>
          </tr>
          <slot v-for="(report, index) in monthlyReport">
            <tr v-if="index == 0" :key="index">
              <td>{{$n(index+1)}}</td>
              <td>{{report.stock_date | dateFormat}}</td>
              <td :rowspan="monthlyReport.length">{{ $n(initial_stock) }}</td>
              <td>{{ $n(report.total_stock_in) }}</td>
              <td>{{$n(report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution)}}</td>
              <td>{{  $n(report.total_stock_in - (report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution)) }}</td>
            </tr>
            <tr v-if="index !== 0" :key="index">
              <td>{{$n(index+1)}}</td>
              <td>{{ report.stock_date | dateFormat }}</td>
              <td>{{ $n(report.total_stock_in) }}</td>
              <td>{{$n(report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution)}}</td>
              <td>{{$n(report.total_stock_in - (report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution))}}</td>
            </tr>
          </slot>
          <tr>
            <th colspan="5" class="text-right">{{$t('globalTrans.total')}} {{$t('tcb_report.conclusion')}}</th>
            <th>{{$n(totalConslussion(monthlyReport))}}</th>
          </tr>
        </table>
      </div>
        </b-overlay>
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { productWiseMonthlyReport } from '../../api/routes'
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
      start_date: '',
      end_date: '',
      month: 0,
      regional_office: 0,
      item: 0,
      warehouseList: [],
      item_category: 0
      },
      monthlyReport: [],
      initial_stock: 0,
      itemList: [],
      fiscalYear: {},
      show: false,
      loader: false
    }
  },
  created () {
  },
  watch: {
    'search.item_category': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === newVal)
      }
    }
  },
  computed: {
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
    MonthList () {
      return this.$store.state.commonObj.monthList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    }
  },
  methods: {
    totalConslussion (data) {
      let total = 0
      data.map(function (report, index) {
        total += report.total_stock_in - (report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution)
      })
      return total
    },
      async searchData () {
        this.loader = true
        const isValid = await this.$refs.form.validate()
        if (isValid) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          result = await RestApi.getData(licenseRegistrationServiceBaseUrl, productWiseMonthlyReport, this.search)
          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)

          if (result.success) {
            this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
            this.loader = false
            this.show = true
            this.initial_stock = result.data.initial_stock
            this.monthlyReport = result.data.monthlyStockReport
          } else {
            this.$refs.form.setErrors(result.errors)
          }
        }
      },
    getWarehouse (officeId) {
      // const isOrgAdmin = this.$store.state.Auth.authUser.org_admin
      const warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === officeId)
      // if (isOrgAdmin !== 1) {
      //   const officeId = this.$store.state.Auth.authUser.office_details.office_id
      //   const warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === officeId)
      // } else {
      //   const warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === officeId)
      // }
      this.search.warehouseList = []
      warehouseList.forEach(item => {
        this.search.warehouseList.push(item.value)
      })
    },
    getOfficeName (id) {
      const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
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
    getFiscalYear (id) {
      const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
          return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
          return ''
      }
    },
    fiscalYearCahnge (event) {
      this.fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === event)
      this.search.start_date = this.fiscalYear.start_date
      this.search.end_date = this.fiscalYear.end_date
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
          return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
          return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
      },
    pdfExport () {
          var categoryname = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === this.search.item_category)
          var itemname = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === this.search.item)
          const reportTitle = this.$t('li_step.expiration_passed_report')
          Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.monthlyReport, this, this.initial_stock, this.search, categoryname, itemname)
    }
  }
}
</script>
<style>
@import '../../style.css';
</style>
