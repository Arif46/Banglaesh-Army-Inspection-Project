import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import Custom from './custom'
const state = {
  commonObj: {
    hasDropdownLoaded: false,
    masterFactoryTypeList: [],
    masterValleyList: [],
    masterMadeTeaTypeList: [],
    masterTeaCompanyList: [],
    masterBoughtLeafFactoryList: [],
    masterTeaGardenGenInfoList: [],
    masterTeaPlantClassificationList: [],
    feeTypesList: [],
    yearList: Custom.yearList,
    zoneList: Custom.zoneList,
    masterCloneNameList: [],
    masterCloneClassList: [],
    masterServiceWiseInstructionList: [],
    trustType: Custom.trustType,
    masterDesignationList: [],
    masterTrustTypeList: [],
    gardenType: Custom.gardenType,
    schoolCategory: Custom.schoolCategory,
    schoolStatus: Custom.schoolStatus,
    schoolLocation: Custom.schoolLocation,
    masterWorkerInformationList: [],
    gender: Custom.gender,
    workerType: Custom.workerType,
    seasonYearList: Custom.seasonYearList,
    masterPluckingTargetList: [],
    masterServiceList: [],
    masterTreeList: [],
    forestResource: Custom.forestResource,
    purposeTreeFelling: Custom.purposeTreeFelling,
    unitQuantity: Custom.unitQuantity,
    loggedService: [],
    factoryApplicationApplicantType: Custom.factoryApplicationApplicantType,
    masterServiceAssign: [],
    organicFertilizerTypes: Custom.organicFertilizerTypes,
    soilTestType: Custom.soilTestType,
    masterFertilizerList: [],
    masterMadeTeaGradeList: [],
    btriPaymentType: Custom.btriPaymentType,
    masterSectionList: [],
    teaSmapleTestType: Custom.teaSmapleTestType,
    masterDocumentSignatoryList: [],
    pduCourseList: [],
    pduCircularList: []
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
