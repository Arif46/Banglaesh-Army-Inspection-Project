const informationTrainingRoutes = (prop) => [
  {
    path: 'business-directory',
    name: prop + '.business_directory',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/business-directory/List.vue')
  },
  {
    path: 'product-directory',
    name: prop + '.product_directory',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/product-directory/List.vue')
  },
  {
    path: 'training-information',
    name: prop + '.training_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/training-information/List.vue')
  },
  {
    path: 'data-trend',
    name: prop + '.data_trend',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/data-trend/List.vue')
  },
  {
    path: 'training-summary',
    name: prop + '.training_summary',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/training-summary/List.vue')
  },
  {
    path: 'content-management',
    name: prop + '.content_management',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/content-management/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/information-training-management',
    name: 'e_biz_management_system_service.information_training_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: informationTrainingRoutes('e_biz_management_system_service.information_training_management')
  }
]

export default routes
