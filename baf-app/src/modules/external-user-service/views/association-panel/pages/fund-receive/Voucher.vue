<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <b-col class="text-right">
            <b-button @click="pdfExport" class="btn btn-success btn-sm">
              <i class="ri-printer-line"></i>  {{  $t('globalTrans.print') }}
            </b-button>
          </b-col>
         <h4 class="card-title"> {{ $t('globalTrans.print') }} {{ $t('associationPnl.voucher') }}</h4>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.date')}} </b> : {{ items.program?.payment?.updated_at | dateFormat }}
            </b-col>
            <b-col sm="12" class="mt-2">

            </b-col>
            <b-col sm="12" class="mt-2">
              <b> {{ $t('associationPnl.receive_from')}} </b> : {{ getCouncilName(items.program.council_info_id) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.amount')}} </b> : {{ items.program?.payment == null ? $n(0):$n(items.program?.payment?.amount) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('eBizProgram.cheque_no')}} </b> : {{ items.program?.payment == null ? $n(0): $n(items.program?.payment?.cheque_no, {useGrouping:false})}}
            </b-col>
            <b-col sm="12" class="mt-2">
              <b> {{ $t('associationPnl.for')}} </b> : {{ currentLocale == 'en' ? items.program.program.programe_name_en : items.program.program.programe_name_bn }}
            </b-col>
        </b-row>
      </b-card>
    </b-overlay>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('voucher')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
import { eBizServiceBaseUrl } from '@/config/api_config'
import Pdf from './pdf'
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
    getCouncilName (councilNameId) {
            const cateObj = this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1).find(item => item.value === councilNameId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
     },
        cipTradeRejectId () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        statusText (sta) {
          const reqStatusObj = this.requestStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
        },
        pdfExport () {
          Pdf.exportPdfDetails(eBizServiceBaseUrl, '/configuration/report-heading/detail', 2, this.items, this)
        }
    }
}
</script>
