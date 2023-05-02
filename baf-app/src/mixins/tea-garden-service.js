import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'

export default {
  computed: {
    hasDropdownLoadedTeaGardenService () {
      return this.$store.state.TeaGardenService.commonObj.hasDropdownLoaded
    }
  },
  watch: {
    hasDropdownLoadedTeaGardenService: function (newValue) {
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
      RestApi.getData(teaGardenServiceBaseUrl, 'common-dropdowns', null).then(response => {
        if (response.success) {
          this.$store.dispatch('TeaGardenService/mutateCommonObj', {
            hasDropdownLoaded: true,
            masterValleyList: response.data.masterValleyList,
            masterFactoryTypeList: response.data.masterFactoryTypeList,
            masterMadeTeaTypeList: response.data.masterMadeTeaTypeList,
            masterTeaCompanyList: response.data.masterTeaCompanyList,
            masterBoughtLeafFactoryList: response.data.masterBoughtLeafFactoryList,
            masterTeaGardenGenInfoList: response.data.masterTeaGardenGenInfoList,
            masterTeaPlantClassificationList: response.data.masterTeaPlantClassificationList,
            feeTypesList: response.data.feeTypesList,
            masterCloneNameList: response.data.masterCloneNameList,
            masterCloneClassList: response.data.masterCloneClassList,
            masterServiceWiseInstructionList: response.data.masterServiceWiseInstructionList,
            masterDesignationList: response.data.masterDesignationList,
            masterTrustTypeList: response.data.masterTrustTypeList,
            masterWorkerInformationList: response.data.masterWorkerInformationList,
            masterPluckingTargetList: response.data.masterPluckingTargetList,
            masterServiceList: response.data.masterServiceList,
            loggedService: response.data.loggedService,
            masterTreeList: response.data.masterTreeList,
            masterServiceAssign: response.data.masterServiceAssign,
            masterFertilizerList: response.data.masterFertilizerList,
            masterMadeTeaGradeList: response.data.masterMadeTeaGradeList,
            masterSectionList: response.data.masterSectionList,
            masterDocumentSignatoryList: response.data.masterDocumentSignatoryList,
            pduCourseList: response.data.pduCourseList,
            pduCircularList: response.data.pduCircularList
          })
          this.$store.dispatch('TeaGardenService/localizeDropdown', { value: this.$i18n.locale })
        }
      })
    },
    // check tea garden admin & return garden id
    isGardenAdminCheckGardenId () {
      if (this.$store.state.Auth.authUser.office_detail && this.$store.state.Auth.authUser.office_detail.office_id !== null) {
          const officeId = this.$store.state.Auth.authUser.office_detail.office_id
          const gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.office_id === officeId)
          if (gardenInfo !== undefined) {
              return gardenInfo.value
          } else { return 0 }
      }
    }
  }
}
