<template>
  <div>
    <b-row class="mb-3">
      <b-col sm="12">
      <!-- <pre>{{ appDetail.pay_status }}</pre> -->
        <div class="mt-1">
          <div>
            <h6 class="mb-3 tag">{{ $t('dealer.actions') }}</h6>
          </div>
          <b-button v-if="appDetail.pay_status === 0" v-b-modal.payment class="btn-sm" variant="warning">{{ $t('dealer.pay') }}</b-button>&nbsp;
          <b-button v-if="appDetail.pay_status > 0" v-b-modal.receipt class="btn-sm" variant="primary">{{ $t('dealer.receipt') }}</b-button>&nbsp;
          <b-button v-if="appDetail.review_status === 0 && appDetail.agreement_no" v-b-modal.modal-form class="btn-sm" variant="success">{{ $t('globalTrans.review') }}</b-button>&nbsp;
          <b-button v-if="isRenewButton" @click="enableRenew()" class="btn-sm" variant="info">{{ $t('dealer.renew') }} </b-button>&nbsp;
          <b-button v-if="isExpiredStatus" class="btn-sm" variant="info">{{ $t('dealer.expire_status')}} </b-button>
        </div>
      </b-col>
    </b-row>
    <div>
    <b-modal id="payment" size="lg" :title="$t('dealer.payment')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Payment :application="appDetail" />
    </b-modal>
    <b-modal id="modal-form" size="lg" :title="$t('globalTrans.review')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Review :application="appDetail" />
    </b-modal>
    <b-modal id="receipt" size="lg" :title="$t('dealer.receipt')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Receipt :application="appDetail" />
    </b-modal>
  </div>
  </div>
</template>
<script>
import Payment from './Payment.vue'
import Review from './Review.vue'
import Receipt from './Receipt.vue'
import moment from 'moment'

export default {
  props: ['appDetail'],
  name: 'Action',
  components: {
    Payment,
    Review,
    Receipt
  },
  data () {
    return {
      loading: false,
      isRenewButton: false,
      isExpiredStatus: false
    }
  },
  created () {
    this.checkRenewStatus()
  },
  computed: {
  },
  methods: {
    checkRenewStatus () {
      const expiredDate = this.appDetail.expire_date
      const currentDate = moment().format('YYYY-MM-DD')
      const expireNextDate = moment(expiredDate).add(1, 'day').format('YYYY-MM-DD')
      const expirePrevMonthDate = moment(expireNextDate).subtract(1, 'month').format('YYYY-MM-DD')
      const expireNextYearDate = moment(expiredDate).add(365, 'day').format('YYYY-MM-DD')
      const isBetween = moment(currentDate).isBetween(expirePrevMonthDate, expireNextYearDate, undefined, '[]')
      if (moment(currentDate).isAfter(expireNextYearDate)) {
        this.isExpiredStatus = true
      } else {
        this.isExpiredStatus = false
      }
      if (isBetween && this.appDetail.agreement_no) {
        this.isRenewButton = true
      } else {
        this.isRenewButton = false
      }
    },
    enableRenew () {
      this.$emit('enableRenew')
    }
  }
}
</script>
