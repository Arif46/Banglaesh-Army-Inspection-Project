import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
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
            columns: reportHeadData?.reportHeadColumn
        },
        { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData?.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      const search = vm.search
      const searchHeaderData = vm.searchHeaderData
      const listData = vm.listData
      const currentLocale = vm.currentLocale
        const header1 = [
          { text: vm.$t('globalTrans.division'), style: 'td', alignment: 'right' },
          { text: ':', style: 'td', alignment: 'center' },
          { text: search.division_id ? (i18n.locale === 'en' ? searchHeaderData.division_name : searchHeaderData.division_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.district'), style: 'td', alignment: 'right' },
          { text: ':', style: 'td', alignment: 'center' },
          { text: search.district_id ? (i18n.locale === 'en' ? searchHeaderData.district_name : searchHeaderData.district_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
        ]
        if (search.area_type_id === 1) {
          header1.push(
            { text: vm.$t('globalTrans.city_corporation'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.city_corporation_id ? (i18n.locale === 'en' ? searchHeaderData.city_corporation_name : searchHeaderData.city_corporation_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            {},
            {},
            {}
          )
        } else {
          header1.push(
            { text: vm.$t('globalTrans.upazila'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.upazila_id ? (i18n.locale === 'en' ? searchHeaderData.upazila_name : searchHeaderData.upazila_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
          )
          if (search.area_type_id === 2) {
            header1.push(
              { text: vm.$t('globalTrans.pouroshova'), style: 'td', alignment: 'right' },
              { text: ':', style: 'td', alignment: 'center' },
              { text: search.pauroshoba_id ? (i18n.locale === 'en' ? searchHeaderData.pauroshoba_name : searchHeaderData.pauroshoba_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
            )
          } else {
            header1.push(
              { text: vm.$t('globalTrans.union'), style: 'td', alignment: 'right' },
              { text: ':', style: 'td', alignment: 'center' },
              { text: search.union_id ? (i18n.locale === 'en' ? searchHeaderData.union_name : searchHeaderData.union_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true }
            )
          }
        }
        const allRowsHead = [
          header1,
          [
            { text: vm.$t('bazarMonitoring.market_name'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.market_directory_id ? (i18n.locale === 'en' ? searchHeaderData.market_name_en : searchHeaderData.market_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('report.frequency_type'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.frequency_type ? (i18n.locale === 'en' ? searchHeaderData.frequency_name : searchHeaderData.frequency_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('bazarMonitoring.Price_category'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.price_category_id ? (i18n.locale === 'en' ? searchHeaderData.price_category_name : searchHeaderData.price_category_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('globalTrans.date'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: dateFormat(search.date), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('bazarMonitoring.commodity_group'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.commodity_group_id.length ? (i18n.locale === 'en' ? searchHeaderData.commodity_group_name_en : searchHeaderData.commodity_group_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('bazarMonitoring.commodity_name'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: search.commodity_name_id.length ? (i18n.locale === 'en' ? searchHeaderData.commodity_name_en : searchHeaderData.commodity_name_bn) : vm.$t('globalTrans.all'), style: 'td', alignment: 'left', bold: true },
            { text: '', style: 'td', alignment: 'right' },
            { text: '', style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left', bold: true },
            { text: '', style: 'td', alignment: 'right' },
            { text: '', style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left', bold: true }
          ]
        ]
        pdfContent.push({
          table: {
            widths: ['12%', '1%', '12%', '12%', '1%', '12%', '12%', '1%', '12%', '12%', '1%', '12%'],
            // widths: '*',
            body: allRowsHead
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
        const allRows = []
        const tableHead1 = [
          { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
          { text: vm.$t('bazarMonitoring.commodity_group'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
          { text: vm.$t('bazarMonitoring.commodity_name'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
          { text: vm.$t('bazarMonitoring.Price_category'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 }
        ]
        vm.frequencyDateArr.forEach((info, index) => {
          tableHead1.push(
            {
              text: (currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn) + (' ' + dateFormat(info.frequency_date)), style: 'th', alignment: 'center', bold: true, colSpan: 4
            },
            {},
            {},
            {}
          )
        })
        const tableHead2 = [{}, {}, {}, {}]
        vm.frequencyDateArr.forEach((info, index) => {
          tableHead2.push(
            {
              text: vm.$t('report.l'), style: 'th', alignment: 'center', bold: true
            },
            {
              text: vm.$t('report.h'), style: 'th', alignment: 'center', bold: true
            },
            {
              text: vm.$t('report.tk'),
              style: 'th',
              alignment: 'center',
              bold: true
            },
            {
              text: vm.$t('report.%'), style: 'th', alignment: 'center', bold: true
            }
          )
        })
        allRows.push(tableHead1, tableHead2)
        if (listData.length) {
          listData.forEach((item, index) => {
            item.commodity_name_info.forEach((commodityNameInfo, commodityNameInfoIndex) => {
              commodityNameInfo.price_category_info.forEach((priceCategoryInfo, priceCategoryInfoIndex) => {
                const rowItem = []
                if (commodityNameInfoIndex === 0 && priceCategoryInfoIndex === 0) {
                  rowItem.push(
                    { text: vm.$n(index + 1), alignment: 'center', rowSpan: (item.total_rows > 1 ? item.total_rows : null), style: 'td' },
                    { text: (i18n.locale === 'en') ? item.commodity_group_name_en : item.commodity_group_name_bn, alignment: 'center', rowSpan: (item.total_rows > 1 ? item.total_rows : null), style: 'td' }
                    )
                } else {
                  rowItem.push(
                    { text: '', alignment: 'center', style: 'td' },
                    { text: '', alignment: 'center', style: 'td' }
                  )
                }
                if (priceCategoryInfoIndex === 0) {
                  rowItem.push(
                    { text: (i18n.locale === 'en') ? commodityNameInfo.commodity_name_en : commodityNameInfo.commodity_name_bn, alignment: 'center', rowSpan: (commodityNameInfo.price_category_info.length > 1 ? commodityNameInfo.price_category_info.length : null), style: 'td' }
                  )
                } else {
                  rowItem.push(
                    { text: '', alignment: 'center', style: 'td' }
                  )
                }
                rowItem.push(
                  { text: (i18n.locale === 'en') ? priceCategoryInfo.price_category_name_en : priceCategoryInfo.price_category_name_bn, alignment: 'center', style: 'td' }
                )
                priceCategoryInfo.frequency_type_info.forEach((frequencyItem, frequencyIndex) => {
                  rowItem.push(
                    {
                      text: vm.$n(frequencyItem.lowest_price_amount), alignment: 'center', style: 'td'
                    },
                    {
                      text: vm.$n(frequencyItem.highest_price_amount), alignment: 'center', style: 'td'
                    },
                    {
                      text: vm.getFluctuationRate(frequencyItem, 'fluctuation_rate'), alignment: 'center', style: 'td'
                    },
                    {
                      text: vm.getFluctuationRate(frequencyItem, 'fluctuation_rate_percentage') + '%', alignment: 'center', style: 'td'
                    }
                  )
                })
                allRows.push(rowItem)
              })
            })
          })
        } else {
          allRows.push([
            { text: vm.$t('globalTrans.noDataFound'), alignment: 'center', style: 'td', colSpan: (4 + (4 * vm.frequencyDateArr.length)) }
          ])
        }
        pdfContent.push({
          margin: [0, 20, 0, 0],
          table: {
            headerRows: 2,
            // widths: ['6%', '14%', '14%', '13%', '12%', '12%', '9%', '10%', '10%'],
            widths: '*',
            body: allRows
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: {
          width: 2100,
          height: 1000
        },
        pageOrientation: 'landscape',
        footer: { text: (i18n.locale === 'bn' ? 'প্রতিবেদন প্রকাশকাল:' : 'Report Publication Period:') + ' ' + (new Date().toLocaleString()), fontSize: 8, marginLeft: 50 },
        defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
        // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 10 : 12,
            margin: [0, 0, 0, 0]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 12 : 10,
            margin: [0, 0, 0, 0]
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
            margin: [0, 4, 0, 11]
          },
          krishi: {
            margin: [0, -5, 0, 11],
            alignment: 'center'
          },
          header3: {
            fontSize: 9,
            margin: [0, 0, 0, 0]
          },
          tableSubHead: {
            margin: [0, 5, 0, 11]
          },
          header1: {
            fontSize: 13,
            margin: [0, 5, 0, 5]
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
