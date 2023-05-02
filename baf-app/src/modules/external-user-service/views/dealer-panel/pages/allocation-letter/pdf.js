import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (vm, items, totalTax, allTotal) => {
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
          pdfContent.push({
            style: 'tableExampleThree',
            table: {
              headerRows: 1,
              body: [
                ['', '', { text: vm.$t('globalTrans.sl_no') + '-' + items.distribution[0].id }],
                ['', '', { text: vm.$t('allocation_management.buyer_copy') }],
                ['', '', { text: vm.$t('globalTrans.date') + '-' + items.letter_date | dateFormat }]
              ]
            },
            layout: 'noBorders'
          })
        pdfContent.push({
          style: 'tableExample',
          table: {
            headerRows: 1,
            body: [
              [{ text: '' }, { text: vm.$t('allocation_management.do_sales_header'), style: 'tableHeader' }, { text: '' }],
              ['', '', '']
            ]
          },
          layout: 'headerLineOnly'
        })
        pdfContent.push({
          style: 'tableExampleFive',
          table: {
            heights: [20, 50, 70],
            widths: ['50%', '50%'],
            body: [
              [{ text: vm.$t('allocation_management.name_or_address'), alignment: 'center' }, { text: vm.$t('allocation_management.all_letter_no') + '-' + items.allocation_letter_id + '    ' + vm.$t('globalTrans.date') + ':' + items.letter_date, alignment: 'left' }],
              [{ text: '\n' + (i18n.locale === 'bn' ? items.application.details.applicant_name_bn : items.application.details.applicant_name) + '\n' + (i18n.locale === 'bn' ? items.application.details.company_name_bn : items.application.details.company_name) + '\n' + (i18n.locale === 'bn' ? items.application.details.village_bn : items.application.details.village) + '\n' + '       ' + '\n', alignment: 'center' }, { text: vm.$t('allocation_management.bank_pay') + items.payment[0].transaction_no + '\n' + vm.$t('allocation_management.mr_no') + items.payment[0].challan_no + '\n' + vm.$t('allocation_management.bank_name') + items.payment[0].bank_name + '\n' + vm.$t('allocation_management.warehouse') + ':' + items.payment[0].branch_name + '\n' }]
            ]
          }
        })

        let Arow = [[{ text: vm.$t('globalTrans.sl_no') }, { text: vm.$t('allocation_management.item_name') }, { text: vm.$t('allocation_management.item_quantity') }, { text: vm.$t('allocation_management.unit_rate') }, { text: vm.$t('allocation_management.total_price') }, { text: vm.$t('allocation_management.selling_amount') }]]
        items.details.map((detail, index) => {
          Arow.push([{ text: vm.$n(index + 1) }, { text: vm.itemName(detail.item_id) }, { text: vm.$n(detail.quantity) }, { text: vm.$n(detail.unit_price) }, { text: vm.$n(detail.total_price) }, { text: vm.$n(detail.selling_amount) }])
        })
        Arow.push([{ text: '' }, { text: vm.$t('allocation_management.tax_diduction'), colSpan: 4, alignment: 'right' }, { text: '' }, { text: '' }, { text: '' }, { text: vm.$n(totalTax) }])
        Arow.push([{ text: '' }, { text: vm.$t('allocation_management.taka_in_word') + ' : ' + (i18n.locale === 'bn' ? vm.convertNumberToBanglaWords(allTotal) : vm.convertNumberToEnglishWords(allTotal)), colSpan: 4, alignment: 'right' }, { text: '' }, { text: '' }, { text: vm.$t('globalTrans.total') }, { text: vm.$n(allTotal) }])
        pdfContent.push({
          style: 'tableExampleFive',
          table: {
            widths: ['16%', '16%', '17%', '17%', '17%', '17%'],
            body: Arow
          }
        })
        pdfContent.push([
            { text: vm.$t('allocation_management.accept_message'), alignment: 'right', fontSize: 10, margin: [0, 10, 0, 0] }
          ])
        pdfContent.push({
          style: 'tableExampleFour',
          table: {
            widths: ['0%', '30%', '4%', '30%', '4%', '30%', '4%'],
            body: [
              [
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, true, false, false],
                  text: vm.$t('allocation_management.2nd_signature')
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, true, false, false],
                  text: vm.$t('allocation_management.head_signature')
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, true, false, false],
                  text: vm.$t('allocation_management.buyer_signature')
                },
                {
                  border: [false, false, false, false],
                  text: ''
                }
              ]
            ]
          },
          layout: {
            defaultBorder: false
          }
        })

        pdfContent.push({
          style: 'tableExampleFive',
          table: {
            widths: ['40%', '0%', '0%', '0%', '0%', '0%'],
            body: [
              [
                {
                  border: [false, false, false, true],
                  text: vm.$t('allocation_management.terms_of_supply')
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, false, false, false],
                  text: ''
                },
                {
                  border: [false, false, false, false],
                  text: ''
                }
              ]
            ]
          },
          layout: {
            defaultBorder: false
          }
        })

        pdfContent.push([
          { text: vm.$t('allocation_management.rules_one'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push([
          { text: vm.$t('allocation_management.rules_two'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push([
          { text: vm.$t('allocation_management.rules_three'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push([
          { text: vm.$t('allocation_management.rules_four'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push([
          { text: vm.$t('allocation_management.rules_five'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push([
          { text: vm.$t('allocation_management.rules_six'), alignment: 'left', fontSize: 10, margin: [0, 1, 0, 0] }
        ])
        pdfContent.push({
          style: 'tableExampleTwo',
          table: {
            headerRows: 1,
            body: [
              [{ text: '' }, { text: vm.$t('allocation_management.delivery_details'), style: 'tableHeader' }, { text: '' }],
              ['', '', '']
            ]
          },
          layout: 'headerLineOnly'
        })

        Arow = [[{ text: vm.$t('allocation_management.warehouse') + ' ' + vm.$t('globalTrans.name') }, { text: vm.$t('allocation_management.supply_date') }, { text: vm.$t('allocation_management.item_name') }, { text: vm.$t('globalTrans.quantity') }, { text: vm.$t('allocation_management.buy_sig') }, { text: vm.$t('allocation_management.warehouse_sig') }]]
        items.distribution[0].details.map((item, index) => {
          Arow.push([{ text: vm.getWareName(items.distribution[0].warehouse_id) }, { text: items.distribution[0].distribution_date }, { text: vm.itemNameCotract(item.item_id, item.contract_no_id) }, { text: item.quantity }, { text: '' }, { text: '' }])
        })
        pdfContent.push({
          style: 'tableExampleFive',
          table: {
            widths: ['16%', '16%', '17%', '17%', '17%', '17%'],
            body: Arow
          }
        })

        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
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
            bold: true,
            fontSize: 13,
            color: 'black',
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
          },
          tableExample: {
            margin: [150, -25, 0, 0],
            fontSize: 8
          },
          tableExampleTwo: {
            margin: [200, 0, 0, 0],
            fontSize: 8
          },
          tableExampleThree: {
            margin: [400, -30, 0, 0],
            fontSize: 8
          },
          tableExampleFour: {
            margin: [0, 30, 0, 0],
            fontSize: 8
          },
          tableExampleFive: {
            margin: [0, 20, 0, 0],
            fontSize: 8
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
