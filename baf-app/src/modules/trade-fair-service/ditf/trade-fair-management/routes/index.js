const tradeFairManageRoutes = (prop) => [
    {
      path: 'receive-application',
      name: prop + '.receive_application',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/app-manage/ReceiveList.vue')
    },
    {
      path: 'approve-application',
      name: prop + '.approve_application',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/app-manage/ApproveList.vue')
    }
  ]
  const routes = [
    {
      path: '/trade-fair-service/ditf/trade-fair-management',
      name: 'trade_fair_service.trade_fair_management',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: tradeFairManageRoutes('trade_fair_service.trade_fair_management')
    }
  ]
  export default routes
