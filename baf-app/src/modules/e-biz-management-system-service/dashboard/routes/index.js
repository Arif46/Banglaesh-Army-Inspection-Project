const dashboardComRoutes = (prop) => [
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
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/dashboard',
    name: 'e_biz_management_system_service',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: dashboardComRoutes('e_biz_management_system_service')
  }
]

export default routes
