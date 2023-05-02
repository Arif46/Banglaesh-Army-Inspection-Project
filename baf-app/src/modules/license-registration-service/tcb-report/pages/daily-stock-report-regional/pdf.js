import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, itemList, vm) => {
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
          const allrows = [
            [
              { text: vm.$t('tcb_report.regional_office_camp') + ':' + vm.getOfficeName(), alignment: 'center', colSpan: 16, style: 'tablecellTwo' },
               { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }
          ]
        ]
          pdfContent.push({
            table: {
              widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
              body: allrows
            },
            layout: 'noBorders'
          })
          const allrowsTwo = [[{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }]]
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
          pdfContent.push({
            table: {
              widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
              body: allrowsTwo
            },
            layout: 'noBorders'
          })

          // var widthone = ['12%', '12%', '12%', '12%', '12%', '12%', '12%']
          const firstrow = []
          firstrow.push(
            { text: vm.$t('tcb_report.date_a') + ':' + dateFormat(vm.search.search_date), colSpan: 6, borderleft: false, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6',
            { text: vm.$t('tcb_report.tcb_big_text'), colSpan: 15, style: 'tablecell' }, 'Column 8', 'Column 9', 'Column 10', 'Column 11', 'Column 12', 'Column 13', 'Column 14', 'Column 15', 'Column 16', 'Column 17', 'Column 18', 'Column 19', 'Column 20', 'Column 21'
          )
          const secondrow = [
            { text: vm.$t('globalTrans.sl_no'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.product_name'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.brand_name'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.contact_no'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.initial_stock_a'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.receive_amount'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.total_stock_quantity'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.sending_to_different_warehouse'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('stock_management.on_transport'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.sales_volume_a'), colSpan: 4, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 4',
            { text: vm.$t('tcb_report.total_sales_amount'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('stock_management.stock_out') + vm.$t('stock_management.approved'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('stock_management.stock_out') + vm.$t('stock_management.pending'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.per_kg_liter_price'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.total_sell_price_taka'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.retail_salesCenter_reserves'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.closing_stock'), rowSpan: 3, style: 'tablecell' },
            { text: vm.$t('tcb_report.comment'), rowSpan: 3, style: 'tablecell' }
          ]
          const thirdrow = [
            'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', { text: vm.$t('tcb_report.truck_sale'), colSpan: 2, style: 'tablecell' }, 'Column 11', { text: vm.$t('tcb_report.general_allotment'), colSpan: 2, style: 'tablecell' }, 'Column 13', 'Column 14', 'Column 15', 'Column 16', 'Column 17', 'Column 18', 'Column 19', 'Column 20', 'Column 21'
          ]
          const forthrow = [
            'Column 1', 'Column 2', 'Column 3', 'Column 4', 'Column 5', 'Column 6', 'Column 7', 'Column 8', 'Column 9', { text: vm.$t('tcb_report.number'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.number'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, 'Column 14', 'Column 15', 'Column 16', 'Column 17', 'Column 18', 'Column 19', 'Column 20', 'Column 21'
          ]
          const DailyStockReportRegional = [
            firstrow,
            secondrow,
            thirdrow,
            forthrow
          ]
          itemList.map((item, index) => {
            item.contractItems.map((innerItem, indx) => {
            const looprow = []
            looprow.push({ text: vm.$n(index + 1), rowSpan: item.contractItems.length, style: 'tablecell' })
            looprow.push({ text: i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en, rowSpan: item.contractItems.length, style: 'tablecell' })
             looprow.push({ text: i18n.locale === 'bn' ? innerItem.contractnum.supplier_name_bn : innerItem.contractnum.supplier_name, style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.contractnum.contract_no), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_initial_stock), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_receive_total), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_initial_stock + innerItem.report_receive_total), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_inter_warehouse), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_on_transport), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_truck_sale_number), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_truck_sale_quantity), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_storeallo_number), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_storeallo_quantity), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_distribution_truck_sale_quantity + innerItem.report_distribution_storeallo_quantity + innerItem.report_distribution_inter_warehouse), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_stock_out_approved), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_stock_out_pending), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.selling_price), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.selling_price * innerItem.report_distribution_total), style: 'tablecell' })
             looprow.push({ text: vm.$n(0), style: 'tablecell' })
             looprow.push({ text: vm.$n(innerItem.report_closing_stock), style: 'tablecell' })
             looprow.push({ text: '--', style: 'tablecell' })
             DailyStockReportRegional.push(looprow)
           })
          })
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: ['2%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '3%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%', '5%'],
                body: DailyStockReportRegional
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
