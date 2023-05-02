<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.monthly_report_hq')}}</h4>
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
          <b-col lg="4" sm="4">
            <ValidationProvider name="Report Section" vid="report_section" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="report_section"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.report_section')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="section"
                  :options="sectionList"
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
        <b-row class="text-right mb-5 mt-5">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                    {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
        </b-row>
      <b-overlay :show="loadingReport">
        <ReportHeading />
        <!-- table section start -->
        <SectionA v-if="section === '1' && this.productData !== ''" :reportData="productData" :taxData="taxData" :distributionCount="distributionCount" :allocationCount="allocationCount"></SectionA>
        <SectionB v-if="section === '2' && this.productData !== ''" :reportData="productData" :itemData="itemData" :searchData="search"></SectionB>
        <!-- table section end -->
      </b-overlay>
    </body-card>
  </div>
</template>
<script>
import ModalBaseMasterList from '@/mixins/list'
import SectionA from './SectionA.vue'
import SectionB from './SectionB.vue'
import ReportHeading from '../../components/ReportHeading.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { monthlyReportHqka, monthlyReportHqkha } from '../../api/routes'
import Pdf from './pdf'
// import { helpers } from '@/utils/helper-functions'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    SectionA,
    SectionB,
    ReportHeading
  },
  data () {
    return {
      search: {
        fiscal_year_id: 0,
        bn_month: 0
      },
      loadingReport: false,
      section: 0,
      productData: '',
      itemData: '',
      taxData: '',
      distributionCount: 0,
      allocationCount: 0,
      truckTotal: 0,
      retailTotal: 0,
      dealerTotal: 0,
      onlineTotal: 0,
      taxTotal: 0
    }
  },
  created () {
  },
  watch: {
  },
  computed: {
    monthList () {
      return this.$store.state.commonObj.monthList
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
    sectionList () {
      let sectionlist = [{
          value: '1',
          text_en: 'ka',
          text_bn: 'ক'
      },
      {
          value: '2',
          text_en: 'kha',
          text_bn: 'খ'
      }]
       sectionlist = sectionlist.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return sectionlist
    }
  },
  methods: {
  getTotalFinal (officeId) {
      let sellingAmount = 0
      const items = this.itemData.filter(item => item.office_id === parseInt(officeId))
      if (items.length > 0) {
        items.forEach(product => {
          sellingAmount = sellingAmount + product.selling_amount
        })
        return sellingAmount
      } else {
        return 0
      }
  },
  getTotalItemQuantity (officeId, category) {
      let sellingQuantity = 0
      const categoryId = category.value
      const items = this.itemData.filter(item => item.office_id === parseInt(officeId) && item.item_category_id === categoryId)
      if (items.length > 0) {
        items.forEach(product => {
          sellingQuantity = sellingQuantity + product.quantity
        })
        return sellingQuantity
      } else {
        return 0
      }
  },
  getTotalItemPrice (officeId, category) {
      let sellingAmount = 0
      const categoryId = category.value
      const items = this.itemData.filter(item => item.office_id === parseInt(officeId) && item.item_category_id === categoryId)
      if (items.length > 0) {
        items.forEach(product => {
          sellingAmount = sellingAmount + product.selling_amount
        })
        return sellingAmount
      } else {
        return 0
      }
  },
  getItemAvgPrice (officeId, category, distanceId, dealerType) {
      let sellingAmount = 0
      let quantity = 0
      const categoryId = category.value
      const items = this.itemData.filter(item => (item.office_id === parseInt(officeId) && item.distence_id === distanceId) && (item.item_category_id === categoryId && item.dealer_type === dealerType))
      if (items.length > 0) {
        items.forEach(product => {
          sellingAmount = sellingAmount + product.selling_amount
          quantity = quantity + product.quantity
        })
        const avgPrice = sellingAmount / quantity
        return avgPrice
      } else {
        return 0
      }
  },
  getItemPrice (officeId, category, distanceId, dealerType) {
      let sellingAmount = 0
      const categoryId = category.value
      const items = this.itemData.filter(item => (item.office_id === parseInt(officeId) && item.distence_id === distanceId) && (item.item_category_id === categoryId && item.dealer_type === dealerType))
      if (items.length > 0) {
        items.forEach(product => {
          sellingAmount = sellingAmount + product.selling_amount
        })
        return sellingAmount
      } else {
        return 0
      }
  },
  getItemQuantity (officeId, category, distanceId, dealerType) {
      let quantity = 0
      const categoryId = category.value
      const items = this.itemData.filter(item => (item.office_id === parseInt(officeId) && item.distence_id === distanceId) && (item.item_category_id === categoryId && item.dealer_type === dealerType))
      if (items.length > 0) {
        items.forEach(product => {
          quantity = quantity + product.quantity
        })
        return quantity
      } else {
        return 0
      }
  },
  getDistance (distance) {
      if (this.$i18n.locale === 'bn') {
          return distance.text_bn
        } else {
          return distance.text_en
        }
  },
  getTotal (item) {
      let truck = 0
      let dealer = 0
      let retail = 0
      let online = 0
      let tax = 0
      item.forEach(allocateItem => {
        truck = truck + allocateItem.truck_seller_price
        dealer = dealer + allocateItem.dealer_price
        retail = retail + allocateItem.retail_seller_price
        online = online + allocateItem.online_seller_price
        tax = tax + allocateItem.tax_amount
      })
      this.truckTotal = truck
      this.retailTotal = retail
      this.dealerTotal = dealer
      this.onlineTotal = online
      this.taxTotal = tax
  },
  getTotalPrice (item) {
      const tPrice = parseInt(item.dealer_price) + parseInt(item.retail_seller_price) + parseInt(item.online_seller_price) + parseInt(item.truck_seller_price)
      return tPrice
  },
  getProductSale (officeItems) {
      let sellAmount = 0
      Object.values(officeItems).forEach(item => {
        sellAmount = sellAmount + item.amount
      })
      return sellAmount
  },
  getOfficeTax (officeId) {
      const officeTax = this.taxData.find(item => item.office_id === officeId)
      return officeTax.amount
  },
  getProductQuantity (officeItems) {
      let quantity = 0
      Object.values(officeItems).forEach(item => {
        quantity = quantity + item.quantity
      })
      return quantity
  },
  getItemName (itemId, cntctId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
      const contract = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === cntctId)
      const itemName = item.text + ' ( ' + contract.text + ' )'
      return itemName
  },
  getOfficeName (officeData) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeData.office_id)
      return office.text
  },
  pdfExport () {
      const distance = this.$store.state.LicenseRegistrationService.commonObj.distanceList
      const itemcategorylist = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
      const month = this.monthList.find(item => item.value === this.search.bn_month)
      if (this.$i18n.locale === 'bn') {
        this.monthName = month.text_bn
      } else {
        this.monthName = month.text_en
      }
      if (this.productData.length > 0 && Object.prototype.hasOwnProperty.call(this.productData[0], 'officeItems')) {
      const lengthOffice = Object.keys(this.productData[0]?.officeItems)?.length
      var colLength = lengthOffice * 2
      } else {
        this.getTotal(this.productData)
      }
      Pdf.exportPdfDetails(this, this.productData, colLength, this.allocationCount, this.distributionCount, this.section, this.truckTotal, this.retailTotal, this.dealerTotal, this.onlineTotal, this.taxTotal, this.monthName, itemcategorylist, distance)
  },
  searchData () {
    if (this.section === '1') {
      this.loadingReport = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, monthlyReportHqka, this.search).then(response => {
        if (response.success) {
          this.productData = response.data
          this.taxData = response.tax
          this.distributionCount = response.disTime
          this.allocationCount = response.allocationCount
          this.loadingReport = false
        }
      })
    } else if (this.section === '2') {
      this.loadingReport = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, monthlyReportHqkha, this.search).then(response => {
        if (response.success) {
          this.productData = response.data
          this.itemData = response.allocatedItems
          this.loadingReport = false
        }
      })
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
