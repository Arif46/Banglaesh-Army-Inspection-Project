<template>
  <div class="inner-section">
     <!-- <bread-cumb /> -->
        <body-card>
           <b-container fluid>
              <b-row>
                <b-overlay :show="loading">
                 <b-col sm="12" class="mt-3">
                   <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                         <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                          <b-row>
                           <slot>
                           <b-col xs="12" sm="12" md="6">
                            <ValidationProvider name="Expenditure Head En" vid="expenditure_head_en" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="expenditure_head_en">
                                  <template v-slot:label>
                                    {{ $t('associationPnl.expenditure_head') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="expenditure_head_en"
                                    v-model="formData.expenditure_head_en"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                           </b-col>
                           <b-col xs="12" sm="12" md="6">
                            <ValidationProvider name="Expenditure Head Bn" vid="expenditure_head_bn" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="expenditure_head_bn">
                                  <template v-slot:label>
                                    {{ $t('associationPnl.expenditure_head') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="expenditure_head_bn"
                                    v-model="formData.expenditure_head_bn"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                           </b-col>
                           </slot>
                             </b-row>
                           </b-form>
                         <!-- </b-overlay> -->
                   </ValidationObserver>
                           <!-- =============End Main========= -->
                     <template>
                           <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                               <h5 class="text-white text-left">
                                   {{ $t('associationPnl.expenditure_item') }} {{ $t('globalTrans.details') }}
                               </h5>
                           </div>
                     </template>
                       <hr>
                       <!-- =================Add More Start===================== -->
                     <div>
                       <ValidationObserver ref="headItemEntryForm" v-slot="{ handleSubmit, reset }">
                         <!-- <b-overlay :show="loading"> -->
                           <b-form @submit.prevent="handleSubmit(headItemEntryAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                             <b-row>
                              <b-col xs="12" sm="12" md="6">
                                <ValidationProvider name="Expenditure Head Item" vid="expenditure_item_en" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                      label-for="expenditure_item_en">
                                      <template v-slot:label>
                                        {{ $t('associationPnl.expenditure_item') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                                      </template>
                                      <b-form-input
                                        id="expenditure_item_en"
                                        v-model="headItemData.expenditure_item_en"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                        {{ errors[0] }}
                                      </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6">
                                <ValidationProvider name="Expenditure Head Bn" vid="expenditure_item_bn" rules="required" v-slot="{ errors }">
                                    <b-form-group
                                      label-for="expenditure_item_bn">
                                      <template v-slot:label>
                                        {{ $t('associationPnl.expenditure_item') }} {{ $t('globalTrans.bn') }}<span class="text-danger">*</span>
                                      </template>
                                      <b-form-input
                                        id="expenditure_item_bn"
                                        v-model="headItemData.expenditure_item_bn"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                      ></b-form-input>
                                      <div class="invalid-feedback">
                                        {{ errors[0] }}
                                      </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                               <b-col xs="12" sm="12" md="6">
                                 <ValidationProvider name="Quantity" vid="quantity" rules="required" v-slot="{ errors }">
                                   <b-form-group
                                     label-for="quantity">
                                     <template v-slot:label>
                                      {{ $t('associationPnl.quantity') }}<span class="text-danger">*</span>
                                     </template>
                                     <b-form-input
                                       id="quantity"
                                       v-model="headItemData.quantity"
                                       @keyup="calculateTotalAmount()"
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
                                 <ValidationProvider name="Rate" vid="rate" rules="required" v-slot="{ errors }">
                                   <b-form-group
                                     label-for="rate">
                                     <template v-slot:label>
                                      {{ $t('associationPnl.rate') }}<span class="text-danger">*</span>
                                     </template>
                                     <b-form-input
                                       id="rate"
                                       v-model="headItemData.rate"
                                       @keyup="calculateTotalAmount()"
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
                                 <ValidationProvider name="Total Amount" vid="total_amount" rules="required" v-slot="{ errors }">
                                   <b-form-group
                                     label-for="total_amount">
                                     <template v-slot:label>
                                      {{ $t('associationPnl.total_amount') }}<span class="text-danger">*</span>
                                     </template>
                                     <b-form-input
                                       id="total_amount"
                                       v-model="headItemData.total_amount"
                                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                       :state="errors[0] ? false : (valid ? true : null)"
                                       disabled
                                     ></b-form-input>
                                     <div class="invalid-feedback">
                                       {{ errors[0] }}
                                     </div>
                                   </b-form-group>
                                 </ValidationProvider>
                               </b-col>
                               <b-col xs="12" sm="12" md="6">
                                 <ValidationProvider name="Remarks" vid="remarks" rules="" v-slot="{ errors }">
                                   <b-form-group
                                     label-for="remarks">
                                     <template v-slot:label>
                                      {{ $t('associationPnl.remarks') }}
                                     </template>
                                     <b-form-input
                                       id="remarks"
                                       v-model="headItemData.remarks"
                                       :state="errors[0] ? false : (valid ? true : null)"
                                     ></b-form-input>
                                     <div class="invalid-feedback">
                                       {{ errors[0] }}
                                     </div>
                                   </b-form-group>
                                 </ValidationProvider>
                               </b-col>
                             </b-row>
                             <b-row class="text-right">
                               <b-col>
                                   <b-button type="submit" variant="success" class="mr-2 btn-sm">
                                       <span v-if="loading">
                                           <b-spinner small label="Loading..."></b-spinner>
                                       </span>
                                       <span v-else>
                                           <i class="fas fa-plus-circle m-0"></i>
                                       </span>
                                       {{arrHeadItemData && arrHeadItemData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
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
                                         <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.expenditure_item') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.quantity') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.rate') }}</div></th>
                                         <th scope="col" class="text-center"><div>{{ $t('associationPnl.total_amount') }}</div></th>
                                         <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                     </tr>
                                 </thead>
                                 <tbody>
                                     <template v-if="arrHeadItemData && arrHeadItemData.length > 0">
                                         <tr v-for="(item, index) in arrHeadItemData" :key="index">
                                             <td  class="text-center">{{ $n(index+1) }}</td>
                                             <td class="text-center">{{ $i18n.locale === 'bn' ? item.expenditure_item_bn : item.expenditure_item_en }}</td>
                                             <td style="width: 15%" class="text-center" >
                                                 <ValidationProvider name="Quantity" :vid="`expence_item${index}`" rules="required" v-slot="{ errors }">
                                                   <b-form-group
                                                     :label-for="`expence_item${index}`">
                                                     <b-form-input
                                                       id="quantity"
                                                       v-model.number="item.quantity"
                                                       @keyup="calculateTotalAmountInArr(index)"
                                                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                       :state="errors[0] ? false : (valid ? true : null)"
                                                     ></b-form-input>
                                                     <div class="invalid-feedback">
                                                       {{ errors[0] }}
                                                     </div>
                                                   </b-form-group>
                                                 </ValidationProvider>
                                             </td>
                                             <td style="width: 40%" class="text-center" >
                                                 <ValidationProvider name="Rate" :vid="`expence_item${index}`" rules="required" v-slot="{ errors }">
                                                   <b-form-group
                                                     :label-for="`expence_item${index}`">
                                                     <b-form-input
                                                       id="rate"
                                                       v-model.number="item.rate"
                                                       @keyup="calculateTotalAmountInArr(index)"
                                                       oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                       :state="errors[0] ? false : (valid ? true : null)"
                                                     ></b-form-input>
                                                     <div class="invalid-feedback">
                                                       {{ errors[0] }}
                                                     </div>
                                                   </b-form-group>
                                                 </ValidationProvider>
                                             </td>
                                             <td style="width: 40%" class="text-center" >
                                                 <ValidationProvider name="Total Amount" :vid="`expence_item${index}`" rules="required" v-slot="{ errors }">
                                                   <b-form-group
                                                     :label-for="`expence_item${index}`">
                                                     <b-form-input
                                                       id="total_amount"
                                                       v-model.number="item.total_amount"
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
                          <!-- </b-overlay> -->
                         </div>
                         <!-- Budget Details End -->
                     <!-- =================Add More End===================== -->
                     <br>
                     <!-- attachemnt  -->
                 <b-row class="text-right mb-3">
                     <b-col>
                         <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                         <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form-add-item')">{{ $t('globalTrans.cancel') }}</b-button>
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
 import { programHeadItemStore } from '../../api/routes'
 export default {
   name: 'Form',
   props: ['id'],
   components: { },
   data () {
     return {
       valid: null,
       saveBtnName: this.id ? this.$t('globalTrans.save') : this.$t('globalTrans.save'),
       errors: [],
       formData: {
        expenditure_head_en: '',
        expenditure_head_bn: '',
        headItemDataArr: []
       },
       headItemData: {
        expenditure_item_en: '',
        expenditure_item_bn: '',
        quantity: 0,
        rate: 0,
        total_amount: 0.00,
        remarks: ''
       },
       exitBudgetShow: false,
       arrHeadItemData: []
     }
   },
   created () {
   },
   computed: {
     loading: function () {
       return this.$store.state.commonObj.loading
     },
     currentLocale () {
       return this.$i18n.locale
     }
   },
   watch: {
   },
   methods: {
      calculateTotalAmount () {
         const totalAmt = parseFloat((this.headItemData.quantity > 0) ? this.headItemData.quantity : 0) * parseFloat((this.headItemData.rate > 0) ? this.headItemData.rate : 0)
        this.headItemData.total_amount = totalAmt
       },
      calculateTotalAmountInArr (index) {
         const totalAmt = parseFloat((this.arrHeadItemData[index].quantity > 0) ? this.arrHeadItemData[index].quantity : 0) * parseFloat((this.arrHeadItemData[index].rate > 0) ? this.arrHeadItemData[index].rate : 0)
        this.arrHeadItemData[index].total_amount = totalAmt
       },
     // ================Edu Info Start=================
         async headItemEntryAddItem () {
          var obj = {
                  program_id: this.id,
                  expenditure_item_en: this.headItemData.expenditure_item_en,
                  expenditure_item_bn: this.headItemData.expenditure_item_bn,
                  quantity: this.headItemData.quantity,
                  rate: this.headItemData.rate,
                  total_amount: parseFloat(this.headItemData.total_amount),
                  remarks: this.headItemData.remarks
                 }
                       if (this.headItemData.key === undefined) {
                        this.formData.headItemDataArr.push(obj)
                       }
                       this.headItemData = {
                        program_id: this.id,
                        expenditure_item_en: '',
                        expenditure_item_bn: '',
                        quantity: 0,
                        rate: 0,
                        total_amount: 0.00,
                        remarks: ''
                       }
                       this.arrHeadItemData = this.formData.headItemDataArr
                       this.$refs.headItemEntryForm.reset()
         },
         headItemEntryRemove (key) {
           this.arrHeadItemData.splice(key, 1)
         },
         // ================Edu Info End===================
     async saveData () {
       const isValid = await this.$refs.mainForm.validate()
       if (isValid && this.arrHeadItemData.length > 0) {
        this.formData.program_id = this.id
        this.formData.headItemDataArr = this.arrHeadItemData
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
         result = await RestApi.postData(eBizServiceBaseUrl, programHeadItemStore, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)

       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })

         this.$bvModal.hide('modal-form-add-item')
       } else {
         this.$refs.mainForm.setErrors(result.errors)
       }
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
