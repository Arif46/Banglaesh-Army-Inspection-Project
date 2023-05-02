<template>
  <b-col md="10" lg="10" sm="12" offset-md="1">
    <b-overlay :show="loading">
      <table class="table table-striped table-hover table-sm table-bordered">
        <tbody>
          <tr>
              <th>{{ $t('dealer.fee_name') }}</th>
              <th>{{ $t('globalTrans.amount') }}</th>
              <th>{{ $t('globalTrans.vat') }} (%) </th>
              <th>{{ $t('globalTrans.tax') }} (%) </th>
          </tr>
          <tr v-for="(item, index) in payments" :key="index">
            <td>
              {{ $i18n.locale === 'bn' ? item.text_bn : item.text_en }}
            </td>
            <td>
              {{ $n( item.amount) }}
            </td>
            <td>({{ $n(item.vat) }}%) = {{ $n(item.amount_vat) }}</td>
            <td>({{ $n(item.tax) }}%) = {{ $n(item.amount_tax) }}</td>
          </tr>
        </tbody>
      </table>
      <div class="row mt-3">
          <div class="col-md-12 text-right">
              <b-button v-if="payments.length" variant="primary" class="mr-1 mt-3 btn-sm" @click="saveFormData()">{{ $t('dealer.payment') }}</b-button>
              <b-button variant="danger" class="mr-1 mt-3 btn-sm" @click="$bvModal.hide('payment')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
      </div>
    </b-overlay>
  </b-col>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paymentOnlineStore } from '../api/routes'
export default {
  props: ['payments'],
  name: 'PaymentOnline',
  components: {
  },
  data () {
    return {
      loading: false
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
    async saveFormData () {
          let result = null
          this.loading = true
          const paymentData = {
            tcb_application_id: this.payments[0].tcb_application_id,
            applicant_name: this.auth.name,
            mobile_no: this.auth.mobile,
            address: this.commonProfile.pm_village_en,
            payments: this.payments,
            amount: this.calculateAmount(this.payments)
          }
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentOnlineStore, paymentData)
          this.loading = false
          if (result.success) {
            if (result.success === 2) {
              this.$toast.success({
                title: 'Success',
                message: result.message
              })
              this.$bvModal.hide('modal-payment')
            } else {
              window.location = result.url
            }
          } else {
            // this.$refs.form.setErrors(result.errors)
            this.$toast.error({
              title: 'Error',
              message: result.message
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
