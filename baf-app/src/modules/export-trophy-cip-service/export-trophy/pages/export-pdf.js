import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

  function getAddMobileEmail (vm) {
    let addInfo = ''
    addInfo = vm.AddressHelper.getPresentAddress(vm.application.address) + '\n'
    addInfo += vm.EngBangNum(vm.application.contact_info.mobile_no.toString()) + ', ' + vm.$n(vm.application.contact_info.telephone_no, { useGrouping: false }) + '\n'
    addInfo += vm.application.contact_info.email
    return addInfo
  }

  function getOfficeInfo (vm) {
    const faxInfo = vm.application.office_contact_info.fax_no ? ', ' + vm.EngBangNum(vm.application.office_contact_info.fax_no.toString()) : ' '
    let addInfo = ''
    addInfo = vm.EngBangNum(vm.application.office_contact_info.telephone_no.toString()) + ', ' + vm.EngBangNum(vm.application.office_contact_info.mobile_no.toString()) + faxInfo + '\n'
    addInfo += vm.application.office_contact_info.email
    return addInfo
  }

  function getFactoryInfo (vm) {
    const faxInfo = vm.application.factory_contact_info.fax_no ? ', ' + vm.EngBangNum(vm.application.factory_contact_info.fax_no.toString()) : ' '
    let addInfo = ''
    addInfo = vm.EngBangNum(vm.application.factory_contact_info.telephone_no.toString()) + ', ' + vm.EngBangNum(vm.application.factory_contact_info.mobile_no.toString()) + faxInfo + '\n'
    addInfo += vm.application.factory_contact_info.email
    return addInfo
  }

  function getContractPersonInfo (vm) {
    let addInfo = ''
    addInfo = vm.currentLocale === 'en' ? vm.application.contact_person_info.name_en + ' ,' + vm.application.contact_person_info.designation_en : vm.application.contact_person_info.name_bn + ' ,' + vm.application.contact_person_info.designation_bn + '\n'
    addInfo += vm.EngBangNum(vm.application.contact_person_info.mobile)
    return addInfo
  }
  function getComplaince (vm) {
    const yesNo = vm.application.other_compliance !== null ? parseInt(vm.application.other_compliance.merchandising_sector) === 1 ? (vm.currentLocale === 'en' ? 'Textile Factory' : 'টেক্সটাইল ফ্যাক্টরি') : (vm.currentLocale === 'en' ? 'Others' : 'অন্যান্য') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.compliance_given') + ' ' + yesNo + '\n' + vm.$t('etDetailsView.compliance_given_ex')
  }
  function destinationData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.export_destination_add === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.new_destination') + ' ' + yesNo + '\n' + vm.$t('etDetailsView.new_destination_ex')
  }
  function productData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.export_products_add === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.new_product') + ' ' + yesNo + '\n' + vm.$t('etDetailsView.new_product_ex')
  }
  function disputeSettledData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.dispute_settled === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('detailsView.extra_text_ten') + ' ' + yesNo + '\n' + vm.$t('detailsView.extra_test_fourtheen')
  }
  function previousTrophyData (vm) {
    const yesNo = vm.application.other_compliance !== null ? vm.application.other_compliance.applicant_selected_et_past_year === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : (vm.currentLocale === 'en' ? 'Form fill up incomplete' : 'ফর্ম পূরণ অসম্পূর্ণ রয়েছে')
    return vm.$t('detailsView.extra_text_eleven') + ' ' + yesNo
  }
  function firstRules (vm) {
    const yesNo = vm.currentLocale === 'en' ? 'and' : 'এবং'
    const first = vm.$t('detailsView.first_rule')
    const second = vm.$t('detailsView.first_rule_ex')
    const firstFiscalyear = vm.getPreviousFiscalYearFirst(vm.application.circular.year)
    const secondFiscalyear = vm.getPreviousFiscalYear(vm.application.circular.year)
    return first + ' ' + firstFiscalyear + ' ' + yesNo + secondFiscalyear + second
  }
  function newDistinationData (vm, item) {
    let country = vm.countryName(item.country_id) + ' , '
    country += vm.currentLocale === 'en' ? item.buyer_org_name_en : item.buyer_org_name_bn
    return country
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
          // headerRows: 4,
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
        { text: vm.$t('etDetailsView.et_header') + ' ' + vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.et_header_ex'), style: 'govt_info', alignment: 'center', decoration: 'underline' }
      )
      pdfContent.push(
        { text: '(' + vm.getPreviousFiscalYear(vm.application.circular.year) + ' ' + vm.$t('etDetailsView.application_header') + ')', style: 'header2', alignment: 'center' }
      )
      const allThird = [
        [
          { text: vm.$n(1), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.export_cip_product_name') + ' ' + vm.$t('detailsView.circular_wise_product_application'), colSpan: 2, style: 'td', alignment: 'left' },
          {},
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.productName(vm.application.product_service_sector_id), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$n(2), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.exporter'), colSpan: 2, style: 'td', alignment: 'left' },
          {},
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.getLatentExporter(vm.application.latent_exporter), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$n(3), rowSpan: 21, style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.institute_info'), colSpan: 4, style: 'header2' },
          {},
          {},
          {}
        ],
        [
          {},
          { text: vm.$t('detailsView.one'), rowSpan: 7, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_owner_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.owner_info !== null ? vm.currentLocale === 'bn' ? vm.application.owner_info.owner_name_bn : vm.application.owner_info.owner_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.desination_owner'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.owner_info !== null ? vm.currentLocale === 'bn' ? vm.application.owner_info.designation_bn : vm.application.owner_info.designation_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('etDetailsView.applicant_father_husband_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.owner_info !== null ? vm.currentLocale === 'bn' ? vm.application.owner_info.father_husband_name_bn : vm.application.owner_info.father_husband_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('etDetailsView.applicant_mother_name'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.owner_info !== null ? vm.currentLocale === 'bn' ? vm.application.owner_info.mother_name_bn : vm.application.owner_info.mother_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.present_address_mobile'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.contact_info !== null && vm.application.address !== null ? getAddMobileEmail(vm) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.permanent_address'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.address !== null ? vm.AddressHelper.getPermanentAddress(vm.application.address) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.national_identification_number'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.EngBangNum(vm.application.tax_info.tin_no.toString()) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.two'), rowSpan: 3, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.tin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.EngBangNum(vm.application.tax_info.tin_no.toString()) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.circule'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.EngBangNum(vm.application.tax_info.tax_circle.toString()) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.region'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.tax_info !== null ? vm.currentLocale === 'bn' ? vm.application.tax_info.tax_region_bn : vm.application.tax_info.tax_region_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.three'), rowSpan: 2, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_name_bn'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.currentLocale === 'bn' ? vm.application.org_info.org_name_bn : '' : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: '(ii) English (Capital Letter)', style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.application.org_info.org_name_en : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.four'), style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_owner_type'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.orgTypeName(vm.application.org_info.org_type) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.five'), rowSpan: 3, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_tin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.EngBangNum(vm.application.org_tax_info.tin_no) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.circule'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.EngBangNum(vm.application.org_tax_info.tax_circle) : '', style: 'td', alignment: 'left' }
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
          { text: vm.$t('detailsView.six'), style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_bin'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? vm.EngBangNum(vm.application.org_info.bin_no) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          { text: vm.$t('detailsView.seven'), rowSpan: 3, style: 'td', alignment: 'left' },
          { text: vm.$t('detailsView.institute_address'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.office_contact_info !== null ? getOfficeInfo(vm) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.institute_company'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.factory_contact_info !== null ? getFactoryInfo(vm) : '', style: 'td', alignment: 'left' }
        ],
        [
          {},
          {},
          { text: vm.$t('detailsView.institute_contact_person'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.office_contact_info !== null ? getContractPersonInfo(vm) : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          widths: ['5%', '5%', '50%', '5%', '35%'],
          body: allThird,
          dontBreakRows: true
        }
      })
      // 04 (Woman Enterpunior)
      if (vm.application.entrepreneurs !== null) {
        const femaleEntrepreneurs = [
          [
            { text: vm.$n(4), rowSpan: 5, style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs') + '\n' + vm.$t('etDetailsView.female_entrepreneurs_ex'), style: 'td', colSpan: 2 },
            {},
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: vm.application.entrepreneurs !== null ? vm.currentLocale === 'bn' ? vm.application.entrepreneurs.name_bn + ' ,' + vm.application.entrepreneurs.designation_bn : vm.application.entrepreneurs.name_en + ' ,' + vm.application.entrepreneurs.designation_en : '', style: 'td' }
          ],
          [
            {},
            { text: vm.$t('etDetailsView.roman_1'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs_1'), style: 'td', alignment: 'left' },
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: vm.application.entrepreneurs !== null ? vm.application.entrepreneurs.license : '', style: 'td', alignment: 'left' }
          ],
          [
            {},
            { text: vm.$t('etDetailsView.roman_2'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs_2'), style: 'td', alignment: 'left' },
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: vm.application.entrepreneurs !== null ? vm.application.entrepreneurs.license_no : '', style: 'td', alignment: 'left' }
          ],
          [
            {},
            { text: vm.$t('etDetailsView.roman_3'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs_3'), style: 'td', alignment: 'left' },
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: vm.application.entrepreneurs !== null ? parseInt(vm.application.entrepreneurs.directly_involced_business) === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : '', style: 'td', alignment: 'left' }
          ],
          [
            {},
            { text: vm.$t('etDetailsView.roman_4'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs_4'), style: 'td', alignment: 'left' },
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: vm.application.entrepreneurs !== null ? vm.getProductServiceList(vm.application.entrepreneurs.product_service_name_details) : '', style: 'td', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 5,
            widths: ['5%', '5%', '50%', '5%', '35%'],
            body: femaleEntrepreneurs
          }
        })
      } else {
        const femaleEntrepreneurs = [
          [
            { text: vm.$n(4), rowSpan: 1, style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.female_entrepreneurs') + '\n' + vm.$t('etDetailsView.female_entrepreneurs_ex'), style: 'td', colSpan: 1 },
            { text: ' : ', style: 'td', alignment: 'center' },
            { text: (vm.currentLocale === 'en' ? 'No' : 'না') }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['5%', '56%', '5%', '34%'],
            body: femaleEntrepreneurs
          }
        })
      }
      // 05
      const epz = [
        [
          { text: vm.$n(5), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.epz_company'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.org_info !== null ? parseInt(vm.application.org_info.bangladeshi_owned_company) === 1 ? (vm.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (vm.currentLocale === 'en' ? 'No' : 'না') : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '56%', '5%', '34%'],
          body: epz
        }
      })
      // Bank
      if (vm.application.bank.length > 0) {
        const bank = []
        vm.application.bank.forEach((item, index) => {
          bank.push([
            { text: vm.$n(6), style: 'td', rowSpan: vm.application.bank.length, alignment: 'center' },
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
            { text: vm.$n(6), style: 'td', rowSpan: 1, alignment: 'center' },
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
      const successDescription = [
        [
          { text: vm.$n(7), style: 'td', alignment: 'center' },
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
            { text: vm.EngBangNum(item.income_growth.toString()) + ' %', style: 'td', alignment: 'center' },
            { text: vm.getDesingationData(item.destination_id), style: 'td', alignment: 'center' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['*', '*', '*', '*', '*', '*'],
            body: successDescription2
          }
        })
      }
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
      // 08
      const complianceOne = [
        [
          { text: vm.$n(8), style: 'td', alignment: 'center', rowSpan: 1 },
          { text: getComplaince(vm), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: complianceOne
        }
      })

      // 09 new destination
        const destination = [
          [
            { text: vm.$n(9), style: 'td', alignment: 'center' },
            { text: destinationData(vm), style: 'td', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['5%', '95%'],
            body: destination
          }
        })
        if (vm.application.export_destination.length > 0) {
          const destinationTwo = [
            [
              { text: vm.$t('etDetailsView.country_org_name'), style: 'td', alignment: 'center' },
              { text: vm.$t('etDetailsView.prc_no_date'), style: 'td', alignment: 'center' },
              { text: vm.$t('etDetailsView.export_income_fob_mmd'), style: 'td', alignment: 'center' },
              { text: vm.$t('etDetailsView.relization_date'), style: 'td', alignment: 'center' }
            ]
          ]
          vm.application.export_destination.forEach((item) => {
            destinationTwo.push([
              { text: newDistinationData(vm, item), style: 'td', alignment: 'center' },
              { text: vm.EngBangNum(item.prc_no.toString()) + ' ,' + vm.$d(new Date(item.prc_date)), style: 'td', alignment: 'center' },
              { text: vm.EngBangNum(item.export_value_usd.toString()), style: 'td', alignment: 'center' },
              { text: vm.$d(new Date(item.realization_date)), style: 'td', alignment: 'center' }
            ])
          })
          pdfContent.push({
            table: {
              headerRows: 1,
              widths: ['*', '*', '*', '*'],
              body: destinationTwo,
              dontBreakRows: true
            }
          })
        }
      // 10 new Product
      const product = [
        [
          { text: vm.$n(10), style: 'td', alignment: 'center' },
          { text: productData(vm), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: product
        }
      })
      if (vm.application.export_product.length > 0) {
        const productTwo = [
          [
            { text: vm.$t('externalUser.product_name'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.hs_code'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.prc_no_date'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.export_income_fob_mmd'), style: 'td', alignment: 'center' },
            { text: vm.$t('etDetailsView.relization_date'), style: 'td', alignment: 'center' }
          ]
        ]
        vm.application.export_product.forEach((item) => {
          productTwo.push([
            { text: vm.productName(item.product_id), style: 'td', alignment: 'center' },
            { text: item.hs_code, style: 'td', alignment: 'center' },
            { text: vm.EngBangNum(item.prc_no.toString()) + ' ,' + vm.$d(new Date(item.prc_date)), style: 'td', alignment: 'center' },
            { text: vm.EngBangNum(item.export_value_usd.toString()), style: 'td', alignment: 'center' },
            { text: vm.$d(new Date(item.realization_date)), style: 'td', alignment: 'center' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['*', '*', '*', '*', '*'],
            body: productTwo,
            dontBreakRows: true
          }
        })
      }

      // 11 Dispute Settled
      const disputeSettled = [
        [
          { text: vm.$n(11), style: 'td', alignment: 'center' },
          { text: disputeSettledData(vm), style: 'td', alignment: 'left' }
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
          { text: vm.$n(12), style: 'td', alignment: 'center' },
          { text: previousTrophyData(vm), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '95%'],
          body: previousTrophy
        }
      })
      if (vm.application.et_selected.length > 0) {
        const previousTrophy2 = [
          [
            { text: vm.$t('globalTrans.year'), style: 'td', alignment: 'center' },
            { text: vm.$t('externalUser.product_name'), style: 'td', alignment: 'center' }
          ]
        ]
        vm.application.et_selected.forEach((item) => {
          previousTrophy2.push([
            { text: vm.EngBangNum(item.selection_year), style: 'td', alignment: 'center' },
            { text: vm.productName(item.product_sector_id), style: 'td', alignment: 'center' }
          ])
        })
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['*', '*'],
            body: previousTrophy2,
            dontBreakRows: true
          }
        })
      }
      // 13 Other Information
      const otherInfo = [
        [
          { text: vm.$n(13), style: 'td', alignment: 'center' },
          { text: vm.$t('detailsView.others_info'), style: 'td', alignment: 'left' },
          { text: ' : ', style: 'td', alignment: 'center' },
          { text: vm.application.other_compliance !== null ? vm.application.other_compliance.other_information : '', style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['5%', '30%', '5%', '60%'],
          body: otherInfo
        }
      })
      // pdfContent.push({ text: '', pageOrientation: 'portrait', pageBreak: 'after' })
      pdfContent.push({ text: vm.$t('detailsView.application_rules'), style: 'my_title', alignment: 'left', decoration: 'underline' })
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
          { text: vm.$t('etDetailsView.rules_four'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.five'), style: 'td', alignment: 'center' },
          { text: vm.$t('etDetailsView.rules_five'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.six'), style: 'td', alignment: 'center' },
          { text: vm.$t('etDetailsView.rules_six'), style: 'td', alignment: 'left' }
        ],
        [
          { text: vm.$t('detailsView.seven'), style: 'td', alignment: 'center' },
          { text: vm.$t('etDetailsView.rules_seven'), style: 'td', alignment: 'left' }
        ]
      ]
      pdfContent.push({
        table: {
          widths: ['5%', '95%'],
          body: otherRules,
          dontBreakRows: true
        }
      })
      pdfContent.push({ text: vm.$t('detailsView.end_extra_text'), style: 'td', alignment: 'left' })
      pdfContent.push({ text: vm.$t('globalTrans.date') + ' : ' + vm.finalSubmitDate(vm.application.updated_at), style: 'td', alignment: 'left' })

      pdfContent.push({ text: vm.$t('etDetailsView.signature_txt'), style: 'td', alignment: 'right', margin: [0, 0, 10, 0] })
      pdfContent.push({ text: vm.$t('etDetailsView.signature_txt_ex'), style: 'td', alignment: 'right', margin: [0, 0, 10, 0] })
      if (vm.application.other_compliance !== null) {
        pdfContent.push({ image: 'data:image/jpg;base64,' + vm.application.other_compliance.pdfSignature.data, alignment: 'right', height: 50, width: 80, rowSpan: '4', margin: [0, 0, 10, 0] })
      } else {
        pdfContent.push({ text: vm.currentLocale === 'bn' ? 'স্বাক্ষক .............................' : 'Signature .............................', style: 'td', alignment: 'right', margin: [0, 10, 10, 0] })
      }

    // const waterMarkText = i18n.locale === 'bn' ? 'বাণিজ্য মন্ত্রণালয়' : 'Ministry of Commerce'
    var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      watermark: { text: '', color: 'blue', opacity: 0.1, bold: true, italics: false },
      styles: {
        th: {
          fillColor: '#dee2e6',
          fontSize: 10,
          margin: [3, 2, 3, 2]
        },
        td: {
          fontSize: i18n.locale === 'bn' ? 10 : 9,
          margin: [3, 2, 3, 2]
        },
        header: {
          margin: [0, 0, 0, 0],
          fontSize: 18,
          alignment: 'center',
          bold: true
        },
        header2: {
          border: 0,
          fontSize: 11,
          margin: [0, 0, 0, 1],
          bold: true
        },
        my_title: {
          border: 0,
          fillColor: '#dee2e6',
          fontSize: 11,
          margin: [0, 10, 0, 10],
          bold: true,
          alignment: 'center'
        },
        govt_info: {
          margin: [0, 1, 0, 1],
          fontSize: 15,
          bold: true,
          alignment: 'center'
        },
        address: {
          border: 0,
          fontSize: 10,
          bold: true,
          margin: [0, 0, 0, 1]
        }
      }
    }
    pdfMake.createPdf(docDefinition, null, null, null).print() // 'et-application')
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
