import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
// import { ReportHeading } from '../../../e-biz-reports/pages/report-heading/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, items, vm) => {
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
          // const rowItemTwo = ReportHeading(vm)
          // allRowsHeadTwo.push(...rowItemTwo)
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', { text: `${vm.currentLocale === 'en' ? 'Program Voucher' : 'প্রোগ্রাম ভাউচার'}`, alignment: 'center', fontSize: 18 }, ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          pdfContent.push({
            table: {
              widths: ['20%', '60%', '20%'],
              body: allRowsHeadTwo
            },
            layout: 'noBorders'
          })

          const amount = items.program?.payment == null ? vm.$n(0) : vm.$n(items.program?.payment?.amount)
          const chequeNo = items.program?.payment == null ? vm.$n(0) : vm.$n(items.program?.payment?.cheque_no, { useGroupning: false })

          const ProductWiseRowsFirst = [
            [
              { text: vm.$t('globalTrans.date') + ' : ' + dateFormat(items.program?.payment.updated_at), style: 'tablecell', alignment: 'left', fontSize: 14 },
              { text: '', style: 'tablecell' },
              { text: '', style: 'tablecell' }
            ],
            [
              { text: vm.$t('associationPnl.receive_from') + ' : ' + vm.getCouncilName(items.program.council_info_id), style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5], colSpan: 3 },
              { text: '', style: 'tablecell' },
              { text: '', style: 'tablecell' }
            ],
            [
              { text: vm.$t('associationPnl.amount') + ' : ' + amount, style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5] },
              { text: vm.$t('eBizProgram.cheque_no') + ' : ' + chequeNo, style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5], colSpan: 2 },
              { text: '', style: 'tablecell' }
            ],
            [
              { text: vm.$t('associationPnl.for') + ' : ' + `${vm.currentLocale === 'en' ? items.program.program.programe_name_en : items.program.program.programe_name_bn}`, style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5], colSpan: 3 },
              { text: '', style: 'tablecell' },
              { text: '', style: 'tablecell' }
            ]
          ]

            pdfContent.push({
              style: 'tableExampleTwo',
              table: {
                widths: ['50%', '25%', '25%'],
                body: ProductWiseRowsFirst
              },
              layout: 'noBorders'
            })

          // const ProductWiseRowsTwo = [
          //   [
          //     { text: vm.$t('associationPnl.amount') + ' : ' + amount, style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5] },
          //     { text: vm.$t('eBizProgram.cheque_no') + ' : ' + chequeNo, style: 'tablecell', alignment: 'left', fontSize: 14, margin: [0, 5] },
          //     { text: '', style: 'tablecell' }
          //   ]
          // ]

          //   pdfContent.push({
          //     style: 'tableExampleTwo',
          //     table: {
          //       widths: ['50%', '49%', '1%'],
          //       body: ProductWiseRowsTwo
          //     },
          //     layout: 'noBorders'
          //   })
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
