const dashboardRoutes = (prop) => [
  {
      path: 'dashboard',
      name: prop + '.dashboard',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/Dashboard.vue')
  }
]
const configurationRoutes = (prop) => [
  {
    path: 'valley-entry',
    name: prop + '.valley_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/valley-entry/List.vue')
  },
  {
    path: 'service-entry',
    name: prop + '.service_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-entry/List.vue')
  },
  {
    path: 'service-assign',
    name: prop + '.service_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-assign/List.vue')
  },
  {
    path: 'service-assign/form',
    name: prop + '.service_assign_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-assign/Form.vue')
  },
  {
    path: 'factory-type',
    name: prop + '.factory_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/factory-type/List.vue')
  },
  {
    path: 'fertilizer-info',
    name: prop + '.fertilizer_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fertilizer-info/List.vue')
  },
  {
    path: 'circular-type',
    name: prop + '.circular_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular-type/List.vue')
  },
  {
    path: 'fee-type-entry',
    name: prop + '.fee_type_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fee-type-entry/List.vue')
  },
  {
    path: 'fee-assign',
    name: prop + '.fee_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fee-assign/List.vue')
  },
  {
    path: 'service-validity-setup',
    name: prop + '.service_validity_setup',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-validity-setup/List.vue')
  },
  {
    path: 'made-tea-type',
    name: prop + '.made_tea_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/made-tea-type/List.vue')
  },
  {
    path: 'made-tea-grade',
    name: prop + '.made_tea_grade',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/made-tea-grade/List.vue')
  },
  {
    path: 'tea-company',
    name: prop + '.tea_company',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-company/List.vue')
  },
  {
    path: 'bought-leaf-factory',
    name: prop + '.bought_leaf_factory',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/bought-leaf-factory/List.vue')
  },
  {
    path: 'tea-plant-classification',
    name: prop + '.tea_plant_classification',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-plant-classification/List.vue')
  },
  {
    path: 'tree-entry',
    name: prop + '.tree_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tree-entry/List.vue')
  },
  {
    path: 'tea-garden-profile-form',
    name: prop + '.tea_garden_profile_create',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-profile/Form.vue')
  },
  {
    path: 'tea-garden-profile',
    name: prop + '.tea_garden_profile',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-profile/List.vue')
  },
  {
    path: 'tea-garden-profile-view',
    name: prop + '.tea_garde_profile_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-profile/ProfileView.vue')
  },
  {
    path: 'tea-garden-school',
    name: prop + '.tea-garden-school',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-school/List.vue')
  },
  {
    path: 'tea-garden-school-create',
    name: prop + '.tea-garden-school',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-school/Form.vue')
  },
  {
    path: 'tea-garden-school-view',
    name: prop + '.tea-garden-school-view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-school/ProfileView.vue')
  },
  {
    path: 'tea-garden-application-form',
    name: prop + '.tea-garden-application-form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/application-form/TeaGardenApplicationForm.vue')
  },
  {
    path: 'tea-garden-forest-resource-cutting-form',
    name: prop + '.tea-garden-forest-resource-cutting-form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/application-form/ForestResourceCuttingForm.vue')
  },
  {
    path: 'clone-name',
    name: prop + '.clone_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/clone-name/List.vue')
  },
  {
    path: 'brokers-info',
    name: prop + '.brokers_info',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/brokers-info/List.vue')
  },
  {
    path: 'clone-class',
    name: prop + '.clone_class',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/clone-class/List.vue')
  },
  {
    path: 'service-wise-instruction',
    name: prop + '.service_wise_instruction',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-wise-instruction/List.vue')
  },
  {
    path: 'designation',
    name: prop + 'designation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/designation/List.vue')
  },
  {
    path: 'trust-type',
    name: prop + '.trust_type',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/trust-type/List.vue')
  },
  {
    path: 'worker-information',
    name: prop + '.worker_information',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/worker-information/List.vue')
  },
  {
    path: 'sch-season-amount',
    name: prop + '.sch-season-amount',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/sch-season-amount/List.vue')
  },
  {
    path: 'sch-season-amount-create',
    name: prop + '.sch-season-amount-create',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/sch-season-amount/Form.vue')
  },
  {
    path: 'sch-season-amount-view',
    name: prop + '.sch-season-amount-view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/sch-season-amount/Details.vue')
  },
  {
    path: 'plucking-target',
    name: prop + '.plucking-target',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/plucking-target/List.vue')
  },
  {
    path: 'section-entry',
    name: prop + '.section-entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/section-entry/List.vue')
  },
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue')
  },
  {
    path: 'document-signatory',
    name: prop + '.document_signatory',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-signatory/List.vue')
  }
]

const routes = [
  {
    path: '/tea-garden-service',
    name: 'tea_garden_service',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('tea_garden_service')
  },
  {
    path: '/tea-garden-service/configuration',
    name: 'tea_garden_service.configuration',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('tea_garden_service.configuration')
  }
]

export default routes
