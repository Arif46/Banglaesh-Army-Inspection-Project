import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'
import AddressHelper from '@/utils/area-type-address'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, signatureType, signature) => {
  function getTrophyType (type) {
    if (type === 1) {
      return vm.$t('exportTrophyConfig.gold')
    } else if (type === 2) {
      return vm.$t('exportTrophyConfig.silver')
    } else if (type === 3) {
      return vm.$t('exportTrophyConfig.bronze')
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
        { text: vm.$t('globalTrans.application_id'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('exportTrophy.org_name_address'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('exportTrophy.owner_or_md_name'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('externalUser.tin_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('globalTrans.vat') + '/' + vm.$t('externalUser.bin_no'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('exportTrophy.position'), style: 'th', alignment: 'center', bold: true },
        { text: vm.$t('exportTrophy.trophy_type'), style: 'th', alignment: 'center', bold: true }
      ]
    ]

    vm.applications.forEach((data, index) => {
      allRows.push([
        { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
        { text: vm.$n(data.application_id, { useGrouping: false }), alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.org_info.org_name_en : data.org_info.org_name_bn + AddressHelper.getCommonAddress(data.org_address), alignment: 'center', style: 'td' },
        { text: i18n.locale === 'en' ? data.owner_info.owner_name_en : data.owner_info.owner_name_bn, alignment: 'center', style: 'td' },
        { text: vm.$n(data.org_tax_info.tin_no, { useGrouping: false }), alignment: 'center', style: 'td' },
        { text: vm.$n(data.org_info.bin_no, { useGrouping: false }), alignment: 'center', style: 'td' },
        { text: vm.$n(data.position, { useGrouping: false }), alignment: 'center', style: 'td' },
        { text: getTrophyType(data.evaluation.trophy), alignment: 'center', style: 'td' }
      ])
    })

    pdfContent.push({
      table: {
        headerRows: 1,
        widths: ['8%', '10%', '20%', '20%', '12%', '10%', '10%', '10%'],
        body: allRows
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
