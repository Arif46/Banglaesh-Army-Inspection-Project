const childRoutes = (prop) => [
  {
    path: 'create-committee',
    name: prop + '.create_committee',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/create-committee/List.vue')
  },
  {
    path: 'manage-agenda',
    name: prop + '.manage_agenda',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/manage-agenda/List.vue')
  },
  {
    path: 'generate-circulate',
    name: prop + '.generate_circulate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/generate-circulate/List.vue')
  },
  {
    path: 'manage-expense',
    name: prop + '.manage_expense',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/manage-expense/List.vue')
  }
  ]

  const routes = [
      {
        path: '/common-service/committee-management',
        name: 'common_service.committee_management',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.committee_management')
      }
  ]

  export default routes
