import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedExportTrophyCipService () {
      return this.$store.state.ExportTrophyCipService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedExportTrophyCipService: function (newValue) {
      if (!newValue) {
        this.loadExportTrophyDropdown()
      }
    }
  },
  created () {
    this.loadExportTrophyDropdown()
  },
  methods: {
    loadExportTrophyDropdown () {
      RestApi.getData(exportTrophyCIPServiceBaseUrl, 'export-trophy-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExportTrophyCipService/mutateCommonObj', {
            hasDropdownLoaded: true,
            exportSectorList: response.data.exportSectorList,
            cipSectorList: response.data.cipSectorList,
            venueList: response.data.venueList,
            assignIncomeList: response.data.assignIncomeList,
            invitationCardList: response.data.invitationCardList,
            eventList: response.data.eventList
          })
          this.$store.dispatch('ExportTrophyCipService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
