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
        const previousPermissionData = vm.previousPermissionData
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({
          columns: [
            {
              columns: [
                {
                  text: vm.$t('teaGardenService.application_id') + ' : ', style: 'td', bold: true, width: 'auto'
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
                  text: vm.$t('teaGardenService.application_date') + ' : ', style: 'td', bold: true, alignment: 'right', width: 200
                },
                {
                  text: dateFormat(application.application.issue_date), style: 'td', bold: false, alignment: 'right', width: 55
                }
              ]
            }
          ]
        })
        // 1
        const allRows = [
          [
            { text: vm.$t('teaGardenPanel.1') + '  ' + vm.$t('teaGardenService.tea_garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_info.tea_garden_name_en : application.garden_info.tea_garden_name_bn, style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.2') + '  ' + vm.$t('teaGardenService.tea_garden_address'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_info.garden_address_en : application.garden_info.garden_address_bn, style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.3') + '  ' + vm.$t('teaGardenService.tea_board_reg_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.garden_info.registration_no_en ? application.garden_info.registration_no_en : '', style: 'td', alignment: 'left', bold: false }
          ],
          [
            { text: vm.$t('teaGardenPanel.4') + '  ' + vm.$t('teaGardenService.tea_garden_owner_name_address'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? application.garden_info.owner_name_en : application.garden_info.owner_name_bn, style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.5') + '  ' + vm.$t('teaGardenService.tree_class_of_forest_resources'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.tree_class_of_forest_resources ? vm.getTreeClassResource(application.tree_class_of_forest_resources) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.6') + '  ' + vm.$t('teaGardenService.description_of_forest_resource'), style: 'td', alignment: 'left', bold: true },
            {},
            {}
          ],
          [
            { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.plantation_year_label'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.plantation_year.toString()), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.number_of_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.number_of_trees), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.size'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.size), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.quantity_approx'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.quantity_approx), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.e') + '  ' + vm.$t('teaGardenService.unit_quantity'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.unit_quantity ? vm.getUnitName(application.unit_quantity) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.7') + '  ' + vm.$t('teaGardenService.disposal_plan'), style: 'td', alignment: 'left', bold: true },
            {},
            {}
          ],
          [
            { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.total_cutable_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.total_cutable_trees), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.number_of_re_plantable_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.number_of_re_plantable_tree), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.number_of_very_old_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.number_of_very_old_trees), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.number_of_rubber_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.number_of_rubber_tree), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.e') + '  ' + vm.$t('teaGardenService.number_of_disease_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.number_of_disease_tree), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.f') + '  ' + vm.$t('teaGardenService.number_of_other_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(application.cutting_purpose?.number_of_other_trees), style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenPanel.8') + '  ' + vm.$t('globalTrans.fiscal_year'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.fiscal_year_id ? vm.getFiscalYearName(application.development_planing.fiscal_year_id) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.expansion_planting'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.expansion_planting ? vm.$n(application.development_planing.expansion_planting) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.re_plantation'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.re_plantation ? vm.$n(application.development_planing.re_plantation) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.rubber'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.rubber ? vm.$n(application.development_planing.rubber) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.afforestation'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.afforestation ? vm.$n(application.development_planing.afforestation) : '', style: 'td', alignment: 'left', bold: true }
          ],
          [
            { text: vm.$t('teaGardenService.f') + '  ' + vm.$t('teaGardenService.other_plants'), style: 'labelMarginLeft', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: application.development_planing?.other_plants ? vm.$n(application.development_planing.other_plants) : '', style: 'td', alignment: 'left', bold: true }
          ]
        ]
        allRows.push([
          { text: vm.$t('teaGardenPanel.9') + '  ' + vm.$t('teaGardenService.forest_resource_section_area'), style: 'td', alignment: 'left', bold: true },
          {},
          {}
        ])
        // tree information display
        const sectionTreeRow = [
          [
            { text: vm.$t('teaGardenService.section_name'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.mouja'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.khotian'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.dag_no'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.tree_name'), style: 'td', alignment: 'center', bold: true },
            { text: vm.$t('teaGardenService.number_of_trees'), style: 'td', alignment: 'center', bold: true },
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
                  { text: vm.$n(treeItem.number_of_tree), style: 'td', alignment: 'center' },
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
              { text: vm.$n(item.cutting_trees.reduce((sum, { numberOfTrees }) => sum + Number(numberOfTrees), 0)), style: 'td', alignment: 'center', bold: true },
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
          { text: vm.$n(vm.totalNumberOfTrees), style: 'td', alignment: 'center', bold: true },
          { text: vm.$n(vm.totalNumberOfApprovedTrees), style: 'td', alignment: 'center', bold: true }
        ])
        sectionTreeRow.push([
          { text: currentLocale === 'bn' ? vm.convertNumberToBanglaWords(Number(vm.totalNumberOfTrees)) : vm.convertNumberToEnglishWords(Number(vm.totalNumberOfTrees)), style: 'td', alignment: 'right', colSpan: 6, bold: true },
          {},
          {},
          {},
          {},
          {},
          { text: currentLocale === 'bn' ? vm.convertNumberToBanglaWords(Number(vm.totalNumberOfApprovedTrees)) : vm.convertNumberToEnglishWords(Number(vm.totalNumberOfApprovedTrees)), style: 'td', alignment: 'center', bold: true }
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
            widths: ['40%', '1%', '59%'],
            body: allRows
          },
          layout: 'noBorders'
        })
        // check exist previous history
        if (previousPermissionData.application && previousPermissionData.application.status && previousPermissionData.application.status === 6) {
          // previous permission history
          pdfContent.push({ text: '', pageOrientation: 'portrait', pageBreak: 'after' })
          pdfContent.push({ text: vm.$t('teaGardenService.previous_tree_disposal_history'), style: 'hh', alignment: 'center', decoration: 'underline' })
          // 1
          const allRowsPrevious = [
            [
              { text: vm.$t('teaGardenPanel.1') + '  ' + vm.$t('teaGardenService.tree_class_of_forest_resources'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.tree_class_of_forest_resources ? vm.getTreeClassResource(previousPermissionData.tree_class_of_forest_resources) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenPanel.2') + '  ' + vm.$t('teaGardenService.description_of_forest_resource'), style: 'td', alignment: 'left', bold: true },
              {},
              {}
            ],
            [
              { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.plantation_year_label'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.plantation_year ? vm.$n(previousPermissionData.plantation_year.toString()) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.number_of_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.number_of_trees ? vm.$n(previousPermissionData.number_of_trees) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.size'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.size ? vm.$n(previousPermissionData.size) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.quantity_approx'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.quantity_approx ? vm.$n(previousPermissionData.quantity_approx) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.e') + '  ' + vm.$t('teaGardenService.unit_quantity'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: application.unit_quantity ? vm.getUnitName(previousPermissionData.unit_quantity) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenPanel.3') + '  ' + vm.$t('teaGardenService.disposal_plan'), style: 'td', alignment: 'left', bold: true },
              {},
              {}
            ],
            [
              { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.total_cutable_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.total_cutable_trees), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.number_of_re_plantable_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.number_of_re_plantable_tree), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.number_of_very_old_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.number_of_very_old_trees), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.number_of_rubber_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.number_of_rubber_tree), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.e') + '  ' + vm.$t('teaGardenService.number_of_disease_tree'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.number_of_disease_tree), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.f') + '  ' + vm.$t('teaGardenService.number_of_other_trees'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(previousPermissionData.cutting_purpose?.number_of_other_trees), style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenPanel.4') + '  ' + vm.$t('globalTrans.fiscal_year'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.fiscal_year_id ? vm.getFiscalYearName(previousPermissionData.development_planing.fiscal_year_id) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.a') + '  ' + vm.$t('teaGardenService.expansion_planting'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.expansion_planting ? vm.$n(previousPermissionData.development_planing.expansion_planting) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.b') + '  ' + vm.$t('teaGardenService.re_plantation'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.re_plantation ? vm.$n(previousPermissionData.development_planing.re_plantation) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.c') + '  ' + vm.$t('teaGardenService.rubber'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.rubber ? vm.$n(previousPermissionData.development_planing.rubber) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.d') + '  ' + vm.$t('teaGardenService.afforestation'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.afforestation ? vm.$n(previousPermissionData.development_planing.afforestation) : '', style: 'td', alignment: 'left', bold: true }
            ],
            [
              { text: vm.$t('teaGardenService.f') + '  ' + vm.$t('teaGardenService.other_plants'), style: 'labelMarginLeft', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: previousPermissionData.development_planing?.other_plants ? vm.$n(previousPermissionData.development_planing.other_plants) : '', style: 'td', alignment: 'left', bold: true }
            ]
          ]
          allRowsPrevious.push([
            { text: vm.$t('teaGardenPanel.5') + '  ' + vm.$t('teaGardenService.forest_resource_section_area'), style: 'td', alignment: 'left', bold: true },
            {},
            {}
          ])
          // tree information display
          const sectionTreeRowPrevious = [
            [
              { text: vm.$t('teaGardenService.section_name'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.mouja'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.khotian'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.dag_no'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.tree_name'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.number_of_trees'), style: 'td', alignment: 'center', bold: true },
              { text: vm.$t('teaGardenService.approved_tree'), style: 'td', alignment: 'center', bold: true }
            ]
          ]
          if (previousPermissionData.tree_cutting_locations.length) {
            previousPermissionData.tree_cutting_locations.forEach((item, index) => {
              if (item.cutting_trees.length) {
                item.cutting_trees.forEach(treeItem => {
                  sectionTreeRowPrevious.push([
                    { text: vm.getSectionName(item.section_id), style: 'td', alignment: 'left', rowSpan: item.cutting_trees.length },
                    { text: currentLocale === 'en' ? item.mouja_en : item.mouja_bn, style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                    { text: item.khotian_no ? vm.EngBangNum(item.khotian_no) : '', style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                    { text: item.dag_no ? vm.EngBangNum(item.dag_no) : '', style: 'td', alignment: 'center', rowSpan: item.cutting_trees.length },
                    { text: vm.getTreeName(treeItem.tree_id), style: 'td', alignment: 'center' },
                    { text: vm.$n(treeItem.number_of_tree), style: 'td', alignment: 'center' },
                    { text: vm.$n(treeItem.approved_tree), style: 'td', alignment: 'center' }
                  ])
                })
              }
              sectionTreeRowPrevious.push([
                { text: vm.$t('teaGardenService.sub_total'), style: 'td', alignment: 'right', colSpan: 5, bold: true },
                {},
                {},
                {},
                {},
                { text: vm.$n(item.cutting_trees.reduce((sum, { numberOfTrees }) => sum + Number(numberOfTrees), 0)), style: 'td', alignment: 'center', bold: true },
                { text: vm.$n(item.cutting_trees.reduce((sum, { approvedTrees }) => sum + Number(approvedTrees), 0)), style: 'td', alignment: 'center', bold: true }
              ])
            })
          }
          sectionTreeRowPrevious.push([
            { text: vm.$t('teaGardenService.grand_total'), style: 'td', alignment: 'right', colSpan: 5, bold: true },
            {},
            {},
            {},
            {},
            { text: vm.$n(vm.totalNumberOfTreesPrevious), style: 'td', alignment: 'center', bold: true },
            { text: vm.$n(vm.totalNumberOfApprovedTreesPrevious), style: 'td', alignment: 'center', bold: true }
          ])
          sectionTreeRowPrevious.push([
            { text: currentLocale === 'bn' ? vm.convertNumberToBanglaWords(Number(vm.totalNumberOfTreesPrevious)) : vm.convertNumberToEnglishWords(Number(vm.totalNumberOfTreesPrevious)), style: 'td', alignment: 'right', colSpan: 6, bold: true },
            {},
            {},
            {},
            {},
            {},
            { text: currentLocale === 'bn' ? vm.convertNumberToBanglaWords(Number(vm.totalNumberOfApprovedTreesPrevious)) : vm.convertNumberToEnglishWords(Number(vm.totalNumberOfApprovedTreesPrevious)), style: 'td', alignment: 'center', bold: true }
          ])
          allRowsPrevious.push(
            [
              {
                table: {
                  body: sectionTreeRowPrevious
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
              widths: ['40%', '1%', '59%'],
              body: allRowsPrevious
            },
            layout: 'noBorders'
          })
        }
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: '--------------------------------------------', style: 'signatureBorder', alignment: 'right' })
        pdfContent.push({ text: vm.$t('teaGardenService.tree_disposal_applicant_signature'), style: 'signatureBorder', alignment: 'right' })
        pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({ text: '---------------------------------------------', style: 'signatureBorder', alignment: 'right' })
        pdfContent.push({ text: vm.$t('teaGardenService.tree_disposal_owner_signature'), style: 'signatureBorder', alignment: 'right' })
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
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            margin: [3, 3, 3, 3]
          },
          labelMarginLeft: {
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            margin: [30, 3, 3, 3]
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
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
            bold: true
          },
          app_id: {
            margin: [15, 10, 0, 5],
            fontSize: (i18n.locale === 'bn') ? 9 : 9
          },
          signatureBorder: {
            margin: [0, 0, 0, 0],
            fontSize: (i18n.locale === 'bn') ? 9 : 9,
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
          noMargin: {
            margin: [0, 0, 0, 0],
            fontSize: (i18n.locale === 'bn') ? 14 : 13
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
