<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="factoryInfo"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.factory_info_label')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                               <!-- factory name  -->
                                               <b-col sm="6">
                                                <ValidationProvider name="Factory Name (En)" vid="factory_name_en" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="factory_name_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.proposed_factory_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="factory_info.factory_name_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                               <b-col sm="6">
                                                <ValidationProvider name="Factory Name (Bn)" vid="factory_name_bn" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="factory_name_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.proposed_factory_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="factory_info.factory_name_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                            <!-- area section start here -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="area_type_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.area_type_id"
                                                            id="area_type_id"
                                                            :options="getAreaTypeList"
                                                            @change="getAreaTypeData(factory_info.area_type_id)"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="division_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.division_id"
                                                            id="division_id"
                                                            :options="divisionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="district_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.district_id"
                                                            id="district_id"
                                                            :options="districtList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="PauroshobaItemShow || UnionItemShow">
                                                <ValidationProvider name="District" vid="upazila_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="upazila_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.upazila') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.upazila_id"
                                                            id="upazila_id"
                                                            :options="upazilaList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="UnionItemShow">
                                                <ValidationProvider name="Union" vid="union_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="union_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.union') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.union_id"
                                                            id="union_id"
                                                            :options="unionList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="CityCorpItemShow">
                                                <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="city_corporation_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.city_corporation') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.city_corporation_id"
                                                            id="city_corporation_id"
                                                            :options="cityCorporationList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                            <b-col sm="6" v-show="PauroshobaItemShow">
                                                <ValidationProvider name="Municipality" vid="paurashoba_id">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="paurashoba_id">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenConfig.municipality_name') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="factory_info.paurashoba_id"
                                                            id="paurashoba_id"
                                                            :options="municipalityList"
                                                            :state="errors[0] ? false : (valid ? true : null)">
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
                                              <!-- address  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Address (En)" vid="address_en" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="address_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="factory_info.address_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <b-col sm="6">
                                                <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="address_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="text"
                                                            v-model="factory_info.address_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <!-- establishment year  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Establishment Year" vid="established_year" rules="required">
                                                    <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                        label-for="established_year">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.established_year') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            v-model="factory_info.established_year"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <!-- total land  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Total Land Quantity" vid="total_land_factory_established" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="total_land_factory_established">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_land_factory_established') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            v-model="factory_info.total_land_factory_established"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <!-- production capacity  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Production Capacity" vid="production_capacity" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="production_capacity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.production_capacity') }} ({{ $t('globalTrans.kg') }}) <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            v-model="factory_info.production_capacity"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <!-- Source of funding  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Source of Funding (En)" vid="source_of_funding_en" v-slot="{ errors }">
                                                    <b-form-group
                                                        label-for="source_of_funding_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.source_of_funding') }} {{ $t('globalTrans.en') }}
                                                        </template>
                                                        <b-form-input
                                                            type="text"
                                                            v-model="factory_info.source_of_funding_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <b-col sm="6">
                                                <ValidationProvider name="Source of Funding (Bn)" vid="source_of_funding_bn" v-slot="{ errors }">
                                                    <b-form-group
                                                        label-for="source_of_funding_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.source_of_funding') }} {{ $t('globalTrans.bn') }}
                                                        </template>
                                                        <b-form-input
                                                            type="text"
                                                            v-model="factory_info.source_of_funding_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                              </b-col>
                                              <!-- area's of tea  -->
                                              <b-col sm="6">
                                                <ValidationProvider name="Processed Area" vid="processed_area" v-slot="{ errors }">
                                                    <b-form-group
                                                        label-for="processed_area">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.processed_area') }}
                                                        </template>
                                                        <v-select
                                                            id="processed_area"
                                                            v-model="factory_info.processed_area"
                                                            multiple
                                                            :reduce="op => op.value"
                                                            :options="districtListForProposedArea"
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
                                    </b-form-group>
                                </b-card>
                            </div>
                        </b-col>
                    </b-row>
                </b-overlay>
            </b-form>
        </ValidationObserver>
    </b-col>
</b-row>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { factoryInfoStoreApi } from '../../api/routes'
import { mapGetters } from 'vuex'
export default {
    props: ['app_id', 'factoryInfoData', 'allData', 'isRenew'],
    data () {
      return {
        ItemShow: false,
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        CityCorpItemShow: false,
        PauroshobaItemShow: false,
        UnionItemShow: false,
        factory_info: {
            btb_tea_factory_reg_main_id: 0,
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            country_id: 1,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            processed_area: [],
            factory_name_en: null,
            factory_name_bn: null
        },
        districtList: [],
        upazilaList: [],
        unionList: [],
        cityCorporationList: [],
        municipalityList: [],
        districtListForProposedArea: [],
        valid: null,
        loading: false,
        editIndex: '',
        manualList: [
            { value: 1, text: this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes' },
            { value: 2, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
        ]
      }
    },
    computed: {
        ...mapGetters({
            authUser: 'Auth/authUser'
        }),
        currentLocale () {
            return this.$i18n.locale
        },
        divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        getAreaTypeList: function () {
            const objectData = this.$store.state.commonObj.areaTypeList
            return objectData.map((obj, key) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.value, text: obj.text_bn }
                } else {
                    return { value: obj.value, text: obj.text_en }
                }
            })
        }
    },
    methods: {
        async submit () {
                var check = await this.$refs.factoryInfo.validate()
                if (check) {
                this.loading = true
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const loadingState = { loading: false, listReload: false }
                this.factory_info.app_id = this.app_id
                const result = await RestApi.postData(teaGardenServiceBaseUrl, factoryInfoStoreApi, this.factory_info)
                loadingState.listReload = true
                this.$store.dispatch('mutateCommonProperties', loadingState)
                this.loading = false
                if (result.success) {
                    this.$toast.success({
                    title: 'Success',
                    message: this.app_id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                    })
                    return result
                } else {
                    this.$refs.factoryInfo.setErrors(result.errors)
                    this.$toast.error({
                    title: this.$t('globalTrans.error'),
                    message: this.$t('globalTrans.form_error_msg'),
                    color: '#ee5253'
                    })
                }
                }
        },
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
        getDistrictList (id) {
          return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
        },
        getUpazilaList (id) {
        return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
        },
        getUnionList (upazilaId) {
        return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
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
            return objectData.map((obj, key) => {
                if (this.$i18n.locale === 'bn') {
                    return { value: obj.value, text: obj.text_bn }
                } else {
                    return { value: obj.value, text: obj.text_en }
                }
            })
        },
        getDistrictListForProposedArea (divisionId) {
            this.districtListForProposedArea = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === divisionId)
        },
        getGardenDivisionId (id) {
            var gardenInfo
            if (this.authUser.user_type === 1) {
                gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            } else {
                gardenInfo = this.$store.state.ExternalUserService.teaGarden.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            }
            if (gardenInfo) {
                return gardenInfo.division_id
            }
        },
        gardenNameSetForFactoryName (id) {
            var gardenInfo
            if (this.authUser.user_type === 1) {
                gardenInfo = this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            } else {
                gardenInfo = this.$store.state.ExternalUserService.teaGarden.commonObj.masterTeaGardenGenInfoList.find(item => item.value === id)
            }
            if (this.factory_info.factory_name_en === null) {
                this.factory_info.factory_name_en = gardenInfo.text_en
            }
            if (this.factory_info.factory_name_bn === null) {
                this.factory_info.factory_name_bn = gardenInfo.text_bn
            }
        }
    },
    watch: {
    'factory_info.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'factory_info.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'factory_info.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    currentLocale: function () {
        if (this.allData.factory_type_id === 1 && this.allData.garden_id) {
            const divisionId = this.getGardenDivisionId(this.allData.garden_id)
            if (divisionId) {
                this.getDistrictListForProposedArea(divisionId)
            }
        } else if (this.allData.factory_type_id === 2 || this.allData.factory_type_id === 3) {
            this.getDistrictListForProposedArea(this.allData.division_id)
        }
    }
    },
    created () {
        this.factory_info = this.factoryInfoData
        if (this.$route.query.id) {
            if (this.factory_info.area_type_id === 1) {
            this.ItemShow = true
            this.CityCorpItemShow = true
            this.PauroshobaItemShow = false
            this.UnionItemShow = false
            } else if (this.factory_info.area_type_id === 2) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = true
                this.UnionItemShow = false
            } else if (this.factory_info.area_type_id === 3) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = false
                this.UnionItemShow = true
            }
        }
        // district list get for proposed area
        // factory_type_id = 1  Garden Factory
        // factory_type_id = 2,3 Bought Leaf Factory and Cooperative Factory
        if (this.allData.factory_type_id === 1 && this.allData.garden_id) {
            const divisionId = this.getGardenDivisionId(this.allData.garden_id)
            if (divisionId) {
                this.getDistrictListForProposedArea(divisionId)
            }
            // garden name set for factory name
            this.gardenNameSetForFactoryName(this.allData.garden_id)
        } else if (this.allData.factory_type_id === 2 || this.allData.factory_type_id === 3) {
            this.getDistrictListForProposedArea(this.allData.division_id)
        }
    }
}
</script>
