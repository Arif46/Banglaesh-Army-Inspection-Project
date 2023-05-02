<template>
  <b-overlay :show="loadingState">
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12" style="text-align: center;">
        <ValidationProvider name="Had manual" vid="has_manual">
            <b-form-group
              class="row"
              label-cols-sm="12"
              label-for="has_manual"
            >
            <template v-slot:label>
                {{$t('stock_management.deduct_or_refund')}}
            </template>
            <b-form-radio-group
              v-model="form.deduct_or_refund"
              :options="manualList"
            >
            </b-form-radio-group>
            </b-form-group>
        </ValidationProvider>
      </b-col>
      <b-col lg="12" sm="12">
        <body-card style="height: 400px;">
          <template v-slot:body>
            <table v-if="form.deduct_or_refund === false" class="table table-borderless" style="width: 50%;margin: auto;background-color: darkgreen;color: white;">
              <tr>
                <th style="width: 25%"> {{$t('stock_management.security_money')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 70%">{{securitymoney}}</td>
              </tr>
            </table>
            <table v-if="form.deduct_or_refund === true" class="table table-borderless" style="width: 50%;margin: auto;background-color: darkgreen;color: white;">
              <tr>
                <th style="width: 25%"> {{$t('stock_management.amount_text')}}</th>
                <th style="width: 2%">:</th>
                <td style="width: 70%">{{amount}}</td>
              </tr>
            </table>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
          <table class="table table-borderless">
            <b-row style="width: 90%;margin: auto;">
            <b-col sm="6" md="6" v-if="form.deduct_or_refund === false">
              <ValidationProvider name="Refund amount" vid="refund_amount" rules="required" v-slot="{ errors }">
                <b-form-group
                  label-for="heading">
                  <template v-slot:label>
                    {{$t('stock_management.refund_amount')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="heading"
                    v-model="form.refund_amount"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              </b-col>
              <b-col sm="6" md="6" v-if="form.deduct_or_refund === true">
              <ValidationProvider name="Deduct amount" vid="deduct_amount" rules="required" v-slot="{ errors }">
                <b-form-group
                  label-for="heading">
                  <template v-slot:label>
                    {{$t('stock_management.deduct_amount')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="heading"
                    v-model="form.deduct_amount"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              </b-col>
              <b-col sm="6" md="6" style="transform: translateY(4px);" v-if="form.deduct_or_refund === true">
                  <b-form-group
                  label-for="heading">
                  <template v-slot:label>
                    {{$t('stock_management.fine_date')}} <span class="text-danger">*</span>
                  </template>
                  <date-picker
                      class="form-control"
                      style="transform: translateY(10px);"
                      plain
                      v-model="form.date"
                      id="date"
                    >
                  </date-picker>
                </b-form-group>
              </b-col>
              <b-col sm="6" md="6">
              <ValidationProvider name="Reason (En)" vid="reason" rules="required" v-slot="{ errors }" v-if="form.deduct_or_refund === true">
                <b-form-group
                  label-for="heading">
                  <template v-slot:label>
                    {{$t('stock_management.reason_en')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-textarea
                    id="heading"
                    v-model="form.reason"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              </b-col>
              <b-col sm="6" md="6" v-if="form.deduct_or_refund === true">
              <ValidationProvider name="Reason (Bn)" vid="heading" rules="required" v-slot="{ errors }">
                <b-form-group
                  label-for="heading">
                  <template v-slot:label>
                    {{$t('stock_management.reason_bn')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-textarea
                    id="heading"
                    v-model="form.reason_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-textarea>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
              </b-col>
            </b-row>
          </table>
          <b-row class="text-right">
            <b-col>
                <b-button v-if="form.deduct_or_refund === false" type="submit" variant="danger" class="mr-2 btn-sm">{{$t('stock_management.refund_and_cancel')}}</b-button>
                <b-button v-if="form.deduct_or_refund === true" type="submit" variant="danger" class="mr-2 btn-sm">{{$t('stock_management.deduct_and_cancel')}}</b-button>
            </b-col>
          </b-row>
        </b-form>
        </ValidationObserver>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </div>
  </b-overlay>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dealerPenaltyLoadAmount, dealerPenaltyDeductOrRefundAmount } from '../../api/routes'

  export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      valid: null,
      loadingState: true,
      securitymoney: 0,
      amount: '',
      manualList: [
        { value: true, text: this.$i18n.locale === 'bn' ? 'জরিমানা' : 'Deduct' },
        { value: false, text: this.$i18n.locale === 'bn' ? 'ফেরত' : 'Refund' }
      ],
      form: {
        deduct_amount: '',
        refund_amount: '',
        deduct_or_refund: '',
        date: '',
        reason: '',
        reason_bn: '',
        user_id: this.items.user_id,
        tcb_application_id: this.items.tcb_application_id
      },
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
    }
  },
  computed: {
  },
  created () {
    this.loadData()
  },
  methods: {
    getFormData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async loadData () {
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, dealerPenaltyLoadAmount, { userid: this.form.user_id, tcb_application_id: this.form.tcb_application_id })
      if (result.success) {
        this.amount = result.amount
        this.loadingState = false
        this.securitymoney = result.security_money
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async saveUpdate () {
      this.loadingState = true
      const result = await RestApi.postData(licenseRegistrationServiceBaseUrl, dealerPenaltyDeductOrRefundAmount, { form: this.form, amount: this.amount, type: this.form.deduct_or_refund })
      if (result.success) {
        this.loadingState = false
        this.$router.push({ path: '/license-registration-service/dealer-management/manage-information/dealer-penalty' })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('details')
        }
    }
  }
}
</script>
