import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    councilInfoList: [],
    associationInfoList: [],
    associationProfileList: [],
    proposalTypeList: [],
    productInfoList: [],
    programTypeList: [],
    typeOfBusinessList: [],
    projectNameList: [],
    sliderList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
