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
      pdfMake.fonts = {
        Kalpurush: {
          normal: 'Kalpurush.ttf',
          bold: 'Kalpurush.ttf',
          italics: 'Kalpurush.ttf',
          bolditalics: 'Kalpurush.ttf'
        }
      }
    } else {
        pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        pdfMake.fonts = {
          Roboto: {
            normal: 'Roboto-Regular.ttf',
            bold: 'Roboto-Medium.ttf',
            italics: 'Roboto-Italic.ttf',
            bolditalics: 'Roboto-MediumItalic.ttf'
          }
        }
    }
    const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
    const pdfContent = [
      {
        columns: reportHeadData?.reportHeadColumn
      },
      { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData?.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]
    const search = vm.search
    const reportData = vm.reportData
    const allRowsHead = [
      [
        { text: vm.$t('bfti.doc_type'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.document_type_id ? vm.getColumnName(vm.$store.state.BftiResearchAndReportService.commonObj.documentTypeList, 'value', search.document_type_id) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
        { text: vm.$t('research_execution.title_or_topic'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.title_id ? vm.getColumnName(vm.titleListData, 'value', search.title_id) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
        { text: vm.$t('globalTrans.start_date'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.start_date ? dateFormat(search.start_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
      ],
      [
        { text: vm.$t('globalTrans.end_date'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.end_date ? dateFormat(search.end_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
        { text: vm.$t('globalTrans.status'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.status ? vm.getColumnName(vm.statusList, 'value', search.status) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
        { text: vm.$t('globalTrans.contract_status'), style: 'td', alignment: 'right' },
        { text: ':', style: 'td', alignment: 'center' },
        { text: search.contract_status ? vm.getColumnName(vm.yesNo, 'value', search.contract_status) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
      ]
    ]
    pdfContent.push({
      table: {
        widths: ['14%', '1%', '22%', '10%', '1%', '18%', '10%', '1%', '18%'],
        // widths: '*',
        body: allRowsHead
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
    const allRows = [
      [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.title'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('research_plan_management.organization_ministry_division'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.contact_person_name'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.contact_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.contract_status'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('bfti.budget'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.status'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.date_of_status'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.remarks'), style: 'th', alignment: 'center', bold: true }
      ]
    ]
    if (reportData.length) {
      reportData.forEach((item, index) => {
        let status = ''
        if (item.document_approve_status === 5) {
          status = 'globalTrans.cancel'
        } else if (item.document_approve_status === 4) {
          status = 'research_execution.non_awarded'
        } else if (item.document_approve_status === 3) {
          status = 'research_execution.awarded'
        } else if (item.document_approve_status === 2) {
          status = 'globalTrans.submitted'
        } else {
          status = 'globalTrans.pending'
        }
        let statusDate = ''
        if (item.document_approve_status === 5) {
          statusDate = dateFormat(item.cancel_date)
        } else if (item.document_approve_status === 4) {
          statusDate = dateFormat(item.non_awarded_date)
        } else if (item.document_approve_status === 3) {
          statusDate = dateFormat(item.awarded_date)
        } else if (item.document_approve_status === 2) {
          statusDate = dateFormat(item.submit_date)
        }
        let statusComment = ''
        if (item.document_approve_status === 5) {
          statusComment = item.cancel_comment
        } else if (item.document_approve_status === 4) {
          statusComment = item.non_awarded_comment
        } else if (item.document_approve_status === 3) {
          statusComment = item.awarded_comment
        } else if (item.document_approve_status === 2) {
          statusComment = item.submit_comment
        }
        let contractStatus = 'No'
        if (item.contact_status === 2) {
          contractStatus = 'Yes'
        }
        let zero = '0'
        if (i18n.locale === 'bn') {
          zero = '০'
        }
        let contactNo = ''
        if (item.contact_no) {
          contactNo = zero + vm.$n(item.contact_no, { useGrouping: false })
        }
        let contactAmount = ''
        if (item.contact_status === 2) {
          contactAmount = vm.$n(item.contract_amount, { useGrouping: false })
        }
        allRows.push(
          [
            { text: vm.$n(index + 1), style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'en') ? item.rfp_title_en : item.rfp_title_bn, style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'en') ? item.organization_ministry_division : item.organization_ministry_division_bn, style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'en') ? item.name : item.name_bn, style: 'td', alignment: 'center' },
            { text: contactNo, style: 'td', alignment: 'center' },
            { text: contractStatus, style: 'td', alignment: 'center' },
            { text: contactAmount, style: 'td', alignment: 'center' },
            { text: vm.$t(status), style: 'td', alignment: 'center' },
            { text: statusDate, style: 'td', alignment: 'center' },
            { text: statusComment, style: 'td', alignment: 'center' }
          ]
        )
      })
    } else {
      allRows.push(
        [
          { text: vm.$t('globalTrans.noDataFound'), style: 'td', alignment: 'center', colSpan: 10 },
          { },
          { },
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
        widths: ['6%', '9%', '10%', '12%', '10%', '8%', '9%', '7%', '8%', '6%'],
        body: allRows
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
          fontSize: 14,
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
