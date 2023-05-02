const exportTrophyRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'primary-sorting',
    name: prop + '.primary_sorting',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/primary-sorting/List.vue')
  },
  {
    path: 'primary-sorting-applicants',
    name: prop + '.primary_sorting_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/primary-sorting/Applicants.vue')
  },
  {
    path: 'profile-scrutiny-evaluation',
    name: prop + '.profile_scrutiny_evaluation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/profile-scrutiny-evaluation/List.vue')
  },
  {
    path: 'profile-scrutiny-evaluation-applicants',
    name: prop + '.profile_scrutiny_evaluation_applicants',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/profile-scrutiny-evaluation/Applicants.vue')
  },
  {
    path: 'cip-trade',
    name: prop + '.cip_trade',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/cip-trade/List.vue')
  },
  {
    path: 'moc-scrutiny',
    name: prop + '.moc_scrutiny',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/moc-scrutiny/List.vue')
  },
  {
    path: 'bb',
    name: prop + '.bb',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/bb/Form.vue')
  },
  {
    path: 'nbr',
    name: prop + '.nbr',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/nbr/Form.vue')
  },
  {
    path: 'moha',
    name: prop + '.moha',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/moha/Form.vue')
  },
  {
    path: 'moc-scrutiny-applicants',
    name: prop + '.moc_scrutiny_applicants',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/moc-scrutiny/Applicants.vue')
  },
  {
    path: 'profile-verification',
    name: prop + '.profile_verification',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/profile-verification/List.vue')
  },
  {
    path: 'profile-verification-applicants',
    name: prop + '.profile_verification_applicants',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/profile-verification/Applicants.vue')
  },
  {
    path: 'moc-committee-approval',
    name: prop + '.moc_committee_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/moc-committee-approval/List.vue')
  },
  {
    path: 'approval-request',
    name: prop + '.approval_request',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approval-request/List.vue')
  },
  {
    path: 'cabinet-committee-approval',
    name: prop + '.cabinet_committee_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/cabinet-committee-approval/List.vue')
  },
  {
    path: 'pmo-approval',
    name: prop + '.pmo_approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/pmo-approval/List.vue')
  },
  {
    path: 'final-list',
    name: prop + '.final_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/final-list/List.vue')
  },
  {
    path: 'rejected',
    name: prop + '.rejected',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/rejected/List.vue')
  },
  {
    path: 'cip-trade-rejected',
    name: prop + '.cip_trade_rejected',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/cip-trade-rejected/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/cip',
    name: 'export_trophy_cip_service.cip',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    children: exportTrophyRoutes('export_trophy_cip_service.cip')
  }
]

export default routes
