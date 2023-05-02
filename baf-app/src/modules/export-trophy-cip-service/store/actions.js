export default {
  mutateCommonObj ({ commit }, payload) {
    commit('mutateCommonObj', payload)
  },
  stateReload ({ commit }, payload) {
    commit('stateReload', payload)
  },
  localizeDropdown ({ commit }, payload) {
    commit('localizeDropdown', payload)
  },
  setPendingForward ({ commit }, payload) {
    commit('setPendingForward', payload)
  }
}
