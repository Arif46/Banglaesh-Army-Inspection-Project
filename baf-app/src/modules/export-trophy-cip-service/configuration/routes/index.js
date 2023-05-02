const configurationRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/List.vue')
  },
  {
    path: 'product-service-sector',
    name: prop + '.product_service_sector',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/product-service-sector/List.vue')
  },
  {
    path: 'assign-income',
    name: prop + '.assign_income',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-income/List.vue')
  },
  {
    path: 'cip-sector',
    name: prop + '.cip_sector',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/cip-sector/List.vue')
  },
  {
    path: 'venue-info',
    name: prop + '.venue_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/venue-info/List.vue')
  },
  {
    path: 'assign-trophy',
    name: prop + '.assign_trophy',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-trophy/List.vue')
  },
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue')
  },
  {
    path: 'et-evalution-marking',
    name: prop + '.et_evalution_marking',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/et-evalution-marking/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/configuration',
    name: 'export_trophy_cip_service.configuration',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('export_trophy_cip_service.configuration')
  }
]

export default routes
