import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedTradeService () {
      return this.$store.state.ExternalUserService.tradeFair.commonObj.hasDropdownLoaded
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
      RestApi.getData(internationalTradeFairServiceBaseUrl, 'trade-fair-external-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateTradeFairPanelCommonObj', {
            hasDropdownLoaded: true,
            fairSectorList: response.data.fairSectorList,
            fairNameList: response.data.fairNameList,
            subsidyCategoryList: response.data.subsidyCategoryList,
            measurementUnitList: response.data.measurementUnitList,
            noteList: response.data.noteList
          })
          this.$store.dispatch('ExternalUserService/localizeTradeFairPanelDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
