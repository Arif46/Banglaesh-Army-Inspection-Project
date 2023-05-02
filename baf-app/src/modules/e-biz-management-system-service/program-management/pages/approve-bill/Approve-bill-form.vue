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
                           </slot>
                             </b-row>
                        <b-row>
                         <template>
                            <h4 class="card-title">{{ $t('associationPnl.payment_history') }} </h4>
                          </template>
                           <hr>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Total Proposal Budget" vid="total_proposal_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="total_proposal_budget">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.total_proposal_budget') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="total_proposal_budget"
                                    v-model="formData.total_proposal_budget"
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
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Remaining Proposal Budget" vid="remaining_proposal_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="remaining_proposal_budget">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.remaining_proposal_budget') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="remaining_proposal_budget"
                                    v-model="formData.remaining_proposal_budget"
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
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Available Program Budget" vid="available_program_budget" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="available_program_budget">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.available_program_budget') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="available_program_budget"
                                    v-model="formData.available_program_budget"
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
                        </b-row>
                        <b-row>
                         <template>
                            <h4 class="card-title">{{ $t('associationPnl.final_bill') }} </h4>
                          </template>
                           <hr>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Actual Expenditure (Excluding VAT & TAX)" vid="actual_expenditure" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="actual_expenditure">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.actual_expenditure') }} ({{ $t('associationPnl.excluding_vat_tax') }})<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="actual_expenditure"
                                    v-model="formData.actual_expenditure"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Actual Expenditure (Excluding VAT & TAX) Approve" vid="actual_expenditure" :rules="`required|min_value:0|max_value:${formData.actual_expenditure}`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="actual_expenditure">
                                  <template v-slot:label>
                                   {{ $t('associationPnl.actual_expenditure') }} ({{ $t('associationPnl.excluding_vat_tax') }}) {{$t('globalTrans.approve')}}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="actual_expenditure"
                                    v-model="formData.actual_expenditure_approve"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <!-- <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            </b-col> -->
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="VAT Deducted " vid="vat_deducted" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="vat_deducted">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.vat_deducted') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="vat_deducted"
                                    v-model="formData.vat_deducted"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="VAT Deducted Approve" vid="vat_deducted" :rules="`required|min_value:0|max_value:${formData.vat_deducted}`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="vat_deducted">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.vat_deducted') }} {{$t('globalTrans.approve')}}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="vat_deducted"
                                    v-model="formData.vat_deducted_approve"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <!-- <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            </b-col> -->
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Tax Deducted" vid="tax_deducted" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="tax_deducted">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.tax_deducted') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="tax_deducted"
                                    v-model="formData.tax_deducted"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Tax Deducted Approve" vid="tax_deducted" :rules="`required|min_value:0|max_value:${formData.tax_deducted}`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="tax_deducted">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.tax_deducted') }} {{$t('globalTrans.approve')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="tax_deducted"
                                    v-model="formData.tax_deducted_approve"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Total (Including VAT & Tax)" vid="total" rules="required|min:0" v-slot="{ errors }">
                                <b-form-group
                                  label-for="total">
                                  <template v-slot:label>
                                  {{ $t('globalTrans.total') }} ({{ $t('associationPnl.including_vat_tax') }}) <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="total"
                                    v-model="formData.total"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Total (Including VAT & Tax) Approve" vid="total" rules="required|min:0" v-slot="{ errors }">
                                <b-form-group
                                  label-for="total">
                                  <template v-slot:label>
                                  {{ $t('globalTrans.total') }} ({{ $t('associationPnl.including_vat_tax') }}) {{$t('globalTrans.approve')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="total"
                                    v-model="formData.total_approve"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="BPC Payable on Actual Expense" vid="bpc_payable_actual_expense" rules="" v-slot="{ errors }">
                                <b-form-group
                                  label-for="bpc_payable_actual_expense">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.bpc_payable_actual_expense') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="bpc_payable_actual_expense"
                                    v-model="formData.bpc_payable_actual_expense"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="BPC Payable on Actual Expense Approve" vid="bpc_payable_actual_expense_approve" :rules="`required|min_value:0|max_value:${formData.bpc_payable_actual_expense}`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="bpc_payable_actual_expense_approve">
                                  <template v-slot:label>
                                   {{ $t('associationPnl.bpc_payable_actual_expense') }} {{$t('globalTrans.approve')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="bpc_payable_actual_expense_approve"
                                    v-model="formData.bpc_payable_actual_expense_approve"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Final Payable" vid="final_payable" rules="" v-slot="{ errors }">
                                <b-form-group
                                  label-for="final_payable">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.final_payable') }} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="final_payable"
                                    v-model="formData.final_payable"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                              <ValidationProvider name="Final Payable Approve" vid="final_payable" :rules="`required|min:0`" v-slot="{ errors }">
                                <b-form-group
                                  label-for="final_payable">
                                  <template v-slot:label>
                                  {{ $t('associationPnl.final_payable') }} {{$t('globalTrans.approve')}} <span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="final_payable"
                                    v-model="formData.final_payable_approve"
                                    disabled
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                        </b-row>
                        <b-row>
                           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
                        </b-row>
                     </b-form>
                  </ValidationObserver>
                 <b-row class="text-right mb-3">
                     <b-col>
                         <b-button type="submit" variant="danger" @click="RejectBill(4)" class="mr-2 btn-sm">{{ rejectBtnName }}</b-button>
                         <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                         <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('approve-bill-form')">{{ $t('globalTrans.cancel') }}</b-button>
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
 import { approveBillSave, rejectProgramBill } from '../../api/routes'
 export default {
   name: 'Form',
   props: ['items'],
   components: { },
   data () {
     return {
       valid: null,
       saveBtnName: this.$t('globalTrans.approve'),
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
        total_proposal_budget: 0,
        remaining_proposal_budget: 0,
        advance_paid: 0,
        program_budget: 0,
        available_program_budget: 0,
        actual_expenditure: 0,
        actual_expenditure_approve: 0,
        vat_deducted: 0,
        vat_deducted_approve: 0,
        tax_deducted: 0,
        tax_deducted_approve: 0,
        total: 0,
        total_approve: 0,
        bpc_payable_actual_expense: 0,
        bpc_payable_actual_expense_approve: 0,
        final_payable: 0,
        final_payable_approve: 0,
        file: [],
        attachment: '',
        headItemDataArr: []
       },
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
      this.formData.actual_expenditure = this.items.actual_expenditure
      this.formData.vat_deducted = this.items.vat
      this.formData.tax_deducted = this.items.tax
      this.formData.total = this.items.total
      this.formData.bpc_payable_actual_expense = this.items.bpc_payable_actual_expense
      this.formData.final_payable = this.items.final_payable
    }
    if (this.items.program.initial_proposals.length > 0) {
      this.formData.total_proposal_budget = this.items.program.initial_proposals.filter(item => item.approve_amount > 0).reduce((sum = 0, item) => sum + item.amount, 0)
    }
    if (this.items.program.adv_payments.length > 0) {
      this.formData.advance_paid = this.items.program.adv_payments.reduce((sum = 0, item) => sum + item.amount, 0)
      this.formData.available_program_budget = this.formData.program_budget - this.formData.advance_paid
    }
    this.getProgramBillAgainstProposal(this.items.program.proposal_id)
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
    'formData.actual_expenditure_approve': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.totalVatTaxCalculation()
      }
    },
    'formData.tax_deducted_approve': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.totalVatTaxCalculation()
      }
    },
    'formData.vat_deducted_approve': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.totalVatTaxCalculation()
      }
    },
    'formData.bpc_payable_actual_expense_approve': function (newVal, oldVal) {
      if (newVal !== oldVal) {
       this.finalPayable(newVal)
      }
    }
   },
   methods: {
     totalVatTaxCalculation () {
      this.formData.total_approve = parseFloat(this.formData.tax_deducted_approve) + parseFloat(this.formData.actual_expenditure_approve) + parseFloat(this.formData.vat_deducted_approve)
    },
    finalPayable (percent) {
      const perceFinalPay = (parseFloat(percent) / 100) * parseFloat(this.formData.total_approve)
      this.formData.final_payable_approve = parseFloat(perceFinalPay)
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
       result = await RestApi.postData(eBizServiceBaseUrl, approveBillSave, this.formData)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)

       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Success',
           message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
           color: '#D6E09B'
         })
         this.$bvModal.hide('approve-bill-form')
       } else {
         this.$refs.mainForm.setErrors(result.errors)
       }
     }
     },
     RejectBill (status) {
        window.vm.$swal({
            title: window.vm.$t('eBizProgram.bill_reject_sure_msg'),
            showCancelButton: true,
            confirmButtonText: window.vm.$t('globalTrans.yes'),
            cancelButtonText: window.vm.$t('globalTrans.no'),
            focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
             this.saveRejectBill(status)
            }
        })
    },
     async saveRejectBill (status) {
       this.$store.dispatch('mutateCommonProperties', { loading: true })
       let result = null
       const loadingState = { loading: false, listReload: false }
       const params = {
            bill_id: this.items.id,
            status: status
       }
       result = await RestApi.postData(eBizServiceBaseUrl, rejectProgramBill, params)
       loadingState.listReload = true
       this.$store.dispatch('mutateCommonProperties', loadingState)

       if (result.success) {
         this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
         this.$toast.success({
           title: 'Warning',
           message: this.$t('eBizProgram.bill_reject_msg'),
           color: '#FF0000'
         })
         this.$bvModal.hide('approve-bill-form')
       }
     },
     async getProgramBillAgainstProposal (proposalId) {
      this.formData.remaining_proposal_budget = parseFloat(this.formData.total_proposal_budget) - parseFloat(this.formData.advance_paid)
        // const params = {
        //     program_id: this.items.program.id,
        //     proposal_id: proposalId
        // }
        // const result = await RestApi.getData(eBizServiceBaseUrl, programSubmitBillList, params)
        // if (result.success) {
        //   const proposalIds = result.detail_ids
        //   const inititalProposals = this.items.program.initial_proposals
        //   const remainingProposal = inititalProposals.filter(function (event) {
        //       return !proposalIds.includes(event.id)
        //   })
        //   this.formData.remaining_proposal_budget = remainingProposal.reduce((sum = 0, item) => sum + item.amount, 0)
        // } else {
        //   this.remainingProposal = []
        // }
    },
     getEditEntry () {
       const itemId = this.id
       const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
       return JSON.parse(JSON.stringify(tmpData))
     }
   }
 }
 </script>
