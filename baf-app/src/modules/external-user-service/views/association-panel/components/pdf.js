import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat, mobileNumber } from '@/utils/fliter'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, appDetail) => {
  try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
        if (i18n.locale === 'bn') {
          pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        }
        const pdfContent = []
        pdfContent.push({
          style: 'tableExample',
          table: {
            widths: ['20%', '60%', '20%'],
            headerRows: 1,
            body: [
              [{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.application_form') + ' (' + (appDetail.type === 1 ? vm.$t('dealer.new') : vm.$t('globalTrans.renew')) + ')', style: 'tableHeader' }, { text: '', style: 'tableHeader' }],
              [{ text: vm.$t('dealer.agreement_no'), style: 'tableHeaderFour' }, '', { text: vm.$t('dealer.expire_date'), style: 'tableHeaderFour' }]
            ]
          },
          layout: 'headerLineOnly'
        })
        pdfContent.push({
          style: 'tableExample',
          table: {
            headerRows: 1,
            body: [
              [{ text: vm.$t('dealer.chairman'), style: 'chanirman' }],
              [{ text: vm.$t('dealer.tcb'), style: 'tableHeaderThree' }],
              [{ text: vm.$t('dealer.tcb_address'), style: 'tableHeaderThree' }],
              [{ text: vm.$t('dealer.subject'), style: 'tableHeaderFive' }],
              [{ text: vm.$t('dealer.sir'), style: 'tableHeaderThree' }],
              [{ text: '                ' + vm.$t('dealer.application_text_one'), style: 'tableHeaderThree' }]
            ]
          },
          layout: 'noBorders'
        })
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              [{ text: vm.$t('dealer.applicant_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.applicant_name_bn : appDetail.details.applicant_name, style: 'tablecell' }, { text: vm.$t('dealer.father_spouse_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.father_spouse_name_bn : appDetail.details.father_spouse_name, style: 'tablecell' }],
              [{ text: vm.$t('dealer.company_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name, style: 'tablecell' }, { text: vm.$t('dealer.dob'), style: 'tablecell' }, { text: dateFormat(appDetail.details.dob), style: 'tablecell' }],
              [{ text: vm.$t('dealer.nid_no'), style: 'tablecell' }, { text: vm.$n(appDetail.details.nid_no, { useGrouping: false }), style: 'tablecell' }, { text: vm.$t('dealer.marital_status'), style: 'tablecell' }, { text: vm.getMeritalStatus(appDetail.details.marital_status), style: 'tablecell' }],
              [{ text: vm.$t('dealer.spouse_nid_no'), style: 'tablecell' }, { text: appDetail.details.spouse_nid_no ? vm.$n(appDetail.details.spouse_nid_no, { useGrouping: false }) : '', style: 'tablecell' }, { text: vm.$t('dealer.father_nid_no'), style: 'tablecell' }, { text: appDetail.details.father_nid_no ? vm.$n(appDetail.details.father_nid_no, { useGrouping: false }) : '', style: 'tablecell' }],
              [{ text: vm.$t('dealer.email'), style: 'tablecell' }, { text: appDetail.details.email, style: 'tablecell' }, { text: vm.$t('dealer.tin_no'), style: 'tablecell' }, { text: appDetail.details.tin_no, style: 'tablecell' }],
              [{ text: vm.$t('dealer.mobile'), style: 'tablecell' }, { text: mobileNumber(appDetail.details.mobile), colSpan: 2, style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }]
            ]
          },
          layout: {
            fillColor: function (rowIndex, node, columnIndex) {
              return (rowIndex % 2 === 0) ? '#CCCCCC' : null
            }
          }
        })
        if (appDetail.details.other_family_license) {
          pdfContent.push({ text: vm.$t('dealer.tcb_license_text') + ' ' + vm.$t('globalTrans.yes'), style: 'tableHeaderSix' })
          pdfContent.push({
            style: 'tableExampleGrid',
            table: {
              widths: ['20%', '30%', '20%', '30%'],
              body: [
                [{ text: vm.$t('dealer.dealer_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.other_dealer_name_bn : appDetail.details.other_dealer_name, style: 'tablecell' }, { text: vm.$t('dealer.company_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.other_company_name_bn : appDetail.details.other_company_name, style: 'tablecell' }],
                [{ text: vm.$t('globalTrans.division'), style: 'tablecell' }, { text: vm.getDivisionName(appDetail.details.other_company_division_id), style: 'tablecell' }, { text: vm.$t('globalTrans.district'), style: 'tablecell' }, { text: vm.getDistrictName(appDetail.details.other_company_district_id), style: 'tablecell' }],
                [{ text: vm.$t('globalTrans.upazila'), style: 'tablecell' }, { text: vm.getUpazillaName(appDetail.details.other_company_upazilla_id), style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }]
              ]
            },
            layout: {
              fillColor: function (rowIndex, node, columnIndex) {
                return (rowIndex % 2 === 0) ? '#CCCCCC' : null
              }
            }
          })
        } else {
          pdfContent.push({ text: vm.$t('dealer.tcb_license_text') + ' ' + vm.$t('globalTrans.no'), style: 'tableHeaderSix' })
        }
        pdfContent.push({ text: vm.$t('dealer.company_details_a'), style: 'tableHeaderSix' })
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              [{ text: vm.$t('allocation_management.dealer_type'), style: 'tablecell' }, { text: vm.getDealerType(appDetail.dealer_type), style: 'tablecell' }, { text: vm.$t('dealer.company_name'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name, style: 'tablecell' }],
              [{ text: vm.$t('orgProfile.city_corporation'), style: 'tablecell' }, { text: vm.getCityCorName(appDetail.details.company_city_corporation_id), style: 'tablecell' }, { text: vm.$t('globalTrans.division'), style: 'tablecell' }, { text: vm.getDivisionName(appDetail.details.company_division_id), style: 'tablecell' }],
              [{ text: vm.$t('globalTrans.district'), style: 'tablecell' }, { text: vm.getDistrictName(appDetail.details.company_district_id), style: 'tablecell' }, { text: vm.$t('globalTrans.upazila'), style: 'tablecell' }, { text: vm.getUpazillaName(appDetail.details.company_upazilla_id), style: 'tablecell' }],
              [{ text: vm.$t('globalTrans.union'), style: 'tablecell' }, { text: vm.getUnionName(appDetail.details.company_union_id), style: 'tablecell' }, { text: vm.$t('globalTrans.ward'), style: 'tablecell' }, { text: vm.getWardName(appDetail.details.company_ward_id), style: 'tablecell' }],
              [{ text: vm.$t('globalTrans.office'), style: 'tablecell' }, { text: vm.getOfficeName(appDetail.office_id), style: 'tablecell' }, { text: '', style: 'tablecell' }, { text: '', style: 'tablecell' }]
            ]
          },
          layout: {
            fillColor: function (rowIndex, node, columnIndex) {
              return (rowIndex % 2 === 0) ? '#CCCCCC' : null
            }
          }
        })
        pdfContent.push({ text: vm.$t('dealer.permanent_address'), style: 'tableHeaderSix' })
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              [{ text: vm.$t('orgProfile.city_corporation'), style: 'tablecell' }, { text: vm.getCityCorName(appDetail.details.company_city_corporation_id), style: 'tablecell' }, { text: vm.$t('globalTrans.division'), style: 'tablecell' }, { text: vm.getDivisionName(appDetail.details.division_id), style: 'tablecell' }],
              [{ text: vm.$t('globalTrans.district'), style: 'tablecell' }, { text: vm.getDistrictName(appDetail.details.district_id), style: 'tablecell' }, { text: vm.$t('globalTrans.upazila'), style: 'tablecell' }, { text: vm.getUpazillaName(appDetail.details.upazilla_id), style: 'tablecell' }],
              [{ text: vm.$t('globalTrans.union'), style: 'tablecell' }, { text: vm.getUnionName(appDetail.details.union_id), style: 'tablecell' }, { text: vm.$t('dealer.village'), style: 'tablecell' }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.village_bn : appDetail.details.village, style: 'tablecell' }]
            ]
          },
          layout: {
            fillColor: function (rowIndex, node, columnIndex) {
              return (rowIndex % 2 === 0) ? '#CCCCCC' : null
            }
          }
        })
        pdfContent.push({ text: vm.$t('dealer.application_text_two'), style: 'tableHeaderFive' })
        pdfContent.push({
          style: 'tableExample',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              ['', '', '', { text: vm.$t('dealer.sincerely_yours'), style: 'tableHeaderEight' }],
              ['', '', '', { text: vm.$t('dealer.name') + '..................', style: 'tableHeaderSeven' }],
              ['', '', '', { text: vm.$t('dealer.phone_no') + '.............', style: 'tableHeaderSeven' }]
            ]
          },
          layout: 'noBorders'
        })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'Landcape',
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
            fontSize: (i18n.locale === 'bn') ? 10 : 8,
            margin: [3, 3, 3, 3]
          },
          fertilizer: {
            margin: [5, 0, 0, 5]
          },
          header: {
            fontSize: 12,
            margin: [0, 0, 0, 4]
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
          },
          img_logo: {
            margin: [20, 0, 0, 0]
          },
          img_logo_two: {
            margin: [25, 0, 0, 0]
          },
          reportHeading: {
            fontSize: 13,
            margin: [0, 10, 0, 0]
          },
          headerTwo: {
            fontSize: 12,
            margin: [0, -10, 0, 0]
          },
          headerThree: {
            fontSize: 9,
            margin: [0, 1, 0, 0]
          },
          giveUnderline: {
            decoration: 'underline',
            margin: [0, 0, 0, 0]
          },
          tableHeader: {
            alignment: 'center'
          },
          tableHeaderTwo: {
            fontSize: 9,
            alignment: 'center',
            margin: [0, 10, 0, 0]
          },
          tableHeaderThree: {
            alignment: 'left',
            margin: [0, 0, 0, 0]
          },
          tableHeaderFour: {
            alignment: 'left',
            margin: [0, 10, 0, 0]
          },
          chanirman: {
            alignment: 'left',
            margin: [0, 40, 0, 0]
          },
          tableHeaderFive: {
            alignment: 'left',
            bold: true
          },
          tableExampleGrid: {
            margin: [0, 5, 5, 0]
          },
          tableHeaderSix: {
            fontSize: 15,
            margin: [0, 8, 8, 0]
          },
          tableHeaderSeven: {
            fontSize: 10,
            margin: [0, 0, 0, 0]
          },
          tableHeaderEight: {
            fontSize: 10,
            margin: [20, 0, 0, 0]
          },
          tablecell: {
            fontSize: 10
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
