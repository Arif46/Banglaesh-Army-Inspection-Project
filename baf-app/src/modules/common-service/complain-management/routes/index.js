const childRoutes = (prop) => [
  {
    path: 'complain-type',
    name: prop + '.complain_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-type/List.vue')
  },
  {
    path: 'complain-designation',
    name: prop + '.complain_designation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-designation/List.vue')
  },
  {
    path: 'complain-submit',
    name: prop + '.complain_submit',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-submit/List.vue')
  },
  {
    path: 'complain-chain',
    name: prop + '.complain_chain',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-chain/List.vue')
  },
  {
    path: 'complain-request',
    name: prop + '.complain_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-request/List.vue')
  },
  {
    path: 'complain-report',
    name: prop + '.complain_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain-report/List.vue')
  }
]

const routes = [
    {
      path: '/common-service/complain-management',
      name: 'common_service.complain_management',
      component: () => import('@/layouts/CommonServiceLayout.vue'),
      meta: { auth: false },
      children: childRoutes('common_service.complain_management')
    }
]

export default routes
