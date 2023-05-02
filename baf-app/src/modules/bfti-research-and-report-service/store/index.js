import actions from './actions'
import getters from './getters'
// import Custom from './custom'
import { mutations } from './mutations'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    documentTypeList: [],
    areaOfInterestList: [],
    organizationTypeList: [],
    organizationNameList: [],
    organizationSubTypeList: [],
    stakeholderList: [],
    expenditureHeadList: [],
    programTypeList: [],
    budgetInstallmentList: [],
    taskHeadingList: [],
    taskSubHeadingList: [],
    researchRequestList: [],
    eoiList: [],
    surveyList: [],
    holidayList: [],
    taskAlertList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
