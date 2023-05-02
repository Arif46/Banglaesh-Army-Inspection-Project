// Fee Name Api
const recruitment = '/license-management/recruitment/'
export const recruitmentList = recruitment + 'list'
export const recruitmentStore = recruitment + 'store'
export const recruitmentUpdate = recruitment + 'update'
export const recruitmentToggle = recruitment + 'toggle-status'
export const recruitmentApproveStatus = recruitment + 'approve-status'

// TCB common api
const common = '/license-management/common/'
export const tcbCommonForward = common + 'forward-store'
export const designationWiseUser = common + 'user-list'

// TCB Application List
const application = '/license-management/application-list/'
export const tcbApplicationList = application + 'list'
export const tcbApplicationShow = application + 'show'

// TCB Document Verificaiton
const documentVry = '/license-management/document-verification/'
export const tcbDocumentVryList = documentVry + 'list'
export const tcbDocumentVerify = documentVry + 'verify-store'

// TCB Inspection
const inspection = '/license-management/inspection/'
export const tcbInspectionList = inspection + 'list'
export const tcbInspectionStore = inspection + 'inspection-store'

// TCB agreement
const agreement = '/license-management/agreement/'
export const tcbAgreementList = agreement + 'list'
export const tcbAgreementStore = agreement + 'agreement-store'
export const archieveStatus = agreement + 'archieve-status'

// TCB Approval
const approval = '/license-management/approval/'
export const approvalList = approval + 'list'
export const approvalStatus = approval + 'approve-status'
export const tcbLicenseReject = '/license-management/reject/store'

// TCB Application List
const archive = '/license-management/archive/'
export const tcbArchiveList = archive + 'list'

// Payment List
const agreementPayment = '/license-management/license-payment/'
export const allPaymentLIst = agreementPayment + 'list'

// application payment online
const adminPayment = '/license-management/license-payment/'
const payment = '/dealer-panel/tcb-license-payment/'
export const adminPaymentOnlineStore = adminPayment + 'online/store'
export const adminTcbPaymentStatusUpdate = adminPayment + 'online/'
export const adminPaymentOfflineStore = payment + 'offline/store'
export const adminPaymentRecepetAll = payment + 'offline/receipt'
