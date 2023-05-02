import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, data, vm, search, searchHeader) => {
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
      const pdfContent = [
        {
            columns: reportHeadData.reportHeadColumn
        },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      const firstRowHeader = [
        [
          { text: vm.$t('bazarMonitoring.Price_category_name') + ' : ' + (i18n.locale === 'en' ? searchHeader.priceCategory_name_en : searchHeader.priceCategory_name_bn), alignment: 'left', style: 'thh' },
          { text: vm.$t('globalTrans.date') + ' : ' + dateFormat(vm.search.date), alignment: 'right', style: 'th' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: '*',
          body: firstRowHeader
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
      let priceName = ''
      if (vm.search.price_veriation === 1) {
        priceName = vm.$t('globalTrans.price') + ' : ' + vm.$t('report.lowest_price_amount')
      }
      if (vm.search.price_veriation === 2) {
        priceName = vm.$t('globalTrans.price') + ' : ' + vm.$t('report.highest_price_amount')
      }
      const allRowsHead1 = [
        [
          { text: vm.$t('bazarMonitoring.commodity_group') + ' : ' + (search.commodity_group_id.length ? vm.commodityGroupCheck(search.commodity_group_id) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
          { text: priceName, alignment: 'right', style: 'th' }
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
      if (search.area_type_id) {
        const firstRowHeaders = [
          [
            { text: vm.$t('globalTrans.division') + ' : ' + (search.division_id ? (i18n.locale === 'en' ? searchHeader.division_name : searchHeader.division_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' },
            { text: vm.$t('globalTrans.district') + ' : ' + (search.district_id ? (i18n.locale === 'en' ? searchHeader.district_name : searchHeader.district_name_bn) : vm.$t('globalTrans.all')), alignment: 'right', style: 'thh' }
          ]
        ]
        pdfContent.push({
            table: {
                headerRows: 1,
                widths: ['50%', '50%'],
                body: firstRowHeaders
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
        }
      if (search.area_type_id === 1) {
        const firstRowHeaders = [
          [
            { text: vm.$t('globalTrans.city_corporation') + ' : ' + (search.city_corporation_id ? (i18n.locale === 'en' ? searchHeader.city_corporation_name : searchHeader.city_corporation_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['100%'],
            body: firstRowHeaders
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
      }
      if (search.area_type_id === 2 || search.area_type_id === 3) {
        const firstRowHeaders = [
          [
            { text: vm.$t('globalTrans.upazila') + ' : ' + (search.upazila_id ? (i18n.locale === 'en' ? searchHeader.upazila_name : searchHeader.upazila_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['100%'],
            body: firstRowHeaders
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
      }
      if (search.area_type_id === 2) {
        const firstRowHeaders = [
          [
            { text: vm.$t('globalTrans.pouroshova') + ' : ' + (search.pauroshoba_id ? (i18n.locale === 'en' ? searchHeader.pauroshoba_name : searchHeader.pauroshoba_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['100%'],
            body: firstRowHeaders
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
      }
      const firstRowHeadersss = [
        [
          { text: vm.$t('bazarMonitoring.market_name') + ' : ' + (search.market_directory_id.length ? vm.getMarketDirectoryList(search.market_directory_id) : vm.$t('globalTrans.all')), alignment: 'left', style: 'thh' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['100%'],
          body: firstRowHeadersss
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
      const widths = ['7%', '20%']
      const allRows = []
      const secondRowHeader = [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('bazarMonitoring.market_name'), style: 'th', alignment: 'center', bold: true }
      ]
      vm.commDatas.forEach((commData, index) => {
        secondRowHeader.push(
          { text: i18n.locale === 'bn' ? commData.text_bn : commData.text_en, alignment: 'center', style: 'th', bold: true }
        )
        widths.push('*')
      })
      allRows.push(secondRowHeader)
      data.forEach((info, index) => {
        const thirdRowHeader = [
          { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
          { text: i18n.locale === 'bn' ? info.market_name_bn : info.market_name, alignment: 'center', style: 'td' }
        ]
        vm.commDatas.forEach((commData, index) => {
          thirdRowHeader.push(
            { text: vm.commDataFn(commData.value, info.list), alignment: 'center', style: 'td' }
          )
        })
        allRows.push(thirdRowHeader)
      })
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: widths,
          body: allRows
        }
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
          thh: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [0, 3, 3, 3]
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
            margin: [0, 4, 0, 15]
          },
          krishi: {
            margin: [0, -5, 0, 15],
            alignment: 'center'
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
