import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head-tea-garden'
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
      const pdfContent = [
        { columns: reportHeadData.reportHeadColumn },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center', decoration: 'underline' }
      ]
        const currentLocale = vm.currentLocale
        const data = vm.data
        const arr1 = [
          [
            { text: vm.$t('globalTrans.organization'), style: 'td', alignment: 'left', bold: true },
            { text: currentLocale === 'en' ? 'BTRI' : 'বিটিআরই', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$t('teaGardenConfig.service_name'), style: 'td', alignment: 'left', bold: true },
            { text: currentLocale === 'en' ? data.service.service_name_en : data.service.service_name_bn, style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$t('teaGardenService.application_id'), style: 'td', alignment: 'left', bold: true },
            { text: data.app_id, style: 'td', alignment: 'left' }
          ]
        ]
        const arr2 = []
        if (data.payment.payment_type === 1) {
          arr2.push(
            [
              { text: vm.$t('teaGardenBtriService.receipt'), style: 'td', alignment: 'left', bold: true },
              { text: data.payment.received_number, style: 'td', alignment: 'left' }
            ]
          )
        } else if (data.payment.payment_type === 2) {
          arr2.push(
            [
              { text: vm.$t('teaGardenBtriService.check_no'), style: 'td', alignment: 'left', bold: true },
              { text: data.payment.check_no, style: 'td', alignment: 'left' }
            ]
          )
        } else {
          arr2.push(
            [
              { text: vm.$t('teaGardenBtriService.transaction_number'), style: 'td', alignment: 'left', bold: true },
              { text: data.payment.transaction_number, style: 'td', alignment: 'left' }
            ]
          )
        }
        arr2.push(
          [
            { text: vm.$t('teaGardenBtriService.transaction_date'), style: 'td', alignment: 'left', bold: true },
            { text: dateFormat(data.payment.date), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$t('globalTrans.payment_type'), style: 'td', alignment: 'left', bold: true },
            { text: vm.getPaymentTypeName(data.payment.payment_type), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$t('teaGardenBtriService.total_samples'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$n(data.total_samples), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$t('priceMonitoring.amount_in_taka'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$n(data.payment.amount) + '/-', style: 'td', alignment: 'left' }
          ]
        )
        const allRows = arr1.concat(arr2)
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['50%', '50%'],
            body: allRows
          }
        })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 14 : 13,
            margin: [3, 3, 15, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 12 : 11,
            margin: [3, 3, 3, 3]
          },
          customTdGarden: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 40, 3, 3]
          },
          customTdOwner: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 80, 3, 3]
          },
          customTdLand: {
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            margin: [3, 50, 3, 3]
          },
          search: {
            fontSize: (i18n.locale === 'bn') ? 10 : 11,
            margin: [3, 3, 3, 3]
          },
          normalText: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 9 : 8,
            bold: true
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
          hh: {
              fontSize: 13,
              bold: true,
              margin: [10, 10, 25, 20]
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
          tableSubHead: {
            margin: [0, 5, 0, 15]
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
