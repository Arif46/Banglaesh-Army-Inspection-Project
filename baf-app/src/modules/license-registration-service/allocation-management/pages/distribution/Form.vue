<template>
<b-container fluid>
    <b-row>
      <b-overlay :show="itemLoad">
        <b-col sm="12">
          <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit()" @reset.prevent="reset">
                <b-row>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Region" vid="office_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="office_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.regional_office')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        disabled
                        v-model="office_id"
                        :options="regionalOfficeList"
                        id="office_id"
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
                    <ValidationProvider name="Warehouse" vid="warehouse_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="warehouse_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.warehouse')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                      disabled
                        plain
                        v-model="warehouse_id"
                        :options="warehouseList"
                        id="warehouse_id"
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
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
          <ValidationObserver ref="itemEntry" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(addItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
              <b-row >
                <b-col xs="12" sm="12" md="4">
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
                      :options="categoryList"
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
                <b-col xs="12" sm="12" md="4">
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
                      :options="stitemList"
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
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Contract No" vid="contract_no_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="contract_no_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('tcbconfiguration.contract_no')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="stockItemData.contract_no_id"
                      :options="contratcList"
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
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Available Quantity" vid="available_quantity" v-slot="{ errors }">
                    <b-form-group
                      label-for="available_quantity">
                      <template v-slot:label>
                        {{ $t('stock_management.available_quantity') }}<span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="available_quantity"
                        v-model="availableQt"
                        readonly
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Allocated Quantity" vid="allocated_quantity" v-slot="{ errors }">
                    <b-form-group
                      label-for="allocated_quantity">
                      <template v-slot:label>
                        {{ $t('allocation_management.allocated_quantity') }}<span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="allocated_quantity"
                        v-model="allocatedQt"
                        readonly
                        oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="4">
                  <ValidationProvider name="Quantity" vid="quantity" :rules="`required|min_value:1|max_value: ${allocatedQt}`" v-slot="{ errors }">
                    <b-form-group
                      label-for="quantity">
                      <template v-slot:label>
                        {{ $t('stock_management.quantity') }}<span class="text-danger">*</span>
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
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row>
                <span class="text-danger">{{err_msg}}</span>
              </b-row>
              <b-row class="text-right">
                <b-col>
                    <b-button :disabled="loading || perm" type="submit" variant="success" class="mr-2 mb-2 btn-sm">
                        {{$t('globalTrans.add')}}
                    </b-button>
                </b-col>
              </b-row>
              <b-row>
                <div class="table-wrapper table-responsive">
                    <table class="table table-striped table-hover table-bordered">
                      <thead>
                        <tr class="bg-primary">
                          <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('stock_management.quantity') }}</div></th>
                          <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                        </tr>
                      </thead>
                      <tbody>
                        <template v-if="formData.details.length > 0">
                            <tr v-for="(item, index) in formData.details" :key="index">
                              <td class="text-center">{{ $n(index+1) }}</td>
                              <td class="text-center">{{ getItemCategoryName(item.item_category_id, item.contract_no_id) }}</td>
                              <td class="text-center">{{ getItemName(item.item_id) }}</td>
                              <td class="text-center">{{ $n(item.quantity) }}</td>
                              <td class="text-center">
                                  <b-button :title="$t('globalTrans.delete')" v-if="!item.id" variant="action-btn delete mr-1" size="sm" @click="remove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
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
              </b-row>
            </b-form>
          </ValidationObserver>
        </b-col>
        <b-col sm="12" class="text-right">
          <b-button type="submit" variant="success" @click="saveUpdate" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
          <b-button variant="danger" class="btn-sm" @click="cancelSubmit">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { wareProducts, distributionDistribute } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('allocation_management.distribute'),
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      errors: [],
      formData: {
        applicant_id: 0,
        allocation_id: 0,
        warehouse_id: 0,
        fiscal_year_id: 0,
        sale_type: 0,
        details: []
      },
      stockItemData: {
        tcb_distribution_id: 0,
        item_id: 0,
        item_category_id: 0,
        contract_no_id: 0,
        quantity: 0
      },
      perm: false,
      err_msg: '',
      availableQt: 0,
      paidlableQt: 0,
      allocatedQt: 0,
      warehouse_id: 0,
      categoryList: [],
      itemList: [],
      stitemList: [],
      wareItems: [],
      requestItems: [],
      contratcList: [],
      loading: false,
      allProvided: true,
      itemLoad: false,
      qtExced: false
    }
  },
  created () {
    if (this.item) {
      this.formData.applicant_id = this.item.applicant_id
      this.stockItemData.tcb_distribution_id = this.item.id
      this.formData.allocation_id = this.item.allocation_id
      this.formData.warehouse_id = this.item.warehouse_id
      this.formData.fiscal_year_id = this.item.fiscal_year_id
      this.formData.sale_type = this.item.sale_type
      this.warehouse_id = this.item.warehouse_id
      this.office_id = this.item.office_id
      this.itemList = []
      this.categoryList = []
      this.item.allocation.details.forEach(item => {
        const reqItem = {
          item_id: item.item_id,
          item_category_id: item.item_category_id,
          quantity: item.quantity,
          paid_quantity: 0
        }
        this.requestItems.push(reqItem)
        this.itemList.push(item.item_id)
        this.getItemCategory(item.item_category_id)
      })
      this.getWareItems()
    }
  },
  computed: {
    warehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === this.office_id)
    },
    regionalOfficeList (orgId = 7) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => (item.status === 1 && item.org_id === 7) && item.is_regional_office === 1)
    }
  },
  watch: {
    'stockItemData.item_category_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        this.stitemList = []
        const itemsWare = this.wareItems.filter(item => item.item_category_id === newVal)
        let itId = 0
        itemsWare.forEach(item => {
          if (itId !== item.item_id) {
            itId = item.item_id
            const itemSt = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(it => it.value === item.item_id)
            if (itemSt !== undefined) {
              this.stitemList.push(itemSt)
            }
          }
        })
      }
    },
    'stockItemData.item_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        this.contratcList = []
        const askedItem = this.requestItems.find(item => item.item_id === newVal && item.item_category_id === this.stockItemData.item_category_id)
        this.allocatedQt = parseInt(askedItem.quantity) - parseInt(askedItem.paid_quantity)
        const itemsWare = this.wareItems.filter(item => item.item_id === newVal)
        itemsWare.forEach(item => {
          const contrSt = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(it => it.value === item.contract_no_id)
          if (contrSt !== undefined) {
            this.contratcList.push(contrSt)
          }
        })
      }
    },
    'stockItemData.contract_no_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        const contract = this.wareItems.find(item => (item.contract_no_id === newVal && item.item_category_id === this.stockItemData.item_category_id) && item.item_id === this.stockItemData.item_id)
        this.availableQt = contract.available_quantity
      }
    },
    'stockItemData.quantity': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        const itemSt = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(it => it.value === this.stockItemData.item_id)
        if (itemSt !== undefined) {
          const mod = newVal % itemSt.unit_actual_value
         if (mod > 0) {
           this.perm = true
           this.err_msg = this.$i18n.locale === 'bn' ? '* পরিমাণ অবশ্যই ' + this.$n(itemSt.unit_actual_value) + ' এর গুণিতক হতে হবে' : '* The amount must be a multiple of ' + itemSt.unit_actual_value
         } else {
           this.perm = false
           this.err_msg = ''
         }
        }
      }
    }
  },
  methods: {
    getItemCategory (catId) {
      const contrSt = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(it => it.value === catId)
      if (contrSt !== undefined) {
        this.categoryList.push(contrSt)
      }
    },
    async addItem () {
      if (this.formData.details.length > 0) {
        const extItem = this.formData.details.find(eItm => eItm.item_id === this.stockItemData.item_id)
        if (extItem === undefined) {
          if (this.availableQt < this.stockItemData.quantity) {
            this.qtExced = true
            this.$toast.error({
              title: 'Error',
              message: "You Don't have available item.Change Contract No.",
              color: '#D6E09B'
            })
          } else {
            this.qtExced = false
            const objData = this.stockItemData
            this.formData.details.push(objData)
          }
        } else if (extItem.contract_no_id === this.stockItemData.contract_no_id) {
          if (this.availableQt < this.stockItemData.quantity) {
            this.qtExced = true
            this.$toast.error({
              title: 'Error',
              message: "You Don't have available item.Change Contract No.",
              color: '#D6E09B'
            })
          } else {
            this.qtExced = false
            const nQ = parseInt(this.stockItemData.quantity) + parseInt(extItem.quantity)
            extItem.quantity = nQ
          }
        } else {
          if (this.availableQt < this.stockItemData.quantity) {
            this.qtExced = true
            this.$toast.error({
              title: 'Error',
              message: "You Don't have available item.Change Contract No.",
              color: '#D6E09B'
            })
          } else {
            this.qtExced = false
            const objData = this.stockItemData
            this.formData.details.push(objData)
          }
        }
      } else {
        if (this.availableQt < this.stockItemData.quantity) {
          this.qtExced = true
          this.$toast.error({
            title: 'Error',
            message: "You Don't have available item.Change Contract No.",
            color: '#D6E09B'
          })
        } else {
          this.qtExced = false
          const objData = this.stockItemData
          this.formData.details.push(objData)
        }
      }
      if (this.qtExced === false) {
        const wareItemAvl = this.wareItems.find(item => item.item_id === this.stockItemData.item_id && item.contract_no_id === this.stockItemData.contract_no_id)
        const newQt = parseInt(wareItemAvl.available_quantity) - parseInt(this.stockItemData.quantity)
        wareItemAvl.available_quantity = newQt
        const reqItemAvl = this.requestItems.find(item => item.item_id === this.stockItemData.item_id)
        const newReqQt = parseInt(reqItemAvl.paid_quantity) + parseInt(this.stockItemData.quantity)
        reqItemAvl.paid_quantity = newReqQt
        this.stockItemData = {
          tcb_distribution_id: this.item.id,
          item_id: 0,
          item_category_id: 0,
          contract_no_id: 0,
          quantity: 0
        }
        this.availableQt = 0
        this.allocatedQt = 0
        this.$refs.itemEntry.reset()
      }
    },
    getItemCategoryName (catId, contrId) {
      const cat = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
      const contr = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === contrId)
      const catName = cat.text + ' - ' + contr.text
      return catName
    },
    getItemName (catId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === catId)
      return item.text
    },
    async getWareItems () {
      const params = {
        warehouse_id: this.warehouse_id,
        item_id: this.itemList
      }
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, wareProducts, params).then(response => {
        if (response.data.length > 0) {
          this.wareItems = []
          response.data.forEach(item => {
            const itemDetails = {
              contract_no_id: item.contract_no_id,
              item_id: item.item_id,
              item_category_id: item.item_category_id,
              available_quantity: item.available_quantity
            }
            this.wareItems.push(itemDetails)
          })
        }
        this.loading = false
      })
    },
    remove (index) {
      const delItem = this.formData.details[index]
      const wareItemAvl = this.wareItems.find(item => item.item_id === delItem.item_id && item.contract_no_id === delItem.contract_no_id)
      const newQt = parseInt(wareItemAvl.available_quantity) + parseInt(delItem.quantity)
      wareItemAvl.available_quantity = newQt
      const reqItemAvl = this.requestItems.find(item => item.item_id === delItem.item_id)
      const newReqQt = parseInt(reqItemAvl.paid_quantity) - parseInt(delItem.quantity)
      reqItemAvl.paid_quantity = newReqQt
      this.formData.details.splice(index, 1)
    },
    cancelSubmit () {
      this.$bvModal.hide('modal-form')
    },
    async saveUpdate () {
      this.requestItems.forEach(item => {
        if (parseInt(item.quantity) !== parseInt(item.paid_quantity)) {
          this.allProvided = false
          this.$toast.error({
            title: 'Error',
            message: 'All items not given',
            color: '#D6E09B'
          })
        } else {
          this.allProvided = true
        }
      })
      if (this.allProvided === true) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        this.pageLoad = true
        this.itemLoad = true
        let result = null
        const loadingState = { loading: false, listReload: false }
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, `${distributionDistribute}`, this.formData)
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          this.pageLoad = true
          this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-form')
        } else {
          this.pageLoad = false
          this.$refs.form.setErrors(result.errors)
        }
        this.itemLoad = false
      }
    }
  }
}
</script>
