import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { ReportHeading } from '../../../../license-registration-service/tcb-report/components/ReportHeadingPdfTwo'

const exportPdfDetails = async (vm, data, section) => {
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
          const allRowsHeadTwo = []
          const rowItemTwo = ReportHeading(vm)
          allRowsHeadTwo.push(...rowItemTwo)
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          allRowsHeadTwo.push(['', '', ''])
          pdfContent.push({
            table: {
              widths: ['20%', '60%', '20%'],
              body: allRowsHeadTwo
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
            const allRowsHead1 = [
              [
                { text: vm.$t('bazarMonitoring.area_type') + ' : ' + vm.AddressHelper.getCityCorporationName(vm.search.pre_city_corporation_id), alignment: 'left', style: 'thh' },
                { text: vm.$t('globalTrans.division') + ' : ' + vm.getDivisionName(vm.search.pre_division_id), alignment: 'left', style: 'thh' },
                { text: vm.$t('globalTrans.district') + ' : ' + vm.AddressHelper.getDistrictName(vm.search.pre_district_id), alignment: 'left', style: 'thh' }
              ]
            ]
            if (vm.search.pre_area_type_id === 1) {
              allRowsHead1.push([
                { text: vm.$t('globalTrans.city_corporation') + ' : ' + vm.AddressHelper.getCityCorporationName(vm.search.pre_city_corporation_id), alignment: 'left', style: 'thh' },
                { text: '', alignment: 'left', style: 'thh' },
                { text: '', alignment: 'left', style: 'thh' }
              ])
            } else {
              allRowsHead1.push([
                { text: vm.$t('globalTrans.upazila') + ' : ' + vm.AddressHelper.getUpazilaName(vm.search.pre_upazila_id), alignment: 'left', style: 'thh' },
                { text: '', alignment: 'left', style: 'thh' },
                { text: '', alignment: 'left', style: 'thh' }
              ])
            }
            // allRowsHead1.push([
            //   { text: '' + '' + '', alignment: 'left', style: 'thh' },
            //   { text: '' + '' + '', alignment: 'left', style: 'thh' },
            //   { text: '' + '' + '', alignment: 'left', style: 'marginForUse' }
            // ])
            pdfContent.push({
              table: {
                headerRows: 1,
                widths: '*',
                body: allRowsHead1
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
            const ProductWiseRows = [
              [
                { text: vm.$t('tcb_report.beneficiary_report'), style: 'tablecell', colSpan: 15 },
                { text: vm.$t('tcbconfiguration.name_of_head_of_family_un'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.father_name_un'), style: 'tablecell' },
                { text: vm.$t('globalTrans.dob'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.age_un'), style: 'tablecell' },
                { text: vm.$t('globalTrans.gender'), style: 'tablecell' },
                { text: vm.$t('globalTrans.present_address'), style: 'tablecell' },
                { text: vm.$t('globalTrans.permanent_address'), style: 'tablecell' },
                { text: vm.$t('globalTrans.occupation'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.mobile_un'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.nid_un'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.is_allowance_recipient'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.member_in_family'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.family_net_monthly_income'), style: 'tablecell' },
                { text: vm.$t('tcbconfiguration.family_net_monthly_expense'), style: 'tablecell' }]
            ]

            ProductWiseRows.push([{ text: vm.$t('globalTrans.sl_no'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.name_of_head_of_family_un'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.father_name_un'), style: 'tablecell' }, { text: vm.$t('globalTrans.dob'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.age_un'), style: 'tablecell' }, { text: vm.$t('globalTrans.gender'), style: 'tablecell' }, { text: vm.$t('globalTrans.present_address'), style: 'tablecell' }, { text: vm.$t('globalTrans.permanent_address'), style: 'tablecell' }, { text: vm.$t('globalTrans.occupation'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.mobile_un'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.nid_un'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.is_allowance_recipient'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.member_in_family'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.family_net_monthly_income'), style: 'tablecell' }, { text: vm.$t('tcbconfiguration.family_net_monthly_expense'), style: 'tablecell' }])

              data.map((item, index) => {
                  ProductWiseRows.push(
                    [
                      { text: vm.$n(index + 1), style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.beneficiary_name : item.beneficiary_name_bn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.father_name : item.father_name_bn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.DateEn : item.DateBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.age : item.ageBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.genderEn : item.genderBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.pre_address_en : item.pre_address_bn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.per_address_en : item.per_address_bn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.occupationEn : item.occupationBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.mobile : item.mobileBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.nid : item.nidBn, style: 'tablecell' },
                      { text: (item.is_allowance_recipient === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না')), style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.member_in_family : item.member_in_familyBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.family_net_monthly_income : item.family_net_monthly_incomeBn, style: 'tablecell' },
                      { text: vm.currentLocale === 'en' ? item.family_net_monthly_expense : item.family_net_monthly_expenseBn, style: 'tablecell' }])
              })
              pdfContent.push({
                style: 'tableExample',
                table: {
                  widths: ['7%', '7%', '6%', '7%', '7%', '7%', '7%', '7%', '7%', '7%', '7%', '7%', '7%', '7%', '7%'],
                  body: ProductWiseRows
                }
              })
        var docDefinition = {
        content: pdfContent,
        pageSize: 'A4',
        pageOrientation: 'landscape',
        styles: {
          th: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
          },
          td: {
            fontSize: (i18n.locale === 'bn') ? 8 : 7,
            margin: [1, 1, 1, 1]
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
          img_logo_unique: {
            margin: [60, 0, 0, 0]
          },
          img_logo_two: {
            margin: [25, 0, 0, 0]
          },
          reportHeading: {
            fontSize: 13,
            margin: [0, 10, 0, 0]
          },
          reportHeadingTwo: {
            fontSize: 14,
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
            margin: [0, 10, 0, 0]
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
            margin: [0, 50, 0, 0]
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
          leftalign: {
            alignment: 'left'
          },
          tablecell: {
            fontSize: 12,
            alignment: 'center'
          },
          marginForUse: {
            margin: [0, 20, 0, 0]
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
