<template>
  <div class="inner-section">
     <!-- <bread-cumb /> -->
        <body-card>
          <template v-slot:headerTitle>
            <h4 class="card-title">{{ $t('associationPnl.program') }}  {{ $t('associationPnl.total_amount') }} {{$n(program_total_amount)}}</h4>
          </template>
           <b-container fluid>
               <b-row>
                <b-overlay :show="loading">
                 <b-col sm="12" class="mt-3">
                       <!-- =================Add More Start===================== -->
                     <div>
                       <ValidationObserver ref="payItemEntryForm" v-slot="{ handleSubmit, reset }">
                           <b-form @submit.prevent="handleSubmit(payItemEntryAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                             <b-row>
                               <b-col xs="12" sm="12" md="6">
                                 <!-- <ValidationProvider name="Amount Percent" vid="amt_percent" rules="required" v-slot="{ errors }"> -->
                                 <ValidationProvider name="Amount Percent" vid="amt_percent" :rules="`required|min_value:1|max_value: ${adv_pay_remain_parcent}`" v-slot="{ errors }">
                                   <b-form-group
                                     label-for="amt_percent">
                                     <template v-slot:label>
                                      {{ $t('associationPnl.amount_percent') }}<span class="text-danger">*</span>
                                     </template>
                                     <b-form-input
                                       id="amt_percent"
                                       v-model="payItemData.amt_percent"
                                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                       :state="errors[0] ? false : (valid ? true : null)"
                                     ></b-form-input>
                                     <div class="invalid-feedback">
                                       {{ errors[0] }}
                                     </div>
                                   </b-form-group>
                                 </ValidationProvider>
                               </b-col>
                               <b-col xs="12" sm="12" md="6">
                                <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                      label-for="amount">
                                      <template v-slot:label>
                                        {{ $t('associationPnl.amount') }}
                                      </template>
                                      <b-form-input
                                        id="amount"
                                        v-model="payItemData.amount"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        disabled
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                        {{ errors[0] }}
                                      </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Pay Date" vid="pay_date" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="pay_date">
                                    <template v-slot:label>
                                      {{ $t('associationPnl.pay_date') }} <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                      id="pay_date"
                                      v-model="payItemData.pay_date"
                                      class="form-control"
                                      :placeholder="$t('globalTrans.select_date')"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                      :class="errors[0] ? 'is-invalid' : ''"
                                    >
                                    </date-picker>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                             </b-row>
                             <b-row class="text-right">
                               <b-col>
                                   <b-button v-if="program.adv_payment_status != 3" type="submit" variant="success" class="mr-2 btn-sm">
                                       <span v-if="loading">
                                           <b-spinner small label="Loading..."></b-spinner>
                                       </span>
                                       <span v-else>
                                           <i class="fas fa-plus-circle m-0"></i>
                                       </span>
                                       {{arrAdvPaymentData && arrAdvPaymentData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
                                   </b-button>
                               </b-col>
                             </b-row>
                           </b-form>
                         <!-- </b-overlay> -->
                       </ValidationObserver>
                     </div>
                     <br/>
                       <!-- Budget Details Start -->
                        <div class="table-wrapper table-responsive">
                          <!-- <b-overlay :show="loading"> -->
                         <table class="table table-striped table-hover table-bordered">
                                 <thead>
                                     <tr class="bg-primary">
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.schedule_no') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.pay_date') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount_percent') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount') }}</div></th>
                                         <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <template v-if="arrAdvPaymentData && arrAdvPaymentData.length > 0">
                                         <tr v-for="(item, index) in arrAdvPaymentData" :key="index">
                                             <td  class="text-center">{{ $n(index+1) }}</td>
                                             <td class="text-center">{{ item.pay_date | dateFormat }}</td>
                                             <td style="width: 40%" class="text-center" >
                                                 <!-- <ValidationProvider name="Amount Percent" :vid="`payment_item${index}`" rules="required" v-slot="{ errors }"> -->
                                                 <ValidationProvider name="Amount Percent" :vid="`payment_item${index}`" :rules="`required|min_value:1|max_value: ${adv_pay_remain_parcent}`" v-slot="{ errors }">
                                                   <b-form-group
                                                     :label-for="`payment_item${index}`">
                                                     <b-form-input
                                                       id="quantity"
                                                       v-model.number="item.amt_percent"
                                                       @keyup="calculateTotalParcentInArr(index)"
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
                                             <td style="width: 40%" class="text-center" >
                                                 <ValidationProvider name="Amount" :vid="`payment_item${index}`" rules="required" v-slot="{ errors }">
                                                   <b-form-group
                                                     :label-for="`payment_item${index}`">
                                                     <b-form-input
                                                       id="rate"
                                                       v-model.number="item.amount"
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
                                             <td class="text-center">
                                                 <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="headItemEntryRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                             </td>
                                         </tr>
                                     </template>
                                     <template v-else>
                                         <tr>
                                             <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                         </tr>
                                     </template>
                                 </tbody>
                          </table>
                         </div>
                         <!-- Budget Details End -->
                     <!-- =================Add More End===================== -->
                     <br>
                     <!-- attachemnt  -->
                 <b-row class="text-right mb-3">
                     <b-col>
                         <b-button v-if="program.adv_payment_status != 3 " type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                         <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-advanced-payment')">{{ $t('globalTrans.cancel') }}</b-button>
                     </b-col>
                 </b-row>
                 </b-col>
                 </b-overlay>
               </b-row>
           </b-container>
      </body-card>
   </div>
 </template>
 <script>
 import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
 import { programAdvPaymentList, programAdvPaymentStore } from '../../api/routes'
//  import BreadCumb from '../../../../../../components/BreadCumb.vue'
import flatpickr from 'flatpickr'
 export default {
   name: 'Form',
   props: ['id'],
   components: { },
   data () {
     return {
       valid: null,
      //  saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
       saveBtnName: this.id ? this.$t('globalTrans.save') : this.$t('globalTrans.save'),
       errors: [],
       formData: {
        program_id: 0,
        advPaymentDataArr: []
       },
       payItemData: {
        amt_percent: 0,
        amount: 0.00,
        pay_date: ''
       },
       arrAdvPaymentData: [],
       program: {},
       program_total_amount: 0.00,
       adv_pay_grand_parcent: 0.00,
       adv_pay_remain_parcent: 0,
       adv_pay_grand_total: 0.00
     }
   },
   created () {
    if (this.id) {
      this.formData.program_id = this.id
      this.loadAdvancedPayment()
      //  const tmp = this.getEditEntry()
      //  this.formData = tmp
     }
   },
   computed: {
     loading: function () {
       return this.$store.state.commonObj.loading
     },
     currentLocale () {
       return this.$i18n.locale
     }
   },
   mounted () {
        flatpickr('#pay_date', {
          minDate: 'today',
          defaultDate: 'null'
        })
    },
   watch: {
    'payItemData.amt_percent': function (newVal, oldVal) {
       if (newVal !== oldVal) {
        this.loading = true
        const tmpPercent = parseFloat((newVal > 0) ? newVal : 0)
        // ---------------------
        // const tmpTotalPercent = this.adv_pay_grand_parcent + tmpPercent
        const tmpTotalPercent = this.arrAdvPaymentData.reduce((total, item) => total + parseFloat(item.amt_percent), 0)
        this.adv_pay_remain_parcent = 100 - ((parseFloat(tmpTotalPercent) > 0) ? parseFloat(tmpTotalPercent) : 0)
        // -----------------------
          const tmpProgramTotalAmt = parseFloat(this.program_total_amount)
          const totalAmt = (tmpPercent * tmpProgramTotalAmt) / 100
          this.payItemData.amount = totalAmt
          this.loading = false
       }
     }
   },
   methods: {
      calculateTotalParcentInArr (index) {
        // this.payItemData = {
        //                 program_id: this.id,
        //                 amt_percent: 0,
        //                 amount: 0.00,
        //                 pay_date: ''
        //                }
        this.payItemData.pay_date = ''
                       this.$refs.payItemEntryForm.reset()
        const tmpPercent = parseFloat((this.arrAdvPaymentData[index].amt_percent > 0) ? this.arrAdvPaymentData[index].amt_percent : 0)
        // ---------------------
        const tmpTotalPercent = this.arrAdvPaymentData.reduce((total, item) => total + parseFloat(item.amt_percent), 0)
        this.adv_pay_remain_parcent = (100 - ((parseFloat(tmpTotalPercent) > 0) ? parseFloat(tmpTotalPercent) : 0))
        // -----------------------
          const tmpProgramTotalAmt = parseFloat(this.program_total_amount)
          const totalAmt = (tmpPercent * tmpProgramTotalAmt) / 100
          this.arrAdvPaymentData[index].amount = totalAmt
       },
     // ================Edu Info Start=================
         async payItemEntryAddItem () {
          var obj = {
                  program_id: this.id,
                  amt_percent: parseFloat(this.payItemData.amt_percent),
                  amount: parseFloat(this.payItemData.amount),
                  pay_date: this.payItemData.pay_date
                 }
                   // this.loading = true
                        this.formData.advPaymentDataArr.push(obj)
                        this.payItemData = {
                        program_id: this.id,
                        amt_percent: 0,
                        amount: 0.00,
                        pay_date: ''
                       }
                       this.arrAdvPaymentData = this.formData.advPaymentDataArr
                       this.$refs.payItemEntryForm.reset()
                       // this.loading = false
         },
         headItemEntryRemove (key) {
          //  this.formData.budgetEntryDataArr.splice(key, 1)
           this.arrAdvPaymentData.splice(key, 1)
         },
         // ================Edu Info End===================
     async saveData () {
      //  const isValid = await this.$refs.mainForm.validate()
      //  if (isValid && this.arrAdvPaymentData.length > 0) {
       if (this.arrAdvPaymentData.length > 0) {
        this.formData.program_id = this.id
        this.formData.advPaymentDataArr = this.arrAdvPaymentData
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
         result = await RestApi.postData(eBizServiceBaseUrl, programAdvPaymentStore, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)

       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })

         this.$bvModal.hide('modal-form-advanced-payment')
       } else {
         this.$refs.mainForm.setErrors(result.errors)
       }
     }
     },
     async loadAdvancedPayment () {
          this.loading = true
          let result = null
          const params = Object.assign({}, { program_id: this.id })
          result = await RestApi.postData(eBizServiceBaseUrl, programAdvPaymentList, params)
          if (result.success) {
            this.program = result.program
            this.program_total_amount = result.program.total_amount
              if (result.data.length > 0) {
                this.arrAdvPaymentData = result.data
                this.formData.advPaymentDataArr = result.data
                result.data.map(item => {
                    this.adv_pay_grand_parcent += parseFloat(item.amt_percent)
                    this.adv_pay_grand_total += parseFloat(item.amount)
                })
                this.adv_pay_remain_parcent = 100 - this.adv_pay_grand_parcent
              }
              this.loading = false
          } else {
              this.loading = false
          }
        },
     getEditEntry () {
       const itemId = this.id
       const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
       return JSON.parse(JSON.stringify(tmpData))
     }
   }
 }
 </script>
