// Allotment Order Entry Ministry Api
const deliveryOrderHq = '/allocation-management-dc-office/delivery-order-hq/'

export const districtWithItem = deliveryOrderHq + 'district-with-items'
export const districtOther = deliveryOrderHq + 'district-other'
export const deliveryOrderList = deliveryOrderHq + 'list'
export const deliveryOrderFinalSave = deliveryOrderHq + 'final-save'
export const deliveryOrderStore = deliveryOrderHq + 'store'
export const deliveryOrderUpdate = deliveryOrderHq + 'update'

const districtWiseAllotment = '/allocation-management-dc-office/district-wise-allotment/'
export const districtWiseAllotmentList = districtWiseAllotment + 'list'
export const districtWiseAllotmentStore = districtWiseAllotment + 'store'
export const districtWiseAllotmentUpdate = districtWiseAllotment + 'update'

const deliveryEntry = '/allocation-management-dc-office/delivery-entry/'
export const deliveryEntryList = deliveryEntry + 'list'
export const deliveryEntryStore = deliveryEntry + 'store'
export const deliveryEntryUpdate = deliveryEntry + 'update'
export const getItemPrice = deliveryEntry + 'get-item-price'
export const getItemByWarehouse = deliveryEntry + 'get-product-warehouse'

export const allotmentItemList = districtWiseAllotment + 'allotment-item-list'
export const districtWithBeneficiaryCount = districtWiseAllotment + 'district-with-beneficiary-count'
// assign warehouse
const assignWarehouse = '/allocation-management-dc-office/assign-warehouse/'
export const assignWarehouseList = assignWarehouse + 'list'
export const assignWarehouseAssignUpdate = assignWarehouse + 'assign'
// receive Product
const receiveProduct = '/allocation-management-dc-office/receive-product/'
export const receiveProductList = receiveProduct + 'list'
export const receiveProductStore = receiveProduct + 'update'

const shortageOrder = '/allocation-management-dc-office/shortage-order/'
export const shortageOrderWithDeliveryList = shortageOrder + 'list'
export const shortageOrderWithDeliveryListByChalan = shortageOrder + 'shortage-list'
export const shortageOrderDeliver = shortageOrder + 'deliver'
export const receiveOrderStore = shortageOrder + 'store'

// receive Product
const receivePayment = '/allocation-management-dc-office/delivery-order-payment-hq/'
export const paymentList = receivePayment + 'list'
export const paymentStore = receivePayment + 'store'
export const paymentConfirm = receivePayment + 'confirm'
