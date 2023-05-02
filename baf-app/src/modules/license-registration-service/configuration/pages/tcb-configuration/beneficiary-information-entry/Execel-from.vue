<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
        <b-col md="12" sm="12">
            <b-row>
                <b-col xl="6" lg="6" sm="12">
                    <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="area_type_id "
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="form.area_type_id"
                            id="area_type_id"
                            :options="getAreaTypeList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xl="6" lg="6" sm="12" v-if="ItemShow">
                    <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="division_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                            {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="form.division_id"
                            :options="divisionList"
                            id="division_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xl="6" lg="6" sm="12" v-if="ItemShow">
                    <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="district_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                            {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="form.district_id"
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
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xl="6" lg="6" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                    <ValidationProvider name="Upazila" vid="upazilla_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="upazilla_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                            {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="form.upazilla_id"
                            :options="upazilaList"
                            id="upazilla_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                <b-col xl="6" lg="6" sm="12" v-if="CityCorpItemShow">
                    <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="5"
                            label-for="city_corporation_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="form.city_corporation_id"
                            :options="cityCorporationList"
                            id="city_corporation_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            <div class="invalid-feedback">
                            {{ errors[0] }}
                            </div>
                        </b-form-group>
                    </ValidationProvider>
                </b-col>
                 <b-col xl="12" lg="12" sm="12">
                 <p> {{ $t('tcbconfiguration.excel_downolad_msg') }} </p>
                 <a target="_blank" class="btn btn-primary mr-2" :href="licenseRegistrationServiceBaseUrl+'download-attachment?file=storage/beneficiary/beneficiary-excel-format/tcb_beneficiary_info_format.xlsx'"><i class="ri-file-download-line"></i>&nbsp;{{$t('globalTrans.download')}}</a>
                </b-col>
                <b-col xs="6" sm="12" md="6" lg="6" xl="6" class="mt-3">
                    <ValidationProvider name="Beneficiary Attachment" vid="excel_file" rules="required">
                      <b-form-group
                        label-for="excel_file"
                        label-cols-sm="5"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{ $t('tcbconfiguration.beneficiary_attachment') }}<span class="text-danger">*</span>
                        </template>
                      <b-form-file id="excel_file"
                      v-model="form.excel_file"
                      v-on:change="onFileChange"
                      accept=".xlsx"
                      class="mt-2" plain
                      :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-file>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
              </b-col>
            </b-row>
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
import { beneficiartInformationExcelUpload } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        area_type_id: 0,
        district_id: 0,
        division_id: 0,
        upazilla_id: 0,
        city_corporation_id: 0,
        excel_file: [],
        attachment: ''
      },
      districtList: [],
      upazilaList: [],
      cityCorporationList: [],
      ItemShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      UnionItemPerShow: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getItemEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
     getAreaTypeList: function () {
      const objectData = this.$store.state.commonObj.typeList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.id, text: obj.name_bn }
          } else {
            return { value: obj.id, text: obj.name }
          }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  watch: {
    'form.area_type_id': function (n, o) {
      if (o !== n) {
        this.getAreaTypeData(n)
      }
    },
    'form.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
    },
    'form.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazillaList(newVal)
    }
  },
  methods: {
    onFileChange (e) {
      this.form.attachment = e.target.files[0]
    },
     getAreaTypeData (typeId) {
      if (typeId) {
        this.ItemShow = true
        if (typeId === 1) {
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
        } else if (typeId === 2) {
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
        } else if (typeId === 3) {
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
        }
      }
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      var formData = new FormData()
      Object.keys(this.form).map(key => {
        formData.append(key, this.form[key])
      })
      formData.append('excel_file', this.form.attachment)
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, beneficiartInformationExcelUpload, formData)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result === undefined) {
        this.$toast.success({
          title: 'Error',
          message: this.$t('tcbconfiguration.excel_error'),
          color: '#FF0000'
        })
      }

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
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getDistrictList (divisionId) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === divisionId)
    },
    getUpazillaList (districtId) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
      })
    }
  }
}
</script>
