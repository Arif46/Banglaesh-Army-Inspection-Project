const fairPartiPaymentManagementRoutes = (prop) => [
    {
      path: 'parti-payment-info-list',
      name: prop + '.parti_payment_info_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/parti-payment-info/List.vue')
    },
    {
      path: 'approved-participation-list',
      name: prop + '.approved_participation_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/approved-participation/List.vue')
    },
    {
      path: 'rejected-participation-list',
      name: prop + '.rejected_participation_list',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/rejected-participation/List.vue')
    },
    {
      path: 'visa-processing',
      name: prop + '.visa_processing',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/visa-processing/List.vue')
    }
  ]

  const routes = [
    {
      path: '/trade-fair-service/itf/fair-parti-management',
      name: 'fair_parti_management.fpm',
      component: () => import('@/layouts/TradeFairServiceLayout.vue'),
      meta: { auth: true },
      children: fairPartiPaymentManagementRoutes('fair_parti_management.fpm')
    }
  ]

  export default routes
