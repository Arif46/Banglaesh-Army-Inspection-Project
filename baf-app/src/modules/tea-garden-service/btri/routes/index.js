const btbRoutes = (prop) => [
  {
    path: 'test-services',
    name: prop + '.test_services',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/List.vue')
  },
  {
    path: 'test-service-form',
    name: prop + '.test_service_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Form.vue')
  },
  {
    path: 'test-service-form/:id',
    name: prop + '.test_service_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Form.vue')
  },
  {
    path: 'test-service/:id',
    name: prop + '.test_services_view',
    meta: { auth: true },
    props: true,
    component: () => import('../pages/common-services/Details.vue')
  },
  {
    path: 'test-service-received-list',
    name: prop + '.test_service_received_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/ReceivedList.vue')
  },
  // payments routes
  {
    path: 'payment/:id',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Payment.vue')
  },
  {
    path: 'test/payment/success',
    name: prop + '.payment_success',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/PaymentSuccess.vue')
  },
  {
    path: 'test/payment/cancel',
    name: prop + '.payment_cancel',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/PaymentCancel.vue')
  },
  {
    path: 'test/payment/decline',
    name: prop + '.payment_decline',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/PaymentDecline.vue')
  },
  {
    path: 'test-service-forwarded-list',
    name: prop + '.test_service_forwarded_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/ForwardedList.vue')
  },
  {
    path: 'test-service-report-prepare-list',
    name: prop + '.test_service_report_prepare_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/ReportPrepareList.vue')
  },
  {
    path: 'test-service-report-publish-list',
    name: prop + '.test_service_report_publish_list',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/ReportPublishList.vue')
  },
  // for view pages custom design
  {
    path: 'view-1',
    name: prop + '.view1',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Details/file1.vue')
  },
  {
    path: 'view-2',
    name: prop + '.view2',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Details/file2.vue')
  },
  {
    path: 'view-3',
    name: prop + '.view3',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/common-services/Details/file3.vue')
  }
]

const routes = [
  {
    path: '/tea-garden-service/btri',
    name: 'tea_garden_service.btri',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: btbRoutes('tea_garden_service.btri')
  }
]

export default routes
