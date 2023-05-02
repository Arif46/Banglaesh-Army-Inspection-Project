const circularRoutes = (prop) => [
  {
    path: 'list',
    name: prop + '.list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular/List.vue')
  },
  {
    path: 'forward-list',
    name: prop + '.forward_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular-request/List.vue')
  },
  {
    path: 'approve-list',
    name: prop + '.approve_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular-approve/List.vue')
  },
  {
    path: 'published-list',
    name: prop + '.published_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular-publised/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/circular',
    name: 'export_trophy_cip_service.circular',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: circularRoutes('export_trophy_cip_service.circular')
  }
]

export default routes
