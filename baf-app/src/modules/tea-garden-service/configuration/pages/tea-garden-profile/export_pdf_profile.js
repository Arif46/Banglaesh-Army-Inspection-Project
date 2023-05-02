import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
 import { dateFormat, mobileNumber } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, generalTitle, landLeaseTitle, humanInfoTitle) => {
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
        const detailsData = vm.formData
        // general info
        const allRows = [
          [
            { text: generalTitle, style: 'th', alignment: 'left', bold: true },
            {},
            {}
          ]
        ]
         allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_id_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.garden_id_no), style: 'td', alignment: 'left', bold: true }
          ]
         )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.owner_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.owner_name_en : detailsData.owner_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_authority_email'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.email : detailsData.email, style: 'td', alignment: 'left', bold: false }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_authority_mobile'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: mobileNumber(detailsData.mobile), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.tea_garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.tea_garden_name_en : detailsData.tea_garden_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.company_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getTeaCompanyName(detailsData.tea_company_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.company_address'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getTeaCompanyAddress(detailsData.tea_company_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.division'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getDivisionName(detailsData.division_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.district'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getDistrictName(detailsData.district_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.registration_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: detailsData.registration_no_en ? detailsData.registration_no_en : '', style: 'td', alignment: 'left', bold: false }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_class'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.garden_class_en : detailsData.garden_class_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_address'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.garden_address_en : detailsData.garden_address_, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_history'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.garden_history_en : detailsData.garden_history_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        // land lease info
        allRows.push(
          [
            { text: landLeaseTitle, style: 'th', alignment: 'left', bold: true },
            {},
            {}
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.total_land'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.land_lease_info.total_land), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.lease_start_date'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: dateFormat(detailsData.land_lease_info.lease_start_date), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.lease_end_date'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: dateFormat(detailsData.land_lease_info.lease_end_date), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.lease_duration'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.land_lease_info.lease_duration), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.reg_lease_deed_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.land_lease_info.reg_lease_deed_no : detailsData.land_lease_info.reg_lease_deed_no, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.lease_deed_date'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: dateFormat(detailsData.land_lease_info.lease_deed_date), style: 'td', alignment: 'left', bold: true }
          ]
        )
        // human resource
        allRows.push(
          [
            { text: humanInfoTitle, style: 'th', alignment: 'left', bold: true },
            {},
            {}
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.register') + ' ' + vm.$t('teaGardenConfig.male'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.register_labor_male), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.register') + ' ' + vm.$t('teaGardenConfig.female'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.register_labor_female), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.unregister') + ' ' + vm.$t('teaGardenConfig.male'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.unregister_labor_male), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.unregister') + ' ' + vm.$t('teaGardenConfig.female'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.unregister_labor_female), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.dependent') + ' ' + vm.$t('teaGardenConfig.male'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.dependent_labor_male), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.dependent') + ' ' + vm.$t('teaGardenConfig.female'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.$n(detailsData.human_resource_info.dependent_labor_female), style: 'td', alignment: 'left', bold: true }
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
