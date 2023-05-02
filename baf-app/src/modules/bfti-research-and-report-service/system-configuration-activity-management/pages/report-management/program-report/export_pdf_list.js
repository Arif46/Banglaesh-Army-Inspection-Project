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
            { text: vm.$t('meeting_management.program_type_id'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.program_type_id ? (i18n.locale === 'en' ? searchHeaderData.rogram_type_en : searchHeaderData.rogram_type_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('research_execution.title_or_topic'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.title ? (i18n.locale === 'en' ? searchHeaderData.title : searchHeaderData.title_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('globalTrans.date_from'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.start_date ? dateFormat(searchHeaderData.start_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('globalTrans.date_to'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.end_date ? dateFormat(searchHeaderData.end_date) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
          ]
        ]
        pdfContent.push({
          table: {
            widths: ['24%', '1%', '24%', '24%', '1%', '24%'],
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
            { text: vm.$t('meeting_management.program_type_id'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('meeting_management.title'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('meeting_management.organized_by'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('meeting_management.venue'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('meeting_management.total_participant'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('meeting_management.program_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.remarks'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        if (reportData.length) {
          reportData.forEach((item, index) => {
            allRows.push(
              [
                { text: vm.$n(index + 1), style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.rogram_type_en : item.rogram_type_bn, style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.title : item.title_bn, style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.organized_by : item.organized_by_bn, style: 'td', alignment: 'center' },
                { text: (i18n.locale === 'en') ? item.venue : item.venue_bn, style: 'td', alignment: 'center' },
                { text: vm.$n(item.total_participant), style: 'td', alignment: 'center' },
                { text: dateFormat(item.program_date), style: 'td', alignment: 'center' },
                { text: item.remarks, style: 'td', alignment: 'center' }
              ]
            )
          })
          allRows.push(
            [
              { text: vm.$t('meeting_management.grand_total_participant'), style: 'th', alignment: 'center', colSpan: 5, bold: true },
                { },
                { },
                { },
                { },
                { text: vm.$n(vm.getTotal(reportData)), style: 'th', alignment: 'center', bold: true },
                { text: '', style: 'th', alignment: 'left', colSpan: 2, bold: true },
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
            widths: ['6%', '14%', '*', '*', '*', '*', '*', '*'],
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
