import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../e-biz-reports/pages/report-heading/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, itemList, bpcBudget, search, vm) => {
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
          allRowsHeadTwo.push(['', { text: vm.$t('eBizProposal.proposal_top_sheet'), alignment: 'center' }, ''])
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
          firstrow.push({ text: vm.$t('globalTrans.sl_no'), style: 'tablecell' })
          firstrow.push({ text: vm.$t('globalTrans.fiscal_year'), style: 'tablecell' })
          firstrow.push({ text: vm.$t('associationPanel.association'), style: 'tablecell' })
          firstrow.push({ text: vm.$t('associationPnl.proposal_no'), style: 'tablecell' })
          firstrow.push({ text: vm.$t('associationPanel.circular_no'), style: 'tablecell' })
          firstrow.push({ text: vm.$t('associationPanel.amount'), style: 'tablecell' })

          const proposalTopSheet = [
            firstrow
          ]
          const totalAmount = []
          itemList.map((item, index) => {
            const loopData = []
            loopData.push({ text: vm.$n(index + 1), style: 'tablecell' })
            loopData.push({ text: vm.getFiscalYear(item.circular.fiscal_year_id), style: 'tablecell' })
            loopData.push({ text: vm.getAssociationName(item.association_info_id), style: 'tablecell' })
            loopData.push({ text: item.proposal_id, style: 'tablecell' })
            loopData.push({ text: item.circular.circular_memo_no, style: 'tablecell' })
            loopData.push({ text: vm.$n(vm.calculateAmount(item)), style: 'tablecell' })
            proposalTopSheet.push(loopData)
            totalAmount.push({
              total_amount: vm.calculateAmount(item)
            })
          })

          const totalRow = [
            { text: vm.$t('eBizProposal.grand_total'), colSpan: 5, alignment: 'right', style: 'tablecell' },
            { },
            { },
            { },
            { },
            { text: vm.$n(totalAmount.reduce((total, item) => total + parseFloat(item.total_amount), 0)), style: 'tablecell' }
          ]
          proposalTopSheet.push(totalRow)

          const totalBudget = [
            { text: vm.$t('eBizProposal.total_council_budget'), colSpan: 5, alignment: 'right', style: 'tablecell' },
            { },
            { },
            { },
            { },
            { text: vm.$n(bpcBudget.budget_amount), style: 'tablecell' }
          ]
          proposalTopSheet.push(totalBudget)

          pdfContent.push({
            style: 'tableExample',
            table: {
              widths: ['5%', '20%', '20%', '20%', '20%', '20%'],
              body: proposalTopSheet
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
