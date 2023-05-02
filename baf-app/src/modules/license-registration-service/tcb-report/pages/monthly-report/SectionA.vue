<template>
        <div style="width:100%;overflow-x:auto;">
        <table style="width:100%;" class="table-sm" v-if="reportData.length > 0">
          <tr>
            <th :colspan="colLength + 4">{{ $t('tcb_report.trading_corporation_of_bangladesh') }}</th>
          </tr>
          <tr>
            <th :colspan="colLength + 4">{{ $t('tcb_report.cms_and_bob_branch') }}</th>
          </tr>
          <tr>
            <th rowspan="3" style="width:10%">{{ $t('tcb_report.sl_no') }}</th>
            <th rowspan="3">{{ $t('tcb_report.product_name_and_brand') }}</th>
            <th :colspan="colLength">{{ $t('tcb_report.tcb_regional_ofc_name') }}</th>
            <th rowspan="2" colspan="2">{{ $t('tcb_report.total_a') }}</th>
          </tr>
          <tr>
            <th colspan="2" v-for="(office, index) in reportData[0].officeItems" :key='index'>{{ getOfficeName(office) }}</th>
          </tr>
          <tr>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <th :key="index">{{ $t('tcb_report.sales_volume') }}</th>
              <th :key="index">{{ $t('tcb_report.product_sold_price') }}</th>
            </slot>
            <th>{{ $t('tcb_report.sales_volume') }}</th>
            <th>{{ $t('tcb_report.product_sold_price') }}</th>
            <th>{{ $t('tcb_report.total_no_of_days_alotted') }}</th>
            <th>{{ $t('tcb_report.total_no_of_truck_sell') }}</th>
          </tr>
          <tr v-for="(item, index) in reportData" :key="index">
            <td>{{ $n(index + 1) }}</td>
            <td>{{ getItemName(item.item_id,item.contract_no_id) }}</td>
            <slot v-for="(officeItem, officeIndex) in item.officeItems">
              <td :key="officeIndex">{{ $n(officeItem.quantity) }}</td>
              <td :key="officeIndex">{{ $n(officeItem.amount) }}</td>
            </slot>
            <td>{{ $n(getProductQuantity(item.officeItems)) }}</td>
            <td>{{ $n(getProductSale (item.officeItems)) }}</td>
            <td v-if="index == 0">{{ $n(allocationCount) }}</td>
            <td v-if="index == 0">{{ $n(distributionCount) }}</td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.cost_of_goods_sold') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
            </slot>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.advanced_deposit_for_product_price') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
            </slot>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.about_income_tax_at_source') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
              <td :key="index">{{ $n(getOfficeTax(office.office_id)) }}</td>
            </slot>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.additional_deposits') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
            </slot>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.less_deposit_by_dealer') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
            </slot>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          <tr>
            <td>{{ $t('tcb_report.total') }}</td>
            <td></td>
            <slot v-for="(office, index) in reportData[0].officeItems">
              <td :key="index"></td>
            </slot>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        </table>
        </div>
</template>
<script>
export default {
  props: ['reportData', 'taxData', 'distributionCount', 'allocationCount'],
  data () {
    return {
      colLength: 0
    }
  },
  created () {
    if (this.reportData.length > 0) {
      this.getColCount(this.reportData[0].officeItems)
    }
  },
  methods: {
    getColCount (officeItems) {
      const lengthOffice = Object.keys(officeItems).length
      this.colLength = lengthOffice * 2
    },
    getOfficeName (officeData) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeData.office_id)
      return office.text
    },
    getItemName (itemId, cntctId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
      const contract = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === cntctId)
      const itemName = item.text + ' ( ' + contract.text + ' )'
      return itemName
    },
    getProductQuantity (officeItems) {
      let quantity = 0
      Object.values(officeItems).forEach(item => {
        quantity = quantity + item.quantity
      })
      return quantity
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
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
