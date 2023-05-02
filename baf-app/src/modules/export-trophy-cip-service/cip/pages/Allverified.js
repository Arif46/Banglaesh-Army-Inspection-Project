import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_pdf_kal_fonts_bn'
// import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import Address from '@/utils/area-type-address'

function getAddress (address) {
  return Address.getPresentAddress(address)
}

function getCommonAddress (address) {
  return Address.getCommonAddress(address)
}

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm) => {
  try {
    Store.commit('mutateCommonProperties', {
      loading: true
    })
    pdfMake.vfs = pdfFontsBn.pdfMake.vfs
    pdfMake.fonts = {
      Kalpurush: {
        normal: 'Kalpurush.ttf',
        bold: 'Kalpurush.ttf',
        italics: 'Kalpurush.ttf',
        bolditalics: 'Kalpurush.ttf'
      }
    }

    const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)

    const pdfContent = [
      { columns: reportHeadData.reportHeadColumn },
      { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData.address, style: 'address', alignment: 'center' },
      { text: vm.$n(vm.year, { useGrouping: false }) + ' ' + reportTitle, style: 'hh', alignment: 'center' }
    ]

    const allRows = [
      [
        { text: vm.$t('globalTrans.sl_no'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.sector_wise_no'), rowSpan: 3, style: 'th1', alignment: 'center', bold: true },
        { text: vm.$t('cip.name_father_mother_address'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.org_name_address_phone_fax'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: i18n.locale === 'en' ? vm.fiscalYear_en + ' ' + vm.$t('cip.report_para') : vm.fiscalYear_bn + ' ' + vm.$t('cip.report_para'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.trade_disputes'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.nbr_opinion'), colSpan: 4, style: 'th', alignment: 'center', bold: true },
        {},
        {},
        {},
        { text: vm.$t('cip.bangladesh_bank'), rowSpan: 3, style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.public_safety'), colSpan: 2, style: 'th', alignment: 'center', bold: true },
        {},
        { text: vm.$t('globalTrans.comments'), rowSpan: 3, style: 'th', alignment: 'center', bold: true }
      ]
    ]

    allRows.push([
      {},
      {},
      {},
      {},
      {},
      {},
      { text: vm.$t('cip.income_tax'), colSpan: 2, style: 'th', alignment: 'center', bold: true },
      {},
      { text: vm.$t('cip.tax'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
      { text: vm.$t('cip.vat'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
      {},
      { text: vm.$t('cip.sb'), rowSpan: 2, style: 'th', alignment: 'center', bold: true },
      { text: vm.$t('cip.nsi'), rowSpan: 2, style: 'th1', alignment: 'center', bold: true },
      { text: vm.$t('cip.cip_commentt'), rowSpan: 3, style: 'th', alignment: 'center', bold: true }
    ])
    allRows.push([
      {},
      {},
      {},
      {},
      {},
      {},
      { text: vm.$t('cip.institution'), style: 'th1', alignment: 'center', bold: true },
      { text: vm.$t('cip.person'), style: 'th', alignment: 'center', bold: true },
      {},
      {},
      {},
      {},
      {},
      {}
    ])
    allRows.push([
      { text: vm.$n(1), alignment: 'center', style: 'td' },
      { text: vm.$n(2), alignment: 'center', style: 'td' },
      { text: vm.$n(3), alignment: 'center', style: 'td' },
      { text: vm.$n(4), alignment: 'center', style: 'td' },
      { text: vm.$n(5), alignment: 'center', style: 'td' },
      { text: vm.$n(6), alignment: 'center', style: 'td' },
      { text: vm.$n(7), alignment: 'center', style: 'td' },
      { text: vm.$n(8), alignment: 'center', style: 'td' },
      { text: vm.$n(9), alignment: 'center', style: 'td' },
      { text: vm.$n(10), alignment: 'center', style: 'td' },
      { text: vm.$n(11), alignment: 'center', style: 'td' },
      { text: vm.$n(12), alignment: 'center', style: 'td' },
      { text: vm.$n(13), alignment: 'center', style: 'td' },
      { text: vm.$n(14), alignment: 'center', style: 'td' }
    ])

    vm.applications.forEach((item, index) => {
      if (item.sector_id) {
        const productServiceSectorName = (i18n.locale === 'bn') ? item.sector_name_bn : item.sector_name_en
        allRows.push([
          { text: vm.$t('exportTrophy.product_service_sector') + ': ' + productServiceSectorName, rowSpan: item.details.length, colSpan: 14, alignment: 'center', style: 'td' },
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {},
          {}
        ])
      }

      item.details.forEach((data, index1) => {
        const name = i18n.locale === 'en' ? data.name_en : data.name_bn + ', \n'
        const designation = i18n.locale === 'en' ? data.designation_en : data.designation_bn + ', \n'
        const father = vm.$t('cip.father') + '- ' + (i18n.locale === 'en' ? data.father_name_en : data.father_name_bn) + ', \n'
        const mother = vm.$t('cip.mother') + '- ' + (i18n.locale === 'en' ? data.mother_name_en : data.mother_name_bn) + ', \n'
        const nameAddress = name + designation + father + mother + getAddress(data.address)

        const orgName = i18n.locale === 'en' ? data.org_info.org_name_en : data.org_info.org_name_bn + ', \n'
        const orgAddress = getCommonAddress(data.org_address) + ', \n'
        const orgPhone = (data.office_contact_info ? vm.$n(data.office_contact_info.telephone_no, { useGrouping: false }) : '') + ', '
        const orgFax = data.office_contact_info ? vm.$n(data.office_contact_info.fax_no, { useGrouping: false }) : ''
        const orgNameAddress = orgName + orgAddress + orgPhone + orgFax
        pdfContent.push({ text: '', style: 'space' })
        allRows.push([
          { text: vm.$n((item.sector_sl + 1), { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: vm.$n((index1 + 1), { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: nameAddress, alignment: 'left', style: 'td' },
          { text: orgNameAddress, alignment: 'left', style: 'td' },
          { text: vm.$n(data.product_success_description[1].export_value_ssd, { useGrouping: false }), alignment: 'left', style: 'td' },
          { text: data.other_compliance.compliance_current_fiscal_year === 2 ? i18n.locale === 'en' ? 'Yes' : 'হ্যাঁ' : i18n.locale === 'en' ? 'No' : 'না', alignment: 'center', style: 'td' },
          { text: data.profile_verification.nbr_institute_revenue ? vm.$n(data.profile_verification.nbr_institute_revenue, { useGrouping: false }) : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.nbr_person_revenue ? vm.$n(data.profile_verification.nbr_person_revenue, { useGrouping: false }) : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.nbr_tax ? vm.$n(data.profile_verification.nbr_tax, { useGrouping: false }) : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.nbr_vat ? vm.$n(data.profile_verification.nbr_vat, { useGrouping: false }) : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.bb_comment ? data.profile_verification.bb_comment : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.moha_sb ? data.profile_verification.moha_sb : '', alignment: 'center', style: 'td' },
          { text: data.profile_verification.moha_nsi ? data.profile_verification.moha_nsi : '', alignment: 'center', style: 'td' },
          {}
        ])
      })
    })

    pdfContent.push({
      table: {
        headerRows: 3,
        widths: ['5%', '5%', '15%', '15%', '9%', '6%', '6%', '5%', '5%', '5%', '9%', '5%', '5%', '5%'],
        body: allRows
      }
    })

    var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'landscape',
      defaultStyle: {
        font: 'Kalpurush'
      },
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        th1: {
          fontSize: (i18n.locale === 'bn') ? 8 : 7,
          margin: [3, 3, 3, 3]
        },
        thh: {
          fontSize: (i18n.locale === 'bn') ? 12 : 10,
          margin: [3, 3, 3, 3]
        },
        td: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        tdCustom: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          padding: [0, 0, 0, 10]
        },
        search: {
          fontSize: (i18n.locale === 'bn') ? 10 : 11,
          margin: [3, 3, 3, 3]
        },
        space: {
          margin: [5, 0, 0, 5]
        },
        header: {
          fontSize: 17,
          bold: true,
          margin: [0, 5, 0, 0]
        },
        address: {
          fontSize: 11,
          margin: [0, 0, 0, 5]
        },
        hh: {
          fontSize: 13,
          bold: true,
          margin: [10, 10, 25, 20]
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
