export default {
  mutateCommonObj ({ commit }, payload) {
    commit('mutateCommonObj', payload)
  },
  mutateDitfCommonObj ({ commit }, payload) {
    commit('mutateDitfCommonObj', payload)
  },
  stateReload ({ commit }, payload) {
    commit('stateReload', payload)
  },
  localizeDropdown ({ commit }, payload) {
    commit('localizeDropdown', payload)
  }
}
