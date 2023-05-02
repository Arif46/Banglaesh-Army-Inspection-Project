const LicenseRoutes = (prop) => [
  {
    path: 'existing-dealer-entry',
    name: prop + '.existing_dealer_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/existing-dealer-entry/List.vue')
  },
  {
    path: 'existing-dealer-entry/create',
    name: prop + '.create',
    meta: { auth: true },
    component: () => import('../pages/existing-dealer-entry/CreateDealer.vue')
  },
  {
    path: 'renew-agreement',
    name: prop + '.renew_agreement',
    meta: { auth: true },
    component: () => import('../pages/renew-agreement/List.vue')
  },
  {
    path: 'existing-dealer-entry/edit/:id',
    name: prop + '.edit',
    meta: { auth: true },
    props: true,
    component: () => import('../pages/existing-dealer-entry/CreateDealer.vue')
  },
  {
    path: 'complain',
    name: prop + '.complain',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/complain/List.vue')
  }
]
const routes = [
  {
    path: '/license-registration-service/manage-information',
    name: 'license_registration_service.manage-information',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: LicenseRoutes('license_registration_service')
  }
]

export default routes
