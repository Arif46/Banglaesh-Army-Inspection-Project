import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      if (i18n.locale === 'bn') {
        pdfMake.vfs = pdfFontsBn.pdfMake.vfs
      } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
      }
      const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
      const pdfContent = [{
            columns: reportHeadData.reportHeadColumn
        },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      pdfContent.push({ text: '', style: 'fertilizer' })
      const detailsData = vm.viewData
      const rows = [
        [
          { text: vm.$t('globalTrans.fiscal_year'), style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(i18n.locale === 'bn' ? detailsData.fiscal_year_bn : detailsData.fiscal_year_en), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '2%', '83%'],
          body: rows
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
      const row1 = [
        [
          { text: vm.$t('exhibitCircularManagement.circular_memo'), style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: detailsData.circular_memo_number, style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '2%', '83%'],
          body: row1
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
      const row2 = [
        [
          { text: vm.$t('exhibitCircularManagement.subject'), style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(i18n.locale === 'bn' ? detailsData.subject_bn : detailsData.subject_en), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '2%', '83%'],
          body: row2
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
      const row3 = [
        [
          { text: vm.$t('globalTrans.description'), style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: vm.$t(i18n.locale === 'bn' ? detailsData.description_bn : detailsData.description_en), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '2%', '83%'],
          body: row3
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
      const row4 = [
        [
          { text: vm.$t('tradeFairInfoManagement.submission_deadline'), style: 'tdCustom3', alignment: 'left' },
          { text: ' : ', style: 'tdCustom3', alignment: 'left' },
          { text: dateFormat(detailsData.submission_deadline), style: 'tdCustom3', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['15%', '2%', '83%'],
          body: row4
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
      if (detailsData.status === 3 || detailsData.status === 5) {
        const row5 = [
          [
            { text: vm.$t('tradeFairInfoManagement.approve_message'), style: 'tdCustom3', alignment: 'left' },
            { text: ' : ', style: 'tdCustom3', alignment: 'left' },
            { text: detailsData.comment_en, style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['15%', '2%', '83%'],
            body: row5
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
      if (detailsData.status === 5) {
        const row6 = [
          [
            { text: vm.$t('globalTrans.status'), style: 'tdCustom3', alignment: 'left' },
            { text: ' : ', style: 'tdCustom3', alignment: 'left' },
            { text: vm.$t('globalTrans.publish'), style: 'tdCustom3', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['15%', '2%', '83%'],
            body: row6
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
      if (detailsData.forwards.length > 0) {
        pdfContent.push({ text: '', style: 'fertilizer' })
        const row5 = [
          [
            { text: vm.$t('research_plan_management.received_history'), style: 'tdCustom3', alignment: 'left', bold: true }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['100%'],
            body: row5
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
        const allRow2 = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.sender'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.receiver'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.status'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.comments'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        detailsData.forwards.forEach((item, index) => {
          let status = ''
          if (item.status === 1) {
            status = vm.$t('globalTrans.pending')
          } else if (item.status === 2) {
            status = vm.$t('globalTrans.forward')
          } else if (item.status === 3) {
            status = vm.$t('globalTrans.approved')
          } else if (item.status === 4) {
            status = vm.$t('globalTrans.return')
          } else {
            status = vm.$t('globalTrans.publish')
          }
          allRow2.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: vm.$t(i18n.locale === 'bn' ? item.sender_name_bn : item.sender_name_en), alignment: 'center', style: 'td' },
            { text: vm.$t(i18n.locale === 'bn' ? item.receiver_name_bn : item.receiver_name_en), alignment: 'center', style: 'td' },
            { text: status, alignment: 'center', style: 'td' },
            { text: item.comment_en, alignment: 'center', style: 'td' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['10%', '18%', '18%', '18%', '36%'],
            body: allRow2
          }
        })
      }
      var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [3, 3, 3, 3]
          },
          fertilizer: {
            margin: [5, 0, 0, 5]
          },
          header: {
              fontSize: 16,
              bold: true,
              margin: [0, 0, 0, 0]
          },
          org: {
              fontSize: 13,
              bold: true,
              margin: [0, -25, 10, 5]
          },
          address: {
              fontSize: 11,
              margin: [0, 0, 0, 5]
          },
          tdCustom3: {
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [0, 5, 0, 0]
          },
          hh: {
              fontSize: 13,
              bold: true,
              margin: [10, 10, 25, 20]
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
