<template>
  <b-container fluid>
    <b-overlay :show="saveloading">
      <b-col md="12" lg="12" sm="12">
          <ValidationObserver ref="from" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" autocomplete="off">
              <div v-if="payments.length">
                <div v-for="(item, key) in payments" :key="key" class="row">
                  <div class="col-md-12">
                    <table class="table table-bordered table-sm">
                      <tbody>
                        <tr>
                            <th>{{ $t('fee_name.fee_name') }}</th>
                            <th>{{ $t('globalTrans.amount') }}</th>
                            <th>{{ $t('globalTrans.vat') }} (%) </th>
                            <th>{{ $t('globalTrans.tax') }} (%) </th>
                        </tr>
                        <tr>
                          <td>{{ $i18n.locale === 'en' ? item.text_en : item.text_bn }}</td>
                          <td>{{ $n(item.amount) }}</td>
                          <td>({{ $n(item.vat) }}%) = {{ $n(item.amount_vat) }}</td>
                          <td>({{ $n(item.tax) }}%) = {{ $n(item.amount_tax) }}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="col-md-12">
                    <h6 class="mt-3 mb-2"><b>{{ $i18n.locale === 'en' ? item.text_en : item.text_bn }} : ({{ $n(item.amount) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="`challan_no`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.challan_no') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Date" :vid="`pay_date`+key" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                :label-for="`pay_date`+key"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-datepicker
                                    :id="`pay_date`+key"
                                    v-model="item.pay_date"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-datepicker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="`bank_name`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.bank_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.branch_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Attachment" :vid="`attachment`" :rules="`required`">
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
                                    @change="onChange($event, key)"
                                    v-model="item.attachment"
                                    name="attachment"
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
                    <h6 class="mt-3 mb-2"><b>{{ $i18n.locale === 'en' ? item.text_en : item.text_bn }} ({{ $t('globalTrans.vat') }}) : ({{ $n(item.amount_vat) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="`challan_no_vat`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.challan_no') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Date" :vid="`pay_date_vat`" :rules="`required`">
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
                                <b-form-datepicker b-form-datepicker
                                    id="pay_date_vat"
                                    class="datepic"
                                    v-model="item.pay_date_vat"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-datepicker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="`bank_name_vat`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.bank_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name_vat`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name_vat"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.branch_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Attachment" :vid="`attachment_vat`" :rules="`required`">
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
                                    @change="onChange($event, key)"
                                    name="attachment_vat"
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
                    <h6 class="mt-3 mb-2"><b>{{ $i18n.locale === 'en' ? item.text_en : item.text_bn }} ({{ $t('globalTrans.tax') }}) : ({{ (item.amount_tax) }})</b></h6>
                    <div class="row">
                      <div class="col-md-6">
                        <ValidationProvider name="Challan No" :vid="`challan_no_tax`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="challan_no_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.challan_no') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Date" :vid="`pay_date_tax`" :rules="`required`">
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
                                <b-form-datepicker b-form-datepicker
                                    id="pay_date_tax"
                                    class="datepic"
                                    v-model="item.pay_date_tax"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-datepicker>
                                <div class="invalid-feedback">
                                    {{ errors[0] }}
                                </div>
                            </b-form-group>
                          </ValidationProvider>
                      </div>
                      <div class="col-md-6">
                        <ValidationProvider name="Bank Name" :vid="`bank_name_tax`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="bank_name_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.bank_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Branch Name" :vid="`branch_name_tax`" :rules="`required`">
                            <b-form-group
                                class="row"
                                label-cols-sm="3"
                                label-for="branch_name_tax"
                                slot-scope="{ valid, errors }"
                                style="font-size: 13px"
                            >
                                <template v-slot:label>
                                    {{ $t('dealer.branch_name') }} <span class="text-danger">*</span>
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
                        <ValidationProvider name="Attachment" :vid="`attachment_tax`" :rules="`required`">
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
                                    @change="onChange($event, key)"
                                    name="attachment_tax"
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
                      <b-button type="submit" variant="primary" class="mr-2 btn-sm">{{ $t('dealer.payment') }}</b-button>
                      <b-button variant="danger" class="mr-1 btn-sm" @click="$bvModal.hide('payment')">{{ $t('globalTrans.cancel') }}</b-button>
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
import { paymentOfflineStore } from '../api/routes'
import { EventBus } from '@/EventBusLayout'

export default {
  props: ['payments'],
  data () {
    return {
        saveloading: false
    }
  },
  created () {
  },
  computed: {
    commonProfile () {
      return this.$store.state.Auth.commonProfile
    },
    auth () {
      return this.$store.state.Auth.authUser
    }
  },
  methods: {
    onChange (e, index) {
      const selectedFile = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.payments[index][e.target.name] = event.target.result
      }
      reader.readAsDataURL(selectedFile)
    },
    async saveFormData () {
        let result = null
        this.saveloading = true
        const paymentData = {
        tcb_application_id: this.payments[0].tcb_application_id,
        applicant_name: this.auth.name,
        mobile_no: this.auth.mobile,
        address: this.commonProfile.pm_village_en,
        payments: this.payments,
        amount: this.calculateAmount(this.payments)
        }
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentOfflineStore, paymentData)
        this.saveloading = false
        if (result.success) {
            this.$toast.success({
                title: 'Success',
                message: 'Payment Paid Success.'
            })
            this.$bvModal.hide('payment')
            EventBus.$emit('offlinePaymentSubmit')
        } else {
            this.$refs.form.setErrors(result.errors)
            this.$toast.error({
                title: 'Error',
                message: 'Payment Paid failed.'
            })
        }
    },
    calculateAmount (payments) {
      const sum = payments.reduce((amount, object) => {
        return amount + object.amount
      }, 0)

      return sum
    }
  }
}
</script>
