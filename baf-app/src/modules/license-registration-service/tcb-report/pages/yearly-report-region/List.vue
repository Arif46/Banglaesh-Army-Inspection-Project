<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.yearly_report_regional')}}</h4>
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
    <body-card >
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
        <div class="table-wrapper table-responsive" mt-2>
          <ReportHeading />
          <table class="table table-striped table-hover table-bordered">
            <!-- <tr>
              <td colspan="4" style="border-right-color: #fff;"><div><img src="@/assets/images/logo.png" style="width: 50%;" class="img-fluid" alt="" ></div></td>
              <td colspan="13" style="border-right-color: #fff;"><h5>{{$t('tcb_report.government_text')}}</h5>
                <p style="font-weight: 600;font-size: 20px;margin-top: 25px;">{{$t('tcb_report.trading_corporation_of_bangladesh')}}</p><p style="font-weight: 600;font-size: 12px;">{{$t('tcb_report.tcb_address')}}</p></td>
              <td colspan="4"><img style="width: 100%;" src="@/assets/images/tcb.jpg" class="img-fluid" alt=""></td>
            </tr> -->
          <tr>
            <th colspan="21" >{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th colspan="21">{{ $t('tcb_report.regional_office_name') }} : {{ currentLocale === 'en'? regoOfficeName_en : regoOfficeName_bn}}</th>
          </tr>
          <tr>
            <th colspan="21" style="text-align:left;">{{ $t('tcb_report.subject') }}{{$n(search.fis_custom_start_year, { useGrouping: false })}} - {{ $n(search.fis_custom_end_year, { useGrouping: false }) }} {{ $t('tcb_report.tcb_big_text_three') }}</th>
          </tr>
          <tr v-if="itemList.length > 0">
            <th rowspan="3">{{$t('globalTrans.sl_no')}}</th>
            <th rowspan="3">{{$t('tcb_report.product_name')}}</th>
            <th rowspan="3">{{$t('tcb_report.contact_no_and_brand')}}</th>
            <th rowspan="3">{{$t('tcb_report.july_2020_date_opening_stock')}} {{search.fis_start_date | dateFormat}}</th>
            <th colspan="8">{{search.fis_start_date | dateFormat}} {{ $t('tcb_report.date_range_status') }} {{search.fis_end_date | dateFormat}} {{$t('tcb_report.from_to_send_receive_one')}}</th>
            <th rowspan="3">{{$t('tcb_report.total_stock_quantity')}}</th>
            <th colspan="5">{{$t('tcb_report.inter_warehouse_send_amount')}}</th>
            <th rowspan="3">{{$t('tcb_report.june_2021_closing_stock')}} {{search.fis_end_date | dateFormat}}</th>
            <th rowspan="3">{{$t('tcb_report.june_2021_closing_stock_taka')}} {{search.fis_end_date | dateFormat}}</th>
            <th rowspan="3">{{$t('tcb_report.comment')}}</th>
          </tr>
          <tr>
            <th colspan="2">{{$t('tcb_report.received_from_supplier')}}</th>
            <th colspan="3">{{$t('tcb_report.inter_warehouse_receipt')}}</th>
            <th colspan="3">{{$t('tcb_report.inter_warehouse_send')}}</th>
            <th rowspan="2">{{$t('tcb_report.truck_sale')}}</th>
            <th rowspan="2">{{$t('tcb_report.online')}}</th>
            <th rowspan="2">{{$t('tcb_report.general_allotment')}}</th>
            <th rowspan="2">{{$t('tcb_report.total_sell')}}</th>
            <th rowspan="2">{{$t('tcb_report.sold_product_price')}}</th>
          </tr>
          <tr>
            <th>{{$t('tcb_report.quantity')}}</th>
            <th>{{$t('tcb_report.receive_date')}}</th>
            <th>{{$t('tcb_report.quantity')}}</th>
            <th>{{$t('tcb_report.receive_date')}}</th>
            <th>{{$t('tcb_report.office_name')}}</th>
            <th>{{$t('tcb_report.quantity')}}</th>
            <th>{{$t('tcb_report.send_date')}}</th>
            <th>{{$t('tcb_report.office_name')}}</th>
          </tr>
          <tr>
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
            <th style="text-align: center">{{ $n('13') + ' = (' + $n('5') + '+' + $n('7') + '+' + $n('10') + ')' }}</th>
            <th style="text-align: center">{{ $n('14') }}</th>
            <th style="text-align: center">{{ $n('15') }}</th>
            <th style="text-align: center">{{ $n('16') }}</th>
            <th style="text-align: center">{{ $n('17') + ' = (' + $n('14') + '+' + $n('15') + '+' + $n('16') + ')' }}</th>
            <th style="text-align: center">{{ $n('18') }}</th>
            <th style="text-align: center">{{ $n('19') }}</th>
            <th style="text-align: center">{{ $n('20') }}</th>
            <th style="text-align: center">{{ $n('21') }}</th>
          </tr>
          <slot v-if="itemList.length > 0">
          <slot v-for="(item, itIndex) in itemList">
          <slot v-for="(sinItemRow, stIndex) in item.itemRow">
          <tr v-if="stIndex == 0" :key="stIndex">
            <td style="text-align: left" :rowspan="item.itemRow.length + 1">{{ $n(itIndex + 1) }}</td>
            <td style="text-align: center" :rowspan="item.itemRow.length + 1">{{ currentLocale === 'en'? item.item_name_en : item.item_name_bn}}</td>
            <td style="text-align: center">{{ $n(sinItemRow.contract_number, { useGrouping: false }) }}</td>
            <td style="text-align: center" :rowspan="item.itemRow.length">{{item.report_initial_stock}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_recive_from_supplier_quantity)}}</td>
            <td style="text-align: center">{{sinItemRow.report_recive_from_supplier_date | dateFormat}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_inter_warehouse_receipt_quantity)}}</td>
            <td style="text-align: center">{{sinItemRow.report_inter_warehouse_receipt_date | dateFormat}}</td>
            <td style="text-align: center">{{getOfficeName(sinItemRow.report_inter_warehouse_receipt_office_id)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_inter_warehouse_send_quantity)}}</td>
            <td style="text-align: center">{{ sinItemRow.report_inter_warehouse_send_date | dateFormat }}</td>
            <td style="text-align: center">{{getOfficeName(sinItemRow.report_inter_warehouse_send_office_id)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_total_stock_quantity)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_truck_sale)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_online)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_general_allotment)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_total_sales)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_sold_product_price)}}</td>
            <td style="text-align: center" :rowspan="item.itemRow.length">{{$n(item.report_closing_stock)}}</td>
            <td style="text-align: center" :rowspan="item.itemRow.length">{{$n(item.report_closing_stock_price)}}</td>
            <td style="text-align: center"></td>
          </tr>
          <tr v-if="stIndex !== 0" :key="stIndex">
            <td style="text-align: center">{{ $n(sinItemRow.contract_number, { useGrouping: false }) }}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_recive_from_supplier_quantity)}}</td>
            <td style="text-align: center">{{sinItemRow.report_recive_from_supplier_date | dateFormat}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_inter_warehouse_receipt_quantity)}}</td>
            <td style="text-align: center">{{sinItemRow.report_inter_warehouse_receipt_date | dateFormat}}</td>
            <td style="text-align: center">{{getOfficeName(sinItemRow.report_inter_warehouse_receipt_office_id)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_inter_warehouse_send_quantity)}}</td>
            <td style="text-align: center">{{sinItemRow.report_inter_warehouse_send_date | dateFormat}}</td>
            <td style="text-align: center">{{getOfficeName(sinItemRow.report_inter_warehouse_send_office_id)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_total_stock_quantity)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_truck_sale)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_online)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_general_allotment)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_total_sales)}}</td>
            <td style="text-align: center">{{$n(sinItemRow.report_sold_product_price)}}</td>
            <td style="text-align: center"></td>
          </tr>
          </slot>
          <tr :key="itIndex">
            <th style="text-align: center">{{$t('tcb_report.sub_total')}}</th>
            <th style="text-align: center"></th>
            <th style="text-align: center">{{$n(item.report_recive_from_supplier_quantity_subTotal)}}</th>
            <th style="text-align: center"></th>
            <th style="text-align: center">{{$n(item.report_inter_warehouse_receipt_quantity_subTotal)}}</th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center">{{$n(item.report_inter_warehouse_send_quantity_subTotal)}}</th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
            <th style="text-align: center"></th>
          </tr>
        </slot>
        </slot>
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
import { yearlyReportRegion } from '../../api/routes'
import Pdf from './pdf'
import ReportHeading from '../../components/ReportHeading.vue'
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
      fis_start_date: '',
      fis_end_date: '',
      fis_custom_start_year: '',
      fis_custom_end_year: ''
      },
      itemList: [],
      show: false,
      regoOfficeName_en: '',
      regoOfficeName_bn: '',
      loading: false
    }
  },
  created () {
  },
  watch: {
    'search.regional_office': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const itemFind = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(newVal))
        this.regoOfficeName_bn = itemFind.text_bn
        this.regoOfficeName_en = itemFind.text_en
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const ficYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === newVal)
          this.search.fis_start_date = ficYear.start_date
          this.search.fis_end_date = ficYear.end_date
          let startDateArr = []
          startDateArr = ficYear.start_date.split('-')
          this.search.fis_custom_start_year = startDateArr[0]
          let endDateArr = []
          endDateArr = ficYear.end_date.split('-')
          this.search.fis_custom_end_year = endDateArr[0]
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
    getRegionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    }
  },
  methods: {
    pdfExport () {
      Pdf.exportPdfDetails(this, this.regoOfficeName_en, this.regoOfficeName_bn, this.search, this.itemList)
    },
    getItemName (itemId) {
      const itemFind = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
      return itemFind.text
    },
    getContractName (itemId) {
      const itemFind = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === itemId)
      return itemFind.text
    },
    getOfficeName (itemId) {
      if (itemId !== '') {
        const itemFind = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(itemId))
      if (this.$i18n.locale === 'bn') {
        return itemFind.text_bn
      } else {
          return itemFind.text_en
      }
      } else {
        return '--'
      }
    },
    async searchData () {
      this.loadData = true
      this.loading = true
      let result = null
      const params = Object.assign({}, this.search)
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, yearlyReportRegion, params)
      if (result.success) {
          this.itemList = result.data
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
