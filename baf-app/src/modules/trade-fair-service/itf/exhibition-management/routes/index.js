const fairtradeExhibitCircularManagementRoutes = (prop) => [
    {
      path: 'exhibition-circular-list',
      name: prop + '.exhibition_circular_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-circular/List.vue')
    },
    {
      path: 'exhibition-circular-forward-list',
      name: prop + '.exhibition_circular_forward_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-circular/RequestList.vue')
    },
    {
      path: 'exhibition-circular-approved-list',
      name: prop + '.exhibition_circular_approved_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-circular/ApprovalList.vue')
    },
    {
      path: 'exhibition-info-list',
      name: prop + '.exhibition_info_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-information/List.vue')
    },
    {
      path: 'exhibition-info-requested-list',
      name: prop + '.exhibition_info_requested_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-information/ForwardList.vue')
    },
    {
      path: 'exhibition-info-approved-list',
      name: prop + '.exhibition_info_approved_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/exhibition-information/ApprovedList.vue')
    }
  ]

  const routes = [
    {
      path: '/trade-fair-service/itf/exhibition-management',
      name: 'trade_fair_service.em',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: fairtradeExhibitCircularManagementRoutes('trade_fair_service.em')
    }
  ]

  export default routes
