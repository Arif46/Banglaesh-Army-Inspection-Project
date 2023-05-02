import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import Custom from './custom'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    fairSectorList: [],
    committeeNameList: [],
    committeeRollList: [],
    committeeTypeList: Custom.committeeTypeList,
    stallTypeList: Custom.stallTypeList,
    typeOfFair: Custom.typeOfFair,
    paymentStatusList: Custom.paymentStatusList,
    calendarCircularList: [],
    subsidyCategoryList: [],
    fairNameList: [],
    measurementUnitList: [],
    companyTypeList: Custom.companyTypeList,
    companyNatureList: Custom.companyNatureList,
    noteList: []
  },
  ditfCommonObj: {
    circularTypeList: Custom.circularTypeList,
    countryTypeList: Custom.countryTypeList,
    stallTypeList: Custom.ditfStallTypeList,
    priceTypeList: Custom.priceTypeList,
    businessTypeList: [],
    dhakaFairList: [],
    stallCategoryList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
