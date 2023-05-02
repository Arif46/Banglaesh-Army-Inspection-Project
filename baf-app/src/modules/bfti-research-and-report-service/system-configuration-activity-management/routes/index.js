const researchAndProposalRoutes = (prop) => [
  {
    path: 'program-management/create-program-info',
    name: prop + '.create_program_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/program-management/create-program-info/List')
  },
  {
    path: 'survey-management/survey-info',
    name: prop + '.survey-info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/survey-management/survey-info/List')
  },
  {
    path: 'report-management/bfti-own-fund-report',
    name: prop + '.bfti_own_fund_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/bfti-own-fund-report/List')
  },
  {
    path: 'report-management/ledger-report',
    name: prop + '.survey-info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/ledger-report/List')
  },
  {
    path: 'report-management/policy-review-document-report',
    name: prop + '.policy_review_document_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/policy-review-document-report/List')
  },
  {
    path: 'report-management/program-report',
    name: prop + '.program_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/program-report/List')
  },
  {
    path: 'report-management/income-expenditure-report',
    name: prop + '.income_expenditure_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/income-expenditure-report/List')
  },
  {
    path: 'report-management/progress-report',
    name: prop + '.progress_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/progress-report/List')
  },
  {
    path: 'report-management/consultant-payment-ledger-report',
    name: prop + '.consultant_payment_ledger_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/consultant-payment-ledger-report/List')
  },
  {
    path: 'report-management/survey-report',
    name: prop + '.survey_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-management/survey-report/List')
  },
  {
    path: 'survey-management/survey-form',
    name: prop + '.survey_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/survey-management/survey-form/List')
  },
  {
    path: 'survey-management/survey-form-create',
    name: prop + '.survey_form_create',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/survey-management/survey-form/createForm')
  },
  {
    path: 'survey-management/survey-form-view',
    name: prop + '.survey_form_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/survey-management/survey-form/viewForm')
  },
  {
    path: 'survey-management/survey-form/receive/:id?',
    name: prop + '.survey_receive_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/survey-management/survey-receive/List')
  },
  {
    path: 'survey-management/survey-form/view/:id?',
    name: prop + '.survey_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('@/modules/external-user-service/views/bfti-panel/pages/survey/View')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/system-configuration-activity-management/',
    name: 'bfti-research-and-report-service.system_configuration_activity_management',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: researchAndProposalRoutes('bfti-research-and-report-service.system-configuration-activity-management')
  }
]

export default routes
