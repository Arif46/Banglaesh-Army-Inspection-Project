
<template>
<b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading || loadData">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                <b-row>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                      <ValidationProvider name="Request Id" vid="request_id" rules="required">
                        <b-form-group
                          label-for="request_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                            {{ $t('stock_management.request_id') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input
                            id="request_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            v-model="formData.request_id"
                          ></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Warehouse From" vid="warehouse_id_from" rules="required|min_value:1">
                      <b-form-group
                        label-for="warehouse_id_from"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.warehouse_from')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.warehouse_id_from"
                        :options="fromWarehouseList"
                        id="warehouse_id_from"
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
                    <ValidationProvider name="Warehouse To" vid="warehouse_to_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="warehouse_to_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.warehouse_to')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.warehouse_to_id"
                        :options="toWarehouseList"
                        id="warehouse_to_id"
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
                    <ValidationProvider name="Request Date" vid="request_date" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="request_date">
                        <template v-slot:label>
                          {{ $t('stock_management.request_date') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="request_date"
                          v-model="formData.request_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          :config="{ static: true }"
                        >
                        </date-picker>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Transfer Date" vid="transfer_date" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="transfer_date">
                        <template v-slot:label>
                          {{ $t('stock_management.transfer_date') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="transfer_date"
                          v-model="formData.transfer_date"
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          :config="{ static: true }"
                        >
                        </date-picker>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  </b-row>
                  <b-row>
                  <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Reason (En)" vid="reason_en">
                        <b-form-group
                          label-for="reason_en">
                          <template v-slot:label>
                            {{ $t('stock_management.reason_en') }}
                          </template>
                          <b-form-input
                            id="reason_en"
                            v-model="formData.reason_en"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Reason (Bn)" vid="reason_bn">
                        <b-form-group
                          label-for="reason_bn">
                          <template v-slot:label>
                            {{ $t('stock_management.reason_bn') }}
                          </template>
                          <b-form-input
                            id="reason_bn"
                            v-model="formData.reason_bn"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>

                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Remarks (En)" vid="remarks_en">
                        <b-form-group
                          label-for="remarks_en">
                          <template v-slot:label>
                            {{ $t('stock_management.remarks_en') }}
                          </template>
                          <b-form-input
                            id="remarks"
                            v-model="formData.remarks_en"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Remarks (Bn)" vid="remarks_bn">
                        <b-form-group
                          label-for="remarks_bn">
                          <template v-slot:label>
                            {{ $t('stock_management.remarks_bn') }}
                          </template>
                          <b-form-input
                            id="remarks_bn"
                            v-model="formData.remarks_bn"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Receieve Reason (En)" vid="receieve_reason_en">
                        <b-form-group
                          label-for="receieve_reason_en">
                          <template v-slot:label>
                            {{ $t('stock_management.receieve_reason_en') }}
                          </template>
                          <b-form-input
                            id="receieve_reason_en"
                            v-model="formData.receieve_reason_en"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="receieve Reason (Bn)" vid="receieve_reason_bn">
                        <b-form-group
                          label-for="receieve_reason_bn">
                          <template v-slot:label>
                            {{ $t('stock_management.receieve_reason_bn') }}
                          </template>
                          <b-form-input
                            id="receieve_reason_bn"
                            v-model="formData.receieve_reason_bn"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Receieve Reason Remarks (En)" vid="receieve_remarks_en">
                        <b-form-group
                          label-for="receieve_remarks_en">
                          <template v-slot:label>
                            {{ $t('stock_management.receieve_remarks_en') }}
                          </template>
                          <b-form-input
                            id="receieve_remarks_en"
                            v-model="formData.receieve_remarks_en"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Receieve Reason Remarks (Bn)" vid="receieve_remarks_bn">
                        <b-form-group
                          label-for="receieve_remarks_bn">
                          <template v-slot:label>
                            {{ $t('stock_management.receieve_remarks_bn') }}
                          </template>
                          <b-form-input
                            id="receieve_remarks_bn"
                            v-model="formData.receieve_remarks_bn"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col xs="12" sm="12" md="6">
                      <ValidationProvider name="Transfer Attachment" vid="transfer_attachment" :rules="is_required">
                          <b-form-group
                              label-for="transfer_attachment"
                              slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{$t('stock_management.transfer_attachment')}} <span v-if="is_required" class="text-danger">*</span>
                          </template>
                              <b-form-file
                                placeholder="Choose a file"
                                id="transfer_attachment"
                                v-on:change="ontTransferAttachmentChange"
                                accept="image/*"
                                v-model="formData.attachment"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-file>
                              <div class="invalid-feedback">
                                {{ errors[0] }} <br>
                                <span>* Max file size 1 MB and allowed file type: jpg,jpeg,png.</span>
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
                <!-- =============End Main========= -->
           <template>
                <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h5 class="text-white text-left">
                        {{ $t('stock_management.inter_warehouse_transfer') }}  {{ $t('stock_management.item') }} {{ $t('globalTrans.details') }}
                    </h5>
                </div>
            </template>
            <hr>
             <!-- =================Add More Start===================== -->
          <ValidationObserver ref="stockInForm" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading || loadData">
              <b-form @submit.prevent="handleSubmit(stockinAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Contract Number" vid="contract_no_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="contract_no_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.contract_no')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="stockItemData.contract_no_id"
                        :options="contractNoList"
                        id="contract_no_id"
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
                    <ValidationProvider name="Item Category" vid="item_category_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="item_category_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.item_category')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="stockItemData.item_category_id"
                        :options="itemCategoryList"
                        id="item_category_id"
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
                    <ValidationProvider name="Item" vid="item_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="item_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.item')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="stockItemData.item_id"
                        :options="itemList"
                        id="item_id"
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
                  <!-- <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Unit" vid="unit_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="unit_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.item')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="stockItemData.unit_id"
                        :options="unitList"
                        id="unit_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :disabled="true"
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
                  </b-col> -->
                  <b-col xs="6" sm="6" md="6">
                    <ValidationProvider name="Available Quantity" vid="available_quantity">
                      <b-form-group
                        label-for="available_quantity">
                        <template v-slot:label>
                          {{ $t('stock_management.available_quantity') }}<span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          id="available_quantity"
                          v-model="stockItemData.available_quantity"
                          :disabled="true"
                        ></b-form-input>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="6" sm="6" md="6">
                    <ValidationProvider name="Quantity" vid="quantity" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="quantity">
                        <template v-slot:label>
                          {{ $t('stock_management.stock_out_quantity') }}<span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          id="quantity"
                          v-model="stockItemData.quantity"
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                        <div v-if="qntyAlertShow" class="custom-invalid-feedback">Quantity Is More Than available Quantity</div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
                <b-row class="text-right">
                  <b-col>
                      <b-button :disabled="loading" type="submit" variant="success" class="mr-2 btn-sm">
                          <span v-if="loading">
                              <b-spinner small label="Loading..."></b-spinner>
                          </span>
                          <span v-else>
                              <i class="fas fa-plus-circle m-0"></i>
                          </span>
                          {{$t('stock_management.add_more')}}
                      </b-button>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
          <br/>
            <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
              <div class="table-responsive">
                  <table class="table table-sm table-bordered table-responsive">
                      <thead>
                          <tr class="bg-primary">
                              <th style="width: 5%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                              <th style="width: 30%"><div>{{ $t('stock_management.contract_no') }}</div></th>
                              <th style="width: 10%"><div>{{ $t('stock_management.item_category') }}</div></th>
                              <th style="width: 15%"><div>{{ $t('stock_management.item') }}</div></th>
                              <th style="width: 15%"><div>{{ $t('stock_management.quantity') }}</div></th>
                              <th style="width: 30%"><div>{{ $t('globalTrans.action') }}</div></th>
                          </tr>
                      </thead>
                      <tbody>
                          <template v-if="arrStockItemData && arrStockItemData.length > 0">
                              <tr v-for="(item, index) in arrStockItemData" :key="index">
                                  <td  class="text-center">{{ index+1 }}</td>
                                  <td  class="text-center">{{ item.contract_no }}</td>
                                  <td class="text-center">{{ $i18n.locale === 'bn' ? item.item_category_name_bn : item.item_category_name_en }}</td>
                                  <td class="text-center">{{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}</td>
                                  <td class="text-center">{{ item.quantity }}</td>
                                  <td class="text-center">
                                      <!-- <b-button variant="iq-bg-success mr-1" size="sm" @click="stockItemEdit(index)" class="action-btn edit"><i class="ri-pencil-fill"></i></b-button> -->
                                      <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" @click="stockItemRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
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
              <!-- &&&&&&&&&&&&&&Manual Info Details End&&&&&&&&&&&&&&& -->
          <!-- =================Add More End===================== -->
          <br>
      <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<style scoped>
.custom-invalid-feedback {
    width: 100%;
    margin-top: 0.25rem;
    font-size: 80%;
    color: #dc3545;
}
</style>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { innerWarehTransferStore, innerWarehTransferUpdate, stockOutAvailableData, stockOutGetContractNumber } from '../../../api/routes'
import userTypeModule from '../../../../../../utils/userType'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      loadData: false,
      is_required: 'required|size:1024',
      formData: {
        contract_no: '',
        warehouse_id_from: 0,
        warehouse_to_id: 0,
        request_date: '',
        transfer_date: '',
        reason_en: '',
        reason_bn: '',
        remarks_en: '',
        remarks_bn: '',
        receieve_reason_en: '',
        receieve_reason_bn: '',
        receieve_remarks_en: '',
        receieve_remarks_bn: '',
        attachment: null,
        tempAttachment: null,
        stockItemDataArr: []
      },
      stockItemData: {
        contract_no_id: 0,
        contract_no: '',
        item_category_id: 0,
        item_category_name_en: '',
        item_category_name_bn: '',
        item_id: 0,
        item_name_en: '',
        item_name_bn: '',
        available_quantity: 0,
        quantity: 0
      },
      arrStockItemData: [],
      fromWarehouseList: [],
      itemList: [],
      contractNoList: [],
      qntyAlertShow: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
    }
    this.checkGetWarehosueUserList()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    },
    auth () {
      return this.$store.state.Auth
    }
  },
  watch: {
    'stockItemData.item_category_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === newVal)
      }
    },
    'stockItemData.item_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal > 0) {
        this.getItemAvailbale(newVal)
      }
    },
    'stockItemData.quantity': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal > this.stockItemData.available_quantity) {
          this.qntyAlertShow = true
        } else {
          this.qntyAlertShow = false
        }
      }
    },
    'formData.warehouse_id_from': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.contractNoList = []
        this.toWarehouseList = []
        this.toWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.org_id === this.$store.state.Auth.authUser.org_id && item.value !== newVal)
          this.getContractAbailable(newVal)
      }
    },
    'stockItemData.contract_no_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.stockItemData.stockItemData = 0
        this.stockItemData.item_category_id = 0
        this.stockItemData.item_id = 0
        this.stockItemData.available_quantity = 0
        this.stockItemData.quantity = 0
      }
    }
  },
  methods: {
    async getItemAvailbale (itemId) {
        this.loadData = true
        let result = null
        const params = Object.assign({}, { contract_no_id: this.stockItemData.contract_no_id, warehouse_id: this.formData.warehouse_id_from, item_id: itemId })
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stockOutAvailableData, params)
        if (result.success) {
            this.stockItemData.available_quantity = result.data
            this.loadData = false
        } else {
            this.loadData = false
        }
    },
        //  =========Warehouse related Contract Number Strat=========
    async getContractAbailable (itemId) {
              this.loadData = true
              let result = null
              const params = Object.assign({}, { warehouse_id: this.formData.warehouse_id_from })
              result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stockOutGetContractNumber, params)
              if (result.success) {
                  this.contractNoList = result.data.map(item => {
              if (this.$i18n.locale === 'bn') {
                  return { value: item.id, text: item.contract_no + '(' + item.supplier_name_bn + ')' }
              } else {
                  return { value: item.id, text: item.contract_no + '(' + item.supplier_name + ')' }
              }
          })
                  this.loadData = false
              } else {
                  this.loadData = false
              }
    },
    //  =========Warehouse related Contract Number End===========
    ontTransferAttachmentChange (e) {
        var file = e.target.files[0]
        var reader = new FileReader()
        // eslint-disable-next-line no-return-assign
        reader.onloadend = () => this.formData.tempAttachment = reader.result
        reader.readAsDataURL(file)
    },
    // ================Edu Info Start=================
    async stockinAddItem () {
            const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(quaItem => quaItem.value === this.stockItemData.item_category_id)
            const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(sinItem => sinItem.value === this.stockItemData.item_id)
            const contractObj = this.contractNoList.find(sinItem => sinItem.value === this.stockItemData.contract_no_id)
            var obj = {
                contract_no_id: this.stockItemData.contract_no_id,
                contract_no: contractObj !== undefined ? contractObj.text : '',
                item_category_id: this.stockItemData.item_category_id,
                item_category_name_en: cateObj !== undefined ? cateObj.text_en : '',
                item_category_name_bn: cateObj !== undefined ? cateObj.text_bn : '',
                item_id: this.stockItemData.item_id,
                item_name_en: itemObj !== undefined ? itemObj.text_en : '',
                item_name_bn: itemObj !== undefined ? itemObj.text_bn : '',
                quantity: parseFloat(this.stockItemData.quantity)
            }
              // this.loading = true
                  if (this.stockItemData.key === undefined) {
                    const extItem = this.formData.stockItemDataArr.find(eItm => eItm.item_id === this.stockItemData.item_id && eItm.contract_no_id === this.stockItemData.contract_no_id)
                    if (extItem === undefined) {
                      this.formData.stockItemDataArr.push(obj)
                    } else {
                      // extItem.quantity += parseFloat(this.stockItemData.quantity)
                      extItem.quantity = parseFloat(this.stockItemData.quantity)
                    }
                  } else {
                    this.formData.stockItemDataArr[this.stockItemData.key].contract_no_id = this.stockItemData.contract_no_id
                      this.formData.stockItemDataArr[this.stockItemData.key].contract_no = contractObj !== undefined ? contractObj.text : ''
                      this.formData.stockItemDataArr[this.stockItemData.key].item_category_id = this.stockItemData.item_category_id
                      this.formData.stockItemDataArr[this.stockItemData.key].item_category_name_en = cateObj !== undefined ? cateObj.text_en : ''
                      this.formData.stockItemDataArr[this.stockItemData.key].item_category_name_bn = cateObj !== undefined ? cateObj.text_bn : ''
                      this.formData.stockItemDataArr[this.stockItemData.key].item_id = this.stockItemData.item_id
                      this.formData.stockItemDataArr[this.stockItemData.key].item_name_en = itemObj !== undefined ? itemObj.text_en : ''
                      this.formData.stockItemDataArr[this.stockItemData.key].item_name_bn = itemObj !== undefined ? itemObj.text_bn : ''
                      this.formData.stockItemDataArr[this.stockItemData.key].quantity = this.stockItemData.quantity
                  }
                  this.stockItemData = {
                        contract_no_id: 0,
                        contract_no: '',
                        item_category_id: 0,
                        item_category_name_en: '',
                        item_category_name_bn: '',
                        item_id: 0,
                        item_name_en: '',
                        item_name_bn: '',
                        quantity: 0
                  }
                  this.arrStockItemData = this.formData.stockItemDataArr
                  this.$refs.stockInForm.reset()
                  this.loading = false
    },
    stockItemRemove (key) {
        this.formData.stockItemDataArr.splice(key, 1)
    },
    stockItemEdit (key) {
      this.stockItemData = this.formData.stockItemDataArr[key]
      this.stockItemData.editMode = true
      this.stockItemData.key = key
    },
    edulevelName (elevId) {
      const list = [
            { value: 1, text: this.$i18n.locale === 'en' ? 'Secondary' : 'মাধ্যমিক' },
            { value: 2, text: this.$i18n.locale === 'en' ? 'Higher Secondary' : 'উচ্চ মাধ্যমিক' },
            { value: 3, text: this.$i18n.locale === 'en' ? 'Diploma' : 'ডিপ্লোমা' },
            { value: 4, text: this.$i18n.locale === 'en' ? 'Bachelor' : 'স্নাতক' },
            { value: 5, text: this.$i18n.locale === 'en' ? 'Masters' : 'মাস্টার্স' },
            { value: 6, text: this.$i18n.locale === 'en' ? 'PHD' : 'পিএইচডি' }
        ]
      const edulvlObj = list.find(quaItem => quaItem.value === elevId)
      if (edulvlObj !== undefined) {
        return edulvlObj.text
      } else {
        return ''
      }
    },
        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.stockItemDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${innerWarehTransferUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, innerWarehTransferStore, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    checkGetWarehosueUserList () {
      const warehouseUser = this.$store.state.LicenseRegistrationService.commonObj.userWarehouseList.filter(item => item.user_id === parseInt(this.auth.authUser.user_id))
      if (userTypeModule.userType('is_office_user')) {
        if (warehouseUser.length) {
          const tmpWarehouses = []
          warehouseUser.forEach(itm => {
            const tmpWare = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === parseInt(itm.warehouse_id))
            tmpWarehouses.push(tmpWare)
          })
          this.warehouseList = tmpWarehouses
        }
      } else {
        this.fromWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      }
    }
  }
}
</script>
