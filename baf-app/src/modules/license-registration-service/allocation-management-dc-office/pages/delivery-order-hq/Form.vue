<template>
 <div class="inner-section">
     <bread-cumb />
     <body-card>
       <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.delivery_order') }}  {{  listLoad ? $t('globalTrans.add') : $t('globalTrans.edit') }}</h4>
      </template>
          <b-container fluid>
              <b-row>
                <b-col sm="12" class="mt-3">
                  <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                    <b-overlay :show="loading">
                      <b-row>
                        <b-col>
                          <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                            <b-row>
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Fiscal Year" vid="fiscal_year" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="fiscal_year"
                                    slot-scope="{ valid, errors }"
                                  >
                                    <template v-slot:label>
                                      {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                      plain
                                      v-model="formData.fiscal_year_id"
                                      :options="fiscalYearList"
                                      id="fiscal_year"
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
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Allotment Installment" vid="allotment_count_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="allotment_count_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                    <template v-slot:label>
                                      {{$t('allocation_management.allotment_count')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                      plain
                                      v-model="formData.allotment_count_id"
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
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Allotment Date" vid="allotment_date" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="allotment_date">
                                    <template v-slot:label>
                                      {{ $t('allocation_dc_office.allotment_date') }} <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                      id="allotment_date"
                                      v-model="formData.allotment_date"
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
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Delivery Order No" vid="delivery_order_no" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="delivery_order_no">
                                    <template v-slot:label>
                                      {{ $t('allocation_dc_office.delivery_order_no') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="dispatch_no"
                                      v-model="formData.delivery_order_no"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                              <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                <ValidationProvider name="Regional Office" vid="regional_office_id" rules="required|min_value:1">
                                  <b-form-group
                                    label-for="regional_office_id"
                                    slot-scope="{ valid, errors }"
                                  >
                                    <template v-slot:label>
                                      {{$t('allocation_management.regional_office')}} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-select
                                      plain
                                      v-model="formData.regional_office_id"
                                      :options="regionalOfficeList"
                                      id="regional_office_id"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    >
                                      <template v-slot:first>
                                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                                      </template>
                                    </b-form-select>
                                    <div class="invalid-feedback">
                                      {{ errors[0] }}
                                    </div>
                                  </b-form-group>
                                </ValidationProvider>
                              </b-col>
                            </b-row>
                            <!-- =============End Main========= -->
                            <template>
                              <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                                <h5 class="text-white text-left">
                                  {{ $t('allocation_dc_office.delivery_order') }} {{ $t('globalTrans.details') }}
                                </h5>
                              </div>
                            </template>
                            <hr>
                            <div class="table-wrapper table-responsive">
                              <b-overlay :show="loader">
                                <table class="table table-striped table-hover table-bordered">
                                  <thead class="small">
                                  <tr class="bg-primary">
                                    <th rowspan="2" scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                    <th rowspan="2" scope="col" class="text-center"><div>{{ $t('globalTrans.district') }}</div></th>
                                    <th rowspan="2" scope="col" class="text-center"><div>{{ $t('allocation_dc_office.beneficiary_no') }}</div></th>
                                    <template v-if="deliveryOrderItems.headerData">
                                      <th scope="col" colspan="2" class="text-center"  v-for="(item, index) in deliveryOrderItems.headerData" :key="index">
                                        <div>{{ currentLocale === 'en'? item.text_en : item.text_bn }} ({{$t('allocation_dc_office.unit')}})</div>
                                      </th>
                                    </template>
                                    <th rowspan="2" scope="col" class="text-center"><div>{{$t('globalTrans.action')}}</div></th>
                                  </tr>
                                  <tr class="bg-primary">
                                    <template v-if="deliveryOrderItems.childHeaderData">
                                      <th class="text-center"  v-for="(item, index) in deliveryOrderItems.childHeaderData" :key="index">
                                        {{item.delivery_qty_en ? currentLocale === 'en'? item.delivery_qty_en : item.delivery_qty_bn : currentLocale === 'en'? item.allocated_qty_en : item.allocated_qty_bn }}
                                      </th>
                                    </template>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  <template v-if="Object.keys(deliveryOrderItems).length > 0">
                                    <tr v-for="(item, index) in deliveryOrderItems.tableData" :key="index">
                                      <td  class="text-center">{{ $n(index+1) }}</td>
                                      <td class="text-center">{{ currentLocale === 'en'? item.district_name_en : item.district_name_bn }}</td>
                                      <td class="text-center">{{ item.is_other ? currentLocale === 'en'? 'N/A' : 'প্রযোজ্য নয়' : $n(item.no_of_benificiary) }}</td>
                                      <template v-if="item.child">
                                        <td  class="text-center"  v-for="(item2, index2) in item.child" :key="index2">
                                          <div v-if="item2.allocated_qty >= 0">
                                            {{$n(item2.allocated_qty)}}
                                          </div>
                                          <div v-else>
                                            <ValidationProvider name="Delivery Qty" :vid="`delivery_${index}`" :rules="`required|min_value:0|max_value:`+item.child[index2-1].allocated_qty" v-slot="{ errors }">
                                              <b-form-group
                                                :label-for="`delivery_${index}`">
                                                <b-form-input
                                                  :id="`delivery_${index}`"
                                                  v-model="item2.delivery_qty"
                                                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                  :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                  {{ errors[0] }}
                                                </div>
                                              </b-form-group>
                                            </ValidationProvider>
                                          </div>
                                        </td>
                                      </template>
                                      <td>
                                        <button @click="removeOther(item, index)" v-if="item.is_other" class="btn btn-sm" title="remove"><b-icon icon="x-circle" scale="1" variant="danger"></b-icon></button>
                                      </td>
                                    </tr>
                                  </template>
                                  <template v-else>
                                    <tr>
                                      <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                    </tr>
                                  </template>
                                  </tbody>
                                 <!-- <tfoot v-if="Object.keys(deliveryOrderItems).length > 0">-->
                                  <tfoot>
                                  <tr>
                                    <th :colspan="colSpanCount(deliveryOrderItems.tableData)" class="text-right"><div><button @click="openOtherDist()" type="button" class="btn btn-sm btn-primary">{{$t('allocation_dc_office.other_district')}}</button></div></th>
                                  </tr>
                                  </tfoot>
                                </table>
                              </b-overlay>
                            </div>
                            <b-row>
                              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider name="Remarks" vid="remarks">
                                  <b-form-group
                                    class="row"
                                    label-for="remarks"
                                    slot-scope="{ valid, errors }">
                                    <template v-slot:label>
                                      {{ $t('globalTrans.remarks') }}
                                    </template>
                                    <b-form-textarea
                                      rows="5"
                                      id="remarks"
                                      v-model="formData.remarks"
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
                        </b-col>
                      </b-row>
                   </b-overlay>
                  </ValidationObserver>
                    <br>
                  <b-row class="text-right mb-3">
                    <b-col>
                      <b-button type="submit" variant="warning" @click="saveData(1)" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
                      <b-button type="submit" variant="success" @click="confirmSave" class="mr-2 btn-sm">{{ $t('globalTrans.finalSave') }}</b-button>
                      <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                  </b-row>
            </b-col>
              </b-row>
          </b-container>
     </body-card>
     <b-modal :no-close-on-backdrop="true" id="modal-other-form" size="lg" :title="$t('allocation_dc_office.other_district')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <OtherForm :formDatas="formData" @others="otherData" :deliveryOrderItems="deliveryOrderItems" :otherDistrictList="otherDistrictList" :key="editItemId"/>
   </b-modal>
  </div>
</template>
<script>
  import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
  import ModalBaseMasterList from '@/mixins/list'
  import { deliveryOrderStore, deliveryOrderUpdate, districtWithItem } from '../../api/routes'
  import BreadCumb from '../../../../../components/BreadCumb.vue'
  import OtherForm from './OtherForm'

  export default {
  name: 'Form',
  props: ['items'],
  mixins: [ModalBaseMasterList],
  components: { BreadCumb, OtherForm },
  data () {
    return {
      valid: null,
      saveBtnName: '',
      errors: [],
      formData: {
        fiscal_year_id: 0,
        allotment_count_id: 0,
        allotment_date: null,
        regional_office_id: 0,
        remarks: '',
        is_draft: false,
        deliveryOrderItems: []
      },
      loader: false,
      deliveryOrderItems: [],
      showDistrict: false,
      itemList: [],
      listLoad: true,
      otherDistrictList: [],
      otherDistrictListEdit: [],
      id: null
    }
  },
  created () {
    this.saveBtnName = this.$route.params.item ? this.$t('globalTrans.update') : this.$t('globalTrans.save')
    if (this.$route.params.item) {
      const items = this.$route.params.item
      this.id = items.id
      this.formData.fiscal_year_id = items.fiscal_year_id
      this.formData.allotment_count_id = items.allotment_count_id
      this.formData.allotment_date = items.allotment_date
      this.formData.delivery_order_no = items.delivery_order_no
      this.formData.regional_office_id = items.regional_office_id
      this.formData.remarks = items.remarks
      this.formData.is_draft = items.is_draft
      this.listLoad = false
      this.dataFormatterEdit(items.details)
    } else {
      if (new URL(window.location.href).pathname.split('/')[4] === 'edit') {
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/delivery-order-hq' })
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
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
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList
    },
    regionalOfficeList: function () {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    districtList () {
        const objectData = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1)
        return objectData.map((obj, key) => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.value, text: obj.text_bn, text_bn: obj.text_bn, text_en: obj.text_en, no_of_beneficiary: 0 }
            } else {
                return { value: obj.value, text: obj.text_en, text_bn: obj.text_bn, text_en: obj.text_en, no_of_beneficiary: 0 }
            }
        })
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === this.allotmentOrderData.item_category_id)
        }
    },
    'formData.fiscal_year_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          if (this.formData.fiscal_year_id > 0 && this.formData.allotment_count_id > 0 && this.formData.regional_office_id > 0) {
            this.loader = true
            this.getItems()
          }
        }
    },
    'formData.allotment_count_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (this.formData.fiscal_year_id > 0 && this.formData.allotment_count_id > 0 && this.formData.regional_office_id > 0) {
          this.loader = true
          this.getItems()
        }
      }
    },
    'formData.regional_office_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          if (this.formData.fiscal_year_id > 0 && this.formData.allotment_count_id > 0 && this.formData.regional_office_id > 0) {
            this.loader = true
            this.getItems()
          }
        }
    }
  },
  methods: {
    colSpanCount (data) {
      if (data) {
        return 4 + data[0].child.length
      } else {
        return 4
      }
    },
    getItems () {
      const data = {
        fiscal_year_id: this.formData.fiscal_year_id,
        allotment_count_id: this.formData.allotment_count_id,
        regional_office_id: this.formData.regional_office_id
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, districtWithItem, data)
        .then((response) => {
          this.loader = false
          if (response.success) {
            if (this.listLoad) {
              if (response.data.length > 0) {
                this.dataFormatter(response.data)
              } else {
                this.$toast.info({
                  title: 'Info',
                  message: 'No allotment is found for this information',
                  color: '#7fbbd2'
                })
                this.deliveryOrderItems = []
              }
              this.otherDistrictList = response.other_district_id
            } else {
              this.otherDistrictList = response.other_district_id.filter((el) => !this.otherDistrictListEdit.includes(el))
            }
          } else {
            this.$toast.info({
              title: 'Info',
              message: response.message,
              color: '#7fbbd2'
            })
            this.deliveryOrderItems = []
          }
      })
    },
    dataFormatter (data) {
      const headerData = []
      const childHeaderData = []
      const tableData = []
      data.forEach((element, index) => {
        if (index === 0) {
          element.details.forEach((element2, index2) => {
            headerData.push({
              text: this.getItemCategoryName(element2.item_category_id),
              text_en: this.getItemCategoryName(element2.item_category_id, 'en'),
              text_bn: this.getItemCategoryName(element2.item_category_id, 'bn'),
              id: element2.item_category_id
            })
            childHeaderData.push({
              allocated_qty_en: 'Allocated Qty',
              allocated_qty_bn: 'বরাদ্দকৃত পরিমাণ'
            })
            childHeaderData.push({
              delivery_qty_en: 'Delivery Qty',
              delivery_qty_bn: 'ডেলিভারির পরিমাণ'
            })
          })
        }
        const child = []
        element.details.forEach((element2, index2) => {
          child.push({
            allocated_qty: element2.is_del ? element2.allocated_qty : element2.beneficiary_per_qt * element.total_beneficiary,
            item: element2.item_category_id
          })
          child.push({
            delivery_qty: 0,
            item: element2.item_category_id
          })
        })
        tableData.push({
          district_name_en: this.getDistrictName(element.district_id, 'en'),
          district_name_bn: this.getDistrictName(element.district_id, 'bn'),
          district_id: element.district_id,
          is_other: false,
          no_of_benificiary: element.total_beneficiary,
          child: child
        })
      })
      this.deliveryOrderItems = {
        headerData: headerData,
        childHeaderData: childHeaderData,
        tableData: tableData
      }
    },
    dataFormatterEdit (data) {
      const headerData = []
      const childHeaderData = []
      const tableData = []
      data.forEach((element, index) => {
        if (index === 0) {
          element.items.forEach((element2, index2) => {
            headerData.push({
              text: this.getItemCategoryName(element2.item_category_id),
              text_en: this.getItemCategoryName(element2.item_category_id, 'en'),
              text_bn: this.getItemCategoryName(element2.item_category_id, 'bn'),
              id: element2.item_category_id
            })
            childHeaderData.push({
              allocated_qty_en: 'Allocated Qty',
              allocated_qty_bn: 'বরাদ্দকৃত পরিমাণ'
            })
            childHeaderData.push({
              delivery_qty_en: 'Delivery Qty',
              delivery_qty_bn: 'ডেলিভারির পরিমাণ'
            })
          })
        }
        const child = []
        element.items.forEach((element2, index2) => {
          child.push({
            allocated_qty: element2.allocated_qty,
            id: element2.id,
            item: element2.item_category_id
          })
          child.push({
            delivery_qty: element2.delivered_qty,
            id: element2.id,
            item: element2.item_category_id
          })
        })
        tableData.push({
          district_name_en: this.getDistrictName(element.district_id, 'en'),
          district_name_bn: this.getDistrictName(element.district_id, 'bn'),
          district_id: element.district_id,
          is_other: element.is_other_district,
          id: element.id,
          no_of_benificiary: element.total_beneficiary,
          child: child
        })
        if (element.is_other_district) {
          this.otherDistrictListEdit.push(element.district_id)
        }
      })
      this.deliveryOrderItems = {
        headerData: headerData,
        childHeaderData: childHeaderData,
        tableData: tableData
      }
    },
    cancel () {
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/delivery-order-hq' })
    },
    showDistrictData () {
      this.showDistrict = true
    },
    confirmSave () {
      this.$swal({
        title: this.$t('globalTrans.final_save_msg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.saveData(2)
        }
      })
    },
    async saveData (type = 2) {
      if (type === 1) {
        this.formData.is_draft = true
      } else {
        this.formData.is_draft = false
      }
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && Object.keys(this.deliveryOrderItems).length > 0) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.formData.deliveryOrderItems = this.deliveryOrderItems.tableData
      if (!this.listLoad) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${deliveryOrderUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, deliveryOrderStore, this.formData)
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
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/delivery-order-hq' })
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    isEven (value) {
      return value % 2 === 0
    },
    getDistrictName (itemCategoryId, lang = this.$i18n.locale) {
      const cateObj = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
      if (cateObj !== undefined) {
          if (lang === 'bn') {
              return cateObj.text_bn
          } else {
              return cateObj.text_en
          }
      }
    },
    getItemName (itemCategoryId, lang = this.$i18n.locale) {
      const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
      if (cateObj !== undefined) {
        if (lang === 'bn') {
          return cateObj.text_bn
        } else {
          return cateObj.text_en
        }
      }
    },
    getItemCategoryName (itemCategoryId, lang = this.$i18n.locale) {
      const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
      if (cateObj !== undefined) {
        if (lang === 'bn') {
          return cateObj.text_bn
        } else {
          return cateObj.text_en
        }
      }
    },
  otherData (data) {
      const s = []
      this.otherDistrictList.map((item, index) => {
           if (item !== data.district_id) {
             s.push(item)
           }
        })
      this.otherDistrictList = s
      this.deliveryOrderItems.tableData.push(data)
    },
    removeOther (item, index) {
      this.otherDistrictList.push(item.district_id)
      this.deliveryOrderItems.tableData.splice(index, 1)
    },
    async openOtherDist () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
        this.$root.$emit('bv::show::modal', 'modal-other-form')
      }
    }
  }
}
</script>
