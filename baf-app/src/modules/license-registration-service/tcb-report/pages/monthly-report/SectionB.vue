<template>
    <div>
        <div style="width:100%;overflow-x:auto;">
          <table class="table-sm">
          <tr>
            <th colspan="15">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th colspan="15">{{ $t('tcb_report.cms_and_bob_branch_b') }}</th>
          </tr>
          <tr style="text-align: left!important;">
            <th style="text-align: left!important;" colspan="15">{{ $t('tcb_report.tcb_summary') }}</th>
          </tr>
          <tr style="text-align: left!important;">
            <th style="text-align: left!important;" colspan="15">{{ $t('tcb_report.month_name') }} {{ monthName }}</th>
          </tr>
          <tr>
            <th style="width:10%">{{ $t('tcb_report.sl_no') }}</th>
            <th>{{ $t('tcb_report.regional_and_camp_name') }}</th>
            <th>{{ $t('tcb_report.product_selling_price_to_dealer') }}</th>
            <th>{{ $t('tcb_report.dealer_tracksale_selling_price') }}</th>
            <th>{{ $t('tcb_report.retail_outlet_product_total_selling_price') }}</th>
            <th>{{ $t('tcb_report.total_selling_price _to_online_organizations') }}</th>
            <th>{{ $t('tcb_report.total_price_of_sold_products') }}</th>
            <th>{{ $t('tcb_report.income_tax_amount') }}</th>
            <th>{{ $t('tcb_report.vat_amount') }}</th>
            <th>{{ $t('tcb_report.total_amount_due') }}</th>
            <th>{{ $t('tcb_report.money_deposit_according_to_report') }}</th>
            <th>{{ $t('tcb_report.according_to_report_deposited_money') }}</th>
            <th>{{ $t('tcb_report.finace_acc_total_deposit_money') }}</th>
            <th>{{ $t('tcb_report.finace_acc_total_deposit_money_less_more') }}</th>
            <th>{{ $t('tcb_report.comment') }}</th>
          </tr>
          <tr>
            <td>{{ $n('1')}}</td>
            <td>{{ $n('2')}}</td>
            <td>{{ $n('3')}}</td>
            <td>{{ $n('4')}}</td>
            <td>{{ $n('5')}}</td>
            <td>{{ $n('6')}}</td>
            <td>{{ $n('7') + ' = (' + $n('3') + '+' + $n('4') + '+' + $n('5') + '+' + $n('6') + ')' }}</td>
            <td>{{ $n('8')}}</td>
            <td>{{ $n('9')}}</td>
            <td>{{ $n('10') + ' = (' + $n('7') + '+' + $n('8') + '+' + $n('9') + ')' }}</td>
            <td>{{ $n('11')}}</td>
            <td>{{ $n('12') + ' = (' + $n('11') + '-' + $n('10') + ')' }}</td>
            <td>{{ $n('13')}}</td>
            <td>{{ $n('14') + '()'}}</td>
            <td>{{ $n('15')}}</td>
          </tr>
          <tr v-for="(item, index) in reportData" :key="index">
            <td>{{ $n(index + 1) }}</td>
            <td>{{ getOfficeName(item.office_id) }}</td>
            <td>{{ $n(item.dealer_price) }}</td>
            <td>{{ $n(item.truck_seller_price) }}</td>
            <td>{{ $n(item.retail_seller_price) }}</td>
            <td>{{ $n(item.online_seller_price) }}</td>
            <td>{{ $n(getTotalPrice(item)) }}</td>
            <td>{{ $n(item.tax_amount) }}</td>
            <td>{{ $n(item.vat_amount) }}</td>
            <td>{{ $n(item.tax_amount + item.vat_amount) }}</td>
            <td>{{ $n(getTotalPrice(item)) }}</td>
            <td>{{ $n(0) }}</td>
            <td>{{ $n(0) }}</td>
            <td>{{ $n(0) }}</td>
            <td></td>
          </tr>
          <tr>
            <td colspan="2">{{ $t('tcb_report.total') }}</td>
            <td>{{ $n(dealerTotal) }}</td>
            <td>{{ $n(truckTotal) }}</td>
            <td>{{ $n(retailTotal) }}</td>
            <td>{{ $n(onlineTotal) }}</td>
            <td>{{ $n(dealerTotal + truckTotal + retailTotal + onlineTotal) }}</td>
            <td>{{ $n(taxTotal) }}</td>
            <td>{{ $n(0) }}</td>
            <td>{{ $n(taxTotal) }}</td>
            <td>{{ $n(dealerTotal + truckTotal + retailTotal + onlineTotal) }}</td>
            <td>{{ $n(0) }}</td>
            <td>{{ $n(0) }}</td>
            <td>{{ $n(0) }}</td>
            <td></td>
          </tr>
        </table>
        </div>

        <br>
        <div style="width:100%;overflow-x:auto;" v-if="itemData.length > 0">
        <table class="table-sm mb-4" style="padding: 1px !important;" v-for="(office, index) in reportData" :key="index">
          <tr>
            <th :colspan="colLength">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th :colspan="colLength">{{ $t('tcb_report.month_text') }} {{ monthName }}</th>
          </tr>
          <tr>
            <th rowspan="16">{{ $t('tcb_report.sl_no') }} {{ $n(index + 1) }}</th>
            <th rowspan="2">{{ $t('tcb_report.regional_office') }}</th>
            <th rowspan="2">{{ $t('tcb_report.selling_medium') }}</th>
            <th rowspan="2">{{ $t('tcb_report.distance') }}</th>
            <th colspan="3" v-for="(item, index) in itemCategoryList" :key='index'>{{ item.text }}</th>
          </tr>
          <tr>
            <slot v-for="(distance, index) in itemCategoryList">
              <th :key='index'>{{ $t('tcb_report.quantity') }}</th>
              <th :key='index'>{{ $t('tcb_report.price') }}</th>
              <th :key='index'>{{ $t('tcb_report.avg_price') }}</th>
            </slot>
          </tr>
          <tr>
            <th rowspan="14">{{ getOfficeName(office.office_id) }}</th>
            <th>{{ $t('tcb_report.sales_center') }}</th>
            <th></th>
            <slot v-for="(distance, index) in itemCategoryList">
              <th :key='index'></th>
              <th :key='index'></th>
              <th :key='index'></th>
            </slot>
          </tr>
          <slot v-for="(distance, index) in  distanceList">
            <tr v-if="index==0" :key="index">
              <td rowspan="3">{{ $t('tcb_report.dealer_allocation') }}</td>
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="'del' + index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 2)) }}</td>
                <td :key="'del' + index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 2)) }}</td>
                <td :key="'del' + index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 2)) }}</td>
              </slot>
            </tr>
            <tr v-else :key="index">
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="'del' + index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 2)) }}</td>
                <td :key="'del' + index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 2)) }}</td>
                <td :key="'del' + index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 2)) }}</td>
              </slot>
            </tr>
          </slot>
          <tr>
            <td>{{ $t('tcb_report.total_d') }}</td>
            <td></td>
            <slot v-for="(itemcategry, index) in  itemCategoryList">
              <td :key="'tot' + index">{{ $n(0) }}</td>
              <td :key="'tot' + index">{{ $n(0) }}</td>
              <td :key="'tot' + index"></td>
            </slot>
          </tr>
          <slot v-for="(distance, index) in  distanceList">
            <tr v-if="index==0" :key="index">
              <td rowspan="3">{{ $t('tcb_report.allotment_of_truck_sells') }}</td>
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 1)) }}</td>
                <td :key="index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 1)) }}</td>
                <td :key="index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 1)) }}</td>
              </slot>
            </tr>
            <tr v-else :key="index">
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 1)) }}</td>
                <td :key="index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 1)) }}</td>
                <td :key="index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 1)) }}</td>
              </slot>
            </tr>
          </slot>
          <tr>
            <td>{{ $t('tcb_report.total_d') }}</td>
            <td></td>
            <slot v-for="(itemcategry, index) in  itemCategoryList">
              <td :key="'tot' + index">{{ $n(getTotalItemQuantity(office.office_id,itemcategry)) }}</td>
              <td :key="'tot' + index">{{ $n(getTotalItemPrice(office.office_id,itemcategry)) }}</td>
              <td :key="index"></td>
            </slot>
          </tr>
          <slot v-for="(distance, dindex) in  distanceList">
            <tr v-if="dindex==0" :key="dindex">
              <td rowspan="3">{{ $t('tcb_report.online_allocation') }}</td>
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="'onl' + index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 3)) }}</td>
                <td :key="'onl' + index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 3)) }}</td>
                <td :key="'onl' + index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 3)) }}</td>
              </slot>
            </tr>
            <tr v-else :key="dindex">
              <td>{{ getDistance(distance) }}</td>
              <slot v-for="(itemcategry, index) in  itemCategoryList">
                <td :key="'onl' + index">{{ $n(getItemQuantity(office.office_id,itemcategry, distance.value, 3)) }}</td>
                <td :key="'onl' + index">{{ $n(getItemPrice(office.office_id,itemcategry, distance.value, 3)) }}</td>
                <td :key="'onl' + index">{{ $n(getItemAvgPrice(office.office_id,itemcategry, distance.value, 3)) }}</td>
              </slot>
            </tr>
          </slot>
          <tr>
            <td>{{ $t('tcb_report.total_a') }}</td>
            <td></td>
            <slot v-for="(itemcategry, index) in  itemCategoryList">
              <td :key="'tota' + index">{{ $n(getTotalItemQuantity(office.office_id,itemcategry)) }}</td>
              <td :key="'tota' + index">{{ $n(getTotalItemPrice(office.office_id,itemcategry)) }}</td>
              <td :key="index"></td>
            </slot>
          </tr>
          <tr>
            <slot v-for="(itemcategry, index) in  (itemCategoryList)">
              <th colspan="2" style="border: 1px solid grey;" :key="index"></th>
            </slot>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th colspan="2">{{ $t('tcb_report.total_taka') }}</th>
            <th colspan="2">{{ $n(getTotalFinal(office.office_id)) }}</th>
          </tr>
        </table>
        </div>
    </div>
</template>
<script>
export default {
  props: ['reportData', 'itemData', 'searchData'],
  data () {
    return {
      monthName: '',
      truckTotal: 0,
      dealerTotal: 0,
      retailTotal: 0,
      onlineTotal: 0,
      taxTotal: 0,
      colLength: 0
    }
  },
  created () {
    this.getTotal(this.reportData)
    const month = this.monthList.find(item => item.value === this.searchData.bn_month)
    if (this.$i18n.locale === 'bn') {
      this.monthName = month.text_bn
    } else {
      this.monthName = month.text_en
    }
    this.colLength = (this.itemCategoryList.length * 3) + 5
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    monthList () {
      return this.$store.state.commonObj.monthList
    },
    distanceList () {
      return this.$store.state.LicenseRegistrationService.commonObj.distanceList
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const month = this.monthList.find(item => item.value === this.searchData.bn_month)
        if (this.$i18n.locale === 'bn') {
          this.monthName = month.text_bn
        } else {
          this.monthName = month.text_en
        }
      }
    }
  },
  methods: {
    getDistance (distance) {
      if (this.$i18n.locale === 'bn') {
          return distance.text_bn
        } else {
          return distance.text_en
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
    getOfficeName (officeId) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeId)
      return office.text
    },
    getTotalPrice (item) {
      const tPrice = parseInt(item.dealer_price) + parseInt(item.retail_seller_price) + parseInt(item.online_seller_price) + parseInt(item.truck_seller_price)
      return tPrice
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
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
