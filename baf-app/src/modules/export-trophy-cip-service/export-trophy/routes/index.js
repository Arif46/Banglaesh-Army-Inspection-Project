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
    path: 'scrutiny-evaluation-applicants',
    name: prop + '.scrutiny_evaluation_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/profile-scrutiny-evaluation/Applicants.vue')
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
    props: true,
    component: () => import('../pages/moc-scrutiny/Applicants.vue')
  },
  {
    path: 'profile-verification',
    name: prop + '.profile_verification',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/profile-verification/List.vue')
  },
  {
    path: 'profile-verification-applicants',
    name: prop + '.profile_verification_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/profile-verification/Applicants.vue')
  },
  {
    path: 'moc-committee-approval',
    name: prop + '.moc_committee_approval',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/moc-committee-approval/List.vue')
  },
  {
    path: 'moc-committee-approval-applicants',
    name: prop + '.moc_committee_approval_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/moc-committee-approval/Applicants.vue')
  },
  {
    path: 'pmo-approval-request',
    name: prop + '.pmo_approval_request',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/pmo-approval-request/List.vue')
  },
  {
    path: 'pmo-approval-request-applicants',
    name: prop + '.pmo_approval_request_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/pmo-approval-request/Applicants.vue')
  },
  {
    path: 'pmo-approval',
    name: prop + '.pmo_approval',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/pmo-approval/List.vue')
  },
  {
    path: 'pmo-approval-applicants',
    name: prop + '.pmo_approval_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/pmo-approval/Applicants.vue')
  },
  {
    path: 'final-list',
    name: prop + '.final_list',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/final-list/List.vue')
  },
  {
    path: 'final-list-applicants',
    name: prop + '.final_list_applicants',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/final-list/Applicants.vue')
  },
  {
    path: 'reject-application-list',
    name: prop + '.reject_application_list',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/reject-application-list/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/export-trophy',
    name: 'export_trophy_cip_service.export_trophy',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: exportTrophyRoutes('export_trophy_cip_service.export_trophy')
  }
]

export default routes
