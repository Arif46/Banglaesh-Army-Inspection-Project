import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
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
        const pdfContent = []
        if (appDetail.agreement_no) {
          pdfContent.push({
            style: 'tableExample',
            table: {
              widths: ['30%', '35%', '35%'],
              headerRows: 1,
              body: [
                [{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.application_form') + ' (' + (appDetail.type === 1 ? vm.$t('dealer.new') : vm.$t('globalTrans.renew')) + ')', style: 'tableHeader' }, { text: '', style: 'tableHeader' }],
                [{ text: vm.$t('dealer.agreement_no') + ' ' + vm.$n(appDetail.agreement_no, { useGrouping: false }), style: 'tableHeaderFour' }, '', { text: vm.$t('dealer.expire_date') + ' ' + dateFormat(appDetail.expire_date), style: 'tableHeaderFour' }]
              ]
            },
            layout: 'headerLineOnly'
          })
        } else {
          pdfContent.push({
            style: 'tableExample',
            table: {
              widths: ['20%', '50%', '30%'],
              headerRows: 1,
              body: [
                // [{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.application_form') + ' (' + (appDetail.type === 1 ? vm.$t('dealer.new') : vm.$t('globalTrans.renew')) + ')', style: 'tableHeader' }, { text: '', style: 'tableHeader' }],
                [{ text: '', style: 'tableHeader' }, { text: vm.$t('dealer.application_form'), style: 'tableHeader' }, { text: '', style: 'tableHeader' }]
                // [{ text: vm.$t('dealer.agreement_no') + ' ' + ' ', style: 'tableHeaderFour' }, '', { text: vm.$t('dealer.expire_date') + ' ' + dateFormat(appDetail.expire_date), style: 'tableHeaderFour' }]
              ]
            },
            layout: 'headerLineOnly'
          })
        }
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            headerRows: 1,
            body: [
              [{ text: vm.$t('dealer.chairman'), style: 'chanirman' }],
              [{ text: vm.$t('dealer.tcb'), style: 'tableHeaderThree' }],
              [{ text: vm.$t('dealer.tcb_address'), style: 'tableHeaderThree' }],
              [{ text: vm.$t('dealer.subject'), style: 'tableHeaderThree' }],
              [{ text: vm.$t('dealer.sir'), style: 'tableHeaderThree' }],
              [{ text: ' ' + vm.$t('dealer.application_text_one'), style: 'tableHeaderThree' }]
            ]
          },
          layout: 'noBorders'
        })
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              [{ text: vm.$t('dealer.applicant_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.applicant_name_bn : appDetail.details.applicant_name }, { text: vm.$t('dealer.father_spouse_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.father_spouse_name_bn : appDetail.details.father_spouse_name }],
              [{ text: vm.$t('dealer.company_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name }, { text: vm.$t('dealer.dob') }, { text: dateFormat(appDetail.details.dob) }],
              [{ text: vm.$t('dealer.nid_no') }, { text: vm.$n(appDetail.details.nid_no, { useGrouping: false }) }, { text: vm.$t('dealer.marital_status') }, { text: vm.getMeritalStatus(appDetail.details.marital_status) }],
              [{ text: vm.$t('dealer.spouse_nid_no') }, { text: appDetail.details.spouse_nid_no ? vm.$n(appDetail.details.spouse_nid_no, { useGrouping: false }) : '' }, { text: vm.$t('dealer.father_nid_no') }, { text: appDetail.details.father_nid_no ? vm.$n(appDetail.details.father_nid_no, { useGrouping: false }) : '' }],
              [{ text: vm.$t('dealer.email') }, { text: appDetail.details.email }, { text: vm.$t('dealer.tin_no') }, { text: vm.$n(appDetail.details.tin_no, { useGrouping: false }) }],
              [{ text: vm.$t('dealer.mobile') }, { text: mobileNumber(appDetail.details.mobile), colSpan: 2 }, '', '']
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
                [{ text: vm.$t('dealer.dealer_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.other_dealer_name_bn : appDetail.details.other_dealer_name }, { text: vm.$t('dealer.company_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.other_company_name_bn : appDetail.details.other_company_name }],
                [{ text: vm.$t('globalTrans.division') }, { text: vm.getDivisionName(appDetail.details.other_company_division_id) }, { text: vm.$t('globalTrans.district') }, { text: vm.getDistrictName(appDetail.details.other_company_district_id) }],
                [{ text: vm.$t('globalTrans.upazila') }, { text: vm.getUpazillaName(appDetail.details.other_company_upazilla_id) }, { text: '' }, { text: '' }]
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
              [
                { text: vm.$t('dealer.company_name') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.company_name_bn : appDetail.details.company_name },
                { text: vm.$t('globalTrans.office') }, { text: vm.getOfficeName(appDetail.office_id) }
              ],
              [
                { text: vm.$t('globalTrans.division') }, { text: vm.getDivisionName(appDetail.details.company_division_id) },
                { text: vm.$t('globalTrans.district') }, { text: vm.getDistrictName(appDetail.details.company_district_id) }
              ],
              [
                { text: vm.$t('globalTrans.upazila') }, { text: vm.getUpazillaName(appDetail.details.company_upazilla_id) },
                { text: '' }, { text: '' }
              ]
            ]
          },
          layout: {
            fillColor: function (rowIndex, node, columnIndex) {
              return (rowIndex % 2 === 0) ? '#CCCCCC' : null
            }
          }
        })
        pdfContent.push({ text: vm.$t('externalLrcpn.permanent_address'), style: 'tableHeaderSix' })
        pdfContent.push({
          style: 'tableExampleGrid',
          table: {
            widths: ['20%', '30%', '20%', '30%'],
            body: [
              [
                { text: vm.$t('globalTrans.division') }, { text: vm.getDivisionName(appDetail.details.division_id) },
                { text: vm.$t('globalTrans.district') }, { text: vm.getDistrictName(appDetail.details.district_id) }
              ],
              [
                { text: vm.$t('globalTrans.upazila') }, { text: vm.getUpazillaName(appDetail.details.upazilla_id) },
                { text: vm.$t('globalTrans.union') }, { text: vm.getUnionName(appDetail.details.union_id) }
              ],
              [
                { text: vm.$t('dealer.village') }, { text: vm.$i18n.locale === 'bn' ? appDetail.details.village_bn : appDetail.details.village, colSpan: 3 },
                { text: vm.$i18n.locale === 'bn' ? 'a' : 'b' }, { text: vm.$i18n.locale === 'bn' ? 'a' : 'b' }
              ]
            ]
          },
          layout: {
            fillColor: function (rowIndex, node, columnIndex) {
              return (rowIndex % 2 === 0) ? '#CCCCCC' : null
            }
          }
        })
        pdfContent.push({ text: vm.$t('dealer.application_text_two'), style: 'tableHeaderEleven' })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'Landcape',
        defaultStyle: {
          font: (i18n.locale === 'bn') ? 'Kalpurush' : 'Roboto'
        },
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
            margin: [0, 10, 0, 10],
            fontSize: 14
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
