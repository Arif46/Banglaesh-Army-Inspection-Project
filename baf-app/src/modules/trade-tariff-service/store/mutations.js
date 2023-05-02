export const mutations = {
  mutateCommonObj (state, payload) {
    state.commonObj = Object.assign({}, state.commonObj, payload)
  },
  localizeDropdown (state, payload) {
    state.commonObj.tradeTariffCountryList = state.commonObj.tradeTariffCountryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.applicationTypeList = state.commonObj.applicationTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.capitalInfoList = state.commonObj.capitalInfoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.portTypeList = state.commonObj.portTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.currencyList = state.commonObj.currencyList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.productTypeList = state.commonObj.productTypeList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.productList = state.commonObj.productList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.unitMeasurementList = state.commonObj.unitMeasurementList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.chapterNoList = state.commonObj.chapterNoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.sectionNoList = state.commonObj.sectionNoList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.headingList = state.commonObj.headingList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.subHeadingList = state.commonObj.subHeadingList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  }
}
