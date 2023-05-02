const configurationRoutes = (prop) => [
  {
    path: 'business-type',
    name: prop + '.business_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/business-type/List.vue')
  },
  {
    path: 'fair-calendar',
    name: prop + '.fair_calendar',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-calendar/List.vue')
  },
  {
    path: 'stall-category',
    name: prop + '.stall_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-category/List.vue')
  },
  {
    path: 'stall-information',
    name: prop + '.stall_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-information/List.vue')
  },
  {
    path: 'stall-information-form',
    name: prop + '.stall_information_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-information/Form.vue')
  }
]

const routes = [
  {
    path: '/trade-fair-service/ditf/configuration',
    name: 'trade_fair_service.configuration',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('trade_fair_service.configuration')
  }
]

export default routes
