import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, datas, search, searchHeader) => {
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
      const allRowsHead1 = [
        [
          { text: vm.$t('bazarMonitoring.commodity_group') + ' : ' + (search.commodity_group_id ? (i18n.locale === 'en' ? searchHeader.commodity_group : searchHeader.commodity_group_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
          { text: vm.$t('bazarMonitoring.commodity_name') + ' : ' + (search.commodity_name_id ? (i18n.locale === 'en' ? searchHeader.commodity_name : searchHeader.commodity_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
          { text: vm.$t('bazarMonitoring.market_name') + ' : ' + (search.market_directory_id ? (i18n.locale === 'en' ? searchHeader.market_name_en : searchHeader.market_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
          { text: vm.$t('globalTrans.date') + ' : ' + (search.price_collection_date ? dateFormat(search.price_collection_date) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
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
      const allRowD = []
      const firstRowHeader = [
        { text: vm.$t('globalTrans.division') + ' : ' + (search.division_id ? (i18n.locale === 'en' ? searchHeader.division_name : searchHeader.division_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
        { text: vm.$t('globalTrans.district') + ' : ' + (search.district_id ? (i18n.locale === 'en' ? searchHeader.district_name : searchHeader.district_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
      ]
      if (search.area_type_id === 1) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.city_corporation') + ' : ' + (search.city_corporation_id ? (i18n.locale === 'en' ? searchHeader.city_corporation_name : searchHeader.city_corporation_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
        )
      }
      if (search.area_type_id === 2 || search.area_type_id === 3) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.upazila') + ' : ' + (search.upazila_id ? (i18n.locale === 'en' ? searchHeader.upazila_name : searchHeader.upazila_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
        )
      }
      if (search.area_type_id === 2) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.pouroshova') + ' : ' + (search.pauroshoba_id ? (i18n.locale === 'en' ? searchHeader.pauroshoba_name : searchHeader.pauroshoba_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
        )
      }
      if (search.area_type_id === 3) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.union') + ' : ' + (search.union_id ? (i18n.locale === 'en' ? searchHeader.union_name : searchHeader.union_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
        )
      }
      if (!search.area_type_id) {
        firstRowHeader.push(
          { text: '', alignment: 'left', style: 'thh' }
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
        pdfContent.push({ text: '', style: 'fertilizer' })
        datas.forEach((data, firstIndex) => {
          if (data.market_directory_id) {
            pdfContent.push({ text: vm.$t('bazarMonitoring.market_name') + ' : ' + (vm.$i18n.locale === 'bn' ? data.market_directory_bn : data.market_directory), style: 'header2', alignment: 'left' })
          }
          const allRows = []
          const firstRow = [
            { text: vm.$t('globalTrans.sl_no'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('bazarMonitoring.Price_category'), rowSpan: 2, style: 'th', alignment: 'center', bold: true }
          ]
          const widthList = ['4%', '10%']
          search.frequency_type_id.forEach((search, index) => {
            widthList.push('*', '*', '*', '*')
            if (search === 1) {
              firstRow.push(
                { text: vm.$t('report.day_price') + '\n' + (dateFormat(vm.dateList[0])), colSpan: 4, style: 'th', alignment: 'center', bold: true },
                {},
                {},
                {}
              )
            }
            if (search === 2) {
              firstRow.push(
                { text: vm.$t('report.week_price') + '\n' + dateFormat(vm.dateList[1]), colSpan: 4, style: 'th', alignment: 'center', bold: true },
                {},
                {},
                {}
              )
            }
            if (search === 3) {
              firstRow.push(
                { text: vm.$t('report.month_price') + '\n' + dateFormat(vm.dateList[2]), colSpan: 4, style: 'th', alignment: 'center', bold: true },
                {},
                {},
                {}
              )
            }
            if (search === 4) {
              firstRow.push(
                { text: vm.$t('report.year_price') + '\n' + dateFormat(vm.dateList[3]), colSpan: 4, style: 'th', alignment: 'center', bold: true },
                {},
                {},
                {}
              )
            }
          })
          allRows.push(firstRow)
          const secondHeader = [
            {},
            {}
          ]
          search.frequency_type_id.forEach((priceItem, index) => {
            secondHeader.push(
              { text: vm.$t('report.l'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('report.h'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('report.tk'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('report.%'), style: 'td', alignment: 'center', bold: true }
            )
          })
          allRows.push(secondHeader)
          data.list.forEach((info, index) => {
            const NewLoop = []
            NewLoop.push({ text: vm.$n(index + 1), style: 'td', alignment: 'center' })
            NewLoop.push({ text: vm.$i18n.locale === 'bn' ? info.price_category_bn : info.price_category, style: 'td', alignment: 'center' })
            search.frequency_type_id.forEach((search) => {
              if (search === 1) {
                NewLoop.push({ text: vm.$n(info.lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                NewLoop.push({ text: vm.$n(info.highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                let takaIncrease = vm.$n(0.00.toFixed(2))
                if (info.today_taka_increase) {
                  if (info.today_taka_increase < 0) {
                    takaIncrease = vm.$n(info.today_taka_increase.toFixed(2))
                  } else {
                    takaIncrease = '+' + vm.$n(info.today_taka_increase.toFixed(2))
                  }
                }
                NewLoop.push({ text: takaIncrease, style: 'td', alignment: 'center' })
                let todayPercentage = vm.$n(0.00.toFixed(2))
                if (info.today_percenatage) {
                  if (info.today_percenatage < 0) {
                    todayPercentage = vm.$n(info.today_percenatage.toFixed(2))
                  } else {
                    todayPercentage = '+' + vm.$n(info.today_percenatage.toFixed(2))
                  }
                }
                NewLoop.push({ text: todayPercentage, style: 'td', alignment: 'center' })
              } else if (search === 2) {
                NewLoop.push({ text: vm.$n(info.weekly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                NewLoop.push({ text: vm.$n(info.weekly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                let weeklyTakaIncrease = vm.$n(0.00.toFixed(2))
                if (info.weekly_taka_increase) {
                  if (info.weekly_taka_increase < 0) {
                    weeklyTakaIncrease = vm.$n(info.weekly_taka_increase.toFixed(2))
                  } else {
                    weeklyTakaIncrease = '+' + vm.$n(info.weekly_taka_increase.toFixed(2))
                  }
                }
                NewLoop.push({ text: weeklyTakaIncrease, style: 'td', alignment: 'center' })
                let weeklyPercentage = vm.$n(0.00.toFixed(2))
                if (info.weekly_percentage) {
                  if (info.weekly_percentage < 0) {
                    weeklyPercentage = vm.$n(info.weekly_percentage.toFixed(2))
                  } else {
                    weeklyPercentage = '+' + vm.$n(info.weekly_percentage.toFixed(2))
                  }
                }
                NewLoop.push({ text: weeklyPercentage, style: 'td', alignment: 'center' })
              } else if (search === 3) {
                NewLoop.push({ text: vm.$n(info.monthly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                NewLoop.push({ text: vm.$n(info.monthly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                let monthlyTakaIncrease = vm.$n(0.00.toFixed(2))
                if (info.monthly_taka_increase) {
                  if (info.monthly_taka_increase < 0) {
                    monthlyTakaIncrease = vm.$n(info.monthly_taka_increase.toFixed(2))
                  } else {
                    monthlyTakaIncrease = '+' + vm.$n(info.monthly_taka_increase.toFixed(2))
                  }
                }
                NewLoop.push({ text: monthlyTakaIncrease, style: 'td', alignment: 'center' })
                let monthlyPercentage = vm.$n(0.00.toFixed(2))
                if (info.monthly_percentage) {
                  if (info.monthly_percentage < 0) {
                    monthlyPercentage = vm.$n(info.monthly_percentage.toFixed(2))
                  } else {
                    monthlyPercentage = '+' + vm.$n(info.monthly_percentage.toFixed(2))
                  }
                }
                NewLoop.push({ text: monthlyPercentage, style: 'td', alignment: 'center' })
              } else if (search === 4) {
                NewLoop.push({ text: vm.$n(info.yearly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                NewLoop.push({ text: vm.$n(info.yearly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                let yearlyTakaIncrease = vm.$n(0.00.toFixed(2))
                if (info.yearly_taka_increase) {
                  if (info.yearly_taka_increase < 0) {
                    yearlyTakaIncrease = vm.$n(info.yearly_taka_increase.toFixed(2))
                  } else {
                    yearlyTakaIncrease = '+' + vm.$n(info.yearly_taka_increase.toFixed(2))
                  }
                }
                NewLoop.push({ text: yearlyTakaIncrease, style: 'td', alignment: 'center' })
                let yearlyPercentage = vm.$n(0.00.toFixed(2))
                if (info.yearly_percentage) {
                  if (info.yearly_percentage < 0) {
                    yearlyPercentage = vm.$n(info.yearly_percentage.toFixed(2))
                  } else {
                    yearlyPercentage = '+' + vm.$n(info.yearly_percentage.toFixed(2))
                  }
                }
                NewLoop.push({ text: yearlyPercentage, style: 'td', alignment: 'center' })
              }
            })
            allRows.push(NewLoop)
          })
          pdfContent.push({
            table: {
              headerRows: 2,
              widths: widthList,
              body: allRows
            }
          })
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
        defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
        // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          thh: {
            fontSize: (i18n.locale === 'bn') ? 14 : 12,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
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
            margin: [0, 15, 0, 10]
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
