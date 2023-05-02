// Product and Service Sector Apis
const bfti = '/bfti-panel/research-and-other-request/'
export const bftiResearchRequestListApi = bfti + 'list'
export const bftiResearchRequestStoreApi = bfti + 'store'
export const bftiResearchRequestUpdateApi = bfti + 'update'
export const bftiResearchRequestToggleApi = bfti + 'toggle-status'

// policy-request-entry Apis
const bftiPolicy = '/bfti-panel/policy-request-entry/'
export const bftiPolicyRequestListApi = bftiPolicy + 'list'
export const bftiPolicyRequestStoreApi = bftiPolicy + 'store'
export const bftiPolicyRequestUpdateApi = bftiPolicy + 'update'
export const bftiPolicyRequestToggleApi = bftiPolicy + 'toggle-status'

const creatingMeeting = '/meeting-management/creating-meeting/'
export const createMeetingListApi = creatingMeeting + 'list'

export const userListByDesignWise = '/user-management/user/list-by-designation'

export const detailsDataApi = '/meeting-management/creating-meeting/details'

// application
const application = '/dealer-panel/license-application/'
export const applicationList = application + 'list'
export const applicationStore = application + 'store'
export const applicationUpdate = application + 'update'
export const changeAppStatus = application + 'change-status'
export const noticeRecuirmentNoticeList = application + 'notice-list'

export const reviewStore = 'configuration/tcb-configuration/feedback-review/store'

// application payment online
const payment = '/dealer-panel/tcb-license-payment/'
export const paymentOnlineStore = payment + 'online/store'
export const tcbPaymentStatusUpdate = payment + 'online/'
export const paymentOfflineStore = payment + 'offline/store'
export const paymentRecepetAll = payment + 'offline/receipt'

// complain Apis
const complain = '/dealer-panel/complain/'
export const complainList = complain + 'list'
export const complainStore = complain + 'store'
export const complainUpdate = complain + 'update'

const faq = '/dealer-panel/faq/'
export const faqList = faq + 'list'

// Allocation Letter Api
const allocation = '/dealer-panel/allocation-letter/'
export const allocationList = allocation + 'list'
