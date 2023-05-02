import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
// import AddressHelper from '@/utils/area-type-address'

function getYearFiscalYear (vm) {
  if (vm.search.award_type === 1) {
    return { text: vm.$t('globalTrans.year') + ' : ' + (vm.search.year ? vm.EngBangNum(vm.searchHeaderData.year_name.toString()) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
  }
  if (vm.search.award_type === 2) {
    return { text: vm.$t('globalTrans.fiscal_year') + ' : ' + (vm.search.fiscal_year_id ? (i18n.locale === 'en' ? vm.searchHeaderData.fiscal_year_name : vm.searchHeaderData.fiscal_year_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
  }
}
function getNewProduct (products) {
  const newProduct = []
  products.map(item => {
    const productServiceSectorObj = Store.state.ExportTrophyCipService.commonObj.exportSectorList.find(sector => sector.value === item.product_id)
    if (productServiceSectorObj !== undefined) {
      if (i18n.locale === 'bn') {
        newProduct.push(productServiceSectorObj.text_bn)
      } else {
        newProduct.push(productServiceSectorObj.text_en)
      }
    }
  })
  return newProduct.join()
}
function getNewDestination (destination) {
  const newDestination = []
  destination.map(item => {
    const countryObj = Store.state.CommonService.commonObj.countryList.find(country => country.value === parseInt(item.country_id))
    if (countryObj !== undefined) {
      if (i18n.locale === 'bn') {
        newDestination.push(countryObj.text_bn)
      } else {
        newDestination.push(countryObj.text_en)
      }
    }
  })
  return newDestination.join()
}
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
    const allRowD = []
      const firstRowHeader = [
        { text: vm.$t('exportTrophyConfig.awardType') + ' : ' + (vm.search.award_type ? (i18n.locale === 'en' ? vm.searchHeaderData.award_type_name : vm.searchHeaderData.award_type_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('globalTrans.type') + ' : ' + (vm.search.type ? (i18n.locale === 'en' ? vm.searchHeaderData.type_name : vm.searchHeaderData.type_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        getYearFiscalYear(vm),
        { text: vm.$t('exportCipReport.sector') + ' : ' + (vm.search.product_service_id ? (i18n.locale === 'en' ? vm.searchHeaderData.product_service_name : vm.searchHeaderData.product_service_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
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
          { text: vm.$t('exportCipReport.new_product'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.destination'), style: 'th', alignment: 'center', bold: true }
        ]
      ]
      vm.datas.forEach((info, index) => {
        allRows.push([
          { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info.service_sector_name_bn : info.service_sector_name, alignment: 'center', style: 'td' },
          { text: vm.search.award_type === 1 ? vm.getExterUserName(info.user_id) : (i18n.locale === 'bn') ? info.org_info.org_name_bn : info.org_info.org_name_en, alignment: 'center', style: 'td' },
          { text: vm.getAddress(info.org_address), alignment: 'center', style: 'td' },
          { text: info.export_product.length > 0 ? getNewProduct(info.export_product) : vm.$t('exportCipReport.new_product_not_found'), alignment: 'center', style: 'td' },
          { text: info.export_destination.length > 0 ? getNewDestination(info.export_destination) : vm.$t('exportCipReport.new_destination_not_found'), alignment: 'center', style: 'td' }
        ])
      })
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['10%', '10%', '20%', '20%', '20%', '20%'],
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
      vm.loading = false
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
