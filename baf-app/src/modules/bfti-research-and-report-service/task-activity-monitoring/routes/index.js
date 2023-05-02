const taskActivityMonitoring = (prop) => [
  {
    path: 'activity-monitoring',
    name: prop + '.taskMonitoring',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task-monitoring/List')
  },
  {
    path: 'activity-monitoring/from/:id?',
    name: prop + '.taskMonitoringForm',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task-monitoring/Form')
  },
  {
    path: 'checklist',
    name: prop + '.checklist',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/checklist/List')
  },
  {
    path: 'checklist/from/:id?',
    name: prop + '.checklist_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/checklist/Form')
  },
  {
    path: 'checklist/detail/:id?',
    name: prop + '.checklist_detail',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/checklist/Details')
  },
  {
    path: 'checklist-received',
    name: prop + '.checklistReceived',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/checklist-received/List')
  },
  {
    path: 'assign-consultant/from/:id?',
    name: prop + '.cassign_consultant',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-consultant/Form')
  },
  {
    path: 'assign-consultant/detail/:id?',
    name: prop + '.assign_consultant',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-consultant/Detail')
  },
  {
    path: 'assign-consultant',
    name: prop + '.assign_consultant',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/assign-consultant/List')
  },
  {
    path: 'approved-checklist',
    name: prop + '.checklistApproved',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/checklist-approved/List')
  },
  {
    path: 'task',
    name: prop + '.Task',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task/List')
  },
  {
    path: 'task/detail/:id?',
    name: prop + '.TaskDetails',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/task/TaskDetails')
  }
]

const routes = [
  {
    path: '/bfti-research-and-report-service/task-activity-monitoring',
    name: 'bfti-research-and-report-service.task_activity_monitoring',
    component: () => import('@/layouts/BftiResearchAndReportServiceLayout.vue'),
    meta: { auth: true },
    children: taskActivityMonitoring('bfti-research-and-report-service.task-activity-monitoring')
  }
]

export default routes
