const approvalProcessRoutes = (prop) => [
  {
    path: 'applicant-list',
    name: prop + '.applicant_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/applicant-list/List.vue')
  },
  {
    path: 'applicant-request-list',
    name: prop + '.applicant_request_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/applicant-request-list/List.vue')
  },
  {
    path: 'recommendation-list',
    name: prop + '.recommendation_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/recommendation-list/List.vue')
  },
  {
    path: 'recommended-list',
    name: prop + '.recommended_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/recommended-list/List.vue')
  },
  {
    path: 'approved-list',
    name: prop + '.approved_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approved-list/List.vue')
  },
  {
    path: 'rejected-list',
    name: prop + '.rejected_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/rejected-list/List.vue')
  },
  {
    path: 'applicant-list/detail/:service_id/:id',
    name: prop + '.applicant_details',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../../btb/ApplicationDetails/ApplicationDetails.vue')
  }
]

const routes = [
  {
    path: '/tea-garden-service/approval-process',
    name: 'tea_garden_service.approval_process',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: approvalProcessRoutes('tea_garden_service.approval-process')
  }
]

export default routes
