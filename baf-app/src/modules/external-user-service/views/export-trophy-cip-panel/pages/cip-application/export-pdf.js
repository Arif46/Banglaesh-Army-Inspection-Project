import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import AddressHelper from '@/utils/area-type-address'
import { mobileNumber } from '@/utils/fliter'

  function headingOne (vm) {
    if (vm.currentLocale === 'bn') {
      return vm.$t('externalUser.cip_header') + '' + vm.EngBangNum(vm.application.year.toString()) + ' ' + vm.$t('externalUser.cip_header_ex')
    } else {
      return vm.$t('externalUser.cip_header') + ' ' + vm.$t('externalUser.cip_header_ex') + ' ' + vm.EngBangNum(vm.application.year.toString())
    }
  }
  function disputeSettledData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.dispute_settled === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('detailsView.extra_text_ten') + ' ' + yesNo + '\n' + vm.$t('detailsView.extra_test_fourtheen')
  }
  function previousTrophyData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.applicant_selected_cip_past_year === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.$t('detailsView.extra_text_eleven') + ' | ' + yesNo
  }
  function firstRules (vm) {
    const yesNo = vm.currentLocale === 'en' ? 'and' : 'এবং'
    const first = vm.$t('detailsView.first_rule')
    const second = vm.$t('detailsView.first_rule_ex')
    const firstFiscalyear = vm.getPreviousFiscalYearFirst(vm.application.circular.year)
    const secondFiscalyear = vm.getPreviousFiscalYear(vm.application.circular.year)
    return first + ' ' + firstFiscalyear + ' ' + yesNo + secondFiscalyear + second
  }
const exportPdfDetails = async (vm) => {
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
      const headerTop = [
        [
          { image: 'data:image/jpg;base64,' + vm.application.org_logo_pdf.data, height: 80, width: 100, rowSpan: '4' },
          { text: vm.$t('etDetailsView.heading_1'), style: 'header', alignment: 'center' },
          { image: 'data:image/jpg;base64,' + vm.application.photo_pdf.data, alignment: 'right', height: 80, width: 100, rowSpan: '4' }
        ],
        [{}, { text: vm.$t('etDetailsView.heading_bhobon'), style: 'header2', alignment: 'center' }, {}],
        [{}, { text: vm.$t('etDetailsView.heading_address'), style: 'header2', alignment: 'center' }, {}],
        [{}, { text: vm.$t('etDetailsView.heading_web'), style: 'td', alignment: 'center', decoration: 'underline' }, {}]
      ]
      pdfContent.push({
        table: {
          headerRows: 4,
          widths: '33.33%',
          body: headerTop
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
      pdfContent.push(
        { text: headingOne(vm), style: 'govt_info', alignment: 'center', decoration: 'underline' }
      )
      pdfContent.push(
        { text: '(' + vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.application_header') + ')', style: 'header2', alignment: 'center' }
      )
      // const allRowD = []
      const allRows = [
        [
          { text: vm.$n(1), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_cip_product_name') + ' ' + vm.$t('detailsView.circular_wise_product_application'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.productName(vm.application.product_service_sector_id), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$n(2), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.cip_application_single'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.getAppType(vm.application.app_type), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$n(3), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.exporter'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.getLatentExporter(vm.application.latent_exporter), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '60%', '5%', '30%'],
          body: allRows
        }
      })
      // Personal Information.
      const allFour = [
        [
          { text: vm.$n(4), rowSpan: 13, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.personal_info_cip'), colSpan: 4, style: 'header2' },
          {},
          {},
          {}
        ],
        [
          {},
          { text: vm.$t('detailsView.one'), rowSpan: 3, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.cip_application_full_name') + ' i)' + ' ' + vm.$t('globalTrans.bn'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.currentLocale === 'bn' ? (vm.application.name_bn) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: 'ii)' + '' + 'English (Capital Letter)', style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: (vm.application.name_en), style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.extra_text'), colSpan: 3, style: 'td', alignment: 'left' },
          {},
          {}
        ],
        [
          {},
          { text: vm.$t('detailsView.two'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.concernned_application'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.currentLocale === 'bn' ? vm.application.designation_bn : vm.application.designation_en, style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.three'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.applicant_father_husband_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.currentLocale === 'bn' ? vm.application.father_name_bn : vm.application.father_name_en, style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.four'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.applicant_mother_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.currentLocale === 'bn' ? vm.application.mother_name_bn : vm.application.mother_name_en, style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.five'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.national_identification_number'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.$n(vm.application.nid, { useGrouping: false }), style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.six'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.present_address_mobile'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.address !== null ? vm.currentLocale === 'bn' ? vm.application.address.pm_address_details_bn : vm.application.address.pm_address_details_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.seven'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.permanent_address'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.address !== null ? AddressHelper.getPermanentAddress(vm.application.address) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.eight'), rowSpan: 3, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.tin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.$n(vm.application.tax_info.tin_no, { useGrouping: false }) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.circule'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.application.tax_info.tax_circle : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.region'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.currentLocale === 'bn' ? vm.application.tax_info.tax_region_bn : vm.application.tax_info.tax_region_en : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 13,
          // widths: ['5%', '60%', '5%', '30%'],
          widths: ['5%', '5%', '54.5%', '5%', '30.5%'],
          body: allFour
        }
      })
      // Institute Information..
      const allFive = [
        [
          { text: vm.$n(5), rowSpan: 13, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_info'), colSpan: 4, style: 'header2' },
          {},
          {},
          {}
        ],
        [
          {},
          { text: vm.$t('detailsView.one'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_owner_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.owner_name_bn : vm.application.org_info.owner_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.two'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.desination_owner'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.designation_bn : vm.application.org_info.designation_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.three'), rowSpan: 2, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_name_bn'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.org_name_bn : '' : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: 'ii)' + '' + 'English (Capital Letter)', style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.application.org_info.org_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.four'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_owner_type'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.orgTypeName(vm.application.org_info.org_type) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.five'), rowSpan: 3, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_tin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_tax_info !== null ? vm.$n(vm.application.org_tax_info.tin_no, { useGrouping: false }) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.circule'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_tax_info !== null ? vm.application.org_tax_info.tax_circle : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.region'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_tax_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_tax_info.tax_region_bn : vm.application.org_tax_info.tax_region_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.six'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_bin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.$n(vm.application.org_info.bin_no, { useGrouping: false }) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.seven'), rowSpan: 3, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_address'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.office_contact_info !== null ? vm.$n(vm.application.office_contact_info.telephone_no, { useGrouping: false }) + ' , ' + vm.$n(vm.application.office_contact_info.fax_no, { useGrouping: false }) + ' , ' + mobileNumber(vm.application.office_contact_info.mobile_no) + ' , ' + (vm.application.office_contact_info.email) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.institute_company'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.factory_contact_info !== null ? vm.$n(vm.application.factory_contact_info.telephone_no, { useGrouping: false }) + ' , ' + vm.$n(vm.application.factory_contact_info.fax_no, { useGrouping: false }) + ' , ' + (vm.application.factory_contact_info.email) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.institute_contact_person'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.contact_person_info !== null ? (vm.currentLocale === 'bn' ? vm.application.contact_person_info.name_bn : vm.application.contact_person_info.name_en) + ' , ' + (vm.currentLocale === 'bn' ? vm.application.contact_person_info.designation_bn : vm.application.contact_person_info.designation_en) + ' , ' + mobileNumber(vm.application.contact_person_info.mobile) : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 13,
          widths: ['5%', '5%', '54.5%', '5%', '30.5%'],
          body: allFive
        }
      })
      const allSix = [
        [
          { text: vm.$n(6), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.epz_company'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? parseInt(vm.application.org_info.bangladeshi_owned_company) === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '60.2%', '5%', '29.8%'],
          body: allSix
        }
      })
      const allSeven = [
        [
          { text: vm.$n(7), style: 'td', rowSpan: vm.application.group_based_app.length !== 0 ? parseInt(vm.application.group_based_app.length) + 2 : 1, alignment: 'center' },
          { text: vm.$t('detailsView.extra_text_two'), colSpan: 3, style: 'td', alignment: 'left' },
          {},
          {}
        ],
        [
          {},
          { text: vm.$t('detailsView.group_name'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.group_institute_name'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_earning'), style: 'td', alignment: 'center' }
        ]
      ]
      if (vm.application.group_based_app.length > 0) {
        vm.application.group_based_app.forEach(item => {
          allSeven.push([
            {},
            { text: vm.currentLocale === 'bn' ? item.group_name_bn : item.group_name_en, style: 'td', alignment: 'center' },
            { text: vm.currentLocale === 'bn' ? item.org_name_bn : item.org_name_en, style: 'td', alignment: 'center' },
            { text: vm.EngBangNum(item.export_value.toString()), style: 'td', alignment: 'center' }
          ])
        })
      }

      pdfContent.push({
        table: {
          headerRows: vm.application.group_based_app.length !== 0 ? parseInt(vm.application.group_based_app.length) + 2 : 1,
          widths: ['5%', '30%', '35%', '30%'],
          body: allSeven
        }
      })
      const allText = [
        [
          { text: vm.$t('detailsView.extra_text_three'), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['100%'],
          body: allText
        }
      })
      // 08 Bank
      if (vm.application.bank.length > 0) {
        const bank = []
        vm.application.bank.forEach((item, index) => {
          bank.push([
            { text: vm.$n(8), style: 'td', rowSpan: vm.application.bank.length, alignment: 'center' },
            { text: vm.$t('detailsView.application_institute_bank_name'), style: 'td', rowSpan: vm.application.bank.length, alignment: 'left' },
            { text: vm.currentLocale === 'bn' ? vm.$n(index + 1) + '. ' + item.bank_name_bn + ' ,' + item.branch_name_bn : item.bank_name_en + ' ,' + item.branch_name_en, style: 'td', alignment: 'left' }
          ])
        })

        pdfContent.push({
          table: {
            headerRows: vm.application.bank.length,
            widths: ['5%', '35%', '60%'],
            body: bank
          }
        })
      } else {
        const bank = [
          [
            { text: vm.$n(8), style: 'td', rowSpan: 1, alignment: 'center' },
            { text: vm.$t('detailsView.application_institute_bank_name'), style: 'td', rowSpan: 1, alignment: 'left' },
            { text: vm.currentLocale === 'bn' ? 'কোনো ব্যাংক অ্যাকাউন্ট নেই' : 'No bank Available', style: 'td', rowSpan: 1, alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['5%', '35%', '60%'],
            body: bank
          }
        })
      }
      // 09 success description
      // pdfContent.push({ text: '', pageOrientation: 'portrait', pageBreak: 'after' })
      const successDescription = [
        [
          { text: vm.$n(9), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_product_details'), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: successDescription
        }
      })
      const successDescription2 = [
        [
          { text: vm.$t('detailsView.exported_name'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.fiscal_year_name'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_volumes'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_earning_millions'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.previous_fiscal_year'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.destination'), style: 'td', alignment: 'center' }
        ]
      ]
      if (vm.application.product_success_description !== null) {
        vm.application.product_success_description.forEach((item) => {
          successDescription2.push([
            { text: vm.productName(item.product_id), style: 'td', alignment: 'center' },
            { text: vm.fiscalYearName(item.fiscal_year_id), style: 'td', alignment: 'center' },
            { text: item.export_volume, style: 'td', alignment: 'center' },
            { text: vm.EngBangNum(item.export_value_ssd.toString()) + ' ' + vm.$t('etDetailsView.million'), style: 'td', alignment: 'center' },
            { text: vm.EngBangNum(vm.application.product_success_description[1].income_growth.toString()) + ' %', style: 'td', alignment: 'center', rowSpan: vm.application.product_success_description.length },
            { text: vm.getDesingationData(vm.destinationList), style: 'td', alignment: 'center', rowSpan: vm.application.product_success_description.length }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['20%', '10%', '20%', '15%', '10%', '25%'],
            body: successDescription2,
            dontBreakRows: true
          }
        })
      }
      // warning message
      const notice = [
        [
          { text: vm.$t('detailsView.extra_text_four'), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['100%'],
          body: notice
        }
      })
      // 11 Dispute Settled
      const disputeSettled = [
        [
          { text: vm.$n(10), style: 'td', alignment: 'center' },
          disputeSettledData(vm)
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: disputeSettled
        }
      })
      // 12 Previous Export Trophy
      const previousTrophy = [
        [
          { text: vm.$n(11), style: 'td', alignment: 'center' },
          previousTrophyData(vm)
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: previousTrophy
        }
      })
      const previousTrophy2 = [
        [
          { text: vm.$t('globalTrans.year'), style: 'td', alignment: 'center' },
          { text: vm.$t('externalUser.product_name'), style: 'td', alignment: 'center' }
        ]
      ]
      if (vm.application.cip_selected.length > 0) {
        vm.application.cip_selected.forEach((item) => {
          previousTrophy2.push([
            { text: vm.EngBangNum(item.selection_year), style: 'td', alignment: 'center' },
            { text: vm.productName(item.product_sector_id), style: 'td', alignment: 'center' }
          ])
        })
      }
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['*', '*'],
          body: previousTrophy2
        }
      })
      // 13 Other Information
      const otherInfo = [
        [
          { text: vm.$n(12), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.others_info'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.other_compliance !== null ? vm.application.other_compliance.other_information : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '55.5%', '5%', '34.5%'],
          body: otherInfo
        }
      })
      // Rules heading
      pdfContent.push({ text: vm.$t('detailsView.application_rules'), style: 'my_title', alignment: 'left', decoration: 'underline' })
      // rules
      const otherRules = [
        [
          { text: vm.$t('detailsView.one'), style: 'td', alignment: 'center' },
          { text: firstRules(vm), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.two'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.secound_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.three'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.third_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.four'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.four_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.five'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.five_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.six'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.six_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.seven'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.seven_rule'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.eight'), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.eight_rule'), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          // headerRows: 1,
          widths: ['5%', '95%'],
          body: otherRules,
          dontBreakRows: true
        }
      })

      pdfContent.push({ text: vm.$t('detailsView.end_extra_text'), style: 'td', alignment: 'left' })
      pdfContent.push({ text: vm.$t('globalTrans.date') + ' : ' + vm.EngBangNum(vm.finalSubmitDate(vm.application.updated_at)), style: 'td', alignment: 'left' })

      pdfContent.push({ text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.owner_name_bn : vm.application.org_info.owner_name_en : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে'), style: 'td', alignment: 'right', margin: [0, 0, 10, 0] })
      pdfContent.push({ text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.designation_bn : vm.application.org_info.designation_en : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে'), style: 'td', alignment: 'right', margin: [0, 0, 10, 0] })
      pdfContent.push({ text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.org_name_bn : vm.application.org_info.org_name_en : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে'), style: 'td', alignment: 'right', margin: [0, 0, 10, 0] })

      if (vm.application.other_compliance !== null) {
        pdfContent.push({ image: 'data:image/jpg;base64,' + vm.application.other_compliance.pdfSignature.data, alignment: 'right', height: 50, width: 80, rowSpan: '4', margin: [0, 0, 10, 0] })
      } else {
        pdfContent.push({ text: vm.currentLocale === 'bn' ? 'স্বাক্ষক .............................' : 'Signature .............................', style: 'td', alignment: 'right', margin: [0, 10, 10, 0] })
      }
      var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        td: {
          fontSize: (i18n.locale === 'bn') ? 12 : 12,
          margin: [3, 3, 3, 3]
        },
        header: {
          fontSize: 16,
          bold: true,
          margin: [0, 0, 0, 0]
        },
        address: {
          fontSize: 11,
          margin: [0, 0, 0, 5]
        },
        header2: {
          border: 0,
          fontSize: 12,
          margin: [0, 0, 0, 1],
          bold: true
        },
        govt_info: {
          margin: [0, 1, 0, 1],
          fontSize: 15,
          bold: true,
          alignment: 'center'
        },
        my_title: {
          border: 0,
          fillColor: '#dee2e6',
          fontSize: 13,
          margin: [0, 10, 0, 10],
          bold: true,
          alignment: 'center'
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
