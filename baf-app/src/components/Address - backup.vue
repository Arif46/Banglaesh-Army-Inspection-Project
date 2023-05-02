<template>
    <div>
        <b-row :class="param.noMargin ? null : 'mt-4'">
            <!-- Area Type -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Area Type" vid="area_type_id" :rules="param.isAreaTypeNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="area_type_id"
                    >
                        <template v-slot:label>
                            {{$t('globalTrans.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.area_type_id"
                            :options="areaTypeList"
                            @change="getAreaTypeData(address.area_type_id)"
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

            <!-- Division -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Division" vid="division_id" :rules="param.isDivisionNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="division_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.division_id"
                            :options="divisionList"
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

            <!-- District -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="District" vid="district_id" :rules="param.isDistrictNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="district_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.district_id"
                            :options="districtList"
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

            <!-- City Corporation -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="CityCorpItemShow">
                <ValidationProvider name="City Corporation" vid="city_corporation_id" :rules="param.isCityCorporationNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="city_corporation_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.city_corporation') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.city_corporation_id"
                            :options="cityCorporationList"
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

            <!-- Upazila -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                <ValidationProvider name="Upazila" vid="upazila_id" :rules="param.isUpazilaNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="upazila_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.upazila')}} <span class="text-danger" v-if="!param.isUpazilaNullable">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.upazila_id"
                            :options="upazilaList"
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

            <!-- Pourashava -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="PauroshobaItemShow">
                <ValidationProvider name="Pourashava" vid="paurashava_id" :rules="param.isPaurashavaNullable ? '' : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="paurashava_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.pouroshova') }} <span class="text-danger" v-if="!param.isPaurashavaNullable">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.paurashava_id"
                            :options="municipalityList"
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

            <!-- Union -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="UnionItemShow">
                <ValidationProvider name="Union" vid="union_id" :rules="param.isUnionNullable ? null : 'required|min_value:1'" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="union_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.union')}} <span class="text-danger" v-if="!param.isUnionNullable">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="address.union_id"
                            :options="unionList"
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

            <!-- Ward -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="ItemShow">
                <ValidationProvider name="Ward" vid="ward_id" rules="" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="ward_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.ward') }}
                        </template>
                        <b-form-select
                            plain
                            v-model="address.ward_id"
                            :options="wardList"
                            @change="dataReturn"
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

            <!-- Ward -->
            <b-col :xl="param.xl" :lg="param.lg" :md="param.md" sm="12" v-if="ItemShow === true && param.hasPostCode === true">
                <ValidationProvider name="Post Code" vid="post_code" rules="" v-slot="{ errors }">
                    <b-form-group
                      class="row"
                      :label-cols-sm="param.labelCols"
                      label-for="post_code"
                    >
                        <template v-slot:label>
                            {{ $t('bazarMonitoring.post_code') }}
                        </template>
                        <b-form-input
                          plain
                          v-model="address.post_code"
                          @change="dataReturn"
                          :state="errors[0] ? false : (valid ? true : null)"
                          oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                        >
                        </b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <!-- Address Details -->
        <b-row v-if="addressType === 'address'">
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (En)" vid="address_details_en" v-slot="{ errors }">
                    <b-form-group
                        :label-cols-sm="param.labelCols"
                        label-for="address_details_en"
                    >
                    <template v-slot:label>
                        {{ $t('externalUser.address_details') + ' ' + $t('globalTrans.en')}}
                    </template>
                        <b-form-textarea
                        v-model="address.address_details_en"
                        @change="dataReturn"
                        rows="1"
                        max-rows="2"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                        {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
            <b-col v-if="!param.noAddress" :xl="param.xl" :lg="param.lg" :md="param.md" sm="12">
                <ValidationProvider name="Address Details (Bn)" vid="address_details_bn" v-slot="{ errors }">
                    <b-form-group
                        class="row"
                        :label-cols-sm="param.labelCols"
                        label-for="address_details_bn"
                    >
                        <template v-slot:label>
                            {{$t('externalUser.address_details') + ' ' + $t('globalTrans.bn')}}
                        </template>
                        <b-form-textarea
                            v-model="address.address_details_bn"
                            @change="dataReturn"
                            rows="1"
                            max-rows="2"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-textarea>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
    </div>
</template>
<script>
import { ValidationProvider } from 'vee-validate'

export default {
    props: ['data', 'addressType', 'param'],
    components: {
        ValidationProvider
    },
    data () {
        return {
            valid: null,
            ItemShow: false,
            CityCorpItemShow: false,
            PauroshobaItemShow: false,
            UnionItemShow: false,
            address: {
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0,
                ward_id: 0,
                post_code: '',
                address_details_en: '',
                address_details_bn: ''
            },
            districtList: [],
            cityCorporationList: [],
            upazilaList: [],
            municipalityList: [],
            unionList: [],
            wardList: [],
            tmpWardList: []
        }
    },
    watch: {
        'address.division_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.districtList = this.getDistrictList(newVal)
                this.dataReturn()
            }
        },
        'address.district_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.cityCorporationList = this.getCityCorporationList(newVal)
                this.upazilaList = this.getUpazilaList(newVal)
                this.dataReturn()
            }
        },
        'address.upazila_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.unionList = this.getUnionList(newVal)
                this.municipalityList = this.getPauroshobaList(newVal)
                this.dataReturn()
            }
        },
        'address.city_corporation_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByCityCorporation(newVal)
                this.dataReturn()
            }
        },
        'address.paurasabha_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByPauroshoba(newVal)
                this.dataReturn()
            }
        },
        'address.union_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.wardList = this.getWardListByUnion(newVal)
                this.dataReturn()
            }
        },
        currentLocale: function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.changeEnBn()
            }
        }
    },
    mounted () {
        if (this.data && Object.values(this.data).length > 0) {
            this.changesAreaTypes(this.data.area_type_id)
            this.address.area_type_id = this.data.area_type_id
            this.address.division_id = this.data.division_id
            this.address.district_id = this.data.district_id
            this.address.upazila_id = this.data.upazila_id
            this.address.city_corporation_id = this.data.city_corporation_id
            this.address.union_id = this.data.union_id
            this.address.ward_id = this.data.ward_id
            this.address.paurashava_id = this.data.paurashava_id
            this.address.address_details_en = this.data.address_details_en
            this.address.address_details_bn = this.data.address_details_bn
            this.dataReturn()
        }
    },
    computed: {
        areaTypeList: function () {
            return this.$store.state.commonObj.areaTypeList.map(el => {
                return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
            })
        },
        divisionList () {
            return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
        },
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        changeEnBn () {
            if (Object.values(this.address).length > 0) {
                this.districtList = this.getDistrictList(parseInt(this.address.division_id))
                this.cityCorporationList = this.getCityCorporationList(parseInt(this.address.district_id))
                this.upazilaList = this.getUpazilaList(parseInt(this.address.district_id))
                this.municipalityList = this.getPauroshobaList(parseInt(this.address.upazila_id))
                this.unionList = this.getUnionList(parseInt(this.address.upazila_id))
                if (this.address.area_type_id === 1) {
                    this.wardList = this.getWardListByCityCorporation(this.address.city_corporation_id)
                } else if (this.address.area_type_id === 2) {
                    this.wardList = this.getWardListByPauroshoba(this.address.city_corporation_id)
                } else {
                    this.wardList = this.getWardListByUnion(this.address.city_corporation_id)
                }
            }
        },
        dataReturn () {
            this.$emit('address-data', this.address)
        },
        reset () {
            this.address.city_corporation_id = 0
            this.address.upazila_id = 0
            this.address.paurashava_id = 0
            this.address.union_id = 0
            this.address.ward_id = 0
        },
        resetAll () {
          this.address.area_type_id = 0
          this.address.division_id = 0
          this.address.district_id = 0
          this.address.city_corporation_id = 0
          this.address.upazila_id = 0
          this.address.paurashava_id = 0
          this.address.union_id = 0
          this.address.ward_id = 0
          this.address.post_code = ''
          this.address.address_details_en = ''
          this.address.address_details_bn = ''
        },
        changesAreaTypes (typeId) {
            /**
             * 1 - City Corporation (City-Coporation, Ward)
             * 2 - Pauroshoba (Upazila, Pourosoba, Ward)
             * 3 - Union (Upazila, Pourosoba, Ward)
             */
            this.ItemShow = true
            if (typeId === 1) {
                this.ItemShow = true
                this.CityCorpItemShow = true
                this.PauroshobaItemShow = false
                this.UnionItemShow = false
            } else if (typeId === 2) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = true
                this.UnionItemShow = false
            } else if (typeId === 3) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = false
                this.UnionItemShow = true
            }
        },
        getAreaTypeData (typeId) {
            this.changesAreaTypes(typeId)
            this.reset()
        },
        getDistrictList (divisionId = null) {
            if (divisionId) {
                const objectData = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === divisionId)
                return objectData.map((obj, key) => {
                    if (this.$i18n.locale === 'bn') {
                        return { value: obj.value, text: obj.text_bn }
                    } else {
                        return { value: obj.value, text: obj.text_en }
                    }
                })
            } else {
                return []
            }
        },
        getCityCorporationList (districtId = null) {
            if (districtId) {
                return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
            } else {
                return []
            }
        },
        getUpazilaList (districtId = null) {
            if (districtId) {
                return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
            } else {
                return []
            }
        },
        getUnionList (upazillaId = null) {
            if (upazillaId) {
                return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazillaId)
            } else {
                return []
            }
        },
        getPauroshobaList (upazillaId = null) {
            if (upazillaId) {
                return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === upazillaId)
            } else {
                return []
            }
        },
        getWardListByCityCorporation (cityCorpId) {
            if (cityCorpId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.city_corporation_id === cityCorpId && item.status === 1)
            } else {
                return []
            }
        },
        getWardListByPauroshoba (pauroshobaId) {
            if (pauroshobaId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.paurashava_id === pauroshobaId && item.status === 1)
            } else {
                return []
            }
        },
        getWardListByUnion (unionId) {
            if (unionId) {
                return this.$store.state.CommonService.commonObj.wardList.filter(item => item.union_id === unionId && item.status === 1)
            } else {
                return []
            }
        }
    }
}
</script>
