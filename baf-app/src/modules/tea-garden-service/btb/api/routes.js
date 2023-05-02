// Small Tea farmer Application Submission
const teaFarmerApplication = '/btb/'
export const teaFarmerApplicationListApi = teaFarmerApplication + 'small-tea-farmer-application/list'
export const teaFarmerApplicationDetailsApi = teaFarmerApplication + 'small-tea-farmer-application/details'
export const teaFarmerApplicationGenInfoStoreApi = teaFarmerApplication + 'small-tea-farmer-application/store'
export const teaFarmerApplicationOwnerInfoStoreApi = teaFarmerApplication + 'small-tea-farmer-application/owner-info-store'
export const smallTeaFarmerViewPdf = teaFarmerApplication + 'small-tea-farmer-application/view-pdf'

// Tree Disposal Application Submission
export const treeDisposalAppListApi = '/btb/tree-disposal-application/list'
export const treeDisposalAppDetailsApi = '/btb/tree-disposal-application/details'
export const treeDisposalAppStoreApi = '/btb/tree-disposal-application/store'
export const treeDisposalAppCuttingPurposeStoreApi = '/btb/tree-disposal-application/cutting-purpose'
export const treeDisposalAppCuttingDevelopmentStoreApi = '/btb/tree-disposal-application/cutting-development-planning'
export const gardenSectionDetailsApi = '/btb/tree-disposal-application/garden-section-details'
export const treeDisposalPreviousPermissionDetailsApi = '/btb/tree-disposal-application/previous-permission-history'
export const gardenInfoDetails = '/btb/garden-info-details'
const masterTree = '/configuration/tree-entry/'
export const customTreeEntryApi = masterTree + 'store'
export const getTeaGardenNameList = '/btb/get-tea-garden-name-list'
export const TreeDisposalViewPdf = '/btb/tree-disposal-application/view-pdf'

const teaGardenPanel = 'tea-garden-panel/'
// Small Tea Garden Application
const gardenInfo = 'tea-garden-application/garden-info/'
export const gardenInfoListApi = teaGardenPanel + gardenInfo + 'list'
export const gardenInfoShowApi = teaGardenPanel + gardenInfo + 'show'
export const gardenInfoStoreApi = teaGardenPanel + gardenInfo + 'store'
export const gardenInfoUpdateApi = teaGardenPanel + gardenInfo + 'update'

const proprietorIdentity = 'tea-garden-application/proprietor-identity/'
export const proprietorIdentityStoreApi = teaGardenPanel + proprietorIdentity + 'store'
export const proprietorIdentityUpdateApi = teaGardenPanel + proprietorIdentity + 'update'

const landOwnershipInfo = 'tea-garden-application/land-ownership-info/'
export const landOwnershipInfoStoreApi = teaGardenPanel + landOwnershipInfo + 'store'
export const landOwnershipInfoUpdateApi = teaGardenPanel + landOwnershipInfo + 'update'

const otherInfo = 'tea-garden-application/other-info/'
export const otherInfoStoreApi = teaGardenPanel + otherInfo + 'store'
export const otherInfoUpdateApi = teaGardenPanel + otherInfo + 'update'

const witnessInfo = 'tea-garden-application/witness-info/'
export const witnessInfoStoreApi = teaGardenPanel + witnessInfo + 'store'
export const witnessInfoUpdateApi = teaGardenPanel + witnessInfo + 'update'

// Tea factory Application Submission
const factoryInfo = 'tea-factory-application/'
export const factoryInfoListApi = teaGardenPanel + factoryInfo + 'list'
export const factoryInfoDetailsApi = teaGardenPanel + factoryInfo + 'details'
export const factoryInfoApplicantInfoStoreApi = teaGardenPanel + factoryInfo + 'store'
export const factoryInfoStoreApi = teaGardenPanel + factoryInfo + 'factory-info-store'
export const factoryInfoMachineriesInfoStoreApi = teaGardenPanel + factoryInfo + 'machineries-info-store'
export const factoryInfoAttachmentInfoStoreApi = teaGardenPanel + factoryInfo + 'attachment-info-store'
export const TeaFactoryViewPdf = '/tea-garden-panel/tea-factory-application/view-pdf'

export const applicationPaymentOffline = '/btb/store-offline-payment'
export const applicationPaymentOnline = '/btb/store-online-payment'
export const applicationPaymentDetails = '/btb/get-btb-parent-service'
// payment redirect route
export const paymentSuccessBtb = '/btb/success'
export const PaymentCancelBtb = '/btb/cancel'
export const PaymentDeclineBtb = '/btb/decline'
// auth service all user list
export const AuthUserInfo = '/user-management/user/get-user-details/'
