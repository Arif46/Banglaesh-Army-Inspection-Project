import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { getOtherPayment } from '../../../../api/routes'

const getRenewPayment = async (serviceId, vm) => {
  const params = {
    service_id: serviceId,
    type: 3
  }
  vm.payLoad = true
  const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getOtherPayment, params)
    vm.payLoad = false
    if (result.success) {
      pushAmount(result, result.data.amount, vm)
      if (result.data.payment_from === 1) {
        calculateAmount(result, vm)
      } else {
        if (result.data.expire_type === 1) {
          const resultExpire = expiredDateCheck(result.data.expire_date)
          if (!resultExpire) {
            pushExpireAmount(result, serviceId, vm)
          }
        } else {
          const resultExpire = dayCheck(vm.payment.expire_date, result)
          if (!resultExpire) {
            pushExpireAmount(result, serviceId, vm)
          }
        }
      }
    }
  }
  function pushExpireAmount (result, serviceId, vm) {
    if (result.data.payment_from === 2) {
      // params = service_id, type payment database field, payment type, check expire fee
      vm.typeWithCheckboxPayment(serviceId, result.field_payment, 1, 1)
    }
    if (result.data.payment_from === 3) {
      // params = service_id, type payment database field, payment type, check expire fee
      vm.typeWithCheckboxPayment(serviceId, result.checkbox_payment, 2, 1)
    }
  }
  function calculateAmount (result, vm) {
    if (result.data.expire_type === 1) {
      const resultExpire = expiredDateCheck(result.data.expire_date)
      if (!resultExpire) {
        let amount
        if (result.data.amount_type === 1) {
          amount = result.data.fiexed_amount
        } else {
          amount = (result.data.amount * result.data.percentage_amount) / 100
        }
        result.data.vat = 0
        result.data.tax = 0
        result.data.amount_type = 6
        pushAmount(result, amount, vm)
      }
    } else {
      const resultExpire = dayCheck(vm.payment.expire_date, result)
      if (!resultExpire) {
        let amount
        if (result.data.amount_type === 1) {
          amount = result.data.fixed_amount
        } else {
          amount = (result.data.amount * result.data.percentage_amount) / 100
        }
        result.data.vat = 0
        result.data.tax = 0
        result.data.amount_type = 6
        pushAmount(result, amount, vm)
      }
    }
  }
  function pushAmount (result, amount, vm) {
    const expayChallanNo = result.data.amount_type === 6 ? result.data.expire_challan_no : result.data.renew_challan_no
    vm.allPayment.push({
      application_id: vm.payment.application_id,
      step_id: vm.payment.step_id,
      service_id: result.data.service_id,
      fee_id: result.data.id,
      amount_type: result.data.amount_type,
      amount: amount,
      amount_vat: (amount * (result.data.vat ? parseInt(result.data.vat) : 0)) / 100,
      amount_tax: (amount * (result.data.tax ? parseInt(result.data.tax) : 0)) / 100,
      vat: result.data.vat ? parseInt(result.data.vat) : 0,
      tax: result.data.tax ? parseInt(result.data.tax) : 0,
      bank_name: '',
      bank_name_tax: '',
      bank_name_vat: '',
      branch_name: '',
      branch_name_tax: '',
      branch_name_vat: '',
      ekpay_challan_no: expayChallanNo,
      challan_no: '',
      challan_no_tax: '',
      challan_no_vat: '',
      pay_date: '',
      pay_date_vat: '',
      pay_date_tax: '',
      fee_name: result.data.type_name,
      fee_name_bn: result.data.type_name_bn,
      attachment: '',
      attachment_vat: '',
      attachment_tax: '',
      is_choose_payment: true
    })
  }
  function dayCheck (expareDate, result) {
    const expreDateWithExpireDays = addDays(expareDate, result.data.expire_days)
    return expiredDateCheck(expreDateWithExpireDays)
  }
  function expiredDateCheck (expiredDate) {
    if (!expiredDate) {
      return false
    }
    const currentDate = new Date().toISOString().slice(0, 10)
    const noOfDay = getDaysDiffByDate(currentDate, expiredDate)
    return noOfDay > 1
  }
  function addDays (date, days) {
    const result = new Date(date)
    result.setDate(result.getDate() + days)
    return result.toISOString().slice(0, 10)
  }
  function getDaysDiffByDate (start, end) {
    const date1 = new Date(start)
    const date2 = new Date(end)
    // One day in milliseconds
    const oneDay = 1000 * 60 * 60 * 24
    // Calculating the time difference between two dates
    const diffInTime = date2.getTime() - date1.getTime()
    // Calculating the no. of days between two dates
    const diffInDays = Math.round(diffInTime / oneDay)
    return diffInDays
  }
export default {
  getRenewPayment
}
