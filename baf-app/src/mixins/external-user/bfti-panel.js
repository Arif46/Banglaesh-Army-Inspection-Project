import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.ExternalUserService.bftiPanel.commonObj.hasDropdownLoaded
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
      RestApi.getData(bftiResReportServiceBaseUrl, 'external-common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateCommonObjBftiPanel', {
            hasDropdownLoaded: true,
            documentTypeList: response.data.documentTypeList,
            researchRequestList: response.data.researchRequestList,
            surveyList: response.data.surveyList
          })
          this.$store.dispatch('ExternalUserService/localizeDropdownBftiPanel', { value: this.$i18n.locale })
        }
      })
    }
  }
}
