const circularRoutes = (prop) => [
  {
    path: 'export-trophy-candidate-report',
    name: prop + '.export_trophy_candidate_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/export-trophy-candidate-report/List.vue')
  },
  {
    path: 'cip-candidate-report',
    name: prop + '.cip_candidate-report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/cip-candidate-report/List.vue')
  },
  {
    path: 'new-product-report',
    name: prop + '.new_product_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/new-product-report/List.vue')
  },
  {
    path: 'guest-report',
    name: prop + '.guest_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/guest-report/List.vue')
  },
  {
    path: 'new-destination-report',
    name: prop + '.new_destination_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/new-destination-report/List.vue')
  },
  {
    path: 'income-report-export-trophy',
    name: prop + '.income_report_export_trophy',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/income-report-export-trophy/List.vue')
  },
  {
    path: 'income-report-cip',
    name: prop + '.income_report_cip',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/income-report-cip/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/report',
    name: 'export_trophy_cip_service.report',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: circularRoutes('export_trophy_cip_service.report')
  }
]

export default routes
