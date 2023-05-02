// Proposal Management routes......
const dashProposal = '/proposal-management/'
export const uidRoute = '/configuration/user-assign/details'
export const proposalDashCount = dashProposal + 'dashboard'
// Budget Entry routes......
const budgetEntry = '/proposal-management/budget-entry/'
export const budgetEntryList = budgetEntry + 'list'
export const budgetEntryStore = budgetEntry + 'store'
export const budgetInfo = budgetEntry + 'budget-info'
export const budgetEntryUpdate = budgetEntry + 'update'
export const budgetEntryToggle = budgetEntry + 'toggle-status'

// Circular Notice routes......
const circularNotice = '/proposal-management/circular-notice-for-rfp/'
export const circularNoticeList = circularNotice + 'list'
export const circularNoticeStore = circularNotice + 'store'
export const circularNoticeUpdate = circularNotice + 'update'
export const getCouncilIds = circularNotice + 'council-infos'
export const circularNoticePublish = circularNotice + 'publish-status'

// Proposal Related routes......
const proposal = '/proposal-management/proposal/'
export const proposalList = proposal + 'list'
export const proposalCreateTopSheet = proposal + 'create-top-sheet'
export const proposalTopSheetList = proposal + 'top-sheet-list'
export const circularList = proposal + 'circular-list'
export const proposalApprove = proposal + 'approve'
