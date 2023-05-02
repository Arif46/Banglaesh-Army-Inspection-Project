import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat, mobileNumber } from '@/utils/fliter'

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
          columns: reportHeadData?.reportHeadColumn
      },
      { text: reportHeadData?.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData?.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData?.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]
      const basicInformationTable = [
        [
          { text: vm.$t('globalTrans.document') + ' ' + vm.$t('globalTrans.information'), style: 'th1', alignment: 'left', colSpan: 6, bold: true },
          { },
          { },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('configuration.document_type'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.getDocumentTypeName(vm.research.document_type_id), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('research_plan_management.organization_ministry_division'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: (i18n.locale === 'bn') ? vm.research.organization_bn : vm.research.organization, style: 'td', alignment: 'left' },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('bfti.topic'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: (i18n.locale === 'bn') ? vm.research.topic_bn : vm.research.topic, style: 'td', alignment: 'left' },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('research_execution.project_duration'), style: 'th', alignment: 'left', bold: true },
          { text: ':', style: 'td', alignment: 'center' },
          { text: vm.getDuration(vm.research.duration_start_date, vm.research.duration_end_date), style: 'th', alignment: 'left' },
          { },
          { },
          { }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['20%', '5%', '35%', '15%', '5%', '20%'],
          body: basicInformationTable
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
      const rcvPaymentTable = [
        [
          { text: vm.$t('task_activity_monitoring.consultant_info'), alignment: 'left', colSpan: 5, style: 'th1' },
          { },
          { },
          { },
          { }
        ],
        [
          { text: vm.$t('report_management.sl'), alignment: 'center', style: 'th' },
          { text: vm.$t('task_activity_monitoring.consultant_info'), alignment: 'center', style: 'th' },
          { text: vm.$t('task_activity_monitoring.contract') + ' ' + vm.$t('globalTrans.from_date'), alignment: 'center', style: 'th' },
          { text: vm.$t('task_activity_monitoring.contract') + ' ' + vm.$t('globalTrans.to_date'), alignment: 'center', style: 'th' },
          { text: vm.$t('task_activity_monitoring.contract_amount'), alignment: 'center', style: 'th' }
        ]
      ]
      vm.assignConsultant.forEach((item, index) => {
      rcvPaymentTable.push(
            [
              { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
              { text: (i18n.locale === 'bn' ? item.name_bn : item.name_en) + '\n' + (i18n.locale === 'bn' ? item.designation_bn : item.designation) + '\n' + mobileNumber(item.contact_no) + '\n' + item.email, alignment: 'center', style: 'td' },
              { text: dateFormat(item.date_from), style: 'th', alignment: 'center' },
              { text: dateFormat(item.date_to), style: 'th', alignment: 'center' },
              { text: vm.$n(item.amount, { useGrouping: false }), style: 'th', alignment: 'center' }
            ]
          )
        })
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: '', style: 'fertilizer' })
      pdfContent.push({ text: '', style: 'fertilizer' })
      // pdfContent.push({ text: vm.$t('research_execution.rcv_amount') + '                                                                           ' + vm.$t('report_management.expenditure'), style: 'fertilizer', alignment: 'center' })
      pdfContent.push({
        table: {
          widths: ['100%'],
          body: [
              [
                {
                  table: {
                    widths: ['10%', '30%', '20%', '20%', '20%'],
                    body: rcvPaymentTable
                  }
                }
              ]
          ]
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
      // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
      var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      // watermark: { text: waterMarkText, color: 'blue', opacity: 0.1, bold: true, italics: false },
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 8 : 7,
          margin: [3, 3, 3, 3]
        },
        th1: {
          fillColor: '#C6C2C1',
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
          margin: [0, 5, 0, 5]
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
