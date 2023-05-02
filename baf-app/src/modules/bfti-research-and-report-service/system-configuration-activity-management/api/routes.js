
// Survay management
const surveyInfo = '/system-configuration-and-activity-management/survey-management/survey-info/'
export const surveyInfoListApi = surveyInfo + 'list'
export const surveyInfoStoreApi = surveyInfo + 'store'
export const surveyInfoUpdateApi = surveyInfo + 'update'
export const surveyInfoToggleApi = surveyInfo + 'toggle-status'

const surveyForm = '/system-configuration-and-activity-management/survey-management/survey-form/'
export const surveyFormListApi = surveyForm + 'list'
export const surveyFormReceiveListApi = surveyForm + 'receive-list'
export const surveyFormStoreApi = surveyForm + 'store'
export const surveyFormUpdateApi = surveyForm + 'update'
export const surveyFormEditApi = surveyForm + 'edit'
export const surveyFormToggleApi = surveyForm + 'toggle-status'

const program = '/system-configuration-and-activity-management/program-management/program-info/program-info-entry/'
export const programInfoListApi = program + 'list'
export const programInfoStoreApi = program + 'store'
export const programInfoUpdateApi = program + 'update'
export const programInfoToggleApi = program + 'toggle-status'

const programInvite = '/system-configuration-and-activity-management/program-management/program-info-invite/'
export const programInfoInviteStoreApi = programInvite + 'store'
export const programInfoInviteUpdateApi = programInvite + 'update'
export const programInfoInviteSendInvitationApi = programInvite + 'send-invitation'

export const userListByDesignWise = '/user-management/user/list-by-designation'
export const userNameList = '/user-management/user/get-all'

// Report API
const reportBaseUrl = '/report-management/'
export const ledgerReportList = reportBaseUrl + 'ledger-report/list'
export const ledgerReportShow = reportBaseUrl + 'ledger-report/show/'
export const surveyReportList = reportBaseUrl + 'survey-report'

// income expenditure report api...
export const incomeExpenditureListReportRoute = '/report-management/income-expenditure-report/list'
export const incomeExpenditureDetailReportRoute = '/report-management/income-expenditure-report/show'

// consultant payment report api...
export const consultantPaymentListReportRoute = '/report-management/consultant-payment-report/list'
export const consultantPaymentDetailReportRoute = '/report-management/consultant-payment-report/show'

export const BFTIOwnFundApi = '/report-management/bfti-own-fund-report/list'

// Policy Report API
const policy = '/report-management/'
export const policyReportList = policy + 'policy-review-document-report/list'

// program Report API
const programReport = '/report-management/'
export const programReportList = programReport + 'program-report/list'

export const progressReportApi = '/report-management/progress-report'

const survey = '/bfti-panel/survey-entry/'
export const applicationFormData = survey + 'get-form-data'
export const loadOldFormData = survey + 'load-old-form-Data'
