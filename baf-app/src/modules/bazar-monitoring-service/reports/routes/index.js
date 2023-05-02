const priceMonitoringRoutes = (prop) => [
  {
    path: 'market-directory-report',
    name: prop + '.market_directory_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-directory-report/List.vue')
  },
  {
    path: 'fine-report',
    name: prop + '.fine_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fine-report/List.vue')
  },
  {
    path: 'market-wise-price-report',
    name: prop + '.market_wise_price_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-wise-price-report/List.vue')
  },
  {
    path: 'commodity-wise-price-report',
    name: prop + '.commodity_wise_price_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/commodity-wise-price-report/List.vue')
  },
  {
    path: 'price-fluctuation-report',
    name: prop + '.commodity_wise_price_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-fluctuation-report/List.vue')
  },
  {
    path: 'consolidated-price-report',
    name: prop + '.consolidated_price_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/consolidated-price-report/List.vue')
  },
  {
    path: 'market-comparison-report',
    name: prop + '.market_comparison_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-comparison-report/List.vue')
  },
  {
    path: 'price-average-report',
    name: prop + '.price_average_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-average-report/List.vue')
  }
]

const routes = [
  {
    path: '/bazar-monitoring-service/reports',
    name: 'bazar_monitoring_service.reports',
    component: () => import('@/layouts/BazarMonitoringServiceLayout.vue'),
    meta: { auth: true },
    children: priceMonitoringRoutes('bazar_monitoring_service.reports')
  }
]

export default routes
