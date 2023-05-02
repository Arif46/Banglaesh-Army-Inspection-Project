import Vue from 'vue'
import VueI18n from 'vue-i18n'

Vue.use(VueI18n)
const mergeLocaleMessage = (localeMessages) => {
  const messages = {}
  localeMessages.keys().forEach(key => {
    const matched = key.match(/([A-Za-z0-9-_]+)\./i)
    if (matched && matched.length > 1) {
      const locale = matched[1]
      messages[locale] = localeMessages(key)
    }
  })
  return messages
}
function loadLocaleMessages () {
  let locales = require.context('./locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const defaultMessages = mergeLocaleMessage(locales)
  locales = require.context('./modules/auth-service/auth/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const authServiceLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/portal/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const portalMessages = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/menu/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceMenuLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/org-profile/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceOrgProfileLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/organogram/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceOrganogramLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/notification-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceNotificationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/portal/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServicePortalLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/access-control/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceAccessControlLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/auth-service/user-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const authServiceUserManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bazar-monitoring-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const BazarMonitoringServiceConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/document-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceDocumentManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bazar-monitoring-service/commodity-price-market-monitoring/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const BazarMonitoringServicePriceMonitoringLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bazar-monitoring-service/reports/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const BazarMonitoringServiceReportLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/complain-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceComplainManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/committee/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceCommitteeLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/information-service-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceInformationServiceManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const exportTrophyCipServiceConfigLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const LicenseRegistrationServiceConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/license-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const LicenseRegistrationServiceLicenseLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/tcb-report/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const LicenseRegistrationServiceTcbReportLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/dealer-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const LicenseRegistrationServiceDealerLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const externalUserServiceLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/common-service/external/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const commonServiceExternalLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/circular/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const exportTrophyCipCircularLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/event-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const exportTrophyCipEventManageLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiReaserchAndReportLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/meeting-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiReaserchAndReportMeetingManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/export-trophy/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const cipEtExportTrophyLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/cip/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const cipEtCIPLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/bfti-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiReaserchAndReportExternalLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/research-request-and-proposal-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiReaserchAndProposalLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/policy-advocacy-management-system/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftipolicyAdvocacyManagementSystemLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/system-configuration-activity-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiSystemConfigurationActivityManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/research-plan-preparation/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiresearchPlanManagement = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/research-execution-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiResearchExecutionManagement = mergeLocaleMessage(locales)
  locales = require.context('./modules/bfti-research-and-report-service/task-activity-monitoring/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const bftiResearchTaskActivityMonitoring = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/gazette/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const exportTrophyGazetteLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/dealer-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const dealerPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/association-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const associationPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/trade-and-tariff-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const tradeAndTariffPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/export-trophy-cip-service/report/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const exportTrophyReportLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/license-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const lrcpnlicenseManagement = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/manage-information/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const manageInformation = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/allocation-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const lrcpnAllocationManagement = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/allocation-management-dc-office/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const lrcpnAllocationManagementDcOffice = mergeLocaleMessage(locales)
  locales = require.context('./modules/license-registration-service/license-step/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const lrcpnLicenseStep = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/lrcpn-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const lrcpnPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/tea-garden-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const teaGardenPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenServiceConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/btb/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenServiceBtbLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/dashboard/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenDashboardLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/btri/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenServiceBtriLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/pdu/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenServicePduLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/tea-garden-service/approval-process/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TeaGardenServiceApprovalProcessLocales = mergeLocaleMessage(locales)
  // EBiz Management Locals Start
  locales = require.context('./modules/e-biz-management-system-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/proposal-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceProposalManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/e-biz-reports/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceReportsLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/dashboard/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceDashboardLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/program-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceProgramManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/association-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceAssociationManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/policy-advocacy-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServicePolicyAdvocacyManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/promotional-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemPromotionalManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/e-biz-management-system-service/information-training-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const EBizManagementSystemServiceInformationTrainingManagementLocales = mergeLocaleMessage(locales)
// EBiz Management Locals End

// Trade and Tariff Management Locals Start
  locales = require.context('./modules/trade-tariff-service/specification/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeTariffServiceConfigurationLocales = mergeLocaleMessage(locales)
// Trade and Tariff Management Locals End

  locales = require.context('./modules/trade-fair-service/itf/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeFairServiceConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/itf/fair-proposal-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeFairServiceFairProposalCalanderLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/itf/fair-parti-circular-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeFairServiceFairPartiCircularLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/itf/exhibition-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeFairServiceExhibitionCircularLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/itf/fair-parti-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const ITFFairPartiPaymentLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/ditf/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const DITFConfigurationLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/ditf/circular-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const DITFcircularManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/ditf/trade-fair-management/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const DITFtradeFairManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/itf/trade-fair-info-managemnt/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const ITFTradeFairIngoManagementLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/trade-fair-service/report/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const TradeFairReportLocales = mergeLocaleMessage(locales)
  locales = require.context('./modules/external-user-service/views/trade-fair-panel/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const tradeFairPanel = mergeLocaleMessage(locales)
  locales = require.context('./modules/rjsc-service/configuration/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const rjscConfigLocale = mergeLocaleMessage(locales)
  locales = require.context('./modules/rjsc-service/admin-portal/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const rjscServiceAdminPortalLocale = mergeLocaleMessage(locales)
  locales = require.context('./modules/rjsc-portal/locales', true, /[A-Za-z0-9-_,\s]+\.json$/i)
  const rjscPortalLocale = mergeLocaleMessage(locales)

  const dateTimeFormats = {
    en: {
      short: {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
      },
      long: {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long',
        hour: 'numeric',
        minute: 'numeric'
      },
      time: {
        hour: 'numeric',
        minute: 'numeric'
      }
    },
    bn: {
      short: {
        year: 'numeric',
        month: 'short',
        day: 'numeric'
      },
      long: {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long',
        hour: 'numeric',
        minute: 'numeric',
        hour12: true
      },
      time: {
        hour: 'numeric',
        minute: 'numeric',
        hour12: true
      }
    }
  }
  const allMessages = {
    bn: Object.assign(
      {},
      dateTimeFormats.bn,
      defaultMessages.bn,
      portalMessages.bn,
      authServiceLocales.bn,
      commonServiceMenuLocales.bn,
      commonServiceOrgProfileLocales.bn,
      commonServiceOrganogramLocales.bn,
      commonServiceNotificationLocales.bn,
      commonServicePortalLocales.bn,
      authServiceUserManagementLocales.bn,
      BazarMonitoringServiceConfigurationLocales.bn,
      BazarMonitoringServicePriceMonitoringLocales.bn,
      BazarMonitoringServiceReportLocales.bn,
      LicenseRegistrationServiceConfigurationLocales.bn,
      LicenseRegistrationServiceLicenseLocales.bn,
      LicenseRegistrationServiceTcbReportLocales.bn,
      LicenseRegistrationServiceDealerLocales.bn,
      commonServiceDocumentManagementLocales.bn,
      commonServiceComplainManagementLocales.bn,
      commonServiceInformationServiceManagementLocales.bn,
      commonServiceCommitteeLocales.bn,
      exportTrophyCipServiceConfigLocales.bn,
      externalUserServiceLocales.bn,
      commonServiceExternalLocales.bn,
      exportTrophyCipCircularLocales.bn,
      exportTrophyCipCircularLocales.bn,
      bftiReaserchAndReportLocales.bn,
      cipEtExportTrophyLocales.bn,
      cipEtCIPLocales.bn,
      bftiReaserchAndReportExternalLocales.bn,
      bftiReaserchAndReportMeetingManagementLocales.bn,
      bftiReaserchAndProposalLocales.bn,
      bftipolicyAdvocacyManagementSystemLocales.bn,
      bftiSystemConfigurationActivityManagementLocales.bn,
      bftiresearchPlanManagement.bn,
      bftiResearchTaskActivityMonitoring.bn,
      exportTrophyGazetteLocales.bn,
      exportTrophyCipEventManageLocales.bn,
      bftiResearchExecutionManagement.bn,
      dealerPanel.bn,
      associationPanel.bn,
      tradeAndTariffPanel.bn,
      exportTrophyReportLocales.bn,
      lrcpnlicenseManagement.bn,
      manageInformation.bn,
      commonServiceAccessControlLocales.bn,
      lrcpnAllocationManagement.bn,
      lrcpnAllocationManagementDcOffice.bn,
      lrcpnLicenseStep.bn,
      lrcpnPanel.bn,
      teaGardenPanel.bn,
      TeaGardenServiceConfigurationLocales.bn,
      TeaGardenServiceBtbLocales.bn,
      TeaGardenServiceBtriLocales.bn,
      TeaGardenServicePduLocales.bn,
      TeaGardenDashboardLocales.bn,
      TeaGardenServiceApprovalProcessLocales.bn,
      EBizManagementSystemServiceConfigurationLocales.bn,
      EBizManagementSystemServiceProposalManagementLocales.bn,
      EBizManagementSystemServiceProgramManagementLocales.bn,
      EBizManagementSystemServicePolicyAdvocacyManagementLocales.bn,
      EBizManagementSystemPromotionalManagementLocales.bn,
      EBizManagementSystemServiceInformationTrainingManagementLocales.bn,
      EBizManagementSystemServiceAssociationManagementLocales.bn,
      TradeFairServiceConfigurationLocales.bn,
      TradeFairServiceFairProposalCalanderLocales.bn,
      TradeFairServiceFairPartiCircularLocales.bn,
      TradeFairServiceExhibitionCircularLocales.bn,
      ITFFairPartiPaymentLocales.bn,
      ITFTradeFairIngoManagementLocales.bn,
      TradeFairReportLocales.bn,
      EBizManagementSystemServiceDashboardLocales.bn,
      EBizManagementSystemServiceReportsLocales.bn,
      DITFConfigurationLocales.bn,
      DITFcircularManagementLocales.bn,
      DITFtradeFairManagementLocales.bn,
      TradeTariffServiceConfigurationLocales.bn,
      tradeFairPanel.bn,
      rjscConfigLocale.bn,
      rjscServiceAdminPortalLocale.bn,
      rjscPortalLocale.bn
    ),
    en: Object.assign(
      {},
      dateTimeFormats.en,
      defaultMessages.en,
      portalMessages.en,
      authServiceLocales.en,
      commonServiceMenuLocales.en,
      commonServiceOrgProfileLocales.en,
      commonServiceOrganogramLocales.en,
      commonServicePortalLocales.en,
      commonServiceNotificationLocales.en,
      authServiceUserManagementLocales.en,
      BazarMonitoringServiceConfigurationLocales.en,
      BazarMonitoringServicePriceMonitoringLocales.en,
      BazarMonitoringServiceReportLocales.en,
      LicenseRegistrationServiceConfigurationLocales.en,
      LicenseRegistrationServiceLicenseLocales.en,
      LicenseRegistrationServiceTcbReportLocales.en,
      LicenseRegistrationServiceDealerLocales.en,
      commonServiceDocumentManagementLocales.en,
      commonServiceComplainManagementLocales.en,
      commonServiceInformationServiceManagementLocales.en,
      commonServiceCommitteeLocales.en,
      exportTrophyCipServiceConfigLocales.en,
      externalUserServiceLocales.en,
      commonServiceExternalLocales.en,
      exportTrophyCipCircularLocales.en,
      bftiReaserchAndReportLocales.en,
      cipEtExportTrophyLocales.en,
      cipEtCIPLocales.en,
      bftiReaserchAndReportExternalLocales.en,
      bftiReaserchAndReportMeetingManagementLocales.en,
      bftiReaserchAndProposalLocales.en,
      bftipolicyAdvocacyManagementSystemLocales.en,
      bftiSystemConfigurationActivityManagementLocales.en,
      bftiresearchPlanManagement.en,
      bftiResearchTaskActivityMonitoring.en,
      exportTrophyGazetteLocales.en,
      exportTrophyCipEventManageLocales.en,
      bftiResearchExecutionManagement.en,
      dealerPanel.en,
      associationPanel.en,
      tradeAndTariffPanel.en,
      exportTrophyReportLocales.en,
      lrcpnlicenseManagement.en,
      manageInformation.en,
      commonServiceAccessControlLocales.en,
      lrcpnAllocationManagement.en,
      lrcpnAllocationManagementDcOffice.en,
      lrcpnLicenseStep.en,
      lrcpnPanel.en,
      teaGardenPanel.en,
      TeaGardenServiceConfigurationLocales.en,
      TeaGardenServiceBtbLocales.en,
      TeaGardenServiceBtriLocales.en,
      TeaGardenServicePduLocales.en,
      TeaGardenDashboardLocales.en,
      TeaGardenServiceApprovalProcessLocales.en,
      EBizManagementSystemServiceConfigurationLocales.en,
      EBizManagementSystemServiceProposalManagementLocales.en,
      EBizManagementSystemServiceProgramManagementLocales.en,
      EBizManagementSystemServicePolicyAdvocacyManagementLocales.en,
      EBizManagementSystemPromotionalManagementLocales.en,
      EBizManagementSystemServiceInformationTrainingManagementLocales.en,
      EBizManagementSystemServiceAssociationManagementLocales.en,
      TradeFairServiceConfigurationLocales.en,
      TradeFairServiceFairProposalCalanderLocales.en,
      TradeFairServiceFairPartiCircularLocales.en,
      TradeFairServiceExhibitionCircularLocales.en,
      ITFFairPartiPaymentLocales.en,
      ITFTradeFairIngoManagementLocales.en,
      TradeFairReportLocales.en,
      EBizManagementSystemServiceDashboardLocales.en,
      EBizManagementSystemServiceReportsLocales.en,
      DITFConfigurationLocales.en,
      DITFcircularManagementLocales.en,
      DITFtradeFairManagementLocales.en,
      TradeTariffServiceConfigurationLocales.en,
      tradeFairPanel.en,
      rjscConfigLocale.en,
      rjscServiceAdminPortalLocale.en,
      rjscPortalLocale.en
    )
  }
  return allMessages
}
export default new VueI18n({
  locale: process.env.VUE_APP_I18N_LOCALE || 'en',
  fallbackLocale: process.env.VUE_APP_I18N_FALLBACK_LOCALE || 'en',
  messages: loadLocaleMessages()
})
