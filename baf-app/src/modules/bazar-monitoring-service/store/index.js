import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import Custom from './custom'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    priceCategoryList: [],
    commodityGroupList: [],
    commodityNameList: [],
    lawEntryList: [],
    marketDirectoryList: [],
    unitList: [],
    inspectByList: Custom.inspectByList,
    frequencyTypeList: Custom.frequencyTypeList,
    frequencyTypeList2: Custom.frequencyTypeList2,
    sectionList: [],
    alertList: [],
    addressCustomUser: [],
    loggedUserPrivilege: {}
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
