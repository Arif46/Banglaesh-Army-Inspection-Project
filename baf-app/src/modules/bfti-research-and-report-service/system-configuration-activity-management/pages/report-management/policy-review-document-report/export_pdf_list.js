import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat, mobileNumber } from '@/utils/fliter'

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
      const pdfContent = [{
            columns: reportHeadData?.reportHeadColumn
        },
        { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData?.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      const search = vm.search
      const searchHeaderData = vm.searchHeaderData
      const reportData = vm.reportData
        const allRowsHead = [
          [
            { text: vm.$t('research_execution.title_or_topic'), style: 'td', alignment: 'center' },
            { text: ':', style: 'td', alignment: 'left' },
            { text: search.policy_title ? searchHeaderData.policy_title : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('globalTrans.date_from'), style: 'td', alignment: 'center' },
            { text: ':', style: 'td', alignment: 'left' },
            { text: search.start_date ? dateFormat(searchHeaderData.start_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('globalTrans.date_to'), style: 'td', alignment: 'center' },
            { text: ':', style: 'td', alignment: 'left' },
            { text: search.end_date ? dateFormat(searchHeaderData.end_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
          ]
          // [
          //   { },
          //   { },
          //   { },
          //   { text: vm.$t('globalTrans.date_to'), style: 'td', alignment: 'right' },
          //   { text: ':', style: 'td', alignment: 'center' },
          //   { text: search.end_date ? dateFormat(searchHeaderData.end_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
          // ]
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
            { text: vm.$t('report_management.client'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.title_or_topic'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('report_management.date_request'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('policy_advocacy.focal_point_name'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('policy_advocacy.focal_point_designation'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('bfti.contact_number'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.status'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('report_management.date_status'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.remarks'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        if (reportData.length) {
          reportData.forEach((item, index) => {
            let status = ''
        if (item.status === 5) {
          status = 'globalTrans.cancel'
        } else if (item.status === 4) {
          status = 'research_execution.submitted'
        } else if (item.status === 3) {
          status = 'globalTrans.rejected'
        } else if (item.status === 2) {
          status = 'globalTrans.approved'
        } else {
          status = 'globalTrans.pending'
        }
            allRows.push(
              [
                { text: vm.$n(index + 1), style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.organization : item.organization_bn, style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.policy_title : item.policy_title_bn, style: 'td', alignment: 'center' },
                { text: dateFormat(item.submission_date), style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.name : item.name_bn, style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.designation : item.designation_bn, style: 'td', alignment: 'center' },
                { text: mobileNumber(item.contact_no), style: 'td', alignment: 'center' },
                { text: vm.$t(status), style: 'td', alignment: 'center' },
                { text: dateFormat(item.updated_at), style: 'td', alignment: 'center' },
                { text: item.remarks, style: 'td', alignment: 'center' }
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
            widths: ['5%', '14%', '*', '7%', '*', '*', '7%', '7%', '6%', '10%'],
            body: allRows
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
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
