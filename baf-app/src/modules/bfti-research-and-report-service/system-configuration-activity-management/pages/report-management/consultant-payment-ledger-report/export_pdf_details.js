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
          { text: (i18n.locale === 'bn') ? vm.items.topic_bn : vm.items.topic, style: 'th', alignment: 'left' },
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
        [
          { text: vm.$t('research_execution.consultant_name'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: (i18n.locale === 'bn') ? vm.items.consultant_name_bn : vm.items.consultant_name, style: 'th', alignment: 'left' },
          { text: vm.$t('report_management.contract_date_from'), style: 'th', alignment: 'right', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: dateFormat(vm.items.date_from), style: 'th', alignment: 'left' }
        ],
        [
          { text: vm.$t('report_management.contract_date_to'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: dateFormat(vm.items.date_to), style: 'th', alignment: 'left' },
          { text: vm.$t('researchRequestManagement.contract_amount'), style: 'th', alignment: 'right', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.$n(vm.items.amount, { useGrouping: false }), style: 'th', alignment: 'left' }
        ],
        [
          { text: vm.$t('research_execution.rem_amount'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.$n(vm.remAmount, { useGrouping: false }), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['20%', '5%', '30%', '20%', '5%', '20%'],
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
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: '', style: 'fertilizer' })
        const allRows = [
          [
            { text: vm.$t('research_execution.payment_schedule'), style: 'header1', alignment: 'center', bold: true, colSpan: 8 },
            { },
            { },
            { },
            { },
            { },
            { },
            { }
          ],
          [
            { text: vm.$t('report_management.sl'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.payment_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('report_management.paid_amount_tk'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.tax'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('report_management.tax_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.total') + ' ' + vm.$t('research_execution.paid_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('report_management.payable_balance'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.remarks'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        if (vm.detailsData.length) {
          vm.detailsData.forEach((paymentItem, index) => {
            allRows.push(
              [
                { text: vm.$n(index + 1), style: 'td', alignment: 'center' },
                { text: dateFormat(paymentItem.payment_date), style: 'td', alignment: 'center' },
                { text: vm.$n(paymentItem.paid_amount, { useGrouping: false }), style: 'td', alignment: 'center' },
                { text: vm.$n(paymentItem.tax, { useGrouping: false }), style: 'td', alignment: 'center' },
                { text: vm.$n(paymentItem.tax_amount, { useGrouping: false }), style: 'td', alignment: 'center' },
                { text: vm.$n(paymentItem.actual_paid_amount, { useGrouping: false }), style: 'td', alignment: 'center' },
                { text: vm.$n(paymentItem.payable_amount, { useGrouping: false }), style: 'td', alignment: 'center' },
                { text: paymentItem.remark, style: 'td', alignment: 'right' }
              ]
            )
          })
          allRows.push(
            [
              { text: vm.$t('globalTrans.total'), style: 'td', alignment: 'right', colSpan: 2 },
              { },
              { text: vm.$n(vm.totPaid, { useGrouping: false }), style: 'td', alignment: 'center' },
              { text: vm.$n(vm.totTax), style: 'td', alignment: 'center' },
              { text: vm.$n(vm.totTaxAmount, { useGrouping: false }), style: 'td', alignment: 'center' },
              { text: vm.$n(vm.totActualPaid, { useGrouping: false }), style: 'td', alignment: 'center' },
              { },
              { }
            ]
          )
        } else {
          allRows.push(
            [
              { text: vm.$t('globalTrans.noDataFound'), style: 'td', alignment: 'center', colSpan: 8 },
              { },
              { },
              { },
              { },
              { },
              { },
              { }
            ]
          )
        }
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['10%', '20%', '15%', '15%', '10%', '10%', '10%', '10%'],
            body: allRows
          }
        })
      var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
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
