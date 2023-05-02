import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (vm, itemList) => {
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
            const allrows = [[{ text: vm.$t('tcb_report.daily_stock_report'), colSpan: 16, style: 'tablecellTwo' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }]]
            pdfContent.push({
              table: {
                widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
                body: allrows
              },
              layout: 'noBorders'
            })
            const allrowsTwo = [[{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }]]
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            pdfContent.push({
              table: {
                widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
                body: allrowsTwo
              },
              layout: 'noBorders'
            })
            itemList.map((item) => {
            const allrows = [[{ text: vm.$t('tcb_report.product_name'), style: 'tablecell' }, { text: (i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en), colSpan: 15, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }]]
            allrows.push([{ text: vm.$t('globalTrans.date'), rowSpan: 3, style: 'tablecell' }, { text: vm.$t('tcb_report.initial_stock_a'), rowSpan: 3, style: 'tablecell' }, { text: vm.$t('tcb_report.receive'), colSpan: 4, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.distribution'), colSpan: 6, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('stock_management.stock_out') + ' ' + vm.$t('stock_management.approved'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('stock_management.stock_out') + ' ' + vm.$t('stock_management.pending'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('stock_management.on_transport'), style: 'tablecell', rowSpan: 3 }, { text: vm.$t('tcb_report.closing_stock'), style: 'tablecell', rowSpan: 3 }])
            allrows.push([{ text: 'column', style: 'tablecell' }, { text: 'oil 500ml', style: 'tablecell' }, { text: vm.$t('tcb_report.supplier'), colSpan: 2, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.inter_warehouse'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.total_d'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.inter_warehouse'), style: 'tablecell', rowSpan: 2 }, { text: vm.$t('tcb_report.truck_sale'), colSpan: 2, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.store_allocation'), colSpan: 2, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.total_d'), rowSpan: 2, style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }])
            allrows.push([{ text: 'column', style: 'marginForUse' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.contact_no'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: vm.$t('tcb_report.number'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: vm.$t('tcb_report.number'), style: 'tablecell' }, { text: vm.$t('tcb_report.quantity'), style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }, { text: 'column', style: 'tablecell' }])
            item.contractItems.map((sinContract) => {
              allrows.push([{ text: dateFormat(sinContract.search_date), style: 'tablecell' }, { text: sinContract.report_initial_stock, style: 'tablecell' }, { text: sinContract.contractnum.contract_no, style: 'tablecell' }, { text: vm.$n(sinContract.report_recive_supplier_contract_quantity), style: 'tablecell' }, { text: vm.$n(sinContract.report_receive_inter_warehouse), style: 'tablecell' }, { text: vm.$n(sinContract.report_receive_total), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_inter_warehouse), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_truck_sale_number), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_truck_sale_quantity), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_storeallo_number), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_storeallo_quantity), style: 'tablecell' }, { text: vm.$n(sinContract.report_distribution_total), style: 'tablecell' }, { text: vm.$n(sinContract.report_stock_out_approved), style: 'tablecell' }, { text: vm.$n(sinContract.report_stock_out_pending), style: 'tablecell' }, { text: vm.$n(sinContract.report_on_transport), style: 'tablecell' }, { text: vm.$n(sinContract.report_closing_stock), style: 'tablecell' }])
            })
            pdfContent.push({
              table: {
                widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
                body: allrows
              }
            })

            const allrowsTwo = [[{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }]]
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            allrowsTwo.push([{ text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }, { text: '' }])
            pdfContent.push({
              table: {
                widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '9%', '9%', '6%', '6%'],
                body: allrowsTwo
              },
              layout: 'noBorders'
            })
          })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
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
            fontSize: 7,
            alignment: 'center'
          },
          tablecellTwo: {
            fontSize: 15,
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
