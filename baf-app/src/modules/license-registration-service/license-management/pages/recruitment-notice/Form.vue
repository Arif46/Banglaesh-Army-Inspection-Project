<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <div>
          <p style="font-size:17px;color:#77A0CB"><i class="ri-home-7-line"></i> {{ $t('license_management.division_district_status') }}</p>
        </div>
        <b-row class="mt-3" style="border-bottom:1px solid">
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Area Type" vid="area_type_id">
              <b-form-group
                class="row"
                label-for="area_type_id "
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{ $t('orgProfile.area_type') }}
                </template>
                <b-form-select
                plain
                v-model="formData.area_type_id"
                id="area_type_id"
                :options="areaTypeList"
                :state="errors[0] ? false : (valid ? true : null)"
                @change="getChangeDropdowns(formData.area_type_id)"
                >
                <template v-slot:first>
                    <b-form-select-option value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6"  v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
            <ValidationProvider name="Division" vid="division_id">
              <b-form-group
                label-for="division_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.division')}}
              </template>
                <v-select
                  id="division_id"
                  v-model="formData.division_id"
                  multiple
                  :reduce="op => op.value"
                  :options="divisionList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6"  v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
            <ValidationProvider name="District" vid="district_id">
              <b-form-group
                label-for="district_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.district')}}
              </template>
                <v-select
                  id="district_id"
                  v-model="formData.district_id"
                  multiple
                  :reduce="op => op.value"
                  :options="districtList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="formData.area_type_id === 1">
            <ValidationProvider name="City Corporation" vid="city_corporation_id">
              <b-form-group
                label-for="city_corporation_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.city_corporation')}}
              </template>
                <v-select
                  id="city_corporation_id"
                  v-model="formData.city_corporation_id"
                  multiple
                  :reduce="op => op.value"
                  :options="cityCorporationList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="formData.area_type_id === 2 || formData.area_type_id === 3">
            <ValidationProvider name="Upazilla" vid="upazila_id">
              <b-form-group
                label-for="upazila_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.upazila')}}
              </template>
                <v-select
                  id="upazila_id"
                  v-model="formData.upazila_id"
                  multiple
                  :reduce="op => op.value"
                  :options="upazilaList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="formData.area_type_id === 2">
            <ValidationProvider name="Upazilla" vid="pauroshoba_id">
              <b-form-group
                label-for="pauroshoba_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.pouroshova')}}
              </template>
                <v-select
                  id="pauroshoba_id"
                  v-model="formData.pauroshoba_id"
                  multiple
                  :reduce="op => op.value"
                  :options="pauroshobaList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="formData.area_type_id === 3">
            <ValidationProvider name="Union" vid="union_id">
              <b-form-group
                label-for="union_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.union')}}
              </template>
                <v-select
                  id="union_id"
                  v-model="formData.union_id"
                  multiple
                  :reduce="op => op.value"
                  :options="unionList"
                  label="text"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.select')"
                >
                </v-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="mt-2">
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Title (Bn)" vid="title_bn" rules="required|max:255">
              <b-form-group
                label-for="title_bn"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.title_bn')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="formData.title_bn"
                id="title_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
             <ValidationProvider name="Title (En)" vid="title_en" rules="required|max:255">
              <b-form-group
                label-for="title_en"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('exportTrophyCircular.title_en')}} <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="formData.title_en"
                id="title_en"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Notice Date" vid="notice_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="notice_date">
                <template v-slot:label>
                  {{ $t('license_management.notice_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="notice_date"
                  v-model="formData.notice_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select')"
                  :config="config"
                >
              </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Memorial No" vid="memorial_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="memorial_no">
                <template v-slot:label>
                  {{ $t('license_management.memorial_no') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="memorial_no"
                  v-model="formData.memorial_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Application Start Date" vid="start_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                  {{ $t('license_management.start_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="start_date"
                  v-model="formData.start_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :config="config"
                >
                </date-picker>
                <div class="invalid-feedback d-block" v-if="errors.length">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Application End Date" vid="end_date" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('license_management.end_date') }} <span class="text-danger">*</span>
                </template>
                <date-picker
                  id="end_date"
                  v-model="formData.end_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :config="config"
                >
                </date-picker>
                <div class="invalid-feedback d-block" v-if="errors.length">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description (Bn)" vid="description_bn">
              <b-form-group
                label-for="description_bn"
                slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.description_bn')}}
              </template>
              <vue-editor v-model="formData.description_bn"></vue-editor>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en"
                slot-scope="{ errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.description_en')}}
              </template>
              <vue-editor v-model="formData.description_en"></vue-editor>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { recruitmentStore, recruitmentUpdate } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  components: {
    VueEditor
  },
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        notice_date: '',
        memorial_no: '',
        start_date: '',
        end_date: '',
        description_bn: '',
        description_en: '',
        title_en: '',
        title_bn: '',
        area_type_id: 0,
        division_id: [],
        city_corporation_id: [],
        district_id: [],
        pauroshoba_id: [],
        upazila_id: [],
        union_id: []
      },
      districtList: [],
      upazilaList: [],
      prvDivisionIdArr: [],
      prvDistrictIdArr: [],
      prvUpazilaIdArr: [],
      prvUnionIdArr: [],
      prvPauroshobaArr: [],
      prvCityCorporationArr: [],
      cityCorporationList: [],
      unionList: [],
      config: { static: true },
      districList: [],
      pauroshobaList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getRecruitmentNotice()
      this.formData = tmp
    }
  },
  watch: {
    // 'formData.area_type_id': function (newVal, oldVal) {
    //   if (newVal !== oldVal) {
    //     this.formData.division_id = []
    //   }
    // },
    'formData.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getMultipleDistrictList(newVal)
      }
    },
    'formData.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getMultipleUpazilaList(newVal)
        this.getMultipleCityCorporationList(newVal)
      }
    },
    'formData.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getMultiplePauroshabaList(newVal)
        this.getMultipleUnionList(newVal)
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
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
  methods: {
    getChangeDropdowns (type) {
        if (type === 1) {
          this.formData.division_id = []
        } else if (type === 2) {
          this.formData.division_id = []
        } else if (type === 3) {
          this.formData.division_id = []
        }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${recruitmentUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, recruitmentStore, this.formData)
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
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: result.message,
          color: '#ee5253'
        })
        this.$refs.form.setErrors(result.errors)
      }
    },
    getRecruitmentNotice () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getMultipleDistrictList (divisionIds) {
      if (divisionIds.length) {
        this.districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => divisionIds.includes(item.division_id))
        if (this.formData.district_id.length) {
          const arr = []
          this.formData.district_id.forEach(id => {
            const obj = this.districtList.find(obj => obj.value === parseInt(id))
            if (obj !== undefined) {
              arr.push(id)
            }
          })
          this.formData.district_id = arr
        }
      } else {
        this.districtList = []
        this.formData.district_id = []
        this.cityCorporationList = []
        this.formData.city_corporation_id = []
        this.upazilaList = []
        this.formData.upazila_id = []
        this.unionList = []
        this.formData.union_id = []
        this.pauroshobaList = []
        this.formData.pauroshoba_id = []
      }
    },
    getMultipleUpazilaList (districtIds) {
      if (districtIds.length) {
        this.upazilaList = this.$store.state.CommonService.commonObj.upazilaList.filter(item => districtIds.includes(item.district_id))
        if (this.formData.upazila_id.length) {
          const arr = []
          this.formData.upazila_id.forEach(id => {
            const obj = this.upazilaList.find(obj => obj.value === parseInt(id))
            if (obj !== undefined) {
              arr.push(id)
            }
          })
          this.formData.upazila_id = arr
        }
      } else {
        this.upazilaList = []
        this.formData.upazila_id = []
        this.unionList = []
        this.formData.union_id = []
        this.pauroshobaList = []
        this.formData.pauroshoba_id = []
      }
    },
    getMultipleCityCorporationList (districtIds) {
      if (districtIds.length) {
        this.cityCorporationList = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => districtIds.includes(item.district_id))
        if (this.formData.city_corporation_id.length) {
          const cityCorporationIdArr = []
          this.formData.city_corporation_id.forEach(cityCorporationId => {
            const cityCorporation = this.cityCorporationList.find(obj => obj.value === parseInt(cityCorporationId))
            if (cityCorporation !== undefined) {
              cityCorporationIdArr.push(cityCorporationId)
            }
          })
          this.formData.city_corporation_id = cityCorporationIdArr
        }
      } else {
        this.cityCorporationList = []
        this.formData.city_corporation_id = []
      }
    },
    getMultiplePauroshabaList (upazilaIds) {
    if (upazilaIds.length) {
        this.pauroshobaList = this.$store.state.CommonService.commonObj.municipalityList.filter(item => upazilaIds.includes(item.upazila_id))
        if (this.formData.pauroshoba_id.length) {
          const arr = []
          this.formData.pauroshoba_id.forEach(pauroshobaId => {
            const obj = this.pauroshobaList.find(obj => obj.value === parseInt(pauroshobaId))
            if (obj !== undefined) {
              arr.push(pauroshobaId)
            }
          })
          this.formData.pauroshoba_id = arr
        }
      } else {
        this.pauroshobaList = []
        this.formData.pauroshoba_id = []
      }
    },
    getMultipleUnionList (upazilaIds) {
      if (upazilaIds.length) {
        this.unionList = this.$store.state.CommonService.commonObj.unionList.filter(item => upazilaIds.includes(item.upazila_id))
        if (this.formData.union_id.length) {
          const arr = []
          this.formData.union_id.forEach(unionId => {
            const unionObj = this.unionList.find(obj => obj.value === parseInt(unionId))
            if (unionObj !== undefined) {
              arr.push(unionId)
            }
          })
          this.formData.union_id = arr
        }
      } else {
        this.unionList = []
        this.formData.union_id = []
      }
    }
  }
}
</script>
