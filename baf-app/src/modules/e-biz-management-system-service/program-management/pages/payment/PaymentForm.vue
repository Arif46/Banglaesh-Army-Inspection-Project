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
                           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Proposal No" vid="proposal_no" v-slot="{ errors }" rules="required">
                            <b-form-group
                              label-for="proposal_no"
                            >
                              <template v-slot:label>
                                {{ $t('eBizProgram.proposal_no') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="proposal_no"
                                  type="text"
                                  v-model="formData.proposal_no"
                                  disabled
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Program No" vid="program_no" v-slot="{ errors }" rules="required">
                            <b-form-group
                              label-for="program_no"
                            >
                              <template v-slot:label>
                                {{ $t('eBizProgram.program_no') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="program_no"
                                  type="text"
                                  v-model="formData.program_no"
                                  disabled
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                            <ValidationProvider name="Program Name" vid="program_name" v-slot="{ errors }" rules="required">
                            <b-form-group
                              label-for="program_name"
                            >
                              <template v-slot:label>
                                {{ $t('eBizProgram.program_name') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="program_name"
                                  type="text"
                                  v-model="formData.program_name"
                                  disabled
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Program Budget" vid="program_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="program_budget">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.program_budget') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="program_budget"
                                    v-model="formData.program_budget"
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
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Advance Paid" vid="advance_paid" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="advance_paid">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.advance_paid') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="advance_paid"
                                    v-model="formData.advance_paid"
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
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Final Payable" vid="final_payable" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="final_payable">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.final_payable') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="final_payable"
                                    v-model="formData.final_payable"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                                <div class="text-right">
                                    <button @click="setPayAmount" type="button" class="btn btn-sm btn-success">{{$t('eBizProgram.pay')}}</button>
                                </div>
                            </b-col>
                           </slot>
                             </b-row>
                        <b-row>
                         <template>
                            <h4 class="card-title">{{ $t('eBizProgram.payment_details') }} </h4>
                          </template>
                           <hr>
                        </b-row>
                        <b-row>
                         <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Bank Name" vid="bank_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="bank_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProgram.bank_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.bank_id"
                                    :options="bankList"
                                    id="bank_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                            </b-col>
                         <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Branch Name" vid="brnach_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="brnach_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                  <template v-slot:label>
                                    {{$t('eBizProgram.branch_name')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                    plain
                                    v-model="formData.branch_id"
                                    :options="branchList"
                                    id="brnach_id"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  >
                                    <template v-slot:first>
                                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                                    </template>
                                  </b-form-select>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                  </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="Cheque No" vid="cheque_no" v-slot="{ errors }" rules="required">
                            <b-form-group
                              label-for="cheque_no"
                            >
                              <template v-slot:label>
                                {{ $t('eBizProgram.cheque_no') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="cheque_no"
                                  type="text"
                                  v-model="formData.cheque_no"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Amount" vid="amount" :rules="`required|min_value:${parseFloat(formData.final_payable)}|max_value:${parseFloat(formData.final_payable)}`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="amount">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.amount') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="amount"
                                    v-model="formData.amount"
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
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                  <ValidationProvider name="Attachment" vid="attachment" rules="required">
                                    <b-form-group
                                      label-for="attachment"
                                      slot-scope="{ valid, errors }"
                                      >
                                      <template v-slot:label>
                                        {{ $t('globalTrans.attachment') }}<span class="text-danger">*</span>
                                      </template>
                                    <b-form-file id="attachment"
                                    v-model="formData.file"
                                    v-on:change="onFileChange"
                                    accept=".doc,.docx,.pdf"
                                    class="mt-2" plain
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-file>
                                      <div class="invalid-feedback">
                                        {{ errors[0] }}
                                      </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                  <ValidationProvider name="Remarks (En)" vid="remarks" v-slot="{ errors }" rules="">
                                      <b-form-group
                                          label-for="remarks">
                                          <template v-slot:label>
                                            {{ $t('globalTrans.remarks') }} {{$t('globalTrans.en')}}
                                          </template>
                                        <b-form-textarea
                                              id="remarks"
                                              rows="3"
                                              v-model="formData.remarks_en"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-textarea>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                  <ValidationProvider name="Remarks (Bn)" vid="remarks_bn" v-slot="{ errors }" rules="">
                                      <b-form-group
                                          label-for="remarks_bn">
                                          <template v-slot:label>
                                            {{ $t('globalTrans.remarks') }} {{$t('globalTrans.bn')}}
                                          </template>
                                        <b-form-textarea
                                              id="remarks_bn"
                                              rows="3"
                                              v-model="formData.remarks_bn"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-textarea>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                  </ValidationProvider>
                              </b-col>
                        </b-row>
                     </b-form>
                  </ValidationObserver>
                 <b-row class="text-right mb-3">
                     <b-col>
                         <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                         <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('payment-form')">{{ $t('globalTrans.cancel') }}</b-button>
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
 import { programPaymentSave } from '../../api/routes'
 export default {
   name: 'Form',
   props: ['items'],
   components: { },
   data () {
     return {
       valid: null,
       saveBtnName: this.$t('eBizProgram.make_pay'),
       rejectBtnName: this.$t('globalTrans.reject'),
       errors: [],
       formData: {
        bill_id: this.items.id,
        program_id: this.items.program.id,
        fiscal_year_id: this.items.fiscal_year_id,
        association_info_id: this.items.association_info_id,
        council_info_id: this.items.council_info_id,
        proposal_id: this.items.program.program?.proposal_id,
        proposal_detail_id: this.items.program.program?.id,
        proposal_no: this.items.program?.program?.proposal?.proposal_id,
        program_no: this.items.proposal_detail_id,
        program_name: this.currentLocale === 'bn' ? this.items.program?.program?.programe_name_bn : this.items.program?.program?.programe_name_en,
        advance_paid: 0,
        final_payable: 0,
        program_budget: 0,
        bank_id: 0,
        branch_id: 0,
        amount: 0,
        cheque_no: '',
        remarks_en: '',
        remarks_bn: '',
        file: [],
        attachment: '',
        headItemDataArr: []
       },
       branchList: [],
       attachmentReq: 'required',
      //  remainingProposal: [],
       exitBudgetShow: false
     }
   },
   created () {
     if (this.items.id) {
      this.attachmentReq = ''
      this.formData.program_budget = this.items.program.program.amount
    }
    if (this.items !== null) {
      const finalPayableApprove = this.items.final_payable_approve
      const advancePaid = this.items.program.adv_payments.reduce((sum = 0, item) => sum + item.amount, 0)
      const firstBalance = parseFloat(finalPayableApprove) - parseFloat(advancePaid)
      const secondBalance = parseFloat(firstBalance) - parseFloat(this.items.vat_approve)
      const thirdBalance = parseFloat(secondBalance) - parseFloat(this.items.tax_approve)
      // this.formData.final_payable = this.items.final_payable
      this.formData.final_payable = thirdBalance
    }
    if (this.items.program.initial_proposals.length > 0) {
      this.formData.total_proposal_budget = this.items.program.initial_proposals.filter(item => item.approve_amount > 0).reduce((sum = 0, item) => sum + item.amount, 0)
    }
    if (this.items.program.adv_payments.length > 0) {
      this.formData.advance_paid = this.items.program.adv_payments.reduce((sum = 0, item) => sum + item.amount, 0)
    }
    this.getProgramBillAgainstProposal(this.items.program.proposal_id)
   },
   computed: {
     loading: function () {
       return this.$store.state.commonObj.loading
     },
     currentLocale () {
       return this.$i18n.locale
     },
     bankList: function () {
        return this.$store.state.CommonService.commonObj.bankList
     }
   },
    watch: {
    'formData.bank_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getBranchList(newVal)
      } else {
        this.branchList = []
      }
    }
   },
   methods: {
    setPayAmount () {
      this.formData.amount = this.formData.final_payable
    },
    getBranchList (bankId) {
        this.branchList = this.$store.state.CommonService.commonObj.branchList.filter(item => (item.bank_id === bankId))
    },
    finalPayable (percent) {
      const perceFinalPay = (parseFloat(percent) / 100) * parseFloat(this.formData.total_approve)
      this.formData.final_payable_approve = parseFloat(this.formData.total_approve) - parseFloat(perceFinalPay)
    },
      onFileChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.formData.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.formData.attachment = ''
          }
      },
         // ================Edu Info End===================
     async saveData () {
       const isValid = await this.$refs.mainForm.validate()
       if (isValid) {
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
       result = await RestApi.postData(eBizServiceBaseUrl, programPaymentSave, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)

       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })
         this.$bvModal.hide('payment-form')
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
