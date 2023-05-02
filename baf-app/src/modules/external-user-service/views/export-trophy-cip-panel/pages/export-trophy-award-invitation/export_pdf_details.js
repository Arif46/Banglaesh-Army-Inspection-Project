import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, data, venueName, formatted) => {
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
    const allRowsthree = [
      [
        {},
        { text: vm.$t('globalTrans.date') + ' : ' + formatted(data.date_time), style: 'td2', alignment: 'center' },
        {}
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['20%', '50%', '20%'],
        body: allRowsthree
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
    const allRowsFour = [
      [
        {},
        { text: (i18n.locale === 'bn' ? data.description_bn : data.description_en), style: 'td3', alignment: 'center' },
        {}
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['20%', '50%', '20%'],
        body: allRowsFour
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
    const allRowsFive = [
      [
        {},
        { text: vm.$t('eventManage.venue') + ':' + venueName(data.venue_id), style: 'td1', alignment: 'center' },
        {}
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['20%', '50%', '20%'],
        body: allRowsFive
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
            fontSize: 11,
            margin: [0, 10, 0, 0]
          },
          header3: {
            fontSize: 10,
            margin: [0, 6, 0, 0]
          },
          header4: {
            fontSize: 9,
            margin: [0, 6, 0, 9]
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
          tableSubHead: {
            margin: [0, 5, 0, 11]
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
