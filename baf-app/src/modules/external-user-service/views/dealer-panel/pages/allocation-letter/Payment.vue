<template>
<div>
  <b-row>
    <b-col md="12" lg="12" sm="12" class="mb-4">
      <div class="text-center mt-2">
        <b-form-radio-group
          id="payment_type"
          v-model="type"
          :options="paidTypeList"
        ></b-form-radio-group>
      </div>
    </b-col>
    <component :is="comp" :payments="payments"></component>
  </b-row>
</div>
</template>
<script>
import OnlinePayment from '../../components/PaymentOnline.vue'
import OfflinePayment from '../../components/PaymentOffline.vue'

export default {
  props: ['application'],
  name: 'Payment',
  components: {
    OnlinePayment,
    OfflinePayment
  },
  data () {
    return {
      comp: 'OnlinePayment',
      type: 1,
      payments: []
    }
  },
    watch: {
    type: function (n, o) {
      if (n !== o) {
        if (n === 1) {
          this.comp = 'OnlinePayment'
        } else {
          this.comp = 'OfflinePayment'
        }
      }
    }
  },
  computed: {
    paidTypeList () {
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
    },
    paymentList () {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.paymentTypeList.filter(item => item.value === 6)
    }
  },
  created () {
    this.getPaymentList()
  },
  methods: {
    getPaymentList () {
      const mytemp = this.paymentList
      const datas = []
       mytemp.forEach(item => {
        const fee = item
        const tmp = Object.assign(fee,
          {
            tcb_application_id: this.application.tcb_applicant_id,
            allocation_id: this.application.id,
            paid_type: this.type,
            payment_type: fee.value,
            vat: 0,
            tax: 0,
            amount: this.application.selling_amount + this.application.tax_amount,
            amount_vat: 0,
            amount_tax: 0,
            pay_date: ''
          })
        datas.push(tmp)
      })
      this.payments = datas
    }
  }
}
</script>
