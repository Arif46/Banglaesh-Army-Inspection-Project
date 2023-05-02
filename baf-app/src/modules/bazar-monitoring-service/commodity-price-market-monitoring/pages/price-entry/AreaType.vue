<template>
  <div class="row">
    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
      <ValidationProvider name="Area Type" vid="area_type_id">
          <b-form-group
              label-for="area_type_id"
              slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
              {{$t('bazarMonitoring.area_type')}}
          </template>
          <b-form-select
              plain
              v-model="formData.area_type_id"
              :options="areaTypeList"
              id="area_type_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
        <ValidationProvider name="Division" vid="division_id">
            <b-form-group
                label-for="division_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.division')}}
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
        <ValidationProvider name="District" vid="district_id">
            <b-form-group
                label-for="district_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.district')}}
            </template>
            <b-form-select
                plain
                v-model="formData.district_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1">
        <ValidationProvider name="City Corporation" vid="city_corporation_id">
            <b-form-group
                label-for="city_corporation_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.city_corporation')}}
            </template>
            <b-form-select
                plain
                v-model="formData.city_corporation_id"
                :options="corporationList"
                id="city_corporation_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2 || formData.area_type_id === 3">
      <ValidationProvider name="Upazila" vid="upazila_id">
          <b-form-group
              label-for="upazila_id"
              slot-scope="{ valid, errors }"
          >
          <template v-slot:label>
              {{$t('globalTrans.upazila')}}
          </template>
          <b-form-select
              plain
              v-model="formData.upazila_id"
              :options="upazilaList"
              id="upazila_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 2">
        <ValidationProvider name="Pauroshoba" vid="pauroshoba_id">
            <b-form-group
                label-for="pauroshoba_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.pouroshova')}}
            </template>
            <b-form-select
                plain
                v-model="formData.pauroshoba_id"
                :options="pauroshobaList"
                id="pauroshoba_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 3">
        <ValidationProvider name="Union" vid="union_id">
            <b-form-group
                label-for="union_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.union')}}
            </template>
            <b-form-select
                plain
                v-model="formData.union_id"
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
    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="formData.area_type_id === 1 || formData.area_type_id === 2 || formData.area_type_id === 3">
        <ValidationProvider name="0" vid="ward_id">
            <b-form-group
                label-for="ward_id"
                slot-scope="{ valid, errors }"
            >
            <template v-slot:label>
                {{$t('globalTrans.ward')}}
            </template>
            <b-form-select
                plain
                v-model="formData.ward_id"
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
  </div>
</template>
<script>
export default {
  name: 'areaType',
  props: ['formData'],
  data () {
    return {
    }
  },
  watch: {
    'search.area_type_id': function (newVal, oldVal) {
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.corporationList = this.getcityCorporationList(newVal)
      } else {
        this.upazilaList = []
        this.corporationList = []
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.unionList = this.getUnionList(newVal)
          this.pauroshobaList = this.getPauroshobaList(newVal)
        } else {
          this.unionList = []
          this.pauroshobaList = []
        }
    },
    'search.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
        } else {
          this.wardList = []
        }
    },
    'search.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getPauroMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
    },
    'search.union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.wardList = this.getWardList(newVal)
          this.marketDirectoryList = this.getUniMarketList(newVal)
        } else {
          this.wardList = []
          this.marketDirectoryList = []
        }
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
    currentLocale () {
      return this.$i18n.locale
    },
    priceCategoryList () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  created () {
  },
  methods: {
    getMarketDirectoryList (marketIds) {
        const arr = []
        if (marketIds.constructor === Array) {
            marketIds.forEach(item => {
            const marketId = this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.find(obj => obj.value === item)
            const marketName = this.currentLocale === 'en' ? ' ' + marketId.text_en : ' ' + marketId.text_bn
            arr.push(marketName)
            })
        }
        return arr.toString()
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    getUpazilaList (id) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
    },
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUnionList (upazilaId) {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
    },
    getWardList (id) {
      return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
    },
    getPauroshobaList (id) {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getAreaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.area_type_id === id)
    },
    getDivMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.division_id === id)
    },
    getDisMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.district_id === id)
    },
    getUpaMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.upazila_id === id)
    },
    getUniMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.union_id === id)
    },
    getPauroMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.pauroshoba_id === id)
    },
    getCityMarketList (id) {
      return this.$store.state.BazarMonitoringService.commonObj.marketDirectoryList.filter(item => item.status === 1 && item.city_corporation_id === id)
    }
  }
}
</script>
