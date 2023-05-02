import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../report-heading/ReportHeadingPdf'

const exportPdfDetails = async (vm, itemList) => {
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
          allRowsHeadTwo.push(['', { text: vm.$t('eBizReports.periodical_report'), alignment: 'center' }, ''])
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

          const ProductWiseRowsFirst = [
            [
            { text: '', style: 'tablecellUni', colSpan: 5 },
            { text: vm.$t('eBizReports.proposal_no'), style: 'tablecell' },
            { text: vm.$t('eBizReports.program_id'), style: 'tablecell' },
            { text: vm.$t('eBizReports.program_name'), style: 'tablecell' },
            { text: vm.$t('eBizReports.investigator_name'), style: 'tablecell' }
            ]
            ]

            pdfContent.push({
              style: 'tableExampleTwo',
              table: {
                widths: ['20%', '20%', '20%', '20%', '20%'],
                body: ProductWiseRowsFirst
              },
              layout: 'noBorders'
            })

            const ProductWiseRows = [
              [
               { text: vm.$t('globalTrans.sl_no'), style: 'tablecell', rowSpan: 2 },
               { text: vm.$t('eBizReports.council'), style: 'tablecell', rowSpan: 2 },
               { text: vm.$t('eBizReports.association'), style: 'tablecell', rowSpan: 2 },
               { text: vm.$t('globalTrans.fiscal_year') + ' ' + vm.$n(1), style: 'tablecell', colSpan: 2 },
               { text: vm.$t('eBizReports.investigator_name'), style: 'tablecell' },
               { text: vm.$t('globalTrans.fiscal_year') + ' ' + vm.$n(2), style: 'tablecell', colSpan: 2 },
               { text: '', style: 'tablecell' },
               { text: vm.$t('globalTrans.fiscal_year') + ' ' + vm.$n(3), style: 'tablecell', colSpan: 2 },
               { text: '', style: 'tablecell' }
              ],
              [
               { text: '', style: 'tablecell' },
               { text: '', style: 'tablecell' },
               { text: '', style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_budget'), style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_expense'), style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_budget'), style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_expense'), style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_budget'), style: 'tablecell' },
               { text: vm.$t('eBizReports.actual_expense'), style: 'tablecell' }]
            ]

            itemList.map((item, index) => {
              ProductWiseRows.push([
               { text: vm.$n(index + 1), style: 'tablecell' },
               { text: vm.currentLocale === 'en' ? item.council_name_en : item.council_name_bn, style: 'tablecell' },
               { text: vm.currentLocale === 'en' ? item.association_name_en : item.association_name_bn, style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_one_actual_budget), style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_one_payable), style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_two_actual_budget), style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_two_payable), style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_three_actual_budget), style: 'tablecell' },
               { text: vm.$n(item.fiscal_year_three_payable), style: 'tablecell' }])
            })

            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: ['11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%'],
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
            fontSize: 8,
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
