import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import Address from '@/utils/area-type-address'

function getAddress (address) {
  return Address.getPresentAddress(address)
}

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, signatureType, signature) => {
  try {
    Store.commit('mutateCommonProperties', {
      loading: true
    })

    if (i18n.locale === 'bn') {
      pdfMake.vfs = pdfFontsBn.pdfMake.vfs
    } else {
      pdfMake.vfs = pdfFontsEn.pdfMake.vfs
    }

    const reportHeadData = await ReportHeading.getReportHead(baseUrl, uri, orgId)

    const pdfContent = [
      { columns: reportHeadData.reportHeadColumn },
      { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
      { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
      { text: reportHeadData.address, style: 'address', alignment: 'center' },
      { text: reportTitle, style: 'hh', alignment: 'center' }
    ]

    pdfContent.push({ text: vm.$t('cip.cip_list'), style: 'thh' })
    const allRows = [
      [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.name'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.designation'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.institution'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.address'), style: 'th', alignment: 'center', bold: true }
      ]
    ]

    vm.applications.cip_applicants.forEach((data, index) => {
      allRows.push([
        { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.name_en : data.name_bn, alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.designation_en : data.designation_bn, alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.institute_en : data.institute_bn, alignment: 'center', style: 'td' },
        { text: getAddress(data.address), alignment: 'center', style: 'td' }
      ])
    })
    pdfContent.push({
      table: {
        headerRows: 1,
        widths: '*',
        body: allRows
      }
    })

    pdfContent.push({ text: '', style: 'space' })
    pdfContent.push({ text: '', style: 'space' })
    pdfContent.push({ text: vm.$t('cip.cip_trade') + ' ' + vm.$t('globalTrans.list'), style: 'thh' })
    const allRows1 = [
      [
        { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.name'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.designation'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('cip.institution'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.address'), style: 'th', alignment: 'center', bold: true }
      ]
    ]
    vm.applications.cip_trades.forEach((data, index) => {
      allRows1.push([
        { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.name_en : data.name_bn, alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.designation_en : data.designation_bn, alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.institute_en : data.institute_bn, alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.address_en : data.address_bn, alignment: 'center', style: 'td' }
      ])
    })

    pdfContent.push({
      table: {
        headerRows1: 1,
        widths: '*',
        body: allRows1
      }
    })

    if (signatureType === 2) {
      pdfContent.push({ text: '', style: 'space', alignment: 'left' })
      pdfContent.push({ text: '', style: 'space', alignment: 'left' })
      pdfContent.push({ text: '', style: 'space', alignment: 'left' })
      pdfContent.push({ text: '', style: 'space', alignment: 'left' })

      pdfContent.push({ text: signature, style: 'space', alignment: 'left' })
      pdfContent.push({ text: '......................................................................', style: 'space', alignment: 'left' })
      pdfContent.push({ text: vm.$t('cip.automated_signature'), style: 'space', alignment: 'left' })
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
