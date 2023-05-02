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
        const detailsData = vm.detailsData
        const allRows = [
          [
            { text: vm.$t('teaGardenPanel.registration_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: detailsData.application.registration_no, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenConfig.tea_garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? detailsData.tea_garden_name_en : detailsData.tea_garden_name_bn, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenConfig.division'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDivisionName(detailsData.division_id), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenConfig.district'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDistrictName(detailsData.district_id), style: 'td', alignment: 'left', bold: false }
          ]
        ]
        if (detailsData.area_type_id === 1) {
          allRows.push([
            { text: vm.$t('teaGardenConfig.city_corporation'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getCityCorName(detailsData.city_corporation_id), style: 'td', alignment: 'left', bold: false }
          ])
        } else {
          allRows.push([
            { text: vm.$t('teaGardenConfig.upazila'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getUpazillaName(detailsData.upazila_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        if (detailsData.area_type_id === 2) {
          allRows.push([
            { text: vm.$t('teaGardenConfig.pouroshova'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getPouroName(detailsData.pauroshoba_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        if (detailsData.area_type_id === 3) {
          allRows.push([
            { text: vm.$t('teaGardenConfig.union'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getUnionName(detailsData.union_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        allRows.push([
          { text: vm.$t('globalTrans.ward'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.getWardName(detailsData.ward_id), style: 'td', alignment: 'left', bold: false }
        ])
        if (detailsData.proprietor_identity.owners.length) {
          detailsData.proprietor_identity.owners.forEach((item, index) => {
            allRows.push(
              [
                { text: (detailsData.proprietor_identity.owners.length > 1 ? vm.$n(index + 1) + ') ' : '') + vm.$t('teaGardenPanel.owner_name'), style: 'td', alignment: 'left', bold: true },
                { text: ':', alignment: 'center' },
                { text: currentLocale === 'en' ? item.garden_owner_name_en : item.garden_owner_name_bn, style: 'td', alignment: 'left', bold: false }
              ],
              [
                { text: (detailsData.proprietor_identity.owners.length > 1 ? vm.$n(index + 1) + ') ' : '') + vm.$t('globalTrans.father_name'), style: 'td', alignment: 'left', bold: true },
                { text: ':', alignment: 'center' },
                { text: currentLocale === 'en' ? item.garden_owner_father_name_en : item.garden_owner_father_name_bn, style: 'td', alignment: 'left', bold: false }
              ]
            )
          })
        }
        allRows.push(
          [
            { text: vm.$t('teaGardenPanel.amount_of_land'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(detailsData.land_ownership_info.total_grant_area), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('externalUser.issue_date'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: dateFormat(detailsData.application.issue_date), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('externalLrcpn.expire_date'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: dateFormat(detailsData.application.expired_date), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenPanel.schedule_of_land'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenPanel.mouja'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? detailsData.land_ownership_info.mouja_en : detailsData.land_ownership_info.mouja_bn, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenPanel.khotian'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(detailsData.land_ownership_info.khotian_no, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenPanel.dag_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(detailsData.land_ownership_info.dag_no, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ]
        )
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['25%', '3%', '72%'],
            body: allRows
          },
          layout: 'noBorders'
        })
        pdfContent.push(
          { text: vm.$t('teaGardenPanel.conditions'), style: 'td', bold: true, margin: [0, 5, 0, 5] },
          {
            stack: htmlToPdfmake(currentLocale === 'en' ? detailsData.application.service_instruction.instruction_en : detailsData.application.service_instruction.instruction_bn, {
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
              qr: vm.getQrCodeContent(), fit: '100', rowSpan: 4
            },
            {
              stack: [
                { image: await getBase64ImageFromURL(baseUrl + 'download-storage-attachment?file=app/public/signature.png'), width: 70 }
              ]
            }
          ],
          [
            {},
            { text: vm.$t('globalTrans.name') + ' : ' + vm.$t('teaGardenPanel.signatory_name'), style: 'td', alignment: 'left' }
          ],
          [
            {},
            { text: vm.$t('globalTrans.designation') + ' : ' + vm.$t('teaGardenPanel.signatory_designation'), style: 'td', alignment: 'left' }
          ],
          [
            {},
            { text: vm.$t('globalTrans.date') + ' : ' + vm.$t('teaGardenPanel.signatory_date'), style: 'td', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['60%', '40%'],
            body: signatureRows
          },
          layout: 'noBorders'
        })
        // pdfContent.push({ text: vm.$t('teaGardenService.appDetail_date') + ' : ' + dateFormat(appDetail.created_at), style: 'normalText', alignment: 'right' })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        // pageSize: {
        //   width: 1000,
        //   height: 'auto'
        // },
        // pageOrientation: 'landscape',
        pageOrientation: 'portrait',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 14 : 13,
            margin: [3, 3, 15, 3]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 10 : 9,
            margin: [1, 1, 1, 1]
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
