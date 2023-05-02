<template>
 <div class="inner-section">
    <bread-cumb />
       <body-card>
       <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('allocation_management.allotment_order') }}  {{ $t('globalTrans.edit') }}</h4>
      </template>
          <b-container fluid>
              <b-row>
                <b-col sm="12" class="mt-3">
                  <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
                    <b-overlay :show="loading">
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
                                    disabled
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
                                    v-model="formData.allotment_count_id"
                                    :options="allotmentCount"
                                    id="allotment_count_id"
                                    disabled
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
                                <ValidationProvider name="Dispatch No" vid="dispatch_no" rules="required" v-slot="{ errors }">
                                  <b-form-group
                                    label-for="dispatch_no">
                                    <template v-slot:label>
                                      {{ $t('allocation_dc_office.dispatch_no') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                      id="dispatch_no"
                                      v-model="formData.dispatch_no"
                                      :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
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
                                  {{ $t('allocation_management.allotment_order') }} {{ $t('globalTrans.details') }}
                              </h5>
                          </div>
                    </template>
                      <hr>
                      <!-- =================Add More Start===================== -->
                                <!-- Allotment Items -->
                       <div class="table-wrapper table-responsive">
                        <b-overlay :show="loader">
                        <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('allocation_dc_office.beneficiary_per_qt') }}</div></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="allotmentItems && allotmentItems.length > 0">
                                        <tr v-for="(item, index) in allotmentItems" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td class="text-center">{{ getCategoryItemName(item.item_category_id) }}</td>
                                            <td class="text-center">{{ $n(item.beneficiary_per_qt) }}</td>
                                        </tr>
                                    </template>
                                    <template v-else>
                                        <tr>
                                            <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                            </b-overlay>
                        </div>
                          <!-- Allotment Item Details End -->
                        <hr>
                      <!-- =================Add More Start===================== -->
                                <!--District Wise Allotment Items -->
                       <div class="table-wrapper table-responsive tableFixHead">
                        <b-overlay :show="loader">
                        <table class="table table-hover table-bordered">
                                <thead>
                                    <tr class="bg-primary">
                                        <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('globalTrans.district_name') }}</div></th>
                                        <th scope="col" class="text-center"><div>{{ $t('allocation_management.no_of_beneficary') }}</div></th>
                                        <template v-if="formData.districts[0].details && formData.districts[0].details.length > 0">
                                          <th  v-for="(item, index) in formData.districts[0].details" :key="index">
                                            <div>{{ getCategoryItemName(item.item_category_id) }}</div>
                                          </th>
                                        </template>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-if="formData.districts && formData.districts.length > 0">
                                        <tr v-for="(district, index) in formData.districts" :key="index">
                                            <td  class="text-center">{{ $n(index+1) }}</td>
                                            <td class="text-center">{{ getDistrictName(district.district_id) }}</td>
                                            <td style="width: 20%" class="text-center" >
                                                <ValidationProvider name="No Of Beneficiary" :vid="`no_of_beneficiary${index}`" rules="required" v-slot="{ errors }">
                                                  <b-form-group
                                                    :label-for="`no_of_beneficiary${index}`">
                                                    <b-form-input
                                                      id="no_of_beneficiary"
                                                      v-model.number="district.total_beneficiary"
                                                      oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                    ></b-form-input>
                                                    <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                    </div>
                                                  </b-form-group>
                                                </ValidationProvider>
                                            </td>
                                             <template v-if="allotmentItems && allotmentItems.length > 0">
                                              <td v-for="(item, itemIndex) in allotmentItems" :key="itemIndex" class="text-center" >
                                              {{ $n(item.beneficiary_per_qt*district.total_beneficiary)}}
                                            </td>
                                            </template>
                                        </tr>
                                        <tr>
                                          <th class="text-right" colspan="2"> {{$t('globalTrans.total')}}:</th>
                                          <th>{{ $n(getTotalBeneficiary()) }}</th>
                                          <template v-if="allotmentItems && allotmentItems.length > 0">
                                            <th v-for="(item, itemIndex) in allotmentItems" :key="itemIndex" class="text-center" >
                                              {{ $n(item.beneficiary_per_qt*getTotalBeneficiary())}}
                                            </th>
                                          </template>
                                        </tr>
                                    </template>
                                    <template v-else>
                                        <tr>
                                            <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                        </b-overlay>
                        </div>
                        <b-row>
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="Remarks En" vid="remarks">
                              <b-form-group
                              class="row"
                              label-for="remarks"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('globalTrans.remarks') }}
                              </template>
                              <b-form-textarea
                              rows="3"
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
                          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                            <ValidationProvider name="Remarks Bn" vid="remarks_bn">
                              <b-form-group
                              class="row"
                              label-for="remarks_bn"
                              slot-scope="{ valid, errors }">
                              <template v-slot:label>
                                {{ $t('globalTrans.remarks_bn') }}
                              </template>
                              <b-form-textarea
                              rows="3"
                              id="remarks_bn"
                              v-model="formData.remarks_bn"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-textarea>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                        <!--District Wise Allotment Items End -->
                      </b-form>
                   </b-overlay>
                  </ValidationObserver>
                    <br>
                <b-row class="text-right mb-3">
                    <b-col>
                        <b-button type="submit" variant="warning" @click="saveData(1)" class="mr-2 btn-sm">{{ $t('globalTrans.draft') }}</b-button>
                        <b-button type="submit" variant="success" @click="saveData(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                        <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
            </b-col>
              </b-row>
          </b-container>
     </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { districtWiseAllotmentUpdate, allotmentItemList } from '../../api/routes'
import BreadCumb from '../../../../../components/BreadCumb.vue'
export default {
  name: 'Edit-form',
  props: ['id'],
  components: { BreadCumb },
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.finalSave'),
      errors: [],
      formData: {
        fiscal_year_id: 0,
        allotment_count_id: 0,
        regional_office_id: 0,
        remarks: '',
        remarks_bn: '',
        districts: []
      },
      loader: false,
      allotmentItems: [],
      showDistrict: false,
      itemList: []
    }
  },
  created () {
    if (this.$route.query.id) {
      const tmp = this.getEditEntry()
      this.formData = tmp
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
    officeList () {
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
          this.showDistrict = false
          this.getAllotmentItems(this.formData.allotment_count_id, newVal)
        }
    },
    'formData.allotment_count_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.showDistrict = false
          this.loader = true
          this.getAllotmentItems(newVal, this.formData.fiscal_year_id)
        }
    }
  },
  methods: {
    cancel () {
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/district-wise-allotment' })
    },
    getDistrictName (id) {
        if (id) {
            const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
            if (this.$i18n.locale === 'bn') {
                return obj.text_bn
            } else {
                return obj.text_en
            }
        }
    },
    getTotalBeneficiary () {
        return this.formData.districts.reduce((total, item) => total + parseFloat(item.total_beneficiary), 0)
    },
    calItemByBeneficiary (itemPerBeneficiary, NoOfBeneficary) {
        return parseFloat(itemPerBeneficiary * NoOfBeneficary)
    },
      async getAllotmentItems (allotmentId, fiscalYearId) {
          const params = {
            fiscal_year_id: fiscalYearId,
            allotment_count_id: allotmentId
          }
        let result = null
        result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allotmentItemList, params)
        if (result.success) {
          if (result.data !== null) {
            this.allotmentItems = result.data.details
             this.loader = false
          } else {
            this.loader = false
              this.allotmentItems = []
          }
        }
    },
    showDistrictData () {
      this.showDistrict = true
    },
    async saveData (status) {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid && this.formData.districts.length > 0) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.formData.allotmentItems = this.allotmentItems
      this.formData.status = status
      if (this.$route.query.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${districtWiseAllotmentUpdate}/${this.$route.query.id}`, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push({ path: '/license-registration-service/allocation-management-dc-office/district-wise-allotment' })
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getCategoryItemName (itemCategoryId) {
          const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
          if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return cateObj.text_bn
              } else {
                  return cateObj.text_en
              }
          }
    },
    getEditEntry () {
      const itemId = this.$route.query.id
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(itemId))
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
<style scoped>
.tableFixHead          { overflow: auto; height: 500px; }
.tableFixHead thead th { position: sticky; top: 0; z-index: 1;background-color: #77a0cb;}
</style>
