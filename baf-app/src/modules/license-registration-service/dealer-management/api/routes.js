// Stock In Api
const stockIn = '/dealer-management/stock-management/stock-in/'
export const stockInList = stockIn + 'list'
export const stockInStore = stockIn + 'store'
export const stockInUpdate = stockIn + 'update'
export const stockInToggle = stockIn + 'toggle-status'

// Stock Out Api
const stockOut = '/dealer-management/stock-management/stock-out/'
export const stockOutList = stockOut + 'list'
export const stockOutStore = stockOut + 'store'
export const stockOutUpdate = stockOut + 'update'
export const stockOutToggle = stockOut + 'toggle-status'
export const stockOutAvailableData = stockOut + 'available-data'
export const stockOutApproved = stockOut + 'approve-status'
export const stockOutReject = stockOut + 'reject-status'
export const stockOutGetContractNumber = stockOut + 'get-by-warehouse'

// Inner Warehouse Transfer In Api
const innerWarehTransfer = '/dealer-management/stock-management/inter-warehouse-transfers/'
export const innerWarehTransferList = innerWarehTransfer + 'list'
export const innerWarehTransferStore = innerWarehTransfer + 'store'
export const innerWarehTransferUpdate = innerWarehTransfer + 'update'
export const innerWarehTransferToggle = innerWarehTransfer + 'toggle-status'
export const innerWarehTransferAdjustItem = innerWarehTransfer + 'adjust-item'

// Dealer penalty Api
const dealerPenalty = '/dealer-management/dealer-penalty/'
export const dealerPenaltyList = dealerPenalty + 'list'
export const dealerPenaltyCancel = dealerPenalty + 'cancel'
export const dealerPenaltySuspend = dealerPenalty + 'suspend'
export const dealerPenaltyReactive = dealerPenalty + 'reactive'
export const dealerPenaltyLoadAmount = dealerPenalty + 'loadamount'
export const dealerPenaltyDeductAmount = dealerPenalty + 'deductamount'
export const dealerPenaltyDeductOrRefundAmount = dealerPenalty + 'DeductOrRefundAmount'

// Inner Warehouse Product Received In Api
const innerWarehProReceive = '/dealer-management/stock-management/inter-warehouse-product-receive/'
export const innerWarehProReceiveList = innerWarehProReceive + 'list'
export const innerWarehProReceiveStore = innerWarehProReceive + 'store'
export const innerWarehProReceiveUpdate = innerWarehProReceive + 'update'
export const innerWarehProReceiveToggle = innerWarehProReceive + 'toggle-status'
// export const innerWarehProReceiveAdjustItem = innerWarehProReceive + 'adjust-item'
