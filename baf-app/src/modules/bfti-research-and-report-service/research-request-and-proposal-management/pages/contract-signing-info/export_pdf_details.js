import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, data) => {
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
          columns: reportHeadData.reportHeadColumn
      },
      { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]
    pdfContent.push({ text: '', style: 'marginStyle' })
    pdfContent.push({ text: '', style: 'marginStyle' })
    pdfContent.push({ text: '', style: 'marginStyle' })
    const allRows = [
      [
        { text: vm.$t('configuration.document_type'), style: 'td', alignment: 'left', bold: true },
        { text: ':', style: 'td', alignment: 'left' },
        { text: vm.getDocumentTypeName(data.document_type_id), style: 'td', alignment: 'left' }
      ],
      [
        { text: vm.$t('globalTrans.title'), style: 'td', alignment: 'left', bold: true },
        { text: ':', style: 'td', alignment: 'left' },
        { text: vm.getDocumentTitle(data.document_type_id), style: 'td', alignment: 'left' }
      ],
      [
        { text: vm.$t('research_plan_management.organization_ministry_division'), style: 'td', alignment: 'left', bold: true },
        { text: ':', style: 'td', alignment: 'left' },
        { text: (i18n.locale === 'bn') ? data.organization_ministry_division_bn : data.organization_ministry_division, style: 'td', alignment: 'left' }
      ],
      [
        { text: vm.$t('researchRequestManagement.contract_sign') + ' ' + vm.$t('globalTrans.date'), style: 'td', alignment: 'left', bold: true },
        { text: ':', style: 'td', alignment: 'left' },
        { text: dateFormat(data.contract_date), style: 'td', alignment: 'left' }
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['30%', '5%', '65%'],
        body: allRows
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
    pdfContent.push({ text: '', style: 'marginStyle' })
    pdfContent.push({ text: '', style: 'marginStyle' })
    pdfContent.push({ text: vm.$t('researchRequestManagement.budget_information'), fillColor: 'gray', style: 'my_title', alignment: 'center', bold: true })
    pdfContent.push({ text: '', style: 'marginStyle' })
    pdfContent.push({ text: vm.$t('researchRequestManagement.contract_amount') + ': ' + vm.$n(data.contract_amount, { useGrouping: false }), style: 'marginStyle', bold: true })
    const allRows2 = [
      [
        { text: vm.$t('researchRequestManagement.installment'), style: 'td', alignment: 'center', bold: true },
        { text: vm.$t('researchRequestManagement.payment_for'), style: 'td', alignment: 'center', bold: true },
        { text: vm.$t('researchRequestManagement.installment_amount'), style: 'td', alignment: 'center', bold: true }
      ]
    ]
    data.budgets.forEach((item, index) => {
        allRows2.push(
        [
          { text: vm.getInstallmentName(item.installment_id), style: 'td', alignment: 'center' },
          { text: item.payment_for, style: 'td', alignment: 'center' },
          { text: vm.$n(item.installment_amount, { useGrouping: false }), style: 'td', alignment: 'center' }
        ]
        )
    })
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['40%', '30%', '30%'],
        body: allRows2
      }
    })
    pdfContent.push({ text: '', style: 'marginStyle' })
    var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        td: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        search: {
          fontSize: (i18n.locale === 'bn') ? 10 : 11,
          margin: [3, 3, 3, 3]
        },
        marginStyle: {
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
        tableSubHead: {
          margin: [0, 5, 0, 15]
        },
        my_title: {
          border: 0,
          fillColor: '#dee2e6',
          fontSize: 13,
          margin: [0, 10, 0, 10],
          bold: true,
          alignment: 'center'
        }
      }
    }
    pdfMake.createPdf(docDefinition, null, null, null).print('')
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
