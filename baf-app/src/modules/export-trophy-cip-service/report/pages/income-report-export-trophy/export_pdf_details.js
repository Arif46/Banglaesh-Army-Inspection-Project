import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import AddressHelper from '@/utils/area-type-address'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, newDatas, search, searchHeader) => {
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
    const allRowD = []
      const firstRowHeader = [
        { text: vm.$t('globalTrans.fiscalYear') + ' : ' + (search.fiscal_year_id ? (i18n.locale === 'en' ? searchHeader.fiscal_year_name : searchHeader.fiscal_year_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('globalTrans.type') + ' : ' + (search.sector_type ? (i18n.locale === 'en' ? searchHeader.sector_type_name : searchHeader.sector_type_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('exportCipReport.sector') + ' : ' + (search.product_id ? (i18n.locale === 'en' ? searchHeader.product_service_sector_name : searchHeader.product_service_sector_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
      ]
      allRowD.push(firstRowHeader)
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: '*',
          body: allRowD
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
      const allRows = [
        [
          { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.sector'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.owner_name_address'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.org_name_address'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.income_usd'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.income_growth_from_last'), style: 'th', alignment: 'center', bold: true }
        ]
      ]
      newDatas.forEach((info, index) => {
        allRows.push([
          { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info.product_service_sector_name_bn : info.product_service_sector_name, alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info.owner_name_bn : info.owner_name_en + ' , ' + AddressHelper.getPresentAddress(info), alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info.org_name_bn + ' , ' + AddressHelper.getCommonAddress(info) : info.org_name_en + ' , ' + AddressHelper.getCommonAddress(info), alignment: 'center', style: 'td' },
          { text: vm.$n(info.export_value_ssd, { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: vm.$n(info.income_growth, { useGrouping: false }), alignment: 'center', style: 'td' }
        ])
      })
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['10%', '15%', '20%', '20%', '20%', '15%'],
          body: allRows
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
