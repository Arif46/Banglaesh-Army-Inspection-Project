import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
// import pdfMakeUnicode from 'pdfmake-unicode'
import { dateFormat } from '@/utils/fliter'

function takaIncreament (dataField, vm) {
  let takaIncrease = 0.00.toFixed(2)
  if (dataField) {
    if (dataField < 0) {
      takaIncrease = vm.$n(dataField.toFixed(2))
    } else {
      takaIncrease = '+' + vm.$n(dataField.toFixed(2))
    }
  }
  if (!dataField) {
    if (vm.$i18n.locale === 'bn') {
      return vm.$n(takaIncrease)
    } else {
      return takaIncrease
    }
  }
  return takaIncrease
}

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
      // pdfMake.vfs = pdfMakeUnicode.pdfMake.vfs

      const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
      const pdfContent = [
        {
          columns: reportHeadData.reportHeadColumn
        },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
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
      const firstReportHead = []
      firstReportHead.push(
        { text: vm.$t('bazarMonitoring.market_name') + ' : ' + (search.market_directory_id ? (i18n.locale === 'en' ? searchHeader.market_name_en : searchHeader.market_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
        { text: vm.$t('bazarMonitoring.Price_category') + ' : ' + (search.price_category_id ? (i18n.locale === 'en' ? searchHeader.price_category : searchHeader.price_category_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
        { text: vm.$t('globalTrans.date') + ' : ' + (search.price_collection_date ? dateFormat(search.price_collection_date) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
      )
      if (search.area_type_id) {
        if (search.area_type_id !== 1) {
          firstReportHead.push({})
        }
      }
      const allRowsHead1 = []
      allRowsHead1.push(firstReportHead)
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
      pdfContent.push({ text: '', style: 'fertilizer', alignment: 'center' })
      datas.forEach((data, firstIndex) => {
        if (data.market_directory_id) {
          pdfContent.push({ text: vm.$t('bazarMonitoring.market_name') + ' : ' + (vm.$i18n.locale === 'bn' ? data.market_directory_bn : data.market_directory), style: 'header2', alignment: 'left' })
          pdfContent.push({ text: '', style: 'fertilizer', alignment: 'center' })
        }
      const allRows = []
      const firstRow = [
        { text: vm.$t('globalTrans.sl_no'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('bazarMonitoring.commodity_group'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('bazarMonitoring.commodity_name'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('bazarMonitoring.Price_category'), rowSpan: 2, style: 'th', alignment: 'center', bold: true }
      ]
      const widthList = ['5%', '8%', '10%', '11%']
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
            { text: vm.$t('report.week_price') + '\n' + (dateFormat(vm.dateList[1])), colSpan: 4, style: 'th', alignment: 'center', bold: true },
            {},
            {},
            {}
          )
        }
        if (search === 3) {
          firstRow.push(
            { text: vm.$t('report.month_price') + '\n' + (dateFormat(vm.dateList[2])), colSpan: 4, style: 'th', alignment: 'center', bold: true },
            {},
            {},
            {}
          )
        }
        if (search === 4) {
          firstRow.push(
            { text: vm.$t('report.year_price') + '\n' + (dateFormat(vm.dateList[3])), colSpan: 4, style: 'th', alignment: 'center', bold: true },
            {},
            {},
            {}
          )
        }
      })
      allRows.push(firstRow)
      const secondHeader = [
        {},
        {},
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
        // const thridRow = [
        //   { text: vm.$i18n.locale === 'bn' ? data.market_directory_bn : data.market_directory, colSpan: 4 + search.frequency_type_id.length * 4, style: 'td', alignment: 'center', bold: true },
        //   {},
        //   {},
        //   {},
        //   {}
        // ]
        // search.frequency_type_id.forEach((search, index) => {
        //   if (index === 0) {
        //     thridRow.push(
        //       {},
        //       {},
        //       {}
        //     )
        //   } else {
        //     thridRow.push(
        //       {},
        //       {},
        //       {},
        //       {}
        //     )
        //   }
        // })
        // allRows.push(thridRow)
        data.group.forEach((group, index) => {
          group.commodity.forEach((commodity, index1) => {
            commodity.list.forEach((info, index2) => {
              const NewLoop = []
              if (index1 === 0 && index2 === 0) {
                NewLoop.push({ text: vm.$n(index + 1), style: 'td', rowSpan: group.rowspan, alignment: 'center' })
                NewLoop.push({ text: vm.$i18n.locale === 'bn' ? group.commodity_group_bn : group.commodity_group, style: 'td', rowSpan: group.rowspan, alignment: 'center' })
              } else {
                NewLoop.push({})
                NewLoop.push({})
              }
              if (index2 === 0) {
                NewLoop.push({ text: vm.$i18n.locale === 'bn' ? commodity.commodity_name_bn : commodity.commodity_name, style: 'td', rowSpan: commodity.list.length, alignment: 'center' })
              } else {
                NewLoop.push({})
              }
              NewLoop.push({ text: vm.$i18n.locale === 'bn' ? info.price_category_bn : info.price_category, style: 'td', rowSpan: commodity.list.length, alignment: 'center' })
              search.frequency_type_id.forEach((search) => {
                if (search === 1) {
                  NewLoop.push({ text: vm.$n(info.lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: vm.$n(info.highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.today_taka_increase, vm), alignment: 'center', style: 'icon' })
                  NewLoop.push({ text: takaIncreament(info.today_percenatage, vm), style: 'td', alignment: 'center' })
                } else if (search === 2) {
                  NewLoop.push({ text: vm.$n(info.weekly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: vm.$n(info.weekly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.weekly_taka_increase, vm), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.weekly_percentage, vm), style: 'td', alignment: 'center' })
                } else if (search === 3) {
                  NewLoop.push({ text: vm.$n(info.monthly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: vm.$n(info.monthly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.monthly_taka_increase, vm), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.monthly_percentage, vm), style: 'td', alignment: 'center' })
                } else if (search === 4) {
                  NewLoop.push({ text: vm.$n(info.yearly_lowest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: vm.$n(info.yearly_highest_price_amount.toFixed(2)), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.yearly_taka_increase, vm), style: 'td', alignment: 'center' })
                  NewLoop.push({ text: takaIncreament(info.yearly_percentage, vm), style: 'td', alignment: 'center' })
                }
              })
              allRows.push(NewLoop)
            })
          })
        })
      pdfContent.push({
        table: {
          headerRows: 3,
          widths: widthList,
          body: allRows
        }
      })
    })
      // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
      var docDefinition = {
      content: pdfContent,
      pageSize: 'A3',
      pageOrientation: 'landscape',
      defaultStyle: {
        font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
      },
      // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 10 : 12,
          margin: [3, 3, 3, 3]
        },
        td: {
          fontSize: (i18n.locale === 'bn') ? 12 : 10,
          margin: [3, 3, 3, 3]
        },
        search: {
          fontSize: (i18n.locale === 'bn') ? 9 : 10,
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
          fontSize: 12,
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
        thh: {
          fontSize: (i18n.locale === 'bn') ? 14 : 12,
          margin: [3, 3, 3, 3]
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
