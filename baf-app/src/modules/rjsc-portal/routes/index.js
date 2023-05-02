const portalRoutes = (prop) => [
  {
    path: 'home',
    name: prop + '.home',
    meta: { auth: false },
    component: () => import('../pages/Home.vue')
  },
  {
    path: 'faq',
    name: prop + '.faq',
    meta: { auth: false },
    component: () => import('../pages/Faq.vue')
  },
  {
    path: 'about',
    name: prop + '.about',
    meta: { auth: false },
    component: () => import('../pages/About.vue')
  },
  {
    path: 'common-page/:id',
    props: true,
    name: prop + '.common_page',
    meta: { auth: false },
    component: () => import('../pages/CommonPage.vue')
  },
  {
    path: 'contact-us',
    name: prop + '.contactUs',
    meta: { auth: false },
    component: () => import('../pages/ContactUs.vue')
  },
  {
    path: 'entity-act',
    name: prop + '.entityAct',
    meta: { auth: false },
    component: () => import('../pages/EntityAct.vue')
  },
  {
    path: 'rjsc-fees',
    name: prop + '.rjscFees',
    meta: { auth: false },
    component: () => import('../pages/Fees.vue')
  },
  {
    path: 'rjsc-laws',
    name: prop + '.rjscLaws',
    meta: { auth: false },
    component: () => import('../pages/Laws.vue')
  },
  // Entity Statistics Route
  {
    path: 'entity-type',
    name: prop + '.entityType',
    meta: { auth: false },
    component: () => import('../pages/entity-statistics/EntityType.vue')
  },
  {
    path: 'sector',
    name: prop + '.entitySector',
    meta: { auth: false },
    component: () => import('../pages/entity-statistics/Sector.vue')
  },
  {
    path: 'sub-sector',
    name: prop + '.subSector',
    meta: { auth: false },
    component: () => import('../pages/entity-statistics/SubSector.vue')
  },
  {
    path: 'district',
    name: prop + '.entityDistrict',
    meta: { auth: false },
    component: () => import('../pages/entity-statistics/District.vue')
  },
  {
    path: 'search-entity',
    name: prop + '.searchEntity',
    meta: { auth: false },
    component: () => import('../pages/forms/SearchEntity.vue')
  },
  {
    path: 'submission-status',
    name: prop + '.submissionStatus',
    meta: { auth: false },
    component: () => import('../pages/forms/SubmissionStatus.vue')
  },
  {
    path: 'fee-calculator',
    name: prop + '.feeCalculator',
    meta: { auth: false },
    component: () => import('../pages/forms/FeeCalculator.vue')
  },
  {
    path: 'news-list',
    name: prop + '.news-list',
    meta: { auth: false },
    component: () => import('../pages/NewsList.vue')
  },
  {
    path: 'news-details/:id',
    name: prop + '.news_details',
    meta: { auth: false },
    component: () => import('../pages/NewsDetails.vue')
  },
  {
    path: 'notice-details/:id',
    name: prop + '.news-details',
    meta: { auth: false },
    component: () => import('../pages/NoticeDetails.vue')
  },
  {
    path: 'notice-list',
    name: prop + '.news-list',
    meta: { auth: false },
    component: () => import('../pages/NoticeList.vue')
  }
]

const portalProfileRoutes = (prop) => [
  {
    path: 'profile',
    name: prop + '.profile',
    meta: { auth: false },
    component: () => import('../profile/Profile.vue')
  },
  {
    path: 'entity-list',
    name: prop + '.entity-list',
    meta: { auth: false },
    component: () => import('../pages/EntityList.vue')
  }
]

const routes = [
  {
    path: '/rjsc-portal',
    name: 'rjsc_portal',
    component: () => import('@/layouts/RjscPortalLayout'),
    meta: { auth: false },
    children: portalRoutes('rjsc_portal')
  },
  {
    path: '/rjsc-portal-entity',
    name: 'rjsc_portal_entity',
    component: () => import('@/layouts/RjscPortalProfileLayout'),
    meta: { auth: false },
    children: portalProfileRoutes('rjsc_portal')
  }
]

export default routes
