const LicenseStepRoutes = (prop) => [
    {
        path: 'steps/:id',
        name: 'steps',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/List.vue')
    },
    {
        path: 'archive/:id',
        name: 'Archive',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/archive/List.vue')
    },
    {
        path: 'reports/:id',
        name: 'reports',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/report/List.vue')
    },
    {
        path: 'approve-reject',
        name: 'approve_reject',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../components/common/approveReject.vue')
    },
    {
        path: 'forward',
        name: 'forward',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../components/common/Forward.vue')
    },
    {
        path: 'approve-issue',
        name: 'approve_issue',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/ApproveIssueFromDetails.vue')
    },
    {
        path: 'preview',
        name: 'preview',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/DocumentPreviewfromDetails.vue')
    },
    {
        path: 'application-form',
        name: 'application_form',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/AppForm.vue')
    },
    {
        path: 'action-form',
        name: 'action_form',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/action-component/ActionMain.vue')
    },
    {
        path: 'document-view',
        name: 'document_view',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/DocumentView.vue')
    },
    {
        path: 'app-detail',
        name: 'app_detail',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/DetailsMain.vue')
    },
    {
        path: 'edit-form',
        name: 'edit_form',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/AppEdit.vue')
    },
    {
        path: 'transfer',
        name: 'transfer',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/Transfer.vue')
    },
    {
        path: 'transfer-list',
        name: 'transfer_list',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/TransferList.vue')
    },
    {
        path: 'cancel-list',
        name: 'cancel_list',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/CancelList.vue')
    },
    {
        path: 'withdraw-list',
        name: 'withdraw_list',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/WithdrawList.vue')
    },
    {
        path: 'numerical-report',
        name: 'numerical_report',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/NumericalReport.vue')
    },
    {
        path: 'payment-list',
        name: 'payment_list',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/payment-report/PaymentList.vue')
    },
    {
        path: 'challan-report',
        name: 'challan_report',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/steps/challan-report/index.vue')
    },
    {
        path: 'expiration-active-passed-report',
        name: 'expiration_active_passed_report',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/report/expiration-passed-report/List.vue')
    },
    {
        path: 'application-entry',
        name: 'application_entry',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/application-entry/List.vue')
    },
    {
        path: 'application-form-entry',
        name: 'application_form_entry',
        props: true,
        meta: { auth: true, name: 'Editable' },
        component: () => import('../pages/application-entry/Form.vue')
    }
]

const routes = [
    {
      path: '/license-registration-service/license-step/',
      name: 'license_registration_service.license-step',
      component: () => import('@/layouts/LicenseRegistrationServiceLayout.vue'),
      meta: { auth: false },
      children: LicenseStepRoutes('license_registration_service')
    }
  ]

export default routes
