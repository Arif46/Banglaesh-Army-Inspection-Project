<template>
<div>
  <b-row v-if="old_app_loading">
    <b-col md="12" lg="12" sm="12">
      <b-skeleton-table
        :rows="2"
        :columns="2"
        :table-props="{ bordered: true, striped: true }"
      ></b-skeleton-table>
    </b-col>
  </b-row>
  <b-row v-else>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import OnlinePayment from '../../components/paymentComponent/PaymentOnline.vue'
import OfflinePayment from '../../components/paymentComponent/PaymentOffline.vue'
import moment from 'moment'

export default {
  props: ['application'],
  name: 'Payment',
  components: {
    OnlinePayment,
    OfflinePayment
  },
  data () {
    return {
      old_app_loading: false,
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
      if (this.application.applications.type === 1) {
        return this.$store.state.LicenseRegistrationService.commonObj.paymentTypeList.filter(item => (item.value !== 4 && item.value !== 5 && item.step_id === parseInt(this.application.applications.status)))
      } else {
        return this.$store.state.LicenseRegistrationService.commonObj.paymentTypeList.filter(item => (item.value === 4))
      }
    }
  },
  created () {
    this.getPaymentList()
    this.getOldAppData()
  },
  methods: {
    getPaymentList () {
      const mytemp = this.paymentList
      const datas = []
       mytemp.forEach(item => {
        const fee = item
        const tmp = Object.assign(fee,
          {
            tcb_application_id: this.application.applications.id,
            paid_type: this.type,
            payment_type: fee.value,
            vat: 0,
            tax: 0,
            amount_vat: 0,
            amount_tax: 0,
            pay_date: ''
          })
        datas.push(tmp)
      })
      this.payments = datas
    },
    async getOldAppData () {
      this.old_app_loading = true
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `/manage-information/renew/old-application/${this.application.applications.old_tcb_application_id}`)
      this.old_app_loading = false
      if (result.success) {
        const fee = this.$store.state.LicenseRegistrationService.commonObj.paymentTypeList.find(item => item.value === 5)
        const years = moment().diff(result.data.expire_date, 'years', false)
        if (years > 0) {
          const amount = fee.amount * years
          const amountVat = (amount * 15) / 100
          const amountTax = (amount * 10) / 100
          const tmp = Object.assign(fee,
          {
            tcb_application_id: this.application.id,
            paid_type: this.type,
            payment_type: fee.value,
            vat: 15,
            tax: 10,
            amount_vat: amountVat,
            amount_tax: amountTax,
            amount: amount,
            pay_date: ''
          })
          this.payments.push(tmp)
        }
      }
    }
  }
}
</script>
