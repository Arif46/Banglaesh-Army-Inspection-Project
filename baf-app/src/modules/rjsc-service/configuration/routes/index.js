const configurationRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/List.vue')
  },
  {
    path: 'alphabet-wise-role',
    name: prop + '.alphabet_wise_role',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/alphabet-wise-role/List.vue')
  },
  {
    path: 'restricted-word',
    name: prop + '.restricted_word_role_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/restricted-word/List.vue')
  },
  {
    path: 'group-entity',
    name: prop + '.group_entity',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/group-entity/List.vue')
  },
  {
    path: 'name-clearness',
    name: prop + '.name_clearness',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/name-clearness/List.vue')
  },
  {
    path: 'considerable-word',
    name: prop + '.considerable_word',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/considerable-word/List.vue')
  },
  {
    path: 'business-type',
    name: prop + '.business_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/business-type/List.vue')
  },
  {
    path: 'common-fee',
    name: prop + '.common_fee',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-fee/List.vue')
  }
]

const routes = [
  {
    path: '/rjsc-service/configuration',
    name: 'rjsc_service.configuration',
    component: () => import('@/layouts/RjscServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('rjsc_service.configuration')
  }
]

export default routes
