import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'
import htmlToPdfmake from 'html-to-pdfmake'

const exportPdfDetails = async (vm, data, EngBangNum) => {
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
    const pdfContent = []
    const allRowsHeadTwo = []

    const rowItemTwo = ReportHeading(vm)
    allRowsHeadTwo.push(...rowItemTwo)
    pdfContent.push({
      table: {
        widths: ['20%', '60%', '20%'],
        body: allRowsHeadTwo
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
      { text: '', style: 'empty_space' },
      { text: '', alignment: 'center' }
    )
    const allRows = [
      [
        { text: '', style: 'th', alignment: 'center', border: [false, false, false, false] },
        { text: vm.$t('portal.first_tag'), style: 'td1', alignment: 'center' }
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['88%', '12%'],
        body: allRows
      }
    })
    const allRowsHeadThree = [
      [
        { text: vm.$t('exportTrophyCircular.memo_no') + ' : ' + vm.EngBangNum(data.memorial_no), style: 'td2', alignment: 'center' },
        { text: '', style: 'td1', alignment: 'center' },
        { text: vm.$t('globalTrans.date') + ' : ' + dateFormat(data.notice_date), style: 'td2', alignment: 'center' }
      ]
    ]
    pdfContent.push({
      table: {
        widths: ['35%', '40%', '25%'],
        body: allRowsHeadThree
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
      { text: (i18n.locale === 'bn' ? data.title_bn : data.title_en), style: 'td3', alignment: 'center' }
    )
    pdfContent.push(
      { text: htmlToPdfmake(i18n.locale === 'bn' ? data.description_bn : data.description_en), style: 'td4', alignment: 'justify' }
    )
    const allRowsHeadFour = [
      [
        { },
        { },
        { text: vm.$t('portal.detail_bottom_tile'), style: 'td5', alignment: 'center' }
      ]
    ]
    pdfContent.push({
      table: {
        widths: ['20%', '45%', '35%'],
        body: allRowsHeadFour
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
    var docDefinition = {
    content: pdfContent,
    pageSize: 'A4',
    pageOrientation: 'portrait',
    defaultStyle: {
      font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
    },
    styles: {
      th: {
        fontSize: 8,
        margin: [1, 3, 1, 3],
        bold: true
      },
      td: {
        fontSize: (i18n.locale === 'bn') ? 8 : 7,
        margin: [3, 3, 3, 3]
      },
      td3: {
        fontSize: (i18n.locale === 'bn') ? 25 : 25,
        margin: [3, 3, 3, 3]
      },
      td4: {
        fontSize: (i18n.locale === 'bn') ? 15 : 15,
        margin: [3, 3, 3, 3],
        bold: false
      },
      search: {
        fontSize: (i18n.locale === 'bn') ? 10 : 8,
        margin: [3, 3, 3, 3]
      },
      fertilizer: {
        margin: [5, 0, 0, 5]
      },
      header: {
        fontSize: 12,
        margin: [0, 0, 0, 4]
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
      address: {
        fontSize: 9,
        margin: [0, -10, 0, 0]
      },
      tableSubHead: {
        margin: [0, 5, 0, 15]
      },
      img_logo: {
        margin: [20, 0, 0, 0]
      },
      img_logo_two: {
        margin: [115, 0, 0, 0]
      },
      img_logo_three: {
        margin: [0, 0, 0, 0]
      },
      reportHeading: {
        fontSize: 13,
        margin: [0, 10, 0, 0]
      },
      headerTwo: {
        fontSize: 15,
        margin: [0, 20, 0, 0]
      },
      headerThree: {
        fontSize: 9,
        margin: [0, 1, 0, 0]
      },
      giveUnderline: {
        decoration: 'underline',
        margin: [0, 10, 0, 0]
      },
      tableHeader: {
        alignment: 'center'
      },
      tableHeaderTwo: {
        fontSize: 9,
        alignment: 'center',
        margin: [0, 10, 0, 0]
      },
      tableHeaderThree: {
        alignment: 'left',
        margin: [0, 0, 0, 0]
      },
      tableHeaderFour: {
        alignment: 'left',
        margin: [0, 50, 0, 0]
      },
      tableHeaderFive: {
        alignment: 'left',
        bold: true
      },
      tableExampleGrid: {
        margin: [0, 5, 5, 0]
      },
      tableHeaderSix: {
        fontSize: 15,
        margin: [0, 8, 8, 0]
      },
      tableHeaderSeven: {
        fontSize: 10,
        margin: [0, 0, 0, 0]
      },
      tableHeaderEight: {
        fontSize: 10,
        margin: [20, 0, 0, 0]
      },
      leftalign: {
        alignment: 'left'
      },
      tablecell: {
        fontSize: 7,
        alignment: 'center'
      },
      tablecellTwo: {
        fontSize: 15,
        alignment: 'center'
      },
      marginForUse: {
        margin: [0, 20, 0, 0]
      },
      td2: {
        margin: [0, 20, 0, 0]
      },
      td5: {
        margin: [0, 100, 0, 0]
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
