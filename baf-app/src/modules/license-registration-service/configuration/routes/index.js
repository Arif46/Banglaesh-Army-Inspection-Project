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
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/config-dashboard/Dashboard.vue')
  },
  {
    path: 'service-name',
    name: prop + '.service_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/service-name/List.vue'),
    props: true
  },
  {
    path: 'step-name',
    name: prop + '.step_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-name/List.vue'),
    props: true
  },
  {
    path: 'step-assign',
    name: prop + '.step_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-assign/List.vue'),
    props: true
  },
  {
    path: 'step-fee-assign',
    name: prop + '.step_fee_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-fee-assign/List.vue'),
    props: true
  },
  {
    path: 'fee-name',
    name: prop + '.fee_name',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/fee-name/List.vue'),
    props: true
  },
  {
    path: 'region',
    name: prop + '.region',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/region/List.vue'),
    props: true
  },
  {
    path: 'step-form',
    name: prop + '.step_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-form/List.vue'),
    props: true
  },
  {
    path: 'service-wise-office-type',
    name: 'service_wise_office_type',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/service-wise-office-type/List.vue')
  },
  {
    path: 'create-form',
    name: 'create_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/step-form/createForm.vue')
  },
  {
    path: 'step-form-view',
    name: prop + '.step_form_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-form/viewForm.vue'),
    props: true
  },
  {
    path: 'form-view-design',
    name: prop + '.step_form_view',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-form-view/List.vue'),
    props: true
  },
  {
    path: 'create-view-form',
    name: prop + '.create_view_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/step-form-view/createForm.vue'),
    props: true
  },
  {
    path: 'step-form-details',
    name: 'step_form_details',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/step-form-view/Details.vue')
  },
  {
    path: 'form-assign',
    name: 'form_assign',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/form-assign/List.vue')
  },
  {
    path: 'step-process',
    name: 'step_process',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/step-process/List.vue')
  },
  {
    path: 'step-process-form',
    name: 'step_process_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/step-process/Form.vue')
  },
  {
    path: 'menu-assign',
    name: 'menu_assign',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/menu-assign/List.vue')
  },
  {
    path: 'auto-gen-num-type',
    name: 'auto_gen_num_type',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/auto-gen-num-type/List.vue')
  },
  {
    path: 'document-builder',
    name: 'document_builder',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/document-builder/List.vue')
  },
  {
    path: 'document-builder-form',
    name: 'document_builder_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/document-builder/createForm.vue')
  },
  {
    path: 'document-builder-form/:id',
    name: 'document-builder_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/document-builder/createForm.vue')
  },
  {
    path: 'document-builder-view',
    name: 'document_builder_view',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/document-builder/viewForm.vue')
  },
  {
    path: 'report-process',
    name: 'report_process',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/report-process/List.vue')
  },
  {
    path: 'report-process-form',
    name: 'report_process_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/report-process/Form.vue')
  },
  {
    path: 'report-heading',
    name: prop + '.report_heading',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-heading/List.vue'),
    props: true
  },
  {
    path: 'report-menu-assign',
    name: 'report_menu_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/report-menu-assign/List.vue')
  },
  {
    path: 'dashboard-card',
    name: 'dashboard_card',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/dashboard-card/List.vue')
  },
  {
    path: 'renew-lost-fee',
    name: 'renew_lost_fee',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/renew-lost-fee/List.vue')
  },
  {
    path: 'org-notes',
    name: 'org_notes',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/org-notes/List.vue')
  },
  {
    path: 'notice',
    name: 'notice',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/notice/List.vue')
  },
  {
    path: 'form-field-assign',
    name: 'form_field_assign',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/form-field-assign/List.vue')
  },
  {
      path: 'form-field-assign-form',
      name: 'form_field_assign-form',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/form-field-assign/Form.vue')
  },
  {
      path: 'received-notifications',
      name: 'received_notifications',
      meta: { auth: true },
      component: () => import('../pages/received-notifications/List.vue')
  },
  {
      path: 'notice',
      name: 'notice',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/notice/List.vue')
  },
  {
    path: 'service-precondition',
    name: '/service_precondition',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/service-precondition/List.vue')
  },
  {
    path: 'service-precondition-form',
    name: '/service_precondition_form',
    meta: {
        auth: true,
        name: 'Editable'
    },
    component: () => import('../pages/service-precondition/Form.vue')
  },
  {
      path: 'ekpay-manage',
      name: 'ekpay_manage',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/ekpay-manage/List.vue')
  },
  {
      path: 'ekpay-challan',
      name: 'ekpay_challan',
      meta: { auth: true, name: 'Editable' },
      component: () => import('../pages/ekpay-challan/List.vue')
  }
]

const tcbconfigurationRoutes = (prop) => [
  {
    path: 'item-category',
    name: prop + '.item_category',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/item-category/List.vue')
  },
  {
    path: 'item',
    name: prop + '.item',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/item/List.vue')
  },
  {
    path: 'warehouse',
    name: prop + '.warehouse',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/warehouse/List.vue')
  },
  {
    path: 'operating-expense',
    name: prop + '.operating-expense',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/operating-expense/List.vue')
  },
  {
    path: 'operating-expense-tax',
    name: prop + '.operating-expense-tax',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/operating-expense-tax/List.vue')
  },
  {
    path: 'faq',
    name: prop + '.faq',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/faq/List.vue')
  },
  {
    path: 'feedback-review',
    name: prop + '.feedback-review',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/feedback-review/List.vue')
  },
  {
    path: 'contract-numbers',
    name: prop + '.contract-numbers',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/contract-numbers/List.vue')
  },
  {
    path: 'user-wise-warehouse',
    name: prop + 'user-wise-warehouse',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/user-wise-warehouse/List.vue')
  },
  {
    path: 'beneficiary-entry',
    name: prop + '.beneficiary_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/beneficiary-entry/List.vue')
  },
  {
    path: 'beneficiary-entry-form',
    name: prop + 'beneficiary_entry_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/beneficiary-entry/Form.vue')
  },
  {
    path: 'beneficiary-information-entry-form',
    name: prop + 'beneficiary_entry_form',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/beneficiary-information-entry/Form.vue')
  },
  {
    path: 'beneficiary-information-entry',
    name: prop + 'beneficiary_information_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/beneficiary-information-entry/List.vue')
  },
  {
    path: 'regional-office-wise-district',
    name: prop + '.regional_office_wise_district',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/regional-office-wise-district/List.vue')
  },
  {
    path: 'dc-office-tax',
    name: prop + './dc_office_tax',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/tcb-configuration/dc-office-tax/List.vue')
  }
]

const routes = [
  {
    path: '/license-registration-service',
    name: 'license_registration_service',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: false },
    children: dashboardRoutes('license_registration_service')
  },
  {
    path: '/license-registration-service/configuration',
    name: 'license_registration_service.configuration',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: true },
    children: configurationRoutes('license_registration_service.configuration')
  },
  {
    path: '/license-registration-service/configuration/tcb-configuration',
    name: 'license_registration_service.tcb_configuration',
    component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
    meta: { auth: true },
    children: tcbconfigurationRoutes('license_registration_service.tcb_configuration')
  }
]

export default routes
