// cip panel child routes
const cipPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/Dashboard.vue')
  },
  {
    path: 'circular',
    name: prop + '.circular',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/circular/List.vue')
  },
  {
    path: 'cip-application',
    name: prop + '.cip_application',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/cip-application/List.vue')
  },
  {
    path: 'cip-application-form',
    name: prop + '.cip_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/export-trophy-cip-panel/pages/cip-application/Form.vue')
  },
  {
    path: 'export-trophy-application',
    name: prop + '.export_trophy_application',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/export-tophy-application/List.vue')
  },
  {
    path: 'export-trophy-application-form',
    name: prop + '.export_trophy_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/export-trophy-cip-panel/pages/export-tophy-application/Form.vue')
  },
  {
    path: 'gazettes',
    name: prop + '.gazettes',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/gazettes/List.vue')
  },
  {
    path: 'cip-award-invitation',
    name: prop + '.cip_award_invitation',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/cip-award-invitation/List.vue')
  },
  {
    path: 'export-trophy-award-invitation',
    name: prop + '.export_trophy_award_invitation',
    meta: { auth: true },
    component: () => import('../views/export-trophy-cip-panel/pages/export-trophy-award-invitation/List.vue')
  }
]
const bftiPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/Dashboard.vue')
  },
  {
    path: 'research-and-other-request-list',
    name: prop + '.research-and-other-request-list',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/research-and-other-request/List')
  },
  {
    path: 'policy-request-entry',
    name: prop + '.policy-request-entry',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/policy-request-entry/List')
  },
  {
    path: 'receive-meeting-notice',
    name: prop + '.receive_meeting_notice',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/receive-meeting-notice/List')
  },
  {
    path: 'survey-list',
    name: prop + '.survey_list',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/survey/List')
  },
  {
    path: 'survey-entry/add/:id?',
    name: prop + '.survey-entry',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/survey/Form')
  },
  {
    path: 'survey-entry/edit',
    name: prop + '.survey-edit',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/survey/EditForm')
  },
  {
    path: 'survey-entry/view/:id?',
    name: prop + '.survey-entry-view',
    meta: { auth: true },
    component: () => import('../views/bfti-panel/pages/survey/View')
  }
]
const dealerPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/Dashboard.vue')
  },
  {
    path: 'applications',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/application/List')
  },
  {
    path: 'applications/:status',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/application/List')
  },
  {
    path: 'allocation-letter',
    name: prop + '.allocation-letter',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/allocation-letter/List')
  },
  {
    path: 'allocation-letter/:status',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/allocation-letter/List')
  },
  {
    path: 'complain',
    name: prop + '.complain',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/complain/List')
  },
  {
    path: 'faq',
    name: prop + '.faq',
    meta: { auth: true },
    component: () => import('../views/dealer-panel/pages/faq/List')
  }
]
const lrcpnPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/Dashboard.vue')
  },
  {
    path: 'applications',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/List')
  },
  {
    path: 'applications/:status',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/List')
  },
  {
    path: 'application-form',
    name: prop + '.application_form',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/Form.vue')
  },
  {
    path: 'application-form-edit',
    name: prop + '.application_form_edit',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/Edit.vue')
  },
  {
    path: 'application-form-resubmit',
    name: prop + '.application_form_edit',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/Resubmit.vue')
  },
  {
    path: 'application-form-view',
    name: prop + '.application_form_view',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/View.vue')
  },
  {
    path: 'document-view',
    name: prop + '.document_view',
    meta: { auth: true },
    component: () => import('../views/lrcpn-panel/pages/application/DocumentView.vue')
  }
]
const associationPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/Dashboard.vue')
  },
  {
    path: 'association-profile-update',
    name: prop + '.association_profile_update',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/ProfileUpdate.vue')
  },
  {
    path: 'association-profile',
    name: prop + '.association_profile',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/ProfileShow.vue')
  },
  {
    path: 'published-notice',
    name: prop + '.published_notice',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/published-notice/List.vue')
  },
  {
    path: 'proposal-submission',
    name: prop + '.proposal_submission',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/proposal-submission/List.vue')
  },
  {
    path: 'program-request',
    name: prop + '.program_request',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/program-request/List.vue')
  },
  {
    path: 'submit-bill',
    name: prop + '.submit_bill',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/submit-bill/List.vue')
  },
  {
    path: 'fund-receive',
    name: prop + '.submit_bill',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/fund-receive/List.vue')
  },
  {
    path: 'policy-advocacy-application',
    name: prop + '.policy_advocacy_application',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/policy-advocacy-application/List.vue')
  },
  {
    path: 'online-product-advertisement',
    name: prop + '.online_product_advertisement',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/online-product-advertisement/List.vue')
  },
  {
    path: 'promotion-of-events',
    name: prop + '.promotion_of_events',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/promotion-of-events/List.vue')
  },
  {
    path: 'public-relationship-management',
    name: prop + '.public_relationship_management',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/public-relationship-management/List.vue')
  },
  {
    path: 'country-branding',
    name: prop + '.country_branding',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/country-branding/List.vue')
  },
  {
    path: 'sales-kits',
    name: prop + '.sales_kits',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/sales-kits/List.vue')
  },
  {
    path: 'policy-advocacy-feedback',
    name: prop + '.policy_advocacy_feedback',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/policy-advocacy-feedback/List.vue')
  },
  {
    path: 'business-directory',
    name: prop + '.business_directory',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/business-directory/List.vue')
  },
  {
    path: 'product-directory',
    name: prop + '.product_directory',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/product-directory/List.vue')
  },
  {
    path: 'training-information',
    name: prop + '.training_information',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/training-information/List.vue')
  },
  {
    path: 'training-summary',
    name: prop + '.training_summary',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/training-summary/List.vue')
  },
  {
    path: 'content-management',
    name: prop + '.content_management',
    meta: { auth: true },
    component: () => import('../views/association-panel/pages/content-management/List.vue')
  }
]
// common profile routes
const commonProfileRoute = prop => [
  {
    path: 'profile',
    name: prop + '.profile',
    meta: { auth: true },
    component: () => import('../views/ProfileShow.vue')
  },
  {
    path: 'profile-update',
    name: prop + '.profile_update',
    meta: { auth: true },
    component: () => import('../views/ProfileUpdate.vue')
  },
  {
    path: 'panel',
    name: prop + '.panel',
    meta: { auth: true },
    component: () => import('../views/Panel.vue')
  }
]
// tea garden panel child routes
const teaGardenPanelRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/Dashboard.vue')
  },
  // for small tea farmer routes
  {
    path: 'tea-farmer-application',
    name: prop + '.tea_farmer_application',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/tea-farmer-reg/List.vue')
  },
  {
    path: 'tea-farmer-application-form',
    name: prop + '.tea_farmer_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/tea-garden-panel/pages/tea-farmer-reg/Form.vue')
  },
  {
    path: 'tea-farmer-application-renew-form/:parent_id',
    name: prop + '.tea_farmer_application_renew_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/tea-garden-panel/pages/tea-farmer-reg/RenewForm.vue')
  },
  {
    path: 'small-farmer-certificate/:id',
    name: prop + '.small_farmer_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/SmallTeaFarmer/Certificate.vue')
  },
  {
    path: 'tea-farmer-application-view/:id',
    name: prop + '.tea_farmer_application_view',
    meta: { auth: true },
    props: true,
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/SmallTeaFarmer/Details.vue')
  },
  // for tea garden routes
  {
    path: 'tea-garden-application',
    name: prop + '.tea_garden_application',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/tea-garden-application/List.vue')
  },
  {
    path: 'tea-garden-application-form',
    name: prop + '.tea_garden_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/tea-garden-panel/pages/tea-garden-application/Form.vue')
  },
  {
    path: 'tea-garden-application/:id',
    name: prop + '.tea_garden_application_show',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/TeaGarden/Details.vue')
  },
  {
    path: 'tea-garden-application-certificate/:id',
    name: prop + '.tea_garden_application_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/TeaGarden/Certificate.vue')
  },
  {
    path: 'tea-garden-renew-application-form/:id',
    name: prop + '.tea_garden_renew_application_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../views/tea-garden-panel/pages/tea-garden-application/RenewForm.vue')
  },
  // for tea factory routes
  {
    path: 'tea-factory-application',
    name: prop + '.tea_factory_application',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/tea-factory-application/List.vue')
  },
  {
    path: 'tea-factory-application-form',
    name: prop + '.tea_factory_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/tea-garden-panel/pages/tea-factory-application/Form.vue')
  },
  {
    path: 'tea-factory-application-renew-form/:parent_id',
    name: prop + '.tea_factory_application_renew_form',
    meta: { auth: true },
    props: true,
    component: () => import('../views/tea-garden-panel/pages/tea-factory-application/RenewForm.vue')
  },
  {
    path: 'tea-factory-certificate/:id',
    name: prop + '.tea_factory_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/TeaFactory/Certificate.vue')
  },
  {
    path: 'tea-factory-application-view/:id',
    name: prop + '.tea_factory_application_view',
    meta: { auth: true },
    props: true,
    component: () => import('../../tea-garden-service/btb/ApplicationDetails/TeaFactory/Details.vue')
  },
  // payments routes
  {
    path: 'payment/:id',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/pages/Payment/Payment.vue')
  },
  {
    path: 'service/payment/success',
    name: prop + '.payment_success',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/pages/Payment/Success.vue')
  },
  {
    path: 'service/payment/cancel',
    name: prop + '.payment_cancel',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/pages/Payment/Cancel.vue')
  },
  {
    path: 'service/payment/decline',
    name: prop + '.payment_decline',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../tea-garden-service/btb/pages/Payment/Decline.vue')
  },
  // payment route end
  // circular list PDU
  {
    path: 'circular-list',
    name: prop + '.circular_list',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/pdu/CircularList.vue')
  },
  {
    path: 'circular-details/:id',
    name: prop + '.circular_details',
    meta: { auth: true },
    component: () => import('../views/tea-garden-panel/pages/pdu/CircularView.vue')
  }

]
const tradeFairRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/Dashboard.vue')
  },
  {
    path: 'fair-participation-circular',
    name: prop + '.fair_participation_circular',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/fair-participation-circular/List')
  },
  {
    path: 'exhibition-circular-list',
    name: prop + '.exhibition_circular_list',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/exhibit-circular-list/List')
  },
  {
    path: 'exhibit-information-form',
    name: prop + '.exhibition_information_form',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/exhibit-information/Form')
  },
  {
    path: 'exhibit-information',
    name: prop + '.exhibit_information',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/exhibit-information/List')
  },
  {
    path: 'fair-participation',
    name: prop + '.fair_participation',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/fair-participation/List')
  },
  {
    path: 'fair-participation/:status',
    name: prop + '.fair_participation',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/fair-participation/List')
  },
  {
    path: 'fair-participation-form',
    name: prop + '.fair_participation_form',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/fair-participation/Form')
  },
  {
    path: 'visa-processing-info-list',
    name: prop + '.visa_processing_info_list',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/itf/visa-processing-info/List')
  }
]

const dhakaTradeFairRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/ditf/Dashboard.vue')
  },
  {
    path: 'circular-list',
    name: prop + '.circular_list',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/ditf/participation-circular/List')
  },
  {
    path: 'fair-application-form',
    name: prop + '.fair_application_form',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/ditf/fair-application/Form')
  },
  {
    path: 'fair-application',
    name: prop + '.fair_application',
    meta: { auth: true },
    component: () => import('../views/trade-fair-panel/pages/ditf/fair-application/List')
  }
]

const tradeAndTariffRoute = prop => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true },
    component: () => import('../views/trade-and-tariff-panel/pages/Dashboard.vue')
  },
  {
    path: 'application',
    name: prop + '.application',
    meta: { auth: true },
    component: () => import('../views/trade-and-tariff-panel/pages/application/List')
  },
  {
    path: 'application-form',
    name: prop + '.application_form',
    meta: { auth: true },
    component: () => import('../views/trade-and-tariff-panel/pages/application/Form')
  },
  {
    path: 'application-form/:id',
    name: prop + '.application_form',
    meta: { auth: true },
    component: () => import('../views/trade-and-tariff-panel/pages/application/Form')
  }
]
const routes = [
  {
    path: '/export-trophy-cip-panel',
    name: 'export_trophy_cip_panel',
    component: () => import('@/layouts/ExternalUser/CipPanelLayout.vue'),
    meta: { auth: true },
    children: cipPanelRoute('export_trophy_cip_panel')
  },
  {
    path: '/external-user',
    name: 'external_user',
    component: () => import('@/layouts/ExternalUser/CommonLayout.vue'),
    meta: { auth: true },
    children: commonProfileRoute('external_user')
  },
  {
    path: '/bfti-panel',
    name: 'bfti_panel',
    component: () => import('@/layouts/ExternalUser/BftiPanelLayout.vue'),
    meta: { auth: true },
    children: bftiPanelRoute('bfti_panel')
  },
  {
    path: '/dealer-panel',
    name: 'dealer_panel',
    component: () => import('@/layouts/ExternalUser/DealerPanelLayout.vue'),
    meta: { auth: true },
    children: dealerPanelRoute('dealer_panel')
  },
  {
    path: '/lrcpn-panel',
    name: 'lrcpn_panel',
    component: () => import('@/layouts/ExternalUser/LrcpnPanelLayout.vue'),
    meta: { auth: true },
    children: lrcpnPanelRoute('lrcpn_panel')
  },
  {
    path: '/association-panel',
    name: 'association_panel',
    component: () => import('@/layouts/ExternalUser/AssociationPanelLayout.vue'),
    meta: { auth: true },
    children: associationPanelRoute('association_panel')
  },
  {
    path: '/tea-garden-panel',
    name: 'tea_garden_panel',
    component: () => import('@/layouts/ExternalUser/TeaGardenPanelLayout.vue'),
    meta: { auth: true },
    children: teaGardenPanelRoute('tea_garden_panel')
  },
  {
    path: '/trade-fair-panel',
    name: 'trade_fair_panel',
    component: () => import('@/layouts/ExternalUser/ITFPanelLayout.vue'),
    meta: { auth: true },
    children: tradeFairRoute('trade_fair_panel')
  },
  {
    path: '/dhaka-trade-fair-panel',
    name: 'trade_fair_panel',
    component: () => import('@/layouts/ExternalUser/DITFPanelLayout.vue'),
    meta: { auth: true },
    children: dhakaTradeFairRoute('trade_fair_panel')
  },
  {
    path: '/trade-and-tariff-panel',
    name: 'trade_and_tariff_panel',
    component: () => import('@/layouts/ExternalUser/TradeAndTariffPanelLayout.vue'),
    meta: { auth: true },
    children: tradeAndTariffRoute('trade_and_tariff_panel')
  }
]

export default routes
