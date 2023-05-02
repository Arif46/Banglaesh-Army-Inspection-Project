import Vue from 'vue'
import VueRouter from 'vue-router'
import Store from '../store'
import PortalRoutes from '../modules/portal/routes'
import RjscPortalRoutes from '../modules/rjsc-portal/routes'
import DesginerServiceRoute from '../modules/designer-service/configuration/routes'
import AuthServiceAuthRoute from '../modules/auth-service/auth/routes'
import CommonServiceMenuRoute from '../modules/common-service/menu/routes'
import CommonServiceOrgProfileRoute from '../modules/common-service/org-profile/routes'
import CommonServiceOrganogramRoute from '../modules/common-service/organogram/routes'
import CommonServiceNotificationRoute from '../modules/common-service/notification-management/routes'
import CommonServicePortalRoute from '../modules/common-service/portal/routes'
import CommonServiceDocumentManagementRoute from '../modules/common-service/document-management/routes'
import CommonServiceAccessControlRoute from '../modules/common-service/access-control/routes'
import AuthServiceUserManagementRoute from '../modules/auth-service/user-management/routes'
import CommonServiceComplainManagementRoute from '../modules/common-service/complain-management/routes'
import CommonServiceInformationServiceManagementLocales from '../modules/common-service/information-service-management/routes'
import CommonServiceCommitteeRoute from '../modules/common-service/committee/routes'
import ExportTropohyCIPCircularRoute from '../modules/export-trophy-cip-service/circular/routes'
import CipEtExportTrophyRoute from '../modules/export-trophy-cip-service/export-trophy/routes'
import CipEtCIPRoute from '../modules/export-trophy-cip-service/cip/routes'
import ExportTropohyCIPEventManageRoute from '../modules/export-trophy-cip-service/event-management/routes'
import ExportTrophyReportRoute from '../modules/export-trophy-cip-service/report/routes'
import ExternalUserRoute from '../modules/external-user-service/routes'
import ExportTropohyGazetteRoute from '../modules/export-trophy-cip-service/gazette/routes'
// ui-elements for demo
import uiElementRoutes from '../views/routes'

// Bazar Monitoring Service Routes Start
import BazarMonitoringServiceConfigurationRoute from '../modules/bazar-monitoring-service/configuration/routes'
import BazarMonitoringServicePriceMonitoringRoute from '../modules/bazar-monitoring-service/commodity-price-market-monitoring/routes'
import BazarMonitoringServiceReportRoute from '../modules/bazar-monitoring-service/reports/routes'
// Bazar Monitoring Service Routes End

// Tea Garden Service Routes Start
import TeaGardenApprovalProcessRoute from '../modules/tea-garden-service/approval-process/routes'
import TeaGardenRoute from '../modules/tea-garden-service/configuration/routes'
import TeaGardenServiceBTBRoute from '../modules/tea-garden-service/btb/routes'
import TeaGardenServiceBTRIRoute from '../modules/tea-garden-service/btri/routes'
import TeaGardenServicePDURoute from '../modules/tea-garden-service/pdu/routes'
import TeaGardenServiceDashboardRoute from '../modules/tea-garden-service/dashboard/routes'
// Tea Garden Service Routes End

// e-biz-management-system-service Routes Start
import EBizManagementSystemConfigRoute from '../modules/e-biz-management-system-service/configuration/routes'
import EBizManagementSystemAssociationManagementRoute from '../modules/e-biz-management-system-service/association-management/routes'
import EBizManagementSystemProposalManagementRoute from '../modules/e-biz-management-system-service/proposal-management/routes'
import EBizManagementSystemPromotionalManagementRoute from '../modules/e-biz-management-system-service/promotional-management/routes'
import EBizManagementSystemProgramManagementRoute from '../modules/e-biz-management-system-service/program-management/routes'
import EBizManagementSystemPolicyAdvocacyRoute from '../modules/e-biz-management-system-service/policy-advocacy-management/routes'
import EBizManagementSystemInformationTrainingRoute from '../modules/e-biz-management-system-service/information-training-management/routes'
import EBizManagementSystemDashboardRoute from '../modules/e-biz-management-system-service/dashboard/routes'
import EBizManagementSystemReportsRoute from '../modules/e-biz-management-system-service/e-biz-reports/routes'
// e-biz-management-system-service Routes End

// Export Trophy Cip Service Routes Start
import ExportTrophyCipServiceConfigRoute from '../modules/export-trophy-cip-service/configuration/routes'
// Export Trophy Cip Service Routes End

// License Registration Service Routes List
import LicenseregistrationServiceConfigurationRoute from '../modules/license-registration-service/configuration/routes'
import LicenseregistrationServiceLicenseManagementRoute from '../modules/license-registration-service/license-management/routes'
import LicenseregistrationServiceTcbReportRoute from '../modules/license-registration-service/tcb-report/routes'
import LicenseregistrationServiceDealerManagementRoute from '../modules/license-registration-service/dealer-management/routes'
import LicenseregistrationServiceManageInformationRoute from '../modules/license-registration-service/manage-information/routes'
import LicenseregistrationServiceAllocationManagementRoute from '../modules/license-registration-service/allocation-management/routes'
import LicenseregistrationServiceAllocationManagementDcOfficeRoute from '../modules/license-registration-service/allocation-management-dc-office/routes'
import licenseRegistrationServiceStepRoute from '../modules/license-registration-service/license-step/routes'

// BFTI ResReportService Routes List
import BftiResReportServiceBaseUrlConfigurationRoute from '../modules/bfti-research-and-report-service/configuration/routes'
import BftiResReportServiceMeetingManagementRoute from '../modules/bfti-research-and-report-service/meeting-management/routes'

import BftiResearchAndProposalRoute from '../modules/bfti-research-and-report-service/research-request-and-proposal-management/routes'
import BftiResearchPlanRoute from '../modules/bfti-research-and-report-service/research-plan-preparation/routes'
import BftiPolicyAdvocacyManagementSystemRoute from '../modules/bfti-research-and-report-service/policy-advocacy-management-system/routes'
import BftiResearchExecutionManagementSystemRoute from '../modules/bfti-research-and-report-service/research-execution-management/routes'
import BftiSystemConfigurationActivityManagementRoute from '../modules/bfti-research-and-report-service/system-configuration-activity-management/routes'
import BftiSystemTaskActivityMonitoringRoute from '../modules/bfti-research-and-report-service/task-activity-monitoring/routes'
import CommonServiceExternalRoute from '../modules/common-service/external/routes'

// Trade Fair Service Routes Start
import TradeFairServiceConfigurationRoute from '../modules/trade-fair-service/itf/configuration/routes'
import TradeFairServiceFairProposalManagementRoute from '../modules/trade-fair-service/itf/fair-proposal-management/routes'
import DITFConfigurationRoute from '../modules/trade-fair-service/ditf/configuration/routes'
import DITFCircularManagementRoute from '../modules/trade-fair-service/ditf/circular-management/routes'
import DITFTradeFairManagementRoute from '../modules/trade-fair-service/ditf/trade-fair-management/routes'
import ITFTradeFairInfoManagementRoute from '../modules/trade-fair-service/itf/trade-fair-info-managemnt/routes'
import TradeFairServiceFairPartiCircularManagementRoute from '../modules/trade-fair-service/itf/fair-parti-circular-management/routes'
import TradeFairServiceExhibitionManagementRoute from '../modules/trade-fair-service/itf/exhibition-management/routes'
import ITFFairPartiPaymentManagementRoute from '../modules/trade-fair-service/itf/fair-parti-management/routes'
import TradeFairReportRoute from '../modules/trade-fair-service/report/routes'
// Trade Fair Service Routes End

// Trade Tariff Service Routes Start
import TradeTariffServiceConfigurationRoute from '../modules/trade-tariff-service/specification/routes'
// Trade Tariff Service Routes End

// RJSC Service Routes Start
import RJSCServiceConfigurationRoute from '../modules/rjsc-service/configuration/routes'
import RJSCServicePortalRoute from '../modules/rjsc-service/admin-portal/routes'
// RJSC Service Routes End

const NotFoundPage = () => import('../views/pages/404.vue')

Vue.use(VueRouter)

const childRoutes = (prop) => [
  // {
  //   path: '',
  //   meta: { auth: false },
  //   redirect: { name: 'portal.home' }
  // },
  {
    path: '',
    meta: { auth: false },
    redirect: { name: 'auth.login' }
  }
  // {
  //   path: '/portal',
  //   name: prop + '.portal',
  //   meta: { auth: false },
  //   redirect: { name: 'portal.home' }
  // }
]

const defaultRoutes = [
  {
    path: '',
    name: 'dashboard',
    // component: AuthSignUpLayout,
    meta: { auth: false },
    children: childRoutes('dashboard')
  },
  {
    path: '*',
    meta: { auth: false },
    component: NotFoundPage
  }
]

const routes = [
  ...uiElementRoutes,
  ...defaultRoutes,
  ...PortalRoutes,
  ...RjscPortalRoutes,
  ...AuthServiceAuthRoute,
  ...DesginerServiceRoute,
  ...CommonServiceMenuRoute,
  ...CommonServiceOrgProfileRoute,
  ...CommonServiceOrganogramRoute,
  ...AuthServiceUserManagementRoute,
  ...CommonServiceNotificationRoute,
  ...CommonServicePortalRoute,
  ...BazarMonitoringServiceConfigurationRoute,
  ...BazarMonitoringServicePriceMonitoringRoute,
  ...BazarMonitoringServiceReportRoute,
  ...TeaGardenRoute,
  ...TeaGardenApprovalProcessRoute,
  ...TeaGardenServiceBTBRoute,
  ...TeaGardenServiceBTRIRoute,
  ...TeaGardenServicePDURoute,
  ...TeaGardenServiceDashboardRoute,
  ...EBizManagementSystemConfigRoute,
  ...EBizManagementSystemAssociationManagementRoute,
  ...EBizManagementSystemProposalManagementRoute,
  ...EBizManagementSystemPromotionalManagementRoute,
  ...EBizManagementSystemProgramManagementRoute,
  ...EBizManagementSystemPolicyAdvocacyRoute,
  ...EBizManagementSystemInformationTrainingRoute,
  ...EBizManagementSystemDashboardRoute,
  ...EBizManagementSystemReportsRoute,
  ...LicenseregistrationServiceConfigurationRoute,
  ...LicenseregistrationServiceLicenseManagementRoute,
  ...LicenseregistrationServiceTcbReportRoute,
  ...LicenseregistrationServiceDealerManagementRoute,
  ...LicenseregistrationServiceManageInformationRoute,
  ...LicenseregistrationServiceAllocationManagementRoute,
  ...LicenseregistrationServiceAllocationManagementDcOfficeRoute,
  ...licenseRegistrationServiceStepRoute,
  ...CommonServiceDocumentManagementRoute,
  ...CommonServiceComplainManagementRoute,
  ...CommonServiceInformationServiceManagementLocales,
  ...CommonServiceCommitteeRoute,
  ...ExportTrophyCipServiceConfigRoute,
  ...ExportTropohyCIPCircularRoute,
  ...CipEtExportTrophyRoute,
  ...CipEtCIPRoute,
  ...ExternalUserRoute,
  ...CommonServiceExternalRoute,
  ...BftiResReportServiceBaseUrlConfigurationRoute,
  ...BftiResReportServiceMeetingManagementRoute,
  ...BftiPolicyAdvocacyManagementSystemRoute,
  ...BftiSystemConfigurationActivityManagementRoute,
  ...BftiResearchPlanRoute,
  ...BftiResearchAndProposalRoute,
  ...BftiSystemTaskActivityMonitoringRoute,
  ...ExportTropohyGazetteRoute,
  ...BftiResearchExecutionManagementSystemRoute,
  ...ExportTropohyCIPEventManageRoute,
  ...ExportTrophyReportRoute,
  ...CommonServiceAccessControlRoute,
  ...TradeFairServiceConfigurationRoute,
  ...TradeFairServiceFairProposalManagementRoute,
  ...TradeFairServiceFairPartiCircularManagementRoute,
  ...TradeFairServiceExhibitionManagementRoute,
  ...ITFFairPartiPaymentManagementRoute,
  ...DITFConfigurationRoute,
  ...DITFCircularManagementRoute,
  ...DITFTradeFairManagementRoute,
  ...ITFTradeFairInfoManagementRoute,
  ...TradeFairReportRoute,
  ...TradeTariffServiceConfigurationRoute,
  ...RJSCServiceConfigurationRoute,
  ...RJSCServicePortalRoute
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  linkActiveClass: 'active',
  linkExactActiveClass: 'active',
  routes
})
// function getWithExpiry (key) {
//   const itemStr = localStorage.getItem(key)
//   if (!itemStr) {
//     return null
//   }
//   const item = JSON.parse(itemStr)
//   const now = new Date()
//   if (now.getTime() > item.expiry) {
//     localStorage.removeItem(key)
//     localStorage.clear()
//     Store.dispatch('Auth/updateAuthUser', null)
//     Store.dispatch('Auth/setAccessToken', null)
//     window.vm.$router.push('/auth/login')
//   }
//   return item.value
// }
router.beforeEach((to, from, next) => {
  if (to.matched.some(record => record.meta.auth)) {
    // const accessToken = getWithExpiry('access_token')
    const accessToken = Store.state.Auth.accessToken
    const authUser = Store.state.Auth.authUser
    if (accessToken && !authUser) {
      return next({ path: '/auth/login' })
    } else if (to.path === '/auth/login' && authUser) {
      if (authUser.user_type === 1) {
        return next({ path: '/auth/dashboard' })
      } else {
        const serviceUrl = Store.state.Portal.serviceUrl.externalPanelServiceUrl
        if (serviceUrl) {
          return next({ path: serviceUrl })
        } else {
          return next({ path: '/external-user/panel' })
        }
      }
    } else if (to.path === '/auth/dashboard' && !authUser) {
      return next({ path: '/auth/login' })
    } else {
      return next()
    }
  }

  next()
})

export default router
