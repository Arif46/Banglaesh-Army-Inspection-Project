const TcbReportRoutes = (prop) => [
  {
    path: 'monthly-report',
    name: prop + '.monthly_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/monthly-report/List.vue')
  },
  {
    path: 'monthly-report-region',
    name: prop + '.monthly_report_region',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/monthly-report-region/List.vue')
  },
  {
    path: 'daily-stock-report-hq',
    name: prop + '.daily_stock_report_hq',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/daily-stock-report-hq/List.vue')
  },
  {
    path: 'daily-stock-report-regional',
    name: prop + '.daily_stock_report_regional',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/daily-stock-report-regional/List.vue')
  },
  {
    path: 'yearly-report',
    name: prop + '.yearly_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/yearly-report/List.vue')
  },
  {
    path: 'dealer-report',
    name: prop + '.dealer_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dealer-report/List.vue')
  },
  {
    path: 'beneficiary-report',
    name: prop + '.dealer_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/beneficiary-report/List.vue')
  },
  {
    path: 'yearly-report-region',
    name: prop + '.yearly_report_region',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/yearly-report-region/List.vue')
  },
  {
    path: 'allocation-report',
    name: prop + '.allocation_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allocation-report/List.vue')
  },
  {
    path: 'payment-report',
    name: prop + '.payment_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment-report/List.vue')
  },
  {
    path: 'product-wise-monthly-report',
    name: prop + '.payment_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/product-wise-monthly-report/List.vue')
  },
  {
    path: 'product-transfer-report',
    name: prop + '.product_transfer_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/product-transfer-report/List.vue')
  },
  {
    path: 'payment-report-dc-office',
    name: prop + '.payment_report_dc_office',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment-report-dc-office/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service/tcb-report',
    name: 'license_registration_service.tcb_report',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: TcbReportRoutes('license_registration_service')
  }
]

export default routes
