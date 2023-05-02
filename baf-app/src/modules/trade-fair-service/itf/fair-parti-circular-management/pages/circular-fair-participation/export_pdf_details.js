import i18n from '@/i18n'
import Store from '@/store'
// import ReportHeading from '@/utils/report-head'
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
      // const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
      // const pdfContent = [{
      //       columns: reportHeadData.reportHeadColumn
      //   },
      //   { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
      //   { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
      //   { text: reportHeadData.address, style: 'address', alignment: 'center' },
      //   { text: reportTitle, style: 'hh', alignment: 'center' }
      // ]
      const pdfContent = []
        pdfContent.push({ text: '', style: 'fertilizer' })
        const currentLocale = vm.currentLocale
        const detailsData = vm.detailsData
        const rows = [
          [
            { text: vm.$t('externalTradeFair.circular_memo_no') + ' : ' + detailsData.circular_memo_no, style: 'tdCustom3', alignment: 'left' },
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
            { text: vm.$t('externalTradeFair.next') + ' ' + vm.date + ' ' + vm.$t('externalTradeFair.in_time') + ' ' + (currentLocale === 'en' ? vm.country_en : vm.country_bn) + ', ' + (currentLocale === 'en' ? vm.detailsData.calendar_info.city : vm.detailsData.calendar_info.city_bn) + ' ' + vm.$t('externalTradeFair.to_be_held') + ' ' + (currentLocale === 'en' ? vm.detailsData.calendar_info.fair_name : vm.detailsData.calendar_info.fair_name_bn) + ' ' + vm.$t('externalTradeFair.c_lan_part_1'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['5%', '95%'],
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
        pdfContent.push({ text: vm.$t('externalTradeFair.next') + ' ' + vm.date + ' ' + vm.$t('externalTradeFair.in_time') + ' ' + (currentLocale === 'en' ? vm.country_en : vm.country_bn) + ', ' + (currentLocale === 'en' ? vm.detailsData.calendar_info.city : vm.detailsData.calendar_info.city_bn) + ' ' + vm.$t('externalTradeFair.to_be_held') + ' ' + (currentLocale === 'en' ? vm.detailsData.calendar_info.fair_name : vm.detailsData.calendar_info.fair_name_bn) + ' ' + vm.$t('externalTradeFair.c_lan_part_2') + ' ' + vm.$n(vm.stall_info.length) + vm.$t('externalTradeFair.c_lan_part_23'), style: 'tdCustom3', alignment: 'left' })

        pdfContent.push({ text: '', style: 'fertilizer' })
        const allRows = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.stall_cat_name'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.stall_size'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.stall_type'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.booth_rent'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.corner_booth_rent'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        vm.stall_info.forEach((item, index) => {
          item.details.forEach((info, indx) => {
            allRows.push([
              { text: vm.$n(index + 1), rowSpan: item.details.length, alignment: 'center', style: 'td' },
              { text: vm.getStallCategoryName(item.stall_cat_id), rowSpan: item.details.length, alignment: 'center', style: 'td' },
              { text: (vm.$n(info.stall_size)) + ' ' + vm.getMeasurementUnitList(info.measurement_id), alignment: 'center', style: 'td' },
              { text: vm.getStallType(info.stall_type), alignment: 'center', style: 'td' },
              { text: vm.$n(info.booth_rent, { minimumFractionDigits: 2 }), alignment: 'center', style: 'td' },
              { text: i18n.locale === 'bn' ? info.description_bn : info.description_en, alignment: 'center', style: 'td' }
            ])
          })
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['10%', '22%', '15%', '15%', '12%', '26%'],
            body: allRows
          }
        })
        pdfContent.push({ text: vm.$t('externalTradeFair.c_lan_part_3'), style: 'tdCustom3', alignment: 'left' })
        pdfContent.push({ text: '', style: 'fertilizer' })
        pdfContent.push({ text: vm.$t('externalTradeFair.sector_name') + ' : ' + vm.getFairSector(vm.detailsData.calendar_info.fair_sector_id), style: 'th' })
        const allRow1 = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.subsidy_category'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.subsidy_range_data'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.subsidy_p'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        vm.detailsData.subsidy_info.details.filter(el => parseInt(el.fair_sector_id) === parseInt(vm.detailsData.calendar_info.fair_sector_id)).forEach((info, index) => {
          allRow1.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: vm.getSubsidyCategory(info.subsidy_cat_id), alignment: 'center', style: 'td' },
            { text: i18n.locale === 'bn' ? info.range_bn : info.range_en, alignment: 'center', style: 'td' },
            { text: vm.$n(info.subsidy) + ' (%)', alignment: 'center', style: 'td' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['15%', '30%', '30%', '25%'],
            body: allRow1
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        pdfContent.push({ text: vm.$t('externalTradeFair.sector_name') + ' : ' + vm.$t('globalTrans.others'), style: 'th' })
        const allRow2 = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tradeFairConfig.subsidy_category'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.subsidy_range_data'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('externalTradeFair.subsidy_p'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        vm.detailsData.subsidy_info.details.filter(el => parseInt(el.fair_sector_id) !== parseInt(vm.detailsData.calendar_info.fair_sector_id)).forEach((info, index) => {
          allRow2.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: vm.getSubsidyCategory(info.subsidy_cat_id), alignment: 'center', style: 'td' },
            { text: i18n.locale === 'bn' ? info.range_bn : info.range_en, alignment: 'center', style: 'td' },
            { text: vm.$n(info.subsidy) + ' (%)', alignment: 'center', style: 'td' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['15%', '30%', '30%', '25%'],
            body: allRow2
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        pdfContent.push({ text: vm.$t('externalTradeFair.c_lan_part_4') + ' ' + vm.deadline + ' ' + vm.$t('externalTradeFair.c_lan_part_5'), style: 'tdCustom3', alignment: 'left' })
        pdfContent.push({ text: vm.$t('externalTradeFair.c_lan_part_6'), style: 'tdCustom3', alignment: 'left' })
        // const sigRows =
        // [
        //   [
        //     { text: '', style: 'td', alignment: 'left' },
        //     {
        //       text: '\n\n\n\n' + vm.$t('globalTrans.signature') + '\n\n' + '..........................................\n\n' +
        //         vm.$t('priceMonitoring.seal_of_fine_collecting_disposal_officer') + '\n\n\n\n',
        //       style: 'td',
        //       alignment: 'center',
        //       bold: true,
        //       colSpan: 2
        //     }
        //   ]
        // ]
        // pdfContent.push({
        //   table: {
        //     headerRows: 1,
        //     widths: ['40%', '1%', '59%'],
        //     body: sigRows
        //   },
        //   layout: {
        //     hLineWidth: function (i, node) {
        //       return 0
        //     },
        //     vLineWidth: function (i, node) {
        //       return 0
        //     }
        //   }
        // })
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
