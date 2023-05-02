<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <h4 class="card-title">{{ $t('associationPnl.program') }} {{ $t('globalTrans.details') }}</h4>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.proposal_no')}} </b> : {{ items.program?.program?.proposal?.proposal_id }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.program_no')}} </b> : {{ $n(items.program_id, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.program_name')}} </b> : {{ currentLocale === 'bn' ? items.program.program.programe_name_bn : items.program.program.programe_name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.start_date')}} </b> : {{ items.program.start_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.end_date')}} </b> : {{ items.program.end_date | dateFormat }}
            </b-col>
            <!-- <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.status')}} </b> : {{ statusText(items.program.status) }}
            </b-col> -->
        </b-row>
      </b-card>
      <b-card v-if="items.program.payment != null">
         <h4 class="card-title">{{ $t('eBizProgram.payment_details') }}</h4>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.amount')}} </b> : {{ $n(items.program.payment?.amount) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.cheque_no')}} </b> : {{ $n(items.program.payment?.cheque_no, {useGrouping:false}) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.bank_name')}} </b> : {{ getBankName(items.program.payment?.bank_id) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.branch_name')}} </b> : {{ getBranchName(items.program.payment?.branch_id) }}
            </b-col>
            <b-col sm="12" class="mt-2">
              <b> {{ $t('globalTrans.remarks')}} </b> : {{ currentLocale === 'bn' ? items.program.payment?.remarks_bn : items.program.payment?.remarks_en }}
            </b-col>
        </b-row>
      </b-card>
      <!-- -----------------End----------------------- -->
    </b-overlay>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
// import { eBizServiceBaseUrl } from '@/config/api_config'
import { eBizServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      grand_total: 0.00,
      valid: null,
      allExpHeads: [],
      arrAdvPaymentData: [],
      loading: false
    }
  },
  created () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    requestStatusList: function () {
      const list = [
            { value: 1, text: this.$i18n.locale === 'en' ? 'Draft' : 'খসড়া' },
            { value: 2, text: this.$i18n.locale === 'en' ? 'Pending' : 'অপেক্ষমাণ' },
            { value: 3, text: this.$i18n.locale === 'en' ? 'Processing' : 'প্রক্রিয়াধীন' },
            { value: 4, text: this.$i18n.locale === 'en' ? 'Approved' : 'অনুমোদিত' },
            { value: 5, text: this.$i18n.locale === 'en' ? 'Agreement' : 'চুক্তি' }
            ]
           return list
    }
  },
  methods: {
        // getBankName () {

        // },
         getBankName (bankId) {
          const cateObj = this.$store.state.CommonService.commonObj.bankList.filter(item => item.status === 1).find(item => item.value === bankId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
        },
         getBranchName (bankId) {
          const cateObj = this.$store.state.CommonService.commonObj.branchList.filter(item => item.status === 1).find(item => item.value === bankId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
        },
        statusText (sta) {
          const reqStatusObj = this.requestStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
        }
    }
}
</script>
