
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
                            :disabled="true"
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
                        :disabled="true"
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
                        :disabled="true"
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
                        <b-form-datepicker b-form-datepicker
                          id="request_date"
                          v-model="formData.request_date"
                          :disabled="true"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-datepicker>
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
                        <b-form-datepicker b-form-datepicker
                                            id="transfer_date"
                                            v-model="formData.transfer_date"
                                            :disabled="true"
                                            :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </b-form-datepicker>
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
                            :disabled="true"
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
                            :disabled="true"
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
                            :disabled="true"
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
                            :disabled="true"
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
                            :disabled="true"
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
                            :disabled="true"
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
                            :disabled="true"
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                </b-row>
                <!-- =============End Main========= -->
                 <hr>
            <template>
                <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h5 class="text-white text-left">
                        {{ $t('stock_management.inter_warehouse_product_receive') }}  {{ $t('stock_management.item') }} {{ $t('globalTrans.details') }}
                    </h5>
                </div>
            </template>
             <!-- =================Add More Start===================== -->
          <br/>
            <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
              <div class="table-responsive">
                  <table class="table table-sm table-bordered table-responsive">
                      <thead>
                          <tr class="bg-primary">
                              <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.contract_no') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.transfer') }} {{ $t('stock_management.quantity') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.received') }} {{ $t('stock_management.quantity') }}</div></th>
                              <!-- <th scope="col" class="text-center"><div>{{ $t('stock_management.not_received') }} {{ $t('stock_management.quantity') }}</div></th>
                              <th scope="col" class="text-center"><div>{{ $t('stock_management.not_received') }} {{ $t('stock_management.reason') }}</div></th> -->
                          </tr>
                      </thead>
                      <tbody>
                          <template v-if="arrStockItemData && arrStockItemData.length > 0">
                              <tr v-for="(item, index) in arrStockItemData" :key="index">
                                  <td  class="text-center">{{ index+1 }}</td>
                                  <td class="text-center">{{ item.contractnum.contract_no }} ({{ currentLocale === 'en'? item.contractnum.supplier_name : item.contractnum.supplier_name_bn }})</td>
                                  <td class="text-center">{{ categoryName(item.item_category_id) }}</td>
                                  <td class="text-center">{{ itemName(item.item_id) }}</td>
                                  <td class="text-center">{{ item.quantity }}</td>
                                  <td class="text-center">
                                    <ValidationProvider name="Received Quantity" :vid="`received_quantity${index}`" :rules="`required|min_value:1|max_value: ${item.quantity}`">
                                      <b-form-group
                                        slot-scope="{ valid, errors }"
                                      >
                                        <b-form-input
                                          id="`received_quantity${index}`"
                                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                          :value="item.quantity"
                                          v-model="item.quantity"
                                          :state="errors[0] ? false : (valid ? true : null)"
                                          readonly
                                        ></b-form-input>
                                         <div class="invalid-feedback">
                                          {{ errors[0] }}
                                        </div>
                                      </b-form-group>
                                    </ValidationProvider>
                                  </td>
                                  <!-- <td class="text-center">{{ item.quantity - item.received_quantity }}</td> -->
                                  <!-- <td class="text-center">
                                    <ValidationProvider name="Not Reveieve Reason" :vid="`not_reveieve_reason${index}`" rules="required">
                                      <b-form-group
                                        slot-scope="{ valid, errors }"
                                      >
                                        <b-form-input
                                          id="`not_reveieve_reason${index}`"
                                          v-model="item.not_reveieve_reason"
                                          :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-input>
                                         <div class="invalid-feedback">
                                          {{ errors[0] }}
                                        </div>
                                      </b-form-group>
                                    </ValidationProvider>
                                  </td> -->
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
              <b-button type="submit" variant="success" @click.once="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-recivereport')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
      </b-form>
            </b-overlay>
          </ValidationObserver>
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
import { innerWarehProReceiveStore, innerWarehProReceiveUpdate, stockOutGetContractNumber } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id', 'items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('stock_management.received') : this.$t('globalTrans.save'),
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
      arrStockItemData: [],
      toWarehouseList: [],
      itemList: [],
      contractNoList: [],
      disableItemList: [],
      qntyAlertShow: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditData()
      this.formData = tmp
      this.arrStockItemData = tmp.indetails
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fromWarehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
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
        this.toWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.value !== newVal)
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

        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      this.formData.stockItemDataArr = this.arrStockItemData
      if (isValid && this.formData.stockItemDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${innerWarehProReceiveUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, innerWarehProReceiveStore, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-recivereport')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
    },
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    categoryName (catId) {
      const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
        if (cateObj !== undefined) {
          if (this.$i18n.locale === 'bn') {
            return cateObj.text_bn
          } else {
            return cateObj.text_en
          }
        }
      },
      itemName (itemId) {
        const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
          if (itemObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return itemObj.text_bn
            } else {
                return itemObj.text_en
            }
          }
      },
      abcd (val) {
        return parent(val)
      }
  }
}
</script>
