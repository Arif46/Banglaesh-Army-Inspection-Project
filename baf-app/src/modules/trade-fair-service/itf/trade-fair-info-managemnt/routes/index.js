const tradeFairInfoManagementRoutes = (prop) => [
  {
    path: 'fair-calender-circular',
    name: prop + '.fair_calender_circular',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-calender-circular/List.vue')
  },
  {
    path: 'fair-calender-circular-request',
    name: prop + '.fair_calender_circular_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-calender-circular-request/List.vue')
  },
  {
    path: 'approve-fair-calender-circular',
    name: prop + '.approve_fair_calender_circular',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approve-fair-calender-circular/List.vue')
  }
]

const routes = [
  {
    path: '/trade-fair-service/itf/tfim',
    name: 'trade_fair_service.tfim',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: true },
    children: tradeFairInfoManagementRoutes('trade_fair_service.tfim')
  }
]

export default routes
