import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import actions from './actions'
import mutations from './mutations'
import getters from './getters'
import Custom from './custom'
import Setting from './Setting/index'
import Auth from '../modules/auth-service/store'
import Portal from '../modules/portal/store'
import CommonService from '../modules/common-service/store'
import BazarMonitoringService from '../modules/bazar-monitoring-service/store'
import ExportTrophyCipService from '../modules/export-trophy-cip-service/store'
import ExternalUserService from '../modules/external-user-service/store'
import BftiResearchAndReportService from '../modules/bfti-research-and-report-service/store'
import TeaGardenService from '../modules/tea-garden-service/store'
import EBizManagementSystemService from '../modules/e-biz-management-system-service/store'
import LicenseRegistrationService from '../modules/license-registration-service/store'
import TradeFairService from '../modules/trade-fair-service/store'
import TradeTariffService from '../modules/trade-tariff-service/store'
import RjscService from '../modules/rjsc-service/store'
import RjscPortalService from '../modules/rjsc-portal/store'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    Setting,
    Auth,
    Portal,
    CommonService,
    BazarMonitoringService,
    ExportTrophyCipService,
    ExternalUserService,
    BftiResearchAndReportService,
    LicenseRegistrationService,
    TeaGardenService,
    EBizManagementSystemService,
    TradeFairService,
    TradeTariffService,
    RjscService,
    RjscPortalService
  },
  state: {
    list: [],
    notificationList: [],
    totalNotification: 0,
    isPushNotification: [],
    toggleNotification: false,
    currentFiscalYearId: 0,
    commonObj: {
      hasDropdownLoaded: false,
      perPage: 10,
      limit: 10,
      dateFormat: 'DD/MM/YYYY',
      fiscaleYear: 'YYYY-YYYY',
      timeFormat: 'h:m',
      unitOfTime: 'day',
      loading: false,
      listReload: false,
      maritalStatus: Custom.maritalStatus,
      genderList: Custom.genderList,
      activeIntactive: Custom.activeIntactive,
      pageOptions: Custom.pageOptions,
      typeList: Custom.cityTypeList,
      gradeList: Custom.gradeList,
      noticeForList: Custom.noticeForList,
      areaTypeList: Custom.areaTypeList,
      monthList: Custom.monthList,
      statusList: Custom.statusList,
      priceVariationList: Custom.priceVariationList,
      fifteenDayList: Custom.fifteenDayList,
      banglaMonthDays: Custom.banglaMonthDays,
      banglaMonthList: Custom.banglaMonthList,
      yearList: Custom.yearList,
      weekList: Custom.weekList,
      alphabetList: Custom.alphabetList
    },
    orgList: [],
    orgComponentList: []
  },
  actions,
  mutations,
  getters,
  plugins: [createPersistedState()]
})
