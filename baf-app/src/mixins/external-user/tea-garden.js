import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.ExternalUserService.teaGarden.commonObj.hasDropdownLoaded
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
      RestApi.getData(teaGardenServiceBaseUrl, 'tea-garden-panel-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateTeaGardenPanelCommonObj', {
            hasDropdownLoaded: true,
            feeTypesList: response.data.feeTypesList,
            masterTreeList: response.data.masterTreeList,
            masterFactoryTypeList: response.data.masterFactoryTypeList,
            masterMadeTeaTypeList: response.data.masterMadeTeaTypeList,
            masterTeaGardenGenInfoList: response.data.masterTeaGardenGenInfoList,
            pduCourseList: response.data.pduCourseList
          })
          this.$store.dispatch('ExternalUserService/localizeTeaGardenPanelDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
