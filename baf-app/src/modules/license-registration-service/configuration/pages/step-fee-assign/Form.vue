<template>
  <b-row>
    <b-overlay :show="loading">
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(addTmp)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
          <b-row>
            <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="stepAssign.org_id"
                  :options="orgProfileList"
                  :disabled="isDisable"
                  id="org_id"
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
            <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                <b-form-group
                  label-for="service_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="stepAssign.service_id"
                  :options="serviceList"
                  :disabled="isDisable"
                  id="service_id"
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
            <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Step Name" vid="service_step_id" rules="required|min_value:1">
                <b-form-group
                  label-for="service_step_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('step_name.step_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="detailsFormData.service_step_id"
                  :options="stepList"
                  id="step_id"
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
            <b-col xs="12" sm="12" md="6"></b-col>
            <b-col xs="12" sm="12" md="12">
              <b-row>
                <b-col lg="6" sm="6" md="6" class="">
                  <ValidationProvider name="step_payment" vid="step_payment">
                    <b-form-group
                      class="row"
                      label-cols-sm="6"
                      label-for="step_payment"
                    >
                      <template v-slot:label>
                        {{ $t('step_assign.step_payment') }}
                      </template>
                      <b-form-checkbox
                        id="step_payment"
                        v-model="detailsFormData.assign_fee"
                        :value=1
                        :unchecked-value=0
                        style="margin-top: 8px"
                      >
                      </b-form-checkbox>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="lab_fee" vid="lab_fee">
                    <b-form-group
                      class="row"
                      label-cols-sm="6"
                      label-for="lab_fee"
                    >
                      <template v-slot:label>
                        {{ $t('step_assign.lab_fee') }}
                      </template>
                      <b-form-checkbox
                        id="lab_fee"
                        v-model="detailsFormData.lab_fee"
                        :value=1
                        :unchecked-value=0
                        style="margin-top: 8px"
                      >
                      </b-form-checkbox>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <div v-if="step_fee">
                <b-row v-for="(item, index) in detailsFormData.feeInfo" :key="`fee_info_${index}`">
                  <b-col lg="5" sm="5" md="5">
                    <ValidationProvider name="Fee Name" vid="fee_id" rules="">
                      <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="fee_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('fee_name.fee_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="item.fee_id"
                          :options="feeList"
                          id="fee_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="5" sm="5" md="5">
                    <ValidationProvider name="Amount" vid="amount" rules="">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="amount"
                          slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('step_assign.amount')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            id="amount"
                            v-model="item.amount"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="5" sm="5" md="5">
                    <ValidationProvider name="Vat" vid="vat" rules="">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="vat"
                          slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('step_assign.vat')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            id="vat"
                            v-model="item.vat"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="5" sm="5" md="5">
                    <ValidationProvider name="tax" vid="tax" rules="">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="tax"
                          slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('step_assign.tax')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            id="tax"
                            v-model="item.tax"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="5" sm="5" md="5">
                      <ValidationProvider :vid="`challan_no`" rules="">
                          <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="tax"
                          slot-scope="{ valid, errors }"                                  >
                          <template v-slot:label>
                            {{$t('component_settings.challan_no')}} <span class="text-danger">*</span>
                          </template>
                            <b-form-select
                              plain
                              v-model="item.challan_id"
                              :options="challanList"
                              :id="`challan_no`"
                              :state="errors[0] ? false : (valid ? true : null)"
                            >
                              <template v-slot:first>
                                <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                              </template>
                            </b-form-select>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col lg="7" sm="7" md="7" class="text-right">
                    <b-button v-if="index === 0" type="button" @click="addFee()" variant="primary" class="mr-2 btn-sm">{{ $t('globalTrans.add') }}</b-button>
                    <b-button v-if="index !== 0" type="button" @click="removeFee(index)" variant="danger" class="mr-2 btn-sm">X</b-button>
                  </b-col>
                </b-row>
              </div>
            </b-col>
            <b-col sm="12" md="12" lg="12" class="mb-2">
              <h5>{{ $t('service_name.field_payment') }}</h5>
            </b-col>
            <b-col sm="6" md="6" lg="6">
              <ValidationProvider name="checkbox_payment" vid="checkbox_payment" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="checkbox_payment"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                    {{ $t('service_name.checkbox_payment') }}
                  </template>
                  <b-form-select
                    plain
                    v-model="detailsFormData.checkbox_payment"
                    :options="inputList"
                    id="checkbox_payment"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col sm="6" md="6" lg="6">
              <ValidationProvider name="field_payment" vid="field_payment" rules="">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="field_payment"
                  slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                    {{ $t('service_name.field_payment') }}
                  </template>
                  <b-form-select
                    plain
                    v-model="detailsFormData.field_payment"
                    :options="inputList"
                    id="field_payment"
                    :state="errors[0] ? false : (valid ? true : null)"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col sm="6" md="6" lg="6">
              <ValidationProvider name="Challan No" vid="challan_id" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="challan_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('component_settings.challan_no') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="detailsFormData.challan_id"
                    :options="challanList"
                    id="challan_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                    >
                    <template v-slot:first>
                      <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row class="text-right">
            <b-col>
              <b-button type="button" variant="primary" class="btn-sm mb-2" @click="addTmp()">{{ $t('globalTrans.add') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
      <ValidationObserver ref="form1"  v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(storeUpdate)" @reset.prevent="reset" enctype="multipart/form-data">
          <br>
          <b-row>
            <b-table-simple  bordered>
              <thead>
                <tr class="">
                  <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                  <th scope="col">{{ $t('step_name.step_name') }}</th>
                  <th scope="col">{{ $t('service_name.checkbox_payment') }}</th>
                  <th scope="col">{{ $t('service_name.field_payment') }}</th>
                  <th scope="col">{{ $t('component_settings.challan_no') }}</th>
                  <th scope="col">{{ $t('fee_name.fee_name') }}</th>
                  <th scope="col">{{ $t('step_assign.amount') }}</th>
                  <th scope="col">{{ $t('step_assign.vat') }}</th>
                  <th scope="col">{{ $t('step_assign.tax') }}</th>
                  <th scope="col" class="text-center">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody v-if="feeLoaded">
                <slot v-for="(item, index) in stepAssign.details">
                  <slot v-for="(i, indx) in item.feeInfo">
                    <b-tr v-if="indx === 0" :key="index">
                      <td :rowspan='item.feeInfo.length'>
                        {{ $n(index + 1) }}
                      </td>
                      <td :rowspan='item.feeInfo.length'>
                        {{ getStepName(item.service_step_id) }}
                      </td>
                      <td :rowspan='item.feeInfo.length'>
                        <ValidationProvider :vid="`checkbox_payment_${index}_${indx}`" rules="">
                            <b-form-group
                              class="m-0"
                              slot-scope="{ valid, errors }"
                            >
                              <b-form-select
                                plain
                                v-model="stepAssign.details[index].checkbox_payment"
                                :options="inputList"
                                :id="`checkbox_payment_${index}_${indx}`"
                                :state="errors[0] ? false : (valid ? true : null)"
                              >
                                <template v-slot:first>
                                  <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                              </b-form-select>
                            </b-form-group>
                          </ValidationProvider>
                      </td>
                      <td :rowspan='item.feeInfo.length'>
                        <ValidationProvider :vid="`field_payment_${index}_${indx}`" rules="">
                            <b-form-group
                              class="m-0"
                              slot-scope="{ valid, errors }"
                            >
                              <b-form-select
                                plain
                                v-model="stepAssign.details[index].field_payment"
                                :options="inputList"
                                :id="`field_payment_${index}_${indx}`"
                                :state="errors[0] ? false : (valid ? true : null)"
                              >
                                <template v-slot:first>
                                  <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                              </b-form-select>
                            </b-form-group>
                          </ValidationProvider>
                      </td>
                      <td :rowspan='item.feeInfo.length'>
                        <ValidationProvider :vid="`challan_no_${index}_${indx}`" rules="">
                            <b-form-group
                              class="m-0"
                              slot-scope="{ valid, errors }"
                            >
                              <b-form-select
                                plain
                                v-model="stepAssign.details[index].challan_id"
                                :options="challanList"
                                :id="`challan_no_${index}_${indx}`"
                                :state="errors[0] ? false : (valid ? true : null)"
                              >
                                <template v-slot:first>
                                  <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                              </b-form-select>
                            </b-form-group>
                        </ValidationProvider>
                      </td>
                      <td>
                        {{ getFeeName(i.fee_id) }}
                          <ValidationProvider :vid="`challan_no`" rules="">
                            <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="tax"
                            slot-scope="{ valid, errors }"                                  >
                            <template v-slot:label>
                              {{$t('component_settings.challan_no')}} <span class="text-danger">*</span>
                            </template>
                              <b-form-select
                                plain
                                v-model="i.challan_id"
                                :options="challanList"
                                :id="`challan_no`"
                                :state="errors[0] ? false : (valid ? true : null)"
                              >
                                <template v-slot:first>
                                  <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                              </b-form-select>
                            </b-form-group>
                        </ValidationProvider>
                      </td>
                      <td>
                        {{ i.amount === 0 ? '' : i.amount }}
                      </td>
                        <td>
                        {{ i.vat === 0 ? '' : i.vat }}
                      </td>
                      <td>
                        {{ i.tax === 0 ? '' : i.tax }}
                      </td>
                      <td :rowspan='item.feeInfo.length'>
                        <b-button type="button" @click="remove(index)" class="btn btn- iq-bg-danger btn-sm text-center ml-1"><i class="ri-delete-bin-line m-0"></i></b-button>
                      </td>
                    </b-tr>
                    <b-tr v-if="indx !== 0" :key="`${index}_${indx}`">
                      <td>
                        {{ getFeeName(i.fee_id) }}
                          <ValidationProvider :vid="`challan_no`" rules="">
                            <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="tax"
                            slot-scope="{ valid, errors }"                                  >
                            <template v-slot:label>
                              {{$t('component_settings.challan_no')}} <span class="text-danger">*</span>
                            </template>
                              <b-form-select
                                plain
                                v-model="i.challan_id"
                                :options="challanList"
                                :id="`challan_no`"
                                :state="errors[0] ? false : (valid ? true : null)"
                              >
                                <template v-slot:first>
                                  <b-form-select-option :value=0>{{ $t('globalTrans.select') }}</b-form-select-option>
                                </template>
                              </b-form-select>
                            </b-form-group>
                        </ValidationProvider>
                      </td>
                      <td>
                        {{ i.amount === 0 ? '' : i.amount }}
                      </td>
                      <td>
                        {{ i.vat === 0 ? '' : i.vat }}
                      </td>
                      <td>
                        {{ i.tax === 0 ? '' : i.tax }}
                      </td>
                    </b-tr>
                  </slot>
                </slot>
              </b-tbody>
            </b-table-simple>
          </b-row>
          <div class="row">
            <div class="col-sm-3"></div>
            <div class="col text-right">
              <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
              &nbsp;
              <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </div>
          </div>
        </b-form>
      </ValidationObserver>
    </b-overlay>
  </b-row>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dynamicFormEditData, stepFeeAssignStore, stepFeeAssignUpdate, stepFeeAssignGetFeesList } from '../../api/routes'
import { isNotEmpty, snakeToWords } from '@/utils/fliter'
export default {
  name: 'Form',
  props: ['item', 'id', 'orgId'],
  data () {
    return {
      loading: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      detailsFormData: {
        service_step_id: 0,
        assign_fee: false,
        lab_fee: 0,
        checkbox_payment: 0,
        field_payment: 0,
        challan_id: 0,
        feeInfo: [
          {
            amount: '',
            fee_id: '',
            lab_fee: 0,
            challan_id: 0,
            vat: '',
            tax: ''
          }
        ]
      },
      stepAssign: {
        org_id: 0,
        service_id: 0,
        details: []
      },
      inputList: [],
      inputListCustomLoader: false,
      isDisable: false,
      feeLoaded: false,
      feeList: [],
      serviceList: [],
      stepList: [],
      unitLoad: false,
      step_fee: false,
      checkbox_payment: '',
      field_payment: '',
      challanList: []
    }
  },
  created () {
    if (this.id) {
      this.isDisable = true
      this.stepAssign.org_id = this.orgId
      const tmp = this.getServiceStepData(this.item)
      this.stepAssign.details = tmp
    }
  },
  watch: {
    'stepAssign.org_id': function (newVal) {
      this.serviceList = this.getServiceList(newVal)
    },
    'stepAssign.service_id': function (newVal) {
      this.stepList = this.getStepList(newVal)
      this.getInputList(newVal)
      this.getFeeList()
      this.challanList = this.getChallanList(newVal)
    },
    'detailsFormData.assign_fee': function (newVal) {
      if (this.detailsFormData.assign_fee === 1) {
        this.step_fee = true
      } else {
        this.step_fee = false
      }
    },
    'detailsFormData.lab_fee': function (newVal) {
      this.detailsFormData.feeInfo[0].lab_fee = newVal
    }
  },
  computed: {
    orgProfileList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    },
    apiList: function () {
      const apiList = [
        {
          text_en: 'Bank Account',
          text_bn: 'ব্যাংক অ্যাকাউন্ট',
          value: 1
        },
        {
          text_en: 'Challan No',
          text_bn: 'চালান নম্বর',
          value: 2
        }
      ]
      return apiList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { text: item.text_bn, value: item.value }
        } else {
          return { text: item.text_en, value: item.value }
        }
      })
    }
  },
  methods: {
    isNotEmpty (val) {
      return isNotEmpty(val)
    },
    /** Fee */
    getFeeList () {
      this.detailsFormData.service_step_id = 0
      this.unitLoad = true
      const params = Object.assign({}, { org_id: this.stepAssign.org_id, service_id: this.stepAssign.service_id })
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFeeAssignGetFeesList, params).then(response => {
        if (isNotEmpty(response.stepList)) {
          this.stepList = response.stepList.map(item => {
            const textTranslate = (this.$i18n.locale === 'en') ? item.text_en : item.text_bn
            return Object.assign({}, item, { text: textTranslate })
          })
        }
        if (isNotEmpty(response.data)) {
          const fees = this.$store.state.LicenseRegistrationService.commonObj.feeNamesList
          this.feeList = response.data.map(item => {
            const tmpFee = fees.find(fee => fee.value === item.fee_id)
            return tmpFee
          })
          this.feeLoaded = true
        } else {
          this.feeLoaded = true
          this.feeList = []
        }
        this.unitLoad = false
      })
    },
    /** Input List -> Dynamic Form Id -> Grid Step Object  -> Service Step Form Store */
    getInputList (serviceId = 0) {
      this.detailsFormData.checkbox_payment = 0
      this.detailsFormData.field_payment = 0
      if (serviceId === 0) {
        this.inputList = []
        return
      }
      const tmpServiceStepForm = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (tmpServiceStepForm === undefined) {
        this.inputList = []
        return
      }
      this.inputListCustomLoader = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + tmpServiceStepForm.form_id).then(response => {
        if (response.success && response.data) {
          const finalList = []
          // 1) Tabs
          response.data.tabs.forEach(item => {
            const tmpList = {
                label: snakeToWords(item.tab_name),
                options: []
              }
            // 2) Layouts
            item.layouts.forEach(i => {
              const input = JSON.parse(i.data)
              if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'paymentCheckbox' || input.field_type === 'payment' || input.field_type === 'options' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date') {
                  tmpList.options.push({
                    text: input.label, value: input.field_name
                  })
                }
            })
            finalList.push(tmpList)
          })
          this.inputList = finalList
        } else {
          /** Data Not Found */
          this.inputList = []
        }
        this.inputListCustomLoader = false
      })
    },
    getChallanList (serviceId) {
      return this.$store.state.LicenseRegistrationService.commonObj.challanList.filter(item => item.status === 1 && item.service_id === serviceId)
    },
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getStepList (serviceId) {
      return this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.filter(item => item.status === 1 && item.service_id === serviceId)
    },
    addTmp () {
      this.stepAssign.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
      this.detailsFormData.service_step_id = 0
      this.detailsFormData.assign_fee = 0
      this.detailsFormData.checkbox_payment = 0
      this.detailsFormData.field_payment = 0
      this.detailsFormData.challan_id = 0
      this.detailsFormData.lab_fee = 0
      this.detailsFormData.feeInfo = [{
          amount: '',
          fee_id: '',
          lab_fee: 0,
          challan_id: 0,
          vat: '',
          tax: ''
      }]
      this.$nextTick(() => {
        this.$refs.form.reset()
      })
    },
    remove (key) {
      this.stepAssign.details.splice(key, 1)
    },
    addFee () {
      const tmp = {
            amount: '',
            fee_id: '',
            lab_fee: 0,
            challan_id: 0,
            vat: '',
            tax: ''
          }
      this.detailsFormData.feeInfo.push(tmp)
    },
    removeFee (key) {
      this.detailsFormData.feeInfo.splice(key, 1)
    },
    getStepName (stepId) {
      const tmpStep = this.stepList.find(step => step.value === stepId)
      return this.$i18n.locale === 'en' ? tmpStep !== undefined ? tmpStep.text_en : '' : tmpStep !== undefined ? tmpStep.text_bn : ''
    },
    getServiceStepData (data) {
      const detailData = []
      this.stepAssign.service_id = this.id
      Object.entries(data).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          const stepItem = { service_step_id: value.id, checkbox_payment: value.checkbox_payment, field_payment: value.field_payment, challan_id: value.challan_id, lab_fee: value.lab_fee, feeInfo: value.details }
          detailData.push(stepItem)
        })
      })
      return detailData
    },
    async storeUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadinState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${stepFeeAssignUpdate}/${this.id}`, this.stepAssign)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stepFeeAssignStore, this.stepAssign)
      }
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      this.loading = false
      if (result.exist) {
        this.$toast.error({
          title: 'Error',
          message: result.message
        })
        return
      }
      if (result.success) {
        this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? 'Data updated successfully' : 'Data save successfully',
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-form')
      } else {
        if (result.errors) this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
    },
    getOrgName (orgId) {
      const tmpOrg = this.$store.state.commonObj.organizationProfileList.find(item => item.value === orgId)
      return this.$i18n.locale === 'en' ? tmpOrg !== undefined ? tmpOrg.text_en : '' : tmpOrg !== undefined ? tmpOrg.text_bn : ''
    },
    getFeeName (feeId) {
      const tmpFee = this.feeList.find(step => step.value === feeId)
      return this.$i18n.locale === 'en' ? tmpFee !== undefined ? tmpFee.text_en : '' : tmpFee !== undefined ? tmpFee.text_bn : ''
    }
  }
}
</script>
