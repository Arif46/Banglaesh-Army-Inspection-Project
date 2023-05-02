<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="6">
                            <ValidationProvider name="Garden Name (En)" vid="garden_name_en" rules="required">
                                <b-form-group
                                    slot-scope="{ valid, errors }"
                                    label-for="garden_name_en">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.garden_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        :disabled="isRenew"
                                        v-model="application.garden_name_en"
                                        :state="errors[0] ? false : (valid ? true : null)">
                                    </b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="6">
                            <ValidationProvider name="Garden Name (Bn)" vid="garden_name_bn" rules="required">
                                <b-form-group
                                    slot-scope="{ valid, errors }"
                                    label-for="garden_name_bn">
                                    <template v-slot:label>
                                        {{ $t('teaGardenPanel.garden_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        :disabled="isRenew"
                                        v-model="application.garden_name_bn"
                                        :state="errors[0] ? false : (valid ? true : null)">
                                    </b-form-input>
                                    <div class="invalid-feedback">
                                        {{ errors[0] }}
                                    </div>
                                </b-form-group>
                            </ValidationProvider>
                        </b-col>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.location')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
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
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.division_id"
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
                                                            v-model="application.district_id"
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
                                                            {{ $t('teaGardenConfig.upazila') }}
                                                        </template>
                                                        <b-form-select
                                                            :disabled="isRenew"
                                                            plain
                                                            v-model="application.upazila_id"
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
                                                            v-model="application.union_id"
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
                                                            v-model="application.city_corporation_id"
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
                                                            v-model="application.paurashoba_id"
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
                                            <!-- area section end  -->
                                            <b-col sm="6">
                                                <ValidationProvider name="Distance From Upzilla (km)" vid="distance_from_upzilla" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="distance_from_upzilla">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.distance_from_upzilla') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            :disabled="isRenew"
                                                            type="number"
                                                            min="0"
                                                            v-model="application.distance_from_upzilla"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Total Land Quantity (Acre)" vid="total_land_quantity" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="total_land_quantity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_land_quantity') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            min="0"
                                                            v-model="application.total_land_quantity"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Land Quantity Under Cultivation (Acre)" vid="total_cultivation_land_quantity" :rules="'required|min_value:0|max_value:'+ application.total_land_quantity">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="total_cultivation_land_quantity">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.total_cultivation_land_quantity') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            type="number"
                                                            min="0"
                                                            v-model="application.total_cultivation_land_quantity"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
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
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.land_schedule')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mouja (En)" vid="mouja_en" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="mouja_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.mouja') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            v-model="application.mouja_en"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mouja (Bn)" vid="mouja_bn" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="mouja_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.mouja') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            v-model="application.mouja_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Khotian" vid="khotian" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="khotian">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.khotian') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            v-model="application.khotian"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Dag No" vid="dag_no" rules="required">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="dag_no">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.dag_no') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input
                                                            v-model="application.dag_no"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
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
import { teaFarmerApplicationGenInfoStoreApi } from '../../api/routes'
import { mapGetters } from 'vuex'
export default {
    props: ['app_id', 'basisFormData', 'isShow', 'baseUrl', 'isRenew'],
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
            parent_id: null,
            app_id: 0,
            user_id: 0,
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0,
            total_land_quantity: 0,
            total_cultivation_land_quantity: 0,
            owner_info: { // Table Name: small_tea_farmer_reg_owner_infos
                area_type_id: 0,
                division_id: 0,
                district_id: 0,
                city_corporation_id: 0,
                paurashava_id: 0,
                upazila_id: 0,
                union_id: 0
                }
            },
            valid: null,
            loading: false,
            districtList: [],
            upazilaList: [],
            unionList: [],
            cityCorporationList: [],
            municipalityList: []
        }
    },
    created () {
        this.application = this.basisFormData
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
        }
    },
    methods: {
      async submit () {
          var check = await this.$refs.form.validate()
          if (check) {
              this.loading = true
              this.$store.dispatch('mutateCommonProperties', { loading: true })
              const loadingState = { loading: false, listReload: false }
              this.application.app_id = this.app_id
              if (this.$route.params.parent_id) {
                this.application.parent_id = this.$route.params.parent_id
              } else {
                this.application.parent_id = null
              }
              const result = await RestApi.postData(teaGardenServiceBaseUrl, teaFarmerApplicationGenInfoStoreApi, this.application)
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
        }
    },
    watch: {
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

<style>

</style>
