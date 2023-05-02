export const mutations = {
  mutateCommonObj (state, payload) {
    state.commonObj = Object.assign({}, state.commonObj, payload)
  },
  localizeDropdown (state, payload) {
    state.commonObj.exportSectorList = state.commonObj.exportSectorList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.cipSectorList = state.commonObj.cipSectorList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.venueList = state.commonObj.venueList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.invitationCardList = state.commonObj.invitationCardList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
    state.commonObj.eventList = state.commonObj.eventList.map(item => {
      const tmp = payload.value === 'en' ? { text: item.text_en } : { text: item.text_bn }
      return Object.assign({}, item, tmp)
    })
  },
  setPendingForward (state, payload) {
    state.commonObj.pendingForward = payload
  }
}
