// CIP Management Routes
export const designationWiseUser = '/user/users-by-designation-id'

// cip trade routes
const cipTrade = '/cip-trade/'
export const cipTradeListApi = cipTrade + 'list'
export const cipTradeStoreApi = cipTrade + 'store'
export const cipTradeUpdateApi = cipTrade + 'update'
export const cipTradeRejctApi = cipTrade + 'rejected-list'
export const rejectChangeStatus = cipTrade + 'reject'
export const cipTradeDelete = cipTrade + 'delete'

const cip = '/cip/'
export const dashboardApi = cip + 'dashboard'
export const detailsApi = cip + 'details'
export const meetingResolutionsListApi = cip + 'meeting-resolution'

export const circularRemarkApi = cip + 'remark'
export const previousMeetingResolutionApi = cip + 'previous-remark'
export const approveRejectApi = cip + 'approve-reject'

// primary sorting
export const primarySortingApi = cip + 'primary-sorting/list'
export const primarySortingApplicantsApi = cip + 'primary-sorting/applicants'

// profile scrutiny & evaluation
export const scrutinyEvaluationApi = cip + 'profile-scrutiny-evaluation/list'
export const scrutinyEvaluationApplicantsApi = cip + 'profile-scrutiny-evaluation/applicants'
export const scrutinyEvaluationSendApi = cip + 'profile-scrutiny-evaluation/send'

// moc scrutiny
export const mocScrutinyApi = cip + 'moc-scrutiny/list'
export const mocScrutinyApplicantsApi = cip + 'moc-scrutiny/applicants'
export const mocScrutinySendApi = cip + 'moc-scrutiny/send'
export const mocScrutinyVerifiedAppsApi = cip + 'moc-scrutiny/verified-applicants'
export const mocScrutinyNothiSend = cip + 'moc-scrutiny/nothi-send'
export const mocScrutinyNothiReSend = cip + 'moc-scrutiny/nothi-resend'
export const mocScrutSendToMocCommitteApi = cip + 'moc-scrutiny/send-moc-committee-approval'

// bb routes
export const bbApplicationList = cip + 'bb/applicants'
export const bbVerify = cip + 'bb/verify'

// nbr routes
export const nbrApplicationList = cip + 'nbr/applicants'
export const nbrVerify = cip + 'nbr/verify'

// nbr routes
export const mohaApplicationList = cip + 'moha/applicants'
export const mohaVerify = cip + 'moha/verify'

// profile verification
export const profileVerficationApi = cip + 'profile-verification/list'
export const profileVerficationApplicantsApi = cip + 'profile-verification/applicants'
export const profileVerficationVerifyApi = cip + 'profile-verification/verify'
export const profileVerficationVerifiedApi = cip + 'profile-verification/verified'
export const profileVerficationSendApi = cip + 'profile-verification/send-to-verification'
export const profileVerficationSendOrNotApi = cip + 'profile-verification/send-or-not'
export const profVerfiSendToMocScrutinyApi = cip + 'profile-verification/send-moc-scrutiny'

// moc committee approval
export const mocCommitteeApprovalListApi = cip + 'moc-committee-approval/list'
export const mocCommitteeApprovalApplicantsApi = cip + 'moc-committee-approval/applicants'
export const mocCommitteeApprovalCipTradesApi = cip + 'moc-committee-approval/cip-trades'
export const mocCommitteeApprovalForwardApi = cip + 'moc-committee-approval/forward'
export const mocCommVerifiedAppsApi = cip + 'moc-committee-approval/verified-applicants'

// approval request
export const approvalReqListApi = cip + 'approval-request/list'
export const approvalReqApplicantsApi = cip + 'approval-request/applicants'
export const approvalReqCipTradesApi = cip + 'approval-request/cip-trades'
export const applicantsTradesApi = cip + 'approval-request/applicants-trades'
export const approvalReqForwardedCommentsApi = cip + 'approval-request/forward-comments'
export const approvalReqForwardApi = cip + 'approval-request/forward'
export const approvalReqHandoverApi = cip + 'approval-request/handover'
export const approvalReqVerifiedAppsApi = cip + 'approval-request/verified-applicants'

// cabinet committee approve
export const commApprovalListApi = cip + 'cabinet-committee-approval/list'
export const commApprovalApplicantsApi = cip + 'cabinet-committee-approval/applicants'
export const commApprovReqVerifiedAppsApi = cip + 'cabinet-committee-approval/verified-applicants'
export const commApprovalCipTradesApi = cip + 'cabinet-committee-approval/cip-trades'
export const commApprovalForwardApi = cip + 'cabinet-committee-approval/forward'

// pmo approval
export const pmoApprovalListApi = cip + 'pmo-approval/list'
export const pmoApprovalApplicantsApi = cip + 'pmo-approval/applicants'
export const pmoApprovalCipTradesApi = cip + 'pmo-approval/cip-trades'
export const pmoApprovalVerifiedAppsApi = cip + 'pmo-approval/verified-applicants'

// final list
export const finalListApplicantsApi = cip + 'final-list/applicants'
export const finalListCipTradesApi = cip + 'final-list/cip-trades'

// rejected list
export const rejectedApplicationsApi = cip + 'rejectd'
export const verficationNoteApi = cip + 'verification-notes'
export const fowardedCommentsApi = cip + 'forward-comments'
