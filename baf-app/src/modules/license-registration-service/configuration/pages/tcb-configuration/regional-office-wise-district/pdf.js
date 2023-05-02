import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (reportTitle, data, vm, districtName) => {
  try {
        Store.commit('mutateCommonProperties', {
          loading: true
        })
        // if (i18n.locale === 'bn') {
        //   pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        // } else {
        //   pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        // }
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
          { text: vm.$i18n.locale === 'en' ? 'Regional Office Wise District List' : 'আঞ্চলিক অফিস ভিত্তিক জেলা তালিকা', alignment: 'center', style: 'th2' }
        )
        const allRows = [
            [
              { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center' },
              { text: vm.$t('allocation_management.regional_office'), style: 'th', alignment: 'center' },
              { text: vm.$t('globalTrans.division'), style: 'th', alignment: 'center' },
              { text: vm.$t('globalTrans.district'), style: 'th', alignment: 'center' }
            ]
        ]
        if (data.length) {
          data.map((item, index) => {
              let district = ''
                item.district_details.map((item2, index1) => {
                  if (index1 === 0) {
                    district = districtName(item2.district_id)
                  } else {
                    district = district + ' , ' + districtName(item2.district_id)
                  }
                })
              allRows.push([
                { text: vm.$n(index + 1), style: 'td', alignment: 'center' },
                { text: vm.$i18n.locale === 'bn' ? vm.$t(item.region_name_bn) : vm.$t(item.region_name), style: 'td', alignment: 'center' },
                { text: vm.$i18n.locale === 'bn' ? vm.$t(item.division_name_bn) : vm.$t(item.division_name), style: 'td', alignment: 'center' },
                { text: district, style: 'td', alignment: 'center' }
              ])
          })
        } else {
          allRows.push(
            [
              { text: vm.$t('globalTrans.noDataFound'), colSpan: 4, style: 'td', alignment: 'center' }
            ]
          )
        }
        pdfContent.push({
            table: {
            headerRows: 1,
            widths: ['10%', '25%', '25%', '40%'],
            body: allRows
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
          th2: {
            margin: [0, 0, 3, 0]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
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
            margin: [25, 0, 0, 0]
          },
          reportHeading: {
            fontSize: 13,
            margin: [0, 10, 0, 0]
          },
          headerTwo: {
            fontSize: 12,
            margin: [0, -10, 0, 0]
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
