import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      if (i18n.locale === 'bn') {
        pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        pdfMake.fonts = {
          Kalpurush: {
            normal: 'Kalpurush.ttf',
            bold: 'Kalpurush.ttf',
            italics: 'Kalpurush.ttf',
            bolditalics: 'Kalpurush.ttf'
          }
        }
      } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
          pdfMake.fonts = {
            Roboto: {
              normal: 'Roboto-Regular.ttf',
              bold: 'Roboto-Medium.ttf',
              italics: 'Roboto-Italic.ttf',
              bolditalics: 'Roboto-MediumItalic.ttf'
            }
          }
      }
      const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)
      const pdfContent = [{
            columns: reportHeadData?.reportHeadColumn
        },
        { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData?.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      const item = vm.item
      const currentLocale = vm.currentLocale
      let title = ''
      let client = ''
      let duration = ''
      if (item.document_type_id === 2) {
        title = (i18n.locale === 'en') ? item.prepare_rfp.rfp_title : item.prepare_rfp.rfp_title_bn
        client = (i18n.locale === 'en') ? item.prepare_rfp.client : item.prepare_rfp.client_bn
        duration = (i18n.locale === 'en') ? item.prepare_rfp.duration : item.prepare_rfp.duration
      }
      if (item.document_type_id === 3) {
        title = (i18n.locale === 'en') ? item.research.topic : item.research.topic_bn
        client = (i18n.locale === 'en') ? item.research.client : item.research.client_bn
        duration = (i18n.locale === 'en') ? item.research.duration : item.research.duration_bn
      }
      const allRowsHead = [
        [
          { text: vm.$t('bfti.doc_type'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: currentLocale === 'en' ? item.document_type_en : item.document_type_bn, style: 'td', alignment: 'left', colSpan: 4 },
          {},
          {},
          {}
        ],
        [
          { text: vm.$t('research_execution.title_or_topic'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: title, style: 'td', alignment: 'left', colSpan: 4 },
          {},
          {},
          {}
        ],
        [
          { text: vm.$t('report_management.client'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: client, style: 'td', alignment: 'left' },
          { text: vm.$t('research_plan_management.duration'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: duration, style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('task_activity_monitoring.contract_amount'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: vm.$n(item.contract_amount), style: 'td', alignment: 'left' },
          { text: vm.$t('research_execution.remaining_amount'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: vm.$n(item.remaining_amount), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('research_execution.contract_date'), style: 'th', bold: true },
          { text: ':', style: 'td' },
          { text: dateFormat(item.contract_date), style: 'td', alignment: 'left' },
          {},
          {},
          {}
        ]
      ]
      pdfContent.push({
        table: {
          widths: ['20%', '5%', '35%', '15%', '5%', '20%'],
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
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: vm.$t('research_execution.payment_schedule'), style: 'header1', alignment: 'left', bold: true })
        const allRows = [
          [
            { text: vm.$t('researchRequestManagement.installment'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('researchRequestManagement.payment_for'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('researchRequestManagement.installment_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.rcv_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.rem_amount'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        if (item.budgets.length) {
          item.budgets.forEach((budgetItem, index) => {
            allRows.push(
              [
                { text: vm.getInstallmentName(budgetItem.installment_id), style: 'td', alignment: 'center' },
                { text: budgetItem.payment_for, style: 'td', alignment: 'center' },
                { text: vm.$n(budgetItem.installment_amount), style: 'td', alignment: 'right' },
                { text: vm.$n(budgetItem.rcv_amount), style: 'td', alignment: 'right' },
                { text: vm.$n(budgetItem.rem_amount), style: 'td', alignment: 'right' }
              ]
            )
          })
        } else {
          allRows.push(
            [
              { text: vm.$t('globalTrans.noDataFound'), style: 'td', alignment: 'center', colSpan: 5 },
              { },
              { },
              { },
              { }
            ]
          )
        }
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['14%', '14%', '*', '*', '*'],
            body: allRows
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        pdfContent.push({ text: vm.$t('report_management.payment_receive_info'), style: 'header1', alignment: 'left', bold: true })
        const allRows2 = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('researchRequestManagement.installment_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.ins_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.rcv_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.tax_vat'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.rcv_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.actual_rcv_amount'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('research_execution.receive_through'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('globalTrans.remarks'), style: 'th', alignment: 'center', bold: true }
          ]
        ]
        if (item.budgets.length) {
          item.budgets.forEach((budgetItem, budgetIndex) => {
            if (budgetItem.receive_payments.length) {
              budgetItem.receive_payments.forEach((paymentItem, paymentIndex) => {
                if (paymentIndex === 0) {
                  allRows2.push(
                    [
                      { text: vm.$n(budgetIndex + 1), style: 'td', alignment: 'center', rowSpan: (budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null },
                      { text: vm.getInstallmentName(budgetItem.installment_id), style: 'td', alignment: 'center', rowSpan: (budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null },
                      { text: vm.$n(budgetItem.installment_amount), style: 'td', alignment: 'right', rowSpan: (budgetItem.receive_payments.length > 1) ? budgetItem.receive_payments.length : null },
                      { text: vm.$n(paymentItem.rcv_amount), style: 'td', alignment: 'right' },
                      { text: vm.$n(paymentItem.tax_vat), style: 'td', alignment: 'right' },
                      { text: dateFormat(paymentItem.rcv_date), style: 'td', alignment: 'center' },
                      { text: vm.$n(paymentItem.actual_rcv_amount), style: 'td', alignment: 'right' },
                      { text: paymentItem.rcv_through, style: 'td', alignment: 'center' },
                      { text: paymentItem.remark, style: 'td', alignment: 'center' }
                    ]
                  )
                } else {
                  allRows2.push(
                    [
                      { text: vm.$n(paymentItem.rcv_amount), style: 'td', alignment: 'right' },
                      { text: vm.$n(paymentItem.tax_vat), style: 'td', alignment: 'right' },
                      { text: dateFormat(paymentItem.rcv_date), style: 'td', alignment: 'center' },
                      { text: vm.$n(paymentItem.actual_rcv_amount), style: 'td', alignment: 'right' },
                      { text: paymentItem.rcv_through, style: 'td', alignment: 'center' },
                      { text: paymentItem.remark, style: 'td', alignment: 'center' }
                    ]
                  )
                }
              })
            } else {
              allRows2.push(
                [
                  { text: vm.$n(budgetIndex + 1), style: 'td', alignment: 'center' },
                  { text: vm.getInstallmentName(budgetItem.installment_id), style: 'td', alignment: 'center' },
                  { text: vm.$n(budgetItem.installment_amount), style: 'td', alignment: 'center' },
                  { },
                  { },
                  { },
                  { },
                  { },
                  { }
                ]
              )
            }
          })
        } else {
          allRows.push(
            [
              { text: vm.$t('globalTrans.noDataFound'), style: 'td', alignment: 'center', colSpan: 9 },
              { },
              { },
              { },
              { },
              { },
              { },
              { },
              { }
            ]
          )
        }
        // if (listData.length) {
        //   listData.forEach((marketDirectory, marketDirectoryIndex) => {
        //     pdfContent.push({ text: (vm.$t('bazarMonitoring.market_name') + ': ') + (currentLocale === 'en' ? marketDirectory.market_directory_name_en : marketDirectory.market_directory_name_bn), style: 'header1', alignment: 'left' })
        //     const allRows = []
        //     const tableHead1 = [
        //       { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
        //       { text: vm.$t('bazarMonitoring.commodity_group'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
        //       { text: vm.$t('bazarMonitoring.commodity_name'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 },
        //       { text: vm.$t('bazarMonitoring.measurement_unit'), style: 'th', alignment: 'center', bold: true, rowSpan: 2 }
        //     ]
        //     vm.frequencyDateArr.forEach((info, index) => {
        //       tableHead1.push(
        //         {
        //           text: (currentLocale === 'en' ? info.frequency_text_en : info.frequency_text_bn) + (' ' + dateFormat(info.frequency_date)), style: 'th', alignment: 'center', bold: true, colSpan: 4
        //         },
        //         {},
        //         {},
        //         {}
        //       )
        //     })
        //     const tableHead2 = [{}, {}, {}, {}]
        //     vm.frequencyDateArr.forEach((info, index) => {
        //       tableHead2.push(
        //         {
        //           text: vm.$t('report.l'), style: 'th', alignment: 'center', bold: true
        //         },
        //         {
        //           text: vm.$t('report.h'), style: 'th', alignment: 'center', bold: true
        //         },
        //         {
        //           text: vm.$t('report.tk'),
        //           style: 'th',
        //           alignment: 'center',
        //           bold: true
        //         },
        //         {
        //           text: vm.$t('report.%'), style: 'th', alignment: 'center', bold: true
        //         }
        //       )
        //     })
        //     allRows.push(tableHead1, tableHead2)
        //     marketDirectory.commodity_group_info.forEach((commodityGroup, commodityGroupIndex) => {
        //       commodityGroup.commodity_name_info.forEach((commodityName, commodityNameIndex) => {
        //         if (commodityNameIndex === 0) {
        //           const rowItem = [
        //             { text: vm.$n(commodityGroupIndex + 1), alignment: 'center', rowSpan: (commodityGroup.commodity_name_info.length > 1 ? commodityGroup.commodity_name_info.length : null), style: 'td' },
        //             { text: (i18n.locale === 'en') ? commodityGroup.commodity_group_name_en : commodityGroup.commodity_group_name_bn, alignment: 'center', rowSpan: (commodityGroup.commodity_name_info.length > 1 ? commodityGroup.commodity_name_info.length : null), style: 'td' },
        //             { text: (i18n.locale === 'en') ? commodityName.commodity_name_en : commodityName.commodity_name_bn, alignment: 'center', style: 'td' },
        //             { text: (i18n.locale === 'en') ? commodityName.unit_name_en : commodityName.unit_name_bn, alignment: 'center', style: 'td' }
        //           ]
        //           commodityName.frequency_type_info.forEach((frequencyItem, frequencyIndex) => {
        //             rowItem.push(
        //               {
        //                 text: vm.$n(frequencyItem.lowest_price_amount), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.$n(frequencyItem.highest_price_amount), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.getFluctuationRate(frequencyItem), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.$n(frequencyItem.fluctuation_rate_percentage) + '%', alignment: 'center', style: 'td'
        //               }
        //             )
        //           })
        //           allRows.push(rowItem)
        //         } else {
        //           const rowItem = [
        //             {},
        //             {},
        //             { text: (i18n.locale === 'en') ? commodityName.commodity_name_en : commodityName.commodity_name_bn, alignment: 'center', style: 'td' },
        //             { text: (i18n.locale === 'en') ? commodityName.unit_name_en : commodityName.unit_name_bn, alignment: 'center', style: 'td' }
        //           ]
        //           commodityName.frequency_type_info.forEach((frequencyItem, frequencyIndex) => {
        //             rowItem.push(
        //               {
        //                 text: vm.$n(frequencyItem.lowest_price_amount), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.$n(frequencyItem.highest_price_amount), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.getFluctuationRate(frequencyItem), alignment: 'center', style: 'td'
        //               },
        //               {
        //                 text: vm.$n(frequencyItem.fluctuation_rate_percentage) + '%', alignment: 'center', style: 'td'
        //               }
        //             )
        //           })
        //           allRows.push(rowItem)
        //         }
        //       })
        //     })
        //     pdfContent.push({
        //       table: {
        //         headerRows: 2,
        //         // widths: ['6%', '14%', '14%', '13%', '12%', '12%', '9%', '10%', '10%'],
        //         widths: '*',
        //         body: allRows
        //       }
        //     })
        //   })
        // } else {
        //   pdfContent.push({ text: vm.$t('globalTrans.noDataFound'), style: 'fertilizer', alignment: 'center' })
        // }
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['6%', '14%', '*', '*', '*', '*', '*', '*', '*'],
            body: allRows2
          }
        })
        pdfContent.push({ text: '', style: 'fertilizer' })
        // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
        // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
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
            fontSize: (i18n.locale === 'bn') ? 10 : 11,
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
            margin: [0, 4, 0, 11]
          },
          krishi: {
            margin: [0, -5, 0, 11],
            alignment: 'center'
          },
          header3: {
            fontSize: 9,
            margin: [0, 0, 0, 0]
          },
          tableSubHead: {
            margin: [0, 5, 0, 11]
          },
          header1: {
            fontSize: 13,
            margin: [0, 5, 0, 5],
            background: '#dfdfdf'
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
