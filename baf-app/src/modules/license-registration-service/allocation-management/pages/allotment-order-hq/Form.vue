<template>
<b-container fluid>
    <b-row>
      <b-overlay :show="loading">
        <b-col sm="12">
          <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset">
                <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
                        disabled
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
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Allotment Count" vid="allotment_count" rules="required|min_value:1">
                      <b-form-group
                        label-for="allotment_count"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('allocation_management.allotment_count')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        disabled
                        v-model="formData.allotment_count"
                        :options="allotmentCount"
                        id="allotment_count"
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
                    <ValidationProvider name="Approval Dispatch No" vid="approval_dispatch_no" rules="required" v-slot="{ errors }">
                      <b-form-group
                        label-for="approval_dispatch_no">
                        <template v-slot:label>
                          {{ $t('allocation_management.approval_dispatch_no') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          disabled
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
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                    <ValidationProvider name="Allotment Order Duration" vid="allotment_duration" v-slot="{ errors }">
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
                          disabled
                        >
                        </date-picker>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
                          :placeholder="$t('globalTrans.select_date')"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
                        >
                        </date-picker>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
                        disabled
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
                </b-row>
                <!-- =============End Main========= -->
            <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
            <div class="table-wrapper table-responsive">
              <table class="table table-striped table-hover table-bordered">
                <thead>
                  <tr class="bg-primary">
                    <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                    <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                    <th scope="col" class="text-center"><div>{{ $t('allocation_management.selling_amount') }}</div></th>
                    <th scope="col" class="text-center"><div>{{ $t('allocation_management.dealer_per_allocation_qty') }}</div></th>
                  </tr>
                </thead>
                <tbody>
                  <template v-if="formData.arrallotmentOrderData && formData.arrallotmentOrderData.length > 0">
                    <tr v-for="(item, index) in formData.arrallotmentOrderData" :key="index">
                      <td  class="text-center">{{ $n(index+1) }}</td>
                      <td class="text-center">{{ categoryName(item.item_category_id) }}</td>
                      <td class="text-center">{{ $n(item.selling_amount) }}</td>
                      <td class="text-center">
                      <ValidationProvider name="Allocated Quantity (Kg/Liter)" :vid="`allocation_quantity${index}`" rules="required" v-slot="{ errors }">
                          <b-form-group
                            :label-for="`allocation_quantity${index}`">
                            <b-form-input
                              id="allocation_quantity"
                              v-model="item.allocation_quantity"
                              oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                            <div class="invalid-feedback">
                              {{ errors[0] }}
                            </div>
                          </b-form-group>
                        </ValidationProvider>
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
            <b-col sm="12">
              <div class="row">
                <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="id != 0">
                  {{ $t('allocation_management.attachment') }}<br/>
                  <a target="_blank" :href="licenseRegistrationServiceBaseUrl + formData.allotment_attachment" class="text-muted"><i class="ri-cloud-fill"></i> {{ $t('globalTrans.attachment') }}</a>
              </b-col>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Attachment" vid="order_attachment" rules="required">
                    <b-form-group
                      label-for="order_attachment"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{ $t('allocation_management.tcb_order_attachment') }}<span class="text-danger">*</span>
                      </template>
                    <b-form-file id="order_attachment"
                      v-model="formData.file"
                      v-on:change="onFileChange"
                      accept=".doc,.docx,.pdf"
                      class="mt-2" plain
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-file>
                      <div class="d-block invalid-feedback">
                       {{ fileValidationMsz }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
              </b-col>
              <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Order Date" vid="order_date" rules="required">
                    <b-form-group
                        label-for="order_date"
                        slot-scope="{ valid, errors }"
                    >
                      <template v-slot:label>
                        {{$t('allocation_management.order_date')}} <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="order_date"
                        v-model="formData.order_date"
                        class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        :state="errors[0] ? false : (valid ? true : null)"
                      >
                      </date-picker>
                      <div class="d-block invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
              </b-col>
              </div>
            </b-col>
            </b-form>
        </ValidationObserver>
        <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
        </b-row>
        </b-col>
      </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allotmentOrderministryStore, allotmentOrderhqUpdate } from '../../api/routes'
import flatpickr from 'flatpickr'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      errors: [],
      formData: {
        fiscal_year_id: 0,
        seller_type: 0,
        allotment_count: 0,
        approval_date: '',
        order_date: '',
        allotment_duration: '',
        start_date: '',
        end_date: '',
        approval_dispatch_no: '',
        file: [],
        allotment_attachment: '',
        order_attachment: '',
        allocation_quantity: '',
        arrallotmentOrderData: []
      },
      fileValidationMsz: ''
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getFeeEntry()
      this.formData = tmp
      this.formData.arrallotmentOrderData = tmp.details
    }
  },
  mounted () {
    flatpickr('#allotment_duration', {
      mode: 'range',
      dateFormat: 'Y-m-d',
      defaultDate: [this.formData.start_date, this.formData.end_date]
    })
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
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
    }
  },
  watch: {
  },
  methods: {
    // ================Allotment Order Modify Start=================
    // onFileChange (event) {
    //   const input = event.target
    //   if (input.files && input.files[0]) {
    //     const reader = new FileReader()
    //     reader.onload = (e) => {
    //       this.formData.order_attachment = e.target.result
    //     }
    //     reader.readAsDataURL(input.files[0])
    //   } else {
    //     this.formData.order_attachment = ''
    //   }
    // },
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
          this.formData.order_attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.formData.order_attachment = ''
      }
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
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.arrallotmentOrderData.length > 0) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${allotmentOrderhqUpdate}/${this.id}`, this.formData)
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

        this.$bvModal.hide('modal-form')
      } else {
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
