import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
// import { use } from 'vue/types/umd'
// import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, monthlyReport, vm, startDate, endDate, itemData, itemCategoryList, officeList, prevstocks) => {
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
            // const allRowsHeadTwo = []
            // const rowItemTwo = ReportHeading(vm)
            // allRowsHeadTwo.push(...rowItemTwo)
            // allRowsHeadTwo.push(['', '', ''])
            // allRowsHeadTwo.push(['', '', ''])
            // allRowsHeadTwo.push(['', '', ''])
            // allRowsHeadTwo.push(['', '', ''])
            // allRowsHeadTwo.push(['', '', ''])
            // pdfContent.push({
            //   table: {
            //     widths: ['20%', '60%', '20%'],
            //     body: allRowsHeadTwo
            //   },
            //   layout: {
            //     hLineWidth: function (i, node) {
            //       return 0
            //     },
            //     vLineWidth: function (i, node) {
            //       return 0
            //     }
            //   }
            // })
          // const allRowsHead1 = [
          //   [
          //     { text: vm.$t('organogram.regional_office_name') + ' : ' + vm.getOfficeName(search.regional_office), alignment: 'left', style: 'thh' },
          //     { text: vm.$t('tcb_report.item_category') + ' : ' + ((i18n.locale === 'bn') ? categoryname.text_bn : categoryname.text_en), alignment: 'left', style: 'thh' },
          //     { text: vm.$t('tcb_report.item') + ' : ' + ((i18n.locale === 'bn') ? itemname.text_bn : itemname.text_en), alignment: 'left', style: 'thh' }
          //   ]
          // ]

          // allRowsHead1.push([
          //   { text: vm.$t('globalTrans.fiscal_year') + ' : ' + vm.getFiscalYear(search.fiscal_year_id), alignment: 'left', style: 'thh' },
          //   { text: vm.$t('tcb_report.month') + ' : ' + vm.getMonthName(search.month), alignment: 'left', style: 'thh' },
          //   { text: '' + '' + '', alignment: 'left', style: 'thh' }
          // ])

          // allRowsHead1.push([
          //   { text: '' + '' + '', alignment: 'left', style: 'thh' },
          //   { text: '' + '' + '', alignment: 'left', style: 'thh' },
          //   { text: '' + '' + '', alignment: 'left', style: 'marginForUse' }
          // ])

          // pdfContent.push({
          //   table: {
          //     headerRows: 1,
          //     widths: '*',
          //     body: allRowsHead1
          //   },
          //   layout: {
          //     hLineWidth: function (i, node) {
          //       return 0
          //     },
          //     vLineWidth: function (i, node) {
          //       return 0
          //     }
          //   }
          // })

          const dyColumWidth = []
          const len = 100 / 13
            const length = `${len}%`
            for (let i = 0; i < 13; i++) {
              dyColumWidth.push(length)
            }
         const ProductWiseRows = [
            [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), colSpan: 13, style: 'tablecell' }, 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', 'Column 10', 'Column 11', 'Column 11'],
            [{ text: vm.$t('tcb_report.cms_and_bob'), colSpan: 13, style: 'tablecell' }, 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', 'Column 10', 'Column 11', 'Column 11'],
            [{ text: dateFormat(startDate) + '-' + dateFormat(endDate) + vm.$t('tcb_report.tcb_big_text_two'), colSpan: 13, style: 'tablecell' }, 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', 'Column 10', 'Column 11', 'Column 11'],
            [
              { text: vm.$t('globalTrans.sl_no'), style: 'tablecell' },
              { text: vm.$t('tcb_report.regional_office'), style: 'tablecell' },
              { text: dateFormat(startDate) + vm.$t('tcb_report.beggining_of_date'), style: 'tablecell' },
              { text: vm.$t('tcb_report.amount_received_from_supplier'), style: 'tablecell' },
              { text: vm.$t('tcb_report.inter_warehouse_receipt_quantity'), style: 'tablecell' },
              { text: vm.$t('tcb_report.inter_warehouse_send_amount'), style: 'tablecell' },
              { text: vm.$t('tcb_report.sales_volume_a'), style: 'tablecell' },
              { text: vm.$t('tcb_report.total_taka_of_goods'), style: 'tablecell' },
              { text: vm.$t('tcb_report.amount_of_income_tax_at_source'), style: 'tablecell' },
              { text: vm.$t('tcb_report.wastage'), style: 'tablecell' },
              { text: vm.$t('tcb_report.wastage_pending'), style: 'tablecell' },
              { text: dateFormat(endDate) + vm.$t('tcb_report.closing_stock_of_date'), style: 'tablecell' },
              { text: vm.$t('tcb_report.comment'), style: 'tablecell' }
            ]
          ]
          itemCategoryList.map((itemcategry, catIndex) => {
              ProductWiseRows.push([{ text: vm.$t('tcb_report.product_name_qty_metric_ton') + itemcategry.text + vm.$t('tcb_report.metric_ton'), colSpan: 13, style: 'tablecell' }, 'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', 'Column 10', 'Column 11', 'Column 11'])
              ProductWiseRows.push([{ text: vm.$n('1'), style: 'tablecell' }, { text: vm.$n('2'), style: 'tablecell' }, { text: vm.$n('3'), style: 'tablecell' }, { text: vm.$n('4'), style: 'tablecell' }, { text: vm.$n('5'), style: 'tablecell' }, { text: vm.$n('6'), style: 'tablecell' }, { text: vm.$n('7'), style: 'tablecell' }, { text: vm.$n('8'), style: 'tablecell' }, { text: vm.$n('9'), style: 'tablecell' }, { text: vm.$n('10'), style: 'tablecell' }, { text: vm.$n('11'), style: 'tablecell' }, { text: vm.$n('12'), style: 'tablecell' }, { text: vm.$n('13'), style: 'tablecell' }])
              officeList.map((office, ofIndex) => {
                ProductWiseRows.push([{ text: vm.$n(ofIndex + 1), style: 'tablecell' },
                { text: vm.getOfficeName(office), style: 'tablecell' },
                { text: prevstocks.length > 0 ? vm.getPrevStock(office, itemcategry) : vm.$n(0), style: 'tablecell' },
                { text: vm.getStockIn(office, itemcategry), style: 'tablecell' },
                { text: vm.getRecInter(office, itemcategry), style: 'tablecell' },
                { text: vm.getSendInter(office, itemcategry), style: 'tablecell' },
                { text: vm.getSales(office, itemcategry), style: 'tablecell' },
                { text: vm.getSaleAmount(office, itemcategry), style: 'tablecell' },
                { text: vm.getTaxAmount(office, itemcategry), style: 'tablecell' },
                { text: vm.getWastAmount(office, itemcategry), style: 'tablecell' },
                { text: vm.getWastePending(office, itemcategry), style: 'tablecell' },
                { text: vm.getCurrentStock(office, itemcategry), style: 'tablecell' },
                { text: '', style: 'tablecell' }
              ])
              })
              ProductWiseRows.push([
                { text: '', style: 'tablecell' },
                { text: vm.$t('tcb_report.total_d'), style: 'tablecell' },
                { text: prevstocks.length > 0 ? vm.getPrevTotal(itemcategry) : vm.$n(0), style: 'tablecell' },
                { text: vm.getStockInTotal(itemcategry), style: 'tablecell' },
                { text: vm.getRecInterTotal(itemcategry), style: 'tablecell' },
                { text: vm.getSendInterTotal(itemcategry), style: 'tablecell' },
                { text: vm.getSalesTotal(itemcategry), style: 'tablecell' },
                { text: '', style: 'tablecell' },
                { text: '', style: 'tablecell' },
                { text: vm.getWastAmountTotal(itemcategry), style: 'tablecell' },
                { text: vm.getWastePendingTotal(itemcategry), style: 'tablecell' },
                { text: vm.getCurrentStockTotal(itemcategry), style: 'tablecell' },
                { text: '', style: 'tablecell' }
              ])
            })
            pdfContent.push({
              style: 'tableExample',
              table: {
                // widths: ['8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%', '8%'],
                widths: dyColumWidth,
                body: ProductWiseRows
              }
            })
          var docDefinition = {
          content: pdfContent,
          pageSize: 'A4',
          pageOrientation: 'Landcape',
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
