import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../e-biz-reports/pages/report-heading/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, itemList, bpcBudget, search, vm) => {
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
            layout: 'noBorders'
          })

          const ProductWiseRowsFirst = [
            [
             { text: vm.$t('eBizReports.project_closure_report'), style: 'tablecellUni', colSpan: 5 },
             { text: vm.$t('eBizReports.proposal_no'), style: 'tablecell' },
             { text: vm.$t('eBizReports.program_id'), style: 'tablecell' },
             { text: vm.$t('eBizReports.program_name'), style: 'tablecell' },
             { text: vm.$t('eBizReports.investigator_name'), style: 'tablecell' }]
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
             { text: vm.$t('globalTrans.sl_no'), style: 'tablecell' },
             { text: vm.$t('globalTrans.fiscal_year'), style: 'tablecell' },
             { text: vm.$t('eBizReports.proposal_no'), style: 'tablecell' },
             { text: vm.$t('eBizReports.program_id'), style: 'tablecell' },
             { text: vm.$t('eBizReports.program_name'), style: 'tablecell' },
             { text: vm.$t('globalTrans.start_date'), style: 'tablecell' },
             { text: vm.$t('globalTrans.end_date'), style: 'tablecell' }]
          ]

            itemList.map((item, index) => {
                ProductWiseRows.push([
                 { text: vm.$n(index + 1), style: 'tablecell' },
                 { text: vm.getFiscalYear(item.fiscal_year_id), style: 'tablecell' },
                 { text: item.proposal_id, style: 'tablecell' },
                 { text: vm.$n(item.program_id), style: 'tablecell' },
                 { text: vm.currentLocale === 'en' ? item.programe_name_en : item.programe_name_bn, style: 'tablecell' },
                 { text: dateFormat(item.start_date), style: 'tablecell' },
                 { text: dateFormat(item.end_date), style: 'tablecell' }])
            })
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: ['14%', '14%', '14%', '14%', '14%', '14%', '14%'],
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
          tablecellUni: {
            fontSize: (i18n.locale === 'bn') ? 13 : 12,
            margin: [3, 3, 3, 3],
            alignment: 'center'
          },
          tableExampleTwo: {
            fontSize: (i18n.locale === 'bn') ? 10 : 7,
            margin: [3, 13, 3, 23]
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
