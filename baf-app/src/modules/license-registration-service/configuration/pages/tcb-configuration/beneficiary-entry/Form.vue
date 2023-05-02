<template>
  <div class="inner-section">
      <card>
        <template v-slot:searchHeaderTitle>
          <h4 class="card-title">{{ $t('tcbconfiguration.beneficiary_entry_add') }}</h4>
        </template>
        <!-- <template v-slot:searchHeaderAction>
          <router-link class="btn-add" to="beneficiary-entry"><i class="ri-arrow-left-line"></i> {{ $t('tcbconfiguration.beneficiary_entry') }} {{ $t('globalTrans.list') }}</router-link>
        </template> -->
      <b-container fluid>
      <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
              <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset">
                <b-row>
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="area_type_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="beneficiary.area_type_id"
                            :options="areaTypeList"
                            id="area_type_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
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
                            v-model="beneficiary.division_id"
                            :options="divisionList"
                            id="division_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3">
                    <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="district_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="beneficiary.district_id"
                            :options="districtList"
                            id="district_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 1">
                    <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="city_corporation_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="beneficiary.city_corporation_id"
                            :options="cityCorporationList"
                            id="city_corporation_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 2 || beneficiary.area_type_id === 3">
                    <ValidationProvider name="Upazila" vid="upazila_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="upazila_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="beneficiary.upazila_id"
                            :options="upazilaList"
                            id="upazila_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 2">
                    <ValidationProvider name="Pauroshoba" vid="pauroshoba_id" rules="required|min_value:1">
                        <b-form-group
                            label-for="pauroshoba_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.pouroshova')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="beneficiary.pauroshoba_id"
                            :options="pauroshobaList"
                            id="pauroshoba_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="is_disable"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 3">
                    <ValidationProvider name="Union" vid="union_id">
                        <b-form-group
                            label-for="union_id"
                            slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.union')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="details.union_id"
                            :options="unionList"
                            id="union_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 1 || beneficiary.area_type_id === 2">
                    <ValidationProvider name="Ward" vid="ward_id">
                        <b-form-group
                          label-for="ward_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.ward')}}<span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="details.ward_id"
                            :options="wardList"
                            id="ward_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="beneficiary.area_type_id === 3">
                    <ValidationProvider name="Ward" vid="ward_id">
                        <b-form-group
                          label-for="ward_id"
                          slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('globalTrans.ward')}}
                        </template>
                        <b-form-select
                            plain
                            v-model="details.ward_id"
                            :options="wardList"
                            id="ward_id"
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
                  <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                    <ValidationProvider name="Beneficiary Count" vid="beneficiary_count" v-slot="{ errors }">
                      <b-form-group
                          label-for="beneficiary_count">
                          <template v-slot:label>
                            {{ $t('tcbconfiguration.beneficiary_count') }}<span class="text-danger">*</span>
                          </template>
                          <b-form-input
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                          id="beficiary_count"
                          v-model="details.beneficiary_count"
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
                      <b-button @click="addItem()" type="button" variant="success" class="mr-2 mb-2 btn-sm">
                          {{ $t('globalTrans.add') }}
                      </b-button>
                  </b-col>
                </b-row>
                <b-row>
                    <!-- -----------------Add More Start------------------- -->
                    <div class="table-wrapper table-responsive">
                      <table class="table table-striped table-hover table-bordered">
                        <b-thead>
                          <tr>
                            <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                            <b-th class="text-center" v-if="beneficiary.area_type_id === 3">{{ $t('globalTrans.union') }}</b-th>
                            <b-th class="text-center">{{ $t('globalTrans.ward') }}</b-th>
                            <b-th class="text-center">{{ $t('tcbconfiguration.beneficiary_count') }}</b-th>
                            <b-th class="text-center">{{ $t('globalTrans.action') }}</b-th>
                          </tr>
                        </b-thead>
                        <b-tbody>
                          <template v-if="beneficiary.beficiary_details && beneficiary.beficiary_details.length">
                              <b-tr v-for="(item, index) in beneficiary.beficiary_details" :key="index">
                                  <b-td class="text-center">{{ index+1 }}</b-td>
                                  <b-td class="text-center" v-if="beneficiary.area_type_id === 3">{{ unionName(item.union_id) }}</b-td>
                                  <b-td class="text-center">{{ wardName(item.ward_id) }}</b-td>
                                  <b-td class="text-center" width="20%">
                                      <ValidationProvider name="Beneficiary Count" :vid="`beneficiary_count${index}`" rules="required|min_value:1">
                                          <b-form-group
                                          slot-scope="{ valid, errors }"
                                          >
                                          <b-form-input
                                              style="margin-top: 25px"
                                              id="`beneficiary_count${index}`"
                                              type="number"
                                              oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                              v-model.number="item.beneficiary_count"
                                              :state="errors[0] ? false : (valid ? true : null)"
                                          ></b-form-input>
                                          <div class="invalid-feedback">
                                              {{ errors[0] }}
                                          </div>
                                          </b-form-group>
                                      </ValidationProvider>
                                  </b-td>
                                  <td class="text-center">
                                    <b-button variant="action-btn delete mr-1" size="sm" :title="$t('globalTrans.delete')" @click="removeItem(index)" class="action-btn edit"><i class="ri-close-fill"></i></b-button>
                                  </td>
                              </b-tr>
                          </template>
                          <template v-else>
                            <b-tr v-if="beneficiary.area_type_id === 3">
                              <b-td colspan="5" align="center">{{ $t('globalTrans.noDataFound') }}</b-td>
                            </b-tr>
                            <b-tr v-else>
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
                        <router-link :to="{ path: '/license-registration-service/configuration/tcb-configuration/beneficiary-entry'}" class="btn btn-danger btn-sm">
                            {{ $t('globalTrans.cancel') }}
                        </router-link>
                    </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
      </b-row>
  </b-container>
  </card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { beneficiartEntryStore, beneficiartEntryUpdate, beneficiartEntryshow } from '../../../api/routes'

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
      beneficiary: {
          area_type_id: 0,
          city_corporation_id: 0,
          regional_office_id: 0,
          pauroshoba_id: 0,
          division_id: 0,
          district_id: 0,
          upazila_id: 0,
          beficiary_details: []
      },
      details: {
        ward_id: 0,
        union_id: 0,
        beneficiary_count: ''
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      wardList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      is_disable: false
  }
},
created () {
    if (this.$route.query.id) {
        this.getbeneficiary()
        this.saveBtnName = this.$t('globalTrans.update')
    }
},
computed: {
  areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
  },
  divisionList: function () {
     return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
  }
},
watch: {
  'beneficiary.division_id': function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.districtList = this.getDistrictList(newVal)
      if (oldVal) {
        this.beneficiary.district_id = 0
      }
    } else {
      this.districtList = []
    }
  },
  'beneficiary.district_id': function (newVal, oldVal) {
    if (newVal !== oldVal) {
      this.upazilaList = this.getUpazilaList(newVal)
      this.cityCorporationList = this.getcityCorporationList(newVal)
      if (oldVal) {
        this.beneficiary.upazila_id = 0
      }
    } else {
      this.upazilaList = []
      this.cityCorporationList = []
    }
  },
  'beneficiary.upazila_id': function (newVal, oldVal) {
    if (newVal !== oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.pauroshobaList = this.getPauroshobaList(newVal)
        if (oldVal) {
          this.beneficiary.union_id = 0
          this.beneficiary.pauroshoba_id = 0
        }
    } else {
      this.unionList = []
      this.pauroshobaList = []
    }
  },
  'beneficiary.city_corporation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.wardList = this.getWardList(newVal)
        if (oldVal) {
          this.beneficiary.ward_id = 0
        }
      } else {
          this.wardList = []
      }
  },
  'beneficiary.pauroshoba_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.wardList = this.getPauroshobaWardList(newVal)
        if (oldVal) {
          this.beneficiary.ward_id = 0
        }
      } else {
         this.wardList = []
      }
  },
  'beneficiary.union_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
          this.wardList = this.getUnionWardList(newVal)
          if (oldVal) {
            this.beneficiary.ward_id = 0
          }
      } else {
         this.wardList = []
      }
  }
},
methods: {
  async getbeneficiary () {
    this.loading = true
    this.is_disable = true
    const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `${beneficiartEntryshow}/${this.$route.query.id}`)
    if (result.success) {
      this.beneficiary = result.data
    }
     this.loading = false
  },
  async addItem () {
    // if (this.details.ward_id || this.details.union_id > 0) {
      const wardName = this.$store.state.CommonService.commonObj.wardList.filter(item => item.value === this.details.ward_id)
      const unionName = this.$store.state.CommonService.commonObj.unionList.filter(item => item.value === this.details.union_id)
      var obj = {
        ward_id: this.details.ward_id,
        ward_name: wardName[0]?.text_en,
        ward_name_bn: wardName[0]?.text_bn,
        union_id: this.details.union_id,
        union_name: unionName[0]?.text_en,
        union_name_bn: unionName[0]?.text_bn,
        beneficiary_count: parseInt(this.details.beneficiary_count)
      }
      if (this.beneficiary.area_type_id === 1 || this.beneficiary.area_type_id === 2) {
        if (this.details.ward_id && this.details.beneficiary_count > 0) {
          const extItem = this.beneficiary.beficiary_details.find(eItm => eItm.ward_id === this.details.ward_id && eItm.union_id === this.details.union_id)
          if (extItem === undefined) {
            this.is_disable = true
            this.beneficiary.beficiary_details.push(obj)
          } else {
            extItem.beneficiary_count += parseInt(this.details.beneficiary_count)
          }
        }
      }
      if (this.beneficiary.area_type_id === 3) {
        if (this.details.union_id && this.details.beneficiary_count > 0) {
          const extItem = this.beneficiary.beficiary_details.find(eItm => eItm.ward_id === this.details.ward_id && eItm.union_id === this.details.union_id)
          if (extItem === undefined) {
            this.is_disable = true
            this.beneficiary.beficiary_details.push(obj)
          } else {
            extItem.beneficiary_count += parseInt(this.details.beneficiary_count)
          }
        }
      }
       this.details = {
          ward_name: '',
          ward_name_bn: '',
          ward_id: 0,
          union_name: '',
          union_name_bn: '',
          union_id: 0,
          beneficiary_count: ''
      }
       this.$refs.form.reset()
    // }
  },
  removeItem (item) {
    this.beneficiary.beficiary_details.splice(item, 1)
  },
  async saveUpdate () {
    this.loading = true
    this.$store.dispatch('mutateCommonProperties', { loading: true })
    let result = null
    const loadingState = { loading: false, listReload: false }
    if (this.$route.query.id) {
      result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${beneficiartEntryUpdate}/${this.$route.query.id}`, this.beneficiary)
    } else {
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, beneficiartEntryStore, this.beneficiary)
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
      this.$router.push({ path: '/license-registration-service/configuration/tcb-configuration/beneficiary-entry' })
    } else {
      this.$refs.form.setErrors(result.errors)
    }
    this.loading = false
  },
  getDistrictList (id) {
    return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
  },
  getUpazilaList (id) {
    return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
  },
  getUnionList (id) {
    return this.$store.state.CommonService.commonObj.unionList.filter(item => item.upazila_id === id)
  },
  getWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
  },
  getPauroshobaWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.municipality_id === id)
  },
  getUnionWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.union_id === id)
  },
  getPauroshobaList (id) {
     return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
  },
  getcityCorporationList (id) {
    return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
  },
  wardName (wardId) {
    const wardObj = this.$store.state.CommonService.commonObj.wardList.find(item => item.value === wardId)
      if (wardObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return wardObj.text_bn
        } else {
          return wardObj.text_en
        }
      }
  },
  unionName (id) {
    const unionObj = this.$store.state.CommonService.commonObj.unionList.find(item => item.value === id)
      if (unionObj !== undefined) {
        if (this.$i18n.locale === 'bn') {
          return unionObj.text_bn
        } else {
          return unionObj.text_en
        }
      }
   }
  }
}
</script>
