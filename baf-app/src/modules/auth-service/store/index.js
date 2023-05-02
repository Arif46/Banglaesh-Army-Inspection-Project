import actions from './actions'
import getters from './getters'
import { mutations } from './mutations'

const state = {
  isLoggedIn: false,
  accessToken: null,
  authUser: null,
  authUserRoles: [],
  activeRoleId: 0,
  authorizedComponents: [],
  activeComponentId: 0,
  activeMenus: [],
  authorizedURIs: ['/home'],
  unauthorizedAccessCounter: 0,
  commonProfile: {}
}

export default {
  namespaced: true,
  state,
  actions,
  getters,
  mutations
}
