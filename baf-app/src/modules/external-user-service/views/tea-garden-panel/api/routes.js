// external panel api routes
const teaGardenPanel = 'tea-garden-panel/'
// Small Tea farmer Application Submission
export const teaFarmerApplicationListApi = teaGardenPanel + 'small-tea-farmer-application/list'
export const teaFarmerApplicationDetailsApi = teaGardenPanel + 'small-tea-farmer-application/details'
export const teaFarmerApplicationGenInfoStoreApi = teaGardenPanel + 'small-tea-farmer-application/store'
export const teaFarmerApplicationOwnerInfoStoreApi = teaGardenPanel + 'small-tea-farmer-application/owner-info-store'

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

// Small Tea farmer Application Submission
const factoryInfo = 'tea-factory-application/'
export const factoryInfoListApi = teaGardenPanel + factoryInfo + 'list'
export const factoryInfoDetailsApi = teaGardenPanel + factoryInfo + 'details'
export const factoryInfoApplicantInfoStoreApi = teaGardenPanel + factoryInfo + 'store'
export const factoryInfoStoreApi = teaGardenPanel + factoryInfo + 'factory-info-store'
export const factoryInfoMachineriesInfoStoreApi = teaGardenPanel + factoryInfo + 'machineries-info-store'
export const factoryInfoAttachmentInfoStoreApi = teaGardenPanel + factoryInfo + 'attachment-info-store'
export const gardenInfoDetails = '/btb/garden-info-details'
// PDU circular management
export const circularApprovedList = '/pdu/circular-management/circular/approved-list-external'
export const circularShow = '/pdu/circular-management/circular/show'
