export const mutations = {
  mutateCommonObj (state, payload) {
    state.commonObj = Object.assign({}, state.commonObj, payload)
  },
  localizeDropdown (state, payload) {
    state.commonObj.masterFactoryTypeList = state.commonObj.masterFactoryTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterValleyList = state.commonObj.masterValleyList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterTeaCompanyList = state.commonObj.masterTeaCompanyList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterMadeTeaTypeList = state.commonObj.masterMadeTeaTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterBoughtLeafFactoryList = state.commonObj.masterBoughtLeafFactoryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterTeaGardenGenInfoList = state.commonObj.masterTeaGardenGenInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterTeaPlantClassificationList = state.commonObj.masterTeaPlantClassificationList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.feeTypesList = state.commonObj.feeTypesList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterCloneNameList = state.commonObj.masterCloneNameList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterCloneClassList = state.commonObj.masterCloneClassList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterServiceWiseInstructionList = state.commonObj.masterServiceWiseInstructionList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    // state.commonObj.yearList = state.commonObj.yearList.map(item => {
    //   const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
    //   return Object.assign({}, item, tmp)
    // })
    state.commonObj.zoneList = state.commonObj.zoneList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
      state.commonObj.masterDesignationList = state.commonObj.masterDesignationList.map(item => {
        const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
        return Object.assign({}, item, tmp)
      })
    state.commonObj.trustType = state.commonObj.trustType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterTrustTypeList = state.commonObj.masterTrustTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.gardenType = state.commonObj.gardenType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
        state.commonObj.workerType = state.commonObj.workerType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.gender = state.commonObj.gender.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterWorkerInformationList = state.commonObj.masterWorkerInformationList.map(item => {
         const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.schoolCategory = state.commonObj.schoolCategory.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.schoolLocation = state.commonObj.schoolLocation.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.schoolStatus = state.commonObj.schoolStatus.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterServiceList = state.commonObj.masterServiceList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterPluckingTargetList = state.commonObj.masterPluckingTargetList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.forestResource = state.commonObj.forestResource.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.purposeTreeFelling = state.commonObj.purposeTreeFelling.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.unitQuantity = state.commonObj.unitQuantity.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.organicFertilizerTypes = state.commonObj.organicFertilizerTypes.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.soilTestType = state.commonObj.soilTestType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterTreeList = state.commonObj.masterTreeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.factoryApplicationApplicantType = state.commonObj.factoryApplicationApplicantType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterServiceAssign = state.commonObj.masterServiceAssign.map(item => {
      const tmp = payload.value === 'en' ? { text: item.name_en } : { text: item.name_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterFertilizerList = state.commonObj.masterFertilizerList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterMadeTeaGradeList = state.commonObj.masterMadeTeaGradeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.btriPaymentType = state.commonObj.btriPaymentType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterSectionList = state.commonObj.masterSectionList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.teaSmapleTestType = state.commonObj.teaSmapleTestType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.masterDocumentSignatoryList = state.commonObj.masterDocumentSignatoryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.name_en } : { text: item.name_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.pduCourseList = state.commonObj.pduCourseList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.pduCircularList = state.commonObj.pduCircularList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  }
}
