const AllocationManagementRoutes = (prop) => [
  {
    path: 'allotment-order-ministry',
    name: prop + '.allotment_order_ministry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allotment-order-ministry/List.vue')
  },
  {
    path: 'allotment-order-ministry/order-entry',
    name: prop + '.order_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allotment-order-ministry/Form.vue')
  },
  {
    path: 'allotment-order-hq',
    name: prop + '.allotment_order_hq',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allotment-order-hq/List.vue')
  },
  {
    path: 'allocation-process',
    name: prop + '.allocation_process',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allocation-process/List.vue')
  },
  {
    path: 'allocation-process-form/:id',
    name: prop + '.allocation_process_form',
    props: true,
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/allocation-process/Form.vue')
  },
  {
    path: 'pending-allocation-list',
    name: prop + '.pending_allocation_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/pending-allocation-list/List.vue')
  },
  {
    path: 'paid-allocation-list',
    name: prop + '.paid_allocation_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/paid-allocation-list/List.vue')
  },
  {
    path: 'distributions',
    name: prop + '.distributions',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/distribution/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service/allocation-management/',
    name: 'license_registration_service.allocation_management',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: AllocationManagementRoutes('license_registration_service')
  }
]

export default routes
