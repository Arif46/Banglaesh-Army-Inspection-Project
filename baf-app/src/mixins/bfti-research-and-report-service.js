import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedBftiService () {
      return this.$store.state.BftiResearchAndReportService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedBftiService: function (newValue) {
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
      RestApi.getData(bftiResReportServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', {
            hasDropdownLoaded: true,
            documentTypeList: response.data.documentTypeList,
            areaOfInterestList: response.data.areaOfInterestList,
            organizationTypeList: response.data.organizationTypeList,
            organizationSubTypeList: response.data.organizationSubTypeList,
            organizationNameList: response.data.organizationNameList,
            stakeholderList: response.data.stakeholderList,
            expenditureHeadList: response.data.expenditureHeadList,
            programTypeList: response.data.programTypeList,
            budgetInstallmentList: response.data.budgetInstallmentList,
            taskHeadingList: response.data.taskHeadingList,
            taskSubHeadingList: response.data.taskSubHeadingList,
            researchRequestList: response.data.researchRequestList,
            eoiList: response.data.eoiList,
            surveyList: response.data.surveyList,
            holidayList: response.data.holidayList,
            taskAlertList: response.data.taskAlertList
          })
          this.$store.dispatch('BftiResearchAndReportService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
