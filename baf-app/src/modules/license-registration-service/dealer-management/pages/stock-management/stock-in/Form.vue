
<template>
<b-container fluid>
    <b-row>
      <b-col sm="12">
        <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                <b-row>
                    <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Contract No" vid="contract_no_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="contract_no_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.contract_no')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.contract_no_id"
                        :options="contractNumberList"
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
                    <ValidationProvider name="Warehouse" vid="warehouse_id" rules="required|min_value:1">
                      <b-form-group
                        label-for="warehouse_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('stock_management.warehouse')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.warehouse_id"
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
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Stock In Date" vid="stock_in_date" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="stock_in_date">
                        <template v-slot:label>
                          {{ $t('stock_management.stock_in_date') }} <span class="text-danger">*</span>
                        </template>
                        <date-picker
                          id="stock_in_date"
                          v-model="formData.stock_in_date"
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
              </b-form>
            </b-overlay>
          </ValidationObserver>
                <!-- =============End Main========= -->
          <hr>
           <template>
                <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h5 class="text-white text-left">
                        {{ $t('stock_management.stock_in') }}  {{ $t('stock_management.item') }} {{ $t('globalTrans.details') }}
                    </h5>
                </div>
            </template>
            <br/>
          <!-- =================Add More Start===================== -->
          <ValidationObserver ref="stockInForm" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(stockinAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                <b-row>
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
                  <b-col xs="6" sm="6" md="6">
                    <ValidationProvider name="Quantity" vid="quantity" rules="required|min_value:1" v-slot="{ errors }">
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
            <ValidationObserver ref="detailLoopForm" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(detailLoopFormData)" @reset.prevent="reset">
                <div class="table-wrapper table-responsive">
                  <table class="table table-striped table-hover table-bordered">
                        <thead>
                            <tr class="bg-primary">
                                <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                                <th scope="col" style="width: 15%;" class="text-center"><div>{{ $t('stock_management.quantity') }}</div></th>
                                <th scope="col" class="text-center"><div>{{ $t('globalTrans.action') }}</div></th>
                            </tr>
                        </thead>
                        <tbody>
                            <template v-if="arrStockItemData && arrStockItemData.length > 0">
                                <tr v-for="(item, index) in arrStockItemData" :key="index">
                                    <td  class="text-center">{{ index+1 }}</td>
                                    <td class="text-center">{{ $i18n.locale === 'bn' ? item.item_category_name_bn : item.item_category_name_en }}</td>
                                    <td class="text-center">{{ $i18n.locale === 'bn' ? item.item_name_bn : item.item_name_en }}</td>
                                    <td class="text-center">
                                      <ValidationProvider name="Quantity" :vid="`quantity${index}`" rules="required|min_value:1">
                                        <b-form-group
                                          slot-scope="{ valid, errors }"
                                        >
                                          <b-form-input
                                            id="`quantity${index}`"
                                            type="number"
                                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                            v-model.number="item.quantity"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-input>
                                          <div class="invalid-feedback">
                                            {{ errors[0] }}
                                          </div>
                                        </b-form-group>
                                      </ValidationProvider>
                                    </td>
                                    <td class="text-center">
                                        <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="stockItemRemove(index)" class="action-btn delete"><i class="ri-delete-bin-2-line"></i></b-button>
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
              </b-form>
            </b-overlay>
          </ValidationObserver>
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
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stockInStore, stockInUpdate } from '../../../api/routes'
// import userTypeModule from '@/utils/userType'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        fiscal_year_id: 0,
        contract_no_id: 0,
        warehouse_id: 0,
        stock_in_date: '',
        office_id: '',
        stockItemDataArr: []
      },
      stockItemData: {
        item_category_id: 0,
        item_category_name_en: '',
        item_category_name_bn: '',
        item_id: 0,
        item_name_en: '',
        item_name_bn: '',
        quantity: 0
      },
      arrStockItemData: [],
      itemList: [],
      warehouseList: [],
      contractNumberList: []
    }
  },
  created () {
    this.getCurrentFiscalYear()
    this.getContractAbailable()
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
    }
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.formData.office_id = this.$store.state.Auth.authUser.office_detail.office_id
      this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === parseInt(this.formData.office_id))
      return this.warehouseList
    } else {
      this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      return this.warehouseList
    }
    // this.checkGetWarehosueUserList()
  },
  computed: {
    auth () {
      return this.$store.state.Auth
    },
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
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
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === this.stockItemData.item_category_id)
        }
    }
  },
  methods: {
    getContractAbailable () {
      const contractList = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.filter(item => item.status === 1)
      this.contractNumberList = contractList.map(item => {
        if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.contract_no + '(' + item.text_bn + ')' }
        } else {
            return { value: item.value, text: item.contract_no + '(' + item.text + ')' }
        }
      })
    },
    // ================Edu Info Start=================
        async stockinAddItem () {
               const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(quaItem => quaItem.value === this.stockItemData.item_category_id)
               const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(sinItem => sinItem.value === this.stockItemData.item_id)
               var obj = {
                    item_category_id: this.stockItemData.item_category_id,
                    item_category_name_en: cateObj !== undefined ? cateObj.text_en : '',
                    item_category_name_bn: cateObj !== undefined ? cateObj.text_bn : '',
                    item_id: this.stockItemData.item_id,
                    item_name_en: itemObj !== undefined ? itemObj.text_en : '',
                    item_name_bn: itemObj !== undefined ? itemObj.text_bn : '',
                    quantity: parseFloat(this.stockItemData.quantity)
                }
                      if (this.stockItemData.key === undefined) {
                        const extItem = this.formData.stockItemDataArr.find(eItm => eItm.item_id === this.stockItemData.item_id)
                        if (extItem === undefined) {
                          this.formData.stockItemDataArr.push(obj)
                        } else {
                          extItem.quantity += parseFloat(this.stockItemData.quantity)
                        }
                      } else {
                          this.formData.stockItemDataArr[this.stockItemData.key].item_category_id = this.stockItemData.item_category_id
                          this.formData.stockItemDataArr[this.stockItemData.key].item_category_name_en = cateObj !== undefined ? cateObj.text_en : ''
                          this.formData.stockItemDataArr[this.stockItemData.key].item_category_name_bn = cateObj !== undefined ? cateObj.text_bn : ''
                          this.formData.stockItemDataArr[this.stockItemData.key].item_id = this.stockItemData.item_id
                          this.formData.stockItemDataArr[this.stockItemData.key].item_name_en = itemObj !== undefined ? itemObj.text_en : ''
                          this.formData.stockItemDataArr[this.stockItemData.key].item_name_bn = itemObj !== undefined ? itemObj.text_bn : ''
                          this.formData.stockItemDataArr[this.stockItemData.key].quantity = this.stockItemData.quantity
                      }
                      this.stockItemData = {
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
        getCurrentFiscalYear () {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList
          const currentDate = new Date()
          const [month, year] = [currentDate.getMonth() + 1, currentDate.getFullYear()]
          const yearPosition = month < 7 ? 5 : 0
          const yearStr = `${year}`
          fiscalYearList.forEach(element => {
            if (element.text_en.indexOf(yearStr) === yearPosition) {
              this.formData.fiscal_year_id = element.value
            }
          })
        },
        // ================Edu Info End===================
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      const isDetailsValid = await this.$refs.detailLoopForm.validate()
      this.formData.stockItemDataArr = this.arrStockItemData
      if (isValid && isDetailsValid && this.formData.stockItemDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${stockInUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stockInStore, this.formData)
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

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
    // checkGetWarehosueUserList () {
    //   const warehouseUser = this.$store.state.LicenseRegistrationService.commonObj.userWarehouseList.filter(item => item.user_id === parseInt(this.auth.authUser.user_id))
    //   if (userTypeModule.userType('is_office_user')) {
    //     if (warehouseUser.length) {
    //       const tmpWarehouses = []
    //       warehouseUser.forEach(itm => {
    //         const tmpWare = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === parseInt(itm.warehouse_id))
    //         tmpWarehouses.push(tmpWare)
    //       })
    //       this.warehouseList = tmpWarehouses
    //     } else {
    //       this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === parseInt(this.auth.authUser.office_id))
    //     }
    //   } else {
    //     this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
    //   }
    // }
  }
}
</script>
