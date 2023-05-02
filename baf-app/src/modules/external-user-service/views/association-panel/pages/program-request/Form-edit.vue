<template>
    <div>
      <b-overlay :show="loading">
      <b-card>
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
      <b-card>
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
                        <td  class="text-left">
                          <!-- {{ sinItem.quantity }} -->
                          <ValidationProvider name="Quantity" :vid="`expence_item${itemIndex}`" rules="required" v-slot="{ errors }">
                            <b-form-group
                              :label-for="`expence_item${itemIndex}`">
                              <b-form-input
                                id="quantity"
                                v-model.number="sinItem.quantity"
                                @keyup="calculateTotalAmountInArr(headIndex, itemIndex)"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td  class="text-left">
                          <!-- {{ sinItem.rate }} -->
                          <ValidationProvider name="Rate" :vid="`expence_item${itemIndex}`" rules="required" v-slot="{ errors }">
                            <b-form-group
                              :label-for="`expence_item${itemIndex}`">
                              <b-form-input
                                id="rate"
                                v-model.number="sinItem.rate"
                                @keyup="calculateTotalAmountInArr(headIndex, itemIndex)"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td  class="text-left">
                          <!-- {{ sinItem.total_amount }} -->
                          <ValidationProvider name="Total Amount" :vid="`expence_item${itemIndex}`" rules="required" v-slot="{ errors }">
                            <b-form-group
                              :label-for="`expence_item${itemIndex}`">
                              <b-form-input
                                id="total_amount"
                                v-model.number="sinItem.total_amount"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                                disabled
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </td>
                        <td  class="text-left">{{ sinItem.remarks }}</td>
                      </tr>
                      <!-- ------------Item End------------- -->

                    </tbody>
                        <tr v-if="allExpHeads.length > 0">
                            <td colspan="4" class="text-center" style="font-weight: bold;"><div>{{ $t('associationPnl.grand_total') }}</div></td>
                            <td class="text-left" style="font-weight: bold;"><div>{{ grand_total }}</div></td>
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
        <b-row class="text-right mt-3">
          <b-col>
            <b-button type="submit" variant="success" @click="saveData(1)" class="mr-2 btn-sm">{{$t('globalTrans.draft')}}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-edit')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
        </b-overlay>
    </div>
</template>
<script>
// import { eBizServiceBaseUrl } from '@/config/api_config'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { programHeadItemList, programHeadItemUpdate } from '../../api/routes'
export default {
  name: 'Details',
  props: ['items'],
  data () {
    return {
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      formData: {
        program_id: 0,
        allExpHeadsArr: []
      },
      grand_total: 0.00,
      valid: null,
      allExpHeads: [],
      loading: false
    }
  },
  created () {
    // if (this.id) {
    //   const tmp = this.cipTradeRejectId()
    //   this.detailsData = tmp
    // }
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
        async saveData (status) {
      //  const isValid = await this.$refs.mainForm.validate()
      //  if (isValid) {
        this.loading = true
        this.formData.status = status
        this.formData.allExpHeadsArr = this.allExpHeads
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
         result = await RestApi.postData(eBizServiceBaseUrl, programHeadItemUpdate, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)
       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })
         this.$bvModal.hide('modal-edit')
       } else {
         this.$refs.mainForm.setErrors(result.errors)
       }
    //  }
     },
        async loadExpence () {
          this.loading = true
          let result = null
          const params = Object.assign({}, { program_id: this.items.id })
          result = await RestApi.postData(eBizServiceBaseUrl, programHeadItemList, params)
          if (result.success) {
              if (result.data.length > 0) {
                this.allExpHeads = result.data
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
        calculateTotalAmountInArr (headInx, itemInx) {
         const totalAmt = parseFloat((this.allExpHeads[headInx].expenceitems[itemInx].quantity > 0) ? this.allExpHeads[headInx].expenceitems[itemInx].quantity : 0) * parseFloat((this.allExpHeads[headInx].expenceitems[itemInx].rate > 0) ? this.allExpHeads[headInx].expenceitems[itemInx].rate : 0)
         this.allExpHeads[headInx].expenceitems[itemInx].total_amount = totalAmt
        //  ----------------
        this.grand_total = 0
        this.allExpHeads.map(hdItem => {
            // --------------------------------------
            hdItem.expenceitems.map(item => {
              this.grand_total += parseFloat(item.total_amount)
            })
            // --------------------------------------
          })
        //  ----------------
       }
    }
}
</script>
