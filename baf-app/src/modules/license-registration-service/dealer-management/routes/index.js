const StockManagementRoutes = (prop) => [
  {
    path: 'stock-management/stock-in',
    name: prop + '.stock_in',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stock-management/stock-in/List.vue')
  },
  {
    path: 'stock-management/stock-out',
    name: prop + '.stock_out',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stock-management/stock-out/List.vue')
  },
  {
    path: 'stock-management/inter-warehouse-transfers',
    name: prop + '.inter_warehouse_transfers',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stock-management/inter-warehouse-transfers/List.vue')
  },
  {
    path: 'stock-management/inter-warehouse-product-receive',
    name: prop + '.inter_warehouse_product_receive',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stock-management/inter-warehouse-product-receive/List.vue')
  },
  {
    path: 'manage-information/dealer-penalty',
    name: prop + '.dealer_penalty',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dealer-penalty/List.vue')
  },
  {
    path: 'manage-information/dealer-deduct',
    name: prop + '.dealer_deduct',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../components/deduct.vue')
  },
  {
    path: 'stock-management/stock-out-approval',
    name: prop + '.stock_out_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stock-management/stock-out-approval/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service/dealer-management/',
    name: 'license_registration_service.stock_management',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: StockManagementRoutes('license_registration_service')
  }
]

export default routes
