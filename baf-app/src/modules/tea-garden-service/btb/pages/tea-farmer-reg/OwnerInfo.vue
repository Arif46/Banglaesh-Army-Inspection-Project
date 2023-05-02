<template>
  <b-row>
    <b-col md="12">
        <ValidationObserver ref="ownerInfo"  v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset">
                <b-overlay :show="loading">
                    <b-row>
                        <b-col sm="12">
                            <div class="group-form-card">
                                <b-card>
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.owner_contact_address_label')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
                                        <b-row>
                                            <b-col sm="6">
                                                <ValidationProvider name="Owner's Name (En)" vid="owner_name_en" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="owner_name_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.owner_name_en" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Owner's Name (Bn)" vid="owner_name_bn" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="owner_name_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.owner_name_bn" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Father's Name (En)" vid="father_name_en" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="father_name_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_father_name') }} {{ $t('globalTrans.en') }} <span
                                                            class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.father_name_en" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Father's Name (Bn)" vid="father_name_bn" rules="required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="father_name_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_father_name') }} {{ $t('globalTrans.bn') }} <span
                                                            class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.father_name_bn" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Owner's NID No" vid="owner_nid" rules="required|min:10|max:17">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="owner_nid">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_nid') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" type="number" v-model="owner_info.owner_nid" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Email" vid="owner_email" rules="required|email">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="owner_email">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_email') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.owner_email" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Mobile" vid="owner_mobile" rules="numeric|required">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="owner_mobile">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.owner_mobile') }} <span class="text-danger">*</span>
                                                        </template>
                                                        <b-form-input :disabled="isRenew" type="number" min="0" v-model="owner_info.owner_mobile" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                            </b-col>
                                            <b-col sm="6">
                                                <ValidationProvider name="Land Ownership" vid="land_ownership" rules="required|min_value:1">
                                                    <b-form-group slot-scope="{ valid, errors }" label-for="land_ownership">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.land_ownership') }}<span class="text-danger"> * </span>
                                                        </template>
                                                        <b-form-radio-group :disabled="isRenew" :state="errors[0] ? false : (valid ? true : null)" v-model="owner_info.land_ownership" :options="manualList"></b-form-radio-group>
                                                        <div class="invalid-feedback d-block">
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
                                    <b-form-group label-cols-lg="3" :label="$t('teaGardenPanel.owner_address')" label-size="lg" label-class="font-weight-bold pt-0" class="mb-0">
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
                                                            v-model="owner_info.area_type_id"
                                                            id="area_type_id"
                                                            :options="getAreaTypeList"
                                                            @change="getAreaTypeData(owner_info.area_type_id)"
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
                                                            v-model="owner_info.division_id"
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
                                                            v-model="owner_info.district_id"
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
                                                            v-model="owner_info.upazila_id"
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
                                                            v-model="owner_info.union_id"
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
                                                            v-model="owner_info.city_corporation_id"
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
                                                            v-model="owner_info.paurashoba_id"
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
                                                <ValidationProvider name="Post Office (En)" vid="post_office_en">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="post_office_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.post_office') }} {{ $t('globalTrans.en') }}
                                                        </template>
                                                        <b-form-input :disabled="isRenew"
                                                            v-model="owner_info.post_office_en"
                                                            :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                          </b-col>
                                          <b-col sm="6">
                                                <ValidationProvider name="Owner's Name (Bn)" vid="post_office_bn">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="post_office_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.post_office') }} {{ $t('globalTrans.bn') }}
                                                        </template>
                                                        <b-form-input :disabled="isRenew"
                                                            v-model="owner_info.post_office_bn"
                                                            :state="errors[0] ? false : (valid ? true : null)">
                                                        </b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                          </b-col>
                                          <b-col sm="6">
                                                <ValidationProvider name="Village (En)" vid="village_en">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="village_en">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.village') }} {{ $t('globalTrans.en') }}
                                                        </template>
                                                        <b-form-input :disabled="isRenew"
                                                            v-model="owner_info.village_en"
                                                            :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                                                        <div class="invalid-feedback">
                                                            {{ errors[0] }}
                                                        </div>
                                                    </b-form-group>
                                                </ValidationProvider>
                                          </b-col>
                                          <b-col sm="6">
                                                <ValidationProvider name="Village (Bn)" vid="village_bn">
                                                    <b-form-group
                                                        slot-scope="{ valid, errors }"
                                                        label-for="village_bn">
                                                        <template v-slot:label>
                                                            {{ $t('teaGardenPanel.village') }} {{ $t('globalTrans.bn') }}
                                                        </template>
                                                        <b-form-input :disabled="isRenew" v-model="owner_info.village_bn" :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
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
import { teaFarmerApplicationOwnerInfoStoreApi } from '../../api/routes'
export default {
    props: ['app_id', 'ownerInfoData', 'draft', 'isRenew'],
    data () {
      return {
        ItemShow: false,
        teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
        CityCorpItemShow: false,
        PauroshobaItemShow: false,
        UnionItemShow: false,
        owner_info: { // Table Name: small_tea_farmer_reg_owner_infos
            area_type_id: 0,
            division_id: 0,
            district_id: 0,
            city_corporation_id: 0,
            paurashava_id: 0,
            upazila_id: 0,
            union_id: 0
        },
        districtList: [],
        upazilaList: [],
        unionList: [],
        cityCorporationList: [],
        municipalityList: [],
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
            var check = await this.$refs.ownerInfo.validate()
            if (check) {
              this.loading = true
              this.$store.dispatch('mutateCommonProperties', { loading: true })
              const loadingState = { loading: false, listReload: false }
              this.owner_info.app_id = this.app_id
              this.owner_info.draft = this.draft
              const result = await RestApi.postData(teaGardenServiceBaseUrl, teaFarmerApplicationOwnerInfoStoreApi, this.owner_info)
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
                this.$refs.ownerInfo.setErrors(result.errors)
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
    'owner_info.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'owner_info.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'owner_info.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    }
  },
    created () {
        this.owner_info = this.ownerInfoData
        if (this.$route.query.id) {
            if (this.owner_info.area_type_id === 1) {
            this.ItemShow = true
            this.CityCorpItemShow = true
            this.PauroshobaItemShow = false
            this.UnionItemShow = false
            } else if (this.owner_info.area_type_id === 2) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = true
                this.UnionItemShow = false
            } else if (this.owner_info.area_type_id === 3) {
                this.ItemShow = true
                this.CityCorpItemShow = false
                this.PauroshobaItemShow = false
                this.UnionItemShow = true
            }
        }
    }
}
</script>
