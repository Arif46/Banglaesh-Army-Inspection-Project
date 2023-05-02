import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

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
      const pdfContent = [
        { columns: reportHeadData.reportHeadColumn, style: 'header' },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' }
      ]
      const heading = [
        [
          { text: vm.$t('exhibitCircularManagement.fair_exhibit_dts'), style: 'tdCustom3', alignment: 'center', bold: true }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['100%'],
          body: heading
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
      const detailsData = vm.detailsData
      const rows = [
        [
          { text: vm.$t('globalTrans.fiscal_year'), style: 'tdCustom3', alignment: 'left' },
          { text: '', style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.getFiscalYearName(detailsData.fiscal_year_id), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '2%', '30%'],
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
          { text: vm.$t('exhibitCircularManagement.circular_memo'), style: 'tdCustom3', alignment: 'left' },
          { text: '', style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(detailsData.exhibit_circular.circular_memo_no), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '2%', '30%'],
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
      const row2 = [
        [
          { text: vm.$t('exhibitCircularManagement.subject'), style: 'tdCustom3', alignment: 'left' },
          { text: '', style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(i18n.locale === 'bn' ? detailsData.exhibit_circular.subject_bn : detailsData.exhibit_circular.subject_en), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '2%', '30%'],
          body: row2
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
      const row3 = [
        [
          { text: vm.$t('exhibitCircularManagement.company_name'), style: 'tdCustom3', alignment: 'left' },
          { text: '', style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(i18n.locale === 'bn' ? detailsData.fair_parti.name_bn : detailsData.fair_parti.name_en), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '2%', '30%'],
          body: row3
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
      const row4 = [
        [
          { text: vm.$t('exhibitCircularManagement.company_type'), style: 'tdCustom3', alignment: 'left' },
          { text: '', style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.getCompanyTypeName(detailsData.fair_parti.company_type), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '10%', '2%', '30%'],
          body: row4
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
      const row5 = [
        [
          { text: vm.$t('exhibitCircularManagement.fair_exhibition_info'), style: 'tdCustom3', alignment: 'center', bold: true }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['100%'],
          body: row5
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
        const allRow2 = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('exhibitCircularManagement.description_exhibit'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('exhibitCircularManagement.hs_code_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('exhibitCircularManagement.quantity'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('exhibitCircularManagement.unit_price'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('exhibitCircularManagement.total_price'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.exporter_name'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        vm.detailsData.details.forEach((item, index) => {
          allRow2.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: vm.$t(i18n.locale === 'bn' ? item.exhibit_desc_bn : item.exhibit_desc_en), alignment: 'center', style: 'td' },
            { text: vm.$n(item.hs_code, { useGrouping: false }), alignment: 'center', style: 'td' },
            { text: vm.$n(item.quantity, { useGrouping: false }), alignment: 'center', style: 'td' },
            { text: vm.$n(item.unit_price, { minimumFractionDigits: 2 }), alignment: 'center', style: 'td' },
            { text: vm.$n(item.total_price, { minimumFractionDigits: 2 }), alignment: 'center', style: 'td' },
            { text: vm.$t(i18n.locale === 'bn' ? item.exporter_name_bn : item.exporter_name_en), alignment: 'center', style: 'td' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['10%', '25%', '12%', '12%', '12%', '12%', '17%'],
            body: allRow2
          }
        })
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
            fontSize: (i18n.locale === 'bn') ? 16 : 14,
            bold: true,
            margin: [0, 0, 0, 0]
          },
          org: {
            fontSize: 11,
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
      vm.loader = false
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
