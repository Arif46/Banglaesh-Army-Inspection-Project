import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
  try {
    Store.commit('mutateCommonProperties', {
      loading: true
    })
    if (i18n.locale === 'bn') {
      pdfMake.vfs = pdfFontsBn.pdfMake.vfs
    } else {
        pdfMake.vfs = pdfFontsEn.pdfMake.vfs
    }
    const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
    const pdfContent = [{
          columns: reportHeadData?.reportHeadColumn
      },
      { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData?.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]
      const basicInformationTable = [
        [
          { text: vm.$t('configuration.document_type'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.getDocumentTypeName(vm.items.document_type_id), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('globalTrans.title'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.getDocumentTitle(vm.items.document_type_id), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('research_execution.client'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: (i18n.locale === 'bn') ? vm.items.client_bn : vm.items.client, style: 'th', alignment: 'left' },
          { text: vm.$t('research_execution.project_duration'), style: 'th', alignment: 'right', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: (i18n.locale === 'bn') ? vm.items.duration_bn : vm.items.duration, style: 'th', alignment: 'left' }
        ],
        // [
        //   { text: vm.$t('research_execution.project_duration'), style: 'th', alignment: 'left', bold: true },
        //   { text: ':', style: 'td', alignment: 'center' },
        //   { text: (i18n.locale === 'bn') ? vm.items.duration_bn : vm.items.duration, style: 'th', alignment: 'left' }
        // ],
        [
          { text: vm.$t('researchRequestManagement.contract_amount'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.$n(vm.contract_amount, { useGrouping: false }), style: 'th', alignment: 'left' },
          { text: vm.$t('research_execution.rcv_amount'), style: 'th', alignment: 'right', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.$n(vm.totRcv, { useGrouping: false }), style: 'th', alignment: 'left' }
        ],
        // [
        //   { text: vm.$t('research_execution.rcv_amount'), style: 'th', alignment: 'left', bold: true },
        //   { text: ':', style: 'td', alignment: 'center' },
        //   { text: vm.$n(vm.totRcv, { useGrouping: false }), style: 'th', alignment: 'left' }
        // ],
        [
          { text: vm.$t('report_management.payment_schedule'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: dateFormat(vm.contract_date), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['20%', '5%', '35%', '15%', '5%', '20%'],
          body: basicInformationTable
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
      const rcvPaymentTable = [
        [
          { text: vm.$t('research_execution.rcv_amount'), alignment: 'center', style: 'th', colSpan: 4, bold: true },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('report_management.sl'), alignment: 'center', style: 'th' },
          { text: vm.$t('report_management.particular'), alignment: 'center', style: 'th' },
          { text: vm.$t('report_management.amount'), alignment: 'center', style: 'th' },
          { text: vm.$t('globalTrans.remarks'), alignment: 'center', style: 'th' }
        ]
      ]
      vm.rcvPayment.forEach((item, index) => {
      rcvPaymentTable.push(
            [
              { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
              { text: vm.getInstallmentName(item.installment_id), alignment: 'center', style: 'td' },
              { text: vm.$n(item.actual_rcv_amount, { useGrouping: false }), alignment: 'center', style: 'td' },
              { text: item.remark, alignment: 'center', style: 'td' }
            ]
          )
        })
      rcvPaymentTable.push(
        [
          { },
          { text: vm.$t('globalTrans.total') + ': ', alignment: 'right', style: 'td' },
          { text: vm.$n(vm.totRcv, { useGrouping: false }), alignment: 'left', style: 'td', colSpan: 2, margin: [25, 2, 0, 0] },
          { }
        ]
      )
      const expenditureTable = [
        [
          { text: vm.$t('report_management.expenditure'), alignment: 'center', style: 'th', colSpan: 3, bold: true },
          { },
          { }
        ],
        [
          // { text: vm.$t('report_management.sl'), alignment: 'center', style: 'th' },
          { text: vm.$t('report_management.particular'), alignment: 'center', style: 'th' },
          { text: vm.$t('report_management.amount'), alignment: 'center', style: 'th' },
          { text: vm.$t('globalTrans.remarks'), alignment: 'center', style: 'th' }
        ]
      ]
      vm.expenseArr.forEach((mainItem, index) => {
        mainItem.forEach((expenseItem, index2) => {
          expenditureTable.push(
              [
                // { text: vm.$n(index2 + 1), alignment: 'center', style: 'td' },
                { text: vm.getExpenditureHeadName(expenseItem.expenditure_head_id), alignment: 'center', style: 'td' },
                { text: vm.$n(expenseItem.expense_amount, { useGrouping: false }), alignment: 'center', style: 'td' },
                { text: vm.expenditureInfo[index].remark, alignment: 'center', style: 'td' }
              ]
            )
        })
      })
      expenditureTable.push(
        [
          { text: vm.$t('globalTrans.total') + ': ', alignment: 'right', style: 'td' },
          { text: vm.$n(vm.totExpense, { useGrouping: false }), alignment: 'left', style: 'td', colSpan: 2, margin: [15, 2, 0, 0] },
          { }
        ]
      )
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: '', style: 'fertilizer' })
      // pdfContent.push({ text: vm.$t('research_execution.rcv_amount') + '                                                                           ' + vm.$t('report_management.expenditure'), style: 'fertilizer', alignment: 'center' })
      pdfContent.push({
        table: {
          widths: ['50%', '50%'],
          body: [
              [
                {
                  table: {
                    widths: ['12%', '28%', '30%', '30%'],
                    body: rcvPaymentTable
                  }
                },
                {
                  table: {
                    headerRows: 1,
                    widths: ['30%', '15%', '55%'],
                    body: expenditureTable
                  }
                }
              ]
          ]
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
      pdfContent.push({ text: '', style: 'fertilizer' })
      // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
      var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
      // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
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
          fontSize: (i18n.locale === 'bn') ? 10 : 11,
          margin: [3, 3, 3, 3]
        },
        fertilizer: {
          margin: [5, 0, 0, 5]
        },
        header: {
            fontSize: 16,
            bold: true,
            margin: [0, 0, 0, 0]
        },
        org: {
            fontSize: 13,
            bold: true,
            margin: [0, -25, 10, 5]
        },
        address: {
            fontSize: 11,
            margin: [0, 0, 0, 5]
        },
        hh: {
            fontSize: 13,
            bold: true,
            margin: [10, 10, 25, 20]
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
          margin: [0, 4, 0, 11]
        },
        krishi: {
          margin: [0, -5, 0, 11],
          alignment: 'center'
        },
        header3: {
          fontSize: 9,
          margin: [0, 0, 0, 0]
        },
        tableSubHead: {
          margin: [0, 5, 0, 11]
        },
        header1: {
          fontSize: 13,
          margin: [0, 5, 0, 5]
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
