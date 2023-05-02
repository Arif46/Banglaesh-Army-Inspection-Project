export const mutations = {
  mutateCommonObj (state, payload) {
    state.commonObj = Object.assign({}, state.commonObj, payload)
  },
  localizeDropdown (state, payload) {
    state.commonObj.itemCategoryList = state.commonObj.itemCategoryList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.itemList = state.commonObj.itemList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.contractNumberList = state.commonObj.contractNumberList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.warehouseList = state.commonObj.warehouseList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    // state.commonObj.documentTypeList = state.commonObj.documentTypeList.map(item => {
    //   const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
    //   return Object.assign({}, item, tmp)
    // })
  }
}
