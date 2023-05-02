<template>
  <b-container fluid>
    <b-overlay>
      <b-col v-if="loadHistory" md="12" lg="12" sm="12">
        <b-overlay :show="true" class="p-5">
          <div class="text-center">
            <h5> {{ $t('externalLrcpn.receipt_checking') }} </h5>
          </div>
        </b-overlay>
      </b-col>
      <b-col v-else md="12" lg="12" sm="12">
        <div>
          <b-tabs content-class="mt-3">
            <span v-for="(item, index) in history" :key="index">
              <b-tab :title="index" v-if="item[0].paid_type === 1">
                <Receipt :receipt="item" :transaction_no="index" />
              </b-tab>
              <b-tab :title="index" v-if="item[0].paid_type === 2 || item[0].paid_type === 3">
                <ReceiptOffline :receipt="item" :transaction_no="index" />
              </b-tab>
            </span>
          </b-tabs>
        </div>
        <div class="row mt-3">
          <div class="col-md-12 text-right">
            <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('modal-payment-receipt')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
        </div>
      </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Receipt from './components/Receipt'
import ReceiptOffline from './components/ReceiptOffline'

export default {
  props: ['payment'],
  components: {
    Receipt,
    ReceiptOffline
  },
  data () {
    return {
        loadHistory: false,
        history: [],
        receipt: {}
    }
  },
  created () {
    this.checkHistory()
  },
  methods: {
    setReceipt (item) {
      this.receipt = item
    },
    async checkHistory () {
      const params = {
        application_id: this.payment.application_id,
        service_id: this.payment.service_id
      }
      this.loadHistory = true
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, '/application/payment/all', params)
      this.loadHistory = false
      if (result.success) {
        this.history = result.data
      } else {
        this.history = []
      }
    }
  }
}
</script>
