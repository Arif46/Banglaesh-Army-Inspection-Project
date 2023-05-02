import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (vm) => {
    function getDesignation (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.designation_bn !== '' ? vm.item.owner_info.designation_bn : 'N/A'
      } else {
        return vm.item.owner_info.designation_en !== '' ? vm.item.owner_info.designation_en : 'N/A'
      }
    }
    function getName (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.owner_name_bn !== '' ? vm.item.owner_info.owner_name_bn : 'N/A'
      } else {
        return vm.item.owner_info.owner_name_en !== '' ? vm.item.owner_info.owner_name_en : 'N/A'
      }
    }
    function getFatherTitle (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.father_title_bn !== '' ? (vm.item.owner_info.father_title_bn !== null) ? vm.item.owner_info.father_title_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.owner_info.father_title_en !== '' ? (vm.item.owner_info.father_title_en !== null) ? vm.item.owner_info.father_title_en : 'N/A' : 'N/A'
      }
    }
    function getFatherName (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.father_husband_name_bn !== '' ? vm.item.owner_info.father_husband_name_bn : 'N/A'
      } else {
        return vm.item.owner_info.father_husband_name_en !== '' ? vm.item.owner_info.father_husband_name_en : 'N/A'
      }
    }
    function getMotherTitle (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.mother_title_bn !== '' ? (vm.item.owner_info.mother_title_bn !== null) ? vm.item.owner_info.mother_title_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.owner_info.mother_title_en !== '' ? (vm.item.owner_info.mother_title_en !== null) ? vm.item.owner_info.mother_title_en : 'N/A' : 'N/A'
      }
    }
    function getMotherName (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.mother_name_bn !== '' ? vm.item.owner_info.mother_name_bn : 'N/A'
      } else {
        return vm.item.owner_info.mother_name_en !== '' ? vm.item.owner_info.mother_name_en : 'N/A'
      }
    }
    function getHusbandTitle (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.husband_title_bn !== '' ? (vm.item.owner_info.husband_title_bn !== null) ? vm.item.owner_info.husband_title_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.owner_info.husband_title_en !== '' ? (vm.item.owner_info.husband_title_en !== null) ? vm.item.owner_info.husband_title_en : 'N/A' : 'N/A'
      }
    }
    function getHusbandName (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.owner_info.husband_name_bn !== '' ? (vm.item.owner_info.husband_name_bn !== null) ? vm.item.owner_info.husband_name_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.owner_info.husband_name_en !== '' ? (vm.item.owner_info.husband_name_en !== null) ? vm.item.owner_info.husband_name_en : 'N/A' : 'N/A'
      }
    }
    function permanentAddress (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.address.pm_address_details_bn !== null ? vm.item.address.pm_address_details_bn !== '' ? vm.item.address.pm_address_details_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.address.pm_address_details_en !== null ? vm.item.address.pm_address_details_en !== '' ? vm.item.address.pm_address_details_en : 'N/A' : 'N/A'
      }
    }
    function presentAddress (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.address.pr_address_details_bn !== null ? vm.item.address.pr_address_details_bn !== '' ? vm.item.address.pr_address_details_bn : 'N/A' : ''
      } else {
        return vm.item.address.pr_address_details_en !== null ? vm.item.address.pr_address_details_en !== '' ? vm.item.address.pr_address_details_en : 'N/A' : ''
      }
    }

    try {
      Store.commit('mutateCommonProperties', {
        loading: true
      })
      if (i18n.locale === 'bn') {
        pdfMake.vfs = pdfFontsBn.pdfMake.vfs
      } else {
        pdfMake.vfs = pdfFontsEn.pdfMake.vfs
      }

      // Start heading
      const pdfContent = []
      pdfContent.push({ text: vm.$t('cip.enquiry_form_one'), style: 'marginBottom', alignment: 'center', decoration: 'underline' })
      pdfContent.push({ text: '( ' + vm.$t('cip.for_individual') + ' )', style: 'govt_info', alignment: 'center' })
      pdfContent.push({ text: vm.$t('cip.individual'), style: 'marginBottom', alignment: 'left', decoration: 'underline' })

      // Body Start
      // column 1
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(1) + '.' + vm.$t('cip.title'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[getDesignation(vm)]] } }
          ],
          [
            { text: vm.$t('cip.name'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[getName(vm)]] } }
          ]
        ],
        columnGap: 30
      })

      // column 2
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(2) + '.' + vm.$t('cip.father_title'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[getFatherTitle(vm)]] } }
          ],
          [
            { text: vm.$t('cip.father_name'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[getFatherName(vm)]] } }
          ]
        ],
        columnGap: 30
      })

      // column 3
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(3) + '.' + vm.$t('cip.mother_title'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[getMotherTitle(vm)]] } }
          ],
          [
            { text: vm.$t('cip.mother_name'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[getMotherName(vm)]] } }
          ]
        ],
        columnGap: 30
      })

      // column 4
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(4) + '.' + vm.$t('cip.husband_title'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[getHusbandTitle(vm)]] } }
          ],
          [
            { text: vm.$t('cip.husband_name'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[getHusbandName(vm)]] } }
          ]
        ],
        columnGap: 30
      })

      // column 5/6
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(5) + '.' + vm.$t('cip.nid_number'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.owner_info.nid_no !== '' ? vm.EngBangNum(vm.item.owner_info.nid_no) : '']] } }
          ],
          [
            { text: vm.$n(6) + '.' + vm.$t('cip.tin'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.org_tax_info.tin_no !== '' ? vm.EngBangNum(vm.item.org_tax_info.tin_no) : '']] } }
          ]
        ],
        columnGap: 30
      })

      // column 7/8
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(7) + '.' + vm.$t('cip.date_of_birth'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.owner_info.dob !== '' ? vm.$d(new Date(vm.item.owner_info.dob)) : '']] } }
          ],
          [
            { text: vm.$n(8) + '.' + vm.$t('globalTrans.gender'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.owner_info.gender ? vm.genderName(vm.item.owner_info.gender) : 'N/A']] } }
          ]
        ],
        columnGap: 30
      })

      // column 9/10
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(9) + '.' + vm.$t('cip.district_of_birth'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.owner_info.district_of_birth !== '' ? vm.item.owner_info.district_of_birth : 'N/A']] } }
          ],
          [
            { text: vm.$n(10) + '.' + vm.$t('cip.country_of_birth'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.owner_info.country_of_birth !== '' ? vm.item.owner_info.country_of_birth : 'N/A']] } }
          ]
        ],
        columnGap: 30
      })

      // main permanent address
      pdfContent.push({ text: vm.$t('cip.main_per_address'), alignment: 'left', decoration: 'underline', bold: true })
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(11) + '.' + vm.$t('cip.street_no_name_vill_ps_up'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[permanentAddress(vm)]] } }
          ]
        ]
      })
      pdfContent.push({
        columns: [
          [
            { text: vm.$t('globalTrans.district'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.address.pm_district_id !== '' ? vm.getDistrictName(vm.item.address.pm_district_id) : 'N/A']] } }
          ],
          [
            { text: vm.$t('cip.postal_code'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.address.pm_postal_code !== '' ? vm.EngBangNum(vm.item.address.pm_postal_code) : 'N/A']] } }
          ],
          [
            { text: vm.$t('globalTrans.country'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.address.pm_country_id ? vm.countryName(vm.item.address.pm_country_id) : 'N/A']] } }
          ]
        ]
      })

      // main present address
      pdfContent.push({ text: vm.$t('cip.additional_pre_address'), alignment: 'left', decoration: 'underline', bold: true })
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(12) + '.' + vm.$t('cip.street_no_name_vill_ps_up'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[presentAddress(vm)]] } }
          ]
        ]
      })

      pdfContent.push({
        columns: [
          [
            { text: vm.$t('globalTrans.district'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.address.pr_district_id !== '' ? vm.getDistrictName(vm.item.address.pr_district_id) : 'N/A']] } }
          ],
          [
            { text: vm.$t('cip.postal_code'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.address.pr_postal_code !== '' ? vm.EngBangNum(vm.item.address.pr_postal_code) : 'N/A']] } }
          ],
          [
            { text: vm.$t('globalTrans.country'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.address.pr_country_id ? vm.countryName(vm.item.address.pr_country_id) : 'N/A']] } }
          ]
        ]
      })
      // Indentification document data
      pdfContent.push({ text: vm.$t('cip.identification_document_data'), alignment: 'left', decoration: 'underline', bold: true })
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(13) + '.' + vm.$t('cip.id_type'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.passport_info.passport_no !== '' ? vm.EngBangNum(vm.item.passport_info.passport_no) : '']] } }
          ]
        ]
      })

      pdfContent.push({
        columns: [
          [
            { text: vm.$t('cip.issue_date'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.passport_info.issue_date !== '' ? vm.$d(new Date(vm.item.passport_info.issue_date)) : '']] } }
          ],
          [
            { text: vm.$t('cip.issue_country'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.passport_info.country_id !== '' ? vm.countryName(vm.item.passport_info.country_id) : '']] } }
          ]
        ],
        columnGap: 30
      })
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(14) + '.' + vm.$t('externalUser.telephone_no'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.office_contact_info.telephone_no !== '' ? vm.EngBangNum(vm.item.office_contact_info.telephone_no) : '']] } }
          ]
        ]
      })

      var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      styles: {
        th: {
          margin: [0, 0, 0, 8]
        },
        marginBottom: {
          fontSize: (i18n.locale === 'bn') ? 16 : 14,
          margin: [0, 0, 0, 8]
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
