import i18n from '@/i18n'
import Store from '@/store'
import pdfMake from 'pdfmake/build/pdfmake'
import pdfFontsBn from 'pdfmake/build/vfs_fonts_bn'
import pdfFontsEn from 'pdfmake/build/vfs_fonts_en'

const exportPdfDetails = async (baseUrl, uri, orgId, vm) => {
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
        pdfContent.push({ text: vm.$t('tradeFairProposalManagement.exportPromotionBureau'), alignment: 'center', style: 'title' })
        pdfContent.push({ text: '(' + vm.$t('tradeFairProposalManagement.fair_list') + ' : ' + vm.getFiscalYear(vm.items.fiscal_year_id) + ') ' + vm.$t('tradeFairProposalManagement.product_wise'), style: 'exportTropyUnder', alignment: 'center', decoration: 'underline' })
        // pdfContent.push({ text: vm.$t('externalTradeFair.type_of_fair') + ': ' + 'vm.getTypeOfFair()', style: 'td', alignment: 'left', decoration: 'underline', bold: true })
        const allRowsHead = [
          [
            { text: vm.$t('globalTrans.sl_no'), style: 'th', alignment: 'left' },
            { text: vm.$t('tradeFairProposalManagement.name_and_title'), style: 'th', alignment: 'left' },
            { text: vm.$t('tradeFairProposalManagement.'), style: 'th', alignment: 'left' },
            { text: vm.$t('externalTradeFair.duration'), style: 'th', alignment: 'left' }
          ]
        ]
        pdfContent.push({
          table: {
            headerRows: 1,
            widths: ['10%', '40%', '25%', '25%'],
            body: allRowsHead
          }
        })

        let i = 1
        let dataCount = 1
        for (const prop in vm.finalList) {
          const allRowsHead = [
            [
              { text: vm.$n(parseInt(i++)) + '.' + vm.getFairSector(prop), style: 'th', alignment: 'left', colSpan: 4 },
              {},
              {},
              {}
            ]
          ]
          vm.finalList[prop].forEach((item, index2) => {
            allRowsHead.push([
              { text: vm.$n(parseInt(dataCount++)), style: 'td', alignment: 'left' },
              { text: vm.currentLocale === 'bn' ? item.fair_name_bn : item.fair_name, style: 'td', alignment: 'left' },
              { text: (vm.currentLocale === 'bn' ? item.city_bn : item.city) + ', ' + vm.getCountry(item.country_id), style: 'td', alignment: 'left' },
              { text: vm.getDuration(item.date_from, item.date_to), style: 'td', alignment: 'left' }
            ])
          })
          pdfContent.push({
            table: {
              headerRows: 1,
              widths: ['10%', '40%', '25%', '25%'],
              body: allRowsHead
            }
          })
        }

        var docDefinition = {
            content: pdfContent,
            pageSize: 'A4',
            pageOrientation: 'portrait',
            watermark: { text: '', color: 'blue', opacity: 0.1, bold: true, italics: false },
            styles: {
                th: {
                    fontSize: (i18n.locale === 'bn') ? 9 : 8,
                    margin: [3, 3, 3, 3]
                },
                td: {
                    fontSize: (i18n.locale === 'bn') ? 9 : 8,
                    margin: [3, 3, 3, 3]
                },
                typeHeading: {
                    background: '#ddd'
                },
                title: {
                  fontSize: 18,
                  bold: true
                },
                exportTropyUnder: {
                  fontSize: 15,
                  margin: [0, 3, 0, 15],
                  bold: true
                }
            }
        }
      pdfMake.createPdf(docDefinition, null, null, null).print()
      vm.customloading = false
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
