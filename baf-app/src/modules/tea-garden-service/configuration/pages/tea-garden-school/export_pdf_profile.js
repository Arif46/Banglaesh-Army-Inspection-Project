import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
 import { mobileNumber } from '@/utils/fliter'

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
        const formData = vm.formData
        const allRows = [
          [
            { text: vm.$t('teaGardenConfig.school_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.school_name_en : formData.school_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        ]
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getTeaGardenName(formData.garden_id), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.head_master_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.h_master_name_en : formData.h_master_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.head_master_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.h_master_name_en : formData.h_master_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.mobile_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: mobileNumber(formData.h_master_mobile), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.email'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: formData.h_master_email, style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.establishment_year'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(formData.estabs_year), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.school_status'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getSchoolStatusName(formData.school_status), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.school_category'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getSchoolCategoryName(formData.school_category), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.school_type'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getSchoolTypeNameArrayData(formData.school_type), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.school_location'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.getSchoolLocationName(formData.school_location), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.is_office_room'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.is_office_room === 1 ? 'Yes' : 'No' : formData.is_office_room === 1 ? 'হ্যাঁ' : 'না', style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.num_of_teacher'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(formData.num_of_teacher), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.num_of_latrine'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: vm.EngBangNum(formData.num_of_latrine), style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.have_playground'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.have_playground === 1 ? 'Yes' : 'No' : formData.have_playground === 1 ? 'হ্যাঁ' : 'না', style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.have_flag_pillar'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.have_flag_pillar === 1 ? 'Yes' : 'No' : formData.have_flag_pillar === 1 ? 'হ্যাঁ' : 'না', style: 'td', alignment: 'left', bold: true }
          ]
        )
        allRows.push(
          [
            { text: vm.$t('teaGardenConfig.description'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? formData.description_en : formData.description_bn, style: 'td', alignment: 'left', bold: true }
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
