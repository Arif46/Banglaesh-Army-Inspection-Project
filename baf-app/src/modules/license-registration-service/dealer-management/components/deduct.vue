<template>
  <b-overlay :show="loadingState">
  <div class="section-wrapper">
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
            <table class="table table-borderless" style="width: 50%;margin: auto;background-color: darkgreen;color: white;">
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
              <b-col sm="6" md="6">
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
              <b-col sm="6" md="6" style="transform: translateY(4px);">
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
              <ValidationProvider name="Reason (En)" vid="reason" rules="required" v-slot="{ errors }">
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
              <b-col sm="6" md="6">
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
                <b-button type="submit" variant="danger" class="mr-2 btn-sm">{{$t('stock_management.deduct_amount')}}</b-button>
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
import { dealerPenaltyLoadAmount, dealerPenaltyDeductAmount } from '../api/routes'

  export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      valid: null,
      loadingState: true,
      amount: '',
      form: {
        deduct_amount: '',
        date: '',
        reason: '',
        reason_bn: '',
        user_id: this.$route.query.item.user_id,
        tcb_application_id: this.$route.query.item.application_id
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
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async saveUpdate () {
      this.loadingState = true
      const result = await RestApi.postData(licenseRegistrationServiceBaseUrl, dealerPenaltyDeductAmount, { form: this.form, amount: this.amount })
      if (result.success) {
        this.loadingState = false
        this.$router.push({ path: '/license-registration-service/dealer-management/manage-information/dealer-penalty' })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        }
    }
  }
}
</script>
