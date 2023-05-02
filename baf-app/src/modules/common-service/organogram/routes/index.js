const childRoutes = (prop) => [
    {
        path: 'office-type',
        name: prop + '.office_type',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/office-type/List.vue')
    },
    {
        path: 'office',
        name: prop + '.office',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/office-entry/List.vue')
    },
    {
        path: 'designation',
        name: prop + '.designation',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/designation/List.vue')
    },
    {
        path: 'assign-designation',
        name: prop + '.assign_designation',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/assign-designation/List.vue')
    },
    {
        path: 'component-designation',
        name: prop + '.component_designation',
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/component-designation/List.vue')
    }
]

const routes = [
    {
        path: '/common-service/organogram',
        name: 'common_service.organogram',
        component: () => import('@/layouts/CommonServiceLayout.vue'),
        meta: { auth: false },
        children: childRoutes('common_service.organogram')
    }
]

export default routes
