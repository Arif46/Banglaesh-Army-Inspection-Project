export default {
    mutatePortalLoad ({ commit }, payload) {
        commit('mutatePortalLoad', payload)
    },
    mutateHeader ({ commit }, payload) {
        commit('mutateHeader', payload)
    },
    mutateServiceData ({ commit }, payload) {
        commit('mutateServiceData', payload)
    },
    mutateCustomerTypeList ({ commit }, payload) {
        commit('mutateCustomerTypeList', payload)
    },
    mutateServiceList ({ commit }, payload) {
        commit('mutateServiceList', payload)
    },
    mutateSearch ({ commit }, payload) {
        commit('mutateSearch', payload)
    },
    mutateOrgList ({ commit }, payload) {
        commit('mutateOrgList', payload)
    },
    mutateCategoryList ({ commit }, payload) {
        commit('mutateCategoryList', payload)
    },
    mutateFaqList ({ commit }, payload) {
        commit('mutateFaqList', payload)
    },
    mutateNoticeList ({ commit }, payload) {
        commit('mutateNoticeList', payload)
    },
    mutateNewsList ({ commit }, payload) {
        commit('mutateNewsList', payload)
    },
    setServiceUrl ({ commit }, payload) {
        commit('setServiceUrl', payload)
    },
    // common dropdown
    mutateCommonDropdown ({ commit }, payload) {
        commit('mutateCommonDropdown', payload)
    },
    localizeCommonDropdown ({ commit }, payload) {
        commit('localizeCommonDropdown', payload)
    }
    // trade fair common dropdown
    // mutateTradeFairPortalDropdown ({ commit }, payload) {
    //     commit('mutateTradeFairPortalDropdown', payload)
    // },
    // localizeTradeFairPortalDropdown ({ commit }, payload) {
    //     commit('localizeTradeFairPortalDropdown', payload)
    // }
}
