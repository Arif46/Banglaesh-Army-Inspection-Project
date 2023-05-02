<template>
  <b-container fluid>
    <b-overlay>
      <b-col v-if="loadHistory" md="12" lg="12" sm="12">
         <b-skeleton-table
            :rows="4"
            :columns="4"
            :table-props="{ bordered: true, striped: true }"
          ></b-skeleton-table>
      </b-col>
      <b-col v-else md="12" lg="12" sm="12">
        <div>
          <b-tabs content-class="mt-3">
            <span v-for="(item, index) in history" :key="index">
              <b-tab :title="index" v-if="item[0].paid_type === 1">
                <Receipt :application="application" :receipt="item" :transaction_no="index" />
              </b-tab>
              <b-tab :title="index" v-if="item[0].paid_type === 2">
                <ReceiptOffline :application="application" :receipt="item" :transaction_no="index" />
              </b-tab>
            </span>
          </b-tabs>
        </div>
        <div class="row mt-3">
          <div class="col-md-12 text-right">
            <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('receipt')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
        </div>
      </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Receipt from '../../components/Receipt'
import ReceiptOffline from '../../components/ReceiptOffline'
import { paymentRecepetAll } from '../../api/routes'

export default {
  props: ['application'],
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
    this.paymentHistory()
  },
  methods: {
    setReceipt (item) {
      this.receipt = item
    },
    async paymentHistory () {
      this.loadHistory = true
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, paymentRecepetAll + '/' + this.application.id)
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
