import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, search, searchHeader) => {
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
        { text: vm.$t('globalTrans.division') + ' : ' + (search.division_id ? (i18n.locale === 'en' ? searchHeader.division_name : searchHeader.division_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('globalTrans.district') + ' : ' + (search.district_id ? (i18n.locale === 'en' ? searchHeader.district_name : searchHeader.district_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
      ]
      if (search.area_type_id === 1) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.city_corporation') + ' : ' + (search.city_corporation_id ? (i18n.locale === 'en' ? searchHeader.city_corporation_name : searchHeader.city_corporation_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        )
      }
      if (search.area_type_id === 2 || search.area_type_id === 3) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.upazila') + ' : ' + (search.upazila_id ? (i18n.locale === 'en' ? searchHeader.upazila_name : searchHeader.upazila_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        )
      }
      if (search.area_type_id === 2) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.pouroshova') + ' : ' + (search.pauroshoba_id ? (i18n.locale === 'en' ? searchHeader.pauroshoba_name : searchHeader.pauroshoba_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        )
      }
      if (search.area_type_id === 3) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.union') + ' : ' + (search.union_id ? (i18n.locale === 'en' ? searchHeader.union_name : searchHeader.union_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        )
      }
      if (!search.area_type_id) {
        firstRowHeader.push(
          { text: '', alignment: 'left', style: 'th' }
        )
      }
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
    const allRowsHead1 = [
      [
        { text: vm.$t('globalTrans.date_from') + ' : ' + (search.date_from ? dateFormat(search.date_from) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('globalTrans.date_to') + ' : ' + (search.date_to ? dateFormat(search.date_to) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
        { text: vm.$t('bazarMonitoring.market_name') + ' : ' + (search.market_directory_id ? (i18n.locale === 'en' ? searchHeader.market_name_en : searchHeader.market_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
      ]
    ]
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: '*',
        body: allRowsHead1
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
        vm.datas.forEach((division) => {
          pdfContent.push({ text: vm.$t('globalTrans.division') + ' : ' + (vm.$i18n.locale === 'bn' ? division.division_name_bn : division.division_name), style: 'header2', alignment: 'left', bold: true })
          division.district_info.forEach((district) => {
            pdfContent.push({ text: vm.$t('globalTrans.district') + ' : ' + (vm.$i18n.locale === 'bn' ? district.district_name_bn : district.district_name), style: 'header3', alignment: 'left', bold: true })
            district.city_upazila_info.forEach((cityUpazila) => {
              if (cityUpazila.city_corporation_id) {
                pdfContent.push({ text: vm.$t('globalTrans.city_corporation') + ' : ' + (vm.$i18n.locale === 'bn' ? cityUpazila.city_corporation_bn : cityUpazila.city_corporation), style: 'header4', alignment: 'left', bold: true })
              }
              if (cityUpazila.upazila_id) {
                pdfContent.push({ text: vm.$t('globalTrans.upazila') + ' : ' + (vm.$i18n.locale === 'bn' ? cityUpazila.upazila_name_bn : cityUpazila.upazila_name), style: 'header4', alignment: 'left', bold: true })
              }
              const allRows = [
                [
                  { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('priceMonitoring.accused_person_org'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('priceMonitoring.complain_no'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('globalTrans.mobile'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('priceMonitoring.date_of_conviction'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('report.arbiter_information'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('report.section'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('report.fine_amount_tk'), style: 'th', alignment: 'center', bold: true },
                  { text: vm.$t('report.total_tk'), style: 'th', alignment: 'center', bold: true }
                ]
              ]
              cityUpazila.market_info.forEach((info, index) => {
                info.sections_data.forEach((info1, index1) => {
                  let officeName = ''
                  if (info.officer_name_bn) {
                    officeName = (i18n.locale === 'bn' ? info.officer_name_bn : info.officer_name) + ','
                  }
                  allRows.push([
                    { text: vm.$n(index + 1), alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: i18n.locale === 'bn' ? info.accused_person_name_bn : info.accused_person_name_en, alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: info.case_number, alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: (i18n.locale === 'bn' ? '০' : '0') + vm.$n(info.mobile_no, { useGrouping: false }), alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: dateFormat(info.date_of_conviction), alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: officeName + (i18n.locale === 'bn' ? info.designation_name_bn : info.designation_name), alignment: 'center', rowSpan: info.sections_data.length, style: 'td' },
                    { text: vm.$n(info1.section_number), alignment: 'center', style: 'td' },
                    { text: vm.$n(info1.fine_amount), alignment: 'center', style: 'td' },
                    { text: vm.$n(vm.getTotalFineAmount(info.sections_data)), alignment: 'center', rowSpan: info.sections_data.length, style: 'td' }
                  ])
                })
              })
              allRows.push([
                { text: vm.$t('report.total_fine_amount'), style: 'th', alignment: 'right', bold: true, colSpan: 8 },
                {},
                {},
                {},
                {},
                {},
                {},
                {},
                { text: vm.$n(vm.getTotalAmount(cityUpazila.market_info)), alignment: 'right', bold: true, style: 'th' }
              ])
              pdfContent.push({
                table: {
                  headerRows: 1,
                  widths: ['7%', '13%', '13%', '15%', '12%', '12%', '7%', '10%', '9%'],
                  body: allRows
                }
              })
            })
          })
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
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
              fontSize: 14,
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
