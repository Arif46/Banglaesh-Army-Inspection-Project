<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Registration No" vid="registration_no" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="registration_no">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.registration_no') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input
                  type="number"
                  min="1"
                  id="registration_no"
                  v-model="boughtLeafFactory.registration_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Factory Name (En)" vid="factory_name_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="factory_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.factory_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="factory_name_en"
                  v-model="boughtLeafFactory.factory_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Factory Name (Bn)" vid="factory_name_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="factory_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.factory_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="factory_name_bn"
                  v-model="boughtLeafFactory.factory_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Establishment Year" vid="year" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="year">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.establishment_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="year"
                  v-model="boughtLeafFactory.year"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Made Tea Type" vid="made_tea_type_id" rules="required|min_value:1">
              <b-form-group
              slot-scope="{ valid, errors }"
                label-for="made_tea_type_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.select_made_tea_type') }} <span class="text-danger">*</span>
                </template>
                  <v-select
                    id="made_tea_type_id"
                    v-model="boughtLeafFactory.made_tea_type_id"
                    multiple
                    :reduce="op => op.value"
                    :options="madeTeaType"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Factory Type" vid="factory_type_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="factory_type_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.factory_type') }}
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.factory_type_id"
                      :options="factoryType"
                      id="factory_type_id"
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
          <!-- area section start here -->
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="area_type_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.area_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.area_type_id"
                      id="area_type_id"
                      :options="getAreaTypeList"
                      @change="getAreaTypeData(boughtLeafFactory.area_type_id)"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="ItemShow">
            <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="division_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.division') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.division_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="ItemShow">
            <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="district_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.district') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.district_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="PauroshobaItemShow || UnionItemShow">
            <ValidationProvider name="District" vid="upazila_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="upazila_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.upazila') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.upazila_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="UnionItemShow">
            <ValidationProvider name="Union" vid="union_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="union_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.union') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.union_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="CityCorpItemShow">
            <ValidationProvider name="City Corporation" vid="city_corporation_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="city_corporation_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.city_corporation') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.city_corporation_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-show="PauroshobaItemShow">
            <ValidationProvider name="Municipality" vid="pauroshoba_id">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="pauroshoba_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.municipality_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="boughtLeafFactory.pauroshoba_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Has Own Garden" vid="has_own_garden" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="has_own_garden">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.has_own_garden') }}<span class="text-danger">*</span>
                </template>
                 <b-form-radio-group
                      :state="errors[0] ? false : (valid ? true : null)"
                       v-model="boughtLeafFactory.has_own_garden"
                       :options="manualList">
                  </b-form-radio-group>
                <div class="invalid-feedback d-block">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <!-- garden -->
           <b-col xs="12" sm="12" md="6" lg="6" xl="6" v-if="boughtLeafFactory.has_own_garden === 1">
              <ValidationProvider name="Garden Name" vid="garden_id" rules="required|min_value:1">
                <b-form-group
                  slot-scope="{ valid, errors }"
                  label-for="garden_id">
                  <template v-slot:label>
                    {{ $t('teaGardenConfig.garden_name') }} <span class="text-danger">*</span>
                  </template>
                  <v-select
                    id="garden_id"
                    plain
                    v-model="boughtLeafFactory.garden_id"
                    :options="teaGardenGenInfoList"
                    :reduce="op => op.value"
                    label="text"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select')"
                    >
                    </v-select>
                  <div class="invalid-feedback d-block">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Prod Capacity" vid="prod_capacity" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="prod_capacity">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.prod_capacity') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="prod_capacity"
                  v-model="boughtLeafFactory.prod_capacity"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Land Area" vid="land_area" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="land_area">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.land_area') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="land_area"
                  v-model="boughtLeafFactory.land_area"
                  type="number"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (En)" vid="address_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_en"
                  v-model="boughtLeafFactory.address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="address_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_bn"
                  v-model="boughtLeafFactory.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="boughtLeafFactory.description_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="boughtLeafFactory.description_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
              <ValidationProvider name="attachment" vid="attachment">
                <b-form-group slot-scope="{ valid, errors }" label-for="attachment">
                  <template v-slot:label>
                {{ $t('teaGardenConfig.attachment') }}
                </template>
                <div class="d-flex">
                <b-form-file
                  accept=".pdf, .docx, .doc"
                  id="attachment"
                  v-model="boughtLeafFactory.file"
                  @change="onFileChange"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :placeholder="$t('globalTrans.attachment_placeholder')"
                  :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')">
                </b-form-file>
                    <a target="_blank" style = "margin-left: 8px;" v-if="boughtLeafFactory.attachment && checkBase64(boughtLeafFactory.attachment) === false" :href="teaGardenServiceBaseUrl  + boughtLeafFactory.attachment" class="btn-white btn-success p-1" size="sm"><i class="ri-eye-line"></i></a>
                </div>
                <div class="invalid-feedback d-block">
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { boughtLeafFactoryStore, boughtLeafFactoryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      ItemShow: false,
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      boughtLeafFactory: {
        made_tea_type_id: [],
        factory_type_id: 2,
        garden_id: '',
        area_type_id: '0',
        city_corporation_id: '0',
        pauroshoba_id: '0',
        ward_id: '0',
        country_id: 1,
        division_id: '0',
        district_id: '0',
        upazila_id: '0',
        union_id: '0',
        has_own_garden: 2,
        registration_no: '',
        address_en: '',
        address_bn: '',
        attachment: '',
        file: []
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
        { value: 2, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
      ]
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getTeaCompany()
      this.boughtLeafFactory.oldfile = tmp.attachment
      this.boughtLeafFactory = tmp
      if (this.boughtLeafFactory.area_type_id === 1) {
          this.ItemShow = true
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
      } else if (this.boughtLeafFactory.area_type_id === 2) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
      } else if (this.boughtLeafFactory.area_type_id === 3) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
      }
      // parse school type
      this.boughtLeafFactory.made_tea_type_id = JSON.parse(this.boughtLeafFactory.made_tea_type_id)
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    madeTeaType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterMadeTeaTypeList.filter(item => item.status === 1)
    },
    factoryType: function () {
      return this.$store.state.TeaGardenService.commonObj.masterFactoryTypeList.filter(item => item.status === 1)
    },
    teaGardenGenInfoList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterTeaGardenGenInfoList.filter(item => item.status === 1)
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
    onFileChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.boughtLeafFactory.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.boughtLeafFactory.attachment = ''
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
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${boughtLeafFactoryUpdate}/${this.id}`, this.boughtLeafFactory)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, boughtLeafFactoryStore, this.boughtLeafFactory)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getTeaCompany () {
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
    checkBase64 (string) {
        var result = ''
        result = string.match('data:')
        if (result) {
            return true
        } else {
            return false
        }
    }
  },
  watch: {
    'boughtLeafFactory.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'boughtLeafFactory.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'boughtLeafFactory.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'boughtLeafFactory.city_corporation_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
    },
    'boughtLeafFactory.pauroshoba_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByPauroshoba(newVal)
    },
    'boughtLeafFactory.union_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByUnion(newVal)
    }
  }
}
</script>
