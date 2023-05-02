const childRoutes = (prop) => [
  {
    path: 'document-category',
    name: prop + '.document_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-category/List.vue')
  },
  {
    path: 'add-document',
    name: prop + '.add_document',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/add-document/List.vue')
  },
  {
    path: 'document-indexing',
    name: prop + '.document_indexing',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-indexing/List.vue')
  },
  {
    path: 'document-archive',
    name: prop + '.document_archive',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-archive/List.vue')
  }
]

const routes = [
    {
        path: '/common-service/document-management',
        name: 'common_service.document_management',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.document_management')
    }
]

export default routes
