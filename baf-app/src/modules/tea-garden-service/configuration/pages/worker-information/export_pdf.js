import i18n from '@/i18n'
import Store from '@/store'
// import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (reportTitle, vm) => {
    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      if (i18n.locale === 'bn') {
        pdfMake.vfs = pdfFontsBn.pdfMake.vfs
      } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        }
      const pdfContent = [
        { text: reportTitle, style: 'header2', alignment: 'center' }
        ]
        pdfContent.push({ text: '', style: 'fertilizer' })
        const currentLocale = vm.currentLocale
        const detailsData = vm.detailsData
        // general info
         const allRows = [
          [
            { text: vm.$t('teaGardenConfig.pf_id'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(detailsData.pf_id), style: 'td', alignment: 'left', bold: true }
          ]
        ]
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getTeaGardenName(detailsData.garden_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.worker_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.worker_name_en : detailsData.worker_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.father_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.father_name_en : detailsData.father_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.designation'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getDesignation(detailsData.designation_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.mobile'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(detailsData.mobile), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.nid'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(detailsData.nid), style: 'td', alignment: 'left', bold: true }
          ]
        )
       allRows.push(
          [
            { text: vm.$t('teaGardenConfig.address'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.address_en : detailsData.address_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.worker_type'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.worker_type_en : detailsData.worker_type_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.gender'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getGenderName(detailsData.gender), style: 'td', alignment: 'left', bold: true }
          ]
        )
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['50%', '1%', '49%'],
            body: allRows
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
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 14 : 13,
            margin: [3, 3, 15, 3]
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
