<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <template v-slot:headerTitle>
         <h4 class="card-title">{{ $t('associationPnl.program_request') }}</h4>
        </template>
        <b-row>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.proposal_no')}} </b> : {{ items.program?.program?.proposal?.proposal_id }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.program_no')}} </b> : {{ $n(items.proposal_detail_id) }}
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
      <!-- ------------------------------------------- -->
      <br/>
      <b-card>
        <template>
         <h4 class="card-title fw-bold">{{ $t('associationPnl.final_bill') }}</h4>
        </template>
          <b-col md="8" sm="12">
           <div class="table-wrapper table-responsive table-borderless">
            <table class="table">
                <tbody>
                    <tr>
                      <td style="width:50%">{{ $t('associationPnl.approve_budget')}} {{ $t('associationPnl.vat_and_tax')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(this.items.program.program.approve_amount) }}</td>
                    </tr>
                    <tr>
                      <td style="width:50%">{{ $t('associationPnl.actual_expenditure')}} {{ $t('associationPnl.vat_and_tax')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(this.items.total_approve) }}</td>
                    </tr>
                    <tr>
                      <td style="width:50%">{{ $t('associationPnl.bpc_payable_actual_expense')}} {{$t('associationPnl.value')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(items.final_payable_approve) }}</td>
                    </tr>
                    <tr>
                      <td style="width:50%">{{ $t('associationPnl.advanced_payment')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{$n(advance_paid)}}</td>
                    </tr>
                    <hr>
                    <tr>
                      <td style="width:50%"> {{ $t('associationPnl.balance')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(firstBalance) }}</td>
                    </tr>
                    <tr>
                      <td style="width:50%"> {{ $t('associationPnl.vat_deducted')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(items.vat) }}</td>
                    </tr>
                    <hr>
                    <tr>
                      <td style="width:50%"> {{ $t('associationPnl.balance')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(secondBalance ) }}</td>
                    </tr>
                    <tr>
                      <td style="width:50%"> {{ $t('associationPnl.tax_deducted')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right">{{ $n(items.tax) }}</td>
                    </tr>
                    <hr>
                    <tr>
                      <td class="fw-bold" style="width:50%"> {{ $t('associationPnl.final_bill')}}</td>
                      <td style="width:10%">:</td>
                      <td style="width:20%" class="text-right fw-bold">{{ $n(thirdBalance) }}</td>
                    </tr>
                </tbody>
            </table>
          </div>
          </b-col>
      </b-card>
      <!-- ------------------------------------------- -->
    </b-overlay>
        <b-row class="text-right mt-3">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('view-bill')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
    </div>
</template>
<script>
// import { eBizServiceBaseUrl } from '@/config/api_config'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programHeadItemList } from '../../api/routes'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      grand_total: 0.00,
      valid: null,
      advance_paid: 0,
      firstBalance: 0,
      secondBalance: 0,
      thirdBalance: 0,
      allExpHeads: [],
      arrAdvPaymentData: [],
      loading: false
    }
  },
  created () {
    // if (this.id) {
    //   const tmp = this.cipTradeRejectId()
    //   this.detailsData = tmp
    // }
    if (this.items.id) {
      this.loadExpence()
      this.advance_paid = this.items.program.adv_payments.reduce((sum = 0, item) => sum + item.amount, 0)
      this.firstBalance = parseFloat(this.items.final_payable_approve) - parseFloat(this.advance_paid)
      this.secondBalance = parseFloat(this.firstBalance) - parseFloat(this.items.vat_approve)
      this.thirdBalance = parseFloat(this.secondBalance) - parseFloat(this.items.tax_approve)
    }
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
        cipTradeRejectId () {
            const tmpData = this.$store.state.list.find(item => item.id === this.id)
            return JSON.parse(JSON.stringify(tmpData))
        },
        statusText (sta) {
          const reqStatusObj = this.requestStatusList.find(tlaw => tlaw.value === parseInt(sta))
          return reqStatusObj.text
        },
        async loadExpence () {
          this.loading = true
          let result = null
          const params = Object.assign({}, { program_id: this.items.program.id })
          result = await RestApi.getData(eBizServiceBaseUrl, programHeadItemList, params)
          // var tagArr = []
          if (result.success) {
              if (result.data.length > 0) {
                this.allExpHeads = result.data
                this.arrAdvPaymentData = result.advPayments
                this.programList = result.data.map(hdItem => {
                  // --------------------------------------
                  hdItem.expenceitems.map(item => {
                    this.grand_total += parseFloat(item.total_amount)
                  })
                  // --------------------------------------
                })
              }
              this.loading = false
          } else {
              this.loading = false
          }
        }
    }
}
</script>
