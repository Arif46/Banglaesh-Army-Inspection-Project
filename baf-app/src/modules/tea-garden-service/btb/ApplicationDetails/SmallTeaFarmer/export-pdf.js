import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head-tea-garden'
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
      const pdfContent = [
        { columns: reportHeadData.reportHeadColumn },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center', decoration: 'underline' }
    ]
        const currentLocale = vm.currentLocale
        const application = vm.application
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({
          columns: [
            {
              columns: [
                {
                  text: vm.$t('teaGardenService.application_id') + ' : ', style: 'td', bold: true, width: 'auto'
                },
                {
                  text: application.application.app_id, style: 'td', bold: false, width: 'auto'
                }
              ]
            },
            {
              alignment: 'right',
              columns: [
                {
                  text: vm.$t('teaGardenService.application_date') + ' : ', style: 'td', bold: true, alignment: 'right', width: 200
                },
                {
                  text: dateFormat(application.application.issue_date), style: 'td', bold: false, alignment: 'right', width: 55
                }
              ]
            }
          ]
        })
        // 1
        const allRows = [
          [
            { text: vm.$t('teaGardenPanel.1') + '  ' + vm.$t('teaGardenPanel.garden_name'), style: 'td', alignment: 'left', bold: true },
            {},
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_name_en : application.garden_name_bn, style: 'td', alignment: 'left' }
          ]
        ]
        // 2
        allRows.push([
            { text: vm.$t('teaGardenPanel.2') + '  ' + vm.$t('teaGardenPanel.location'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenConfig.division'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDivisionName(application.division_id), style: 'td', alignment: 'left' }
        ])
        allRows.push([
            {},
            { text: vm.$t('teaGardenConfig.district'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDistrictName(application.district_id), style: 'td', alignment: 'left' }
        ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenConfig.upazila'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getUpzillaName(application.upazila_id), style: 'td', alignment: 'left' }
      ])
        allRows.push([
            {},
            { text: vm.$t('teaGardenPanel.distance_from_upzilla'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.distance_from_upzilla), style: 'td', alignment: 'left' }
        ])
        // owner info
      // 3
        allRows.push([
          { text: vm.$t('teaGardenPanel.3') + '  ' + vm.$t('teaGardenPanel.owner_contact_address_label'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('teaGardenService.village'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? application.owner_info.village_en : application.owner_info.village_bn, style: 'td', alignment: 'left' }
       ])
       allRows.push([
          {},
          { text: vm.$t('teaGardenService.post_office'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? application.owner_info.post_office_en : application.owner_info.post_office_bn, style: 'td', alignment: 'left' }
        ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenConfig.upazila'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getUpzillaName(application.owner_info.upazila_id), style: 'td', alignment: 'left' }
      ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenConfig.division'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getDivisionName(application.owner_info.division_id), style: 'td', alignment: 'left' }
      ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenConfig.district'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getDistrictName(application.owner_info.district_id), style: 'td', alignment: 'left' }
      ])
      allRows.push([
        {},
        { text: vm.$t('teaGardenPanel.owner_name'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? application.owner_info.owner_name_en : application.owner_info.owner_name_bn, style: 'td', alignment: 'left' }
     ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenService.owner_father_name'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? application.owner_info.father_name_en : application.owner_info.father_name_bn, style: 'td', alignment: 'left' }
       ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenService.owner_nid'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: application.owner_info.owner_nid ? vm.EngBangNum(application.owner_info.owner_nid) : '', style: 'td', alignment: 'left' }
       ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenService.owner_email'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: application.owner_info.owner_email, style: 'td', alignment: 'left' }
       ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenService.owner_mobile'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: application.owner_info.owner_mobile ? vm.EngBangNum(application.owner_info.owner_mobile) : '', style: 'td', alignment: 'left' }
       ])
       // land info
      // 4
       allRows.push([
        { text: vm.$t('teaGardenPanel.4') + '  ' + vm.$t('teaGardenPanel.total_land_quantity'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: vm.$n(application.total_land_quantity), style: 'td', alignment: 'left' }
     ])
     // 5
       allRows.push([
        { text: vm.$t('teaGardenPanel.5') + '  ' + vm.$t('teaGardenPanel.total_cultivation_land_quantity'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: vm.$n(application.total_cultivation_land_quantity), style: 'td', alignment: 'left' }
     ])
        allRows.push([
          {},
          { text: vm.$t('teaGardenConfig.upazila'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getUpzillaName(application.upazila_id), style: 'td', alignment: 'left' }
      ])
       allRows.push([
        {},
        { text: vm.$t('teaGardenService.mouja'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? application.mouja_en : application.mouja_bn, style: 'td', alignment: 'left' }
     ])
       allRows.push([
        {},
        { text: vm.$t('teaGardenService.khotian'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: application.khotian ? vm.EngBangNum(application.khotian) : '', style: 'td', alignment: 'left' }
     ])
       allRows.push([
        {},
        { text: vm.$t('teaGardenService.dag_no'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: application.dag_no ? vm.EngBangNum(application.dag_no) : '', style: 'td', alignment: 'left' }
     ])
    //  6
      allRows.push([
        { text: vm.$t('teaGardenPanel.6') + '  ' + vm.$t('teaGardenPanel.land_ownership'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? application.owner_info.land_ownership === 1 ? 'Yes' : 'No' : application.owner_info.land_ownership === 1 ? 'হ্যাঁ' : 'না', style: 'td', alignment: 'left' }
     ])
      allRows.push([
          {},
          { text: vm.$t('teaGardenPanel.applicant_name'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? application.owner_info.owner_name_en : application.owner_info.owner_name_bn, style: 'td', alignment: 'left' }
       ])
       allRows.push([
        {},
        { text: vm.$t('teaGardenPanel.address'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? application.owner_info.village_en : application.owner_info.village_bn, style: 'td', alignment: 'left' }
     ])
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['45%', '16%', '1%', '40%'],
            body: allRows
          },
          layout: 'noBorders'
        })
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: currentLocale === 'en' ? '-----------------------------------' : '-----------------------', style: 'signatureBorder', alignment: 'right' })
        pdfContent.push({ text: vm.$t('teaGardenPanel.applicant_signature'), style: 'signatureBorder', alignment: 'right' })
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
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            margin: [3, 3, 3, 3]
          },
          unboldTd: {
            fontSize: (i18n.locale === 'bn') ? 11 : 11,
            margin: [3, 3, 3, 3]
          },
          customTdGarden: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 40, 3, 3]
          },
          customTdOwner: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 80, 3, 3]
          },
          customTdLand: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 50, 3, 3]
          },
          search: {
            fontSize: (i18n.locale === 'bn') ? 10 : 11,
            margin: [3, 3, 3, 3]
          },
          normalText: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            bold: false
          },
          header: {
              fontSize: 16,
              bold: true,
              margin: [0, 0, 0, 0]
          },
          org: {
              fontSize: 13,
              bold: true,
              margin: [0, -25, 10, 0]
          },
          address: {
              fontSize: 11,
              margin: [0, 0, 0, 5]
          },
          hh: {
              fontSize: 13,
              bold: true,
              margin: [5, 0, 25, 5]
          },
          app_id: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 9 : 9
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
          },
          signatureBorder: {
            margin: [0, 0, 0, 0],
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            bold: false
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
