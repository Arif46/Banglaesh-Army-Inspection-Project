import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (vm, regoOfficeNameen, regoOfficeNamebn, search, itemList) => {
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

       const ProductWiseRows = [
          [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), style: 'tablecell', colSpan: 21 }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2'],
          [{ text: vm.$t('tcb_report.regional_office_name') + '' + (i18n.locale === 'bn') ? regoOfficeNamebn : regoOfficeNameen, style: 'tablecell', colSpan: 21 }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2'],
          [{ text: vm.$t('tcb_report.tcb_big_text_three') + vm.$n(search.fis_custom_start_year) + '-' + vm.$n(search.fis_custom_end_year), style: 'tablecell', colSpan: 21 }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2'],
          [{ text: vm.$t('globalTrans.sl_no'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.product_name'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.contact_no_and_brand'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.july_2020_date_opening_stock') + ' ' + dateFormat(search.fis_start_date), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.from_to_send_receive_one') + ' ' + dateFormat(search.fis_start_date) + ' ' + dateFormat(search.fis_end_date), style: 'tablecell', colSpan: 8 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.total_stock_quantity'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.inter_warehouse_send_amount'), style: 'tablecell', colSpan: 5 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.june_2021_closing_stock') + ' ' + dateFormat(search.fis_end_date), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.june_2021_closing_stock_taka') + ' ' + dateFormat(search.fis_end_date), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.comment'), style: 'tablecell', rowSpan: 3 }],
          [{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.received_from_supplier'), style: 'tablecell', colSpan: 2 }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.inter_warehouse_receipt'), style: 'tablecell', colSpan: 3 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.inter_warehouse_send'), style: 'tablecell', colSpan: 3 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.truck_sale'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.online'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.general_allotment'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.total_sell'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.sold_product_price'), style: 'tablecell', rowSpan: 2 }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }],
          [{ text: '', style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.receive_date'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.receive_date'), style: 'tablecell' }, { text: vm.$t('tcb_report.office_name'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.send_date'), style: 'tablecell' }, { text: vm.$t('tcb_report.office_name'), style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2'],
          [{ text: vm.$n('1'), style: 'tablecell' }, { text: vm.$n('2'), style: 'tablecell' }, { text: vm.$n('3'), style: 'tablecell' }, { text: vm.$n('4'), style: 'tablecell' }, { text: vm.$n('5'), style: 'tablecell' }, { text: vm.$n('6'), style: 'tablecell' }, { text: vm.$n('7'), style: 'tablecell' }, { text: vm.$n('8'), style: 'tablecell' }, { text: vm.$n('9'), style: 'tablecell' }, { text: vm.$n('10'), style: 'tablecell' }, { text: vm.$n('11'), style: 'tablecell' }, { text: vm.$n('12'), style: 'tablecell' }, { text: vm.$n('13') + '=' + '(' + vm.$n('5') + '+' + vm.$n('7') + '+' + vm.$n('10'), style: 'tablecell' }, { text: vm.$n('14'), style: 'tablecell' }, { text: vm.$n('15'), style: 'tablecell' }, { text: vm.$n('16'), style: 'tablecell' }, { text: vm.$n('17') + '=' + '(' + vm.$n('14') + '+' + vm.$n('15') + '+' + vm.$n('16'), style: 'tablecell' }, { text: vm.$n('18'), style: 'tablecell' }, { text: vm.$n('19'), style: 'tablecell' }, { text: vm.$n('20'), style: 'tablecell' }, { text: vm.$n('21'), style: 'tablecell' }]
        ]

        itemList.map((item, itIndex) => {
          item.itemRow.map((sinItemRow, stIndex) => {
            ProductWiseRows.push([{ text: vm.$n(itIndex + 1), style: 'tablecell', rowSpan: item.itemRow.length + 1 }, { text: (i18n.locale === 'bn') ? item.item_name_bn : item.item_name_en, style: 'tablecell', rowSpan: item.itemRow.length + 1 }, { text: sinItemRow.contract_number, style: 'tablecell' }, { text: item.report_initial_stock, style: 'tablecell' }, { text: vm.$n(sinItemRow.report_recive_from_supplier_quantity), style: 'tablecell' }, { text: dateFormat(sinItemRow.report_recive_from_supplier_date), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_inter_warehouse_receipt_quantity), style: 'tablecell' }, { text: dateFormat(sinItemRow.report_inter_warehouse_receipt_date), style: 'tablecell' }, { text: vm.getOfficeName(sinItemRow.report_inter_warehouse_receipt_office_id), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_inter_warehouse_send_quantity), style: 'tablecell' }, { text: dateFormat(sinItemRow.report_inter_warehouse_send_date), style: 'tablecell' }, { text: vm.getOfficeName(sinItemRow.report_inter_warehouse_send_office_id), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_total_stock_quantity), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_truck_sale), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_online), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_general_allotment), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_total_sales), style: 'tablecell' }, { text: vm.$n(sinItemRow.report_sold_product_price), style: 'tablecell' }, { text: vm.$n(item.report_closing_stock), style: 'tablecell', rowSpan: item.itemRow.length + 1 }, { text: vm.$n(item.report_closing_stock_price), style: 'tablecell', rowSpan: item.itemRow.length + 1 }, { text: '', style: 'tablecell' }])
          })
          ProductWiseRows.push([{ text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$t('tcb_report.sub_total'), style: 'tablecellbold' }, { text: '', style: 'tablecell' }, { text: vm.$n(item.report_recive_from_supplier_quantity_subTotal), style: 'tablecellbold' }, { text: '', style: 'tablecell' }, { text: vm.$n(item.report_inter_warehouse_receipt_quantity_subTotal), style: 'tablecellbold' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: vm.$n(item.report_inter_warehouse_send_quantity_subTotal), style: 'tablecellbold' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }])
        })
          pdfContent.push({
            style: 'tableExample',
            table: {
              widths: ['5%', '5%', '5%', '7%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '4%', '4%', '4%', '4%', '4%', '4%', '5%', '5%', '5%'],
              body: ProductWiseRows
            }
          })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
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
            alignment: 'center',
            fontSize: 7
          },
          tablecellbold: {
            alignment: 'center',
            fontSize: 7,
            bold: true
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
