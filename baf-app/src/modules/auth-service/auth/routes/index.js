const authChildRoutes = (prop) => [
  {
    path: 'login',
    name: prop + '.login',
    meta: { auth: false, name: 'Editable' },
    component: () => import('../pages/Login.vue')
  },
  {
    path: 'nothi-login-process',
    name: prop + '.nothi_login_process',
    meta: { auth: false },
    component: () => import('../pages/NothiLoginProcess.vue')
  },
  {
    path: 'sign-up',
    name: prop + '.sign_up',
    meta: { name: 'Editable' },
    component: () => import('../pages/SignUp.vue')
  },
  {
    path: 'otp/:id',
    name: prop + '.reg-otp',
    meta: { auth: false },
    component: () => import('../pages/Otp.vue')
  },
  {
    path: 'sign-up-success',
    name: prop + '.sign_up_success',
    meta: { auth: false },
    component: () => import('../pages/Sign-up-success.vue')
  },
  {
    path: 'forgot-password/otp-sending',
    name: prop + '.forgot_password.otp_sending',
    meta: { name: 'Editable' },
    component: () => import('../pages/ForgotPassword.vue')
  },
  {
    path: 'forgot-password/otp-verification',
    name: prop + '.forgot_password.otp_verification',
    meta: { auth: false },
    props: true,
    component: () => import('../pages/ForgotPasswordOtpVerification.vue')
  },
  {
    path: 'forgot-password/reset-password',
    name: prop + '.forgot_password.reset_password',
    meta: { auth: false },
    props: true,
    component: () => import('../pages/ForgotPasswordResetPassword.vue')
  },
  {
    path: 'dashboard',
    name: prop + '.dashboard',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/Dashboard.vue')
  },
  {
    path: 'role-select',
    name: prop + '.role_select',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/RoleSelect.vue')
  },
  {
    path: 'external-menus',
    name: prop + '.external_menus',
    meta: { auth: true, name: 'Editable' },
    props: true,
    component: () => import('../pages/MenuLoadExternal.vue')
  }
]

const passwordChangeChildRoutes = (prop) => [
  {
    path: 'change-password',
    name: prop + '.change_password',
    meta: { auth: true },
    component: () => import('../pages/ChangePassword.vue')
  }
]

const routes = [
  {
    path: '/auth',
    name: 'auth',
    component: () => import('@/layouts/AuthLayout.vue'),
    meta: { auth: true },
    children: authChildRoutes('auth')
  },
  {
    path: '/security',
    name: 'security',
    component: () => import('@/layouts/CommonServiceLayout'),
    meta: { auth: true },
    children: passwordChangeChildRoutes('security')
  }
]

export default routes
