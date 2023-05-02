const BftiResearchExecutionManagementSystemRoutes = (prop) => [
  {
    path: 'research-document/research-document-upload',
    name: prop + '.research_document_upload',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/research-document/research-document-upload/List')
  },
  {
    path: 'received-payment-entry',
    name: prop + '.received_payment_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/received-payment-entry/List')
  },
  {
    path: 'research-document/received-document-list',
    name: prop + '.received_document_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/research-document/received-document-list/List')
  },
  {
    path: 'expenditure-information',
    name: prop + '.expenditure_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/expenditure-information/List')
  },
  {
    path: 'research-document/approved-document-list',
    name: prop + '.approved_document_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/research-document/approved-document-list/List')
  },
  {
    path: 'consultant-payment',
    name: prop + '.consultant_payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/consultant-payment/List')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/research-execution-management',
    name: 'bfti-research-and-report-service.research_execution_management',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: BftiResearchExecutionManagementSystemRoutes('bfti-research-and-report-service.research-execution-management')
  }
]

export default routes
