const childRoutes = (prop) => [
  {
    path: 'log-report',
    name: prop + '.log_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/log-report/List.vue')
  }
  ]

  const routes = [
      {
        path: '/common-service/access-control',
        name: 'common_service.access_control',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.access_control')
      }
  ]

  export default routes
