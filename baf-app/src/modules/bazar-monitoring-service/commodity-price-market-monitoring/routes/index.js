const priceMonitoringRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'market-inspection-report',
    name: prop + '.market_inspection_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-inspection-report/List.vue')
  },
  {
    path: 'price-entry',
    name: prop + '.price_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-entry/List.vue')
  },
  {
    path: 'fine-receipt',
    name: prop + '.fine_receipt',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fine-receipt/List.vue')
  },
  {
    path: 'fine-receipt-form',
    name: prop + '.fine_receipt_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fine-receipt/Form.vue'),
    props: true
  },
  {
    path: 'form/:id?',
    name: prop + '.form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-entry/Form.vue')
  },
  {
    path: 'detail/:id?',
    name: prop + '.detail',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-entry/Details.vue')
  },
  {
    path: 'price-publish-detail/:id?',
    name: prop + '.detail',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-publish/Details.vue')
  },
  {
    path: 'price-publish',
    name: prop + '.price_publish',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-publish/List.vue')
  },
  {
    path: 'price-trend',
    name: prop + '.price_trend',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-trend/List.vue')
  },
  {
    path: 'daily-price-chart',
    name: prop + '.daily_price_chart',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/daily-price-chart/List.vue')
  }
]

const routes = [
  {
    path: '/bazar-monitoring-service/commodity-price-market-monitoring',
    name: 'bazar_monitoring_service.commodity_price_market_monitoring',
    component: () => import('@/layouts/BazarMonitoringServiceLayout.vue'),
    meta: { auth: true },
    children: priceMonitoringRoutes('bazar_monitoring_service.commodity_price_market_monitoring')
  }
]

export default routes
