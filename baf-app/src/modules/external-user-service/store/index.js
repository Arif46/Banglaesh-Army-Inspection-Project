import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'
import custom from './custom'

const state = {
  isInsidePanel: false,
  externalPanels: [],
  externalMenus: [],
  cipPanel: {
    commonObj: {
      hasDropdownLoaded: false,
      // circularList: [],
      exportSectorList: [],
      venueList: [],
      circular: null
    },
    cipAppTypeList: custom.cipAppTypeList,
    latentExporterList: custom.latentExporterList,
    orgTypeList: custom.orgTypeList,
    merchandisingTypeList: custom.merchandisingTypeList
  },
  bftiPanel: {
    commonObj: {
      hasDropdownLoaded: false,
      documentTypeList: [],
      researchRequestList: [],
      surveyList: []
    }
  },
  eBizPanel: {
    associationProfile: {},
    commonObj: {
      hasDropdownLoaded: false,
      councilInfoList: [],
      associationInfoList: [],
      proposalTypeList: [],
      productInfoList: [],
      typeOfBusinessList: [],
      projectNameList: []
    }
  },
  dealerPanel: {
    commonObj: {
      hasDropdownLoaded: false,
      paymentTypeList: custom.paymentTypeList,
      sellerTypeList: custom.sellerTypeList,
      applicationTypeList: custom.applicationTypeList,
      tcbStepList: custom.tcbStepList,
      maritalStatusList: custom.maritalStatusList,
      actionTypeList: custom.actionTypeList,
      serviceNamesList: [],
      stepNamesList: [],
      recruitmentNoticesList: [],
      warehouseList: []
    }
  },
  teaGarden: {
    commonObj: {
      hasDropdownLoaded: false,
      feeTypesList: [],
      masterTreeList: [],
      masterFactoryTypeList: [],
      masterMadeTeaTypeList: [],
      factoryApplicationApplicantType: custom.factoryApplicationApplicantType,
      masterTeaGardenGenInfoList: [],
      pduCourseList: []
    }
  },
  tradeFair: {
    commonObj: {
      hasDropdownLoaded: false,
      fairSectorList: [],
      fairNameList: [],
      subsidyCategoryList: [],
      measurementUnitList: [],
      noteList: []
    }
  },
  tradeTariff: {
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
      portTypeList: custom.portTypeList,
      productTypeList: custom.productTypeList
    }
  }
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
