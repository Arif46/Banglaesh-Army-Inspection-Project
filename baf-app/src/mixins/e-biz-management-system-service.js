import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedEBizManagementSystemService () {
      return this.$store.state.EBizManagementSystemService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedEBizManagementSystemService: function (newValue) {
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
          this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', {
            hasDropdownLoaded: true,
            councilInfoList: response.data.councilInfoList,
            associationInfoList: response.data.associationInfoList,
            proposalTypeList: response.data.proposalTypeList,
            productInfoList: response.data.productInfoList,
            typeOfBusinessList: response.data.typeOfBusinessList,
            projectNameList: response.data.projectNameList,
            associationProfileList: response.data.associationProfileList
          })
          this.$store.dispatch('EBizManagementSystemService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
