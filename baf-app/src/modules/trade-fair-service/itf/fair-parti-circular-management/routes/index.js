const fairParticipationManagementRoutes = (prop) => [
    {
      path: 'circular-fair-participation-list',
      name: prop + '.circular_fair_participation_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/circular-fair-participation/List.vue')
    },
    {
      path: 'fair-parti-circular-forward-list',
      name: prop + '.fair_parti_circular_forward_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/circular-fair-participation/RequestList.vue')
    },
    {
      path: 'fair-parti-circular-approve-list',
      name: prop + '.fair_parti_circular_approve_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/circular-fair-participation/ApprovalList.vue')
    }
  ]

  const routes = [
    {
      path: '/trade-fair-service/itf/fair-parti-circular-management',
      name: 'trade_fair_service.fpcm',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: fairParticipationManagementRoutes('trade_fair_service.fpcm')
    }
  ]

  export default routes
