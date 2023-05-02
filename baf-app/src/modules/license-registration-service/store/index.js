import actions from './actions'
import getters from './getters'
import Custom from './custom'
import { mutations } from './mutations'

const state = {
  commonObj: {
    laodList: false,
    hasDropdownLoaded: false,
    perPage: 10,
    dateFormat: 'dd/mm/YYYY',
    timeFormat: 'h:m',
    loading: false,
    listReload: false,
    itemCategoryList: [],
    itemList: [],
    contractNumberList: [],
    warehouseList: [],
    feeNamesList: [],
    serviceNamesList: [],
    stepNamesList: [],
    serviceSteps: [],
    dynamicFormList: [],
    recruitmentNoticesList: [],
    serviceStepForm: [],
    dynamicButtonList: [],
    seviceStepWiseButtonList: [],
    menuInfoList: [],
    alignmentList: Custom.alignmentList,
    autoGenNumTypeList: [],
    reportMenuList: [],
    reportProcess: [],
    sellerTypeList: Custom.sellerTypeList,
    distanceList: Custom.distanceList,
    inputOptionList: Custom.inputOptionList,
    languageTypeList: Custom.tmpLanguageTypeList,
    operatorList: Custom.operatorList,
    applicationTypeList: Custom.applicationTypeList,
    tcbStepList: Custom.tcbStepList,
    maritalStatusList: Custom.maritalStatusList,
    paymentTypeList: Custom.paymentTypeList,
    adminPaymentTypeList: Custom.adminPaymentTypeList,
    actionTypeList: Custom.actionTypeList,
    orgNotesList: [],
    noticeList: [],
    operatingExpensesList: [],
    taxOperatingExpensesList: [],
    stepFeeList: [],
    userWarehouseList: [],
    dcOfficetaxList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations,
  Custom
}
