import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (vm, data, section) => {
  try {
        Store.commit('mutateCommonProperties', {
          loading: true
        })
        if (i18n.locale === 'bn') {
          pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        }
          const pdfContent = []
          const allRowsHeadTwo = []
          const rowItemTwo = ReportHeading(vm)
          allRowsHeadTwo.push(...rowItemTwo)
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          pdfContent.push({
            table: {
              widths: ['20%', '60%', '20%'],
              body: allRowsHeadTwo
            },
            layout: {
              hLineWidth: function (i, node) {
                return 0
              },
              vLineWidth: function (i, node) {
                return 0
              }
            }
          })

          if (section === '1') {
            const ProductWiseRows = [
              [{ text: vm.$t('tcb_report.month_name_equal') + ' ' + vm.getMonthName(), colSpan: 12, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', { text: vm.$t('tcb_report.table_a'), colSpan: 3, style: 'tablecell' }, 'Column 2', 'Column 3'],
              [{ text: vm.$t('tcb_report.warehouse_monthly_text_bill'), colSpan: 15, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
              [{ text: vm.$t('globalTrans.sl_no'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.product_name'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.contact_no_and_brand'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.initial_stock'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.receive_amount'), colSpan: 2, style: 'tablecell' }, 'column', { text: vm.$t('tcb_report.total_stock'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.distribution_amount'), colSpan: 3, style: 'tablecell' }, 'column', 'column', { text: vm.$t('tcb_report.total_distribution'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.closing_stock'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.total_product_price'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.avg_price'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.comment_inter_warehouse'), style: 'tablecell', rowSpan: 2 }],
              ['column', 'Column 2', 'Column 3', 'Column 1', { text: vm.$t('tcb_report.supplier'), style: 'tablecell' }, { text: vm.$t('tcb_report.inter_warehouse'), style: 'tablecell' }, 'column', { text: vm.$t('tcb_report.truck_sale'), style: 'tablecell' }, { text: vm.$t('tcb_report.general_allotment'), style: 'tablecell' }, { text: vm.$t('tcb_report.inter_warehouse'), style: 'tablecell' }, 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
              [{ text: vm.$n('1'), style: 'tablecell' }, { text: vm.$n('2'), style: 'tablecell' }, { text: vm.$n('3'), style: 'tablecell' }, { text: vm.$n('4'), style: 'tablecell' }, { text: vm.$n('5'), style: 'tablecell' }, { text: vm.$n('6'), style: 'tablecell' }, { text: vm.$n('7') + ' = (' + vm.$n('4') + '+' + vm.$n('5') + '+' + vm.$n('6') + ')', style: 'tablecell' }, { text: vm.$n('8'), style: 'tablecell' }, { text: vm.$n('9'), style: 'tablecell' }, { text: vm.$n('10'), style: 'tablecell' }, { text: vm.$n('11') + ' = (' + vm.$n('8') + '+' + vm.$n('9') + '+' + vm.$n('10') + ')', style: 'tablecell' }, { text: vm.$n('12'), style: 'tablecell' }, { text: vm.$n('13'), style: 'tablecell' }, { text: vm.$n('14') + ' = (' + vm.$n('13') + '/' + vm.$n('8') + '+' + vm.$n('9') + ')', style: 'tablecell' }, { text: vm.$n('15'), style: 'tablecell' }]
            ]
            data.itemList.map((item, index) => {
              item.contractItems.map((innerItem, indx) => {
                  ProductWiseRows.push([{ text: vm.$n(index + 1), rowSpan: item.contractItems.length, style: 'tablecell' }, { text: (i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en) + ' ' + (i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name), style: 'tablecell' }, { text: innerItem.contractnum.contract_no, style: 'tablecell' }, { text: vm.$n(innerItem.report_initial_stock), style: 'tablecell' }, { text: vm.$n(innerItem.report_recive_supplier_contract_quantity), style: 'tablecell' }, { text: vm.$n(innerItem.report_receive_inter_warehouse), style: 'tablecell' }, { text: vm.$n(innerItem.total_stock), style: 'tablecell' }, { text: vm.$n(innerItem.report_distribution_truck_sale_quantity), style: 'tablecell' }, { text: vm.$n(innerItem.report_distribution_storeallo_quantity), style: 'tablecell' }, { text: vm.$n(innerItem.report_distribution_inter_warehouse), style: 'tablecell' }, { text: vm.$n(innerItem.report_distribution_total), style: 'tablecell' }, { text: vm.$n(innerItem.report_closing_stock), style: 'tablecell' }, { text: vm.$n(innerItem.total_sales_price), style: 'tablecell' }, { text: vm.$n(innerItem.total_avg_sales_price), style: 'tablecell' }, { text: '', style: 'tablecell' }])
              })
                  ProductWiseRows.push([{ text: '', colSpan: 2, style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.sub_total'), style: 'tablecell' }, { text: vm.$n(item.item_total_initial_stock), style: 'tablecell' }, { text: vm.$n(item.item_total_stock_in), style: 'tablecell' }, { text: vm.$n(item.item_total_warehouse_received), style: 'tablecell' }, { text: vm.$n(item.item_total_stock), style: 'tablecell' }, { text: vm.$n(item.item_total_truck_sales), style: 'tablecell' }, { text: vm.$n(item.item_total_store_sales), style: 'tablecell' }, { text: vm.$n(item.item_total_warehouse_transfer), style: 'tablecell' }, { text: vm.$n(item.item_total_distribution), style: 'tablecell' }, { text: vm.$n(item.item_total_closeing_stock), style: 'tablecell' }, { text: vm.$n(item.item_total_sold_price), style: 'tablecell' }, { text: vm.$n(item.item_total_avg_sell_price), style: 'tablecell' }, { text: '', style: 'tablecell' }])
            })
            ProductWiseRows.push([{ text: vm.$t('tcb_report.total_taka'), colSpan: 12, style: 'tablecell', alignment: 'right' }, '', '', '', '', '', '', '', '', '', '', '', { text: data.all_product_sold_amount, style: 'tablecell' }, { text: vm.$n(data.all_product_avg_amount), style: 'tablecell' }, { text: '', style: 'tablecell' }])
            ProductWiseRows.push([{ text: '', rowSpan: 2 }, { text: vm.$t('tcb_report.d_o_quantity'), rowSpan: 2, style: 'tablecell' }, '', { text: vm.$t('tcb_report.initial_number'), style: 'tablecell' }, { text: vm.$t('tcb_report.number_obtained'), style: 'tablecell' }, { text: vm.$t('tcb_report.number_used'), style: 'tablecell' }, { text: vm.$t('tcb_report.wasted_d_o_quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.description_wasted_d_o_quantity'), colSpan: 6, style: 'tablecell' }, '', '', '', '', '', { text: vm.$t('tcb_report.closing_number'), style: 'tablecell' }, ''])
            ProductWiseRows.push([{ text: '', style: 'tablecell' }, '', '', '', '', '', '', '', '', '', '', '', '', '', ''])
              pdfContent.push({
                style: 'tableExample',
                table: {
                  widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%'],
                  body: ProductWiseRows
                }
              })
          } else {
            const ProductWiseRows = [
              [{ text: vm.$t('tcb_report.month_name_equal') + ' ' + vm.getMonthName(), colSpan: 17, style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.table_b'), style: 'tablecell', colSpan: 5 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
              [{ text: vm.$t('tcb_report.warehouse_monthly_text_bill'), style: 'tablecell', colSpan: 22, alignment: 'center' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
              [{ text: vm.$t('tcb_report.sl_no'), style: 'tablecell' }, { text: vm.$t('tcb_report.product_name'), style: 'tablecell' }, { text: vm.$t('tcb_report.contact_no_and_brand'), style: 'tablecell' }, { text: vm.$t('tcb_report.sale_in_general_allotment'), style: 'tablecell', colSpan: 6 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.truck_sale_e'), style: 'tablecell', colSpan: 6 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.online_open_sale'), style: 'tablecell', colSpan: 2, rowSpan: 2 }, { text: vm.$t('tcb_report.total_sales_amount'), style: 'tablecell' }, { text: vm.$t('tcb_report.total_price_of_sold_products'), style: 'tablecell' }, { text: vm.$t('tcb_report.income_tax'), style: 'tablecell' }, { text: vm.$t('tcb_report.money_deposited_in_the_bank'), style: 'tablecell' }, { text: vm.$t('tcb_report.comment'), style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
              [{ text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.0_50_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.50_100_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.100_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.0_50_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.50_100_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.100_km'), style: 'tablecell', colSpan: 2 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
              [{ text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.taka'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
              [{ text: vm.$n('1'), style: 'tablecell' }, { text: vm.$n('2'), style: 'tablecell' }, { text: vm.$n('3'), style: 'tablecell' }, { text: vm.$n('4'), style: 'tablecell' }, { text: vm.$n('5'), style: 'tablecell' }, { text: vm.$n('6'), style: 'tablecell' }, { text: vm.$n('7'), style: 'tablecell' }, { text: vm.$n('8'), style: 'tablecell' }, { text: vm.$n('9'), style: 'tablecell' }, { text: vm.$n('10'), style: 'tablecell' }, { text: vm.$n('11'), style: 'tablecell' }, { text: vm.$n('12'), style: 'tablecell' }, { text: vm.$n('13'), style: 'tablecell' }, { text: vm.$n('14'), style: 'tablecell' }, { text: vm.$n('15'), style: 'tablecell' }, { text: vm.$n('16'), style: 'tablecell' }, { text: vm.$n('17'), style: 'tablecell' }, { text: (vm.$n('18') + '= (' + vm.$n('4') + '+' + vm.$n('6') + '+' + vm.$n('8') + '+' + vm.$n('10') + '+' + vm.$n('12') + '+' + vm.$n('14') + '+' + vm.$n('16') + ')'), style: 'tablecell' }, { text: (vm.$n('19') + '= (' + vm.$n('5') + '+' + vm.$n('7') + '+' + vm.$n('9') + '+' + vm.$n('11') + '+' + vm.$n('13') + '+' + vm.$n('15') + '+' + vm.$n('17') + ')'), style: 'tablecell' }, { text: vm.$n('20'), style: 'tablecell' }, { text: vm.$n('21'), style: 'tablecell' }, { text: vm.$n('22'), style: 'tablecell' }]
            ]

            data.itemList.map((item, index) => {
              item.contractItems.map((innerItem, indx) => {
                ProductWiseRows.push([{ text: vm.$n(index + 1), style: 'tablecell', rowSpan: item.contractItems.length + 1 }, { text: (i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en), style: 'tablecell', rowSpan: item.contractItems.length }, { text: (i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_1 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_1), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_2 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_2), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_3 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.store_sale_distance_3), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_1 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_1), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_2 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_2), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_3 * innerItem.selling_price), style: 'tablecell' }, { text: vm.$n(innerItem.truck_sale_distance_3), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(innerItem.total_sale_quantity), style: 'tablecell' }, { text: vm.$n(innerItem.total_sale_price), style: 'tablecell' }, { text: vm.$n(innerItem.tax_amount), style: 'tablecell' }, { text: vm.$n(innerItem.total_sale_price), style: 'tablecell' }, { text: '', style: 'tablecell' }])
              })
              ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.sub_total'), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_price_distance_1), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_distance_1), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_price_distance_2), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_distance_2), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_price_distance_3), style: 'tablecell' }, { text: vm.$n(item.item_store_sale_distance_3), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_price_distance_1), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_distance_1), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_price_distance_2), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_distance_2), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_price_distance_3), style: 'tablecell' }, { text: vm.$n(item.item_truck_sale_distance_3), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(item.item_total_sale_quantity), style: 'tablecell' }, { text: vm.$n(item.item_total_sale_price), style: 'tablecell' }, { text: vm.$n(item.item_tax_amount), style: 'tablecell' }, { text: vm.$n(item.item_total_sale_price), style: 'tablecell' }, { text: '', style: 'tablecell' }])
            })
            ProductWiseRows.push([{ text: vm.$t('tcb_report.total_money_deposit_bank'), style: 'tablecell', colSpan: 18 }, { text: '', style: 'tablecell' }, '6%', { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: data.final_amount ? vm.$n(data.final_amount) : 0, style: 'tablecell' }, { text: '', style: 'tablecell' }])
              pdfContent.push({
                style: 'tableExample',
                table: {
                  widths: ['4%', '4%', '6%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '4%', '5%', '5%', '6%', '4%', '4%'],
                  body: ProductWiseRows
                }
              })
            ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.advance_deposit_by_dealer'), style: 'tablecell', colSpan: 5 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }])
            ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.total_number_of_days_alloted'), style: 'tablecell', colSpan: 4 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.extra_deposit_by_dealer'), style: 'tablecell', colSpan: 5 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }])
            ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.total_truck_sale'), style: 'tablecell', colSpan: 4 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.less_deposit_by_dealer_e'), style: 'tablecell', colSpan: 5 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }])
            ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.total_money_deposit_bank_e'), style: 'tablecell', colSpan: 5 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }])
          }
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
          },
          search: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [3, 3, 3, 3]
          },
          fertilizer: {
            margin: [5, 0, 0, 5]
          },
          header: {
            fontSize: 12,
            margin: [0, 0, 0, 4]
          },
          header2: {
            fontSize: 14,
            margin: [0, 10, 0, 20]
          },
          headerPort1: {
            fontSize: 10,
            margin: [0, 20, 0, 5]
          },
          headerPort: {
            fontSize: 10,
            margin: [0, 4, 0, 15]
          },
          krishi: {
            margin: [0, -5, 0, 15],
            alignment: 'center'
          },
          header3: {
            fontSize: 9,
            margin: [0, 0, 0, 0]
          },
          address: {
            fontSize: 9,
            margin: [0, -10, 0, 0]
          },
          tableSubHead: {
            margin: [0, 5, 0, 15]
          },
          img_logo: {
            margin: [20, 0, 0, 0]
          },
          img_logo_two: {
            margin: [25, 0, 0, 0]
          },
          reportHeading: {
            fontSize: 13,
            margin: [0, 10, 0, 0]
          },
          headerTwo: {
            fontSize: 12,
            margin: [0, -10, 0, 0]
          },
          headerThree: {
            fontSize: 9,
            margin: [0, 1, 0, 0]
          },
          giveUnderline: {
            decoration: 'underline',
            margin: [0, 10, 0, 0]
          },
          tableHeader: {
            alignment: 'center'
          },
          tableHeaderTwo: {
            fontSize: 9,
            alignment: 'center',
            margin: [0, 10, 0, 0]
          },
          tableHeaderThree: {
            alignment: 'left',
            margin: [0, 0, 0, 0]
          },
          tableHeaderFour: {
            alignment: 'left',
            margin: [0, 50, 0, 0]
          },
          tableHeaderFive: {
            alignment: 'left',
            bold: true
          },
          tableExampleGrid: {
            margin: [0, 5, 5, 0]
          },
          tableHeaderSix: {
            fontSize: 15,
            margin: [0, 8, 8, 0]
          },
          tableHeaderSeven: {
            fontSize: 10,
            margin: [0, 0, 0, 0]
          },
          tableHeaderEight: {
            fontSize: 10,
            margin: [20, 0, 0, 0]
          },
          leftalign: {
            alignment: 'left'
          },
          tablecell: {
            fontSize: 6,
            alignment: 'center'
          },
          marginForUse: {
            margin: [0, 20, 0, 0]
          }
        }
      }
      pdfMake.createPdf(docDefinition, null, null, null).print()
    } catch (error) {
      if (error) {}
    }
    Store.commit('mutateCommonProperties', {
      loading: false
    })
}
export default {
  exportPdfDetails
}
