<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Broker Name (En)" vid="broker_name_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="broker_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.broker_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="broker_name_en"
                  v-model="broker.broker_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Broker Name (Bn)" vid="broker_name_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="broker_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.broker_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="broker_name_bn"
                  v-model="broker.broker_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Zone" vid="zone_id" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="zone_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.zone') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="broker.zone_id"
                      :options="getZoneList"
                      id="zone_id"
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
                      v-model="broker.area_type_id"
                      id="area_type_id"
                      :options="getAreaTypeList"
                      @change="getAreaTypeData(broker.area_type_id)"
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
                      v-model="broker.division_id"
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
                      v-model="broker.district_id"
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
                      v-model="broker.upazila_id"
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
                      v-model="broker.union_id"
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
                      v-model="broker.city_corporation_id"
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
                      v-model="broker.pauroshoba_id"
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
                  v-model="broker.address_en"
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
                  v-model="broker.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Owner Name (En)" vid="owner_name_en" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="owner_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.owner_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="owner_name_en"
                  v-model="broker.owner_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Owner Name (Bn)" vid="owner_name_bn" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="owner_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.owner_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="owner_name_bn"
                  v-model="broker.owner_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Contact No." vid="contact_no" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="contact_no">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.contact_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_no"
                  v-model="broker.contact_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="email" vid="email" rules="required|email" v-slot="{ errors }">
              <b-form-group
                label-for="email">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.email') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email"
                  v-model="broker.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Broker Registration No" vid="registration_no" rules="required">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="registration_no">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.broker') }}  {{ $t('teaGardenConfig.registration_no') }}  <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="registration_no"
                  v-model="broker.registration_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Establishment Year" vid="year" rules="required|min_value:1">
              <b-form-group
                slot-scope="{ valid, errors }"
                label-for="year ">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.establishment_year') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                      plain
                      v-model="broker.year"
                      :options="yearList"
                      id="year "
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Description (En)" vid="description_en">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.broker') }} {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="description_en"
                  v-model="broker.description_en"
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
                  {{ $t('teaGardenConfig.broker') }} {{ $t('teaGardenConfig.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="description_bn"
                  v-model="broker.description_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="reg_paper">
              <b-form-group
                label-for="reg_paper">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.broker') }}  {{ $t('teaGardenConfig.registration') }} {{ $t('teaGardenConfig.paper') }}
                </template>
              <b-form-file id="reg_paper"
              v-model="broker.file"
              v-on:change="onFileChange"
              accept="image/*"
              class="mt-2" plain
              :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <!-- <b-col sm="12" v-if="id != 0 && broker.reg_paper != null">
            <a target="_blank" :href="teaGardenServiceBaseUrl + 'storage/' + broker.reg_paper" class="text-muted"><i class="ri-cloud-fill"></i> {{ $t('globalTrans.attachment') }}</a>
          </b-col> -->
        </b-col>
        <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="photo">
              <b-form-group
                label-for="photo">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.owner') }}  {{ $t('globalTrans.photo') }}
                </template>
              <b-form-file id="photo"
              v-model="broker.file"
              v-on:change="onFileChange2"
              accept="image/*"
              class="mt-2" plain
              :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-file>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
            <!-- <b-col sm="12" v-if="id != 0 && broker.photo != null">
            <a target="_blank" :href="teaGardenServiceBaseUrl + 'storage/' + broker.photo" class="text-muted"><i class="ri-cloud-fill"></i> {{ $t('globalTrans.attachment') }}</a>
          </b-col> -->
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
import { brokersInfoStoreApi, brokersInfoUpdateApi } from '../../api/routes'
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
      broker: {
        broker_name_en: '',
        broker_name_bn: '',
        zone_id: 0,
        area_type_id: '0',
        city_corporation_id: '0',
        pauroshoba_id: '0',
        ward_id: '0',
        country_id: 1,
        division_id: '0',
        district_id: '0',
        upazila_id: '0',
        union_id: '0',
        year: '',
        registration_no: '',
        address_en: '',
        address_bn: '',
        contact_no: '',
        owner_name_bn: '',
        owner_name_en: '',
        email: '',
        reg_paper: '',
        photo: '',
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
      officeList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getTeaCompany()
      this.broker.oldfile = tmp.reg_paper
      this.broker = tmp
      if (this.broker.area_type_id === 1) {
          this.ItemShow = true
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
          this.UnionItemShow = false
      } else if (this.broker.area_type_id === 2) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
          this.UnionItemShow = false
      } else if (this.broker.area_type_id === 3) {
          this.ItemShow = true
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
          this.UnionItemShow = true
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
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
    getZoneList: function () {
      const objectData = this.$store.state.TeaGardenService.commonObj.zoneList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
      })
    },
    yearList: function () {
        return this.$store.state.TeaGardenService.commonObj.yearList.map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item, text: this.$n(item, { useGrouping: false }) }
          } else {
              return item
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
          this.broker.reg_paper = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.broker.reg_paper = ''
      }
   },
   onFileChange2 (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.broker.photo = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.broker.photo = ''
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
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${brokersInfoUpdateApi}/${this.id}`, this.broker)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, brokersInfoStoreApi, this.broker)
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
    }
  },
  watch: {
    'broker.division_id': function (newVal, oldVal) {
        this.districtList = this.getDistrictList(newVal)
    },
    'broker.district_id': function (newVal, oldVal) {
        this.cityCorporationList = this.getCityCorporationList(newVal)
        this.upazilaList = this.getUpazilaList(newVal)
    },
    'broker.upazila_id': function (newVal, oldVal) {
        this.unionList = this.getUnionList(newVal)
        this.municipalityList = this.getPauroshobaList(newVal)
    },
    'broker.city_corporation_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByCityCorportaion(newVal)
    },
    'broker.pauroshoba_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByPauroshoba(newVal)
    },
    'broker.union_id': function (newVal, oldVal) {
        this.wardList = this.getWardListByUnion(newVal)
    }
  }
}
</script>
