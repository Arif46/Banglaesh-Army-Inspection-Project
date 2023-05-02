export const mutations = {
    mutatePortalLoad (state, payload) {
        state.loading = payload
    },
    mutateHeader (state, payload) {
        state.header = payload
    },
    mutateServiceData (state, payload) {
        state.serviceData = payload
        state.orgList = payload.orgList
        state.customerTypeList = payload.serviceCustomerTypeList
        state.categoryList = payload.serviceCategoryList
    },
    mutateCustomerTypeList (state, payload) {
        state.customerTypeList = payload
    },
    mutateServiceList (state, payload) {
        state.serviceList = payload
    },
    mutateSearch (state, payload) {
        state.searchData.loading = !state.searchData.loading
        state.searchData = Object.assign(state.searchData, payload)
    },
    mutateOrgList (state, payload) {
        state.orgList = payload
    },
    mutateCategoryList (state, payload) {
        state.categoryList = payload
    },
    mutateFaqList (state, payload) {
        state.faqList = payload
    },
    mutateNoticeList (state, payload) {
        state.noticeList = payload
    },
    mutateNewsList (state, payload) {
        state.newsList = payload
    },
    setServiceUrl (state, payload) {
        state.serviceUrl = Object.assign(state.serviceUrl, payload)
    },
    // common dropdown
    mutateCommonDropdown (state, payload) {
        state.commonObj = Object.assign(state.commonObj, payload)
    },
    localizeCommonDropdown (state, payload) {
        state.commonObj.fiscalYearList = state.commonObj.fiscalYearList.map(item => {
            const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
            return Object.assign({}, item, tmp)
        })
        state.commonObj.designationList = state.commonObj.designationList.map(item => {
            const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
            return Object.assign({}, item, tmp)
        })
        state.commonObj.orgProfileList = state.commonObj.orgProfileList.map(item => {
            const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
            return Object.assign({}, item, tmp)
        })
        state.commonObj.countryList = state.commonObj.countryList.map(item => {
            const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
            return Object.assign({}, item, tmp)
        })
    }
    // trade fair common dropdown
    // mutateTradeFairPortalDropdown (state, payload) {
    //     state.tradeFair.commonObj = Object.assign(state.tradeFair.commonObj, payload)
    // },
    // localizeTradeFairPortalDropdown (state, payload) {
    //     state.tradeFair.commonObj.fairSectorList = state.tradeFair.commonObj.fairSectorList.map(item => {
    //         const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
    //         return Object.assign({}, item, tmp)
    //     })
    //     state.tradeFair.commonObj.subsidyCategoryList = state.tradeFair.commonObj.subsidyCategoryList.map(item => {
    //         const tmp = payload.value === 'bn' ? { text: item.text_bn } : { text: item.text_en }
    //         return Object.assign({}, item, tmp)
    //     })
    // }
}
