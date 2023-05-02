import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, data, priceCategory, getPriceCategoryInfo, search, searchHeader) => {
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
        { text: vm.$t('globalTrans.division') + ' : ' + (search.division_id ? (i18n.locale === 'en' ? searchHeader.division_name : searchHeader.division_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
        { text: vm.$t('globalTrans.district') + ' : ' + (search.district_id ? (i18n.locale === 'en' ? searchHeader.district_name : searchHeader.district_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
      ]
      if (search.area_type_id === 1) {
        firstRowHeader.push(
          { text: vm.$t('globalTrans.city_corporation') + ' : ' + (search.city_corporation_id ? (i18n.locale === 'en' ? searchHeader.city_corporation : searchHeader.city_corporation_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
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
        { text: vm.$t('globalTrans.date') + ' : ' + (search.price_collection_date ? dateFormat(search.price_collection_date) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
        {}
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
      if (data.length > 0) {
        const allRows = []
        const firstRow = [
          { text: vm.$t('globalTrans.sl_no'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('bazarMonitoring.commodity_group_name'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('bazarMonitoring.commodity_name'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('bazarMonitoring.measurement_unit'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('report.price'), colSpan: priceCategory.length * 4, style: 'th', alignment: 'center', bold: true }
        ]
        priceCategory.forEach((priceItem, index) => {
          if (index === 0) {
            firstRow.push(
              {},
              {},
              {}
            )
          } else {
            firstRow.push(
              {},
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
        const widthList = ['3%', '10%', '10%', '11%']
        priceCategory.forEach((priceItem, index) => {
          widthList.push('*', '*', '*', '*')
          secondHeader.push(
            { text: (vm.$i18n.locale === 'bn') ? priceItem.price_category_bn : priceItem.price_category, style: 'td', alignment: 'center', bold: true, colSpan: 4 },
            { },
            { },
            { }
          )
        })
        allRows.push(secondHeader)
        const thirdHeader = [
          {},
          {},
          {},
          {}
        ]
        priceCategory.forEach(priceItem => {
          thirdHeader.push(
            {
              text: vm.$t('report.l'),
              style: 'th',
              alignment: 'center'
            },
            {
              text: vm.$t('report.h'),
              style: 'th',
              alignment: 'center'
            },
            {
              text: vm.$t('report.tk'),
              style: 'th',
              alignment: 'center'
            },
            {
              text: vm.$t('report.%'),
              style: 'th',
              alignment: 'center'
            }
          )
        })
        allRows.push(thirdHeader)
        data.forEach((item, optionIndex) => {
          item.commodity_name_info.forEach((info1, index2) => {
            const NewLoop = []
            if (index2 === 0) {
              NewLoop.push({ text: vm.$n(optionIndex + 1), style: 'td', rowSpan: item.commodity_name_info.length, alignment: 'center' })
              NewLoop.push({ text: vm.$i18n.locale === 'bn' ? item.commodity_group_bn : item.commodity_group, style: 'td', rowSpan: item.commodity_name_info.length, alignment: 'center' })
            } else {
              NewLoop.push({})
              NewLoop.push({})
            }
            NewLoop.push({ text: vm.$i18n.locale === 'bn' ? info1.commodity_name_bn : info1.commodity_name, style: 'td', alignment: 'center' })
            NewLoop.push({ text: vm.$i18n.locale === 'bn' ? info1.unit_name_bn : info1.unit_name, style: 'td', alignment: 'center' })
            priceCategory.forEach((priceItem, index) => {
              NewLoop.push(
                { text: getPriceCategoryInfo(priceItem.value, info1.price_category_info) !== undefined ? vm.$n(getPriceCategoryInfo(priceItem.value, info1.price_category_info).lowest_price_amount) : (vm.$i18n.locale === 'bn') ? '০' : '0', style: 'td', alignment: 'center' },
                { text: getPriceCategoryInfo(priceItem.value, info1.price_category_info) !== undefined ? vm.$n(getPriceCategoryInfo(priceItem.value, info1.price_category_info).highest_price_amount) : (vm.$i18n.locale === 'bn') ? '০' : '0', style: 'td', alignment: 'center' },
                { text: getPriceCategoryInfo(priceItem.value, info1.price_category_info) !== undefined ? vm.$n(getPriceCategoryInfo(priceItem.value, info1.price_category_info).lowest_price_percentage) : (vm.$i18n.locale === 'bn') ? '০' : '0', style: 'td', alignment: 'center' },
                { text: getPriceCategoryInfo(priceItem.value, info1.price_category_info) !== undefined ? vm.$n(getPriceCategoryInfo(priceItem.value, info1.price_category_info).highest_price_percentage) : (vm.$i18n.locale === 'bn') ? '০' : '0', style: 'td', alignment: 'center' }
              )
            })
            allRows.push(NewLoop)
          })
        })
        pdfContent.push({
          table: {
            headerRows: 3,
            widths: widthList,
            body: allRows
          }
        })
      }
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
            fontSize: (i18n.locale === 'bn') ? 6 : 7,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 7 : 6,
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
