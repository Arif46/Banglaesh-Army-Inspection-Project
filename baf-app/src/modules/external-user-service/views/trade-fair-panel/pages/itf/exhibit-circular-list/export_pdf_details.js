import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
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
        pdfContent.push({ text: '', style: 'fertilizer' })
        const currentLocale = vm.currentLocale
        // const detailsData = vm.detailsData
        const rows = [
          [
            { text: vm.$t('externalTradeFair.circular_memo_no') + ' : ' + vm.detailsData.circular_memo_no, style: 'tdCustom3', alignment: 'left' },
            { text: vm.$t('globalTrans.date') + ' : ' + dateFormat(vm.detailsData.updated_at), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['80%', '20%'],
            body: rows
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
        const row1 = [
          [
            { text: vm.$t('externalTradeFair.subject') + ' : ', style: 'tdCustom3', alignment: 'left' },
            { text: vm.$t('externalTradeFair.next') + ' ' + vm.date + ' ' + vm.$t('externalTradeFair.in_time') + ' ' + (currentLocale === 'en' ? vm.country_en : vm.country_bn) + ', ' + (currentLocale === 'en' ? vm.detailsData.parti_circular.calendar_info.city : vm.detailsData.parti_circular.calendar_info.city_bn) + ' ' + vm.$t('externalTradeFair.to_be_held') + ' ' + (currentLocale === 'en' ? vm.detailsData.parti_circular.calendar_info.fair_name : vm.detailsData.parti_circular.calendar_info.fair_name_bn) + ' ' + vm.$t('portal.exhi_txt_6'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: row1
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
        pdfContent.push({ text: vm.$t('externalTradeFair.next') + ' ' + vm.date + ' ' + vm.$t('externalTradeFair.in_time') + ' ' + (currentLocale === 'en' ? vm.country_en : vm.country_bn) + ', ' + (currentLocale === 'en' ? vm.detailsData.parti_circular.calendar_info.city : vm.detailsData.parti_circular.calendar_info.city_bn) + ' ' + vm.$t('externalTradeFair.to_be_held') + ' ' + (currentLocale === 'en' ? vm.detailsData.parti_circular.calendar_info.fair_name : vm.detailsData.parti_circular.calendar_info.fair_name_bn) + ' ' + vm.$t('portal.exhi_txt_4') + ' ' + vm.deadline + ' ' + vm.$t('portal.exhi_txt_5'), style: 'tdCustom3', alignment: 'left' })

        pdfContent.push({ text: '', style: 'fertilizer' })

        const rowA = [
          [
            { text: vm.$t('portal.a'), style: 'tdCustom3', alignment: 'center' },
            { text: vm.$t('portal.a_text'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: rowA
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
        const rowB = [
          [
            { text: vm.$t('portal.b'), style: 'tdCustom3', alignment: 'center' },
            { text: vm.$t('portal.b_text'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: rowB
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
        const rowC = [
          [
            { text: vm.$t('portal.c'), style: 'tdCustom3', alignment: 'center' },
            { text: vm.$t('portal.c_text'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: rowC
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
            { text: vm.$t('externalTradeFair.description_exhibition'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.hs_code_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.quantity'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.unit_price_us'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.total_value_us'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.exporter_name'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '15%', '15%', '15%', '15%', '17%', '15%'],
            body: allRows
          }
        })

        const rowD = [
          [
            { text: vm.$t('portal.d'), style: 'tdCustom3', alignment: 'center' },
            { text: vm.$t('portal.d_text'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: rowD
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
        const rowE = [
          [
            { text: vm.$t('portal.e'), style: 'tdCustom3', alignment: 'center' },
            { text: vm.$t('portal.e_text'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['8%', '92%'],
            body: rowE
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
        pdfContent.push({ text: vm.$t('portal.exhi_text_2'), style: 'tdCustom3', alignment: 'left' })

        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
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
          tdCustom3: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [0, 9, 0, 0]
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
