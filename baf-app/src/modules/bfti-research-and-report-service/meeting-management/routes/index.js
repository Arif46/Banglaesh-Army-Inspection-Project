const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'create-meeting',
    name: prop + '.create_meeting',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/create-meeting/List.vue')
  },
  {
    path: 'receive-meeting-notice',
    name: prop + '.receive_meeting_notice',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/receive-meeting-notice/List.vue')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service',
    name: 'bfti-research-and-report-service',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('bfti-research-and-report-service')
  },
  {
    path: '/bfti-research-and-report-service/meeting-management',
    name: 'bfti-research-and-report-service.meeting-management',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('bfti-research-and-report-service.meeting-management')
  }
]

export default routes
