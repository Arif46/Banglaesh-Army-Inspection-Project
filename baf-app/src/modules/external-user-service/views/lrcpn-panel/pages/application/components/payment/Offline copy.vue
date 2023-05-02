<template>
  <b-container fluid>
    <b-overlay :show="saveloading">
        <b-col md="12" lg="12" sm="12">
          <ValidationObserver ref="from" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" >
              <div v-if="allPayment.length">
                <div v-for="(item, index) in allPayment" :key="index" class="row">
                  <div class="col-md-12">
                    <h5 class="text-center bg-success">{{ getFeeName(item) }}</h5>
                    <table class="table table-bordered table-sm">
                      <tr>
                          <th>{{ $t('fee_name.fee_name') }}</th>
                          <th>{{ $t('globalTrans.amount') }}</th>
                          <th>{{ $t('globalTrans.vat') }} (%) </th>
                          <th>{{ $t('globalTrans.tax') }} (%) </th>
                      </tr>
                      <tr>
                        <td>{{ getFeeName(item) }}</td>
                        <td>{{ $n(item.amount) }}</td>
                        <td>({{ $n(item.vat) }}%) = {{ (item.amount_vat) }}</td>
                        <td>({{ $n(item.tax) }}%) = {{ (item.amount_tax) }}</td>
                      </tr>
                    </table>
                  </div>
                  <div class="col-md-12">
                    <h6 class="mt-3 mb-2"><b>{{ getFeeName(item) }} : ({{ (item.amount) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="index + `challan_no`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.challan_no') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="challan_no"
                                    v-model="item.challan_no"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Date" :vid="index + `pay_date`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="pay_date"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="pay_date"
                                    class="datepic"
                                    v-model="item.pay_date"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="index + `bank_name`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.bank_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="bank_name"
                                    v-model="item.bank_name"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Branch Name" :vid="index + `branch_name`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.branch_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="branch_name"
                                    v-model="item.branch_name"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Attachment" :vid="index + `attachment`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="attachment"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.attachment') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-file
                                    id="attachment"
                                    @change="onChangeAttachment($event, item)"
                                    v-model="item.attachment"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-12" v-if="item.vat">
                    <h6 class="mt-3 mb-2"><b>{{ getFeeName(item) }} ({{ $t('globalTrans.vat') }}) : ({{ $n(item.amount_vat) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="index + `challan_no_vat`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.challan_no') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="challan_no_vat"
                                    v-model="item.challan_no_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Date" :vid="index + `pay_date_vat`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="pay_date_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="pay_date_vat"
                                    class="datepic"
                                    v-model="item.pay_date_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="index + `bank_name_vat`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.bank_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="bank_name_vat"
                                    v-model="item.bank_name_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Branch Name" :vid="index + `branch_name_vat`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.branch_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="branch_name_vat"
                                    v-model="item.branch_name_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Attachment" :vid="index + `attachment_vat`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="attachment_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.attachment') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-file
                                    id="attachment_vat"
                                    @change="onChangeAttachmentVat($event, item)"
                                    v-model="item.attachment_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                    </div>
                  </div>
                  <div class="col-md-12" v-if="item.tax">
                    <h6 class="mt-3 mb-2"><b>{{ getFeeName(item) }} ({{ $t('globalTrans.tax') }}) : ({{ (item.amount_tax) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="index + `challan_no_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.challan_no') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="challan_no_tax"
                                    v-model="item.challan_no_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Date" :vid="index + `pay_date_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="pay_date_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="pay_date_tax"
                                    class="datepic"
                                    v-model="item.pay_date_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="index + `bank_name_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.bank_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="bank_name_tax"
                                    v-model="item.bank_name_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Branch Name" :vid="index + `branch_name_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.branch_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="branch_name_tax"
                                    v-model="item.branch_name_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Branch Name" :vid="index + `branch_name_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('externalLrcpn.branch_name') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-input
                                    id="branch_name_tax"
                                    v-model="item.branch_name_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Attachment" :vid="index + `attachment_tax`" rules="required">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="attachment_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.attachment') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-file
                                    id="attachment_tax"
                                    @change="onChangeAttachmentTax($event, item)"
                                    v-model="item.attachment_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-file>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                    </div>
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
import { paymentStoreOffline, getTypePaymentList, getCheckboxPaymentList } from './../../../../api/routes'
import flatpickr from 'flatpickr'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import Renew from './renew'

export default {
  props: ['payment'],
  components: {
    ValidationObserver,
    ValidationProvider
  },
  data () {
    return {
        saveloading: false,
        type: 1,
        allPayment: []
    }
  },
  mounted () {
    setTimeout(this.setDatePick(), 3000)
  },
  created () {
    if (this.payment.application_type === 1) {
      this.getPayment()
    }
    const checkPayment = this.checkPayment(this.payment.service_id)
    if (checkPayment.field_payment) {
      this.typePayment(this.payment.service_id)
    }
    if (checkPayment.checkbox_payment) {
      this.checkboxPayment(this.payment.service_id)
    }
    if (this.payment.application_type === 2) {
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
      setDatePick () {
        flatpickr('.datepic', {})
      },
      onChangeAttachment (e, item) {
            this.getBase64(e.target.files[0]).then(res => {
              item = Object.assign(item, { attachment: '' })
              item.attachment = res
            })
      },
      onChangeAttachmentVat (e, item) {
            this.getBase64(e.target.files[0]).then(res => {
                item = Object.assign(item, { attachment_vat: res })
                item.attachment_vat = res
            })
      },
      onChangeAttachmentTax (e, item) {
            this.getBase64(e.target.files[0]).then(res => {
                item = Object.assign(item, { attachment_tax: res })
                item.attachment_tax = res
            })
      },
      getBase64 (file) {
            return new Promise(function (resolve, reject) {
                const reader = new FileReader()
                let imgResult = ''
                reader.readAsDataURL(file)
                reader.onload = function () {
                    imgResult = reader.result
                }
                reader.onerror = function (error) {
                    reject(error)
                }
                reader.onloadend = function () {
                    resolve(imgResult)
                }
            })
        },
      getPayment () {
        const fees = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepFeeList.filter(item => item.step_id === parseInt(this.payment.step_id) && item.service_id === parseInt(this.payment.service_id) && item.fee_id !== 0)
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
                attachment: [],
                attachment_vat: [],
                attachment_tax: []
              })
            })
          }
      },
      getFeeName (fee) {
        if (!fee.fee_name) {
          if (this.payment.application_type === 2) {
            return this.$t('externalLrcpn.renew_fee')
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
      async typePayment (serviceId) {
        const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
        const formId = formData.form_id
        const params = {
          id: formId,
          application_id: this.payment.application_id,
          service_id: this.payment.service_id,
          tabList: this.getTabList(),
          grid_step_id: this.getGridStep(this.payment.service_id).step_id
        }
        this.saveloading = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getTypePaymentList, params)
          this.saveloading = false
          if (result.success) {
            const payment = parseInt(result.payment.payment)
             this.paymentList = result.data.dropdown_options.forEach((item, index) => {
              const amount = this.payment.application_type === 1 ? item.amount : item.renew_amount
              if (index === payment) {
                this.allPayment.push({
                  step_id: this.payment.step_id,
                  service_id: this.payment.service_id,
                  fee_id: payment,
                  amount_type: 2,
                  amount: amount,
                  amount_vat: (item.amount * (item.vat ? parseInt(item.vat) : 0)) / 100,
                  amount_tax: (item.amount * (item.tax ? parseInt(item.tax) : 0)) / 100,
                  vat: item.vat ? parseInt(item.vat) : 0,
                  tax: item.tax ? parseInt(item.tax) : 0,
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
                  fee_name: item.type_name,
                  fee_name_bn: item.type_name_bn,
                  attachment: [],
                  attachment_vat: [],
                  attachment_tax: []
                })
              }
            })
          } else {
            this.paymentList = []
          }
      },
      async checkboxPayment (serviceId) {
        const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
        const formId = formData.form_id
        const params = {
          id: formId,
          application_id: this.payment.application_id,
          service_id: this.payment.service_id,
          tabList: this.getTabList(),
          grid_step_id: this.getGridStep(this.payment.service_id).step_id
        }
        this.saveloading = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, getCheckboxPaymentList, params)
          this.saveloading = false
          if (result.success) {
            const payment = JSON.parse(result.payment_checkbox.payment_checkbox)
            this.paymentList = result.data.dropdown_options.forEach((item, index) => {
              const amount = this.payment.application_type === 1 ? item.amount : item.renew_amount
              payment.forEach(fee => {
                if (index === fee) {
                  this.allPayment.push({
                    step_id: this.payment.step_id,
                    service_id: this.payment.service_id,
                    fee_id: fee,
                    amount_type: 3,
                    amount: amount,
                    amount_vat: (item.amount * (item.vat ? parseInt(item.vat) : 0)) / 100,
                    amount_tax: (item.amount * (item.tax ? parseInt(item.tax) : 0)) / 100,
                    vat: item.vat ? parseInt(item.vat) : 0,
                    tax: item.tax ? parseInt(item.tax) : 0,
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
                    fee_name: item.type_name,
                    fee_name_bn: item.type_name_bn,
                    attachment: [],
                    attachment_vat: [],
                    attachment_tax: []
                  })
                }
              })
            })
          } else {
            this.paymentList = []
          }
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
      async saveFormData (type) {
          let tmpPay = {}
          if (type === 2) {
            tmpPay = Object.assign(this.payment, { details: this.allPayment, transId: 1, paid_type: 2 })
          } else {
            tmpPay = Object.assign(this.payment, { details: this.allPayment, transId: '', paid_type: 2 })
          }
          let result = null
          this.saveloading = true
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentStoreOffline, tmpPay)
          this.saveloading = false
          this.$store.dispatch('ExternalLrcpn/setLaodList', { listLoad: true })
          if (result.success) {
            this.$toast.success({
              title: 'Success',
              message: result.message
            })
            this.$bvModal.hide('modal-payment')
          } else {
            this.$refs.form.setErrors(result.errors)
            this.$toast.error({
              title: 'Error',
              message: result.message
            })
          }
      },
      checkPayment () {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => item.step_id === this.payment.step_id && item.service_id === this.payment.service_id)
        return typeof tmp === 'undefined' ? { checkbox_payment: false, field_payment: false } : tmp
      }
  }
}
</script>
