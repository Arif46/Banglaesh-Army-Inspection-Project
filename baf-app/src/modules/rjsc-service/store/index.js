import actions from './actions'
import getters from './getters'
import custom from './custom'
import { mutations } from './mutations'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    isProfilePage: false,
    pageTypeList: custom.pageTypeList,
    menuList: [],
    subMenuList: [],
    subSubMenuList: [],
    noticeList: [],
    newsList: [],
    businessTypeList: [],
    entityTypeList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
