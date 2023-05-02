<template>
 <div class="inner-section">
    <bread-cumb />
       <body-card>
       <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('allocation_management.allotment_order') }}  {{  id > 0 ? $t('globalTrans.edit') : $t('globalTrans.add') }}</h4>
      </template>
          <b-container fluid>
              <b-row>
                <b-col sm="12" class="mt-3">
                  <b-overlay :show="loading">
                  <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
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
                          <ValidationProvider name="Approval Dispatch No" vid="approval_dispatch_no" rules="required" v-slot="{ errors }">
                            <b-form-group
                              label-for="approval_dispatch_no">
                              <template v-slot:label>
                                {{ $t('allocation_management.approval_dispatch_no') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="approval_dispatch_no"
                                v-model="formData.approval_dispatch_no"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                          <ValidationProvider name="Allotment Order Duration" vid="allotment_duration" rules="required" v-slot="{ errors }">
                            <b-form-group
                              label-for="program_duration">
                              <template v-slot:label>
                                {{ $t('allocation_management.allotment_duration') }} <span class="text-danger">*</span>
                              </template>
                              <date-picker
                                id="allotment_duration"
                                v-model="formData.allotment_duration"
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
                          <ValidationProvider name="Approval Date" vid="approval_date" rules="required" v-slot="{ errors }">
                            <b-form-group
                              label-for="approval_date">
                              <template v-slot:label>
                                {{ $t('allocation_management.approval_date') }} <span class="text-danger">*</span>
                              </template>
                              <date-picker
                                id="approval_date"
                                v-model="formData.approval_date"
                                class="form-control"
                                :placeholder="$t('globalTrans.select')"
                              >
                              </date-picker>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                          <ValidationProvider name="Seller Type" vid="seller_type" rules="required|min_value:1">
                            <b-form-group
                              label-for="seller_type"
                              slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                              {{$t('allocation_management.seller_type')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                              plain
                              v-model="formData.seller_type"
                              :options="sellerTypeList"
                              id="seller_type"
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
                            <ValidationProvider name="Approval Letter Attachment" vid="attachment" rules="required">
                              <b-form-group
                                label-for="attachment"
                                slot-scope="{ valid, errors }"
                                >
                                <template v-slot:label>
                                  {{ $t('allocation_management.attachment') }}<span class="text-danger">*</span>
                                </template>
                              <b-form-file id="attachment"
                              v-model="formData.file"
                              v-on:change="onFileChange"
                              accept=".doc,.docx,.pdf"
                              class="mt-2" plain
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-file>
                                <div class="d-block invalid-feedback">
                                  {{ fileValidationMsz }}
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                        </b-col>
                      </b-row>
                    </b-form>
                  </ValidationObserver>
                   <!-- =============End Main========= -->
                    <template>
                      <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                        <h5 class="text-white text-left">
                          {{ $t('allocation_management.allotment_order') }} {{ $t('globalTrans.details') }}
                        </h5>
                      </div>
                    </template>
                      <hr>
                      <!-- =================Add More Start===================== -->
                    <ValidationObserver ref="allotmentEntryForm" v-slot="{ handleSubmit, reset }">
                        <b-form @submit.prevent="handleSubmit(allotmentOrderAddItem)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
                          <b-row>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
                                  v-model="allotmentOrderData.item_category_id"
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
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Selling Rate (Taka)" vid="selling_amount" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="selling_amount">
                                  <template v-slot:label>
                                    {{ $t('allocation_management.selling_amount') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="selling_amount"
                                    v-model="allotmentOrderData.selling_amount"
                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                    {{ errors[0] }}
                                  </div>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                              <ValidationProvider name="Beneficiary Per Quantity (kg/lt)" vid="beneficiary_per_qt" rules="required" v-slot="{ errors }">
                                <b-form-group
                                  label-for="beneficiary_per_qt">
                                  <template v-slot:label>
                                    {{ $t('allocation_dc_office.beneficiary_per_qt') }} ({{$t('allocation_management.kg_or_litter')}})<span class="text-danger">*</span>
                                  </template>
                                  <b-form-input
                                    id="beneficiary_per_qt"
                                    v-model.number="allotmentOrderData.beneficiary_per_qt"
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
                                    {{arrallotmentOrderData && arrallotmentOrderData.length > 0 ? $t('stock_management.add_more') : $t('globalTrans.add')}}
                                </b-button>
                            </b-col>
                          </b-row>
                        </b-form>
                    </ValidationObserver>
                    <br/>
                      <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                       <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('allocation_management.selling_amount') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('allocation_dc_office.beneficiary_per_qt') }} ({{$t('allocation_management.kg_or_litter')}})</div></th>
                                        <th style="width: 10%"><div>{{ $t('globalTrans.action') }}</div></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="arrallotmentOrderData && arrallotmentOrderData.length > 0">
                                        <tr v-for="(item, index) in arrallotmentOrderData" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td class="text-center">{{ $i18n.locale === 'bn' ? item.item_category_name_bn : item.item_category_name_en }}</td>
                                            <td style="width: 40%" class="text-center" >
                                                <ValidationProvider name="Selling Amount" :vid="`selling_amount${index}`" rules="required" v-slot="{ errors }">
                                                  <b-form-group
                                                    :label-for="`selling_amount${index}`">
                                                    <b-form-input
                                                      id="selling_amount"
                                                      v-model.number="item.selling_amount"
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
                                              <ValidationProvider name="Beneficiary Per Quantity" :vid="`beneficiary_per_qt${index}`" rules="required" v-slot="{ errors }">
                                                <b-form-group
                                                  :label-for="`beneficiary_per_qt${index}`">
                                                  <b-form-input
                                                    id="beneficiary_per_qt"
                                                    v-model.number="item.beneficiary_per_qt"
                                                    oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                    :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                    {{ errors[0] }}
                                                  </div>
                                                </b-form-group>
                                              </ValidationProvider>
                                            </td>
                                            <td class="text-center">
                                                <b-button v-if="!item.id" variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="allotmentOrderRemove(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
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
                    <!-- attachemnt  -->
                <b-row class="text-right mb-3">
                    <b-col>
                        <b-button :disabled="formData.AllotmentOrderDataArr.length <= 0" type="submit" variant="success" @click="publishStatus" class="mr-2 btn-sm">{{ this.$t('globalTrans.save') }}</b-button>
                        <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
                </b-overlay>
            </b-col>
              </b-row>
          </b-container>
     </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allotmentOrderministryStore, allotmentOrderministryUpdate } from '../../api/routes'
import BreadCumb from '../../../../../components/BreadCumb.vue'
import flatpickr from 'flatpickr'
export default {
  name: 'Form',
  props: ['id'],
  components: { BreadCumb },
  data () {
    return {
      valid: null,
      errors: [],
      formData: {
        fiscal_year_id: 0,
        seller_type: 0,
        allotment_count_id: 0,
        approval_date: '',
        approval_dispatch_no: '',
        allotment_duration: '',
        start_date: '',
        end_date: '',
        file: [],
        attachment: '',
        AllotmentOrderDataArr: []
      },
      allotmentOrderData: {
        item_category_id: 0,
        item_category_name_en: '',
        item_category_name_bn: '',
        selling_amount: '',
        beneficiary_per_qt: ''
      },
      arrallotmentOrderData: [],
      itemList: [],
      fileValidationMsz: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
    }
  },
  mounted () {
    flatpickr('#allotment_duration', {
      mode: 'range',
      minDate: 'today'
    })
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
    sellerTypeList () {
      const sellerTypeList = this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList
        return sellerTypeList.map(item => {
          return { value: item.value, text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en }
        })
    },
    warehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
    },
    itemCategoryList () {
      return this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1)
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.itemList = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1 && item.item_category_id === this.allotmentOrderData.item_category_id)
      }
    },
    'formData.allotment_duration': function (newVal, oldVal) {
      const dateArray = newVal.split('to')
      if (dateArray.length > 1) {
        this.formData.start_date = dateArray[0]
        this.formData.end_date = dateArray[1]
      } else {
        this.formData.start_date = dateArray[0]
        this.formData.end_date = dateArray[0]
      }
     }
  },
  methods: {
    // ================Edu Info Start=================
        async allotmentOrderAddItem () {
               const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(quaItem => quaItem.value === this.allotmentOrderData.item_category_id)
               var obj = {
                    item_category_id: this.allotmentOrderData.item_category_id,
                    item_category_name_en: cateObj !== undefined ? cateObj.text_en : '',
                    item_category_name_bn: cateObj !== undefined ? cateObj.text_bn : '',
                    selling_amount: parseFloat(this.allotmentOrderData.selling_amount),
                    beneficiary_per_qt: parseFloat(this.allotmentOrderData.beneficiary_per_qt)
                }
                  // this.loading = true
                      if (this.allotmentOrderData.key === undefined) {
                        const extItem = this.formData.AllotmentOrderDataArr.find(eItm => eItm.item_category_id === this.allotmentOrderData.item_category_id)
                        if (extItem === undefined) {
                          this.formData.AllotmentOrderDataArr.push(obj)
                        } else {
                          extItem.selling_amount += parseFloat(this.allotmentOrderData.selling_amount)
                          extItem.beneficiary_per_qt += parseFloat(this.allotmentOrderData.beneficiary_per_qt)
                        }
                      } else {
                          this.formData.AllotmentOrderDataArr[this.allotmentOrderData.key].item_category_id = this.allotmentOrderData.item_category_id
                          this.formData.AllotmentOrderDataArr[this.allotmentOrderData.key].item_category_name_en = cateObj !== undefined ? cateObj.text_en : ''
                          this.formData.AllotmentOrderDataArr[this.allotmentOrderData.key].item_category_name_bn = cateObj !== undefined ? cateObj.text_bn : ''
                          this.formData.AllotmentOrderDataArr[this.allotmentOrderData.key].selling_amount = this.allotmentOrderData.selling_amount
                          this.formData.AllotmentOrderDataArr[this.allotmentOrderData.key].beneficiary_per_qt = this.allotmentOrderData.beneficiary_per_qt
                      }
                      this.allotmentOrderData = {
                            item_category_id: 0,
                            item_category_name_en: '',
                            item_category_name_bn: '',
                            selling_amount: '',
                            beneficiary_per_qt: ''
                      }
                      this.arrallotmentOrderData = this.formData.AllotmentOrderDataArr
                      this.$refs.allotmentEntryForm.reset()
                      // this.loading = false
        },
        cancel () {
          this.$router.push({ path: '/license-registration-service/allocation-management/allotment-order-ministry' })
        },
        onFileChange (event) {
          this.fileValidationMsz = ''
          const input = event.target
          const file = input.files[0]
          if (file.size > 1024 * 5124) {
            event.preventDefault()
            this.fileValidationMsz = this.$t('allocation_management.file_status')
          }
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
        allotmentOrderRemove (key) {
            this.formData.AllotmentOrderDataArr.splice(key, 1)
        },
        // ================Edu Info End===================
     publishStatus () {
        window.vm.$swal({
            title: window.vm.$t('allocation_management.allotment_save_msg'),
            showCancelButton: true,
            confirmButtonText: window.vm.$t('globalTrans.yes'),
            cancelButtonText: window.vm.$t('globalTrans.no'),
            focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
             this.saveData()
            }
        })
    },
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.AllotmentOrderDataArr.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${allotmentOrderministryUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, allotmentOrderministryStore, this.formData)
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

        this.$router.push({ path: '/license-registration-service/allocation-management/allotment-order-ministry' })
      } else {
          if (result.errors) {
        }
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
