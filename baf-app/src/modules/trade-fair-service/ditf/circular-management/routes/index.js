const configurationRoutes = (prop) => [
    {
      path: 'prepare-circular',
      name: prop + '.prepare_circular',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/prepare-circular/List.vue')
    },
    {
      path: 'request-circular',
      name: prop + '.request_circular',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/prepare-circular/RequestList.vue')
    },
    {
      path: 'approved-circular',
      name: prop + '.approved_circular',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/prepare-circular/ApprovalList.vue')
    }
  ]
  const routes = [
    {
      path: '/trade-fair-service/ditf/circular-management',
      name: 'trade_fair_service.circular_management',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: configurationRoutes('trade_fair_service.circular_management')
    }
  ]
  export default routes
