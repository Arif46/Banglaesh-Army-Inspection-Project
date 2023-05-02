import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'

const state = {
  loading: false,
  header: {},
  serviceData: {
    orgList: [],
    serviceCategoryList: [],
    serviceCustomerTypeList: [],
    serviceList: [],
    total_services: 0
  },
  serviceList: [],
  searchData: {
    loading: false,
    org_id: 0,
    customer_type_id: 0,
    service_category_id: 0
  },
  customerTypeList: [],
  categoryList: [],
  orgList: [],
  faqList: [],
  newsList: [],
  noticeList: [],
  serviceUrl: {
    externalPanelServiceUrl: '',
    externalPanelCurrentServiceUrl: '',
    subsidyId: 0
  },
  // don't change the above state
  /** Portal Common Dropdown State */
  commonObj: {
    fiscalYearList: [],
    orgProfileList: [],
    designationList: [],
    countryList: []
  }
  // Trade fair portal dropdown (currently Not Used)
  // tradeFair: {
  //   commonObj: {
  //     hasDropdownLoaded: false,
  //     fairSectorList: [],
  //     subsidyCategoryList: []
  //   }
  // }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
