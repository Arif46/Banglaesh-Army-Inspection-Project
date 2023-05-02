<template>
        <div style="width:100%;overflow-x:auto;">
        <table style="width:100%;" class="table-sm">
          <tr>
            <th colspan="12" class="text-left">{{ $t('tcb_report.month_name_equal') }} {{ getMonthName() }}</th>
            <th colspan="3" class="text-left">{{ $t('tcb_report.table_a') }}</th>
          </tr>
          <tr>
            <th colspan="15">{{ $t('tcb_report.warehouse_monthly_text_bill') }}</th>
          </tr>
          <tr>
            <th rowspan="2" style="text-align: left">{{ $t('tcb_report.sl_no') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.product_name') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.contact_no_and_brand') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.initial_stock') }}</th>
            <th style="text-align: center" colspan="2">{{ $t('tcb_report.receive_amount') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.total_stock') }}</th>
            <th style="text-align: center" colspan="3">{{ $t('tcb_report.distribution_amount') }}</th>
            <th rowspan="2" style="text-align: center" >{{ $t('tcb_report.total_distribution') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.closing_stock') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.total_product_price') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.avg_price') }}</th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.comment_inter_warehouse') }}</th>
          </tr>
          <tr>
            <th>{{ $t('tcb_report.supplier') }}</th>
            <th>{{ $t('tcb_report.inter_warehouse') }}</th>
            <th>{{ $t('tcb_report.truck_sale') }}</th>
            <th>{{ $t('tcb_report.general_allotment') }}</th>
            <th>{{ $t('tcb_report.inter_warehouse') }}</th>
          </tr>
          <tr>
            <th style="text-align: left">{{ $n('1') }}</th>
            <th style="text-align: center">{{ $n('2') }}</th>
            <th style="text-align: center">{{ $n('3') }}</th>
            <th style="text-align: center">{{ $n('4') }}</th>
            <th style="text-align: center">{{ $n('5') }}</th>
            <th style="text-align: center">{{ $n('6') }}</th>
            <th style="text-align: center">{{ $n('7') + " = (" + $n('4') + "+" + $n('5') + "+" + $n('6') + ")" }}</th>
            <th style="text-align: center">{{ $n('8') }}</th>
            <th style="text-align: center">{{ $n('9') }}</th>
            <th style="text-align: center">{{ $n('10') }}</th>
            <th style="text-align: center">{{ $n('11') + " = (" + $n('8') + "+" + $n('9') + "+" + $n('10') + ")" }}</th>
            <th style="text-align: center">{{ $n('12') }}</th>
            <th style="text-align: center">{{ $n('13') }}</th>
            <th style="text-align: center">{{ $n('14') + " = (" + $n('13') + "/" + $n('8') + "+" + $n('9') + ")" }}</th>
            <th style="text-align: center">{{ $n('15') }}</th>
          </tr>
        <slot v-for="(item, index) in data.itemList">
          <slot v-for="(innerItem, indx) in item.contractItems">
            <tr v-if="indx == 0" :key="index">
              <th :rowspan="item.contractItems.length" style="text-align: left">{{ $n(index+1) }}</th>
              <th style="text-align: center">
                {{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}
                {{ $i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name }}
              </th>
              <th style="text-align: center">
                {{ innerItem.contractnum.contract_no }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_initial_stock) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_recive_supplier_contract_quantity) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_receive_inter_warehouse) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.total_stock) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_truck_sale_quantity) }}
              </th>
              <th style="text-align: center">{{ $n(innerItem.report_distribution_storeallo_quantity) }}</th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_inter_warehouse) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_total) }}
              </th>
              <th style="text-align: center">
                  {{ $n(innerItem.report_closing_stock) }}
              </th>
              <th style="text-align: center">{{ $n(innerItem.total_sales_price) }}</th>
              <th style="text-align: center">{{ $n(innerItem.total_avg_sales_price) }}</th>
              <th style="text-align: center"></th>
            </tr>
            <tr v-else :key="index + indx + 100">
              <th style="text-align: center">
                {{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}
                {{ $i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name }}
              </th>
              <th style="text-align: center">
                {{ innerItem.contractnum.contract_no }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_initial_stock) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_recive_supplier_contract_quantity) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_receive_inter_warehouse) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.total_stock) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_truck_sale_quantity) }}
              </th>
              <th style="text-align: center">{{ $n(innerItem.report_distribution_storeallo_quantity) }}</th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_inter_warehouse) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_distribution_total) }}
              </th>
              <th style="text-align: center">
                {{ $n(innerItem.report_closing_stock) }}
              </th>
              <th style="text-align: center">{{ $n(innerItem.total_sales_price) }}</th>
              <th style="text-align: center">{{ $n(innerItem.total_avg_sales_price) }}</th>
              <th style="text-align: center"></th>
            </tr>
          </slot>
          <tr :key="index">
            <th colspan="2" style="text-align: center"></th>
            <th style="text-align: center">{{ $t('tcb_report.sub_total') }}</th>
            <th style="text-align: center">{{ $n(item.item_total_initial_stock) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_stock_in) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_warehouse_received) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_stock) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_truck_sales) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_store_sales) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_warehouse_transfer) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_distribution) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_closeing_stock) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_sold_price) }}</th>
            <th style="text-align: center">{{ $n(item.item_total_avg_sell_price) }}</th>
            <th style="text-align: center"></th>
          </tr>
        </slot>
          <tr>
            <th colspan="12" style="text-align: right">{{ $t('tcb_report.total_taka') }}</th>
            <th style="text-align: center">{{ $n(data.all_product_sold_amount) }}</th>
            <th style="text-align: center">{{ $n(data.all_product_avg_amount) }}</th>
          </tr>
          <tr>
            <th rowspan="2" style="text-align: center"></th>
            <th rowspan="2" style="text-align: center">{{ $t('tcb_report.d_o_quantity') }}</th>
            <th style="text-align: center"></th>
            <th style="text-align: center">{{ $t('tcb_report.initial_number') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.number_obtained') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.number_used') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.wasted_d_o_quantity') }}</th>
            <th colspan="6" style="text-align: center">{{ $t('tcb_report.description_wasted_d_o_quantity') }}</th>
            <th style="text-align: center">{{ $t('tcb_report.closing_number') }}</th>
            <th style="text-align: center"></th>
          </tr>
          <tr>
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
            <th style="text-align: center"></th>
          </tr>
        </table>
        </div>
</template>
<script>
export default {
  props: ['search', 'data'],
  data () {
    return {
    }
  },
  created () {
  },
  methods: {
    getMonthName () {
      const month = this.$store.state.commonObj.monthList.find(item => item.value === parseInt(this.search.month))
      if (typeof month !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return month.text_bn
        } else {
          return month.text_en
        }
      } else {
        return ''
      }
    }
  }
}
</script>

<style>
@import '../../style.css';

</style>
