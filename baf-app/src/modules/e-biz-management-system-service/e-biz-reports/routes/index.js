const eBizReportRoutes = (prop) => [
  {
    path: 'year-wise-budget-approve-reports',
    name: prop + '.year_wise_budget_approve_reports',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/year-wise-budget-approve-report/List.vue')
  },
  {
    path: 'monitoring-report',
    name: prop + '.monitoring_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/monitoring-report/List.vue')
  },
  {
    path: 'project-closure-report',
    name: prop + '.project_closure_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/project-closure-report/List.vue')
  },
  {
    path: 'periodical-report',
    name: prop + '.periodical_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/periodical-report/List.vue')
  },
  {
    path: 'evaluation-report',
    name: prop + '.evaluation_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/evaluation-report/List.vue')
  },
  {
    path: 'financial-report',
    name: prop + '.financial_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/financial-report/List.vue')
  },
  {
    path: 'workshop-closure-report',
    name: prop + '.financial_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/workshop-closure-report/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/e-biz-reports',
    name: 'e_biz_management_system_service.e_biz_reports',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: eBizReportRoutes('e_biz_management_system_service.e-biz-reports')
  }
]

export default routes
