import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.hasDropdownLoaded
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
      RestApi.getData(licenseRegistrationServiceBaseUrl, 'dealer-panel/common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateCommonObjDealerPanel', {
            hasDropdownLoaded: true,
            serviceNamesList: response.data.serviceNamesList,
            stepNamesList: response.data.stepNamesList,
            recruitmentNoticesList: response.data.recruitmentNoticesList,
            warehouseList: response.data.warehouseList
          })
          this.$store.dispatch('ExternalUserService/localizeDropdownDealerPanel', { value: this.$i18n.locale })
        }
      })
    }
  }
}
