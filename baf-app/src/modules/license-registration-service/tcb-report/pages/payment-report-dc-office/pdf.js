import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../components/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, monthlyReport, vm, initialStock, search, proItemList, itemList) => {
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

          if (proItemList.length > 0) {
            const firstrow = []
            const secondrow = []
            var widthsTwo = []
            const thirdrow = [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), colSpan: 10 + (proItemList.length * 2), style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3']
            const fourthrow = [{ text: vm.$t('tcb_report.payment_report'), colSpan: 10 + (proItemList.length * 2), style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3']
            const len = 100 / (10 + proItemList.length + 2)
            const length = `${len}%`
            for (let i = 0; i < 10; i++) {
              widthsTwo.push(length)
            }
            firstrow.push({ text: vm.$t('globalTrans.sl_no'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('globalTrans.date'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.d_o_no'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.institute_name'), style: 'tablecell', rowSpan: 2 })
            proItemList.map((item) => {
              firstrow.push({ text: (i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en), style: 'tablecell', colSpan: 2 })
              firstrow.push({ text: 'coulmn', style: 'tablecell' })
              widthsTwo.push(length)
              widthsTwo.push(length)
            })
            firstrow.push({ text: vm.$t('tcb_report.product_price'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.selling_amount'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.income_tax'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.total_price'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.money_receipt'), style: 'tablecell', rowSpan: 2 })
            firstrow.push({ text: vm.$t('tcb_report.deposit_date'), style: 'tablecell', rowSpan: 2 })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            proItemList.map((item) => {
              secondrow.push({ text: vm.$t('tcb_report.quantity'), style: 'tablecell' })
              secondrow.push({ text: vm.$t('tcb_report.price_a'), style: 'tablecell' })
              thirdrow.push({ text: 'coulmn', style: 'tablecell' })
              thirdrow.push({ text: 'coulmn', style: 'tablecell' })
              fourthrow.push({ text: 'coulmn', style: 'tablecell' })
              fourthrow.push({ text: 'coulmn', style: 'tablecell' })
            })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            secondrow.push({ text: 'coulmn', style: 'tablecell' })
            const ProductWiseRowsTwo = [
              thirdrow,
              fourthrow,
              firstrow,
              secondrow
            ]
            // if (itemList.length > 0) {
              itemList.map((item, index) => {
                const ProductWiseRowsThree = []
                // const ProductWiseRowsThreeContainer = [ProductWiseRowsThree]
                ProductWiseRowsThree.push({ text: vm.$n(index + 1), style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.letter_date, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.do_no, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.company_name, style: 'tablecell' })
                item.itemArr.map((element) => {
                  ProductWiseRowsThree.push({ text: element, style: 'tablecell' })
                })
                ProductWiseRowsThree.push({ text: item.total_price, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.selling_amount, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.tax_amount, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: vm.$n(item.selling_amount + item.tax_amount), style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.transaction_no, style: 'tablecell' })
                ProductWiseRowsThree.push({ text: item.pay_date, style: 'tablecell' })
                //  pdfContent.push({
                //    style: 'tableExample',
                //    table: {
                //      widths: widthsTwo,
                //      body: ProductWiseRowsThreeContainer
                //    }
                //  })
                ProductWiseRowsTwo.push(ProductWiseRowsThree)
              })
            // }
              pdfContent.push({
                style: 'tableExample',
                table: {
                  widths: widthsTwo,
                  body: ProductWiseRowsTwo
                }
              })
          } else {
            const ProductWiseRows = [
              [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), colSpan: 10, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
              [{ text: vm.$t('tcb_report.payment_report'), colSpan: 10, style: 'tablecell' }, 'Column 2', 'Column 3', 'Column 1', 'Column 2', 'Column 3', 'Column 3', 'Column 1', 'Column 2', 'Column 3'],
              [{ text: vm.$t('globalTrans.sl_no'), style: 'tablecell' }, { text: vm.$t('globalTrans.date'), style: 'tablecell' }, { text: vm.$t('tcb_report.early'), style: 'tablecell' }, { text: vm.$t('tcb_report.receive'), style: 'tablecell' }, { text: vm.$t('tcb_report.supply'), style: 'tablecell' }, { text: vm.$t('tcb_report.conclusion'), style: 'tablecell' }, { text: vm.$t('tcb_report.early'), style: 'tablecell' }, { text: vm.$t('tcb_report.receive'), style: 'tablecell' }, { text: vm.$t('tcb_report.supply'), style: 'tablecell' }, { text: vm.$t('tcb_report.conclusion'), style: 'tablecell' }]
            ]
            const widths = []
            for (let i = 0; i < 10; i++) {
              widths.push('*')
            }
              pdfContent.push({
                style: 'tableExample',
                table: {
                  widths: widths,
                  body: ProductWiseRows
                }
              })
        }
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
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
            fontSize: 6,
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
