<template>
    <div>
    <b-overlay :show="loading">
      <b-card>
        <template v-slot:headerTitle>
         <h4 class="card-title">{{ $t('associationPnl.program_request') }}</h4>
        </template>
        <b-row>
            <b-col sm="6" class="mt-2">
              <!-- <b> {{ $t('associationPnl.proposal_no')}} </b> : {{ $n(items.proposal_id, { useGrouping: false }) }} -->
              <b> {{ $t('associationPnl.proposal_no')}} </b> : {{ items.proposal_id }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.program_no')}} </b> : {{ $n(items.program_no, { useGrouping: false }) }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.program_name')}} </b> : {{ currentLocale === 'bn' ? items.programe_name_bn : items.programe_name_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.start_date')}} </b> : {{ items.start_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('associationPnl.end_date')}} </b> : {{ items.end_date | dateFormat }}
            </b-col>
            <b-col sm="6" class="mt-2">
              <b> {{ $t('globalTrans.status')}} </b> : {{ statusText(items.status) }}
            </b-col>
            <!-- <b-col sm="6" class="mt-2">
                <b> {{ currentLocale === 'bn' ? $t('cip.referred_association_bn') : $t('cip.referred_association_en') }} </b> : {{ currentLocale === 'bn' ? detailsData.referred_association_bn : detailsData.referred_association_en }}
            </b-col>
            <b-col sm="6" class="mt-2">
            <b> {{ currentLocale === 'bn' ? $t('globalTrans.address_bn') : $t('globalTrans.address_en') }} </b> : {{ currentLocale === 'bn' ? detailsData.address_bn : detailsData.address_en }}
            </b-col> -->
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
      <br/>
      <b-card>
        <template>
         <h4 class="card-title">{{ $t('associationPnl.expenditure_item') }}</h4>
        </template>
        <!-- <hr> -->
        <b-row>
          <b-col xs="12" sm="12" md="12">
          <!-- Budget Details Start -->
          <div class="table-wrapper table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                        <tr class="bg-primary">
                            <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                            <th scope="col" class="text-center"><div>{{ $t('globalTrans.description') }}</div></th>
                            <th scope="col" class="text-center"><div>{{ $t('associationPnl.quantity') }}</div></th>
                            <th scope="col" class="text-center"><div>{{ $t('associationPnl.rate') }}</div></th>
                            <th scope="col" class="text-center"><div>{{ $t('associationPnl.total_amount') }}</div></th>
                            <th scope="col" class="text-center"><div>{{ $t('associationPnl.remarks') }}</div></th>
                        </tr>
                    </thead>
                    <tbody v-for="(sinHead, headIndex) in allExpHeads" :key="headIndex" style="border-top: 1px solid #000;">
                      <!-- ------------Head Start----------- -->
                      <tr>
                        <td  class="text-center">{{ $t('associationPnl.heading') }}</td>
                        <td colspan="5"  class="text-left" style="font-weight: bold;">{{ $i18n.locale === 'bn' ? sinHead.expenditure_head_bn : sinHead.expenditure_head_en }}</td>
                      </tr>
                      <!-- ------------Head End------------- -->
                      <!-- ------------Item Start----------- -->
                      <tr v-for="(sinItem, itemIndex) in sinHead.expenceitems" :key="itemIndex">
                        <!-- {{ grand_total += parseFloat(sinItem.total_amount) }} -->
                        <td  class="text-center">{{ $n(itemIndex+1) }}</td>
                        <td  class="text-left">{{ $i18n.locale === 'bn' ? sinItem.expenditure_item_bn : sinItem.expenditure_item_en }}</td>
                        <td  class="text-left">{{ sinItem.quantity }}</td>
                        <td  class="text-right">{{ sinItem.rate }}</td>
                        <td  class="text-right">{{ sinItem.total_amount }}</td>
                        <td  class="text-left">{{ sinItem.remarks }}</td>
                      </tr>
                      <!-- ------------Item End------------- -->

                    </tbody>
                        <tr v-if="allExpHeads.length > 0">
                            <td colspan="4" class="text-center" style="font-weight: bold;"><div>{{ $t('associationPnl.grand_total') }}</div></td>
                            <td class="text-right" style="font-weight: bold;"><div>{{ grand_total }}</div></td>
                            <td>&nbsp;</td>
                        </tr>
                    <tbody v-if="allExpHeads.length === 0">
                        <tr>
                            <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                        </tr>
                    </tbody>
              </table>
          </div>
          <!-- Budget Details End -->
          </b-col>
        </b-row>
      </b-card>
      <!-- ------------------------------------------- -->
      <!-- -----------------Start--------------------- -->
      <br/>
      <b-card>
        <template>
         <h4 class="card-title">{{ $t('associationPnl.advanced_payment') }} {{ $t('associationPnl.schedule') }}</h4>
        </template>
        <!-- <hr> -->
        <b-row>
          <b-col xs="12" sm="12" md="12">
          <!-- Budget Details Start -->
          <div class="table-wrapper table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                      <tr class="bg-primary">
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.schedule_no') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.pay_date') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount_percent') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount') }}</div></th>
                      </tr>
                    </thead>
                    <tbody>
                        <template v-if="arrAdvPaymentData && arrAdvPaymentData.length > 0">
                            <tr v-for="(item, index) in arrAdvPaymentData" :key="index">
                                <td  class="text-center">{{ $n(index+1) }}</td>
                                <td class="text-center">{{ item.pay_date | dateFormat }}</td>
                                <td class="text-center">{{ item.amt_percent }}</td>
                                <td class="text-right">{{ item.amount }}</td>
                            </tr>
                        </template>
                        <template v-else>
                            <tr>
                                <td colspan="4" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                            </tr>
                        </template>
                    </tbody>
              </table>
          </div>
          <!-- Budget Details End -->
          </b-col>
        </b-row>
      </b-card>
      <!-- -----------------End----------------------- -->
        <b-row class="text-right mt-3">
          <b-col>
            <b-button type="submit" variant="success" @click="saveData(2)" class="mr-2 btn-sm">{{$t('associationPnl.final_save')}}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-final-save')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
      </b-overlay>
    </div>
</template>
<script>
// import { eBizServiceBaseUrl } from '@/config/api_config'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programHeadItemList, programFinalSAve } from '../../api/routes'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      grand_total: 0.00,
      valid: null,
      formData: {
        program_id: 0,
        status: 2
      },
      allExpHeads: [],
      arrAdvPaymentData: [],
      loading: false
    }
  },
  created () {
    if (this.items.id) {
      this.formData.program_id = this.items.id
      this.loadExpence()
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
          const params = Object.assign({}, { program_id: this.items.id })
          result = await RestApi.postData(eBizServiceBaseUrl, programHeadItemList, params)
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
        },
        async saveData (status) {
        this.loading = true
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
         result = await RestApi.postData(eBizServiceBaseUrl, programFinalSAve, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)
       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })
         this.$bvModal.hide('modal-final-save')
       } else {
       }
     }
    }
}
</script>
