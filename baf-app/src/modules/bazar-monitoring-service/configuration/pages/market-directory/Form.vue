<template>
    <div class="inner-section">
        <card>
            <template v-slot:searchHeaderTitle>
                <h4 class="card-title">{{ $t('bazarMonitoring.market_directory') }}</h4>
            </template>
            <template v-slot:searchHeaderAction>
                <router-link class="btn-add" to="market-directory"><i class="ri-arrow-left-line"></i> {{ $t('bazarMonitoring.market_directory') }} {{ $t('globalTrans.list') }}</router-link>
            </template>
            <b-container fluid>
                <b-row>
                    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                        <b-overlay :show="loading">
                            <!-- <template>
                                <div style="font-size:12px; background-color: #77a0cb; padding:6px; font-family: fantasy" class="mt-2">
                                    <h5 class="text-white text-left"> {{ $t('bazarMonitoring.market_directory') }}</h5>
                                    <p style="margin-top:-2%; font-size:16px; font-left:10px; font-family: fantasy" class="text-right"><router-link to="market-directory" :class="'text-light'"><b-badge pill variant="info">{{  $t('bazarMonitoring.market_directory') }} {{  $t('globalTrans.list') }}</b-badge></router-link></p>
                                </div>
                            </template> -->
                            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
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
                                                v-model="marketDirectory.area_type_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3" v-if="marketDirectory.area_type_id === 1 || marketDirectory.area_type_id === 2 || marketDirectory.area_type_id === 3">
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
                                                v-model="marketDirectory.division_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" class="mt-3" v-if="marketDirectory.area_type_id === 1 || marketDirectory.area_type_id === 2 || marketDirectory.area_type_id === 3">
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
                                                v-model="marketDirectory.district_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 1">
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
                                                v-model="marketDirectory.city_corporation_id"
                                                :options="cityCorporationList"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 2 || marketDirectory.area_type_id === 3">
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
                                                v-model="marketDirectory.upazila_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 2">
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
                                                v-model="marketDirectory.pauroshoba_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 3">
                                        <ValidationProvider name="Union" vid="union_id" rules="required|min_value:1">
                                            <b-form-group
                                                label-for="union_id"
                                                slot-scope="{ valid, errors }"
                                            >
                                            <template v-slot:label>
                                                {{$t('globalTrans.union')}} <span class="text-danger">*</span>
                                            </template>
                                            <b-form-select
                                                plain
                                                v-model="marketDirectory.union_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 1 || marketDirectory.area_type_id === 2 || marketDirectory.area_type_id === 3">
                                        <ValidationProvider name="Thana" vid="thana_id">
                                            <b-form-group
                                                label-for="thana_id"
                                                slot-scope="{ valid, errors }"
                                            >
                                            <template v-slot:label>
                                                {{$t('orgProfile.thana')}}
                                            </template>
                                            <b-form-select
                                                plain
                                                v-model="marketDirectory.thana_id"
                                                :options="thanaList"
                                                id="thana_id"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="marketDirectory.area_type_id === 1 || marketDirectory.area_type_id === 2 || marketDirectory.area_type_id === 3">
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
                                                v-model="marketDirectory.ward_id"
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
                                </b-row>
                                <b-row>
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                    <ValidationProvider name="Market Name (En)" vid="market_name_en" rules="required" v-slot="{ errors }">
                                            <b-form-group
                                            label-for="market_name_en">
                                            <template v-slot:label>
                                                {{ $t('bazarMonitoring.market_name')}} {{ $t('globalTrans.en')}} <span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="market_name_en"
                                                v-model="marketDirectory.market_name_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-input>
                                            <div class="invalid-feedback">
                                                {{ errors[0] }}
                                            </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                        <ValidationProvider name="Market Name (Bn)" vid="market_name_bn" rules="required" v-slot="{ errors }">
                                            <b-form-group
                                            label-for="market_name_bn">
                                            <template v-slot:label>
                                                {{ $t('bazarMonitoring.market_name')}} {{ $t('globalTrans.bn')}} <span class="text-danger">*</span>
                                            </template>
                                            <b-form-input
                                                id="market_name_bn"
                                                v-model="marketDirectory.market_name_bn"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-input>
                                            <div class="invalid-feedback">
                                                {{ errors[0] }}
                                            </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                        <ValidationProvider name="No of Essential Commodity Stall" vid="essential_commodity_stall" v-slot="{ errors }">
                                            <b-form-group
                                                label-for="alert_percentage">
                                                <template v-slot:label>
                                                {{ $t('bazarMonitoring.no_commodity_stall') }}
                                                </template>
                                                <b-form-input
                                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                id="essential_commodity_stall"
                                                v-model="marketDirectory.essential_commodity_stall"
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
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                        <ValidationProvider name="Post Code" vid="post_code" v-slot="{ errors }">
                                            <b-form-group
                                                label-for="post_code">
                                                <template v-slot:label>
                                                {{ $t('bazarMonitoring.post_code') }}
                                                </template>
                                                <b-form-input
                                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                                id="post_code"
                                                v-model="marketDirectory.post_code"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-input>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                        <ValidationProvider name="Description (En)" vid="description_en">
                                            <b-form-group
                                                label-for="description_en">
                                                <template v-slot:label>
                                                {{ $t('bazarMonitoring.description') }} {{ $t('globalTrans.en') }}
                                                </template>
                                                <b-form-textarea
                                                id="description_en"
                                                v-model="marketDirectory.description_en"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-textarea>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                    <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                                        <ValidationProvider name="Description (Bn)" vid="description_bn">
                                            <b-form-group
                                                label-for="description_bn">
                                                <template v-slot:label>
                                                {{ $t('bazarMonitoring.description') }} {{ $t('globalTrans.bn') }}
                                                </template>
                                                <b-form-textarea
                                                id="description_bn"
                                                v-model="marketDirectory.description_bn"
                                                :state="errors[0] ? false : (valid ? true : null)"
                                                ></b-form-textarea>
                                                <div class="invalid-feedback">
                                                {{ errors[0] }}
                                                </div>
                                            </b-form-group>
                                        </ValidationProvider>
                                    </b-col>
                                </b-row>
                                <b-row>
                                <b-col class="mt-3">
                                    <ValidationProvider name="Price Category" vid="price_category_id" rules="required" v-slot="{ errors }">
                                        <b-form-group
                                        class="row"
                                        label-cols-sm="3"
                                        label-for="price_category_id"
                                        >
                                        <template v-slot:label>
                                        {{ $t('bazarMonitoring.Price_category') }} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-checkbox-group
                                            v-model="marketDirectory.price_category_id"
                                            :options="priceCategoryList"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                            ></b-form-checkbox-group>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        </b-form-group>
                                    </ValidationProvider>
                                </b-col>
                                </b-row>
                                <template>
                                    <div style="font-size:12px; background-color: #77a0cb; padding:6px; font-family: fantasy" class="mt-2">
                                        <h5 class="text-white text-left"> {{ $t('bazarMonitoring.market_directory_google_map') }}</h5>
                                    </div>
                                </template>
                                <b-row>
                                    <b-col sm="12">
                                        <Map :center="center" v-on:child-method="updateParent"/>
                                    </b-col>
                                </b-row>
                                <b-row class="text-right mb-3">
                                    <b-col>
                                        <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                                        <router-link :to="{ path: '/bazar-monitoring-service/configuration/market-directory'}" class="btn btn-danger btn-sm">
                                            {{ $t('globalTrans.cancel') }}
                                        </router-link>
                                    </b-col>
                                </b-row>
                                <!-- <pre>{{marketDirectory.ward_id}}</pre> -->
                            </b-form>
                        </b-overlay>
                    </ValidationObserver>
                </b-row>
            </b-container>
        </card>
    </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { marketDirectoryStore, marketDirectoryUpdate } from '../../api/routes'
import Map from '@/components/Map.vue'

export default {
    components: {
        Map
    },
  name: 'Form',
  props: ['id'],
  data () {
    return {
        valid: null,
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        loading: false,
        center: [90.412, 23.76],
        marketDirectory: {
            area_type_id: 0,
            city_corporation_id: 0,
            pauroshoba_id: 0,
            division_id: 0,
            district_id: 0,
            upazila_id: 0,
            union_id: 0,
            ward_id: 0,
            thana_id: 0,
            post_code: '',
            market_name_en: '',
            market_name_bn: '',
            description_en: '',
            latitude: '',
            longitude: '',
            essential_commodity_stall: '',
            price_category_id: []
        },
        districtList: [],
        upazilaList: [],
        thanaList: [],
        unionList: [],
        wardList: [],
        pauroshobaList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getMarketDirectory()
      const arr = []
      tmp.price_categories.forEach(item => {
        arr.push(item.id)
      })
     this.marketDirectory = Object.assign({}, this.marketDirectory, tmp, { price_category_id: arr })
     this.marketDirectory.ward = 0
    }
  },
  mounted () {
    // if (this.$store.state.Auth.activeRoleId !== 1) {
    //   this.marketDirectory = Object.assign({}, this.marketDirectory, {
    //     area_type_id: this.addressCustomUser.area_type_id,
    //     city_corporation_id: this.addressCustomUser.city_corporation_id,
    //     pauroshoba_id: this.addressCustomUser.pauroshoba_id,
    //     division_id: this.addressCustomUser.division_id,
    //     district_id: this.addressCustomUser.district_id,
    //     upazila_id: this.addressCustomUser.upazila_id
    //   })
    // }
  },
  computed: {
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    priceCategoryList: function () {
      return this.$store.state.BazarMonitoringService.commonObj.priceCategoryList.filter(item => item.status === 1)
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
  watch: {
    'marketDirectory.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
            if (oldVal) {
                this.marketDirectory.district_id = 0
            }
      } else {
        this.districtList = []
      }
    },
    'marketDirectory.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList(newVal)
        this.thanaList = this.getThanaList(newVal)
        this.cityCorporationList = this.getcityCorporationList(newVal)
            if (oldVal) {
                this.marketDirectory.upazila_id = 0
                this.marketDirectory.thana_id = 0
            }
      } else {
        this.upazilaList = []
        this.thanaList = []
        this.cityCorporationList = []
      }
    },
    'marketDirectory.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.unionList = this.getUnionList(newVal)
            this.pauroshobaList = this.getPauroshobaList(newVal)
            if (oldVal) {
                this.marketDirectory.union_id = 0
                this.marketDirectory.pauroshoba_id = 0
            }
        } else {
           this.unionList = []
           this.pauroshobaList = []
        }
    },
    'marketDirectory.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardList(newVal)
            if (oldVal) {
                this.marketDirectory.ward_id = 0
            }
        } else {
           this.wardList = []
        }
    },
    'marketDirectory.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardList(newVal)
            if (oldVal) {
                this.marketDirectory.ward_id = 0
            }
        } else {
           this.wardList = []
        }
    },
    'marketDirectory.union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardList(newVal)
            if (oldVal) {
                this.marketDirectory.ward_id = 0
            }
        } else {
           this.wardList = []
        }
    }
  },
  methods: {
    updateParent (data) {
      this.center = data
    },
    getMarketDirectory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.loading = true
      this.marketDirectory.longitude = this.center[0]
      this.marketDirectory.latitude = this.center[1]
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${marketDirectoryUpdate}/${this.id}`, this.marketDirectory)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, marketDirectoryStore, this.marketDirectory)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push({ path: '/bazar-monitoring-service/configuration/market-directory' })
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
    getThanaList (id) {
      return this.$store.state.CommonService.commonObj.thanaList.filter(item => item.status === 1 && item.district_id === id)
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
    getcityCorporationList (id) {
      return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
    }
  }
}
</script>
