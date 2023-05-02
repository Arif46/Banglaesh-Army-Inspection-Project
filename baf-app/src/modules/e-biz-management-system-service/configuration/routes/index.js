const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue')
  },
  {
    path: 'association-info',
    name: prop + '.association_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/association-info/List.vue')
  },
  {
    path: 'program-type',
    name: prop + '.program_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/program-type/List.vue')
  },
  {
    path: 'type-of-business',
    name: prop + '.type_of_business',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/type-of-business/List.vue')
  },
  {
    path: 'proposal-type',
    name: prop + '.proposal_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/proposal-type/List.vue')
  },
  {
    path: 'council-info',
    name: prop + '.council_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/council-info/List.vue')
  },
  {
    path: 'project-name',
    name: prop + '.project_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/project-name/List.vue')
  },
  {
    path: 'product-name',
    name: prop + '.product_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/product-name/List.vue')
  },
  {
    path: 'external-pannel-db',
    name: prop + '.external-pannel-db',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/External-pannel-db.vue')
  },
  {
    path: 'proposal-mgnt-db',
    name: prop + '.proposal-mgnt-db',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/Proposal-management.vue')
  },
  {
    path: 'program-mgnt-db',
    name: prop + '.program-mgnt-db',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/Program-management.vue')
  },
  {
    path: 'promotion-mgnt-db',
    name: prop + '.promotion-mgnt-db',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/Promotion-management.vue')
  },
  {
    path: 'policy-adv-mgnt-db',
    name: prop + '.policy-adv-mgnt-db',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/Policy-advocacy-management.vue')
  },
  {
    path: 'slider',
    name: prop + '.slider',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/slider/List.vue')
  },
  {
    path: 'portal-question-answer',
    name: prop + '.portal_question_answer',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/portal-question-answer/List.vue')
  },
  {
    path: 'basic-information',
    name: prop + '.basic_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/basic-information/List.vue')
  },
  {
    path: 'user-assign',
    name: prop + '.user_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/user-assign/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service',
    name: 'e_biz_management_system_service',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('e_biz_management_system_service')
  },
  {
    path: '/e-biz-management-system-service/configuration',
    name: 'e_biz_management_system_service.configuration',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('e_biz_management_system_service.configuration')
  }
]

export default routes
