import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedCommonService () {
      return this.$store.state.LicenseRegistrationService.commonObj.hasDropdownLoaded
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
          this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', {
            hasDropdownLoaded: true,
            itemCategoryList: response.data.itemCategoryList,
            recruitmentNoticesList: response.data.recruitmentNoticesList,
            itemList: response.data.itemList,
            contractNumberList: response.data.contractNumberList,
            warehouseList: response.data.warehouseList,
            feeNamesList: response.data.feeNamesList,
            serviceNamesList: response.data.serviceNamesList,
            stepNamesList: response.data.stepNamesList,
            serviceSteps: response.data.serviceSteps,
            dynamicFormList: response.data.dynamicFormList,
            serviceStepForm: response.data.serviceStepForm,
            dynamicButtonList: response.data.dynamicButtonList,
            challanList: response.data.challanList,
            autoGenNumTypeList: response.data.autoGenNumTypeList,
            seviceStepWiseButtonList: response.data.seviceStepWiseButtonList,
            menuInfoList: response.data.menuInfoList,
            reportMenuList: response.data.reportMenuList,
            reportProcess: response.data.reportProcess,
            orgNotesList: response.data.orgNotesList,
            noticeList: response.data.noticeList,
            taxOperatingExpensesList: response.data.taxOperatingExpensesList,
            operatingExpensesList: response.data.operatingExpensesList,
            stepFeeList: response.data.stepFeeList,
            userWarehouseList: response.data.userWarehouseList,
            dcOfficetaxList: response.data.dcOfficetaxList
          })
          this.$store.dispatch('LicenseRegistrationService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    }
  }
}
