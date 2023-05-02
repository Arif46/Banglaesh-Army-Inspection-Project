<template>
    <b-container fluid>
      <b-row>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
              <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
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
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                      <b-form-group
                          label-for="division_id"
                          slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="formData.division_id"
                          :options="divisionList"
                          id="division_id"
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
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="District" vid="district_id">
                      <b-form-group
                          label-for="district_id"
                          slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                          {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="details.district_id"
                          :options="districtList"
                          id="district_id"
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
                <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-4">
                  <button @click="addItem()" class="btn btn-sm btn-primary mr-2" type="button"
                  ><i class="fas fa-plus-circle m-0"></i> {{$t('bazarMonitoring.add')}}</button>
                </b-col>
              </b-row>
              <b-row>
                  <!-- -----------------Add More Start------------------- -->
                  <div class="table-wrapper table-responsive">
                      <table class="table table-striped table-hover table-bordered">
                          <b-thead>
                            <tr>
                              <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th class="text-center">{{ $t('globalTrans.district') }}</b-th>
                              <b-th class="text-center">{{ $t('globalTrans.action') }}</b-th>
                            </tr>
                          </b-thead>
                          <b-tbody>
                              <template v-if="formData.district_details && formData.district_details.length">
                                  <b-tr v-for="(item, index) in formData.district_details" :key="index">
                                      <b-td class="text-center">{{ $n(index+1) }}</b-td>
                                      <b-td class="text-center">
                                      {{ distirctName(item.district_id) }}
                                      <span class="d-block invalid-feedback" v-if="errorArr['district_details.'+index+'.district_id']">
                                        {{ $t('tcbconfiguration.districtStatus') }}
                                      </span>
                                      </b-td>
                                      <td class="text-center">
                                        <b-button variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="removeItem(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                      </td>
                                  </b-tr>
                              </template>
                              <template v-else>
                                  <b-tr>
                                    <b-td colspan="4" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                                  </b-tr>
                              </template>
                          </b-tbody>
                      </table>
                  </div>
                  <!-- -----------------Add More End--------------------- -->
              </b-row>
              <b-row class="text-right mb-3">
                  <b-col>
                      <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                      <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
                  </b-col>
              </b-row>
            </b-form>
          </b-overlay>
        </ValidationObserver>
      </b-row>
    </b-container>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { regionWiseDistrictEntryStore, regionWiseDistrictEntryUpdate } from '../../../api/routes'

export default {
  components: {
  },
name: 'Form',
props: ['id'],
data () {
  return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      loading: false,
      formData: {
        regional_office_id: 0,
        division_id: 0,
        district_details: []
      },
      details: {
        district_id: 0
      },
      districtList: [],
      is_disable: false,
      errorArr: []
  }
},
created () {
    if (this.id) {
      const tmp = this.getformData()
      const arr = []
      tmp.district_details.forEach(item => {
        arr.push(item.id)
      })
     this.formData = Object.assign({}, this.formData, tmp, { district_id: arr })
    }
},
computed: {
  regionalOfficeList: function () {
    return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
  },
  divisionList: function () {
    return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
  }
},
watch: {
  'formData.division_id': function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.districtList = this.getDistrictList(newVal)
      if (oldVal) {
        this.formData.district_id = 0
      }
    } else {
      this.districtList = []
    }
  }
},
methods: {
   getformData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
  async addItem () {
    if (this.details.district_id > 0) {
      const districtName = this.$store.state.CommonService.commonObj.districtList.filter(item => item.value === this.details.district_id)
      const obj = {
        district_id: this.details.district_id,
        district_name: districtName[0]?.text_en,
        district_name_bn: districtName[0]?.text_bn
      }
      const objExist = this.formData.district_details.find(detail => detail.district_id === obj.district_id)
          if (typeof objExist === 'undefined') {
            // this.is_disable = true
            this.formData.district_details.push(obj)
          } else {
            this.$toast.error({
              title: this.$t('tcbconfiguration.data_already_add'),
              color: '#D6E09B'
            })
          }
      this.details = {
        district_id: 0
      }
      this.$refs.form.reset()
    }
  },
  removeItem (item) {
    this.formData.district_details.splice(item, 1)
  },
  async saveUpdate () {
    this.loading = true
    this.$store.dispatch('mutateCommonProperties', { loading: true })
    let result = null
    const loadingState = { loading: false, listReload: false }
    if (this.id) {
      result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${regionWiseDistrictEntryUpdate}/${this.id}`, this.formData)
    } else {
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, regionWiseDistrictEntryStore, this.formData)
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
      this.errorArr = result.errors
      this.$refs.form.setErrors(result.errors)
    }
    this.loading = false
  },
  getDistrictList (id) {
    return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
  },
  distirctName (districtId) {
    const distrctObj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === districtId)
      if (distrctObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return distrctObj.text_bn
        } else {
          return distrctObj.text_en
        }
      }
    }
  }
}
</script>
