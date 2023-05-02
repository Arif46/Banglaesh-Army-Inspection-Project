const btbRoutes = (prop) => [
  {
    path: 'tea-farmer-application',
    name: prop + '.received_application',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-farmer-reg/List.vue')
  },
  {
    path: 'tea-farmer-application-form',
    name: prop + '.tea_farmer_application_create',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-farmer-reg/Form.vue')
  },
  {
    path: 'tea-farmer-application-renew-form/:parent_id',
    name: prop + '.tea_farmer_application_renew_create',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-farmer-reg/RenewForm.vue')
  },
  {
    path: 'tea-farmer-application-view/:id',
    name: prop + '.tea_farmer_application_view',
    meta: { auth: true },
    props: true,
    component: () => import('../ApplicationDetails/SmallTeaFarmer/Details.vue')
  },
  {
    path: 'small-farmer-certificate/:id',
    name: prop + '.small_farmer_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/SmallTeaFarmer/Certificate.vue')
  },
  {
    path: 'certificate',
    name: prop + '.certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/Certificate.vue')
  },
  {
    path: 'registration-copy',
    name: prop + '.registration-copy',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/RegistrationCopy.vue')
  },
  {
    path: 'registration',
    name: prop + '.registration',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/Registration.vue')
  },
  {
    path: 'tree-disposal-registration-form',
    name: prop + '.tree_disposal_registration_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tree-disposal-noc/Form.vue')
  },
  {
    path: 'tree-disposal-registration',
    name: prop + '.tree_disposal_registration',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tree-disposal-noc/List.vue')
  },
  {
    path: 'tree-disposal-registration-view/:id',
    name: prop + '.tree_disposal_registration_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/TreeDisposalNoc/Details.vue')
  },
  {
    path: 'tree-disposal-certificate/:id',
    name: prop + '.tree_disposal_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/TreeDisposalNoc/Certificate.vue')
  },
  {
    path: 'return-form1',
    name: prop + '.return-form1',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/ReturnForm1.vue')
  },
  {
    path: 'return-form2',
    name: prop + '.return-form1',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/ReturnForm2.vue')
  },
  {
    path: 'return-form3',
    name: prop + '.return-form1',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/ReturnForm3.vue')
  },
  {
    path: 'factory-registration',
    name: prop + '.factory-registration',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/FactoryRegistration.vue')
  },
  {
    path: 'res-certificate',
    name: prop + '.res-certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/ResCertificate.vue')
  },
  {
    path: 'tea-course1',
    name: prop + '.tea-course1',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/TeaCourse1.vue')
  },
  {
    path: 'tea-tasting',
    name: prop + '.tea-tasting',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/TeaTasting.vue')
  },
  {
    path: 'tpc-course',
    name: prop + '.tpc-course',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/TpcCourse.vue')
  },
  {
    path: 'factory-reg',
    name: prop + '.factory-reg',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/FactoryReg.vue')
  },
  {
    path: 'distribution-report',
    name: prop + '.distribution-report',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/certificates/SeedDistReport.vue')
  },
  {
    path: 'tea-garden-application',
    name: prop + '.tea_garden_application',
    meta: { auth: true },
    component: () => import('../pages/tea-garden-application/List.vue')
  },
  {
    path: 'tea-garden-application-form',
    name: prop + '.tea_garden_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../pages/tea-garden-application/Form.vue')
  },
  {
    path: 'tea-garden-application/:id',
    name: prop + '.tea_garden_application_show',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/TeaGarden/Details.vue')
  },
  {
    path: 'tea-garden-application-certificate/:id',
    name: prop + '.tea_garden_application_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/TeaGarden/Certificate.vue')
  },
  {
    path: 'tea-garden-renew-application-form/:id',
    name: prop + '.tea_garden_renew_application_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tea-garden-application/RenewForm.vue')
  },
  // tea factory applications routes form external panel
  {
    path: 'tea-factory-application',
    name: prop + '.tea_factory_application',
    meta: { auth: true },
    component: () => import('../../../external-user-service/views/tea-garden-panel/pages/tea-factory-application/ListAdmin.vue')
  },
  {
    path: 'tea-factory-application-form',
    name: prop + '.tea_factory_application_form',
    meta: { auth: true },
    props: true,
    component: () => import('../../../external-user-service/views/tea-garden-panel/pages/tea-factory-application/FormAdmin.vue')
  },
  {
    path: 'tea-factory-application-renew-form/:parent_id',
    name: prop + '.tea_factory_application_renew_form',
    meta: { auth: true },
    props: true,
    component: () => import('../../../external-user-service/views/tea-garden-panel/pages/tea-factory-application/RenewFormAdmin.vue')
  },
  {
    path: 'tea-factory-certificate/:id',
    name: prop + '.tea_factory_certificate',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../ApplicationDetails/TeaFactory/Certificate.vue')
  },
  {
    path: 'tea-factory-application-view/:id',
    name: prop + '.tea_factory_application_view',
    meta: { auth: true },
    props: true,
    component: () => import('../ApplicationDetails/TeaFactory/Details')
  },
  // payments routes
  {
    path: 'payment/:id',
    name: prop + '.payment',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Payment/Payment.vue')
  },
  {
    path: 'service/payment/success',
    name: prop + '.payment_success',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Payment/Success.vue')
  },
  {
    path: 'service/payment/cancel',
    name: prop + '.payment_cancel',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Payment/Cancel.vue')
  },
  {
    path: 'service/payment/decline',
    name: prop + '.payment_decline',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/Payment/Decline.vue')
  }
  // payment route end
]

const routes = [
  {
    path: '/tea-garden-service/btb',
    name: 'tea_garden_service.btb',
    component: () => import('@/layouts/TeaGardenServiceLayout.vue'),
    meta: { auth: true },
    children: btbRoutes('tea_garden_service.btb')
  }
]

export default routes
