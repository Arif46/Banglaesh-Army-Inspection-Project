const configurationRoutes = (prop) => [
  {
    path: 'menu',
    name: prop + '.menu',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/menu/List.vue')
  },
  {
    path: 'common-page',
    name: prop + '.common_page',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-page/List.vue')
  },
  {
    path: 'notice',
    name: prop + '.notice',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/notice/List.vue')
  },
  {
    path: 'news',
    name: prop + '.news',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/news/List.vue')
  },
  {
    path: 'entity-type',
    name: prop + '.entity_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/entity-type/List.vue')
  },
  {
    path: 'entity-sector',
    name: prop + '.entity_sector',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/entity-sector/List.vue')
  },
  {
    path: 'entity-sub-sector',
    name: prop + '.entity_sub_sector',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/entity-sub-sector/List.vue')
  },
  {
    path: 'law',
    name: prop + '.law',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/law/List.vue')
  },
  {
    path: 'faq',
    name: prop + '.faq',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/faq/List.vue')
  },
  {
    path: 'activity-list',
    name: prop + '.activity_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/activity-list/List.vue')
  },
  {
    path: 'slider',
    name: prop + '.slider',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/slider/List.vue')
  },
  {
    path: 'contact-office',
    name: prop + '.contact_office',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/contact-office/List.vue')
  }
]

const routes = [
  {
    path: '/rjsc-service/admin-portal',
    name: 'rjsc_service.admin_portal',
    component: () => import('@/layouts/RjscServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('rjsc_service.configuration')
  }
]

export default routes
