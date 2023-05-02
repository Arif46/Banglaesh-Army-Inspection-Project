const associationManagementRoutes = (prop) => [
  {
    path: 'association-list',
    name: prop + '.association_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/association-list/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/association-management',
    name: 'e_biz_management_system_service.association_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: associationManagementRoutes('e_biz_management_system_service.association-management')
  }
]

export default routes
