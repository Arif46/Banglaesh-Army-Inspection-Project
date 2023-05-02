const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'fair-sector',
    name: prop + '.fair_sector',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-sector/List.vue')
  },
  {
    path: 'committee-name',
    name: prop + '.committee_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/committee-name/List.vue')
  },
  {
    path: 'committee-roll',
    name: prop + '.committee_roll',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/committee-roll/List.vue')
  },
  {
    path: 'committee-info-list',
    name: prop + '.committee_info_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/committee-info/List.vue')
  },
  {
    path: 'committee-info-form',
    name: prop + '.committee_info_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/committee-info/Form.vue')
  },
  {
    path: 'stall-category',
    name: prop + '.stall_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-category/List.vue')
  },
  {
    path: 'measurement-unit',
    name: prop + '.measurement_unit',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/measurement-unit/List.vue')
  },
  {
    path: 'subsidy-category',
    name: prop + '.subsidy_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/subsidy-category/List.vue')
  },
  {
    path: 'fair-evaluation-checklist',
    name: prop + '.fair_evaluation_checklist',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-evaluation-checklist/List.vue')
  },
  {
    path: 'checklist-criteria-list',
    name: prop + '.checklist_criteria_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-evaluation-checklist/List.vue')
  },
  {
    path: 'checklist-criteria-form',
    name: prop + '.checklist_criteria_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-evaluation-checklist/Form.vue')
  },
  {
    path: 'stall-category-form',
    name: prop + '.stall_category_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-category/Form.vue')
  },
  {
    path: 'stall-information-list',
    name: prop + '.stall_information_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/stall-information/List.vue')
  },
  {
    path: 'subsidy-information-list',
    name: prop + '.subsidy_information_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/subsidy-information/List.vue')
  },
  {
    path: 'report-heading-list',
    name: prop + '.report_heading_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue')
  },
  {
    path: 'fair-participation-note',
    name: prop + '.fair_participation_note',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fair-participation-note/List.vue')
  }
]

const routes = [
  {
    path: '/trade-fair-service',
    name: 'trade_fair_service',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('trade_fair_service')
  },
  {
    path: '/trade-fair-service/itf/configuration',
    name: 'trade_fair_service.configuration',
    component: () => import('@/layouts/TradeFairServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('trade_fair_service.configuration')
  }
]

export default routes
