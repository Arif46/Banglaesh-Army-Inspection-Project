<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Organization" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.org_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.org_id"
                        :options="orgProfileList"
                        id="org_id"
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
            <b-col lg="6" sm="12">
                <ValidationProvider name="Office Type" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="office_type_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('organogram.office_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.office_type_id"
                        :options="officeTypeList"
                        id="office_type_id"
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
        </b-row>
        <b-row>
            <b-col lg="6" sm="12">
                <ValidationProvider name="area_type_id" vid="area_type_id" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="area_type_id "
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{$t('orgProfile.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.area_type_id"
                        id="area_type_id"
                        :options="getAreaTypeList"
                        @change="getAreaTypeData(office.area_type_id)"
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
        </b-row>
        <b-row>
            <b-col lg="6" sm="12" v-show="ItemShow">
                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="division_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.division_id"
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
            <b-col lg="6" sm="12" v-show="ItemShow">
                <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="district_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.district_id"
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
            <b-col lg="6" sm="12" v-show="PauroshobaItemShow || UnionItemShow">
                <ValidationProvider name="Upazila" vid="upazila_id">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="upazila_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.upazila')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.upazila_id"
                        :options="upazilaList"
                        id="upazila_id"
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
            <b-col lg="6" sm="12" v-show="UnionItemShow">
                <ValidationProvider name="Union" vid="union_id">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="union_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.union')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.union_id"
                        :options="unionList"
                        id="union_id"
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
            <b-col lg="6" sm="12" v-show="CityCorpItemShow">
                <ValidationProvider name="City Corporation" vid="city_corporation_id">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="city_corporation_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('orgProfile.city_corporation') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.city_corporation_id"
                        :options="cityCorporationList"
                        id="city_corporation_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12" v-show="PauroshobaItemShow">
                <ValidationProvider name="Municipality" vid="pauroshoba_id">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="pauroshoba_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('orgProfile.municipality_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                        plain
                        v-model="office.pauroshoba_id"
                        :options="municipalityList"
                        id="pauroshoba_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12" v-show="ItemShow">
                <ValidationProvider name="Ward" vid="ward_id">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="ward_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                            {{ $t('orgProfile.ward') }}
                        </template>
                        <b-form-select
                        plain
                        v-model="office.ward_id"
                        :options="wardList"
                        id="ward_id"
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
        </b-row>
        <b-row>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Office name" vid='office_name' rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="office_name"
                        slot-scope="{ valid, errors }"
                    >
                        <template v-slot:label>
                        {{ $t('organogram.office_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                        id="office_name"
                        v-model="office.office_name"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Office name (bn)" rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="office_name_bn"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{ $t('organogram.office_name')}} {{$t('globalTrans.bn')}}<span class="text-danger">*</span>
                        </template>
                        <b-form-input
                        id="office_name_bn"
                        v-model="office.office_name_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <b-row>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Office code">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label="$t('organogram.office_code')"
                        label-for="office_code"
                        slot-scope="{ valid, errors }"
                    >
                        <b-form-input
                        id="office_code"
                        v-model="office.office_code"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Parent Office Type">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label="$t('organogram.parent_office_type')"
                        label-for="parent_office_type_id"
                        slot-scope="{ valid, errors }"
                        >
                        <b-form-select
                        plain
                        v-model="office.parent_office_type_id"
                        :options="officeTypeList"
                        id="parent_office_type_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                            <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Parent Office">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label="$t('organogram.parent_office_name')"
                        label-for="parent_office_id"
                        slot-scope="{ valid, errors }"
                        >
                        <b-form-select
                        plain
                        v-model="office.parent_office_id"
                        :options="officeList"
                        id="parent_office_id"
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
            <b-col lg="6" sm="12"></b-col>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Is Regional Office" vid="is_regional_office">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="is_regional_office"
                    >
                        <template v-slot:label>
                            {{$t('organogram.is_regional_office')}}
                        </template>
                        <b-form-radio-group
                            v-model="office.is_regional_office"
                            :options="manualList"
                        >
                        </b-form-radio-group>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="12">
                <ValidationProvider name="Regional Office">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        :label="$t('organogram.regional_office_name')"
                        label-for="regional_office_id"
                        slot-scope="{ valid, errors }"
                        >
                        <b-form-select
                        plain
                        v-model="office.regional_office_id"
                        :options="regionalOfficeList"
                        id="regional_office_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :disabled=" regionalStatus"
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { officeStore, officeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      ItemShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      office: {
        org_id: '0',
        office_type_id: '0',
        area_type_id: '0',
        city_corporation_id: '0',
        pauroshoba_id: '0',
        ward_id: '0',
        country_id: 1,
        division_id: '0',
        district_id: '0',
        upazila_id: '0',
        union_id: '0',
        office_name: '',
        office_name_bn: '',
        office_code: '',
        parent_office_type_id: '0',
        parent_office_id: '0',
        is_regional_office: 0,
        regional_office_id: '0',
        created_by: 1,
        updated_by: 1
      },
      regionalStatus: false,
      regionalOfficeList: [],
      officeTypeList: [],
      districtList: [],
      upazilaList: [],
      unionList: [],
      cityCorporationList: [],
      municipalityList: [],
      wardList: [],
      officeList: [],
      manualList: [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes' },
        { value: 0, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
      ]
    }
  },
  created () {
    if (this.id) {
      if (this.office.area_type_id === 1) {
          this.ItemShow = true
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
      } else if (this.office.area_type_id === 2) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
      } else if (this.office.area_type_id === 3) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
      }
      const tmp = this.getOfficeData()
      // Object.freeze(tmp)
      this.office = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
    }
  },
  watch: {
    'office.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'office.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'office.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'office.city_corporation_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
    },
    'office.pauroshoba_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByPauroshoba(newVal)
    },
    'office.union_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByUnion(newVal)
    },
    'office.org_id': function (newVal, oldVal) {
        // this.officeTypeList = this.getOfficeTypeList(newVal)
      if (newVal !== oldVal) {
        this.officeTypeList = this.getOfficeTypeList(newVal)
        this.regionalOfficeList = this.getRegionalOfficeList(newVal)
      } else {
         this.officeTypeList = []
      }
    },
    'office.parent_office_type_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.officeList = this.getParentOfficeList(newVal)
        }
    },
    'office.is_regional_office': function (newVal) {
        if (newVal === 1) {
            this.regionalStatus = true
        } else {
            this.regionalStatus = false
        }
    }
  },
  methods: {
    getAreaTypeData (typeId) {
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
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${officeUpdate}/${this.id}`, this.office)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, officeStore, this.office)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getOffice () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
       return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getOfficeTypeList (id) {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === id)
    },
    getParentOfficeList (officeTypeId = null) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
          return officeList.filter(office => office.office_type_id === officeTypeId)
      }
      return officeList
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
    },
    getPauroshobaList (upazillaId = null) {
      const objectData = this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.upazila_id === upazillaId)
      // if (upazillaId) {
          return objectData.map((obj, key) => {
              if (this.$i18n.locale === 'bn') {
                  return { value: obj.value, text: obj.text_bn }
              } else {
                  return { value: obj.value, text: obj.text_en }
              }
          })
      // }
    },
    getWardListByCityCorportaion (cityCorpId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.city_corporation_id === cityCorpId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByPauroshoba (pauroshobaId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.pauroshoba_id === pauroshobaId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getWardListByUnion (unionId) {
      const objectData = this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1)
      const wardObjectList = objectData.filter(item => item.union_id === unionId && item.status === 1)
      return wardObjectList.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text }
          }
      })
    },
    getRegionalOfficeList (orgId = null) {
        const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === orgId && item.is_regional_office === 1)
        return officeList
    },
    getOfficeData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
