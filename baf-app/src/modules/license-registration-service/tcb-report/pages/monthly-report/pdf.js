import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'

const exportPdfDetails = async (vm, reportData, colLength, allocationCount, distributionCount, section, truckTotal, retailTotal, dealerTotal, onlineTotal, taxTotal, monthName, itemCategoryList, distanceList) => {
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
          const thirdrow = []

          if (section === '1') {
            thirdrow.push({ text: vm.$t('tcb_report.sl_no'), rowSpan: 3, alignment: 'center' })
            thirdrow.push({ text: vm.$t('tcb_report.product_name_and_brand'), rowSpan: 3, alignment: 'center' })
            thirdrow.push({ text: vm.$t('tcb_report.tcb_regional_ofc_name'), colSpan: colLength, alignment: 'center' })
             if (colLength > 0) {
               for (let i = 0; i < colLength - 1; i++) {
                thirdrow.push({ text: '' })
               }
             }
            thirdrow.push({ text: vm.$t('tcb_report.total_a'), colSpan: 2, rowSpan: 2, alignment: 'center' })
            thirdrow.push({ text: vm.$t('tcb_report.total_a'), alignment: 'center' })
            thirdrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
            thirdrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })

            const fourthrow = []

            fourthrow.push({ text: ' ', alignment: 'center' })
            fourthrow.push({ text: 'b', alignment: 'center' })
            Object.keys(reportData[0].officeItems).map((office, index) => {
              fourthrow.push({ text: vm.getOfficeName(reportData[0].officeItems[office]), colSpan: 2, alignment: 'center' })
              fourthrow.push({ text: '', alignment: 'center' })
            })
            fourthrow.push({ text: vm.$t('tcb_report.sales_volume'), alignment: 'center' })
            fourthrow.push({ text: vm.$t('tcb_report.product_sold_price'), alignment: 'center' })
            fourthrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
            fourthrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })

            const sixthhrow = []

            sixthhrow.push({ text: ' ', alignment: 'center' })
            sixthhrow.push({ text: 'b', alignment: 'center' })
            Object.keys(reportData[0].officeItems).map((office, index) => {
              sixthhrow.push({ text: vm.$t('tcb_report.sales_volume'), alignment: 'center' })
              sixthhrow.push({ text: vm.$t('tcb_report.product_sold_price'), alignment: 'center' })
            })
            sixthhrow.push({ text: vm.$t('tcb_report.sales_volume'), alignment: 'center' })
            sixthhrow.push({ text: vm.$t('tcb_report.product_sold_price'), alignment: 'center' })
            sixthhrow.push({ text: vm.$t('tcb_report.total_no_of_days_alotted'), alignment: 'center' })
            sixthhrow.push({ text: vm.$t('tcb_report.total_no_of_truck_sell'), alignment: 'center' })
         const ProductWiseRows = [
            [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), colSpan: 6, alignment: 'center' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell', border: [false, false, false, false] }, { text: '', style: 'tablecell', border: [false, false, false, false] }],
            [{ text: vm.$t('tcb_report.cms_and_bob_branch'), colSpan: 6, alignment: 'center' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell', border: [false, false, false, false] }, { text: '', style: 'tablecell', border: [false, false, false, false] }],
            thirdrow,
            fourthrow,
            sixthhrow
          ]
          reportData.map((item, index) => {
            const fifthhrow = []
            fifthhrow.push({ text: vm.$n(index + 1), alignment: 'center' })
            fifthhrow.push({ text: vm.getItemName(item.item_id, item.contract_no_id), alignment: 'center' })
            Object.keys(item.officeItems).map((office, index) => {
              fifthhrow.push({ text: item.officeItems[office].quantity, alignment: 'center' })
              fifthhrow.push({ text: item.officeItems[office].amount, alignment: 'center' })
            })
            fifthhrow.push({ text: vm.getProductQuantity(item.officeItems), alignment: 'center' })
            fifthhrow.push({ text: vm.getProductSale(item.officeItems), alignment: 'center' })
            if (index === 0) {
              fifthhrow.push({ text: vm.$n(allocationCount), alignment: 'center' })
              fifthhrow.push({ text: vm.$n(distributionCount), alignment: 'center' })
            } else {
              fifthhrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
              fifthhrow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
            }
            ProductWiseRows.push(fifthhrow)
          })
          for (let j = 0; j < 6; j++) {
                const arow = []
                switch (j) {
                  case 0:
                    arow.push({ text: vm.$t('tcb_report.cost_of_goods_sold'), alignment: 'center' })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: '', alignment: 'center' })
                    })
                    break
                  case 1:
                    arow.push({ text: vm.$t('tcb_report.advanced_deposit_for_product_price') })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: '', alignment: 'center' })
                    })
                    break
                  case 2:
                    arow.push({ text: vm.$t('tcb_report.about_income_tax_at_source') })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: vm.$n(vm.getOfficeTax(reportData[0].officeItems[office].office_id)), alignment: 'center' })
                    })
                    break
                  case 3:
                    arow.push({ text: vm.$t('tcb_report.additional_deposits'), alignment: 'center' })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: '', alignment: 'center' })
                    })
                    break
                  case 4:
                    arow.push({ text: vm.$t('tcb_report.less_deposit_by_dealer') })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: '', alignment: 'center' })
                    })
                    break
                  case 5:
                    arow.push({ text: vm.$t('tcb_report.total') })
                    Object.keys(reportData[0].officeItems).map((office, index) => {
                      arow.push({ text: '', alignment: 'center' })
                      arow.push({ text: '', alignment: 'center' })
                    })
                    break
                }
                arow.push({ text: '', alignment: 'center' })
                arow.push({ text: '', alignment: 'center' })
                arow.push({ text: '', alignment: 'center' })
                arow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
                arow.push({ text: '', border: [false, false, false, false], alignment: 'center' })
                ProductWiseRows.push(arow)
          }
          const widths = ['12%', '12%', '12%', '12%', '12%', '12%']
          Object.keys(reportData[0].officeItems).map((office, index) => {
            widths.push('12%')
            widths.push('12%')
          })
          pdfContent.push({
            style: 'tableExample',
            table: {
              widths: widths,
              body: ProductWiseRows
            }
          })
        } else {
          let ProductWiseRows = [
            [{ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), style: 'tablecell', colSpan: 15 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
            [{ text: vm.$t('tcb_report.month_text') + monthName, style: 'tablecell', colSpan: 15 }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
            [{ text: vm.$t('tcb_report.tcb_summary'), style: 'tablecell', colSpan: 15, alignment: 'left' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
            [{ text: vm.$t('tcb_report.month_name') + monthName, style: 'tablecell', colSpan: 15, alignment: 'left' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }, { text: ' ', style: 'tablecell' }],
            [{ text: vm.$t('tcb_report.sl_no'), style: 'tablecell' }, { text: vm.$t('tcb_report.regional_and_camp_name'), style: 'tablecell' }, { text: vm.$t('tcb_report.product_selling_price_to_dealer'), style: 'tablecell' }, { text: vm.$t('tcb_report.dealer_tracksale_selling_price'), style: 'tablecell' }, { text: vm.$t('tcb_report.retail_outlet_product_total_selling_price'), style: 'tablecell' }, { text: vm.$t('tcb_report.total_selling_price _to_online_organizations'), style: 'tablecell' }, { text: vm.$t('tcb_report.total_price_of_sold_products'), style: 'tablecell' }, { text: vm.$t('tcb_report.income_tax_amount'), style: 'tablecell' }, { text: vm.$t('tcb_report.vat_amount'), style: 'tablecell' }, { text: vm.$t('tcb_report.total_amount_due'), style: 'tablecell' }, { text: vm.$t('tcb_report.money_deposit_according_to_report'), style: 'tablecell' }, { text: vm.$t('tcb_report.according_to_report_deposited_money'), style: 'tablecell' }, { text: vm.$t('tcb_report.finace_acc_total_deposit_money'), style: 'tablecell' }, { text: vm.$t('tcb_report.finace_acc_total_deposit_money_less_more'), style: 'tablecell' }, { text: vm.$t('tcb_report.comment'), style: 'tablecell' }],
            [{ text: vm.$n('1'), style: 'tablecell' }, { text: vm.$n('2'), style: 'tablecell' }, { text: vm.$n('3'), style: 'tablecell' }, { text: vm.$n('4'), style: 'tablecell' }, { text: vm.$n('5'), style: 'tablecell' }, { text: vm.$n('6'), style: 'tablecell' }, { text: vm.$n('7') + '=' + '(' + vm.$n('3') + '+' + vm.$n('4') + '+' + vm.$n('5') + vm.$n('6') + ')', style: 'tablecell' }, { text: vm.$n('8'), style: 'tablecell' }, { text: vm.$n('9'), style: 'tablecell' }, { text: vm.$n('10') + '=' + '(' + vm.$n('7') + '+' + vm.$n('8') + '+' + vm.$n('9'), style: 'tablecell' }, { text: vm.$n('11'), style: 'tablecell' }, { text: vm.$n('12') + '=' + '(' + vm.$n('11') + '+' + vm.$n('10') + ')', style: 'tablecell' }, { text: vm.$n('13'), style: 'tablecell' }, { text: vm.$n('14'), style: 'tablecell' }, { text: vm.$n('15'), style: 'tablecell' }]
          ]

          reportData.map((item, index) => {
            ProductWiseRows.push([{ text: vm.$n(index + 1), style: 'tablecell' }, { text: vm.getOfficeName(item), style: 'tablecell' }, { text: vm.$n(item.dealer_price), style: 'tablecell' }, { text: vm.$n(item.truck_seller_price), style: 'tablecell' }, { text: vm.$n(item.retail_seller_price), style: 'tablecell' }, { text: vm.$n(item.online_seller_price), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(item.tax_amount), style: 'tablecell' }, { text: vm.$n(item.vat_amount), style: 'tablecell' }, { text: vm.$n(item.tax_amount + item.vat_amount), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
          })
          ProductWiseRows.push([{ text: vm.$t('tcb_report.total'), style: 'tablecell', colSpan: 2 }, { text: vm.$n(dealerTotal), style: 'tablecell' }, { text: vm.$n(truckTotal), style: 'tablecell' }, { text: vm.$n(retailTotal), style: 'tablecell' }, { text: vm.$n(onlineTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: ['6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%', '6%'],
                body: ProductWiseRows
              }
            })
            const allRowsHeadTwo = []
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
            allRowsHeadTwo.push(['', '', ''])
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
            var allRowsTotal = []
            let i = 0
            var foo = 5
            for (let j = 0; j < itemCategoryList.length; j++) {
              if (j === 0) {
                var itemCategoryListTwo = null
                itemCategoryListTwo = itemCategoryList.slice(0, foo)
                i = 0
                itemCategoryListTwo.map((item, index) => {
                  i = i + 3
                })
                reportData.map((office, index) => {
                  const allRowsHeadTwo = []
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
                  const firstrow = []
                  firstrow.push({ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), style: 'tablecell', colSpan: 4 + i })
                  firstrow.push({ text: ' ', style: 'tablecell' })
                  firstrow.push({ text: 'b', style: 'tablecell' })
                  firstrow.push({ text: ' ', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    firstrow.push({ text: ' ', style: 'tablecell' })
                    firstrow.push({ text: 'b', style: 'tablecell' })
                    firstrow.push({ text: ' ', style: 'tablecell' })
                  })
                  const secondrow = []
                  secondrow.push({ text: vm.$t('tcb_report.month_text') + ' ' + monthName, style: 'tablecell', colSpan: 4 + i })
                  secondrow.push({ text: ' ', style: 'tablecell' })
                  secondrow.push({ text: 'b', style: 'tablecell' })
                  secondrow.push({ text: ' ', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    secondrow.push({ text: ' ', style: 'tablecell' })
                    secondrow.push({ text: 'b', style: 'tablecell' })
                    secondrow.push({ text: ' ', style: 'tablecell' })
                  })
                  const thirdrow = []
                  thirdrow.push({ text: vm.$t('tcb_report.sl_no') + ' ' + vm.$n(index + 1), style: 'tablecell', rowSpan: 16 })
                  thirdrow.push({ text: vm.$t('tcb_report.regional_office'), style: 'tablecell', rowSpan: 2 })
                  thirdrow.push({ text: vm.$t('tcb_report.selling_medium'), style: 'tablecell', rowSpan: 2 })
                  thirdrow.push({ text: vm.$t('tcb_report.distance'), style: 'tablecell', rowSpan: 2 })
                  itemCategoryListTwo.map((item, index) => {
                    thirdrow.push({ text: item.text, colSpan: 3, style: 'tablecell' })
                    thirdrow.push({ text: ' ', style: 'tablecell' })
                    thirdrow.push({ text: 'b', style: 'tablecell' })
                  })
                  const fourthrow = []
                  fourthrow.push({ text: 'm', style: 'tablecell' })
                  fourthrow.push({ text: ' ', style: 'tablecell' })
                  fourthrow.push({ text: 'b', style: 'tablecell' })
                  fourthrow.push({ text: '', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    fourthrow.push({ text: vm.$t('tcb_report.quantity'), style: 'tablecell' })
                    fourthrow.push({ text: vm.$t('tcb_report.price'), style: 'tablecell' })
                    fourthrow.push({ text: vm.$t('tcb_report.avg_price'), style: 'tablecell' })
                  })
                ProductWiseRows = [
                  firstrow,
                  secondrow,
                  thirdrow,
                  fourthrow
                ]
                const fifthrow = []
                fifthrow.push({ text: 'm', style: 'tablecell' })
                fifthrow.push({ text: vm.getOfficeName(office), style: 'tablecell', rowSpan: 14 })
                fifthrow.push({ text: vm.$t('tcb_report.sales_center'), style: 'tablecell' })
                fifthrow.push({ text: ' ', style: 'tablecell' })
                itemCategoryListTwo.map((item, index) => {
                  fifthrow.push({ text: '', style: 'tablecell' })
                  fifthrow.push({ text: '', style: 'tablecell' })
                  fifthrow.push({ text: '', style: 'tablecell' })
                })

                ProductWiseRows.push(fifthrow)
                distanceList.map((distance, index) => {
                  const sixthbigrow = []
                  sixthbigrow.push({ text: 'm', style: 'tablecell' })
                  sixthbigrow.push({ text: ' ', style: 'tablecell' })
                  sixthbigrow.push({ text: vm.$t('tcb_report.dealer_allocation'), style: 'tablecell', rowSpan: 3 })
                  sixthbigrow.push({ text: vm.getDistance(distance), style: 'tablecell' })
                  itemCategoryListTwo.map((itemcategry, index) => {
                    sixthbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                    sixthbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                    sixthbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                  })
                  ProductWiseRows.push(sixthbigrow)
                })

               const sixthbigrowtotal = []

                sixthbigrowtotal.push({ text: 'm', style: 'tablecell' })
                sixthbigrowtotal.push({ text: ' ', style: 'tablecell' })
                sixthbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                sixthbigrowtotal.push({ text: '', style: 'tablecell' })
                itemCategoryListTwo.map((item, index) => {
                  sixthbigrowtotal.push({ text: vm.$n(0), style: 'tablecell' })
                  sixthbigrowtotal.push({ text: vm.$n(0), style: 'tablecell' })
                  sixthbigrowtotal.push({ text: '', style: 'tablecell' })
                })

                ProductWiseRows.push(sixthbigrowtotal)

                distanceList.map((distance, index) => {
                  const seventhbigrow = []
                  seventhbigrow.push({ text: 'm', style: 'tablecell' })
                  seventhbigrow.push({ text: ' ', style: 'tablecell' })
                  seventhbigrow.push({ text: vm.$t('tcb_report.allotment_of_truck_sells'), style: 'tablecell', rowSpan: 3 })
                  seventhbigrow.push({ text: vm.getDistance(distance), style: 'tablecell' })
                  itemCategoryListTwo.map((itemcategry, index) => {
                    seventhbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                    seventhbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                    seventhbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                  })
                  ProductWiseRows.push(seventhbigrow)
                })

               const seventhbigrowtotal = []

                seventhbigrowtotal.push({ text: 'm', style: 'tablecell' })
                seventhbigrowtotal.push({ text: ' ', style: 'tablecell' })
                seventhbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                seventhbigrowtotal.push({ text: '', style: 'tablecell' })
                itemCategoryListTwo.map((itemcategry, index) => {
                  seventhbigrowtotal.push({ text: vm.$n(vm.getTotalItemQuantity(office.office_id, itemcategry)), style: 'tablecell' })
                  seventhbigrowtotal.push({ text: vm.$n(vm.getTotalItemPrice(office.office_id, itemcategry)), style: 'tablecell' })
                  seventhbigrowtotal.push({ text: '', style: 'tablecell' })
                })

                ProductWiseRows.push(seventhbigrowtotal)

                distanceList.map((distance, index) => {
                  const eighthbigrow = []
                  eighthbigrow.push({ text: 'm', style: 'tablecell' })
                  eighthbigrow.push({ text: ' ', style: 'tablecell' })
                  eighthbigrow.push({ text: vm.$t('tcb_report.online_allocation'), style: 'tablecell', rowSpan: 3 })
                  eighthbigrow.push({ text: '0-100', style: 'tablecell' })
                  itemCategoryListTwo.map((itemcategry, index) => {
                    eighthbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                    eighthbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                    eighthbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                  })
                  ProductWiseRows.push(eighthbigrow)
                })

               const eighthbigrowtotal = []

                eighthbigrowtotal.push({ text: 'm', style: 'tablecell' })
                eighthbigrowtotal.push({ text: ' ', style: 'tablecell' })
                eighthbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                eighthbigrowtotal.push({ text: '', style: 'tablecell' })
                itemCategoryListTwo.map((itemcategry, index) => {
                  eighthbigrowtotal.push({ text: vm.$n(vm.getTotalItemQuantity(office.office_id, itemcategry)), style: 'tablecell' })
                  eighthbigrowtotal.push({ text: vm.$n(vm.getTotalItemPrice(office.office_id, itemcategry)), style: 'tablecell' })
                  eighthbigrowtotal.push({ text: '', style: 'tablecell' })
                })

                ProductWiseRows.push(eighthbigrowtotal)

                const lasttotalrow = []

                lasttotalrow.push({ text: 'm', style: 'tablecell' })
                lasttotalrow.push({ text: ' ', style: 'tablecell' })
                lasttotalrow.push({ text: 'm', style: 'tablecell' })
                lasttotalrow.push({ text: ' ', style: 'tablecell' })
                itemCategoryListTwo.map((item, index) => {
                  lasttotalrow.push({ text: '', style: 'tablecell', colSpan: 3 })
                  lasttotalrow.push({ text: '', style: 'tablecell' })
                  lasttotalrow.push({ text: '', style: 'tablecell' })
                })
                lasttotalrow.splice(lasttotalrow.length - 3, 3)
                lasttotalrow.push({ text: vm.$t('tcb_report.total_taka'), style: 'tablecell', colSpan: 2 })
                lasttotalrow.push({ text: ' ', style: 'tablecell' })
                lasttotalrow.push({ text: vm.$n(vm.getTotalFinal(office.office_id)), style: 'tablecell' })

                ProductWiseRows.push(lasttotalrow)

                const widths = ['5%', '5%', '5%', '5%']

                itemCategoryListTwo.map((item, index) => {
                  widths.push('5%')
                  widths.push('5%')
                  widths.push('5%')
                })

                allRowsTotal.push({
                  index: index,
                  style: 'tableExample',
                  table: {
                    widths: widths,
                    body: ProductWiseRows
                  }
                })

                // reportData.map((item, index) => {
                //   ProductWiseRows.push([{ text: vm.$n(index + 1), style: 'tablecell' }, { text: vm.getOfficeName(item), style: 'tablecell' }, { text: vm.$n(item.dealer_price), style: 'tablecell' }, { text: vm.$n(item.truck_seller_price), style: 'tablecell' }, { text: vm.$n(item.retail_seller_price), style: 'tablecell' }, { text: vm.$n(item.online_seller_price), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(item.tax_amount), style: 'tablecell' }, { text: vm.$n(item.vat_amount), style: 'tablecell' }, { text: vm.$n(item.tax_amount + item.vat_amount), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
                // })
                // ProductWiseRows.push([{ text: vm.$t('tcb_report.total'), style: 'tablecell', colSpan: 2 }, { text: vm.$n(dealerTotal), style: 'tablecell' }, { text: vm.$n(truckTotal), style: 'tablecell' }, { text: vm.$n(retailTotal), style: 'tablecell' }, { text: vm.$n(onlineTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
                // pdfContent.push({
                //     style: 'tableExample',
                //     table: {
                //       widths: widths,
                //       body: ProductWiseRows
                //     }
                //   })
                })
              }
              if (j % 5 === 0) {
                itemCategoryListTwo = itemCategoryList.slice(foo, foo + 5)
                foo = foo + 5
                if (itemCategoryListTwo.length > 0) {
                  i = 0
                  itemCategoryListTwo.map((item, index) => {
                    i = i + 3
                  })
                  reportData.map((office, index) => {
                    const allRowsHeadTwo = []
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
                    const firstrow = []
                    firstrow.push({ text: vm.$t('tcb_report.trading_corporation_of_bangladesh'), style: 'tablecell', colSpan: 4 + i })
                    firstrow.push({ text: ' ', style: 'tablecell' })
                    firstrow.push({ text: 'b', style: 'tablecell' })
                    firstrow.push({ text: ' ', style: 'tablecell' })
                    itemCategoryListTwo.map((item, index) => {
                      firstrow.push({ text: ' ', style: 'tablecell' })
                      firstrow.push({ text: 'b', style: 'tablecell' })
                      firstrow.push({ text: ' ', style: 'tablecell' })
                    })
                    const secondrow = []
                    secondrow.push({ text: vm.$t('tcb_report.month_text') + ' ' + monthName, style: 'tablecell', colSpan: 4 + i })
                    secondrow.push({ text: ' ', style: 'tablecell' })
                    secondrow.push({ text: 'b', style: 'tablecell' })
                    secondrow.push({ text: ' ', style: 'tablecell' })
                    itemCategoryListTwo.map((item, index) => {
                      secondrow.push({ text: ' ', style: 'tablecell' })
                      secondrow.push({ text: 'b', style: 'tablecell' })
                      secondrow.push({ text: ' ', style: 'tablecell' })
                    })
                    const thirdrow = []
                    thirdrow.push({ text: vm.$t('tcb_report.sl_no') + ' ' + vm.$n(index + 1), style: 'tablecell', rowSpan: 16 })
                    thirdrow.push({ text: vm.$t('tcb_report.regional_office'), style: 'tablecell', rowSpan: 2 })
                    thirdrow.push({ text: vm.$t('tcb_report.selling_medium'), style: 'tablecell', rowSpan: 2 })
                    thirdrow.push({ text: vm.$t('tcb_report.distance'), style: 'tablecell', rowSpan: 2 })
                    itemCategoryListTwo.map((item, index) => {
                      thirdrow.push({ text: item.text, colSpan: 3, style: 'tablecell' })
                      thirdrow.push({ text: ' ', style: 'tablecell' })
                      thirdrow.push({ text: 'b', style: 'tablecell' })
                    })
                    const fourthrow = []
                    fourthrow.push({ text: 'm', style: 'tablecell' })
                    fourthrow.push({ text: ' ', style: 'tablecell' })
                    fourthrow.push({ text: 'b', style: 'tablecell' })
                    fourthrow.push({ text: '', style: 'tablecell' })
                    itemCategoryListTwo.map((item, index) => {
                      fourthrow.push({ text: vm.$t('tcb_report.quantity'), style: 'tablecell' })
                      fourthrow.push({ text: vm.$t('tcb_report.price'), style: 'tablecell' })
                      fourthrow.push({ text: vm.$t('tcb_report.avg_price'), style: 'tablecell' })
                    })
                  ProductWiseRows = [
                    firstrow,
                    secondrow,
                    thirdrow,
                    fourthrow
                  ]
                  const fifthrow = []
                  fifthrow.push({ text: 'm', style: 'tablecell' })
                  fifthrow.push({ text: vm.getOfficeName(office), style: 'tablecell', rowSpan: 14 })
                  fifthrow.push({ text: vm.$t('tcb_report.sales_center'), style: 'tablecell' })
                  fifthrow.push({ text: ' ', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    fifthrow.push({ text: '', style: 'tablecell' })
                    fifthrow.push({ text: '', style: 'tablecell' })
                    fifthrow.push({ text: '', style: 'tablecell' })
                  })

                  ProductWiseRows.push(fifthrow)
                  distanceList.map((distance, index) => {
                    const sixthbigrow = []
                    sixthbigrow.push({ text: 'm', style: 'tablecell' })
                    sixthbigrow.push({ text: ' ', style: 'tablecell' })
                    sixthbigrow.push({ text: vm.$t('tcb_report.dealer_allocation'), style: 'tablecell', rowSpan: 3 })
                    sixthbigrow.push({ text: vm.getDistance(distance), style: 'tablecell' })
                    itemCategoryListTwo.map((itemcategry, index) => {
                      sixthbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                      sixthbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                      sixthbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 2)), style: 'tablecell' })
                    })
                    ProductWiseRows.push(sixthbigrow)
                  })

                 const sixthbigrowtotal = []

                  sixthbigrowtotal.push({ text: 'm', style: 'tablecell' })
                  sixthbigrowtotal.push({ text: ' ', style: 'tablecell' })
                  sixthbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                  sixthbigrowtotal.push({ text: '', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    sixthbigrowtotal.push({ text: vm.$n(0), style: 'tablecell' })
                    sixthbigrowtotal.push({ text: vm.$n(0), style: 'tablecell' })
                    sixthbigrowtotal.push({ text: '', style: 'tablecell' })
                  })

                  ProductWiseRows.push(sixthbigrowtotal)

                  distanceList.map((distance, index) => {
                    const seventhbigrow = []
                    seventhbigrow.push({ text: 'm', style: 'tablecell' })
                    seventhbigrow.push({ text: ' ', style: 'tablecell' })
                    seventhbigrow.push({ text: vm.$t('tcb_report.allotment_of_truck_sells'), style: 'tablecell', rowSpan: 3 })
                    seventhbigrow.push({ text: vm.getDistance(distance), style: 'tablecell' })
                    itemCategoryListTwo.map((itemcategry, index) => {
                      seventhbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                      seventhbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                      seventhbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 1)), style: 'tablecell' })
                    })
                    ProductWiseRows.push(seventhbigrow)
                  })

                 const seventhbigrowtotal = []

                  seventhbigrowtotal.push({ text: 'm', style: 'tablecell' })
                  seventhbigrowtotal.push({ text: ' ', style: 'tablecell' })
                  seventhbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                  seventhbigrowtotal.push({ text: '', style: 'tablecell' })
                  itemCategoryListTwo.map((itemcategry, index) => {
                    seventhbigrowtotal.push({ text: vm.$n(vm.getTotalItemQuantity(office.office_id, itemcategry)), style: 'tablecell' })
                    seventhbigrowtotal.push({ text: vm.$n(vm.getTotalItemPrice(office.office_id, itemcategry)), style: 'tablecell' })
                    seventhbigrowtotal.push({ text: '', style: 'tablecell' })
                  })

                  ProductWiseRows.push(seventhbigrowtotal)

                  distanceList.map((distance, index) => {
                    const eighthbigrow = []
                    eighthbigrow.push({ text: 'm', style: 'tablecell' })
                    eighthbigrow.push({ text: ' ', style: 'tablecell' })
                    eighthbigrow.push({ text: vm.$t('tcb_report.online_allocation'), style: 'tablecell', rowSpan: 3 })
                    eighthbigrow.push({ text: '0-100', style: 'tablecell' })
                    itemCategoryListTwo.map((itemcategry, index) => {
                      eighthbigrow.push({ text: vm.$n(vm.getItemQuantity(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                      eighthbigrow.push({ text: vm.$n(vm.getItemPrice(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                      eighthbigrow.push({ text: vm.$n(vm.getItemAvgPrice(office.office_id, itemcategry, distance.value, 3)), style: 'tablecell' })
                    })
                    ProductWiseRows.push(eighthbigrow)
                  })

                 const eighthbigrowtotal = []

                  eighthbigrowtotal.push({ text: 'm', style: 'tablecell' })
                  eighthbigrowtotal.push({ text: ' ', style: 'tablecell' })
                  eighthbigrowtotal.push({ text: vm.$t('tcb_report.total_d'), style: 'tablecell' })
                  eighthbigrowtotal.push({ text: '', style: 'tablecell' })
                  itemCategoryListTwo.map((itemcategry, index) => {
                    eighthbigrowtotal.push({ text: vm.$n(vm.getTotalItemQuantity(office.office_id, itemcategry)), style: 'tablecell' })
                    eighthbigrowtotal.push({ text: vm.$n(vm.getTotalItemPrice(office.office_id, itemcategry)), style: 'tablecell' })
                    eighthbigrowtotal.push({ text: '', style: 'tablecell' })
                  })

                  ProductWiseRows.push(eighthbigrowtotal)

                  const lasttotalrow = []

                  lasttotalrow.push({ text: 'm', style: 'tablecell' })
                  lasttotalrow.push({ text: ' ', style: 'tablecell' })
                  lasttotalrow.push({ text: 'm', style: 'tablecell' })
                  lasttotalrow.push({ text: ' ', style: 'tablecell' })
                  itemCategoryListTwo.map((item, index) => {
                    lasttotalrow.push({ text: '', style: 'tablecell', colSpan: 3 })
                    lasttotalrow.push({ text: '', style: 'tablecell' })
                    lasttotalrow.push({ text: '', style: 'tablecell' })
                  })
                  lasttotalrow.splice(lasttotalrow.length - 3, 3)
                  lasttotalrow.push({ text: vm.$t('tcb_report.total_taka'), style: 'tablecell', colSpan: 2 })
                  lasttotalrow.push({ text: ' ', style: 'tablecell' })
                  lasttotalrow.push({ text: vm.$n(vm.getTotalFinal(office.office_id)), style: 'tablecell' })

                  ProductWiseRows.push(lasttotalrow)

                  const widths = ['5%', '5%', '5%', '5%']

                  itemCategoryListTwo.map((item, index) => {
                    widths.push('5%')
                    widths.push('5%')
                    widths.push('5%')
                  })

                  allRowsTotal.push({
                    index: index,
                    style: 'tableExample',
                    table: {
                      widths: widths,
                      body: ProductWiseRows
                    }
                  })

                  // reportData.map((item, index) => {
                  //   ProductWiseRows.push([{ text: vm.$n(index + 1), style: 'tablecell' }, { text: vm.getOfficeName(item), style: 'tablecell' }, { text: vm.$n(item.dealer_price), style: 'tablecell' }, { text: vm.$n(item.truck_seller_price), style: 'tablecell' }, { text: vm.$n(item.retail_seller_price), style: 'tablecell' }, { text: vm.$n(item.online_seller_price), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(item.tax_amount), style: 'tablecell' }, { text: vm.$n(item.vat_amount), style: 'tablecell' }, { text: vm.$n(item.tax_amount + item.vat_amount), style: 'tablecell' }, { text: vm.$n(vm.getTotalPrice(item)), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
                  // })
                  // ProductWiseRows.push([{ text: vm.$t('tcb_report.total'), style: 'tablecell', colSpan: 2 }, { text: vm.$n(dealerTotal), style: 'tablecell' }, { text: vm.$n(truckTotal), style: 'tablecell' }, { text: vm.$n(retailTotal), style: 'tablecell' }, { text: vm.$n(onlineTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(taxTotal), style: 'tablecell' }, { text: vm.$n(dealerTotal + truckTotal + retailTotal + onlineTotal), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }, { text: vm.$n(0), style: 'tablecell' }])
                    // pdfContent.push({
                    //   style: 'tableExample',
                    //   table: {
                    //     widths: widths,
                    //     body: ProductWiseRows
                    //   }
                    // })
                  })
                }
              }
            }
        }
        // reportData[0].officeItems.map((office, index) => {
        //   thirdrow.push({ text: vm.$t('tcb_report.sales_volume'), style: 'tablecell' })
        //   thirdrow.push({ text: vm.$t('tcb_report.product_sold_price'), style: 'tablecell' })
        // })

        const allRowsHeadThree = []
        allRowsHeadThree.push(['', '', ''])
        allRowsHeadThree.push(['', '', ''])
        allRowsHeadThree.push(['', '', ''])
        allRowsHeadThree.push(['', '', ''])
        allRowsHeadThree.push(['', '', ''])
        pdfContent.push({
          table: {
            widths: ['20%', '60%', '20%'],
            body: allRowsHeadThree
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

       const allRowsTotalTwo = allRowsTotal.reduce(function (r, a) {
          r[a.index] = r[a.index] || []
          r[a.index].push(a)
          return r
      }, Object.create(null))
      try {
        Object.keys(allRowsTotalTwo).map((item, indexone) => {
          allRowsTotalTwo[item].map((element, index) => {
            const allRowsHeadThree = []
            allRowsHeadThree.push(['', '', ''])
            allRowsHeadThree.push(['', '', ''])
            allRowsHeadThree.push(['', '', ''])
            allRowsHeadThree.push(['', '', ''])
            allRowsHeadThree.push(['', '', ''])
            pdfContent.push({
              table: {
                widths: ['20%', '60%', '20%'],
                body: allRowsHeadThree
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
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: element.table.widths,
                body: element.table.body
              }
            })
            const allRowsHeadTwo = []
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
        })
      })
      } catch (e) {
      }

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
            alignment: 'center',
            fontSize: 7
          },
          tablecellbold: {
            alignment: 'center',
            fontSize: 7,
            bold: true
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
