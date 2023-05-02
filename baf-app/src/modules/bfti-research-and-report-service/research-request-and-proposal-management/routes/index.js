const researchAndProposalRoutes = (prop) => [
  {
    path: 'research-request',
    name: prop + '.research_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/research-and-other-request/List')
  },
  {
    path: 'received-research-request',
    name: prop + '.received_research_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/received-research-and-other-request/List')
  },
  {
    path: 'approved-research-request',
    name: prop + '.approved_research_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approved-research-and-other-request/List')
  },
  {
    path: 'contract-signing-info',
    name: prop + '.contract_signing_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/contract-signing-info/List')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/research-request-proposal-management',
    name: 'bfti-research-and-report-service.research-request-proposal-management',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: researchAndProposalRoutes('bfti-research-and-report-service.research-request-proposal-management')
  }
]

export default routes
