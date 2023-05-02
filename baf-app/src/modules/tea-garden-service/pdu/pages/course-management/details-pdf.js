import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head-tea-garden'
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
      const pdfContent = [
        { columns: reportHeadData.reportHeadColumn },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center', decoration: 'underline' }
      ]
        const currentLocale = vm.currentLocale
        const appDetail = vm.appDetail
        // pdfContent.push({ text: vm.$t('teaGardenService.appDetail_id') + ' : ' + appDetail.app_id, style: 'normalText', alignment: 'right' })
        // pdfContent.push({ text: '', style: 'normalText' })
        pdfContent.push({
          columns: [
            {
              columns: [
                {
                  text: vm.$t('teaGardenService.application_id') + ' : ', style: 'td', bold: true, width: 'auto'
                },
                {
                  text: appDetail.application.app_id, style: 'td', bold: false, width: 'auto'
                }
              ]
            },
            {
              alignment: 'right',
              columns: [
                {
                  text: vm.$t('externalLrcpn.expire_date') + ' : ', style: 'td', bold: true, alignment: 'right', width: '*'
                },
                {
                  text: dateFormat(appDetail.application.expired_date), style: 'td', bold: false, alignment: 'right', width: 100
                }
              ]
            }
            // ,
            // {
            //   text: vm.$t('externalUser.issue_date') + ' : ', style: 'td', bold: true, width: 'auto'
            // },
            // {
            //   text: dateFormat(appDetail.application.issue_date), style: 'td', bold: false, width: 'auto'
            // },
            // {
            //   text: vm.$t('externalLrcpn.expire_date') + ' : ', style: 'td', bold: true, alignment: 'right'
            // },
            // {
            //   text: dateFormat(appDetail.application.expired_date), style: 'td', bold: false, alignment: 'right'
            // }
          ]
        })
        // 1 Garden Info
        const allRows = [
          [
            { text: vm.$n(1) + '.  ' + vm.$t('teaGardenPanel.applicant_info'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('globalTrans.applicant_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? appDetail.applicant_name_en : appDetail.applicant_name_bn, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('globalTrans.designation'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? appDetail.designation_en : appDetail.designation_bn, style: 'td', alignment: 'left', bold: false }
          ]
        ]
        // 2 Address Info
        allRows.push(
          [
            { text: vm.$n(2) + '.  ' + vm.$t('teaGardenConfig.garden_address'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenConfig.tea_garden_name'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? appDetail.tea_garden_name_en : appDetail.tea_garden_name_bn, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('globalTrans.area_type'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getAreaTypeName(appDetail.area_type_id), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('globalTrans.division'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDivisionName(appDetail.division_id), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('globalTrans.district'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getDistrictName(appDetail.district_id), style: 'td', alignment: 'left', bold: false }
          ]
        )
        if (appDetail.area_type_id === 1) {
          allRows.push([
            { },
            { text: vm.$t('globalTrans.city_corporation'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getCityCorName(appDetail.city_corporation_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        if (appDetail.area_type_id === 2 || appDetail.area_type_id === 3) {
          allRows.push([
            { },
            { text: vm.$t('globalTrans.upazila'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getUpazillaName(appDetail.upazila_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        if (appDetail.area_type_id === 2) {
          allRows.push([
            { },
            { text: vm.$t('globalTrans.pouroshova'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getPouroName(appDetail.pauroshoba_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        if (appDetail.area_type_id === 3) {
          allRows.push([
            { },
            { text: vm.$t('globalTrans.union'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getUnionName(appDetail.union_id), style: 'td', alignment: 'left', bold: false }
          ])
        }
        allRows.push(
          [
            { },
            { text: vm.$t('globalTrans.ward'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.getWardName(appDetail.ward_id), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('bazarMonitoring.post_code'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: appDetail.post_code ? vm.$n(appDetail.post_code) : '', style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('globalTrans.address'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? appDetail.address_en : appDetail.address_bn, style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 3 Other Garden Info
        allRows.push(
          [
            { text: vm.$n(3) + '.  ' + vm.$t('teaGardenPanel.applicant_have_garden'), style: 'td', alignment: 'left', bold: true },
            { },
            { text: ':', alignment: 'center' },
            { text: vm.getYesNoValue(appDetail.have_other_tea_garden), style: 'td', alignment: 'left', bold: false }
          ]
        )
        if (appDetail.have_other_tea_garden === 1) {
          const gardenTableRows = [
            [
              { text: vm.$t('teaGardenConfig.tea_garden_name'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('globalTrans.area_type'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('globalTrans.division'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('globalTrans.district'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('globalTrans.address'), style: 'td', alignment: 'left', bold: true }
            ]
          ]
          appDetail.others.forEach((item, index) => {
            gardenTableRows.push([
              { text: currentLocale === 'en' ? item.tea_garden_name_en : item.tea_garden_name_bn, style: 'td', alignment: 'left' },
              { text: vm.getAreaTypeName(item.area_type_id), style: 'td', alignment: 'left' },
              { text: vm.getDivisionName(item.division_id), style: 'td', alignment: 'left' },
              { text: vm.getDistrictName(item.district_id), style: 'td', alignment: 'left' },
              { text: currentLocale === 'en' ? item.address_en : item.address_bn, style: 'td', alignment: 'left' }
            ])
          })
          allRows.push(
            [
              { },
              { },
              { },
              {
                table: {
                  body: gardenTableRows
                }
              }
            ]
          )
        }
        // 4 investing info
       allRows.push([
        { text: vm.$n(4) + '.  ' + vm.$t('teaGardenPanel.applicant_capable_of_investing'), style: 'td', alignment: 'left', bold: true },
        { },
        { text: ':', alignment: 'center' },
        { text: vm.getYesNoValue(appDetail.has_investing_capability), style: 'td', alignment: 'left', bold: false }
      ])
      if (appDetail.has_investing_capability === 1) {
        allRows.push([
          { },
          { text: vm.$t('teaGardenPanel.income_tax_amount'), style: 'td', alignment: 'left', bold: true },
          { text: ':', alignment: 'center' },
          { text: vm.$n(appDetail.income_tax_amount), style: 'td', alignment: 'left', bold: false }
        ])
      }
     // 5
       allRows.push([
        { text: vm.$n(5) + '.  ' + vm.$t('teaGardenPanel.reason_of_rejection'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? appDetail.reason_of_rejection_en : appDetail.reason_of_rejection_bn, style: 'td', alignment: 'left', bold: false }
      ])
      allRows.push([
        { text: vm.$n(6) + '.  ' + vm.$t('teaGardenPanel.trade_license_no'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: vm.$n(appDetail.trade_license_no), style: 'td', alignment: 'left', bold: false }
      ])
      allRows.push([
        { text: vm.$n(7) + '.  ' + vm.$t('globalTrans.mobile'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: mobileNumber(appDetail.mobile), style: 'td', alignment: 'left', bold: false }
      ])
      allRows.push([
        { text: vm.$n(8) + '.  ' + vm.$t('globalTrans.email'), style: 'td', alignment: 'left', bold: true },
        {},
        { text: ':', alignment: 'center' },
        { text: appDetail.email, style: 'td', alignment: 'left', bold: false }
      ])
    //  9
      allRows.push([
        { text: vm.$n(9) + '.  ' + vm.$t('teaGardenPanel.identity_of_proprietor'), style: 'td', alignment: 'left', bold: true },
        { text: vm.$t('dealer.company_name'), style: 'td', alignment: 'left', bold: true },
        { text: ':', alignment: 'center' },
        { text: currentLocale === 'en' ? appDetail.proprietor_identity.company_name_en : appDetail.proprietor_identity.company_name_bn, style: 'td', alignment: 'left', bold: false }
     ])
      const ownerTableRow = [
        [
          { text: vm.$t('teaGardenPanel.owner_name'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.father_name'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.mother_name'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.nationality'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.mobile'), style: 'td', alignment: 'left', bold: true },
          { text: vm.$t('globalTrans.permanent_address'), style: 'td', alignment: 'left', bold: true }
        ]
      ]
      if (appDetail.proprietor_identity.owners.length) {
        appDetail.proprietor_identity.owners.forEach((item, index) => {
          ownerTableRow.push([
            { text: currentLocale === 'en' ? item.garden_owner_name_en : item.garden_owner_name_bn, style: 'td', alignment: 'left', bold: false },
            { text: currentLocale === 'en' ? item.garden_owner_father_name_en : item.garden_owner_father_name_bn, style: 'td', alignment: 'left', bold: false },
            { text: currentLocale === 'en' ? item.garden_owner_mother_name_en : item.garden_owner_mother_name_bn, style: 'td', alignment: 'left', bold: false },
            { text: vm.getNationalityName(item.garden_owner_nationality), style: 'td', alignment: 'left', bold: false },
            { text: mobileNumber(item.mobile), style: 'td', alignment: 'left', bold: false },
            { text: currentLocale === 'en' ? item.permanent_address_en : item.permanent_address_bn, style: 'td', alignment: 'left', bold: false }
          ])
        })
      } else {
        ownerTableRow.push([
          { text: vm.$t('globalTrans.noDataFound'), style: 'td', alignment: 'center', bold: false, colSpan: 6 },
          { },
          { },
          { },
          { },
          { }
        ])
      }
      allRows.push([
        { },
        { },
        { },
        {
          table: {
            body: ownerTableRow
          }
        }
      ])
       // 10
       allRows.push([
          { text: vm.$n(10) + '.  ' + vm.$t('teaGardenPanel.experience'), style: 'td', alignment: 'left', bold: true },
          {},
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? appDetail.proprietor_identity.experience_en : appDetail.proprietor_identity.experience_bn, style: 'td', alignment: 'left', bold: false }
        ])
        // 11
        allRows.push(
          [
            { text: vm.$n(11) + '.  ' + vm.$t('teaGardenPanel.ownership_acquired_type'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenPanel.year_of_granting_lease'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.year_of_granting_lease, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.period_of_lease'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.period_of_lease, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 12
        allRows.push(
          [
            { text: vm.$n(12) + '.  ' + vm.$t('teaGardenPanel.particular_of_land'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenPanel.total_grant_area'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.total_grant_area), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.area_under_tea'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.area_under_tea), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.total_suitable_land'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.total_suitable_land), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.total_unsuitable_land'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.total_unsuitable_land), style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 13
        allRows.push([
          { text: vm.$n(13) + '.  ' + vm.$t('teaGardenPanel.favour_garden_land'), style: 'td', alignment: 'left', bold: true },
          {},
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? appDetail.land_ownership_info.favour_garden_land_en : appDetail.land_ownership_info.favour_garden_land_bn, style: 'td', alignment: 'left', bold: false }
        ])
        // 14
        allRows.push(
          [
            { text: vm.$n(14) + '.  ' + vm.$t('teaGardenPanel.land_schedule_owner'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenPanel.mouja'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: currentLocale === 'en' ? appDetail.land_ownership_info.mouja_en : appDetail.land_ownership_info.mouja_bn, style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.khotian'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.khotian_no, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.dag_no'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.dag_no, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 15
        allRows.push(
          [
            { text: vm.$n(15) + '.  ' + vm.$t('teaGardenPanel.plantation_product_start_year'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenPanel.year_plantation'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.year_plantation, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.year_production'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.year_production, { useGrouping: false }), style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 16
        allRows.push(
          [
            { text: vm.$n(16) + '.  ' + vm.$t('teaGardenPanel.last_three_year_production'), style: 'td', alignment: 'left', bold: true },
            { text: vm.$t('teaGardenPanel.average_production'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.average_production), style: 'td', alignment: 'left', bold: false }
          ],
          [
            { },
            { text: vm.$t('teaGardenPanel.average_sale_price'), style: 'td', alignment: 'left', bold: true },
            { text: ':', alignment: 'center' },
            { text: vm.$n(appDetail.land_ownership_info.average_sale_price), style: 'td', alignment: 'left', bold: false }
          ]
        )
        // 17
        allRows.push([
          { text: vm.$n(17) + '.  ' + vm.$t('teaGardenPanel.appointed_broker_name'), style: 'td', alignment: 'left', bold: true },
          {},
          { text: ':', alignment: 'center' },
          { text: currentLocale === 'en' ? appDetail.land_ownership_info.appointed_broker_name_en : appDetail.land_ownership_info.appointed_broker_name_bn, style: 'td', alignment: 'left', bold: false }
        ])
        // 18
        allRows.push(
          [
            { text: vm.$n(18) + '.  ' + vm.$t('teaGardenPanel.does_garden_possesses_factory'), style: 'td', alignment: 'left', bold: true },
            { },
            { text: ':', alignment: 'center' },
            { text: vm.getYesNoValue(appDetail.land_ownership_info.does_garden_possesses_factory), style: 'td', alignment: 'left', bold: false }
          ]
        )
        if (appDetail.land_ownership_info.does_garden_possesses_factory === 1) {
          allRows.push(
            [
              { },
              { text: vm.$t('teaGardenPanel.production_capacity'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.land_ownership_info.production_capacity), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.transformer_capacity'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.land_ownership_info.transformer_capacity), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.withering_capacity'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.land_ownership_info.withering_capacity), style: 'td', alignment: 'left', bold: false }
            ]
          )
        }
          // 19 other facilities
          allRows.push(
            [
              { text: vm.$n(19) + '.  ' + vm.$t('teaGardenPanel.other_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('teaGardenPanel.residence_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_residence_facilities), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.school_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_school_facilities), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.hospital_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_hospital_facilities), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.mosque_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_mosque_facilities), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.club_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_club_facilities), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.drinking_water_facilities'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.getYesNoValue(appDetail.other_info.has_drinking_water_facilities), style: 'td', alignment: 'left', bold: false }
            ]
          )
          // 20 other facilities
          allRows.push(
            [
              { text: vm.$n(20) + '.  ' + vm.$t('teaGardenPanel.manpower_information'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('teaGardenPanel.no_of_officers'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.other_info.no_of_officers), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.no_of_stuffs'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.other_info.no_of_stuffs), style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('teaGardenPanel.no_of_workers'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: vm.$n(appDetail.other_info.no_of_workers), style: 'td', alignment: 'left', bold: false }
            ]
          )
          // 21 First Witness Info
          allRows.push(
            [
              { text: vm.$n(21) + '.  ' + vm.$t('teaGardenPanel.first_witness_info'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('teaGardenPanel.witness_name'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: currentLocale === 'en' ? appDetail.witness_info.first_witness_name_en : appDetail.witness_info.first_witness_name_bn, style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('globalTrans.address'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: currentLocale === 'en' ? appDetail.witness_info.first_witness_address_en : appDetail.witness_info.first_witness_address_bn, style: 'td', alignment: 'left', bold: false }
            ]
          )
          // 22 Second Witness Info
          allRows.push(
            [
              { text: vm.$n(22) + '.  ' + vm.$t('teaGardenPanel.second_witness_info'), style: 'td', alignment: 'left', bold: true },
              { text: vm.$t('teaGardenPanel.witness_name'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: currentLocale === 'en' ? appDetail.witness_info.second_witness_name_en : appDetail.witness_info.second_witness_name_bn, style: 'td', alignment: 'left', bold: false }
            ],
            [
              { },
              { text: vm.$t('globalTrans.address'), style: 'td', alignment: 'left', bold: true },
              { text: ':', alignment: 'center' },
              { text: currentLocale === 'en' ? appDetail.witness_info.second_witness_address_en : appDetail.witness_info.second_witness_address_bn, style: 'td', alignment: 'left', bold: false }
            ]
          )
        pdfContent.push({
          table: {
            headerRows: 0,
            widths: ['25%', '15%', '3%', '57%'],
            body: allRows
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
        pageOrientation: 'landscape',
        // pageOrientation: 'portrait',
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
