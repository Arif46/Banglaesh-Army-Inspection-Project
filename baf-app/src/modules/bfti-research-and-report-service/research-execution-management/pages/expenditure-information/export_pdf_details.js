import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, data, contractSignData) => {
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
    pdfContent.push({ text: '', style: 'fertilizer' })
    pdfContent.push({ text: '', style: 'fertilizer' })
    // pdfContent.push({ text: '', style: 'fertilizer' })
    // pdfContent.push({ text: vm.$t('researchRequestManagement.contract_signing_basic_info'), style: 'fertilizer', alignment: 'left', bold: true })
    // pdfContent.push({ text: '', style: 'fertilizer' })

    const basicInformationTable = [
      [
        { text: vm.$t('configuration.document_type'), style: 'th', alignment: 'left', bold: true },
        { text: vm.getDocumentTypeName(data.document_type_id), style: 'th', colSpan: 3, alignment: 'left' },
        { },
        { }
      ],
      [
        { text: vm.$t('globalTrans.title'), style: 'th', alignment: 'left', bold: true },
        { text: vm.getDocumentTitle(data.document_type_id), colSpan: 3, style: 'th', alignment: 'left' },
        { },
        { }
      ],
      [
        { text: vm.$t('research_execution.client'), style: 'th', alignment: 'left', bold: true },
        { text: vm.getClientName(data.document_type_id), style: 'th', alignment: 'left' },
        { text: vm.$t('research_execution.project_duration'), style: 'th', alignment: 'left', bold: true },
        { text: contractSignData.duration, style: 'th', alignment: 'left' }
      ],
      [
        { text: vm.$t('researchRequestManagement.contract_amount'), style: 'th', alignment: 'left', bold: true },
        { text: vm.$n(contractSignData.contract_amount, { useGrouping: false }), style: 'th', alignment: 'left' },
        { text: vm.$t('research_execution.rcv_amount'), style: 'th', alignment: 'left', bold: true },
        { text: vm.$n(contractSignData.rcv_amount, { useGrouping: false }), style: 'th', alignment: 'left' }
      ],
      [
        { text: vm.$t('research_execution.rem_rcv_amount'), style: 'th', alignment: 'left', bold: true },
        { text: vm.$n(contractSignData.rem_amount, { useGrouping: false }), style: 'th', alignment: 'left' },
        { text: vm.$t('research_execution.current_amount'), style: 'th', alignment: 'left', bold: true },
        { text: vm.$n(contractSignData.usable_amount, { useGrouping: false }), style: 'th', alignment: 'left' }
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['25%', '25%', '25%', '25%'],
        body: basicInformationTable
      }
    })
    pdfContent.push({ text: '', style: 'fertilizer' })
    pdfContent.push({ text: '', style: 'fertilizer' })
    pdfContent.push({ text: '', style: 'fertilizer' })
    pdfContent.push({ text: vm.$t('research_execution.expenditure_information'), style: 'fertilizer', alignment: 'left', bold: true })
    pdfContent.push({ text: '', style: 'fertilizer' })

    const expenditureInfoRow = [
      [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('research_execution.expenditure_head'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('research_execution.expense_amount'), style: 'th', alignment: 'center', bold: true }
      ]
    ]
    contractSignData.expense_details.forEach((info, index) => {
      expenditureInfoRow.push([
        { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
        { text: vm.getExpenditureHeadName(info.expenditure_head_id), alignment: 'center', style: 'td' },
        { text: vm.$n(info.expense_amount, { useGrouping: false }), alignment: 'center', style: 'td' }
      ])
    })
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['20%', '40%', '40%'],
        body: expenditureInfoRow
      }
    })
    pdfContent.push({ text: '', style: 'fertilizer' })
    pdfContent.push({ text: '', style: 'fertilizer' })
    // pdfContent.push({ text: '', style: 'fertilizer' })
    // pdfContent.push({ text: vm.$t('research_execution.bill_collection'), style: 'fertilizer', alignment: 'left', bold: true })
    pdfContent.push({ text: '', style: 'fertilizer' })

    const extraRow = [
      [
        { text: vm.$t('research_execution.expense_date'), style: 'th', alignment: 'left', bold: true },
        { text: dateFormat(contractSignData.expense_date), style: 'th', alignment: 'left' }
      ],
      [
        { text: vm.$t('research_execution.remarks'), style: 'th', alignment: 'left', bold: true },
        { text: contractSignData.remark, style: 'th', alignment: 'left' }
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['25%', '75%'],
        body: extraRow
      }
    })
    pdfContent.push({ text: '', style: 'fertilizer' })
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
