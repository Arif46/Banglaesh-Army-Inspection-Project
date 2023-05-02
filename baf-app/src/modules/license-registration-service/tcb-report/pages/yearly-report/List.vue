<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.year_stock_report_hq')}}</h4>
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
        <table class="table-sm">
          <tr>
            <th colspan="12" style="border: 1px solid grey;">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th colspan="12" style="border-right: 1px solid grey;border-left: 1px solid grey;border-top: 1px solid grey;">{{ $t('tcb_report.cms_and_bob') }}</th>
          </tr>
          <tr>
            <th colspan="12">{{ start_date | dateFormat }} - {{ end_date | dateFormat }} {{ $t('tcb_report.tcb_big_text_two') }}</th>
          </tr>
          <tr>
            <th>{{$t('globalTrans.sl_no')}}</th>
            <th>{{$t('tcb_report.regional_office')}}</th>
            <th>{{ start_date | dateFormat }} <br /> {{$t('tcb_report.beggining_of_date')}}</th>
            <th>{{$t('tcb_report.amount_received_from_supplier')}}</th>
            <th>{{$t('tcb_report.inter_warehouse_receipt_quantity')}}</th>
            <th>{{$t('tcb_report.inter_warehouse_send_amount')}}</th>
            <th>{{$t('tcb_report.sales_volume_a')}}</th>
            <th>{{$t('tcb_report.total_taka_of_goods')}}</th>
            <th>{{$t('tcb_report.amount_of_income_tax_at_source')}}</th>
            <th>{{$t('tcb_report.wastage')}}</th>
            <th>{{$t('tcb_report.wastage_pending')}}</th>
            <th>{{ end_date | dateFormat }} <br />{{$t('tcb_report.closing_stock_of_date')}}</th>
            <th>{{$t('tcb_report.comment')}}</th>
          </tr>
          <slot v-if="itemData.length > 0">
            <slot v-for="(itemcategry, index) in  itemCategoryList">
              <tr :key="index">
                <th colspan="12">{{$t('tcb_report.product_name_qty_metric_ton')}} {{ itemcategry.text }} {{ $t('tcb_report.metric_ton') }}</th>
              </tr>
              <tr :key="index">
                <th style="text-align: left">{{ $n('1') }}</th>
                <th style="text-align: center">{{ $n('2') }}</th>
                <th style="text-align: center">{{ $n('3') }}</th>
                <th style="text-align: center">{{ $n('4') }}</th>
                <th style="text-align: center">{{ $n('5') }}</th>
                <th style="text-align: center">{{ $n('6') }}</th>
                <th style="text-align: center">{{ $n('7') }}</th>
                <th style="text-align: center">{{ $n('8') }}</th>
                <th style="text-align: center">{{ $n('9') }}</th>
                <th style="text-align: center">{{ $n('10') }}</th>
                <th style="text-align: center">{{ $n('11') }}</th>
                <th style="text-align: center">{{ $n('12') }}</th>
                <th style="text-align: center">{{ $n('13') }}</th>
              </tr>
              <tr v-for="(office, ofIndex) in officeList" :key="ofIndex">
                <th style="text-align: left">{{ $n(ofIndex + 1) }}</th>
                <th style="text-align: center">{{getOfficeName(office)}}</th>
                <th style="text-align: center" v-if="prevstocks.length > 0"> {{ $n(getPrevStock(office, itemcategory)) }}</th>
                <th style="text-align: center" v-else>{{ $n(0) }}</th>
                <th style="text-align: center">{{ $n(getStockIn(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getRecInter(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getSendInter(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getSales(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getSaleAmount(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getTaxAmount(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getWastAmount(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getWastePending(office, itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getCurrentStock(office, itemcategry)) }}</th>
                <th style="text-align: center"></th>
              </tr>
              <tr :key="index">
                <th style="text-align: left"></th>
                <th style="text-align: center">{{$t('tcb_report.total_d')}}</th>
                <th style="text-align: center" v-if="prevstocks.length > 0"> {{ $n(getPrevTotal(itemcategory)) }}</th>
                <th style="text-align: center" v-else>{{ $n(0) }}</th>
                <th style="text-align: center">{{ $n(getStockInTotal(itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getRecInterTotal(itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getSendInterTotal(itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getSalesTotal(itemcategry)) }}</th>
                <th style="text-align: center"></th>
                <th style="text-align: center"></th>
                <th style="text-align: center">{{ $n(getWastAmountTotal(itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getWastePendingTotal(itemcategry)) }}</th>
                <th style="text-align: center">{{ $n(getCurrentStockTotal(itemcategry)) }}</th>
                <th style="text-align: center"></th>
              </tr>
            </slot>
          </slot>
        </table>
        <!-- table section end -->
      </b-overlay>
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { yearlyReportHq } from '../../api/routes'
import Pdf from './pdf'

export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      search: {
      fiscal_year_id: 0
      },
      start_date: '',
      end_date: '',
      itemData: [],
      officeList: [],
      prevstocks: [],
      loading: false
    }
  },
  created () {
  },
  watch: {
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const fiscalYear = this.fiscalYearList.find(item => item.value === newVal)
        this.start_date = fiscalYear.start_date
        this.end_date = fiscalYear.end_date
      }
    }
  },
  computed: {
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn), end_date: item.end_date, start_date: item.start_date }
        } else {
          return { value: item.value, text: item.text_en, end_date: item.end_date, start_date: item.start_date }
        }
      })
    }
  },
  methods: {
    pdfExport () {
      const reportTitle = this.$t('li_step.expiration_passed_report')
      Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.monthlyReport, this, this.start_date, this.end_date, this.itemData, this.itemCategoryList, this.officeList, this.prevstocks)
    },
    getOfficeName (officeId) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeId)
      return office.text
    },
    getStockIn (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_in
        })
        return amount
      } else {
        return 0
      }
    },
    getStockInTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_in
        })
        return amount
      } else {
        return 0
      }
    },
    getRecInter (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_received
        })
        return amount
      } else {
        return 0
      }
    },
    getRecInterTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_received
        })
        return amount
      } else {
        return 0
      }
    },
    getSendInter (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_transfer
        })
        return amount
      } else {
        return 0
      }
    },
    getSendInterTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_transfer
        })
        return amount
      } else {
        return 0
      }
    },
    getSales (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_truck_distribution + item.total_store_distribution
        })
        return amount
      } else {
        return 0
      }
    },
    getSalesTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_truck_distribution + item.total_store_distribution
        })
        return amount
      } else {
        return 0
      }
    },
    getSaleAmount (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.selling_amount
        })
        return amount
      } else {
        return 0
      }
    },
    getTaxAmount (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.tax_amount
        })
        return amount
      } else {
        return 0
      }
    },
    getWastAmount (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_out
        })
        return amount
      } else {
        return 0
      }
    },
    getWastAmountTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_out
        })
        return amount
      } else {
        return 0
      }
    },
    getWastePending (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_out_pending
        })
        return amount
      } else {
        return 0
      }
    },
    getWastePendingTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.total_stock_out_pending
        })
        return amount
      } else {
        return 0
      }
    },
    getCurrentStock (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.current_stock
        })
        return amount
      } else {
        return 0
      }
    },
    getCurrentStockTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.itemData.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.current_stock
        })
        return amount
      } else {
        return 0
      }
    },
    getPrevStock (officeId, category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.prevstocks.filter(item => item.office_id === officeId && item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.prev_stock
        })
        return amount
      } else {
        return 0
      }
    },
    getPrevTotal (category) {
      let amount = 0
      const categoryId = category.value
      const supData = this.prevstocks.filter(item => item.item_category_id === categoryId)
      if (supData.length > 0) {
        supData.forEach(item => {
          amount = amount + item.prev_stock
        })
        return amount
      } else {
        return 0
      }
    },
    async searchData () {
      this.loading = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, yearlyReportHq, params)
      if (result.success) {
          this.itemData = result.data
          this.officeList = result.officeList
          this.prevstocks = result.prevstocks
      }
      this.loading = false
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
