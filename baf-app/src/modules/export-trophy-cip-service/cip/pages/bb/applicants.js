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
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]

    const allRows = [
      [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.sector_wise_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.name_father_mother_address'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.org_name_address_phone_fax'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.bb_comment'), style: 'th', alignment: 'center', bold: true }
      ]
    ]

    vm.applications.forEach((item, index) => {
      if (item.sector_id) {
        const productServiceSectorName = (i18n.locale === 'bn') ? item.sector_name_bn : item.sector_name_en
        allRows.push([
          { text: vm.$t('exportTrophy.product_service_sector') + ': ' + productServiceSectorName, colSpan: 5, alignment: 'center', style: 'td' },
          {},
          {},
          {},
          {}
        ])
      }

      item.details.forEach((data, index1) => {
        const name = (i18n.locale === 'en' ? data.name_en : data.name_bn) + ', \n'
        const designation = (i18n.locale === 'en' ? data.designation_en : data.designation_bn) + ', \n'
        const father = vm.$t('cip.father') + '- ' + (i18n.locale === 'en' ? data.father_name_en : data.father_name_bn) + ', \n'
        const mother = vm.$t('cip.mother') + '- ' + (i18n.locale === 'en' ? data.mother_name_en : data.mother_name_bn) + ', \n'
        const nameAddress = name + designation + father + mother + getAddress(data.address)

        const orgName = i18n.locale === 'en' ? data.org_info.org_name_en : data.org_info.org_name_bn + ', \n'
        const orgAddress = getCommonAddress(data.org_address) + ', \n'
        const orgPhone = (data.office_contact_info ? vm.$n(data.office_contact_info.telephone_no, { useGrouping: false }) : '') + ', '
        const orgFax = (data.office_contact_info ? vm.$n(data.office_contact_info.fax_no, { useGrouping: false }) : '')
        const orgNameAddress = orgName + orgAddress + orgPhone + orgFax

        allRows.push([
          { text: vm.$n((item.sector_sl + 1), { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: vm.$n((index1 + 1), { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: nameAddress, alignment: 'left', style: 'td' },
          { text: orgNameAddress, alignment: 'left', style: 'td' },
          { text: (data.profile_verification && data.profile_verification.bb_comment) ? data.profile_verification.bb_comment : '', alignment: 'center', style: 'td' }
        ])
      })
    })

    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['8%', '8%', '28%', '28%', '28%'],
        body: allRows
      }
    })

    var docDefinition = {
      content: pdfContent,
      pageSize: 'A4',
      pageOrientation: 'portrait',
      defaultStyle: {
        font: 'Kalpurush'
      },
      styles: {
        th: {
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
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
