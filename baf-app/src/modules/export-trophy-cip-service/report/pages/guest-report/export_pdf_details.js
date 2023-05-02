import i18n from '@/i18n'
import Store from '@/store'
import ReportHeading from '@/utils/report-head'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (baseUrl, uri, orgId, reportTitle, vm, newDatas, search, searchHeader) => {
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
      const pdfContent = [{
            columns: reportHeadData.reportHeadColumn
        },
        { text: reportHeadData.orgName, style: 'org', alignment: 'center' },
        { text: reportHeadData.projectName, style: 'address', alignment: 'center' },
        { text: reportHeadData.address, style: 'address', alignment: 'center' },
        { text: reportTitle, style: 'hh', alignment: 'center' }
      ]
      const allRowD = []
      if (search.award_type === 1) {
        const firstRowHeader = [
          { text: vm.$t('exportTrophyConfig.awardType') + ' : ' + (search.award_type === 1 ? i18n.locale === 'en' ? 'CIP' : 'সিআইপি' : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
          { text: vm.$t('globalTrans.year') + ' : ' + (search.year ? (i18n.locale === 'en' ? searchHeader.year : searchHeader.year_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
          { text: vm.$t('eventManage.venue') + ' : ' + (search.venue_id ? (i18n.locale === 'en' ? searchHeader.venue_name : searchHeader.venue_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        ]
        allRowD.push(firstRowHeader)
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: '*',
            body: allRowD
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
      }
      if (search.award_type === 2) {
        const firstRowHeader = [
          { text: vm.$t('exportTrophyConfig.awardType') + ' : ' + (search.award_type === 2 ? i18n.locale === 'en' ? 'Export Trophy' : 'রপ্তানি ট্রফি' : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
          { text: vm.$t('globalTrans.fiscal_year') + ' : ' + (search.fiscal_year_id ? (i18n.locale === 'en' ? searchHeader.fiscal_year : searchHeader.fiscal_year_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true },
          { text: vm.$t('eventManage.venue') + ' : ' + (search.venue_id ? (i18n.locale === 'en' ? searchHeader.venue_name : searchHeader.venue_name_bn) : vm.$t('globalTrans.all')), alignment: 'left', style: 'th', bold: true }
        ]
        allRowD.push(firstRowHeader)
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: '*',
            body: allRowD
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
      }
      const allRows = [
        [
          { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('eventManage.venue'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.invitation_titile'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.total_invited'), style: 'th', alignment: 'center', bold: true },
          { text: vm.$t('exportCipReport.total_attend'), style: 'th', alignment: 'center', bold: true }
        ]
      ]
      newDatas.forEach((info2, index) => {
        allRows.push([
          { text: vm.$n(index + 1), alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info2.venue_name_bn : info2.venue_name, alignment: 'center', style: 'td' },
          { text: (i18n.locale === 'bn') ? info2.title_bn : info2.title_en, alignment: 'center', style: 'td' },
          { text: vm.$n(info2.total_invited_guest, { useGrouping: false }), alignment: 'center', style: 'td' },
          { text: vm.$n(info2.total_attend_guest, { useGrouping: false }), alignment: 'center', style: 'td' }
        ])
      })
      pdfContent.push({
        table: {
          headerRows: 1,
          widths: ['10%', '15%', '25%', '25%', '25%'],
          body: allRows
        }
      })
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
          fontSize: (i18n.locale === 'bn') ? 9 : 8,
          margin: [3, 3, 3, 3]
        },
        search: {
          fontSize: (i18n.locale === 'bn') ? 10 : 11,
          margin: [3, 3, 3, 3]
        },
        fertilizer: {
          margin: [5, 0, 0, 5]
        },
        header: {
            fontSize: 16,
            bold: true,
            margin: [0, 0, 0, 0]
        },
        org: {
            fontSize: 13,
            bold: true,
            margin: [0, -25, 10, 5]
        },
        address: {
            fontSize: 11,
            margin: [0, 0, 0, 5]
        },
        hh: {
            fontSize: 13,
            bold: true,
            margin: [10, 10, 25, 20]
        },
        header2: {
          fontSize: 11,
          margin: [0, 10, 0, 0]
        },
        header3: {
          fontSize: 10,
          margin: [0, 6, 0, 0]
        },
        header4: {
          fontSize: 9,
          margin: [0, 6, 0, 9]
        },
        headerPort1: {
          fontSize: 10,
          margin: [0, 20, 0, 5]
        },
        headerPort: {
          fontSize: 10,
          margin: [0, 4, 0, 11]
        },
        krishi: {
          margin: [0, -5, 0, 11],
          alignment: 'center'
        },
        tableSubHead: {
          margin: [0, 5, 0, 11]
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
