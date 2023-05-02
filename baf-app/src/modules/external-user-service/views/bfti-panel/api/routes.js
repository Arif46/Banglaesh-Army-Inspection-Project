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

// const creatingMeeting = '/meeting-management/creating-meeting/'
// export const createMeetingListApi = creatingMeeting + 'list'

// export const userListByDesignWise = '/user-management/user/list-by-designation'

// export const detailsDataApi = '/meeting-management/creating-meeting/details'

const creatingMeeting = '/bfti-panel/creating-meeting/'
export const createMeetingListApi = creatingMeeting + 'list'

export const userListByDesignWise = '/user-management/user/list-by-designation'

export const detailsDataApi = '/bfti-panel/creating-meeting/details'

// Survey Entry and Get Form
const survey = '/bfti-panel/survey-entry/'
export const surveyListApi = survey + 'list'
export const surveyStoreApi = survey + 'store'
export const surveyUpdateApi = survey + 'update'
export const getSurveyForm = survey + 'get-form'
export const applicationFormData = survey + 'get-form-data'
export const loadOldFormData = survey + 'load-old-form-Data'
// Dashboard api routes......
const dashboard = '/bfti-panel/dashboard/'
export const documentUploadInformation = dashboard + 'documents-uploaded'
// Dashboard api routes......
const dashboard2 = '/dashboard/'
export const documentInformationApi = dashboard2 + 'documents-information'
