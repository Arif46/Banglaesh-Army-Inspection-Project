import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import Custom from './custom'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    tradeTariffCountryList: [],
    applicationTypeList: [],
    capitalInfoList: [],
    currencyList: [],
    productList: [],
    unitMeasurementList: [],
    sectionNoList: [],
    chapterNoList: [],
    headingList: [],
    subHeadingList: [],
    portTypeList: Custom.portTypeList,
    productTypeList: Custom.productTypeList
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
