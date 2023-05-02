export const mutations = {
  // CIP panel mutations start
  mutateCipPanelCommonObj (state, payload) {
    state.cipPanel.commonObj = Object.assign({}, state.cipPanel.commonObj, payload)
  },
  mutateCommonObjDealerPanel (state, payload) {
    state.dealerPanel.commonObj = Object.assign({}, state.dealerPanel.commonObj, payload)
  },
  mutateCommonObjeBizPanel (state, payload) {
    state.eBizPanel.commonObj = Object.assign({}, state.eBizPanel.commonObj, payload)
  },
  mutateCommonObjBftiPanel (state, payload) {
    state.bftiPanel.commonObj = Object.assign({}, state.bftiPanel.commonObj, payload)
  },
  mutateTeaGardenPanelCommonObj (state, payload) {
    state.teaGarden.commonObj = Object.assign({}, state.teaGarden.commonObj, payload)
  },
  addCurrentCircular (state, payload) {
    state.cipPanel.commonObj.circular = payload
  },
  localizeCipPanelDropdown (state, payload) {
    // state.cipPanel.commonObj.circularList = state.cipPanel.commonObj.circularList.map(item => {
    //     const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
    //     return Object.assign({}, item, tmp)
    // })
    state.cipPanel.commonObj.exportSectorList = state.cipPanel.commonObj.exportSectorList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.cipPanel.commonObj.venueList = state.cipPanel.commonObj.venueList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  // CIP panel mutations end
  setExternalMenus (state, payload) {
    state.externalMenus = payload
  },
  setExternalPanels (state, payload) {
    state.externalPanels = payload
  },
  isInsidePanel (state, payload) {
    state.isInsidePanel = payload
  },
  // set external association profile
  setAssociationProfile (state, payload) {
    state.eBizPanel.associationProfile = payload
  },
  localizeDropdownDealerPanel (state, payload) {
    state.dealerPanel.commonObj.recruitmentNoticesList = state.dealerPanel.commonObj.recruitmentNoticesList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.dealerPanel.commonObj.stepNamesList = state.dealerPanel.commonObj.stepNamesList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.dealerPanel.commonObj.serviceNamesList = state.dealerPanel.commonObj.serviceNamesList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.dealerPanel.commonObj.warehouseList = state.dealerPanel.commonObj.warehouseList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  localizeDropdownBftiPanel (state, payload) {
    state.bftiPanel.commonObj.documentTypeList = state.bftiPanel.commonObj.documentTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.bftiPanel.commonObj.researchRequestList = state.bftiPanel.commonObj.researchRequestList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.bftiPanel.commonObj.surveyList = state.bftiPanel.commonObj.surveyList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  localizeDropdowneBizPanel (state, payload) {
    state.eBizPanel.commonObj.councilInfoList = state.eBizPanel.commonObj.councilInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.eBizPanel.commonObj.associationInfoList = state.eBizPanel.commonObj.associationInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.eBizPanel.commonObj.proposalTypeList = state.eBizPanel.commonObj.proposalTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.eBizPanel.commonObj.productInfoList = state.eBizPanel.commonObj.productInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.eBizPanel.commonObj.typeOfBusinessList = state.eBizPanel.commonObj.typeOfBusinessList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.eBizPanel.commonObj.projectNameList = state.eBizPanel.commonObj.projectNameList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  localizeTeaGardenPanelDropdown (state, payload) {
    state.teaGarden.commonObj.feeTypesList = state.teaGarden.commonObj.feeTypesList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.masterMadeTeaTypeList = state.teaGarden.commonObj.masterMadeTeaTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.masterFactoryTypeList = state.teaGarden.commonObj.masterFactoryTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.masterTreeList = state.teaGarden.commonObj.masterTreeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.factoryApplicationApplicantType = state.teaGarden.commonObj.factoryApplicationApplicantType.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.masterTeaGardenGenInfoList = state.teaGarden.commonObj.masterTeaGardenGenInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.teaGarden.commonObj.pduCourseList = state.teaGarden.commonObj.pduCourseList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  // International Trade Fair
  mutateTradeFairPanelCommonObj (state, payload) {
    state.tradeFair.commonObj = Object.assign({}, state.tradeFair.commonObj, payload)
  },
  localizeTradeFairPanelDropdown (state, payload) {
    state.tradeFair.commonObj.fairSectorList = state.tradeFair.commonObj.fairSectorList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeFair.commonObj.fairNameList = state.tradeFair.commonObj.fairNameList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeFair.commonObj.subsidyCategoryList = state.tradeFair.commonObj.subsidyCategoryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeFair.commonObj.measurementUnitList = state.tradeFair.commonObj.measurementUnitList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeFair.commonObj.noteList = state.tradeFair.commonObj.noteList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  // Trade and Tariff Mutations
  mutateTradeTariffPanelCommonObj (state, payload) {
    state.tradeTariff.commonObj = Object.assign({}, state.tradeTariff.commonObj, payload)
  },
  localizeTradeTariffPanelDropdown (state, payload) {
    state.tradeTariff.commonObj.tradeTariffCountryList = state.tradeTariff.commonObj.tradeTariffCountryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.applicationTypeList = state.tradeTariff.commonObj.applicationTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.capitalInfoList = state.tradeTariff.commonObj.capitalInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.portTypeList = state.tradeTariff.commonObj.portTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.currencyList = state.tradeTariff.commonObj.currencyList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.productTypeList = state.tradeTariff.commonObj.productTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.productList = state.tradeTariff.commonObj.productList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.unitMeasurementList = state.tradeTariff.commonObj.unitMeasurementList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.chapterNoList = state.tradeTariff.commonObj.chapterNoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.sectionNoList = state.tradeTariff.commonObj.sectionNoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.tradeTariff.commonObj.headingList = state.tradeTariff.commonObj.headingList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  }
}
