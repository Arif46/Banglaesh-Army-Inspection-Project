// ITF Routes
const itfReportRoutes = (prop) => [
  {
    path: 'exhibit-info-report',
    name: prop + '.exhibit_info_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/itf/exhibit-info-report/List.vue')
  },
  {
    path: 'fair-calendar-report',
    name: prop + '.fair_calendar_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/itf/fair-calendar-report/List.vue')
  },
  {
    path: 'applicatipon-report',
    name: prop + '.applicatipon_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/itf/application-report/List.vue')
  },
  {
    path: 'ledger-report',
    name: prop + '.ledger_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/itf/ledger-report/List.vue')
  }
]

// DIFT Routes
const ditfReportRoutes = (prop) => [
  {
    path: 'application-report',
    name: prop + '.application_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/ditf/application-report/List.vue')
  }
]

const routes = [
  {
    path: '/trade-fair-service/itf-report',
    name: 'trade_fair_service.itf_report',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: true },
    children: itfReportRoutes('trade_fair_service.itf_report')
  },
  {
    path: '/trade-fair-service/ditf-report',
    name: 'trade_fair_service.ditf_report',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: true },
    children: ditfReportRoutes('trade_fair_service.ditf_report')
  }
]

export default routes
