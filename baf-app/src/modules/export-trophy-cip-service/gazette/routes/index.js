const circularRoutes = (prop) => [
  {
    path: 'prepare-list',
    name: prop + '.list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/prepare/List.vue')
  },
  {
    path: 'forward-list',
    name: prop + '.forwardlist',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/forward/List.vue')
  },
  {
    path: 'approve-list',
    name: prop + '.approvelist',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approve/List.vue')
  },
  {
    path: 'published-list',
    name: prop + '.publishlist',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/publish/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/gazette',
    name: 'export_trophy_cip_service.gazette',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: circularRoutes('export_trophy_cip_service.gazette')
  }
]

export default routes
