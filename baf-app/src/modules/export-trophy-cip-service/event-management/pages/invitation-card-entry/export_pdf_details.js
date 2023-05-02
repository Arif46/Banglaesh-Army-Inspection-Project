import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, data, formatted) => {
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
    const pdfContent = [
      { columns: reportHeadData.reportHeadColumn },
      { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]
    const allRow = [
      [
        {},
        { text: (i18n.locale === 'bn' ? data.title_bn : data.title_en), style: 'td3', alignment: 'center' },
        {}
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['20%', '60%', '20%'],
        body: allRow
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
    const allRowsTwo = [
      [
        {},
        { text: vm.$t('externalUser.cordially_invite_cip_to'), style: 'td1', alignment: 'center' },
        {}
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['30%', '40%', '30%'],
        body: allRowsTwo
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
    pdfContent.push(
      { text: vm.$t('globalTrans.date') + ' : ' + formatted(data.date_time), style: 'td2', alignment: 'center' }
    )
    pdfContent.push(
      { text: (i18n.locale === 'bn' ? data.description_bn : data.description_en), style: 'td3', alignment: 'center' }
    )
    pdfContent.push(
      { text: vm.$t('eventManage.venue') + ':' + (i18n.locale === 'bn' ? data.venue_name_bn : data.venue_name), style: 'venuFontSize', alignment: 'center' }
    )
    // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
    var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        td: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        td1: {
          fontSize: (i18n.locale === 'bn') ? 20 : 20,
          margin: [3, 3, 3, 3],
          bold: true
        },
        venuFontSize: {
          fontSize: (i18n.locale === 'bn') ? 14 : 14,
          margin: [3, 3, 3, 3],
          bold: true
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
