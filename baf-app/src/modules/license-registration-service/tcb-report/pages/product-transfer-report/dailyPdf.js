import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'
// import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, vm, search, dailyData) => {
  try {
    const districts = dailyData.regeionWiseDistrict
    const preDistricts = dailyData.preRegeionWiseDistrict
    const items = dailyData.regeionWiseDistrict[0].items

    districts.forEach(district => {
        if (district.report_items.length > 0) {
          const summed = district.report_items.reduce((acc, cur, i) => {
          const item = i > 0 && acc.find(({ catId }) => catId === cur.catId)
          if (item) item.disQty += cur.disQty
          else acc.push({ catId: cur.catId, disQty: cur.disQty }) // don't push cur here
          return acc
          }, [])
          district.report_items = summed
        }
    })

    preDistricts.forEach(district => {
        if (district.report_items.length > 0) {
          const summed = district.report_items.reduce((acc, cur, i) => {
          const item = i > 0 && acc.find(({ catId }) => catId === cur.catId)
          if (item) item.preAmount += cur.preAmount
          else acc.push({ catId: cur.catId, preAmount: cur.preAmount }) // don't push cur here
          return acc
          }, [])
          district.report_items = summed
        }
    })
        Store.commit('mutateCommonProperties', {
          loading: true
        })
        if (i18n.locale === 'bn') {
          pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        }
          const pdfContent = []
          const allRowsHeadTwo = []
          const rowItemTwo = ReportHeading(vm)
          allRowsHeadTwo.push(...rowItemTwo)
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          pdfContent.push({
            table: {
              widths: ['20%', '60%', '20%'],
              body: allRowsHeadTwo
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

        // }

        const allRowsHead1 = []

        allRowsHead1.push([
          { text: ' ', alignment: 'left', style: 'thh' },
          { text: vm.$t('tcb_report.transfer_report'), alignment: 'center', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'thh' }
        ])

        allRowsHead1.push([
          { text: '' + '' + '', alignment: 'left', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'thh' },
          { text: '' + '' + '', alignment: 'left', style: 'marginForUse' }
        ])

        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['20%', '60%', '20%'],
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

        var widthone = []
        widthone.push('5%')
        widthone.push('5%')
        widthone.push('5%')
        widthone.push('5%')
        const abn = 75 / (4 * (items.length))
        var a = 0
        for (a = 0; a < items.length; a++) {
            widthone.push(Math.round(abn) + '%')
            widthone.push(Math.round(abn) + '%')
            widthone.push(Math.round(abn) + '%')
            widthone.push(Math.round(abn) + '%')
        }
        widthone.push('5%')
          const firstrow = []
          firstrow.push({ text: vm.$t('globalTrans.sl_no'), style: 'tablecell', rowSpan: 2 })
          firstrow.push({ text: vm.$t('tcb_report.regional_office'), style: 'tablecell', rowSpan: 2 })
          firstrow.push({ text: vm.$t('tcb_report.district_name'), style: 'tablecell', rowSpan: 2 })
          firstrow.push({ text: vm.$t('tcb_report.number_of_beneficiary'), style: 'tablecell', rowSpan: 2 })
          items.map((item) => {
            firstrow.push({ text: vm.getItemCategoryName(item.item_category_id), style: 'tablecell', colSpan: 4 })
             firstrow.push({ text: '', style: 'tablecell' })
             firstrow.push({ text: '', style: 'tablecell' })
             firstrow.push({ text: '', style: 'tablecell' })
          })
          firstrow.push({ text: vm.$t('tcb_report.comment'), style: 'tablecell', rowSpan: 2 })

          const secondRow = []
          secondRow.push({ text: '', style: 'tablecell' })
          secondRow.push({ text: '', style: 'tablecell' })
          secondRow.push({ text: '', style: 'tablecell' })
          secondRow.push({ text: '', style: 'tablecell' })
          items.map((item) => {
            secondRow.push({ text: vm.$t('tcb_report.due_amount'), style: 'tablecell' })
            secondRow.push({ text: vm.$t('tcb_report.supplier_amount'), style: 'tablecell' })
            secondRow.push({ text: vm.$t('tcb_report.tcb_amount'), style: 'tablecell' })
            secondRow.push({ text: vm.$t('tcb_report.remainder_amount'), style: 'tablecell' })
          })
          secondRow.push({ text: '', style: 'tablecell' })
          const AllocationReport = [
            firstrow, secondRow
          ]
          districts.map((district, index) => {
            const looprow = []
            looprow.push({ text: vm.$n(index + 1), style: 'tablecell' })
            if (index === 0) {
                looprow.push({ text: vm.getOfficeName(district.regional_office_id), style: 'tablecell', rowSpan: districts.length })
            } else {
                looprow.push({ text: '', style: 'tablecell' })
            }
            looprow.push({ text: vm.getDistrictName(district.district_id), style: 'tablecell' })
            looprow.push({ text: vm.$n(district.total_beneficiary), style: 'tablecell' })
            if (district.report_items.length > 0) {
                district.report_items.map((item, itemIn) => {
                    looprow.push({ text: vm.$n(preDistricts[index].report_items[itemIn].preAmount), style: 'tablecell' })
                    looprow.push({ text: vm.$n(0), style: 'tablecell' })
                    looprow.push({ text: vm.$n(item.disQty), style: 'tablecell' })
                    looprow.push({ text: vm.$n((preDistricts[index].report_items[itemIn].preAmount) - (item.disQty)), style: 'tablecell' })
                })
            } else {
                items.map((item) => {
                    looprow.push({ text: vm.$n(0), style: 'tablecell' })
                    looprow.push({ text: vm.$n(0), style: 'tablecell' })
                    looprow.push({ text: vm.$n(0), style: 'tablecell' })
                    looprow.push({ text: vm.$n(0), style: 'tablecell' })
                })
            }
              looprow.push({ text: '', style: 'tablecell' })
              AllocationReport.push(looprow)
            })
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: widthone,
                body: AllocationReport
              }
            })

        var docDefinition = {
        content: pdfContent,
        pageSize: 'A3',
        pageOrientation: 'Landcape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          search: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [3, 3, 3, 3]
          },
          fertilizer: {
            margin: [5, 0, 0, 5]
          },
          header: {
            fontSize: 12,
            margin: [0, 0, 0, 4]
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
          address: {
            fontSize: 9,
            margin: [0, -10, 0, 0]
          },
          tableSubHead: {
            margin: [0, 5, 0, 15]
          },
          img_logo: {
            margin: [20, 0, 0, 0]
          },
          img_logo_two: {
            margin: [25, 0, 0, 0]
          },
          reportHeading: {
            fontSize: 13,
            margin: [0, 10, 0, 0]
          },
          headerTwo: {
            fontSize: 12,
            margin: [0, -10, 0, 0]
          },
          headerThree: {
            fontSize: 9,
            margin: [0, 1, 0, 0]
          },
          giveUnderline: {
            decoration: 'underline',
            margin: [0, 10, 0, 0]
          },
          tableHeader: {
            alignment: 'center'
          },
          tableHeaderTwo: {
            fontSize: 9,
            alignment: 'center',
            margin: [0, 10, 0, 0]
          },
          tableHeaderThree: {
            alignment: 'left',
            margin: [0, 0, 0, 0]
          },
          tableHeaderFour: {
            alignment: 'left',
            margin: [0, 50, 0, 0]
          },
          tableHeaderFive: {
            alignment: 'left',
            bold: true
          },
          tableExampleGrid: {
            margin: [0, 5, 5, 0]
          },
          tableHeaderSix: {
            fontSize: 15,
            margin: [0, 8, 8, 0]
          },
          tableHeaderSeven: {
            fontSize: 10,
            margin: [0, 0, 0, 0]
          },
          tableHeaderEight: {
            fontSize: 10,
            margin: [20, 0, 0, 0]
          },
          leftalign: {
            alignment: 'left'
          },
          tablecell: {
            alignment: 'center'
          },
          marginForUse: {
            margin: [0, 20, 0, 0]
          }
        }
      }
      pdfMake.createPdf(docDefinition, null, null, null).print()
    } catch (error) {
      if (error) {
      }
    }
    Store.commit('mutateCommonProperties', {
      loading: false
    })
}
export default {
  exportPdfDetails
}
