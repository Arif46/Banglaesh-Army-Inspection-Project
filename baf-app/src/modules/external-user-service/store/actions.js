export default {
    // CIP panel action start
    mutateCipPanelCommonObj ({ commit }, payload) {
        commit('mutateCipPanelCommonObj', payload)
    },
    localizeCipPanelDropdown ({ commit }, payload) {
        commit('localizeCipPanelDropdown', payload)
    },
    mutateCommonObjBftiPanel ({ commit }, payload) {
        commit('mutateCommonObjBftiPanel', payload)
    },
    localizeBftiPanelDropdown ({ commit }, payload) {
        commit('localizeBftiPanelDropdown', payload)
    },
    mutateCommonObjDealerPanel ({ commit }, payload) {
        commit('mutateCommonObjDealerPanel', payload)
    },
    localizeDropdownDealerPanel ({ commit }, payload) {
        commit('localizeDropdownDealerPanel', payload)
    },
    localizeDropdownBftiPanel ({ commit }, payload) {
        commit('localizeDropdownBftiPanel', payload)
    },
    addCurrentCircular ({ commit }, payload) {
        commit('addCurrentCircular', payload)
    },
    // CIP panel action end
    setExternalMenus ({ commit }, payload) {
        commit('setExternalMenus', payload)
    },
    setExternalPanels ({ commit }, payload) {
        commit('setExternalPanels', payload)
    },
    isInsidePanel ({ commit }, payload) {
        commit('isInsidePanel', payload)
    },
    // Association Profile (eBiz)
    setAssociationProfile ({ commit }, payload) {
        commit('setAssociationProfile', payload)
    },
    mutateCommonObjeBizPanel ({ commit }, payload) {
        commit('mutateCommonObjeBizPanel', payload)
    },
    localizeDropdowneBizPanel ({ commit }, payload) {
        commit('localizeDropdowneBizPanel', payload)
    },
    // tea garden
    mutateTeaGardenPanelCommonObj ({ commit }, payload) {
        commit('mutateTeaGardenPanelCommonObj', payload)
    },
    localizeTeaGardenPanelDropdown ({ commit }, payload) {
        commit('localizeTeaGardenPanelDropdown', payload)
    },
    mutateTradeFairPanelCommonObj ({ commit }, payload) {
        commit('mutateTradeFairPanelCommonObj', payload)
    },
    localizeTradeFairPanelDropdown ({ commit }, payload) {
        commit('localizeTradeFairPanelDropdown', payload)
    },
    // trade and tariff management
    mutateTradeTariffPanelCommonObj ({ commit }, payload) {
        commit('mutateTradeTariffPanelCommonObj', payload)
    },
    localizeTradeTariffPanelDropdown ({ commit }, payload) {
        commit('localizeTradeTariffPanelDropdown', payload)
    }
}
