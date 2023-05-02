const childRoutes = (prop) => [
    {
        path: 'service-category',
        name: prop + '.service_category',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/service-category/List.vue')
    },
    {
        path: 'ministry-entry',
        name: prop + '.ministry_entry',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/ministry-entry/List.vue')
    },
    {
        path: 'service-customer-type',
        name: prop + '.service_customer_type',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/service-customer-type/List.vue')
    },
    {
        path: 'organization-entry',
        name: prop + '.organization_entry',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/organization-entry/List.vue')
    },
    {
        path: 'service',
        name: prop + '.service',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/service/List.vue')
    },
    {
        path: 'news',
        name: prop + '.news',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/news/List.vue')
    },
    {
        path: 'faq',
        name: prop + '.faq',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/faq/List.vue')
    },
    {
        path: 'notice',
        name: prop + '.notice',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/notice/List.vue')
    },
    {
        path: 'portal-header',
        name: prop + '.portal_header',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/portal-header/List.vue')
    },
    {
        path: 'about-service-portal',
        name: 'about_service_portal',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/about/List.vue')
    }
]

const routes = [
    {
        path: '/common-service/portal',
        name: 'common_service.portal',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.portal')
    }
]

export default routes
