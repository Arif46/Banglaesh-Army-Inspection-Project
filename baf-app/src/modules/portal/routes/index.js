// const portalRoutes = (prop) => [
//   {
//     path: 'home',
//     name: prop + '.home',
//     meta: { auth: false },
//     component: () => import('../pages/Home.vue')
//   },
//   {
//     path: 'services',
//     name: prop + '.services',
//     meta: { auth: false },
//     component: () => import('../pages/Services.vue')
//   },
//   {
//     path: 'service-details',
//     name: prop + '.service_details',
//     meta: { auth: false },
//     component: () => import('../pages/ServiceDetails.vue')
//   },
//   {
//     path: 'about-service-portal',
//     name: prop + '.about_service_portal',
//     meta: { auth: false },
//     component: () => import('../pages/AboutPortal.vue')
//   },
//   {
//     path: 'all-services',
//     name: prop + '.all_services',
//     meta: { auth: false },
//     component: () => import('../pages/AllServices.vue')
//   },
//   {
//     path: 'faq',
//     name: prop + '.faq',
//     meta: { auth: false },
//     component: () => import('../pages/FAQ.vue')
//   },
//   {
//     path: 'news',
//     name: prop + '.news',
//     meta: { auth: false },
//     component: () => import('../pages/NewsList.vue')
//   },
//   {
//     path: 'news-details/:id',
//     name: prop + '.services',
//     meta: { auth: false },
//     component: () => import('../pages/NewsDetails.vue')
//   },
//   {
//     path: 'notice',
//     name: prop + '.notice',
//     meta: { auth: false },
//     component: () => import('../pages/NoticeList.vue')
//   },
//   {
//     path: 'policy',
//     name: prop + '.policy',
//     meta: { auth: false },
//     component: () => import('../pages/Policy.vue')
//   },
//   {
//     path: 'terms',
//     name: prop + '.terms',
//     meta: { auth: false },
//     component: () => import('../pages/Terms.vue')
//   },
//   {
//     path: 'cip-et-circular-list',
//     name: prop + '.cip_et_circular_list',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/cip-et-circular/List.vue')
//   },
//   {
//     path: 'license-dealer-notice',
//     name: prop + '.license_dealer_notice',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/license-dealer-notice/List.vue')
//   },
//   {
//     path: 'tea-garden-pdu-circular-notice',
//     name: prop + '.tea_garden_pdu_circular_notice',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/tea-garden-pdu-circular-notice/List.vue')
//   },
//   {
//     path: 'tea-garden-pdu-circular-notice/:id',
//     name: prop + '.circular_details',
//     meta: { auth: true },
//     component: () => import('../pages/tea-garden-pdu-circular-notice/Details.vue')
//   },
//   {
//     path: 'itf-calendar-circular',
//     name: prop + '.itf_calendar_circular',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/trade-fair/itf-calendar-circular/List.vue')
//   },
//   {
//     path: 'itf-participation-circular',
//     name: prop + '.itf_participation_circular',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/trade-fair/itf-participation-circular/List.vue')
//   },
//   {
//     path: 'itf-circular-exhibition',
//     name: prop + '.itf_circular_exhibition',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/trade-fair/itf-circular-exhibition/List.vue')
//   },
//   {
//     path: 'itf-calendar-info-form',
//     name: prop + '.itf_calendar_info_form',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/trade-fair/FairCalendarForm.vue')
//   },
//   {
//     path: 'circular-of-participation-ditf',
//     name: prop + '.circular_of_participation_ditf',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/trade-fair/ditf-participation-circular/List.vue')
//   },
//   {
//     path: 'bpc-landing-page',
//     name: prop + '.bpc_landing_page',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/bpcLandingPage.vue')
//   },
//   {
//     path: 'bpc-country-branding-view',
//     name: prop + '.bpc_product_view',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/countryBrandingView.vue')
//   },
//   {
//     path: 'bpc-product-view',
//     name: prop + '.bpc_product_view',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/productView.vue')
//   },
//   {
//     path: 'bpc-event-list',
//     name: prop + '.bpc_event_list',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/EventList.vue')
//   },
//   {
//     path: 'bpc-add-videos',
//     name: prop + '.bpc_ad_videos',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/AdVideoList.vue')
//   },
//   {
//     path: 'bpc-questions',
//     name: prop + '.bpc_questions',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/bpc/QuestionAns.vue')
//   },
//   {
//     path: 'other-min-services',
//     name: prop + '.other_min_services',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/other-ministry-services/Services.vue')
//   },
//   {
//     path: 'other-min-service-info',
//     name: prop + '.other_min_service-info',
//     props: true,
//     meta: { auth: false },
//     component: () => import('../pages/other-ministry-services/ServiceInfo.vue')
//   }
// ]
const tcbRoutes = (prop) => [
  {
    path: 'dealership',
    redirect: { path: '/portal/service-details', query: { service_type: 'categoryList', service_category_id: 2, service_id: 51 } }
  }
]

const routes = [
  // {
  //   path: '/portal',
  //   name: 'portal',
  //   component: () => import('@/layouts/PortalLayout'),
  //   meta: { auth: false },
  //   children: portalRoutes('portal')
  // },
  {
    path: '/tcb',
    name: 'tcb',
    component: () => import('@/layouts/PortalLayout'),
    meta: { auth: false },
    children: tcbRoutes('portal')
  }
]

export default routes
