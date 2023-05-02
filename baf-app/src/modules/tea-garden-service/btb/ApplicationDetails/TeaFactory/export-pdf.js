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
        const application = vm.application
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({
          columns: [
            {
              columns: [
                {
                  text: vm.$t('teaGardenService.application_id') + ' : ', style: 'td', bold: false, width: 'auto'
                },
                {
                  text: application.application.app_id, style: 'td', bold: false, width: 'auto'
                }
              ]
            },
            {
              alignment: 'right',
              columns: [
                {
                  text: vm.$t('teaGardenService.application_date') + ' : ', style: 'td', bold: false, alignment: 'right', width: 200
                },
                {
                  text: dateFormat(application.application.issue_date), style: 'td', bold: false, alignment: 'right', width: 55
                }
              ]
            }
          ]
        })
        pdfContent.push({ text: '', style: 'normalText' })
        // 1
        const allRows = [
          [
            { text: vm.$t('teaGardenService.serial_no'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.description'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.remarks'), style: 'td', alignment: 'center', bold: true }
          ],
          [
            { text: vm.$n(1), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenService.applicant_name_address'), style: 'td', alignment: 'left' },
            { text: vm.getApplicantNameAddress(), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(2), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenConfig.factory_type'), style: 'td', alignment: 'left' },
            { text: vm.getFactoryTypeName(application.factory_type_id), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(3), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.applicant_type'), style: 'td', alignment: 'left' },
            { text: application.applicant_type ? vm.getApplicantTypeName(application.applicant_type) : '', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(4), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenService.nid'), style: 'td', alignment: 'left' },
            { text: application.applicant_nid ? vm.EngBangNum(application.applicant_nid) : '', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(5), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenService.factory_address'), style: 'td', alignment: 'left' },
            { text: application.factory_info ? vm.getFactoryAddress() : '', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(6), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.manufacturing_method'), style: 'td', alignment: 'left' },
            { text: application.factory_info ? vm.getMadeTypeNames(application.manufacturing_methods) : '', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(7), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.production_capacity'), style: 'td', alignment: 'left' },
            { text: vm.$n(application.factory_info.production_capacity), style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(8), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.source_of_funding'), style: 'td', alignment: 'left' },
            { text: currentLocale === 'en' ? application.factory_info.source_of_funding_en : application.factory_info.source_of_funding_bn, style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(9), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.processed_area'), style: 'td', alignment: 'left' },
            { text: application.factory_info.processed_area ? vm.getFactoryProcessedArea(application.factory_info.processed_area) : '', style: 'td', alignment: 'left' }
          ],
          [
            { text: vm.$n(10), style: 'td', alignment: 'center' },
            { text: vm.$t('teaGardenPanel.total_land_factory_established'), style: 'td', alignment: 'left' },
            { text: vm.$n(application.factory_info.total_land_factory_established), style: 'td', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['8%', '30%', '62%'],
            body: allRows
          },
          layout: ''
        })
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: '--------------------------------', style: 'signatureBorder', alignment: 'right' })
        pdfContent.push({ text: vm.$t('teaGardenPanel.applicant_signature'), style: 'signatureBorder', alignment: 'right' })
        if (application.attachment_file) {
          pdfContent.push({ text: vm.$t('teaGardenPanel.attachment') + ':', style: 'attachment', bold: true })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.machineries_file') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.agreement_deed') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.nationality_certificate') + ':', style: 'attachment' })
          if (application.applicant_type === 2) {
            pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.article_of_association') + ':', style: 'attachment' })
            pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.memorandum_of_association') + ':', style: 'attachment' })
          } else if (application.applicant_type === 3) {
            pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.partnership_deed') + ':', style: 'attachment' })
          } else if (application.applicant_type === 4) {
            pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.cooperative_society_registration') + ':', style: 'attachment' })
          }
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.bank_solvency_certificate') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.land_deed') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.lease_deed') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.environmental_certificate') + ':', style: 'attachment' })
          pdfContent.push({ text: '* ' + vm.$t('teaGardenPanel.tin_certificate') + ':', style: 'attachment' })
          application.add_more_files.forEach((item) => {
            if (currentLocale === 'en') {
              pdfContent.push({ text: '* ' + item.file_name_en + ':', style: 'attachment' })
            } else {
              pdfContent.push({ text: '* ' + item.file_name_bn + ':', style: 'attachment' })
            }
          })
        }
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 16 : 13,
            margin: [3, 3, 15, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 11 : 9,
            margin: [3, 3, 3, 3]
          },
          search: {
            fontSize: (i18n.locale === 'bn') ? 10 : 11,
            margin: [3, 3, 3, 3]
          },
          normalText: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 11 : 9,
            bold: false
          },
          attachment: {
            margin: [5, 4, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 11 : 9,
            bold: false
          },
          header: {
              fontSize: 16,
              bold: true,
              margin: [0, 0, 0, 0]
          },
          org: {
              fontSize: 13,
              bold: true,
              margin: [0, -25, 10, 0]
          },
          address: {
              fontSize: 11,
              margin: [0, 0, 0, 5]
          },
          hh: {
              fontSize: 13,
              bold: true,
              margin: [5, 0, 25, 5]
          },
          app_id: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 9 : 9
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
          },
          signatureBorder: {
            margin: [0, 0, 0, 0],
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            bold: false
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
