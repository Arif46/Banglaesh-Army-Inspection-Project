import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.ExternalUserService.cipPanel.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedCommonService: function (newValue) {
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
      RestApi.getData(exportTrophyCIPServiceBaseUrl, 'cip-panel-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateCipPanelCommonObj', {
            hasDropdownLoaded: true,
            exportSectorList: response.data.exportSectorList,
            circularList: response.data.circularList,
            venueList: response.data.venueList
          })
          this.$store.dispatch('ExternalUserService/localizeCipPanelDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
