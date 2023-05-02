const childRoutes = (prop) => [
  {
    path: 'external-panel',
    name: prop + '.external_panel',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/external-panel/List.vue')
  },
  {
    path: 'external-menu',
    name: prop + '.external_menu',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/external-menu/List.vue')
  }
]

const routes = [
  {
    path: '/common-service/external',
    name: 'common_service.external',
    component: () => import('@/layouts/CommonServiceLayout.vue'),
    meta: { auth: false },
    children: childRoutes('common_service.external')
  }
]

export default routes
