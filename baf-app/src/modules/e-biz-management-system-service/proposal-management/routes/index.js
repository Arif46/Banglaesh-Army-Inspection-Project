const proposalManagementRoutes = (prop) => [
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'budget-entry',
    name: prop + '.budget_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/budget-entry/List.vue')
  },
  {
    path: 'add-budget-entry',
    name: prop + '.add_budget_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/budget-entry/Form.vue')
  },
  {
    path: 'edit-budget-entry/:id?',
    name: prop + '.edit-budget-entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/budget-entry/Form.vue')
  },
  {
    path: 'circular-notice-for-rfp',
    name: prop + '.circular_notice_for_rfp',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular-notice/List.vue')
  },
  {
    path: 'proposal-list',
    name: prop + '.proposal_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/proposal-list/List.vue')
  },
  {
    path: 'proposal-top-sheet',
    name: prop + '.proposal',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/proposal-top-sheet/List.vue')
  },
  {
    path: 'approve-proposal',
    name: prop + '.proposal',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approve-proposal/List.vue')
  }
]

const routes = [
  {
    path: '/e-biz-management-system-service/proposal-management',
    name: 'e_biz_management_system_service.proposal_management',
    component: () => import('@/layouts/EBizManagementSystemLayout.vue'),
    meta: { auth: true },
    children: proposalManagementRoutes('e_biz_management_system_service.proposal_management')
  }
]

export default routes
