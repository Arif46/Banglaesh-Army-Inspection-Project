const btbRoutes = (prop) => [
  {
    path: 'course',
    name: prop + '.course',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course/List.vue')
  },
  {
    path: 'prepare-circular',
    name: prop + '.prepare_circular',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular/List.vue')
  },
  {
    path: 'circular-request',
    name: prop + '.prepare_circular',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular/RequestList.vue')
  },
  {
    path: 'approve-circular',
    name: prop + '.prepare_circular',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular/ApprovedList.vue')
  },
  {
    path: 'circular/:id',
    name: prop + '.circular_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/circular/View.vue')
  },
  // course management routes
  {
    path: 'course-application',
    name: prop + '.course_application',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/List.vue')
  },
  {
    path: 'course-application-form',
    name: prop + '.course_application_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Form.vue')
  },
  // {
  //   path: 'course-application-view/:id',
  //   name: prop + '.course_application_view',
  //   meta: { auth: true, name: 'Editable' },
  //   component: () => import('../pages/course-management/Details.vue')
  // },
  {
    path: 'course-application-certificate/:id',
    name: prop + '.course_application_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Certificate.vue')
  },
  {
    path: 'course-application-verification-list',
    name: prop + '.course_application_verification_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/VerificationList.vue')
  },
  {
    path: 'course-application-confirmed-list',
    name: prop + '.course_application_confirmed_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/ConfirmedList.vue')
  },
  // payment routes
  {
    path: 'payment/:id',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Payment/Form.vue')
  },
  {
    path: 'test/payment/success',
    name: prop + '.payment_success',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Payment/Success.vue')
  },
  {
    path: 'test/payment/cancel',
    name: prop + '.payment_cancel',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Payment/Cancel.vue')
  },
  {
    path: 'test/payment/decline',
    name: prop + '.payment_decline',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Payment/Decline.vue')
  },
  // reports
  {
    path: 'participant-report',
    name: prop + '.participant_report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/course-management/Report/Participant.vue')
  }
]

const routes = [
  {
    path: '/tea-garden-service/pdu',
    name: 'tea_garden_service.pdu',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: btbRoutes('tea_garden_service.pdu')
  }
]

export default routes
