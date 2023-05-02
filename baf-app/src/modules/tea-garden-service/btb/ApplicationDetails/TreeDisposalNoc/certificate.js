import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head-tea-garden'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
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
            { text: vm.$t('teaGardenConfig.garden_name'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_info.tea_garden_name_en : application.garden_info.tea_garden_name_bn, style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.tea_garden_address'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.getGardenAddress(), style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenConfig.registration_no'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: application.garden_info.registration_no_en ? application.garden_info.registration_no_en : '', style: 'td', alignment: 'left', bold: false }
        ],
        [
            { text: vm.$t('teaGardenService.total_approved_trees'), style: 'td', alignment: 'left', bold: false },
            { text: ':', alignment: 'center' },
            { text: vm.$n(vm.totalNumberOfApprovedTrees), style: 'td', alignment: 'left', bold: false }
        ]
      ]
       // tree information display
       const sectionTreeRow = [
        [
          { text: vm.$t('teaGardenService.section_name'), style: 'td', alignment: 'center', bold: true },
          { text: vm.$t('teaGardenService.mouja'), style: 'td', alignment: 'center', bold: true },
          { text: vm.$t('teaGardenService.khotian'), style: 'td', alignment: 'center', bold: true },
          { text: vm.$t('teaGardenService.dag_no'), style: 'td', alignment: 'center', bold: true },
          { text: vm.$t('teaGardenService.tree_name'), style: 'td', alignment: 'center', bold: true },
          { text: vm.$t('teaGardenService.approved_tree'), style: 'td', alignment: 'center', bold: true }
        ]
      ]
      if (application.tree_cutting_locations.length) {
        application.tree_cutting_locations.forEach((item, index) => {
          if (item.cutting_trees.length) {
            item.cutting_trees.forEach(treeItem => {
              sectionTreeRow.push([
                { text: vm.getSectionName(item.section_id), style: 'td', alignment: 'left', rowSpan: item.cutting_trees.length },
                { text: currentLocale === 'en' ? item.mouja_en : item.mouja_bn, style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                { text: item.khotian_no ? vm.EngBangNum(item.khotian_no) : '', style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                { text: item.dag_no ? vm.EngBangNum(item.dag_no) : '', style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                { text: vm.getTreeName(treeItem.tree_id), style: 'td', alignment: 'center' },
                { text: vm.$n(treeItem.approved_tree), style: 'td', alignment: 'center' }
              ])
            })
          }
          sectionTreeRow.push([
            { text: vm.$t('teaGardenService.sub_total'), style: 'td', alignment: 'right', colSpan: 5, bold: true },
            {},
            {},
            {},
            {},
            { text: vm.$n(item.cutting_trees.reduce((sum, { approvedTrees }) => sum + Number(approvedTrees), 0)), style: 'td', alignment: 'center', bold: true }
          ])
        })
      }
      sectionTreeRow.push([
        { text: vm.$t('teaGardenService.grand_total'), style: 'td', alignment: 'right', colSpan: 5, bold: true },
        {},
        {},
        {},
        {},
        { text: vm.$n(vm.totalNumberOfApprovedTrees), style: 'td', alignment: 'center', bold: true }
      ])
      allRows.push(
        [
          {
            table: {
              body: sectionTreeRow
            },
            colSpan: 3
          },
          { },
          { }
        ]
      )
      pdfContent.push({
        table: {
          headerRows: 0,
          widths: ['35%', '1%', '64%'],
          body: allRows
        },
        layout: 'noBorders'
      })

        pdfContent.push(
          { text: '', bold: true, margin: [0, 5, 0, 5] }
        )
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
        pdfContent.push(
          { text: '', bold: true, margin: [0, 5, 0, 5] }
        )
        const signatureRows = [
          [
            {},
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
