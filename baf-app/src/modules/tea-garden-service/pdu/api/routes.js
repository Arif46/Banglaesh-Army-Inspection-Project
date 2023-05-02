// pdu course configuration routes
const course = '/pdu/configuration/course/'
export const courseList = course + 'list'
export const courseStore = course + 'store'
export const courseUpdate = course + 'update'
export const courseToggle = course + 'toggle-status'
// pdu circular routes
const circular = '/pdu/circular-management/circular/'
export const circularList = circular + 'list'
export const circularStore = circular + 'store'
export const circularUpdate = circular + 'update'
export const circularShow = circular + 'show'
export const circularToggle = circular + 'toggle-status'
export const getCircularBatchNumber = circular + 'get-batch-number'
export const circularForward = circular + 'forward'
export const circularApprove = circular + 'approve'
export const circularRequestList = circular + 'forwarded-list'
export const circularApprovedList = circular + 'approved-list'
export const circularClosed = circular + 'closed'
// pdu course management routes
const courseManagement = '/pdu/course-management/'
// applicant info routes
const applicantInfo = courseManagement + 'applicant-info/'
export const applicantInfoListApi = applicantInfo + 'list'
export const applicantInfoStoreApi = applicantInfo + 'store'
export const applicantInfoUpdateApi = applicantInfo + 'update'
export const applicantInfoShowApi = applicantInfo + 'show'
export const applicationDetails = applicantInfo + 'show'
export const applicantInfoVerifyApi = applicantInfo + 'verify'
export const verificationListApi = applicantInfo + 'verification-list'
export const confirmedListApi = applicantInfo + 'confirmed-list'
export const applicationReturn = applicantInfo + 'return'

// other info routes
const otherInfo = courseManagement + 'other-info/'
export const otherInfoStoreApi = otherInfo + 'store'
export const otherInfoUpdateApi = otherInfo + 'update'
// application report
export const participantReportList = courseManagement + 'report/application-participant'

// payment routes
const paymentInfo = courseManagement + 'circular-payment/'
export const applicationPaymentOffline = paymentInfo + 'store-offline-payment'
export const applicationPaymentOnline = paymentInfo + 'store-online-payment'
export const paymentSuccess = paymentInfo + 'success'
export const PaymentCancel = paymentInfo + 'cancel'
export const PaymentDecline = paymentInfo + 'decline'
