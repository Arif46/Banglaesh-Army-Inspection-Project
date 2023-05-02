import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedTradeFairService () {
      return this.$store.state.TradeFairService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedTradeFairService: function (newValue) {
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
      RestApi.getData(internationalTradeFairServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          // ITF
          this.$store.dispatch('TradeFairService/mutateCommonObj', {
            hasDropdownLoaded: true,
            fairSectorList: response.data.fairSectorList,
            committeeNameList: response.data.committeeNameList,
            committeeRollList: response.data.committeeRollList,
            calendarCircularList: response.data.calendarCircularList,
            subsidyCategoryList: response.data.subsidyCategoryList,
            fairNameList: response.data.fairNameList,
            measurementUnitList: response.data.measurementUnitList,
            noteList: response.data.noteList
          })
          // DIFT
          this.$store.dispatch('TradeFairService/mutateDitfCommonObj', {
            hasDropdownLoaded: true,
            dhakaFairList: response.data.dhakaFairList,
            businessTypeList: response.data.businessTypeList,
            stallCategoryList: response.data.stallCategoryList
          })
          this.$store.dispatch('TradeFairService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
