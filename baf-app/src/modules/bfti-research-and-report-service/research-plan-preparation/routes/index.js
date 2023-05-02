const researchAndPlanRoutes = (prop) => [
  {
    path: 'assign-task-coordinator',
    name: prop + '.assign_task_coordinator',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-task-coordinator/List')
  },
  {
    path: 'prepare-eoi',
    name: prop + '.prepare_eio',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/prepare-eio/List')
  },
  {
    path: 'prepare-eoi/prepare-eoi-form/:id?',
    name: prop + '.prepare_eio',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/prepare-eio/Form')
  },
  {
    path: 'prepare-eoi/prepare-eoi-detail/:id?',
    name: prop + '.prepare_eio',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/prepare-eio/Details')
  },
  {
    path: 'prepare-rfp',
    name: prop + '.prepare_rfp',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/prepare-rfp/List')
  },
  {
    path: 'yearly-action-plan',
    name: prop + '.yearly_action_plan',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/yearly-action-plan/List')
  },
  {
    path: 'received-yearly-action-plan',
    name: prop + '.received_yearly_action_plan',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/received-yearly-action-plan/List')
  },
  {
    path: 'approved-yearly-action-plan',
    name: prop + '.approved_yearly_action_plan',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approved-yearly-action-plan/List')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/research-plan-preparation',
    name: 'bfti-research-and-report-service.research-plan-preparation',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: researchAndPlanRoutes('bfti-research-and-report-service.research-plan-preparation')
  }
]

export default routes
