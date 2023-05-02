import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, monthlyReport, vm, initialStock, search, categoryname, itemname) => {
  function totalCalculation (data) {
    let total = 0
    data.map(function (report, index) {
      total += report.total_stock_in - (report.total_stock_out + report.total_stock_out_pending + report.total_on_transport + report.total_truck_distribution + report.total_store_distribution)
    })
    return total
  }
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

        // }

        const allRowsHead1 = [
          [
            { text: vm.$t('organogram.regional_office_name') + ' : ' + vm.getOfficeName(search.regional_office), alignment: 'left', style: 'thh' },
            { text: vm.$t('tcb_report.item_category') + ' : ' + ((i18n.locale === 'bn') ? categoryname.text_bn : categoryname.text_en), alignment: 'left', style: 'thh' },
            { text: vm.$t('tcb_report.item') + ' : ' + ((i18n.locale === 'bn') ? itemname.text_bn : itemname.text_en), alignment: 'left', style: 'thh' }
          ]
        ]

        allRowsHead1.push([
          { text: vm.$t('globalTrans.fiscal_year') + ' : ' + vm.getFiscalYear(search.fiscal_year_id), alignment: 'left', style: 'thh' },
          { text: vm.$t('tcb_report.month') + ' : ' + vm.getMonthName(search.month), alignment: 'left', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'thh' }
        ])

        allRowsHead1.push([
          { text: '' + '' + '', alignment: 'left', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'marginForUse' }
        ])

        pdfContent.push({
          table: {
            headerRows: 1,
            widths: '*',
            body: allRowsHead1
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
          [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), colSpan: 6, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
          [{ text: vm.$t('tcb_report.product_wise_monthly_report'), colSpan: 6, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
          [{ text: vm.$t('globalTrans.sl_no'), style: 'tablecell' }, { text: vm.$t('globalTrans.date'), style: 'tablecell' }, { text: vm.$t('tcb_report.early'), style: 'tablecell' }, { text: vm.$t('tcb_report.receive'), style: 'tablecell' }, { text: vm.$t('tcb_report.supply'), style: 'tablecell' }, { text: vm.$t('tcb_report.conclusion'), style: 'tablecell' }]
        ]
          monthlyReport.map((item, index) => {
            ProductWiseRows.push([{ text: vm.$n(index + 1), style: 'tablecell' }, { text: dateFormat(item.stock_date), style: 'tablecell' }, { text: vm.$n(initialStock), style: 'tablecell', rowSpan: monthlyReport.length }, { text: vm.$n(item.total_stock_in), style: 'tablecell' }, { text: vm.$n(item.total_stock_out + item.total_stock_out_pending + item.total_on_transport + item.total_truck_distribution + item.total_store_distribution), style: 'tablecell' }, { text: vm.$n(item.total_stock_in - (item.total_stock_out + item.total_stock_out_pending + item.total_on_transport + item.total_truck_distribution + item.total_store_distribution)), style: 'tablecell' }])
          })
       ProductWiseRows.push([{ text: vm.$t('globalTrans.total') + vm.$t('tcb_report.conclusion'), colSpan: 5, style: 'tablecell' }, {}, {}, {}, {}, { text: vm.$n(totalCalculation(monthlyReport)), style: 'tablecell' }])
    pdfContent.push({
            style: 'tableExample',
            table: {
              widths: ['16%', '17%', '17%', '17%', '17%', '17%'],
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
      if (error) {
      }
    }
    Store.commit('mutateCommonProperties', {
      loading: false
    })
}
export default {
  exportPdfDetails
}
