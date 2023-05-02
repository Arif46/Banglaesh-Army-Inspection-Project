const researchAndProposalRoutes = (prop) => [
  {
    path: 'policy-request-approval/policy-request-entry',
    name: prop + '.policy_request_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/policy-request-approval/policy-request-entry/List')
  },
  {
    path: 'policy-request-approval/receive-policy-request',
    name: prop + '.receive_policy_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/policy-request-approval/receive-policy-request/List')
  },
  {
    path: 'policy-request-approval/policy-approve-reject-list',
    name: prop + '.policy_approve_reject_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/policy-request-approval/policy-approve-reject-list/List')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/policy-advocacy-management-system',
    name: 'bfti-research-and-report-service.policy_advocacy_management_system',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: researchAndProposalRoutes('bfti-research-and-report-service.policy-advocacy-management-system')
  }
]

export default routes
