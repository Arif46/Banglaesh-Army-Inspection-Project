<template>
  <b-container fluid>
    <b-overlay :show="saveloading">
        <b-col md="12" lg="12" sm="12">
          <div class="text-center mt-2">
            <b-form-radio-group
              id="payment_type"
              v-model="type"
              :options="paymentType"
            ></b-form-radio-group>
          </div>
          <hr>
          <component :is="mycom" :payment="payment"></component>
        </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
import Online from './components/payment/Online'
import Offline from './components/payment/Offline'
import Payorder from './components/payment/Payorder'

export default {
  props: ['payment'],
  components: {
    Online,
    Offline,
    Payorder
  },
  data () {
    return {
        saveloading: false,
        loadHistory: false,
        type: 1,
        history: [],
        mycom: 'Online'
    }
  },
  watch: {
    type: function (n, o) {
      if (n !== o) {
        if (n === 1) {
          this.mycom = 'Online'
        } else if (n === 2) {
          this.mycom = 'Offline'
        } else {
          this.mycom = 'Payorder'
        }
      }
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
        },
        {
          text: this.$i18n.locale === 'bn' ? 'পে-অর্ডার' : 'Pay Order',
          value: 3
        }
      ]
    }
  }
}
</script>
