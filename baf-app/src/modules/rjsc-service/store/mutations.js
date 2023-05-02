export const mutations = {
  mutateCommonObj (state, payload) {
    state.commonObj = Object.assign({}, state.commonObj, payload)
  },
  checkRjscPortalProfilePage (state, payload) {
    state.isProfilePage = payload
  },
  localizeDropdown (state, payload) {
    state.commonObj.menuList = state.commonObj.menuList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.divisionList = state.commonObj.divisionList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.subSubMenuList = state.commonObj.subSubMenuList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    // state.commonObj.noticeList = state.commonObj.noticeList.map(item => {
    //   const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
    //   return Object.assign({}, item, tmp)
    // })
    state.commonObj.districtList = state.commonObj.districtList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })

    state.commonObj.businessTypeList = state.commonObj.businessTypeList.map(item => {
    const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
    return Object.assign({}, item, tmp)
    })
  }
}
