<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="garden_info"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                  <b-row>
                      <b-overlay :show="garden_loaded && garden_id !== 0">
                         <b-col sm="5">
                            <ValidationProvider name="Garden Name" vid="garden_id" rules="required">
                              <b-form-group
                                  slot-scope="{ valid, errors }"
                                  label-for="garden_id">
                                  <template v-slot:label>
                                      {{ $t('teaGardenConfig.select_garden') }}<span class="text-danger">*</span>
                                  </template>
                                  <b-form-select
                                      :disabled="isGardenAdmin"
                                      plain
                                      v-model="garden_id"
                                      id="garden_id"
                                      :options="getGardenList"
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
                        <b-col sm="12" v-if="!garden_loaded">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenConfig.garden_info')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <!-- general info  -->
                                            <b-col sm="6">
                                              <ValidationProvider name="Registration No" vid="registration_no_en" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.registration_no') }}
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.registration_no_en"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                                  </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Garden Name" vid="tea_garden_name_en" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.garden_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.tea_garden_name_en"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                                  </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Garden Name" vid="tea_garden_name_bn" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.garden_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.tea_garden_name_bn"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                                  </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Owner Name (En)" vid="owner_name_en" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.owner_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.owner_name_en"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                                  </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Owner Name" vid="owner_name_bn" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.owner_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.owner_name_bn"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
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
                                                        disabled
                                                        plain
                                                        v-model="application.area_type_id"
                                                        id="area_type_id"
                                                        :options="getAreaTypeList"
                                                        @change="getAreaTypeData(application.area_type_id)"
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="division_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.division_id"
                                                        id="division_id"
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
                                            <b-col sm="6" v-show="ItemShow">
                                                <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="district_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.district_id"
                                                        id="district_id"
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
                                            <b-col sm="6" v-show="PauroshobaItemShow || UnionItemShow">
                                                <ValidationProvider name="District" vid="upazila_id">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="upazila_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.upazila') }}
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.upazila_id"
                                                        id="upazila_id"
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
                                            <b-col sm="6" v-show="UnionItemShow">
                                                <ValidationProvider name="Union" vid="union_id">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="union_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.union') }}
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.union_id"
                                                        id="union_id"
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
                                            <b-col sm="6" v-show="CityCorpItemShow">
                                                <ValidationProvider name="City Corporation" vid="city_corporation_id">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="city_corporation_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.city_corporation') }}
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.city_corporation_id"
                                                        id="city_corporation_id"
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
                                            <b-col sm="6" v-show="PauroshobaItemShow">
                                                <ValidationProvider name="Municipality" vid="pauroshoba_id">
                                                <b-form-group
                                                    slot-scope="{ valid, errors }"
                                                    label-for="pauroshoba_id">
                                                    <template v-slot:label>
                                                    {{ $t('teaGardenConfig.municipality_name') }}
                                                    </template>
                                                    <b-form-select
                                                        disabled
                                                        plain
                                                        v-model="application.pauroshoba_id"
                                                        id="pauroshoba_id"
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
                                            <!-- area section end  -->
                                            <b-col sm="6">
                                              <ValidationProvider name="Garden Address (En)" vid="garden_address_en" rules="required">
                                                  <b-form-group
                                                  slot-scope="{ valid, errors }"
                                                  label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.garden_address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.garden_address_en"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
                                                  <div class="invalid-feedback">
                                                      {{ errors[0] }}
                                                  </div>
                                                  </b-form-group>
                                              </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                              <ValidationProvider name="Garden Address (Bn)" vid="garden_address_bn" rules="required">
                                                  <b-form-group
                                                      slot-scope="{ valid, errors }"
                                                      label-for="clone_class_en">
                                                  <template v-slot:label>
                                                      {{ $t('teaGardenConfig.garden_address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                  </template>
                                                  <b-form-input
                                                      disabled
                                                      id="clone_class_en"
                                                      v-model="application.garden_address_bn"
                                                      :state="errors[0] ? false : (valid ? true : null)"
                                                  ></b-form-input>
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
                      </b-overlay>
                  </b-row>
                </b-overlay>
            </b-form>
        </ValidationObserver>
    </b-col>
</b-row>
</template>
<script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { gardenInfoDetails } from '../../api/routes'
  import { mapGetters } from 'vuex'
  export default {
      props: ['app_id', 'gardenInfoData', 'garden_id_set', 'isShow', 'isGardenAdmin', 'baseUrl'],
      name: 'GardenInfo',
      data () {
        return {
              ItemShow: false,
              teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
              CityCorpItemShow: false,
              PauroshobaItemShow: false,
              UnionItemShow: false,
              fieldObj: {
                  xl: 6,
                  lg: 6,
                  md: 6,
                  sm: 12,
                  labelCols: 5,
                  noAddress: false
              },
              application: {
                app_id: 0,
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0
              },
              garden_id: 0,
              valid: null,
              loading: false,
              districtList: [],
              upazilaList: [],
              unionList: [],
              cityCorporationList: [],
              municipalityList: [],
              garden_loaded: true
          }
      },
      created () {
          this.application = this.gardenInfoData
          this.garden_id = this.garden_id_set
          if (this.$route.query.id) {
              if (this.application.area_type_id === 1) {
              this.ItemShow = true
              this.CityCorpItemShow = true
              this.PauroshobaItemShow = false
              this.UnionItemShow = false
              } else if (this.application.area_type_id === 2) {
                  this.ItemShow = true
                  this.CityCorpItemShow = false
                  this.PauroshobaItemShow = true
                  this.UnionItemShow = false
              } else if (this.application.area_type_id === 3) {
                  this.ItemShow = true
                  this.CityCorpItemShow = false
                  this.PauroshobaItemShow = false
                  this.UnionItemShow = true
              }
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
          },
          getGardenList () {
            return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
          }
      },
      methods: {
        async submit () {
            this.loading = true
            this.loading = false
            return true
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
        async getGardenInfo (id) {
                this.garden_loaded = true
                const result = await RestApi.getData(teaGardenServiceBaseUrl, gardenInfoDetails, { garden_id: id })
                if (result.success) {
                    this.application = result.data
                    this.garden_loaded = false
                } else {
                    this.garden_loaded = true
                }
        }
      },
      watch: {
      garden_id: function (newVal, oldVal) {
         if (newVal !== 0) {
            this.getGardenInfo(newVal)
            this.$emit('change-garden', newVal)
         }
      },
      'application.area_type_id': function (newVal, oldVal) {
        this.getAreaTypeData(newVal)
      },
      'application.division_id': function (newVal, oldVal) {
          this.districtList = this.getDistrictList(newVal)
      },
      'application.district_id': function (newVal, oldVal) {
          this.cityCorporationList = this.getCityCorporationList(newVal)
          this.upazilaList = this.getUpazilaList(newVal)
      },
      'application.upazila_id': function (newVal, oldVal) {
          this.unionList = this.getUnionList(newVal)
          this.municipalityList = this.getPauroshobaList(newVal)
      }
    }
  }
  </script>
