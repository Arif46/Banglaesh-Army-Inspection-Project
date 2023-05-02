import i18n from '@/i18n'
import Store from '@/store'
// import ReportHeading from '@/Utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat, time12Formate } from '@/Utils/fliter'

const exportPdfDetails = async (reportTitle, thisObject, data, vm) => {
  try {
    Store.commit('mutateCommonProperties', {
      loading: true
    })
    if (i18n.locale === 'bn') {
      pdfMake.vfs = pdfFontsBn.pdfMake.vfs
    } else {
      pdfMake.vfs = pdfFontsEn.pdfMake.vfs
    }
    // const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
    const pdfContent = [
      { text: reportTitle, style: 'header', alignment: 'center', decoration: 'underline' }
    ]

    const allRowsHead = [
        [
          { text: thisObject.$t('globalTrans.organization'), alignment: 'left', style: 'th' },
          { text: i18n.locale === 'en' ? data.org_name : data.org_name_bn, alignment: 'left', style: 'search', colSpan: '3' },
          { },
          { }
      ],
      [
        { text: thisObject.$t('publication_management.pub_type'), alignment: 'left', style: 'th' },
        { text: i18n.locale === 'en' ? data.pub_type_name : data.pub_type_name_bn, alignment: 'left', style: 'search' },
        { text: thisObject.$t('publication_management.pub_title'), alignment: 'left', style: 'th' },
        { text: i18n.locale === 'en' ? data.pub_title_name : data.pub_title_name_bn, alignment: 'left', style: 'search' }
      ],
      [
        { text: thisObject.$t('publication_management.memo_number'), alignment: 'left', style: 'th' },
        { text: data.circular_auto_id, alignment: 'left', style: 'search' },
        { text: thisObject.$t('publication_management.circular_subject'), alignment: 'left', style: 'th' },
        { text: i18n.locale === 'en' ? data.circular_subject : data.circular_subject_bn, alignment: 'left', style: 'search' }
      ],
      [
        { text: thisObject.$t('publication_management.year_bn'), alignment: 'left', style: 'th' },
        { text: thisObject.$n(data.year_bn, { useGrouping: false }), alignment: 'left', style: 'search' },
        { text: thisObject.$t('publication_management.month_bn'), alignment: 'left', style: 'th' },
        { text: thisObject.getMonthBnName(data.month_bn), alignment: 'left', style: 'search' }
      ],
      [
        { text: thisObject.$t('publication_management.publication_deadline'), alignment: 'left', style: 'th' },
        { text: dateFormat(data.deadline_date), alignment: 'left', style: 'search' },
        { text: thisObject.$t('publication_management.deadline_time'), alignment: 'left', style: 'th' },
        { text: time12Formate(data.deadline_time), alignment: 'left', style: 'search' }
      ],
      [
        { text: thisObject.$t('publication_management.content_area'), alignment: 'left', style: 'th' },
        { text: i18n.locale === 'en' ? data.content_area : data.content_area_bn, alignment: 'left', style: 'search', colSpan: '3' },
        { },
        { }
      ]
      // [
      //   { text: thisObject.$t('publication_management.circular_guideline'), alignment: 'left', style: 'th' },
      //   { text: i18n.locale === 'en' ? data.circular_guideline : data.circular_guideline_bn, alignment: 'left', style: 'search', colSpan: '3' },
      //   { },
      //   { }
      // ]
    ]

      pdfContent.push({
        table: {
          headerRows: 0,
          widths: ['*', '*', '*', '*'],
          body: allRowsHead
        }
        // layout: {
        //   hLineWidth: function (i, node) {
        //     return 0
        //   },
        //   vLineWidth: function (i, node) {
        //     return 0
        //   }
        // }
      })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'Portrait',
        styles: {
          th: {
            fontSize: (i18n === 'bn') ? 10 : 10,
            margin: [3, 3, 3, 3],
            bold: true
          },
          th2: {
            fillColor: '#dee2e6',
            fontSize: (i18n === 'bn') ? 10 : 10,
            margin: [3, 3, 3, 3],
            bold: true
          },
          td: {
            fontSize: (i18n === 'bn') ? 10 : 10,
            margin: [3, 3, 3, 3]
          },
          search: {
            fontSize: (i18n === 'bn') ? 10 : 10,
            margin: [3, 3, 3, 3]
          },
          fertilizer: {
            margin: [0, 10, 0, 7]
          },
          fertilizerSHeader: {
              fontSize: 10,
              margin: [40, 0, 0, 0]
          },
          header: {
            fontSize: 16,
            bold: 'Courier-Bold',
            margin: [0, 0, 0, 4]
          },
          header2: {
            fillColor: '#dee2e6',
            fontSize: 16,
            bold: 'Courier-Bold',
            italics: 'Courier-Oblique',
            bolditalics: 'Courier-BoldOblique',
            margin: [0, 10, 0, 10]
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
            margin: [0, 15, 0, 0]
          },
          address: {
            fontSize: 9,
            margin: [0, -10, 0, 0]
          },
          tableSubHead: {
            margin: [0, 5, 0, 15]
          }
        }
      }
      pdfMake.createPdf(docDefinition, null, null, null).download('circular')
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
