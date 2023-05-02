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
      RestApi.getData(licenseRegistrationServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('ExternalUserService/mutateCommonObjDealerPanel', {
            hasDropdownLoaded: true,
            feeNamesList: response.data.feeNamesList,
            serviceNamesList: response.data.serviceNamesList,
            stepNamesList: response.data.stepNamesList,
            menuWiseStepList: response.data.menuWiseStepList,
            dynamicFormList: response.data.dynamicFormList,
            serviceSteps: response.data.serviceSteps,
            serviceStepForm: response.data.serviceStepForm,
            dynamicButtonList: response.data.dynamicButtonList,
            stepFeeList: response.data.stepFeeList,
            seviceStepWiseButtonList: response.data.seviceStepWiseButtonList,
            menuInfoList: response.data.menuInfoList,
            reportMenuList: response.data.reportMenuList,
            autoGenNumTypeList: response.data.autoGenNumTypeList,
            preconditionList: response.data.preconditionList,
            fieldAssignList: response.data.fieldAssignList,
            itemCategoryList: response.data.itemCategoryList,
            recruitmentNoticesList: response.data.recruitmentNoticesList,
            itemList: response.data.itemList,
            contractNumberList: response.data.contractNumberList
          })
          this.$store.dispatch('ExternalUserService/localizeDropdownDealerPanel', { value: this.$i18n.locale })
        }
      })
    }
  }
}
