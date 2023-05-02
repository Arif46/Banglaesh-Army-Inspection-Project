<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
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
                  :disabled="councilAssociat"
                  id="council_info_id"
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
                  :disabled="councilAssociat"
                  id="association_info_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <template>
                    <div v-if="hasAssociation">
                      <p class="text-danger">{{$t('eBizAssociation.has_association_msg')}}</p>
                    </div>
                </template>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" md="6" sm="12">
                <ValidationProvider name="Establish Date" vid="establish_date" rules="required" v-slot="{ errors }">
                  <b-form-group
                    label-for="establish_date"
                    >
                    <template v-slot:label>
                      {{ $t('associationPnl.establish_date') }} <span class="text-danger">*</span>
                    </template>
                    <date-picker
                        id="establish_date"
                        v-model="form.establish_date"
                        class="form-control"
                        :placeholder="$t('associationPnl.establish_date')"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :class="errors[0] ? 'is-invalid' : ''"
                      >
                    </date-picker>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
            </b-col>
          <b-col xs="12" sm="12" md="6">
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
                  :disabled="isDisable"
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
                  :disabled="isDisable"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="description_en"
                    rows="3"
                    v-model="form.description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="description_bn"
                    rows="3"
                    v-model="form.description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="6" md="6" sm="12">
              <ValidationProvider name="Gender" vid='gender' rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                      label-for="gender"
                  >
                      <template v-slot:label>
                          {{ $t('globalTrans.gender') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                          plain
                          v-model="form.gender"
                          :options="genderList"
                          id="gender"
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
            <b-col lg="6" md="6" sm="12">
                <ValidationProvider name="NID No" vid="nid_no" rules="required" v-slot="{ errors }">
                    <b-form-group

                        label-for="nid"
                    >
                    <template v-slot:label>
                        {{ $t('globalTrans.nid') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                            v-model="form.nid"
                            oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :disabled="isDisable"
                        ></b-form-input>
                        <div class="invalid-feedback">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                </ValidationProvider>
            </b-col>
        </b-row>
        <b-row>
          <b-col sm="12" style="max-width: 22%">
                <p class="text-black">
                    {{ $t('globalTrans.address') + ' :' }}
                </p>
            </b-col>
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
          </b-row>
        <b-row class="text-right">
          <b-col>
              <b-button :disabled="hasAssociation" type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { associationStore, associationUpdate, getPreviousAssociation } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      isDisable: false,
      ItemShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      hasAssociation: false,
      form: {
          council_info_id: 0,
          association_info_id: 0,
          establish_date: '',
          contact_person_name_en: '',
          contact_person_name_bn: '',
          mobile: '',
          email: '',
          description_en: '',
          description_bn: '',
          area_type_id: 0,
          division_id: 0,
          district_id: 0,
          city_corporation_id: 0,
          pauroshoba_id: 0,
          upazila_id: 0,
          union_id: 0,
          ward_id: 0,
          gender: 0,
          nid: ''
      },
        councilAssociat: false,
        associationInfoList: [],
        districtList: [],
        cityCorporationList: [],
        upazilaList: [],
        unionList: [],
        wardList: [],
        tmpWardList: []
    }
  },
  created () {
    if (this.id) {
      this.councilAssociat = true
      this.isDisable = true
      const tmp = this.getData()
      this.form = tmp
    }
  },
  computed: {
    municipalityList () {
      return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
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
          if (!this.id) {
            this.hasAssociation = false
             this.checkPreviousAssociation()
          }
        }
    },
    'form.association_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
        if (!this.id) {
          this.hasAssociation = false
          this.checkPreviousAssociation()
        }
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
    'form.pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.wardList = this.getWardListByPauroshoba(newVal)
            // this.dataReturn()
        }
    },
    'form.union_id': function (newVal, oldVal) {
    if (newVal !== oldVal) {
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
            return this.$store.state.CommonService.commonObj.wardList.filter(item => item.municipality_id === pauroshobaId && item.status === 1)
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
    // callCeckPreviousAsssociation (event) {
    //   if (this.id) {
    //       if ((parseInt(this.form.association_info_id) === parseInt(this.editForm.association_info_id)) && (parseInt(this.form.council_info_id) === parseInt(this.editForm.council_info_id))) {
    //     } else {
    //           this.hasAssociation = false
    //           this.checkPreviousAssociation()
    //     }
    //   } else {
    //      this.hasAssociation = false
    //      this.checkPreviousAssociation()
    //   }
    // },
     async checkPreviousAssociation () {
        const params = {
          council_info_id: this.form.council_info_id,
          association_info_id: this.form.association_info_id
        }
        const loadingState = { loading: false, listReload: false }
        let result = null
        result = await RestApi.getData(eBizServiceBaseUrl, getPreviousAssociation, params)
        loadingState.listReload = true
          if (result.success) {
            if (result.data) {
                this.hasAssociation = true
              }
          } else {
              this.hasAssociation = false
          }
      },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${associationUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, associationStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
