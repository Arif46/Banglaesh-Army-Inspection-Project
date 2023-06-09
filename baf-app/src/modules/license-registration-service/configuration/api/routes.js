// Fee Name Api
const fee = '/configuration/fee-name/'
export const feeList = fee + 'list'
export const feeStore = fee + 'store'
export const feeUpdate = fee + 'update'
export const feeToggle = fee + 'toggle-status'
// Service Name Api
const service = '/configuration/service-name/'
export const serviceList = service + 'list'
export const serviceStore = service + 'store'
export const serviceUpdate = service + 'update'
export const serviceToggle = service + 'toggle-status'
// Step Name Api
const step = '/configuration/step-name/'
export const stepList = step + 'list'
export const stepStore = step + 'store'
export const stepUpdate = step + 'update'
export const stepToggle = step + 'toggle-status'
// Step Assign Api
const stepAssign = '/configuration/step-assign/'
export const stepAssignList = stepAssign + 'list'
export const stepAssignStore = stepAssign + 'store'
export const stepAssignUpdate = stepAssign + 'update'
// Step Name Api
const region = '/configuration/region/'
export const regionList = region + 'list'
export const regionStore = region + 'store'
export const regionUpdate = region + 'update'
// Step Form api Routes
const stepForm = '/configuration/step-form/'
export const stepFormList = stepForm + 'list'
export const stepListget = stepForm + 'get-steps'
export const stepFormStore = stepForm + 'store'
export const stepFormUpdate = stepForm + 'update'
export const dynamicFormEditData = stepForm + 'edit'
export const stepFormView = stepForm + 'view'
// Step Form View Design Routes
const stepFormViewDesign = '/configuration/step-form-view/'
export const stepFormViewList = stepFormViewDesign + 'list'
export const stepFormViewStore = stepFormViewDesign + 'store'
export const stepFormViewEditData = stepFormViewDesign + 'edit'
export const stepFormViewUpdate = stepFormViewDesign + 'update'
export const stepFormViewDetail = '/configuration/step-form/view'
export const dynamicFormData = '/configuration/step-form/edit'
// Form Assign api Routes
const formAssign = '/configuration/service-step-form-assign/'
export const formAssignList = formAssign + 'list'
export const formAssignStore = formAssign + 'store'
export const formAssignUpdate = formAssign + 'update'
// Step process api Routes
const stepProcess = '/configuration/step-process/'
export const stepProcessList = stepProcess + 'list'
export const stepProcessStore = stepProcess + 'store'
export const stepProcessUpdate = stepProcess + 'update'
// Menu create to common service
export const menuList = 'menu/menu/list'
export const menuStore = 'menu/menu/store'
export const menuUpdate = 'menu/menu/update'
// Menu Assign to license
const menuAssign = '/configuration/menu-assign/'
export const menuAssignList = menuAssign + 'list'
export const menuAssignStore = menuAssign + 'store'
export const menuAssignUpdate = menuAssign + 'update'
// Auto generate number type api Routes
const autoNum = '/configuration/auto-gen-num-types/'
export const autoGenNumTypeList = autoNum + 'list'
export const autoGenNumTypeStore = autoNum + 'store'
export const autoGenNumTypeUpdate = autoNum + 'update'
export const autoGenNumTypeToggleStatus = autoNum + 'toggle-status'
// Step Fee Assign API Routes
const stepFeeAssign = '/configuration/step-fee-assign/'
export const stepFeeAssignList = stepFeeAssign + 'list'
export const stepFeeAssignGetFeesList = stepFeeAssign + 'get-fees'
export const stepFeeAssignStore = stepFeeAssign + 'store'
export const stepFeeAssignUpdate = stepFeeAssign + 'update'
// Document Builder routes
const document = '/configuration/lr-documents/'
export const documentList = document + 'list'
export const documentStore = document + 'store'
export const documentUpdate = document + 'update'
export const documentShow = document + 'show'
// Step process api Routes
const reportProcess = '/configuration/report-process/'
export const reportProcessList = reportProcess + 'list'
export const reportProcessStore = reportProcess + 'store'
export const reportProcessUpdate = reportProcess + 'update'
// Report Menu Assign to license
const reportMenuAssign = '/configuration/report-menu-assign/'
export const reportMenuAssignList = reportMenuAssign + 'list'
export const reportMenuAssignStore = reportMenuAssign + 'store'
export const reportMenuAssignUpdate = reportMenuAssign + 'update'
// Report Header Api
const reportHeading = '/configuration/report-heading/'
export const reportHeadingList = reportHeading + 'list'
export const reportHeadingStore = reportHeading + 'store'
export const reportHeadingUpdate = reportHeading + 'update'
export const reportToggleStatus = reportHeading + 'toggle-status'
export const reportHeaderDestroy = reportHeading + 'destroy'
// Renew/Lost Fee api Routes
const renewLost = '/configuration/renew-lost-fee/'
export const renewLostList = renewLost + 'list'
export const renewLostStore = renewLost + 'store'
export const renewLostUpdate = renewLost + 'update'
export const renewLostToggleStatus = renewLost + 'toggle-status'
// dashboard card routes
const card = '/configuration/dashboard-card/'
export const cardList = card + 'list'
export const cardStore = card + 'store'
export const cardUpdate = card + 'update'
export const cardToggle = card + 'toggle-status'
// Service Wise Office Type api Routes
const officeType = '/configuration/service-office-type/'
export const serviceofficeTypeList = officeType + 'list'
export const serviceofficeTypeStore = officeType + 'store'
export const serviceofficeTypeUpdate = officeType + 'update'
// Org Notifications
const OrgNote = '/configuration/org-notes/'
export const orgNotesList = OrgNote + 'list'
export const orgNotesStore = OrgNote + 'store'
export const orgNotesUpdate = OrgNote + 'update'
export const orgNotesToggleStatus = OrgNote + 'toggle-status'
// Notice api Routes
const notice = '/configuration/notice/'
export const noticeList = notice + 'list'
export const noticeStore = notice + 'store'
export const noticeUpdate = notice + 'update'
export const noticeToggleStatus = notice + 'toggle-status'
// Service Pre Condition API Routes
const preCondition = '/configuration/service-precondition/'
export const preconditionList = preCondition + 'list'
export const preconditionStore = preCondition + 'store'
export const preconditionUpdate = preCondition + 'update'
export const toggleStatus = preCondition + 'toggle-status'
// Form Field Assign api Routes
const fieldAssign = '/configuration/field-assign/'
export const fieldAssignList = fieldAssign + 'list'
export const fieldAssignStore = fieldAssign + 'store'
export const fieldAssignUpdate = fieldAssign + 'update'
export const fieldAssignRemove = fieldAssign + 'remove'
// ekpay Manage api Routes
const ekpayManage = '/configuration/ekpay-manage/'
export const ekpayList = ekpayManage + 'list'
export const ekpayStore = ekpayManage + 'store'
export const ekpayUpdate = ekpayManage + 'update'
export const ekpayToggleStatus = ekpayManage + 'toggle-status'
// ekpay Challan api Routes
const ekpayChallan = '/configuration/ekpay-challan/'
export const challanList = ekpayChallan + 'list'
export const challanStore = ekpayChallan + 'store'
export const challanUpdate = ekpayChallan + 'update'
export const challanToggleStatus = ekpayChallan + 'toggle-status'
// dashboard card routes
export const dasbhoard = '/dashboard'
// Master Item Category Api
const itemCategory = '/configuration/tcb-configuration/item-category/'
export const itemCategoryList = itemCategory + 'list'
export const itemCategoryStore = itemCategory + 'store'
export const itemCategoryUpdate = itemCategory + 'update'
export const itemCategoryToggle = itemCategory + 'toggle-status'
// Master Item Api
const item = '/configuration/tcb-configuration/item/'
export const itemList = item + 'list'
export const itemStore = item + 'store'
export const itemUpdate = item + 'update'
export const itemToggle = item + 'toggle-status'
// Master Warehouse Api
const warehouse = '/configuration/tcb-configuration/warehouse/'
export const warehouseList = warehouse + 'list'
export const warehouseStore = warehouse + 'store'
export const warehouseUpdate = warehouse + 'update'
export const warehouseToggle = warehouse + 'toggle-status'
// Master Operating Expense Api
const optExp = '/configuration/tcb-configuration/operating-expenses/'
export const optExpList = optExp + 'list'
export const optExpStore = optExp + 'store'
export const optExpUpdate = optExp + 'update'
export const optExpToggle = optExp + 'toggle-status'
// Master Operating Expense Api
const optExpTax = '/configuration/tcb-configuration/operating-expenses-tax/'
export const optExpTaxList = optExpTax + 'list'
export const optExpTaxStore = optExpTax + 'store'
export const optExpTaxUpdate = optExpTax + 'update'
export const optExpTaxToggle = optExpTax + 'toggle-status'
// Master faq Api
const faq = '/configuration/tcb-configuration/faq/'
export const faqList = faq + 'list'
export const faqStore = faq + 'store'
export const faqUpdate = faq + 'update'
export const faqToggle = faq + 'toggle-status'
// Master feedback Review Api
const fdReview = '/configuration/tcb-configuration/feedback-review/'
export const fdReviewList = fdReview + 'list'
export const fdReviewStore = fdReview + 'store'
export const fdReviewUpdate = fdReview + 'update'
export const fdReviewToggle = fdReview + 'toggle-status'
// Master Contract Numbers Api
const contractNum = '/configuration/tcb-configuration/contract-numbers/'
export const contractNumList = contractNum + 'list'
export const contractNumStore = contractNum + 'store'
export const contractNumUpdate = contractNum + 'update'
export const contractNumToggle = contractNum + 'toggle-status'
// auth service api
export const tcbUserList = '/user-management/user/get-all'

// user warehouse
const userWarehouse = '/configuration/tcb-configuration/user-warehosue/'
export const userWarehouseList = userWarehouse + 'list'
export const userWarehouseStore = userWarehouse + 'store'
export const userWarehouseUpdate = userWarehouse + 'update'
export const userWarehouseToggle = userWarehouse + 'toggle-status'
 // Beneficiary Entry
const beneficiartEntry = '/configuration/tcb-configuration/master-beneficiary/'
export const beneficiartEntryList = beneficiartEntry + 'list'
export const beneficiartEntryStore = beneficiartEntry + 'store'
export const beneficiartEntryUpdate = beneficiartEntry + 'update'
export const beneficiartEntryToggle = beneficiartEntry + 'toggle-status'
export const beneficiartEntryshow = beneficiartEntry + 'show'
export const beneficiaryExcelUpload = beneficiartEntry + 'excel-upload'

 // Beneficiary Information Entry
 const beneficiartInformationEntry = '/configuration/tcb-configuration/master-beneficiary-information/'
 export const beneficiartInformationEntryList = beneficiartInformationEntry + 'list'
 export const beneficiaryInformationEntryStore = beneficiartInformationEntry + 'store'
 export const beneficiaryInformationEntryUpdate = beneficiartInformationEntry + 'update'
 export const beneficiaryInformationEntryToggle = beneficiartInformationEntry + 'toggle-status'
 export const beneficiartInformationExcelUpload = beneficiartInformationEntry + 'excel-upload'
//  export const beneficiartEntryshow = beneficiartEntry + 'show'

 // Tax and Commission DC Office
 const taxCommission = '/configuration/tcb-configuration/dc-office-tax/'
 export const taxCommissionList = taxCommission + 'list'
 export const taxCommissionStore = taxCommission + 'store'
 export const taxCommissionUpdate = taxCommission + 'update'
 export const taxCommissionToggle = taxCommission + 'toggle-status'
 // Region Wise District Entry
 const regionWiseDistrictEntry = '/configuration/tcb-configuration/master-regional-distrct/'
 export const regionWiseDistrictList = regionWiseDistrictEntry + 'list'
 export const regionWiseDistrictEntryStore = regionWiseDistrictEntry + 'store'
 export const regionWiseDistrictEntryUpdate = regionWiseDistrictEntry + 'update'
 export const regionWiseDistrictEntryToggle = regionWiseDistrictEntry + 'toggle-status'
 export const regionWiseDistrictEntryshow = regionWiseDistrictEntry + 'show'
