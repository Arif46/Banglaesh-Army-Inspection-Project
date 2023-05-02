import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdf'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, itemList, proItemList, search, vm) => {
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
              { text: vm.$t('organogram.regional_office_name') + ' : ' + vm.getOfficeName(search.regional_office), alignment: 'left', style: 'thh' },
              { text: vm.$t('tcb_report.report_type') + ' : ' + vm.getReportTypeName(search.report_type).text, alignment: 'left', style: 'thh' },
              { text: '' + '' + '', alignment: 'left', style: 'thh' }
            ]
          ]
          allRowsHead1.push([
            { text: vm.$t('globalTrans.fiscal_year') + ' : ' + vm.getFiscalYear(search.fiscal_year_id), alignment: 'left', style: 'thh' },
            { text: vm.$t('tcb_report.month') + ' : ' + vm.getMonthName(search.bn_month), alignment: 'left', style: 'thh' },
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
         var widthone = ['12%', '12%', '12%', '12%', '12%', '12%', '12%']
          const firstrow = []
          firstrow.push({ text: vm.$t('tcb_report.allocation_report'), colSpan: 7, style: 'tablecell' })
          firstrow.push({ text: '', style: 'tablecell' })
          firstrow.push({ text: '', style: 'tablecell' })
          firstrow.push({ text: '', style: 'tablecell' })
          firstrow.push({ text: '', style: 'tablecell' })
          proItemList.map((item) => {
            firstrow.push({ text: (i18n.locale === 'bn' ? item.item_name_en : item.item_name_bn) })
          })
          firstrow.push({ text: '', style: 'tablecell' })
          firstrow.push({ text: '', style: 'tablecell' })
          const secondrow = []
          secondrow.push({ text: vm.$t('globalTrans.sl_no'), style: 'tablecell' })
          secondrow.push({ text: vm.$t('globalTrans.date'), style: 'tablecell' })
          secondrow.push({ text: vm.$t('tcb_report.company_name'), style: 'tablecell' })
          secondrow.push({ text: vm.$t('tcb_report.truck_no'), style: 'tablecell' })
          secondrow.push({ text: vm.$t('tcb_report.d_o_no'), style: 'tablecell' })
          proItemList.map((item) => {
            secondrow.push({ text: (i18n.locale === 'bn' ? item.item_name_en : item.item_name_bn), style: 'tablecell' })
            widthone.push('12%')
          })
          secondrow.push({ text: vm.$t('tcb_report.total_taka'), style: 'tablecell' })
          secondrow.push({ text: vm.$t('tcb_report.comment'), style: 'tablecell' })
          const AllocationReport = [
            firstrow,
            secondrow
          ]
          itemList.map((item, index) => {
            const looprow = []
            looprow.push({ text: vm.$n(index + 1), style: 'tablecell' })
            looprow.push({ text: dateFormat(item.letter_date), style: 'tablecell' })
            looprow.push({ text: i18n.locale === 'bn' ? item.company_name : item.company_name_bn, style: 'tablecell' })
            looprow.push({ text: '---', style: 'tablecell' })
            looprow.push({ text: item.do_no, style: 'tablecell' })
            item.itemArr.map((element) => {
              looprow.push({ text: element, style: 'tablecell' })
            })
            looprow.push({ text: item.item_total_amt, style: 'tablecell' })
            looprow.push({ text: '---', style: 'tablecell' })
              AllocationReport.push(looprow)
            })
            pdfContent.push({
              style: 'tableExample',
              table: {
                widths: ['12%', '12%', '12%', '12%', '12%', '12%', '12%', '12%', '12%'],
                body: AllocationReport
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
