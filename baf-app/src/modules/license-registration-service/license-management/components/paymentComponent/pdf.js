import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, receipt, vm, application, transactionno) => {
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

        const allRowsHead = [
          [{ text: vm.$t('dealer.company_name'), style: 'tableHeader', colSpan: 3 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: (i18n.locale === 'bn' ? application.details.company_name_bn : application.details.company_name), style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }],
          [{ text: vm.$t('globalTrans.name'), style: 'tableHeader', colSpan: 3 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: (i18n.locale === 'bn' ? application.details.applicant_name_bn : application.details.applicant_name), style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }],
          [{ text: vm.$t('globalTrans.application_id'), style: 'tableHeader', colSpan: 3 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: (i18n.locale === 'bn' ? vm.$n(application.application_id, { useGrouping: false }) : vm.$n(application.application_id, { useGrouping: false })), style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }],
          [{ text: vm.$t('dealer.transaction_no'), style: 'tableHeader', colSpan: 3 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: transactionno, style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }],
          [{ text: vm.$t('dealer.payment_type'), style: 'tableHeader', colSpan: 3 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: vm.getPaidType(receipt[0].paid_type), style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }],
          [{ text: vm.$t('dealer.payment_history'), style: 'tableHeader', colSpan: 7 }, { text: 'Header 2', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: '', style: 'tableHeader', colSpan: 4 }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }, { text: 'Header 3', style: 'tableHeader' }]
        ]

        receipt.map((item) => {
          allRowsHead.push([{ text: vm.$t('fee_name.fee_name'), style: 'tableHeader' }, { text: vm.$t('globalTrans.fees') + ' ' + vm.$t('globalTrans.amount'), style: 'tableHeader', colSpan: 2 }, { text: 'Header 3', style: 'tableHeader' }, { text: vm.$t('globalTrans.vat') + '%', style: 'tableHeader', colSpan: 2 }, { text: 'Header 3', style: 'tableHeader' }, { text: vm.$t('globalTrans.tax') + '%', style: 'tableHeader', colSpan: 2 }, { text: 'Header 3', style: 'tableHeader' }])
          allRowsHead.push([{ text: vm.getFeeName(item.payment_type), style: 'tableHeader', rowSpan: 5 }, { text: vm.$t('globalTrans.amount'), style: 'tableHeader' }, { text: vm.$n(item.amount), style: 'tableHeader' }, { text: vm.$t('globalTrans.amount'), style: 'tableHeader' }, { text: (item.amount_vat ? vm.$n(item.amount_vat) : ''), style: 'tableHeader' }, { text: vm.$t('globalTrans.amount'), style: 'tableHeader' }, { text: (item.amount_tax ? vm.$n(item.amount_tax) : ''), style: 'tableHeader' }])
          allRowsHead.push([{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.challan_no'), style: 'tableHeader' }, { text: vm.$n(item.challan_no), style: 'tableHeader' }, { text: vm.$t('dealer.challan_no'), style: 'tableHeader' }, { text: (item.challan_no_vat ? vm.$n(item.challan_no_vat) : ''), style: 'tableHeader' }, { text: vm.$t('dealer.challan_no'), style: 'tableHeader' }, { text: (item.challan_no_tax ? vm.$n(item.challan_no_tax) : ''), style: 'tableHeader' }])
          allRowsHead.push([{ text: '', style: 'tableHeader' }, { text: vm.$t('globalTrans.date'), style: 'tableHeader' }, { text: dateFormat(item.pay_date), style: 'tableHeader' }, { text: vm.$t('globalTrans.date'), style: 'tableHeader' }, { text: (item.pay_date_vat ? vm.$n(item.pay_date_vat) : ''), style: 'tableHeader' }, { text: vm.$t('globalTrans.date'), style: 'tableHeader' }, { text: (item.pay_date_tax ? vm.$n(item.pay_date_tax) : ''), style: 'tableHeader' }])
          allRowsHead.push([{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.bank_name'), style: 'tableHeader' }, { text: item.bank_name, style: 'tableHeader' }, { text: vm.$t('dealer.bank_name'), style: 'tableHeader' }, { text: (item.bank_name_vat ? item.bank_name_vat : ''), style: 'tableHeader' }, { text: vm.$t('dealer.bank_name'), style: 'tableHeader' }, { text: (item.bank_name_tax ? item.bank_name_tax : ''), style: 'tableHeader' }])
          allRowsHead.push([{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.branch_name'), style: 'tableHeader' }, { text: item.branch_name, style: 'tableHeader' }, { text: vm.$t('dealer.branch_name'), style: 'tableHeader' }, { text: (item.branch_name_vat ? item.branch_name_vat : ''), style: 'tableHeader' }, { text: vm.$t('dealer.branch_name'), style: 'tableHeader' }, { text: (item.branch_name_tax ? item.branch_name_tax : ''), style: 'tableHeader' }])
        })

        allRowsHead.push([{ text: vm.$t('dealer.sub_total'), style: 'tableHeader' }, { text: vm.$n(vm.getTotal(receipt)), style: 'tableHeader', colSpan: 2 }, { text: '', style: 'tableHeader' }, { text: vm.$n(vm.getTotalVat(receipt)), style: 'tableHeader', colSpan: 2 }, { text: '', style: 'tableHeader' }, { text: vm.$n(vm.getTotalTax(receipt)), style: 'tableHeader', colSpan: 2 }, { text: '', style: 'tableHeader' }])
        allRowsHead.push([{ text: vm.$t('globalTrans.total'), style: 'leftalign' }, { text: vm.$n(vm.getTotal(receipt) + vm.getTotalVat(receipt) + vm.getTotalTax(receipt)), style: 'leftalign', colSpan: 6 }, { text: '', style: 'tableHeader' }, { text: '', style: 'tableHeader' }, { text: '', style: 'tableHeader' }, { text: '', style: 'tableHeader' }, { text: '', style: 'tableHeader' }])

        // }
        pdfContent.push({
          style: 'tableExample',
          table: {
            headerRows: 1,
            widths: ['14%', '14%', '14%', '14%', '14%', '14%', '14%'],
            body: allRowsHead
          },
          layout: {
            hLineWidth: function (i, node) {
              return (i === 0 || i === node.table.body.length) ? 2 : 1
            },
            vLineWidth: function (i, node) {
              return (i === 0 || i === node.table.widths.length) ? 2 : 1
            },
            hLineColor: function (i, node) {
              return (i === 0 || i === node.table.body.length) ? 'black' : 'gray'
            },
            vLineColor: function (i, node) {
              return (i === 0 || i === node.table.widths.length) ? 'black' : 'gray'
            }
            // hLineStyle: function (i, node) { return {dash: { length: 10, space: 4 }}; },
            // vLineStyle: function (i, node) { return {dash: { length: 10, space: 4 }}; },
            // paddingLeft: function(i, node) { return 4; },
            // paddingRight: function(i, node) { return 4; },
            // paddingTop: function(i, node) { return 2; },
            // paddingBottom: function(i, node) { return 2; },
            // fillColor: function (rowIndex, node, columnIndex) { return null; }
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
            margin: [0, 10, 0, 10],
            fontSize: 14
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
