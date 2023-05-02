import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import ReportHeading from '@/utils/report-head'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, orgID, reportTitle, columns, resultData, vm) => {
    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      if (i18n.locale === 'bn') {
        pdfMake.vfs = pdfFontsBn.pdfMake.vfs
      } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
      }
        const reportHeadData = await ReportHeading.getReportHead(baseUrl, '/configuration/report-heading/detail', orgID)
        const pdfContent = [
            { text: reportHeadData.reportHeadColumn[2], style: 'header', alignment: 'center' },
            { text: reportHeadData.address, style: 'address', alignment: 'center' }
          ]
        pdfContent.push({ text: reportTitle, style: 'header2', alignment: 'center' })
        pdfContent.push({ text: '', style: 'fertilizer' })
        const allRows = []
        const dynmicColumns = []
        columns.forEach(item => {
          if (item !== undefined && item.key !== 'action') {
            dynmicColumns.push(
              { text: item.label !== undefined ? item.label : '', style: 'th', alignment: 'left' }
            )
          }
        })
        allRows.push(dynmicColumns)
        let index = 1
        resultData.forEach(dataItem => {
          const data = []
          columns.forEach(columnItem => {
            if (columnItem !== undefined) {
              if (columnItem.key === 'index') {
                data.push(
                  { text: vm.$n(index++), style: 'td', alignment: 'left' }
                )
              } else if (columnItem.key === 'generate_id' || columnItem.key === 'application_id') {
                data.push(
                  { text: vm.$n(dataItem[columnItem.key], { useGrouping: false }), style: 'td', alignment: 'left' }
                )
              } else if (columnItem.key === 'status') {
                data.push(
                  { text: vm.getStepName(dataItem.current_step), style: 'td', alignment: 'left' }
                )
              } else if (columnItem.key === 'expire_date' || columnItem.key === 'issue_date') {
                data.push(
                  { text: columnItem.label !== undefined ? dateFormat(dataItem[columnItem.key]) : '', style: 'td', alignment: 'left' }
                )
              } else {
                if (columnItem.key !== 'action') {
                  data.push(
                    { text: columnItem.label !== undefined ? dataItem[columnItem.key] : '', style: 'td', alignment: 'left' }
                  )
                }
              }
            }
          })
          if (data.length) {
            allRows.push(data)
          }
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: '*',
            body: allRows
          }
        })
        const waterMarkText = i18n.locale === 'bn' ? 'কৃষি মন্ত্রণালয়' : 'Ministry of Agriculture'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A3',
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
            margin: [0, 0, 0, 10]
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
      pdfMake.createPdf(docDefinition, null, null, null).download('report-pdf')
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
