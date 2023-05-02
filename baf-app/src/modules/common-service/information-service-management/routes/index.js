const childRoutes = (prop) => [
    {
        path: 'service-eligibility-type',
        name: prop + '.service_eligibility_type',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/service-eligibility-type/List.vue')
    }
]

const routes = [
    {
        path: '/common-service/information-service-management',
        name: 'common_service.information_service_management',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.information_service_management')
    }
]

export default routes
