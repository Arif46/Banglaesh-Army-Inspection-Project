import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head-tea-garden'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
import htmlToPdfmake from 'html-to-pdfmake'

function getBase64ImageFromURL (url) {
  return new Promise((resolve, reject) => {
    var img = new Image()
    img.setAttribute('crossOrigin', 'anonymous')
    img.onload = () => {
      var canvas = document.createElement('canvas')
      canvas.width = img.width
      canvas.height = img.height
      var ctx = canvas.getContext('2d')
      ctx.drawImage(img, 0, 0)
      var dataURL = canvas.toDataURL('image/png')
      resolve(dataURL)
    }
    img.onerror = error => {
      reject(error)
    }
    img.src = url
  })
}

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
      // 1
      const allRows = [
        [
            { text: vm.$t('teaGardenService.application_id'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.application.app_id, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.tea_garden_name'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_name_en : application.garden_name_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenConfig.division'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.getDivisionName(application.division_id), style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenConfig.district'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.getDistrictName(application.district_id), style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenConfig.upazila'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.getUpzillaName(application.upazila_id), style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenPanel.post_office'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$i18n.locale === 'en' ? application.owner_info.post_office_en : application.owner_info.post_office_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenPanel.village'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$i18n.locale === 'en' ? application.owner_info.village_en : application.owner_info.village_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenPanel.owner_name'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$i18n.locale === 'en' ? application.owner_info.owner_name_en : application.owner_info.owner_name_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenPanel.owner_father_name'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$i18n.locale === 'en' ? application.owner_info.father_name_en : application.owner_info.father_name_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.nid'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.owner_info.owner_nid ? vm.EngBangNum(application.owner_info.owner_nid) : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.total_land'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.total_cultivation_land_quantity ? vm.$n(application.total_cultivation_land_quantity) : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.issue_date'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.application.created_at ? dateFormat(application.application.created_at) : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.expire_date'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.application.expired_date ? dateFormat(application.application.expired_date) : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenPanel.land_schedule'), style: 'td', alignment: 'left', bold: false },
            { },
            { }
        ],
        [
            { text: vm.$t('teaGardenService.mouja'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$i18n.locale === 'en' ? application.mouja_en : application.mouja_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.khotian'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.khotian ? vm.EngBangNum(application.khotian) : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.dag_no'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.dag_no ? vm.EngBangNum(application.dag_no) : '', style: 'td', alignment: 'left', bold: false }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 0,
          widths: ['35%', '1%', '64%'],
          body: allRows
        },
        layout: 'noBorders'
      })
      pdfContent.push(
        { text: vm.$t('teaGardenPanel.conditions'), style: 'td', bold: true, margin: [0, 5, 0, 5] },
        {
          stack: htmlToPdfmake(currentLocale === 'en' ? application.application.service_instruction.instruction_en : application.application.service_instruction.instruction_bn, {
            defaultStyles: {
              p: {
                margin: [0, 2],
                fontSize: (i18n.locale === 'bn') ? 10 : 9
              }
            }
          }),
          margin: [0, 0, 0, 60]
        }
      )
        const signatureRows = [
          [
            {
              qr: vm.getQrCodeContent(), fit: vm.getQrCodeFitWidth(), rowSpan: 4
            },
            {
              stack: [
                { image: await getBase64ImageFromURL(baseUrl + 'download-storage-attachment?file=app/public/signature.png'), width: 70 }
              ]
            }
          ],
          [
            {},
            { text: vm.$t('globalTrans.name') + ' : ' + vm.$t('teaGardenPanel.signatory_name'), style: 'td', alignment: 'left', bold: false }
          ],
          [
            {},
            { text: vm.$t('globalTrans.designation') + ' : ' + vm.$t('teaGardenPanel.signatory_designation'), style: 'td', alignment: 'left', bold: false }
          ],
          [
            {},
            { text: vm.$t('globalTrans.date') + ' : ' + vm.$t('teaGardenPanel.signatory_date'), style: 'td', alignment: 'left', bold: false }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['70%', '30%'],
            body: signatureRows
          },
          layout: 'noBorders'
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
            fontSize: (i18n.locale === 'bn') ? 10 : 9,
            margin: [3, 0, 0, 3]
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
          },
          'html-p': {
            margin: [0, 0, 0, 0]
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
