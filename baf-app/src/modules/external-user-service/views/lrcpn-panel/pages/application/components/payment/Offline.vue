<template>
  <b-container fluid>
    <b-overlay :show="saveloading">
        <b-col md="12" lg="12" sm="12">
          <ValidationObserver ref="from" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" >
              <div v-if="allPayment.length">
                <div v-for="(item, key) in allPayment" :key="key" class="row">
                  <div class="col-md-12">
                    <h5 class="text-center bg-success">
                          <b-form-checkbox v-if="isChoosePayment(item.service_id)"
                            class="mt-2"
                            v-model="item.is_choose_payment"
                          >{{ getFeeName(item) }}</b-form-checkbox>
                          <span v-else>{{ getFeeName(item) }}</span>
                    </h5>
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
                        <ValidationProvider name="Challan No" :vid="`challan_no`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Date" :vid="`pay_date`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Bank Name" :vid="`bank_name`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Attachment" :vid="`attachment`" :rules="item.is_choose_payment ? `required` : ``">
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
                                    @change="onChangeAttachment($event, item, key)"
                                    v-model="item.attachment"
                                    :id="'attachment' + key"
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
                        <ValidationProvider name="Challan No" :vid="`challan_no_vat`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Date" :vid="`pay_date_vat`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Bank Name" :vid="`bank_name_vat`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name_vat`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Attachment" :vid="`attachment_vat`" :rules="item.is_choose_payment ? `required` : ``">
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
                                    :id="'attachment_vat'+key"
                                    @change="onChangeAttachmentVat($event, item, key)"
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
                        <ValidationProvider name="Challan No" :vid="`challan_no_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Date" :vid="`pay_date_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Bank Name" :vid="`bank_name_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                        <ValidationProvider name="Attachment" :vid="`attachment_tax`" :rules="item.is_choose_payment ? `required` : ``">
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
                                    :id="'attachment_tax'+key"
                                    @change="onChangeAttachmentTax($event, item, key)"
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
import { paymentStoreOffline, getTypeCheckboxPaymentList, getLabPaymentFromMainPayment } from './../../../../api/routes'
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
    if (this.payment.application_type === 1 && this.checkLabPayment()) {
      this.getLabPayment()
    }
    const checkPayment = this.checkPayment(this.payment.service_id)
    if (checkPayment.field_payment.length > 1) {
      this.typeWithCheckboxPayment(this.payment.service_id, checkPayment.field_payment, 1)
    }
    if (checkPayment.checkbox_payment.length > 1) {
      this.typeWithCheckboxPayment(this.payment.service_id, checkPayment.checkbox_payment, 2)
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
      setDatePick () {
        flatpickr('.datepic', {})
      },
      onChangeAttachment (e, item, index) {
          this.getBase64(e.target.files[0]).then(res => {
            this.allPayment[index].attachment = res
          })
      },
      onChangeAttachmentVat (e, item, index) {
          this.getBase64(e.target.files[0]).then(res => {
              this.allPayment[index].attachment_vat = res
          })
      },
      onChangeAttachmentTax (e, item, index) {
          this.getBase64(e.target.files[0]).then(res => {
              this.allPayment[index].attachment_tax = res
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
                attachment: [],
                attachment_vat: [],
                attachment_tax: [],
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
      async typeWithCheckboxPayment (serviceId, paymentField, paymentType, isExpireAmout = 0) {
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
            this.typeWisePaymentPush(result, paymentField, paymentType, isExpireAmout)
          }
      },
      typeWisePaymentPush (result, paymentField, paymentType, isExpireAmout = 0) {
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
              this.pushPayment(amount, payment, item, amountType)
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
                this.pushPayment(amount, fee, item, amountType)
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
      pushPayment (amount, feeId, item, amountType) {
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
            attachment_tax: [],
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
            this.$bvModal.hide(this.payment.application_type === 1 ? 'modal-payment' : 'modal-payment-renew')
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
            this.allPayment.push(result.data)
          }
      },
      isChoosePayment (serviceId) {
        const tmp = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.find(item => item.value === serviceId)
        return typeof tmp === 'undefined' ? false : tmp.choose_payment
      }
  }
}
</script>
