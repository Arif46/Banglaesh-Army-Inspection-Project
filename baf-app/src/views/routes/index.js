const childRoutes = (prop) => [
    {
      path: 'table',
      name: prop + '.table',
      meta: { auth: false, name: 'Editable' },
      component: () => import('../ui-elements/Table.vue')
    }
]

const routes = [
    {
      path: '/ui-element',
      name: 'ui_element',
      component: () => import('@/layouts/AuthLayout.vue'),
      meta: { auth: false },
      children: childRoutes('ui_element')
    }
]

export default routes
