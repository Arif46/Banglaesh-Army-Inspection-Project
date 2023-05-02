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
    function getTreadName (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.org_info.org_name_bn !== '' ? vm.item.org_info.org_name_bn : 'N/A'
      } else {
        return vm.item.org_info.org_name_en !== '' ? vm.item.org_info.org_name_en : 'N/A'
      }
    }
    function permanentAddress (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.org_address.address_details_bn !== '' ? vm.item.org_address.address_details_bn !== null ? vm.item.org_address.address_details_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.org_address.address_details_en !== '' ? vm.item.org_address.address_details_en !== null ? vm.item.org_address.address_details_en : 'N/A' : 'N/A'
      }
    }
    function additionalAddress (vm) {
      if (vm.currentLocale === 'bn') {
        return vm.item.additional_org_address.address_details_bn !== '' ? vm.item.additional_org_address.address_details_bn !== null ? vm.item.additional_org_address.address_details_bn : 'N/A' : 'N/A'
      } else {
        return vm.item.additional_org_address.address_details_en !== '' ? vm.item.additional_org_address.address_details_en !== null ? vm.item.additional_org_address.address_details_en : 'N/A' : 'N/A'
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
      pdfContent.push({ text: vm.$t('cip.enquiry_form_two'), style: 'marginBottom', alignment: 'center', decoration: 'underline' })
      pdfContent.push({ text: vm.$t('cip.enquiry_form_two_headding'), style: 'govt_info', alignment: 'center' })
      pdfContent.push({ text: vm.$t('cip.compnay_data'), style: 'marginBottom', alignment: 'left', decoration: 'underline' })

      // Body Start
      // column 1
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(1) + '.' + vm.$t('cip.title'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[getDesignation(vm)]] } }
          ],
          [
            { text: vm.$t('cip.trade_name'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[getTreadName(vm)]] } }
          ]
        ],
        columnGap: 30
      })

      // column 2
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(2) + '.' + vm.$t('cip.legal_form'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.org_info.legal_form !== '' ? vm.item.org_info.legal_form : 'N/A']] } }
          ],
          [
            { text: vm.$n(3) + '.' + vm.$t('cip.tin'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.$n(vm.item.org_tax_info.tin_no, { useGrouping: false })]] } }
          ]
        ],
        columnGap: 30
      })

      // main permanent address
      pdfContent.push({ text: vm.$t('cip.com_main_per_address'), alignment: 'left', decoration: 'underline', bold: true })
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(4) + '.' + vm.$t('cip.street_no_name_vill_ps_up'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[permanentAddress(vm)]] } }
          ]
        ]
      })
      pdfContent.push({
        columns: [
          [
            { text: vm.$t('globalTrans.district'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.org_address.district_id !== '' ? vm.getDistrictName(vm.item.org_address.district_id) : 'N/A']] } }
          ],
          [
            { text: vm.$t('cip.postal_code'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.org_address.post_code !== '' ? vm.$n(vm.item.org_address.post_code, { useGrouping: false }) : 'N/A']] } }
          ],
          [
            { text: vm.$t('globalTrans.country'), alignment: 'left', bold: true },
            { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.item.org_address.country_id ? vm.countryName(vm.item.org_address.country_id) : 'N/A']] } }
          ]
        ]
      })

      // main present address
      pdfContent.push({ text: vm.$t('cip.add_bussness_address'), alignment: 'left', decoration: 'underline', bold: true })
      if (vm.item.additional_org_address !== null) {
        pdfContent.push({
          columns: [
            [
              { text: vm.$n(5) + '.' + vm.$t('cip.street_no_name_vill_ps_up'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [[additionalAddress(vm)]] } }
            ]
          ]
        })
      } else {
        pdfContent.push({
          columns: [
            [
              { text: vm.$n(5) + '.' + vm.$t('cip.street_no_name_vill_ps_up'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [['N/A']] } }
            ]
          ]
        })
      }
      if (vm.item.additional_org_address !== null) {
        pdfContent.push({
          columns: [
            [
              { text: vm.$t('globalTrans.district'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [[vm.item.additional_org_address.district_id !== '' ? vm.getDistrictName(vm.item.additional_org_address.district_id) : 'N/A']] } }
            ],
            [
              { text: vm.$t('cip.postal_code'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [[vm.item.additional_org_address.postal_code ? vm.$n(vm.item.additional_org_address.postal_code, { useGrouping: false }) : 'N/A']] } }
            ],
            [
              { text: vm.$t('globalTrans.country'), alignment: 'left', bold: true },
              { alignment: 'left', style: 'th', table: { widths: '100%', body: [[vm.countryName(vm.item.additional_org_address.country_id)]] } }
            ]
          ]
        })
      } else {
        pdfContent.push({
          columns: [
            [
              { text: vm.$t('globalTrans.district'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [['N/A']] } }
            ],
            [
              { text: vm.$t('cip.postal_code'), alignment: 'left', bold: true },
              { alignment: 'left', table: { widths: '100%', body: [['N/A']] } }
            ],
            [
              { text: vm.$t('globalTrans.country'), alignment: 'left', bold: true },
              { alignment: 'left', style: 'th', table: { widths: '100%', body: [['N/A']] } }
            ]
          ]
        })
      }
      pdfContent.push({
        columns: [
          [
            { text: vm.$n(6) + '.' + vm.$t('externalUser.telephone_no'), alignment: 'left', bold: true },
            { alignment: 'left', table: { widths: '100%', body: [[vm.item.office_contact_info.telephone_no !== '' ? vm.$n(vm.item.office_contact_info.telephone_no, { useGrouping: false }) : '']] } }
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
