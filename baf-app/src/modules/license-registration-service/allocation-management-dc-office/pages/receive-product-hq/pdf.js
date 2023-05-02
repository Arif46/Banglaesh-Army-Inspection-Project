import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../tcb-report/components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, items, challanItems, challanData, vm, currentDate) => {
  function getRelationData (item) {
    const fiscalYearId = vm.$t('globalTrans.fiscal_year') + ' : ' + vm.getFiscalYear(item.fiscal_year_id)
    const allotmentCount = vm.$t('allocation_dc_office.allonment_count') + ' : ' + vm.$n(challanData.allotment_count_id)
    const warehoue = vm.$t('allocation_dc_office.warehouse_name') + ' : ' + vm.getWareName(challanData.warehouse_id)
    let str = ''
    str += fiscalYearId + '\n' + allotmentCount + '\n' + warehoue
    return str
}
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
          pdfContent.push([{ text: vm.$t('allocation_dc_office.challan_header') + '\t\t\t' + vm.$t('globalTrans.date') + ' : ' + dateFormat(vm.currentDate), style: 'td1', alignment: 'center' }])
          const allRows = [
            [
              { text: vm.$t('allocation_management.name_or_address'), style: 'td1', alignment: 'left' },
              { text: vm.$t('allocation_management.all_letter_no') + ' - ' + vm.$n(challanData.delivery_order_no, { useGrouping: false }) + '\t\t\t\t\t' + vm.$t('globalTrans.date') + ' : ' + dateFormat(challanData.distribution_date), style: 'td2', alignment: 'left' }
            ],
            [
              { text: vm.$t('allocation_dc_office.dc_office_name') + ' : ' + vm.getDistrictName(challanData.district_id), style: 'td1', alignment: 'left' },
              { text: getRelationData(challanData), style: 'td1', alignment: 'left' }
            ]
          ]
          pdfContent.push({
            table: {
              headerRows: 1,
              widths: ['50%', '50%'],
              body: allRows
            }
          })
          pdfContent.push([{ text: '', style: 'td1', alignment: 'center' }])

          const firstrow = []
            firstrow.push({ text: vm.$t('globalTrans.sl_no'), alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_management.item_name'), alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_management.item_quantity') + ' (' + vm.$t('allocation_dc_office.unit') + ')', alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_management.unit_rate'), alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_management.total_price'), alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_dc_office.commission'), alignment: 'center' })
            firstrow.push({ text: vm.$t('allocation_management.selling_amount'), alignment: 'center' })
            firstrow.push({ text: vm.$t('globalTrans.tax'), alignment: 'center' })
          const districtWiseAllotment = [
            firstrow
          ]
          challanItems.map((item, index) => {
           const looprow = []
              looprow.push({ text: vm.$n(index + 1), style: 'tablecell' })
              looprow.push({ text: vm.itemCategoryName(item.item_category_id), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.distribution_qty), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.rate), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.total_pirce), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.commission), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.selling_amount), style: 'tablecell' })
              looprow.push({ text: vm.$n(item.tax), style: 'tablecell' })
              districtWiseAllotment.push(looprow)
          })

          const secondrow = []
            secondrow.push({ text: vm.$t('globalTrans.total') + ' ' + vm.$t('globalTrans.taka'), colSpan: 4, alignment: 'right', style: 'tablecell' })
            secondrow.push({ text: ' ', style: 'tablecell' })
            secondrow.push({ text: ' ', style: 'tablecell' })
            secondrow.push({ text: ' ', style: 'tablecell' })
            secondrow.push({ text: vm.$n(vm.totalPriceSum()), style: 'tablecell' })
            secondrow.push({ text: vm.$n(vm.totalCommissionSum()), style: 'tablecell' })
            secondrow.push({ text: vm.$n(vm.totalSellingAmountSum()), style: 'tablecell' })
            secondrow.push({ text: vm.$n(vm.totalTaxSum()), style: 'tablecell' })
          districtWiseAllotment.push(secondrow)

          const thirdRow = []
            thirdRow.push({ text: vm.$t('allocation_dc_office.total_payable_amount'), colSpan: 6, alignment: 'right', style: 'tablecell' })
            thirdRow.push({ text: ' ', style: 'tablecell' })
            thirdRow.push({ text: ' ', style: 'tablecell' })
            thirdRow.push({ text: ' ', style: 'tablecell' })
            thirdRow.push({ text: ' ', style: 'tablecell' })
            thirdRow.push({ text: ' ', style: 'tablecell' })
            thirdRow.push({ text: vm.$n(vm.totalPayableAmount()), style: 'tablecell', colSpan: 2 })
            thirdRow.push({ text: ' ', style: 'tablecell' })
          districtWiseAllotment.push(thirdRow)

          const fourthRow = []
            fourthRow.push({ text: vm.$t('allocation_management.taka_in_word'), style: 'tablecell', colSpan: 2 })
            fourthRow.push({ text: ' ', style: 'tablecell' })
            fourthRow.push({ text: vm.$i18n.locale === 'bn' ? vm.convertNumberToBanglaWords(vm.totalPayableAmount()) : vm.convertNumberToEnglishWords(vm.totalPayableAmount()), colSpan: 6, alignment: 'left', style: 'tablecell' })
            fourthRow.push({ text: ' ', style: 'tablecell' })
            fourthRow.push({ text: ' ', style: 'tablecell' })
            fourthRow.push({ text: ' ', style: 'tablecell' })
            fourthRow.push({ text: ' ', style: 'tablecell' })
            districtWiseAllotment.push(fourthRow)

          const lastwidths = ['7%', '13%', '15%', '10%', '10%', '18%', '15%', '12%']
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: lastwidths,
                body: districtWiseAllotment
              }
            })

            const footerHead = [
              [
                { text: '', alignment: 'left', style: 'thb' },
                { text: '', alignment: 'left', style: 'thb' }
              ]
            ]
            footerHead.push([
              { text: vm.$t('allocation_dc_office.signature_of_storekeeper'), alignment: 'center', style: 'thh' },
              { text: vm.$t('allocation_dc_office.signature_of_dc_office'), alignment: 'center', style: 'thh' }
            ])
            pdfContent.push({
              table: {
                headerRows: 1,
                widths: ['50%', '50%'],
                body: footerHead
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

        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'Landcape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          thb: {
            margin: [0, 50, 0, 0]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [3, 3, 3, 3]
          },
          td2: {
            fontSize: (i18n.locale === 'bn') ? 12 : 9
          },
          td1: {
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
