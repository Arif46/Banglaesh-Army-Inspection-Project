import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat, mobileNumber } from '@/utils/fliter'

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
        const detailsData = vm.detailsData
        const allRows = [
          [
            { text: vm.$t('globalTrans.district'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? detailsData.district_name_en : detailsData.district_name_bn, style: 'td', alignment: 'left', bold: true }
          ]
        ]
        if (detailsData.area_type_id === 1) {
          allRows.push(
            [
              { text: vm.$t('globalTrans.city_corporation'), style: 'td', alignment: 'left', bold: true },
              { text: ':' },
              { text: currentLocale === 'en' ? detailsData.city_corporation_name_en : detailsData.city_corporation_name_bn, style: 'td', alignment: 'left', bold: true }
            ]
          )
        } else {
          allRows.push(
            [
              { text: vm.$t('globalTrans.upazila'), style: 'td', alignment: 'left', bold: true },
              { text: ':' },
              { text: currentLocale === 'en' ? detailsData.upazila_name_en : detailsData.upazila_name_bn, style: 'td', alignment: 'left', bold: true }
            ]
          )
          if (detailsData.area_type_id === 2) {
            allRows.push(
              [
                { text: vm.$t('globalTrans.pouroshova'), style: 'td', alignment: 'left', bold: true },
                { text: ':' },
                { text: currentLocale === 'en' ? detailsData.pauroshoba_name_en : detailsData.pauroshoba_name_bn, style: 'td', alignment: 'left', bold: true }
              ]
            )
          }
        }
        allRows.push(
          [
            { text: vm.$t('priceMonitoring.case_number'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: detailsData.case_number, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('priceMonitoring.accused_person_name_address'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: currentLocale === 'en' ? (detailsData.accused_person_name_en + '\n' + detailsData.accused_person_address_en) : (detailsData.accused_person_name_bn + '\n' + detailsData.accused_person_address_bn), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('priceMonitoring.mobile_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: mobileNumber(detailsData.mobile_no), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('priceMonitoring.date_of_conviction'), style: 'td', alignment: 'left', bold: true },
            { text: ':' },
            { text: dateFormat(detailsData.date_of_conviction), style: 'td', alignment: 'left', bold: true }
          ]
        )
        if (detailsData.fine_details && detailsData.fine_details.sections) {
          let fineInfo = ''
          if (currentLocale === 'en') {
            fineInfo = vm.$t('priceMonitoring.fine_description_of_sections') + ' ' + detailsData.fine_details.law_name_en + '\n'
          } else {
            fineInfo = detailsData.fine_details.law_name_bn + ' ' + vm.$t('priceMonitoring.fine_description_of_sections') + '\n'
          }
          detailsData.fine_details.sections.forEach((item, index) => {
            fineInfo += vm.$n(index + 1) + ') ' + vm.$n(item.section_number) + ' ' + vm.$t('priceMonitoring.amount_in_taka') + ' ' + vm.$n(item.fine_amount) + '\n'
          })
          const fineAmountInfo = vm.$t('priceMonitoring.taka_in_numbers') + ' ' + vm.$n(vm.getTotalFineAmount(detailsData.fine_details.sections)) + '\n(' + vm.$t('priceMonitoring.in_words') + ' ' + (currentLocale === 'en' ? vm.convertNumberToEnglishWords(vm.getTotalFineAmount(detailsData.fine_details.sections)) : vm.convertNumberToBanglaWords(vm.getTotalFineAmount(detailsData.fine_details.sections)) + vm.$t('priceMonitoring.taka')) + ') ' + vm.$t('priceMonitoring.only')

          allRows.push(
            [
              { text: vm.$t('priceMonitoring.convicted_of_that_crime'), style: 'td', alignment: 'left', bold: true },
              { text: ':' },
              { text: fineInfo, style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('priceMonitoring.amount_of_total_fine'), style: 'td', alignment: 'left', bold: true },
              { text: ':' },
              { text: fineAmountInfo, style: 'td', alignment: 'left', bold: true }
            ]
          )
        }
        allRows.push(
          [
            { text: '\n\n\n\n' + vm.$t('globalTrans.date') + '.....................................', style: 'td', alignment: 'left', bold: true },
            {
              text: '\n\n\n\n' + vm.$t('globalTrans.signature') + '\n\n' + '..........................................\n\n' +
                vm.$t('priceMonitoring.seal_of_fine_collecting_disposal_officer') + '\n\n\n\n',
              style: 'td',
              alignment: 'center',
              bold: true,
              colSpan: 2
            }
          ]
        )
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['40%', '1%', '59%'],
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
