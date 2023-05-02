<template>
  <b-container fluid>
    <b-overlay :show="saveloading">
        <b-col v-if="loadHistory" md="12" lg="12" sm="12">
          <b-overlay :show="true" class="p-5">
            <div class="text-center">
              <h5>Pending payment checking...</h5>
            </div>
          </b-overlay>
        </b-col>
        <b-col v-else md="12" lg="12" sm="12">
          <ValidationObserver ref="from" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" >
              <table v-if="history.length" class="table table-bordered table-sm">
                <tr>
                  <th colspan="4" class="text-center">History</th>
                </tr>
                <tr>
                    <th>{{ $t('fee_name.fee_name') }}</th>
                    <th>{{ $t('globalTrans.amount') }}</th>
                    <th>{{ $t('globalTrans.vat') }} (%) </th>
                    <th>{{ $t('globalTrans.tax') }} (%) </th>
                </tr>
                <tr v-for="(item, index) in history" :key="index">
                  <td>{{ getFeeName(item) }}</td>
                  <td>{{ $n(item.amount) }}</td>
                  <td>({{ $n(item.vat) }}%) = {{ (item.amount_vat) }}</td>
                  <td>({{ $n(item.tax) }}%) = {{ (item.amount_tax) }}</td>
                </tr>
                <tr>
                  <th>{{ $t('globalTrans.subtotal') }}</th>
                  <td>{{ getTotal(history) }}</td>
                  <td>{{ getTotalVat(history) }}</td>
                  <td>{{ getTotalTax(history) }}</td>
                </tr>
                <tr>
                  <th colspan="2">{{ $t('globalTrans.total') }}</th>
                  <td colspan="2">{{ getTotal(history) + getTotalVat(history) + getTotalTax(history) }}</td>
                </tr>
              </table>
              <div v-else>
                <div class="row" v-if="allPayment.length">
                  <div class="col-md-12">
                    <table class="table table-bordered table-sm">
                      <tr>
                          <th>{{ $t('fee_name.fee_name') }}</th>
                          <th>{{ $t('globalTrans.amount') }}</th>
                          <th>{{ $t('globalTrans.vat') }} (%) </th>
                          <th>{{ $t('globalTrans.tax') }} (%) </th>
                      </tr>
                      <tr v-for="(item, index) in allPayment" :key="index">
                        <td>
                          <b-form-checkbox v-if="isChoosePayment(item.service_id)"
                            class="mt-2"
                            v-model="item.is_choose_payment"
                            >{{ getFeeName(item) }}</b-form-checkbox>
                            <span v-else>{{ getFeeName(item) }}</span>
                        </td>
                        <td>{{ $n(item.amount) }}</td>
                        <td>({{ $n(item.vat) }}%) = {{ $n(item.amount_vat) }}</td>
                        <td>({{ $n(item.tax) }}%) = {{ $n(item.amount_tax) }}</td>
                      </tr>
                      <tr>
                        <th>{{ $t('globalTrans.subtotal') }}</th>
                        <td>{{ $n(getTotal(allPayment)) }}</td>
                        <td>{{ $n(getTotalVat(allPayment)) }}</td>
                        <td>{{ $n(getTotalTax(allPayment)) }}</td>
                      </tr>
                      <tr>
                        <th colspan="2">{{ $t('globalTrans.total') }}</th>
                        <td colspan="2">{{ $n(getTotal(allPayment) + getTotalVat(allPayment) + getTotalTax(allPayment)) }}</td>
                      </tr>
                    </table>
                  </div>
                </div>
              </div>
              <div class="row mt-3">
                  <div class="col-md-12 text-right">
                      <b-button type="submit" variant="primary" class="mr-2 btn-sm">{{ $t('externalLrcpn.pay_now') }}</b-button>
                      <b-button variant="danger" class="mr-1 btn-sm" @click="$bvModal.hide(payment.application_type === 1 ? `modal-payment` : `modal-payment-renew`)">{{ $t('globalTrans.cancel') }}</b-button>
                  </div>
              </div>
            </b-form>
          </ValidationObserver>
        </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paymentStoreOnline, getTypeCheckboxPaymentList, getLabPaymentFromMainPayment } from './../../../../api/routes'
import flatpickr from 'flatpickr'
import Renew from './renew'
import { ValidationObserver } from 'vee-validate'

export default {
  props: ['payment'],
  components: {
    ValidationObserver
  },
  data () {
    return {
        saveloading: false,
        loadHistory: false,
        type: 1,
        allPayment: [],
        total_amount: 0,
        total_vat: 0,
        total_tax: 0,
        history: []
    }
  },
  mounted () {
    setTimeout(this.setPicker, 10000)
  },
  created () {
    this.checkHistory()
    if (this.payment.application_type === 1) {
      this.getPayment()
    }
    if (this.payment.application_type === 1 && this.checkLabPayment()) {
      this.getLabPayment()
    }
    const checkPayment = this.checkPayment()
    if (checkPayment.field_payment.length > 1) {
      this.typeWithCheckboxPayment(this.payment.service_id, checkPayment.field_payment, 1, checkPayment.ekpay_challan_no)
    }
    if (checkPayment.checkbox_payment.length > 1) {
      this.typeWithCheckboxPayment(this.payment.service_id, checkPayment.checkbox_payment, 2, checkPayment.ekpay_challan_no)
    }
    if (this.payment.application_type === 2 && checkPayment.checkbox_payment.length === 1 && checkPayment.field_payment.length === 1) {
      Renew.getRenewPayment(this.payment.service_id, this)
    }
  },
  computed: {
    paymentType () {
      return [
        {
          text: this.$i18n.locale === 'bn' ? 'অনলাইন' : 'Online',
          value: 1
        },
        {
          text: this.$i18n.locale === 'bn' ? 'অফলাইন' : 'Offline',
          value: 2
        }
      ]
    }
  },
  methods: {
      setPicker () {
        flatpickr('.datepic', {})
      },
      getTotal (data) {
        const total = data.filter(item => item.is_choose_payment === true).reduce(function (a, b) {
          return parseFloat(a) + parseFloat(b.amount)
        }, 0)
        this.total_amount = total
        return total
      },
      getTotalVat (data) {
        const total = data.filter(item => item.is_choose_payment === true).reduce(function (a, b) {
          return parseFloat(a) + parseFloat(b.amount_vat)
        }, 0)
        this.total_vat = total
        return total
      },
      getTotalTax (data) {
        const total = data.filter(item => item.is_choose_payment === true).reduce(function (a, b) {
          return parseFloat(a) + parseFloat(b.amount_tax)
        }, 0)
        this.total_tax = total
        return total
      },
      getPayment () {
        const fees = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepFeeList.filter(item => item.step_id === parseInt(this.payment.step_id) && item.service_id === parseInt(this.payment.service_id) && item.fee_id !== 0 && item.lab_fee === 0)
          if (fees.length) {
            this.allPayment = JSON.parse(JSON.stringify(fees)).map(item => {
              const vat = (item.amount * (item.vat ? parseInt(item.vat) : 0)) / 100
              const tax = (item.amount * (item.tax ? parseInt(item.tax) : 0)) / 100
              return Object.assign(item,
              {
                amount_vat: vat,
                amount_tax: tax,
                bank_name: '',
                bank_name_tax: '',
                bank_name_vat: '',
                branch_name: '',
                branch_name_tax: '',
                branch_name_vat: '',
                challan_no: '',
                challan_no_tax: '',
                challan_no_vat: '',
                pay_date: '',
                pay_date_vat: '',
                pay_date_tax: '',
                amount_type: 1,
                fee_name: '',
                is_choose_payment: true
              })
            })
          }
      },
      getFeeName (fee) {
        if (!fee.fee_name) {
          if (this.payment.application_type === 2) {
            if (fee.amount_type === 6) {
              return this.$t('externalLrcpn.expire_fee')
            } else {
              return this.$t('externalLrcpn.renew_fee')
            }
          }
          const fees = this.$store.state.ExternalUserService.dealerPanel.commonObj.feeNamesList.find(item => item.value === fee.fee_id)
          if (typeof fees === 'undefined') {
              return ''
          } else {
              return fees.text
          }
        } else {
          return (this.$i18n.locale === 'bn') ? fee.fee_name_bn : fee.fee_name
        }
      },
      async typeWithCheckboxPayment (serviceId, paymentField, paymentType, challanNo, isExpireAmout = 0) {
        const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
        const formId = formData.form_id
        const params = {
          id: formId,
          application_id: this.payment.application_id,
          service_id: this.payment.service_id,
          tabList: this.getTabList(),
          payment_field: paymentField,
          grid_step_id: this.getGridStep(this.payment.service_id).step_id
        }
        this.saveloading = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getTypeCheckboxPaymentList, params)
          this.saveloading = false
          if (result.success) {
            this.typeWisePaymentPush(result, paymentField, paymentType, challanNo, isExpireAmout)
          }
      },
      typeWisePaymentPush (result, paymentField, paymentType, challanNo, isExpireAmout = 0) {
        if (paymentType === 1) {
          const payment = parseInt(result.payment[paymentField])
          result.data.dropdown_options.forEach((item, index) => {
           const amount = this.getAmount(item, isExpireAmout)
            if (index === payment) {
              // 3 amount type select payment
              let amountType = 3
              if (isExpireAmout) {
                amountType = 6
              }
              this.pushPayment(amount, payment, item, amountType, challanNo)
            }
          })
        }
        if (paymentType === 2) {
          const payment = JSON.parse(result.payment[paymentField])
          this.paymentList = result.data.dropdown_options.forEach((item, index) => {
            const amount = this.getAmount(item, isExpireAmout)
            payment.forEach(fee => {
              if (index === fee) {
                // 4 amount type checkbox payment
                let amountType = 4
                if (isExpireAmout) {
                  amountType = 6
                }
                this.pushPayment(amount, fee, item, amountType, challanNo)
              }
            })
          })
        }
      },
      getAmount (item, isExpireAmout = 0) {
          let amount = 0
          if (isExpireAmout) {
            amount = this.item.expire_amount
          } else {
            amount = this.payment.application_type === 1 ? item.amount : item.renew_amount
          }
          return amount
      },
      pushPayment (amount, feeId, item, amountType, challanNo) {
          this.allPayment.push({
            step_id: this.payment.step_id,
            service_id: this.payment.service_id,
            fee_id: feeId,
            amount_type: amountType,
            amount: amount,
            amount_vat: (amount * (item.vat ? parseInt(item.vat) : 0)) / 100,
            amount_tax: (amount * (item.tax ? parseInt(item.tax) : 0)) / 100,
            vat: item.vat ? parseInt(item.vat) : 0,
            tax: item.tax ? parseInt(item.tax) : 0,
            bank_name: '',
            bank_name_tax: '',
            bank_name_vat: '',
            branch_name: '',
            branch_name_tax: '',
            branch_name_vat: '',
            ekpay_challan_no: challanNo,
            challan_no: '',
            challan_no_tax: '',
            challan_no_vat: '',
            pay_date: '',
            pay_date_vat: '',
            pay_date_tax: '',
            fee_name: item.type_name,
            fee_name_bn: item.type_name_bn,
            is_choose_payment: true
          })
      },
      getTabList () {
        const formId = this.getGridStep(this.payment.service_id).form_id
        const form = this.$store.state.ExternalUserService.dealerPanel.commonObj.dynamicFormList.find(item => item.value === formId)
        if (typeof form === 'undefined') {
          return []
        }
        return form.tabs
      },
      getGridStep (serviceId) {
        const tmpService = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
        return tmpService
      },
      async saveFormData () {
          let tmpPay = {}
          const amount = this.total_amount + this.total_vat + this.total_tax
          if (amount <= 0) {
            this.$toast.error({
              title: 'Error',
              message: 'Please choose minimum one payment.'
            })
            return false
          }
          const name = this.$store.state.Auth.authUser.name
          const email = this.$store.state.Auth.authUser.email
          if (this.history.length) {
            tmpPay = Object.assign(this.payment, { details: this.allPayment, transId: this.history[0].transaction_no, paid_type: 1, amount: amount, applicant_name: name, email: email })
          } else {
            tmpPay = Object.assign(this.payment, { details: this.allPayment, transId: '', paid_type: 1, amount: amount, applicant_name: name, email: email })
          }
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          this.$store.dispatch('ExternalUserIrrigation/mutateExternalCommonProperties', { loading: true })
          this.saveloading = true
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentStoreOnline, tmpPay)
          this.saveloading = false
          loadingState.listReload = true
          this.$store.dispatch('ExternalUserIrrigation/mutateExternalCommonProperties', { loading: false })
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            if (result.success === 2) {
              this.$toast.success({
                title: 'Success',
                message: result.message
              })
            } else {
              window.location = result.url
            }
          } else {
            this.$refs.form.setErrors(result.errors)
            this.$toast.error({
              title: 'Error',
              message: result.message
            })
          }
      },
      async checkHistory () {
        const params = {
          application_id: this.payment.application_id,
          service_id: this.payment.service_id,
          application_type: this.payment.application_type,
          step_id: this.payment.step_id,
          paid_type: 1
        }
        this.loadHistory = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/application/payment/history', params)
        this.loadHistory = false
        if (result.success) {
          const tmp = result.data.map(item => {
            return Object.assign(item, { is_choose_payment: true })
          })
          this.history = tmp
          flatpickr('.datepic', {})
        } else {
          this.history = []
        }
      },
      checkPayment () {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => item.step_id === this.payment.step_id && item.service_id === this.payment.service_id)
        return typeof tmp === 'undefined' ? { checkbox_payment: false, field_payment: false } : tmp
      },
      checkLabPayment () {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => item.step_id === this.payment.step_id && item.service_id === this.payment.service_id && item.lab_fee === 1)
        return typeof tmp === 'undefined' ? 0 : 1
      },
      async getLabPayment () {
        const params = {
          application_id: this.payment.application_id,
          service_id: this.payment.service_id
        }
        this.saveloading = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getLabPaymentFromMainPayment, params)
          this.saveloading = false
          if (result.success) {
            this.allPayment = result.data
          }
      },
      isChoosePayment (serviceId) {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.find(item => item.value === serviceId)
        return typeof tmp === 'undefined' ? false : tmp.choose_payment
      }
  }
}
</script>
