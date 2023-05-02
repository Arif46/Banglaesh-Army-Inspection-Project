const policyAdvocacyRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'application-list',
    name: prop + '.application_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/application/List.vue')
  },
  {
    path: 'workshop-details',
    name: prop + '.workshop_details',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/workshop-details/List.vue')
  },
  {
    path: 'policy-approval',
    name: prop + '.policy_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/policy-approval/List.vue')
  },
  {
    path: 'feedback-and-recommendation',
    name: prop + '.feedback_and_recommendation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/feedback-and-recommendation/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/policy-advocacy-management',
    name: 'e_biz_management_system_service.policy_advocacy_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: policyAdvocacyRoutes('e_biz_management_system_service.policy_advocacy_management')
  }
]

export default routes
