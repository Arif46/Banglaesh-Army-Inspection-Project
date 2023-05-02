import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, newDatas, vm, search) => {
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
      const pdfContent = [
          {
            columns: reportHeadData.reportHeadColumn, style: 'main_head'
          },
          { text: reportHeadData.address, style: 'address', alignment: 'center' }
        ]
        pdfContent.push({ text: reportTitle, style: 'header2', alignment: 'center', decoration: 'underline' })
        pdfContent.push({ text: '', style: 'fertilizer' })
        const allRowsHead = []
        if (search.org_name) {
          const rowItem = [
            { text: vm.$t('warehouse_config.organization'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'bn') ? search.org_name_bn : search.org_name, style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
        }
        if (search.service_name) {
          const rowItem = [
            { text: vm.$t('service_name.service_name'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'bn') ? search.service_name_bn : search.service_name, style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
        }
        if (search.type_en) {
          const rowItem = [
            { text: vm.$t('service_name.service_name'), style: 'td', alignment: 'right' },
            { text: ':', style: 'td', alignment: 'center' },
            { text: (i18n.locale === 'bn') ? search.type_bn : search.type_en, style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
        }
        if (allRowsHead.length > 0) {
          pdfContent.push({
            table: {
              widths: ['35%', '5%', '60%'],
              body: allRowsHead
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
        const allRows = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('warehouse_config.organization'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('li_step.application_id'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('li_step.issue_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('li_step.expire_date'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        newDatas.forEach((info, index) => {
          allRows.push([
            { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
            { text: (i18n.locale === 'bn') ? info.org_name_bn : info.org_name, alignment: 'center', style: 'td' },
            { text: vm.$n(info.application_id, { useGrouping: false }), alignment: 'center', style: 'td' },
            { text: dateFormat(info.issue_date), alignment: 'center', style: 'td' },
            { text: dateFormat(info.expire_date), alignment: 'center', style: 'td' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['20%', '20%', '20%', '20%', '20%'],
            body: allRows
          }
        })
        const waterMarkText = i18n.locale === 'bn' ? 'কৃষি মন্ত্রণালয়' : 'Ministry of Agriculture'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'Landcape',
        watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 10 : 9,
            margin: [3, 3, 3, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 10 : 9,
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
