import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import { dateFormat } from '@/utils/fliter'
import { ReportHeading } from '../../components/ReportHeadingPdf'

const exportPdfDetails = async (baseUrl, uri, orgId, reportData, reportBackType, vm, search, office, fiscalYear, month, reportType) => {
    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
        if (i18n.locale === 'bn') {
          pdfMake.vfs = pdfFontsBn.pdfMake.vfs
        } else {
          pdfMake.vfs = pdfFontsEn.pdfMake.vfs
        }

        const allRowsHead = []
        const allRowsHeadTwo = []
        const pdfContent = []
        // if (search.type_en) {

          const rowItemTwo = ReportHeading(vm)
          allRowsHeadTwo.push(...rowItemTwo)
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

          let rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('organogram.regional_office_name') + ' : ' + (i18n.locale === 'bn' ? office.text_bn : office.text_en), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)

         if (parseInt(reportType) === 1) {
          rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('tcb_report.report_type') + ' : ' + (i18n.locale === 'bn' ? 'বার্ষিক' : 'Yearly'), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
          rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('globalTrans.fiscal_year') + ' : ' + (i18n.locale === 'bn' ? fiscalYear.text_bn : fiscalYear.text_bn), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
         }

         if (parseInt(reportType) === 2) {
          rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('tcb_report.report_type') + ' : ' + (i18n.locale === 'bn' ? 'মাসিক' : 'Monthly'), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
          rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('globalTrans.fiscal_year') + ' : ' + (i18n.locale === 'bn' ? fiscalYear.text_bn : fiscalYear.text_en), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
          rowItem = [
            { text: '', style: 'td', alignment: 'right' },
            { text: vm.$t('tcb_report.month') + ' : ' + (i18n.locale === 'bn' ? month.text_bn : month.text_en), style: 'td', alignment: 'center' },
            { text: '', style: 'td', alignment: 'left' }
          ]
          allRowsHead.push(rowItem)
         }

         if (parseInt(search.division_id) > 0) {
            rowItem = [
              { text: '', style: 'td', alignment: 'right' },
              { text: vm.$t('globalTrans.division') + ' : ' + vm.getDivisionName(search.division_id), style: 'td', alignment: 'center' },
              { text: '', style: 'td', alignment: 'left' }
            ]
            allRowsHead.push(rowItem)
         }
         if (parseInt(search.district_id) > 0) {
            rowItem = [
              { text: '', style: 'td', alignment: 'right' },
              { text: vm.$t('globalTrans.district') + ' : ' + vm.AddressHelper.getDistrictName(search.district_id), style: 'td', alignment: 'center' },
              { text: '', style: 'td', alignment: 'left' }
            ]
            allRowsHead.push(rowItem)
         }
         if (parseInt(search.upazilla_id) > 0) {
            rowItem = [
              { text: '', style: 'td', alignment: 'right' },
              { text: vm.$t('globalTrans.upazila') + ' : ' + vm.AddressHelper.getUpazilaName(search.upazilla_id), style: 'td', alignment: 'center' },
              { text: '', style: 'td', alignment: 'left' }
            ]
            allRowsHead.push(rowItem)
         }
         if (parseInt(search.city_corporation_id) > 0) {
            rowItem = [
              { text: '', style: 'td', alignment: 'right' },
              { text: vm.$t('globalTrans.city_corporation') + ' : ' + vm.AddressHelper.getCityCorporationName(search.city_corporation_id), style: 'td', alignment: 'center' },
              { text: '', style: 'td', alignment: 'left' }
            ]
            allRowsHead.push(rowItem)
         }

        // }
        pdfContent.push({
          table: {
            widths: ['33%', '33%', '33%'],
            body: allRowsHead
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
        if (reportBackType > 0 && reportBackType < 4) {
              for (const groupItem in reportData) {
                    const gorupHead = []
                    if (reportBackType === 1) {
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: vm.$t('globalTrans.division') + '  :  ' + vm.getDivisionName(groupItem), style: 'th', fontSize: 14, alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                  }
                    if (reportBackType === 2) {
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: ' ', style: 'th', alignment: 'right' },
                        { text: vm.$t('globalTrans.district') + '  :  ' + vm.AddressHelper.getDistrictName(groupItem), style: 'th', fontSize: 14, alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                  }
                    if (reportBackType === 3 && search.district_id > 0 && search.area_type_id > 1) {
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: vm.$t('globalTrans.upazila') + '  :  ' + vm.AddressHelper.getUpazilaName(groupItem), style: 'th', fontSize: 14, alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                  }
                    if (reportBackType === 3 && search.area_type_id === 1 && search.district_id > 0) {
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: vm.$t('orgProfile.city_corporation') + '  :  ' + vm.AddressHelper.getCityCorporationName(groupItem), style: 'th', fontSize: 14, alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                      rowItem = [
                        { text: '', style: 'th', alignment: 'right' },
                        { text: '', style: 'th', alignment: 'center' },
                        { text: '', style: 'th', alignment: 'left' }
                      ]
                      gorupHead.push(rowItem)
                  }

                  pdfContent.push({
                    table: {
                      widths: ['25%', '50%', '25%'],
                      body: gorupHead
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

                  const allRows = []
                  const allRows3 = []
                  allRows3.push(
                    { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true }
                  )
                  if (reportBackType === 1) {
                    allRows3.push(
                      { text: vm.$t('tcb_report.district'), style: 'th', alignment: 'center', bold: true }
                    )
                  }
                  if (reportBackType === 1 || reportBackType === 2) {
                    allRows3.push(
                      { text: vm.$t('tcb_report.upazila'), style: 'th', alignment: 'center', bold: true }
                    )
                  }
                  allRows3.push(
                    { text: vm.$t('tcb_report.dealer_name'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push(
                    { text: vm.$t('tcb_report.institute_name'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push(
                    { text: vm.$t('tcb_report.address'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push(
                    { text: vm.$t('tcb_report.mobile_no'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push({ text: vm.$t('tcb_report.contract_date'), style: 'th', alignment: 'center', bold: true })
                    // allRows3.push({ text: vm.$t('tcb_report.renew_date'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push({ text: vm.$t('tcb_report.contract_duration'), style: 'th', alignment: 'center', bold: true })
                    allRows3.push({ text: vm.$t('tcb_report.distance_km'), style: 'th', alignment: 'center', bold: true }
                  )
                  allRows.push(allRows3)

                  reportData[groupItem].forEach((item, index) => {
                    const rowData = []
                    rowData.push(
                        { text: vm.$n(index + 1), style: 'td', alignment: 'center', bold: false }
                    )
                    if (reportBackType === 1) {
                      rowData.push(
                        { text: vm.AddressHelper.getDistrictName(item.company_district_id), style: 'td', alignment: 'center', bold: false }
                      )
                    }
                    if (reportBackType === 1 || reportBackType === 2) {
                      rowData.push(
                        { text: item.company_area_type_id > 1 ? vm.AddressHelper.getUpazilaName(item.company_upazilla_id) : vm.AddressHelper.getCityCorporationName(item.company_city_corporation_id), style: 'td', alignment: 'center', bold: false }
                      )
                    }
                    rowData.push(
                      { text: vm.currentLocale === 'en' ? item.applicant_name : item.applicant_name_bn, style: 'td', alignment: 'center', bold: false }
                    )
                    rowData.push(
                      { text: vm.currentLocale === 'en' ? item.company_name : item.company_name_bn, style: 'td', alignment: 'center', bold: false }
                    )
                    rowData.push(
                      { text: vm.currentLocale === 'en' ? item.company_address : item.company_address_bn, style: 'td', alignment: 'center', bold: false }
                    )
                    rowData.push(
                      { text: vm.$n('0') + vm.$n(item.mobile, { useGrouping: false }), style: 'td', alignment: 'center', bold: false }
                    )
                    rowData.push(
                      { text: dateFormat(item.agreement_date), style: 'td', alignment: 'center', bold: false }
                    )
                    // rowData.push(
                    //   { text: '', style: 'td', alignment: 'center', bold: false }
                    // )
                    rowData.push(
                      { text: dateFormat(item.expire_date), style: 'td', alignment: 'center', bold: false }
                    )
                    rowData.push(
                      { text: vm.getDistanceFromTcb(item.distance_id), style: 'td', alignment: 'center', bold: false }
                    )
                    allRows.push(rowData)
                  })

                    let widths = null
                    if (reportBackType === 1) {
                      widths = ['9%', '9%', '9%', '9%', '9%', '9%', '9%', '9%', '9%', '9%', '9%']
                    }
                    if (reportBackType === 2) {
                      widths = ['10%', '10%', '10%', '10%', '10%', '10%', '10%', '10%', '10%', '10%']
                    }
                    if (reportBackType > 2) {
                      widths = ['11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%']
                    }
                  pdfContent.push({
                    table: {
                      headerRows: 1,
                      widths: widths,
                      body: allRows
                    }
                  })
                }
        }

        if (reportBackType === 4) {
          const allRows = []
          allRows.push([
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.dealer_name'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.institute_name'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.address'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.mobile_no'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.contract_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.renew_date'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.contract_duration'), style: 'th', alignment: 'center', bold: true },
            { text: vm.$t('tcb_report.distance_km'), style: 'th', alignment: 'center', bold: true }
          ])
          reportData.forEach((item, index) => {
            allRows.push([
              { text: vm.$n(index + 1), style: 'th', alignment: 'center', bold: false },
              { text: (i18n.locale === 'en' ? item.applicant_name : item.applicant_name_bn), style: 'th', alignment: 'center', bold: false },
              { text: (i18n.locale === 'en' ? item.company_name : item.company_name_bn), style: 'th', alignment: 'center', bold: false },
              { text: (i18n.locale === 'en' ? item.company_address : item.company_address_bn), style: 'th', alignment: 'center', bold: false },
              { text: vm.$n('0') + vm.$n(item.mobile, { useGrouping: false }), style: 'th', alignment: 'center', bold: false },
              { text: dateFormat(item.agreement_date), style: 'th', alignment: 'center', bold: false },
              { text: '', style: 'th', alignment: 'center', bold: false },
              { text: dateFormat(item.expire_date), style: 'th', alignment: 'center', bold: false },
              { text: vm.getDistanceFromTcb(item.distance_id), style: 'th', alignment: 'center', bold: false }
            ])
          })
            pdfContent.push({
              table: {
                headerRows: 1,
                widths: ['11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%', '11%'],
                body: allRows
              }
            })
        }

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
