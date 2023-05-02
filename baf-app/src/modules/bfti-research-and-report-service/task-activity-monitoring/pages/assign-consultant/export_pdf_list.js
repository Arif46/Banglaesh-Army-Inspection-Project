import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
// import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, listData, vm) => {
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
        pdfContent.push({ text: '', style: 'fertilizer' })
        const allRows = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('configuration.document_type'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.organization'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('bfti.topic'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.project_duration'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.status'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        listData.forEach((item, index) => {
          let assign = ''
        if (item.assign === 1) {
          assign = 'task_activity_monitoring.not_assign'
        } else {
          assign = 'task_activity_monitoring.assign'
        }
          allRows.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: (i18n.locale === 'en') ? item.document_type : item.document_type_bn, style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'en') ? item.organization : item.organization_bn, style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'en') ? item.topic : item.topic_bn, style: 'td', alignment: 'center' },
            { text: vm.getDuration(item.duration_start_date, item.duration_end_date), style: 'td', alignment: 'center' },
            { text: vm.$t(assign), style: 'td', alignment: 'center' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['6%', '14%', '*', '*', '*', '*'],
            body: allRows
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
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
