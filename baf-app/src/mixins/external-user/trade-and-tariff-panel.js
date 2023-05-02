import RestApi, { tradeTariffServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedTradeService () {
      return this.$store.state.ExternalUserService.tradeTariff.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedTradeService: function (newValue) {
      if (!newValue) {
        this.loadCommonDropdown()
      }
    }
  },
  created () {
    this.loadCommonDropdown()
  },
  methods: {
    loadCommonDropdown () {
      RestApi.getData(tradeTariffServiceBaseUrl, 'trade-tariff-external-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateTradeTariffPanelCommonObj', {
            hasDropdownLoaded: true,
            tradeTariffCountryList: response.data.tradeTariffCountryList,
            applicationTypeList: response.data.applicationTypeList,
            currencyList: response.data.currencyList,
            capitalInfoList: response.data.capitalInfoList,
            productList: response.data.productList,
            unitMeasurementList: response.data.unitMeasurementList,
            sectionNoList: this.section(response.data.sectionList),
            chapterNoList: this.chapter(response.data.chapterList),
            headingList: this.heading(response.data.headingList)
          })
          this.$store.dispatch('ExternalUserService/localizeTradeTariffPanelDropdown', { value: this.$i18n.locale })
        }
      })
    },
    section (arr) {
      return arr.map(el => {
        return Object.assign({}, el, {
          text: 'Section ' + el.text,
          text_en: 'Section ' + el.text_en,
          text_bn: 'Section ' + el.text_bn
        })
      })
    },
    chapter (arr) {
      return arr.map(el => {
        return Object.assign({}, el, {
          text: 'Chapter ' + el.text,
          text_en: 'Chapter ' + el.text_en,
          text_bn: 'Chapter ' + el.text_bn
        })
      })
    },
    heading (arr) {
      return arr.map(el => {
        return Object.assign({}, el, {
          text: 'Heading ' + el.text,
          text_en: 'Heading ' + el.text_en,
          text_bn: 'Heading ' + el.text_bn
        })
      })
    },
    numberConvrtToBn (arr) {
      return arr.map(el => {
        return Object.assign({}, el, {
          text: el.text.toFixed(2),
          text_en: el.text_en.toFixed(2),
          text_bn: this.$n(el.text_bn.toFixed(2))
        })
      })
    }
  }
}
