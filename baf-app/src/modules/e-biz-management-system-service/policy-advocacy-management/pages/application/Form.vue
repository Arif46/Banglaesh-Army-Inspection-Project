<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <template>
                <div style="font-size:14px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h6 class="text-white text-left">
                        {{ $t('globalTrans.basic_information') }}
                    </h6>
                </div>
          </template>
          <hr>
           <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Council Name" vid="council_info_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="council_info_id"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.council_info_id"
                  :options="councilInfoList"
                  id="council_info_id"
                  disabled
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Association Name" vid="association_info_id" rules="required|min_value:1" v-slot="{ errors }">
                <b-form-group
                  label-for="association_info_id"
                >
                <template v-slot:label>
                  {{$t('eBizProposal.association_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.association_info_id"
                  :options="associationInfoList"
                  disabled
                  id="association_info_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Contact Person Name (En)" vid="contact_person_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="contact_person_name_en">
                <template v-slot:label>
                  {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_person_name_en"
                  v-model="form.contact_person_name_en"
                  disabled
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Contact Person Name (Bn)" vid="contact_person_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="contact_person_name_bn">
                <template v-slot:label>
                  {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_person_name_bn"
                  v-model="form.contact_person_name_bn"
                  disabled
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Mobile No" vid="mobile_no" rules="required|min:11|max:11" v-slot="{ errors }">
              <b-form-group
                label-for="mobile_no">
                <template v-slot:label>
                  {{ $t('eBizConfig.mobile_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="mobile_no"
                  v-model="form.mobile"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Email Address" vid="email_address" v-slot="{ errors }" rules="required|email">
              <b-form-group
                label-for="email_address">
                <template v-slot:label>
                  {{ $t('eBizConfig.email_address') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email_address"
                  type="email"
                  v-model="form.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                  disabled
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row>
            <template>
                <div style="font-size:18px; background-color: #17a2b8;border-radius:5px" class="p-1">
                    <h6 class="text-white text-left">
                        {{ $t('globalTrans.address') }}
                    </h6>
                </div>
          </template>
            <hr>
        </b-row>
          <b-row>
            <!-- Area Type -->
            <b-col lg="6" md="6" sm="12">
                <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group
                      label-for="area_type_id"
                    >
                        <template v-slot:label>
                            {{$t('globalTrans.area_type')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="form.area_type_id"
                            :options="areaTypeList"
                            disabled
                            @change="getAreaTypeData(form.area_type_id)"
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
            <b-col lg="6" md="6" sm="12">
                <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1" v-slot="{ errors }">
                    <b-form-group

                        label-for="division_id"
                    >
                        <template v-slot:label>
                            {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="form.division_id"
                            :options="divisionList"
                            :state="errors[0] ? false : (valid ? true : null)"
                            disabled
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
          <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="District" vid="district_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="district_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.district_id"
                          :options="districtList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
          <b-col lg="6" md="6" sm="12" v-if="CityCorpItemShow">
              <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="city_corporation_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.city_corporation') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.city_corporation_id"
                          :options="cityCorporationList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
          <b-col lg="6" md="6" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
              <ValidationProvider name="Upazila" vid="upazila_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="upazila_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.upazila')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.upazila_id"
                          :options="upazilaList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
          <b-col lg="6" md="6" sm="12" v-if="PauroshobaItemShow">
              <ValidationProvider name="Pourashava" vid="pauroshoba_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="pauroshoba_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.pouroshova') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.pauroshoba_id"
                          :options="municipalityList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
          <b-col lg="6" md="6" sm="12" v-if="UnionItemShow">
              <ValidationProvider name="Union" vid="union_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="union_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.union')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.union_id"
                          :options="unionList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
          <b-col lg="6" md="6" sm="12" v-if="ItemShow">
              <ValidationProvider name="Ward" vid="ward_id" rules="" v-slot="{ errors }">
                  <b-form-group
                      label-for="ward_id"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.ward') }}
                      </template>
                      <b-form-select
                          plain
                          v-model="form.ward_id"
                          :options="wardList"
                          :state="errors[0] ? false : (valid ? true : null)"
                          disabled
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
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="Description" vid="description" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="description"
              >
              <template v-slot:label>
                {{$t('globalTrans.description')}} <span class="text-danger">*</span>
              </template>
              <vue-editor
                v-model="form.description"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </vue-editor>
              <div class="invalid-feedback d-block">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
                  <ValidationProvider name="Attachment" vid="attachment" :rules="attachmentReq">
                    <b-form-group
                      label-for="attachment"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('Advocacy.policy_advocacy')}} {{ $t('Advocacy.attachment_type') }} <span class="text-danger">*</span>
                      </template>
                    <b-form-file id="attachment"
                    v-model="form.file"
                    v-on:change="onFileChange"
                    accept=".doc,.docx,.pdf"
                    class="mt-2" plain
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
              </b-col>
          </b-row>
        <b-row class="text-right">
          <b-col>
          <b-button type="submit" variant="warning" @click="formStatus(1)" class="mr-2 btn-sm">{{ draftBtnName }}</b-button>
              <b-button type="submit" variant="success" @click="formStatus(2)" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { advApplicationStore, advApplicationUpdate } from '../../api/routes'
import { VueEditor } from 'vue2-editor'
export default {
  name: 'Form',
  components: {
    VueEditor
  },
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.finalSave'),
      errors: [],
      isDisable: false,
      ItemShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      attachmentReq: 'required',
      draftBtnName: this.$t('globalTrans.draft'),
      form: {
          contact_person_id: 0,
          council_info_id: 0,
          association_info_id: 0,
          establish_date: '',
          contact_person_name_en: '',
          contact_person_name_bn: '',
          mobile: '',
          email: '',
          description: '',
          area_type_id: 0,
          division_id: 0,
          district_id: 0,
          city_corporation_id: 0,
          pauroshoba_id: 0,
          upazila_id: 0,
          union_id: 0,
          ward_id: 0,
          gender: 0,
          file: [],
          attachment: '',
          nid: ''
      },
        profile: this.$store.state.ExternalUserService.eBizPanel.commonObj.associationProfile,
        associationInfoList: [],
        districtList: [],
        cityCorporationList: [],
        upazilaList: [],
        municipalityList: [],
        unionList: [],
        wardList: [],
        tmpWardList: []
    }
  },
  created () {
    if (this.profile !== undefined) {
      this.form = this.profile
      this.form.contact_person_id = this.profile.id
    }
    if (this.id) {
      this.attachmentReq = ''
      this.isDisable = true
      const tmp = this.getData()
      this.form = tmp
      this.form.contact_person_name_en = this.profile.contact_person_name_en
      this.form.contact_person_name_bn = this.profile.contact_person_name_bn
      this.form.attachment = ''
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.ExternalUserService.eBizPanel.commonObj.councilInfoList.filter(item => item.status === 1)
    },
     areaTypeList: function () {
        return this.$store.state.commonObj.areaTypeList.map(el => {
            return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    },
    genderList: function () {
        return this.$store.state.commonObj.genderList.map(el => {
            return Object.assign({ value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    },
    divisionList () {
        return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    }
  },
  watch: {
    'form.area_type_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.changesAreaTypes(newVal)
        }
    },
    'form.council_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.associationInfoList = this.$store.state.EBizManagementSystemService.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
        }
    },
    'form.division_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.districtList = this.getDistrictList(newVal)
            // this.dataReturn()
        }
    },
    'form.district_id': function (newVal, oldVal) {
            if (newVal !== oldVal) {
                this.cityCorporationList = this.getCityCorporationList(newVal)
                this.upazilaList = this.getUpazilaList(newVal)
                // this.dataReturn()
            }
        },
    'form.upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.unionList = this.getUnionList(newVal)
            this.municipalityList = this.getPauroshobaList(newVal)
            // this.dataReturn()
        }
    },
    'form.city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardListByCityCorporation(newVal)
            // this.dataReturn()
        }
    },
    'form.paurasabha_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardListByPauroshoba(newVal)
            // this.dataReturn()
        }
    },
    'form.union_id': function (newVal, oldVal) {
      if (newVal !== oldVal && this.form.area_type_id === 3) {
          this.wardList = this.getWardListByUnion(newVal)
          // this.dataReturn()
      }
  },
  currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    }
  },
  methods: {
    formStatus (status) {
        this.form.status = status
    },
    onFileChange (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.attachment = ''
          }
      },
    changeEnBn () {
        if (Object.values(this.address).length > 0) {
            this.districtList = this.getDistrictList(parseInt(this.form.division_id))
            this.cityCorporationList = this.getCityCorporationList(parseInt(this.form.district_id))
            this.upazilaList = this.getUpazilaList(parseInt(this.form.district_id))
            this.municipalityList = this.getPauroshobaList(parseInt(this.form.upazila_id))
            this.unionList = this.getUnionList(parseInt(this.form.upazila_id))
            if (this.form.area_type_id === 1) {
                this.wardList = this.getWardListByCityCorporation(this.form.city_corporation_id)
            } else if (this.form.area_type_id === 2) {
                this.wardList = this.getWardListByPauroshoba(this.form.city_corporation_id)
            } else {
                this.wardList = this.getWardListByUnion(this.form.city_corporation_id)
            }
        }
    },
    getAreaTypeData (typeId) {
        this.changesAreaTypes(typeId)
        this.reset()
    },
    reset () {
        this.form.city_corporation_id = 0
        this.form.upazila_id = 0
        this.form.pauroshoba_id = 0
        this.form.union_id = 0
        this.form.ward_id = 0
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
            return this.$store.state.CommonService.commonObj.wardList.filter(item => item.pauroshoba_id === pauroshobaId && item.status === 1)
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
    },
    async saveUpdate () {
      const isValid = await this.$refs.form.validate()
      if (isValid) {
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          const loadingState = { loading: false, listReload: false }
          if (this.id) {
            result = await RestApi.putData(eBizServiceBaseUrl, `${advApplicationUpdate}/${this.id}`, this.form)
          } else {
            result = await RestApi.postData(eBizServiceBaseUrl, advApplicationStore, this.form)
          }

          loadingState.listReload = true
          this.$store.dispatch('mutateCommonProperties', loadingState)

          if (result.success) {
           this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
            this.form.description = ''
            this.form.attachment = ''
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
              color: '#D6E09B'
            })
            this.$bvModal.hide('modal-form')
          } else {
            this.$refs.form.setErrors(result.errors)
          }
       }
    },
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
