<template>
  <div class="inner-section">
    <b-overlay :show="pageLoad">
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-overlay :show="loading">
          <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <b-row>
              <b-col xs="12" sm="12" md="4" class="marginTop">
                <ValidationProvider name="Dealer Name" vid="dealer_name" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="heading">
                    <template v-slot:label>
                      {{ $t('dealer.dealer_name') }}
                    </template>
                    <b-form-input
                      id="item_name_en"
                      v-model="form.dealer_name"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="true"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4"  class="marginTop">
                <ValidationProvider name="Company Name" vid="company_name" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="company_name">
                    <template v-slot:label>
                      {{ $t('dealer.company_name') }}
                    </template>
                    <b-form-input
                      id="company_name"
                      v-model="form.company_name"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="true"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4"  class= "marginTop">
                <ValidationProvider name="Agreement No" vid="agreement_no" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="agreement_no">
                    <template v-slot:label>
                      {{ $t('tcb_report.agreement_no') }}
                    </template>
                    <b-form-input
                      id="agreement_no"
                      v-model="form.agreement_no"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="true"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Expire Date" vid="expire_date" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="expire_date">
                    <template v-slot:label>
                      {{ $t('externalLrcpn.expire_date') }}
                    </template>
                    <b-form-input
                      id="expire_date"
                      v-model="form.expire_date"
                      :state="errors[0] ? false : (valid ? true : null)"
                      :disabled="true"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Letter Date" vid="letter_date" v-slot="{ errors }" rules="required">
                  <b-form-group
                    label-for="letter_date">
                    <template v-slot:label>
                      {{ $t('allocation_management.letter_date') }}  <span class="text-danger">*</span>
                    </template>
                    <date-picker
                      id="letter_date"
                      class="form-control"
                      :placeholder="$t('globalTrans.select_date')"
                      v-model="form.letter_date"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </date-picker>
                    <div class="d-block invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="4">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="fiscal_year_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="form.fiscal_year_id"
                    :options="fiscalYearList"
                    id="fiscal_year_id"
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
                <ValidationProvider name="Allotment Count" vid="allotment_count_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="allotment_count_id"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('allocation_management.allotment_count')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="form.allotment_count_id"
                      :options="allotmentCount"
                      id="allotment_count_id"
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
                <ValidationProvider name="Distance" vid="distence_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="distence_id"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('license_config.distance')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="form.distence_id"
                      :options="distanceList"
                      id="distence_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                      disabled
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
        <b-overlay :show="loadingQuantity">
          <b-form @submit.prevent="handleSubmit(allocationAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
            <b-row >
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Item Category" vid="item_category_id">
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
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Item" vid="item_id">
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
              <b-col xs="12" sm="12" md="6">
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
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Allocated Quantity" vid="allocation_quantity" :rules="`required|min_value:1`" v-slot="{ errors }">
                  <b-form-group
                    label-for="allocation_quantity">
                    <template v-slot:label>
                      {{ $t('allocation_management.allocated_quantity_hq') }}<span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      id="allocation_quantity"
                      v-model="allocationQty"
                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                      :state="errors[0] ? false : (valid ? true : null)"
                      readonly
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Quantity" vid="quantity" :rules="`required|min_value:1|max_value: ${allocationQty}`" v-slot="{ errors }">
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
                  <b-button :disabled="loading" type="submit" variant="success" class="mr-2 mb-2 btn-sm">
                      {{form.details.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
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
                        <th scope="col" class="text-center"><div>{{ $t('allocation_management.unit_price') }}</div></th>
                        <th scope="col" class="text-center"><div>{{ $t('tcb_report.total_price') }}</div></th>
                        <th scope="col" class="text-center"><div>{{ $t('license_config.operating_expense') }}</div></th>
                        <th scope="col" class="text-center"><div>{{ $t('allocation_management.selling_amount') }}</div></th>
                        <th scope="col" class="text-center"><div>{{ $t('globalTrans.tax') }}</div></th>
                        <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                      </tr>
                    </thead>
                    <tbody>
                      <template v-if="form.details.length > 0">
                          <tr v-for="(item, index) in form.details" :key="index">
                            <td class="text-center">{{ index+1 }}</td>
                            <td class="text-center">{{ getItemCategoryName(item.item_category_id) }}</td>
                            <td class="text-center">{{ getItemName(item.item_id) }}</td>
                            <td class="text-center">{{ $n(item.quantity) }}</td>
                            <td class="text-center">{{ $n(item.unit_price) }}</td>
                            <td class="text-center">{{ $n(item.total_price) }}</td>
                            <td class="text-center">{{ $n(item.expense) }}</td>
                            <td class="text-center">{{ $n(item.selling_amount) }}</td>
                            <td class="text-center">{{ $n(item.tax_amount) }}</td>
                            <td class="text-center">
                                <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" @click="remove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                            </td>
                          </tr>
                          <tr class="text-bold">
                            <td class="text-center" style="font-weight: bold;" colspan="5">{{ $t('globalTrans.total') }}</td>
                            <td class="text-center" style="font-weight: bold;">{{ getTotalPrice(form.details) }}</td>
                            <td class="text-center" style="font-weight: bold;">{{ getTotalExpense(form.details) }}</td>
                            <td class="text-center" style="font-weight: bold;">{{ getTotalSellingPrice(form.details) }}</td>
                            <td class="text-center" style="font-weight: bold;">{{ getTotalTaxPrice(form.details) }}</td>
                            <td></td>
                          </tr>
                          <tr>
                            <td class="text-center" style="font-weight: bold;" colspan="5"></td>
                            <td class="text-center" style="font-weight: bold;" colspan="2">{{ $t('allocation_management.payable_amount') }}</td>
                            <td class="text-center" style="font-weight: bold;" colspan="3"> {{ getPayableAmount() }}</td>
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
            <b-row>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Comment En" vid="comment_en" v-slot="{ errors }">
                  <b-form-group
                    label-for="comment_en">
                    <template v-slot:label>
                      {{ $t('globalTrans.comment_en') }}
                    </template>
                    <b-form-input
                      id="comment_en"
                      v-model="form.comment_en"
                      :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Comment Bn" vid="comment_bn" v-slot="{ errors }">
                  <b-form-group
                    label-for="comment_bn">
                    <template v-slot:label>
                      {{ $t('globalTrans.comment_bn') }}
                    </template>
                    <b-form-input
                      id="comment_bn"
                      v-model="form.comment_bn"
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
                  <b-button type="submit" variant="success" @click="saveUpdate" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                  <b-button variant="danger" class="btn-sm" @click="cancelSubmit">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </b-overlay>
      </ValidationObserver>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allocationProcessStore, allotmentOrderhqList, stockSearch, ItemCatWiseallocatedQty } from '../../api/routes'
export default {
  name: 'Form',
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      itemList: [],
      form: {
        tcb_applicant_id: 0,
        letter_date: '',
        fiscal_year_id: 0,
        allotment_count_id: 0,
        total_price: 0,
        distence_id: 0,
        operating_expense: 0,
        selling_amount: 0,
        tax_amount: 0,
        comment_en: '',
        comment_bn: '',
        details: []
      },
      stockItemData: {
        item_id: 0,
        item_category_id: 0,
        quantity: 0,
        unit_price: 0,
        total_price: 0,
        expense: 0,
        selling_amount: 0,
        tax_amount: 0,
        office_id: ''
      },
      op_exp: 0,
      tax_per: 0,
      loading: false,
      loadingQuantity: false,
      allotmentItem: [],
      itemCategoryList: [],
      availableQt: 0,
      allocationQty: 0,
      pageLoad: false,
      office_id: 0
    }
  },
  created () {
    if (this.$route.params.id) {
      const tmp = this.getItemEntry(this.$route.params.id)
      this.form.dealer_name = this.$i18n.locale === 'bn' ? tmp.dealer_name_bn : tmp.dealer_name_en
      this.form.company_name = this.$i18n.locale === 'bn' ? tmp.company_name_bn : tmp.company_name_en
      this.form.agreement_date = tmp.agreement_date
      this.form.agreement_no = tmp.agreement_no
      this.form.expire_date = tmp.expire_date
      this.form.distence_id = tmp.distance_id
      this.form.tcb_applicant_id = tmp.id
      this.form.dealer_type = tmp.dealer_type
      this.getOpExp(tmp.distance_id)
      this.gettaxPer()
      // this.form.details = []
    }
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.office_id = this.$store.state.Auth.authUser.office_detail.office_id
      this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === parseInt(this.office_id))
      return this.warehouseList
    } else {
      this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      return this.warehouseList
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    allotmentCount () {
      return this.$store.state.commonObj.gradeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text }
        }
      })
    },
    distanceList () {
      return this.$store.state.LicenseRegistrationService.commonObj.distanceList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList
    },
    auth () {
      return this.$store.state.Auth
    }
  },
  watch: {
    'stockItemData.item_category_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        this.availableQt = 0
        this.allocationQty = 0
        const alItem = this.allotmentItem.find(item => item.item_category_id === newVal)
        this.stockItemData.unit_price = alItem.selling_amount
        this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(product => product.item_category_id === newVal)
      }
    },
    'stockItemData.item_id': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== 0) {
        const warehouses = []
        if (this.warehouseList.length > 0) {
          this.warehouseList.forEach(item => {
            warehouses.push(item.value)
          })
        }
        const searcItem = {
          item_id: newVal,
          office_id: this.office_id,
          warehouse: warehouses
        }
        this.loadingQuantity = true
        this.allocatedItemCatWiseQuantity()
        RestApi.getData(licenseRegistrationServiceBaseUrl, stockSearch, searcItem).then(response => {
          this.availableQt = response.data
          this.loadingQuantity = false
        })
      }
    },
    'stockItemData.quantity': function (newVal, oldVal) {
      if (newVal !== oldVal && newVal !== '') {
        this.stockItemData.total_price = this.stockItemData.unit_price * newVal
        const opExp = this.op_exp
        this.stockItemData.expense = opExp * newVal
        this.stockItemData.selling_amount = this.stockItemData.total_price - this.stockItemData.expense
        this.stockItemData.tax_amount = (this.stockItemData.expense * this.tax_per) / 100
      }
    },
    'form.allotment_count_id': function (newVal, oldVal) {
      if (newVal !== oldVal && typeof (newVal) !== 'undefined') {
        this.getAlloedItems(newVal)
      }
    },
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.itemCategoryList = []
          this.allotmentItem.forEach(item => {
            const itemCategory = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(cat => cat.value === item.item_category_id)
            const catFind = this.itemCategoryList.find(item => item.value === itemCategory.value)
            if (catFind === undefined) {
              this.itemCategoryList.push(itemCategory)
            }
          })
        }
    }
  },
  methods: {
    async allocationAddItem () {
      if (this.form.details.length > 0) {
        const extItem = this.form.details.find(eItm => eItm.item_id === this.stockItemData.item_id)
        if (extItem === undefined) {
          const objData = this.stockItemData
          this.form.details.push(objData)
        } else {
          this.$toast.error({
            title: 'Error',
            message: this.$t('allocation_management.product_existed'),
            color: '#D6E09B'
          })
        }
      } else {
        const objData = this.stockItemData
        this.form.details.push(objData)
      }
      this.stockItemData = {
        item_id: 0,
        item_category_id: 0,
        quantity: 0,
        unit_price: 0,
        total_price: 0,
        expense: 0,
        selling_amount: 0,
        tax_amount: 0
      }
      this.availableQt = 0
      this.allocationQty = 0
      this.$refs.itemEntry.reset()
    },
    async getAlloedItems (allotmentId) {
      const searcItem = {
        fiscal_year_id: this.form.fiscal_year_id,
        allotment_count: this.form.allotment_count_id
      }
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, allotmentOrderhqList, searcItem).then(response => {
        if (response.data.data.length > 0) {
          this.itemCategoryList = []
          const details = response.data.data[0].details
          this.allotmentItem = details
          details.forEach(item => {
            const itemCategory = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(cat => cat.value === item.item_category_id)
            const catFind = this.itemCategoryList.find(item => item.value === itemCategory.value)
            if (catFind === undefined) {
              this.itemCategoryList.push(itemCategory)
            }
          })
        }
        this.loading = false
      })
    },
    gettaxPer () {
      const dateToday = new Date().toLocaleDateString('fr-CA')
      const taxList = this.$store.state.LicenseRegistrationService.commonObj.taxOperatingExpensesList.filter(item => item.status === 1 && dateToday >= item.effective_date)
      const activeTax = taxList.reduce((a, b) => {
        return new Date(a.effective_date) > new Date(b.effective_date) ? a : b
      })
      this.tax_per = activeTax.tax_value
    },
    getOpExp (distanceId) {
      const expList = this.$store.state.LicenseRegistrationService.commonObj.operatingExpensesList.filter(item => item.distance === distanceId && (item.seller_type === this.form.dealer_type && item.status === 1))
      const activeExp = expList.reduce((a, b) => {
        return new Date(a.effective_date) > new Date(b.effective_date) ? a : b
      })
      this.op_exp = activeExp.expense_amount
    },
    getTotalPrice (items) {
      let productPrice = 0
      items.forEach(item => {
        productPrice = productPrice + item.total_price
      })
      this.form.total_price = productPrice
      return this.$n(productPrice)
    },
    getTotalExpense (items) {
      let expense = 0
      items.forEach(item => {
        expense = expense + item.expense
      })
      this.form.operating_expense = expense
      return this.$n(expense)
    },
    getTotalSellingPrice (items) {
      let sellingAmount = 0
      items.forEach(item => {
        sellingAmount = sellingAmount + item.selling_amount
      })
      this.form.selling_amount = sellingAmount
      return this.$n(sellingAmount)
    },
    getTotalTaxPrice (items) {
      let taxAmount = 0
      items.forEach(item => {
        taxAmount = taxAmount + item.tax_amount
      })
      this.form.tax_amount = taxAmount
      return this.$n(taxAmount)
    },
    getPayableAmount () {
      const payAmunt = this.form.selling_amount + this.form.tax_amount
      return this.$n(payAmunt)
    },
    cancelSubmit () {
      this.$router.go(-1)
    },
    remove (index) {
      this.form.details.splice(index, 1)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      this.pageLoad = true
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, `${allocationProcessStore}`, this.form)
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
        this.$router.go(-1)
      } else {
        this.pageLoad = false
        this.$refs.form.setErrors(result.errors)
      }
    },
    getItemCategoryName (catId) {
      const cat = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
      return cat.text
    },
    getItemName (catId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === catId)
      return item.text
    },
    getItemEntry (itemId) {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
      return JSON.parse(JSON.stringify(tmpData))
    },
    async allocatedItemCatWiseQuantity () {
      const searchParams = {
        fiscal_year_id: this.form.fiscal_year_id,
        allotment_count_id: this.form.allotment_count_id,
        item_category_id: this.stockItemData.item_category_id
      }
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, ItemCatWiseallocatedQty, searchParams)
        if (result.success) {
          this.allocationQty = result.data.allocation_quantity
        } else {
          this.allocationQty = ''
        }
      }
  }
}
</script>
<style scoped>
  .marginTop{
    margin-top:20px;
  }
</style>
