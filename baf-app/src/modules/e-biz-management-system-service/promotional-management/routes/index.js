const promotionalManagementRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'online-product-advertisement',
    name: prop + '.online_product_advertisement',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/online-product-advertisement/List.vue')
  },
  {
    path: 'promotion-of-events',
    name: prop + '.promotion_of_events',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/promotion-of-events/List.vue')
  },
  {
    path: 'public-relationship-management',
    name: prop + '.public_relationship_management',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/public-relationship-management/List.vue')
  },
  {
    path: 'country-branding',
    name: prop + '.country_branding',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/country-branding/List.vue')
  },
  {
    path: 'sales-kits',
    name: prop + '.sales_kits',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/sales-kits/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/promotional-management',
    name: 'e_biz_management_system_service.promotional_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: promotionalManagementRoutes('e_biz_management_system_service.promotional_management')
  }
]

export default routes
