import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.ExternalUserService.eBizPanel.commonObj.hasDropdownLoaded
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
      RestApi.getData(eBizServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateCommonObjeBizPanel', {
            hasDropdownLoaded: true,
            councilInfoList: response.data.councilInfoList,
            associationInfoList: response.data.associationInfoList,
            proposalTypeList: response.data.proposalTypeList,
            productInfoList: response.data.productInfoList,
            typeOfBusinessList: response.data.typeOfBusinessList,
            projectNameList: response.data.projectNameList
          })
          this.$store.dispatch('ExternalUserService/localizeDropdowneBizPanel', { value: this.$i18n.locale })
        }
      })
    }
  }
}
