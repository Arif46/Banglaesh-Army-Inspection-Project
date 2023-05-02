const childRoutes = (prop) => [
    {
      path: 'notification-type',
      name: prop + '.notification_type',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/notification-type/List.vue')
    },
    {
      path: 'notification-setup',
      name: prop + '.notification_setup',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/notification-setup/List.vue')
    },
    {
      path: 'circulate-notice',
      name: prop + '.circulate_notice',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/circulate-notice/List.vue')
    },
    {
        path: 'notification-template',
        name: prop + '.notification_template',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/notification-template/List.vue')
    }
]

const routes = [
    {
        path: '/common-service/notification-management',
        name: 'common_service.notification_management',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.notification_management')
    }
]

export default routes
