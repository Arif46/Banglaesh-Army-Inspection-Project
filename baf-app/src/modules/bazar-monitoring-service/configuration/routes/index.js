const configurationRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'price-category',
    name: prop + '.price_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-category/List.vue')
  },
  {
    path: 'commodity-group',
    name: prop + '.commodity_group',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/commodity-group/List.vue')
  },
  {
    path: 'price-fluctuation-alert',
    name: prop + '.price_fluctuation_alert',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/price-fluctuation-alert/List.vue')
  },
  {
    path: 'commodity-name',
    name: prop + '.commodity_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/commodity-name/List.vue')
  },
  {
    path: 'law-entry',
    name: prop + '.law_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/law-entry/List.vue')
  },
  {
    path: 'market-directory',
    name: prop + '.market_directory',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-directory/List.vue')
  },
  {
    path: 'market-directory-form',
    name: prop + '.market_directory_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-directory/Form.vue'),
    props: true
  },
  {
    path: 'measurement-unit',
    name: prop + '.measurement_unit',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/measurement-unit/List.vue')
  },
  {
    path: 'section-entry',
    name: prop + '.section_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/section-entry/List.vue')
  },
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue'),
    props: true
  },
  {
    path: 'market-assign',
    name: prop + '.market_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-assign/List.vue'),
    props: true
  },
  {
    path: 'market-assign-form',
    name: prop + '.market_assign_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/market-assign/Form.vue'),
    props: true
  }
]

const routes = [
  {
    path: '/bazar-monitoring-service/configuration',
    name: 'bazar_monitoring_service.configuration',
    component: () => import('@/layouts/BazarMonitoringServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('bazar_monitoring_service.configuration')
  }
]

export default routes
