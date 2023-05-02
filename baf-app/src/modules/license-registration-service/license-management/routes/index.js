const LicenseRoutes = (prop) => [
  {
    path: 'recruitment-notice',
    name: prop + '.recruitment_notice',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/recruitment-notice/List.vue')
  },
  {
    path: 'application-list',
    name: prop + '.application_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/application-list/List.vue')
  },
  {
    path: 'application-show/:id',
    name: prop + '.application_show',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../components/Details.vue')
  },
  {
    path: 'forward',
    name: prop + '.forward',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../components/Forward.vue')
  },
  {
    path: 'document-verification',
    name: prop + '.document_verification',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/document-verification/List.vue')
  },
  {
    path: 'inspection',
    name: prop + '.inspection',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/inspection/List.vue')
  },
  {
    path: 'approval',
    name: prop + '.approval',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/approval/List.vue')
  },
  {
    path: 'agreement',
    name: prop + '.agreement',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/agreement/List.vue')
  },
  {
    path: 'archive',
    name: prop + '.archive',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/archive/List.vue')
  },
  {
    path: 'payment',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment-list/List.vue')
  },
  {
    path: 'payment/:status',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/payment-list/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service/license-management',
    name: 'license_registration_service.license-management',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: LicenseRoutes('license_registration_service')
  }
]

export default routes
