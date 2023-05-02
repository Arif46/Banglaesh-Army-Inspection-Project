const AllocationManagementDcOfficeRoutes = (prop) => [
  {
    path: 'district-wise-allotment',
    name: prop + '.district_wise_allotment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/district-wise-allotment/List.vue')
  },
  {
    path: 'district-wise-allotment/add',
    name: prop + '.add',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/district-wise-allotment/Form.vue')
  },
  {
    path: 'district-wise-allotment/edit/:id?',
    name: prop + '.edit',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/district-wise-allotment/Edit-form.vue')
  },
  {
    path: 'delivery-order-hq',
    name: prop + '.delivery_order_hq',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/delivery-order-hq/List.vue')
  },
  {
    path: 'delivery-order-hq/add',
    name: prop + '.delivery_order_hq_add',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/delivery-order-hq/Form.vue')
  },
  {
    path: 'delivery-order-hq/edit',
    name: prop + '.delivery_order_hq_edit',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/delivery-order-hq/Form.vue')
  },
  {
    path: 'delivery-entry',
    name: prop + '.delivery_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/delivery-entry/List.vue')
  },
  {
    path: 'assign-warehouse',
    name: prop + '.assign_warehouse',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-warehouse/List.vue')
  },
  {
    path: 'receive-product',
    name: prop + '.receive_product',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/receive-product-hq/List.vue')
  },
  {
    path: 'shortage-order',
    name: prop + '.shortage_order',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/shortage-order-hq/List.vue')
  },
  {
    path: 'shortage-order/delivered',
    name: prop + '.shortage_order_delivered',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/shortage-order-hq/DeliveredList.vue')
  },
  {
    path: 'payment-history',
    name: prop + '.payment_history',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment-history/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service/allocation-management-dc-office/',
    name: 'license_registration_service.allocation_management_dc_office',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: AllocationManagementDcOfficeRoutes('license_registration_service')
  }
]

export default routes
