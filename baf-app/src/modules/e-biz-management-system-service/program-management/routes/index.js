const programManagementRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'program-list',
    name: prop + '.program_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/program-list/List.vue')
  },
  {
    path: 'approved-program',
    name: prop + '.approved_program',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approved-program/List.vue')
  },
  {
    path: 'agreement-preparation',
    name: prop + '.agreement_preparation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/agreement-preparation/List.vue')
  },
  {
    path: 'advance-payment',
    name: prop + '.advance_payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/advance-payment/List.vue')
  },
  {
    path: 'select-investigator',
    name: prop + '.select_investigator',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/select-investigator/List.vue')
  },
  {
    path: 'monitoring-and-evaluation',
    name: prop + '.monitoring_and_evaluation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/monitoring-and-evaluation/List.vue')
  },
  {
    path: 'approve-bill',
    name: prop + '.approve_bill',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approve-bill/List.vue')
  },
  {
    path: 'payment',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/program-management',
    name: 'e_biz_management_system_service.program_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: programManagementRoutes('e_biz_management_system_service.program_management')
  }
]

export default routes
