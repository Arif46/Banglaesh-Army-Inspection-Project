<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
              <b-form-group
                label-for="org_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="region.org_id"
                :options="orgProfileList"
                id="org_id"
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
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                label-for="service_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('service_name.service_name')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="region.service_id"
                :options="serviceNamesList"
                id="service_id"
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
            <ValidationProvider name="Region" vid="region_office_id" rules="required|min_value:1">
              <b-form-group
                label-for="region_office_id"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('organogram.regional_office_name')}}<span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="region.region_office_id"
                  :options="regionNameList"
                  id="region_office_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                <template v-slot:first>
                <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                </template>
                </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row v-for="(setDistrict, index) in setDistricts" :key="index">
          <b-col lg="6" sm="6">
            <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
              <b-form-group
                label-for="district"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="region.district_id[setDistrict.step_id]"
                  :options="districtList"
                  id="district_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                  <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                <div class="invalid-feedback d-block" v-if="customError.hasOwnProperty('district_id.' + index)">
                  The District has already been taken.
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="2" sm="2" class="mt-2">
            <b-button v-show="index == setDistricts.length-1" variant="success" class="btn-sm mt-2" @click="add(setDistrict.step_id)"><i class="ri-add-line m-0"></i></b-button>
            <b-button  v-show="index == setDistricts.length-1" variant="danger" class="btn-sm mt-2" @click="remove(index, setDistrict.step_id)"><i class="ri-delete-bin-line m-0"></i></b-button>
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
import { regionStore, regionUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      region: {
        district_id: [],
        org_id: 0,
        service_id: 0,
        region_office_id: 0
      },
      setDistricts: [
        {
          step_id: 0,
          district_id: []
        }
      ],
      serviceNamesList: [],
      regionNameList: [],
      districtList: [],
      customError: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getRegionData()
      const distId = []
      tmp.master_region_districts.forEach(function (item, index) {
        distId.push(item.district_id)
      })
      tmp.district_id = distId
      this.region = tmp
      const districtLength = distId.length
      if (districtLength) {
        this.setDistricts.splice(0, 1)
        for (let i = 0; i < districtLength; i++) {
          const stepName = {
            step_id: i,
            district_id: distId[i]
          }
          this.setDistricts.push(stepName)
        }
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  watch: {
    'region.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getSevicename(newVal)
        this.regionNameList = this.getRegionNameList(newVal)
      }
    },
    'region.region_office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        const regionalOffice = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === newVal)
        this.districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === regionalOffice.division_id)
      }
    }
  },
  methods: {
    getSevicename (orgId) {
        const service = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
        return service
    },
    getRegionNameList (orgId) {
      const tmpList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === orgId && item.is_regional_office === 1)
      return tmpList.map(item => ({ text: item.text, value: item.value }))
    },
    getRegionData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${regionUpdate}/${this.id}`, this.region)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, regionStore, this.region)
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
    },
    add (stepId) {
      const stepName = {
        step_id: stepId + 1,
        district_id: ''
      }
      this.setDistricts.push(stepName)
    },
    remove (key, stepId) {
        if (this.id) {
            const index = this.region.district_id.indexOf(this.setDistricts[key].district_id)
            if (index > -1) {
             this.region.district_id.splice(index, 1)
            }
        } else {
            this.region.district_id.splice(stepId, 1)
        }
        this.setDistricts.splice(key, 1)
       this.region.district_id.splice(stepId, 1)
    }
  }
}
</script>
