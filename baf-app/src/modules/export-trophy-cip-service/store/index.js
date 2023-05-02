import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import Custom from './custom'

const state = {
  commonObj: {
    hasDropdownLoaded: false,
    pendingForward: false,
    exportSectorList: [],
    venueList: [],
    assignIncomeList: [],
    invitationCardList: [],
    eventList: [],
    productServiceTypeList: Custom.productServiceTypeList,
    assignTypeList: Custom.assignTypeList,
    cipSectorList: Custom.cipSectorList,
    applicationTypeList: Custom.applicationTypeList,
    cipAppTypeList: Custom.cipAppTypeList,
    latentExporterList: Custom.latentExporterList,
    orgTypeList: Custom.orgTypeList,
    merchandisingTypeList: Custom.merchandisingTypeList
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
