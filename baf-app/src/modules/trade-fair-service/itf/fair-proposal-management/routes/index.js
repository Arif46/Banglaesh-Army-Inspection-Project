const fairProposalManagementRoutes = (prop) => [
    {
      path: 'collect-fair-calendar',
      name: prop + '.collect_fair_calendar',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/collect-fair-calendar/List.vue')
    },
    {
      path: 'fair-calendar-info-form',
      name: prop + '.fair_calendar_info_form',
      meta: { auth: true },
      component: () => import('../pages/collect-fair-calendar/Form.vue')
    },
    {
      path: 'collected-fair-calendars-fiscal-year-circular-wise',
      name: prop + '.collected_fair_calendars_fiscal_circular_wise',
      meta: { auth: true },
      component: () => import('../pages/collect-fair-calendar/ListFiscalCircularWise.vue')
    },
    {
      path: 'request-fair-proposal',
      name: prop + '.request_fair_proposal',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/collect-fair-calendar/RequestList.vue')
    },
    {
      path: 'approval-fair-proposal',
      name: prop + '.approval_fair_proposal',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/collect-fair-calendar/ApprovalList.vue')
    }
  ]

  const routes = [
    {
      path: '/trade-fair-service/itf/fair-proposal-management',
      name: 'trade_fair_service.fpm',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: fairProposalManagementRoutes('trade_fair_service.fpm')
    }
  ]

  export default routes
