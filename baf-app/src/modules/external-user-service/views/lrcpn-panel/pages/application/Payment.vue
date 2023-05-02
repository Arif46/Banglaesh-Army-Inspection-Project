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
            <table v-if="history.length" class="table table-bordered">
              <tr>
                <th colspan="4" class="text-center">History</th>
              </tr>
                <tr>
                    <th>{{ $t('fee_name.fee_name') }}</th>
                    <th>{{ $t('globalTrans.amount') }}</th>
                    <th>{{ $t('globalTrans.status') }}</th>
                    <th>{{ $t('globalTrans.action') }}</th>
                </tr>
                <tr v-for="(item, index) in history" :key="index">
                    <td>{{ getFeeName(item.fee_id) }}</td>
                    <td>{{ $n(item.amount) }}</td>
                    <td>
                      <span class="badge badge-success" v-if="item.pay_status === 'success'">{{ $t('globalTrans.success') }}</span>
                      <span class="badge badge-warning" v-else>{{ $t('globalTrans.pending') }}</span>
                    </td>
                    <td class="text-center">
                      <b-button v-if="item.pay_status === 'pending'" @click="saveFormData(2, item.transaction_no)" variant="primary" class="mr-2 btn-sm">{{ $t('externalLrcpn.pay_now') }}</b-button>
                      <p v-else class="badge badge-success">{{ $t('globalTrans.paid') }}</p>
                    </td>
                </tr>
            </table>
            <table v-else class="table table-bordered">
                <tr>
                    <th>{{ $t('fee_name.fee_name') }}</th>
                    <th>{{ $t('globalTrans.amount') }}</th>
                    <th>{{ $t('globalTrans.action') }}</th>
                </tr>
                <tr>
                    <td>{{ getFeeName(payment.fee_id) }}</td>
                    <td>{{ $n(payment.amount) }}</td>
                    <td class="text-center">
                      <b-button @click="saveFormData(1)" variant="primary" class="mr-2 btn-sm">{{ $t('externalLrcpn.pay_now') }}</b-button>
                    </td>
                </tr>
            </table>
            <div class="row mt-3">
                <div class="col-md-12 text-right">
                    <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('modal-payment')">{{ $t('globalTrans.cancel') }}</b-button>
                </div>
            </div>
        </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { paymentStore } from './../../api/routes'
export default {
  props: ['payment'],
  components: {
  },
  data () {
    return {
        saveloading: false,
        loadHistory: false,
        history: []
    }
  },
  created () {
    this.checkHistory()
  },
  methods: {
      async checkHistory () {
        const params = {
          application_id: this.payment.application_id,
          service_id: this.payment.service_id,
          payment_type: 2
        }
        this.loadHistory = true
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/application/payment/history', params)
        this.loadHistory = false
        if (result.success) {
          this.history = result.data
        } else {
          this.history = []
        }
      },
      getFeeName () {
          const fee = this.$store.state.ExternalUserService.dealerPanel.commonObj.feeNamesList.find(item => item.value === this.payment.fee_id)
        if (typeof fee === 'undefined') {
            return ''
        } else {
            return fee.text
        }
      },
      async saveFormData (type, transId = '') {
          let tmpPay = {}
          if (type === 2) {
            tmpPay = Object.assign(this.payment, { transId: transId })
          } else {
            tmpPay = Object.assign(this.payment, { transId: '' })
          }
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          this.$store.dispatch('ExternalUserIrrigation/mutateExternalCommonProperties', { loading: true })
          this.saveloading = true
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentStore, tmpPay)
          this.saveloading = false
          loadingState.listReload = true
          this.$store.dispatch('ExternalUserIrrigation/mutateExternalCommonProperties', { loading: false })
          this.$store.dispatch('mutateCommonProperties', loadingState)
          this.$bvModal.hide('modal-payment')
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
      }
  }
}
</script>
