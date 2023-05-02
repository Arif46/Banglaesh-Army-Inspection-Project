const btbRoutes = (prop) => [
  {
    path: 'btb-one',
    name: prop + 'btb-one',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtbOne.vue')
  },
  {
    path: 'tree-disposal',
    name: prop + '.tree-disposal',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/TreeDisposalDashboard.vue')
  },
  {
    path: 'btb-garden-service',
    name: prop + 'btb-three',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtbGardenServiceDashboard.vue')
  },
  {
    path: 'small-tea-farmer',
    name: prop + '.small-tea-farmer',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/SmallTeaFarmerDashboard.vue')
  },
  {
    path: 'tea-factory-dashboard',
    name: prop + 'tea-factory-dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/TeaFactoryDashboard.vue')
  },
  {
    path: 'btb-six',
    name: prop + 'btb-six',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtbSix.vue')
  },
  {
    path: 'btri-one',
    name: prop + 'btri-one',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtriOne.vue')
  },
  {
    path: 'btri-two',
    name: prop + 'btri-two',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtriTwo.vue')
  },
  {
    path: 'btri-test-services',
    name: prop + '.btri-test-services',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtriTestDashboard.vue')
  },
  {
    path: 'btri-four',
    name: prop + 'btri-four',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtriFour.vue')
  },
  {
    path: 'btri-five',
    name: prop + 'btri-five',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/BtriFive.vue')
  },
  {
    path: 'education-trust-scholarship',
    name: prop + 'education-trust-scholarship',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/pdu/EducationTrustScholarship.vue')
  },
  {
    path: 'professional-course-management',
    name: prop + '.professional_course_management',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/pdu/ProfessionalCourseManagement.vue')
  },
  {
    path: 'regular-garden-inspection',
    name: prop + 'regular-garden-inspection',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/dashboard/pdu/RegularGardenInspection.vue')
  }
]

const routes = [
  {
    path: '/tea-garden-service/dashboard',
    name: 'tea_garden_service.dashboard',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: btbRoutes('tea_garden_service.dashboard')
  }
]

export default routes
