const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/dashboard/Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'area-of-interest',
    name: prop + '.area_of_interest',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/area-of-interest/List.vue')
  },
  {
    path: 'resource-pool',
    name: prop + '.resource_pool',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/resource-pool/List.vue')
  },
  {
    path: 'document-type',
    name: prop + '.document_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-type/List.vue')
  },
  {
    path: 'organization-type',
    name: prop + '.organization_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/organization-type/List.vue')
  },
  {
    path: 'organization-sub-type',
    name: prop + '.organization_sub_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/organization-sub-type/List.vue')
  },
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/config-dashboard/Dashboard.vue')
  },
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue'),
    props: true
  },
  {
    path: 'program-type',
    name: prop + '.program_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/program-type/List.vue'),
    props: true
  },
  {
    path: 'stakeholder-information',
    name: prop + '.stakeholder_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stakeholder-information/List.vue'),
    props: true
  },
  {
    path: 'organization-name',
    name: prop + '.organization_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/organization-name/List.vue'),
    props: true
  },
  {
    path: 'task-heading',
    name: prop + '.task_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task-heading/List.vue'),
    props: true
  },
  {
    path: 'task-sub-heading',
    name: prop + '.task_sub_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task-sub-heading/List.vue'),
    props: true
  },
  {
    path: 'budget-installment',
    name: prop + '.budget_installment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/budget-installment-info/List.vue'),
    props: true
  },
  {
    path: 'expenditure-head',
    name: prop + '.task_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/expenditure-head-info/List.vue'),
    props: true
  },
  {
    path: 'task-alert',
    name: prop + '.task_alert',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task-alert/List.vue'),
    props: true
  },
  {
    path: 'holiday',
    name: prop + '.holiday',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/holiday/List.vue'),
    props: true
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
    path: '/bfti-research-and-report-service/configuration',
    name: 'bfti-research-and-report-service.configuration',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('bfti-research-and-report-service.configuration')
  }
]

export default routes
