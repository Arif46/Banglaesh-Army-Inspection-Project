import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../tcb-report/components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, items, vm) => {
  try {
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

          const allRowsHead1 = [
            [
              { text: vm.$t('globalTrans.fiscal_year') + ' : ' + vm.getFiscalYear(items.fiscal_year_id), alignment: 'left', style: 'thh' },
              { text: vm.$t('allocation_management.allotment_count') + ' : ' + vm.$n(items.allotment_count_id), alignment: 'right', style: 'thh' }
            ]
          ]
          allRowsHead1.push([
            { text: vm.$t('allocation_dc_office.allotment_date') + ' : ' + dateFormat(items.allotment_date), alignment: 'left', style: 'thh' },
            { text: vm.$t('allocation_dc_office.dispatch_no') + ' : ' + items.dispatch_no, alignment: 'right', style: 'thh' }
          ])
          allRowsHead1.push([
            { text: '' + '' + '', alignment: 'left', style: 'thh' },
            { text: '' + '' + '', alignment: 'left', style: 'thh' }
          ])
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
        //  var widthone = ['12%', '12%', '12%', '12%', '12%', '12%', '12%']
          const firstrow = []
          firstrow.push({ text: vm.$t('globalTrans.sl_no'), alignment: 'center' })
          firstrow.push({ text: vm.$t('globalTrans.district_name'), alignment: 'center' })
          firstrow.push({ text: vm.$t('allocation_management.no_of_beneficary'), alignment: 'center' })
          items.districts[0].details.map((item) => {
            firstrow.push({ text: vm.getItemCategoryName(item.item_category_id) + ' (' + vm.$t('allocation_dc_office.unit') + ')', alignment: 'center' })
          })
          const districtWiseAllotment = [
            firstrow
          ]
          items.districts.filter(i => i.total_beneficiary > 0).map((item, index) => {
           const looprow = []
            looprow.push({ text: vm.$n(index + 1), style: 'tablecell' })
            looprow.push({ text: vm.getDistrictName(item.district_id), style: 'tablecell' })
            looprow.push({ text: vm.$n(item.total_beneficiary), style: 'tablecell' })
              item.details.map((element) => {
                looprow.push({ text: vm.$n(element.allocated_quantity), style: 'tablecell' })
              })
              // const haveData = item.details.length
              // const remainder = 5 - haveData
              // for (let k = 0; k < remainder; k++) {
              //   looprow.push({ text: '', style: 'tablecell' })
              // }
              districtWiseAllotment.push(looprow)
          })

          const secondrow = []
          secondrow.push({ text: vm.$t('globalTrans.total') + ':', colSpan: 2, alignment: 'right', style: 'tablecell' })
          secondrow.push({ text: '', style: 'tablecell' })
          secondrow.push({ text: vm.$n(vm.getTotalBeneficiary()), style: 'tablecell' })
          items.districts[0].details.map((element) => {
            secondrow.push({ text: vm.$n(vm.getTotalBeneficiaryItem(element.item_category_id)), style: 'tablecell' })
          })
          districtWiseAllotment.push(secondrow)

          // const lastwidths = ['10%', '20%', '20%', '10%', '10%', '10%', '10%', '10%']

          const lastwidths = ['10%', '22%', '22%']
          items.districts[0].details.map((element) => {
            const haveData = items.districts[0].details.length
              const remainder = 5 - haveData
              if (remainder === 2) {
                lastwidths.push('15%')
              }
              if (remainder === 3) {
                lastwidths.push('23%')
              }
              if (remainder === 4) {
                lastwidths.push('46%')
              }
              if (remainder === 1) {
                lastwidths.push('12%')
              }
              if (remainder <= 0) {
                lastwidths.push('8%')
              }
          })
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: lastwidths,
                body: districtWiseAllotment
              }
            })

        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
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
            fontSize: 8,
            alignment: 'center'
          },
          marginForUse: {
            margin: [0, 20, 0, 0]
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
