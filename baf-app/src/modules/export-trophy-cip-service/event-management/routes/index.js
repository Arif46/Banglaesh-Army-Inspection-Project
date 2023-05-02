const circularRoutes = (prop) => [
  {
    path: 'events-date',
    name: prop + '.events_date',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/events-date/List.vue')
  },
  {
    path: 'invitation-card-entry',
    name: prop + '.invitation_card_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/invitation-card-entry/List.vue')
  },
  {
    path: 'guest-invitation',
    name: prop + '.guest_invitation',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/guest-invitation/Form.vue')
  },
  {
    path: 'guest-entry',
    name: prop + '.guest_entry',
    meta: { auth: true, name: 'Editable' },
    component: () => import('../pages/guest-entry/List.vue')
  }
]

const routes = [
  {
    path: '/export-trophy-cip-service/event-management',
    name: 'export_trophy_cip_service.event_management',
    component: () => import('@/layouts/ExportTrophyCipServiceLayout.vue'),
    meta: { auth: true },
    children: circularRoutes('export_trophy_cip_service.event_management')
  }
]

export default routes
