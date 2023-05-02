const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'specification-info',
    name: prop + '.specification_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/specification-info/List.vue')
  },
  {
    path: 'specification-verify',
    name: prop + '.specification_verify',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/specification-verify/List.vue')
  },
  {
    path: 'specification-verify-form',
    name: prop + '.specification_verify_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/specification-verify/Form.vue')
  },
  {
    path: 'inspection-report',
    name: prop + '.inspection_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/inspection-report/List.vue')
  }
]

const routes = [
  {
    path: '/trade-tariff-service',
    name: 'trade_tariff_service',
    component: () => import('@/layouts/TradeTariffServiceLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('trade_tariff_service')
  },
  {
    path: '/trade-tariff-service/specification',
    name: 'trade_tariff_service.specification',
    component: () => import('@/layouts/TradeTariffServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('trade_tariff_service.specification')
  }
]

export default routes
