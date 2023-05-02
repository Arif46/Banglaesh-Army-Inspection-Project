<template>
  <div class="inner-section">
    <body-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('sideBar.profile') }} {{ $t('globalTrans.update') }}</h4>
      </template>
      <template v-slot:headerAction>
          <!-- <b-link v-if="profile.id" class="btn-add" to="/external-user/association-panel/association-profile"> -->
          <b-link  class="btn-add" to="/association-panel/association-profile">
            <i class="ri-eye-fill"></i>{{ ' ' + $t('globalTrans.details') }}
        </b-link>
      </template>
      <template v-slot:body>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-overlay :show="loading">
                <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                    <b-row>
                 <b-col lg="12" md="12" sm="12">
                 <b-row>
                    <b-col lg="6" md="6" sm="12">
                        <ValidationProvider name="Council Name" vid="council_info_id" rules="required|min_value:1" v-slot="{ errors }">
                        <b-form-group
                            label-for="council_info_id"
                            label-cols-sm="3"
                        >
                        <template v-slot:label>
                            {{$t('eBizProposal.council_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="form.council_info_id"
                            :options="councilInfoList"
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
                            label-cols-sm="3"
                        >
                        <template v-slot:label>
                            {{$t('eBizProposal.association_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                            plain
                            v-model="form.association_info_id"
                            :options="associationInfoList"
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
                        label-cols-sm="3"
                        >
                        <template v-slot:label>
                          {{ $t('associationPnl.establish_date') }} <span class="text-danger">*</span>
                        </template>
                         <date-picker
                            id="establish_date"
                            v-model="form.establish_date"
                            class="form-control"
                            :placeholder="$t('globalTrans.select_date')"
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
                            </b-row>
                            <b-row>
                      <b-col lg="6" md="6" sm="12">
                          <ValidationProvider name="Contact Person Name (En)" vid="contact_person_name_en" rules="required" v-slot="{ errors }">
                              <b-form-group
                              label-for="contact_person_name_en"
                              label-cols-sm="3"
                              >
                              <template v-slot:label>
                                  {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.en') }}<span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="name"
                                  v-model="form.contact_person_name_en"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="6" md="6" sm="12">
                          <ValidationProvider name="Contact Person Name (Bn)" vid="contact_person_name_bn" rules="required" v-slot="{ errors }">
                              <b-form-group
                              label-for="contact_person_name_bn"
                              label-cols-sm="3"
                              >
                              <template v-slot:label>
                                {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                  id="name_bn"
                                  v-model="form.contact_person_name_bn"
                                  :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                  {{ errors[0] }}
                              </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="6" md="6" sm="12">
                          <ValidationProvider name="mobile" vid="mobile" rules="" v-slot="{ errors }">
                              <b-form-group
                                  label-cols-sm="3"
                                  label-for="mobile"
                              >
                              <template v-slot:label>
                                  {{ $t('globalTrans.mobile') }}
                                  </template>
                                  <b-form-input
                                  id="mobile"
                                  disabled
                                  type="email"
                                  v-model="form.mobile"
                                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="6" md="6" sm="12">
                          <ValidationProvider name="Email" vid="email" rules="" v-slot="{ errors }">
                              <b-form-group
                                  class="row"
                                  label-cols-sm="3"
                                  label-for="email"
                              >
                              <template v-slot:label>
                                  {{ $t('globalTrans.email') }}
                                  </template>
                                  <b-form-input
                                  id="org_bn"
                                  disabled
                                  type="email"
                                  v-model="form.email"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  ></b-form-input>
                                  <div class="invalid-feedback">
                                  {{ errors[0] }}
                                  </div>
                              </b-form-group>
                          </ValidationProvider>
                      </b-col>
                      <b-col lg="6" md="6" sm="12">
                        <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
                          <b-form-group
                            label-for="description_en"
                            label-cols-sm="3"
                            >
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
                      <b-col lg="6" md="6" sm="12">
                        <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
                          <b-form-group
                            label-for="description_bn"
                            label-cols-sm="3"
                            >
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
                            </b-row>
                        </b-col>
                    </b-row>
                    <b-row>
                      <b-col lg="6" md="6" sm="12">
                            <ValidationProvider name="Gender" vid='gender' rules="required|min_value:1" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="3"
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
                        <b-col lg="6" md="6" sm="12">
                            <ValidationProvider name="NID No" vid="nid_no" rules="required|min:8" v-slot="{ errors }">
                                <b-form-group
                                    label-cols-sm="3"
                                    label-for="nid"
                                >
                                <template v-slot:label>
                                    {{ $t('globalTrans.nid') }} <span class="text-danger">*</span>
                                    </template>
                                    <b-form-input
                                        v-model="form.nid"
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
                    </b-row>
                    <!-- Present Address -->
                    <b-row>
                        <b-col sm="12" style="max-width: 22%">
                            <p class="text-black" style="border-bottom: 1px solid #ddd; font-weight: bold">
                                {{ $t('globalTrans.address') + ' :' }}
                            </p>
                        </b-col>
                        <!-- <b-col lg="12" md="12" sm="12">
                            <Address :data="pr_address" :addressType="'present'" :param="fieldObj" @pr-address-data="receivePrAddress" title="Present Address"/>
                        </b-col> -->
                    </b-row>
                    <b-row>
                      <!-- Area Type -->
                      <b-col lg="6" md="6" sm="12">
                          <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1" v-slot="{ errors }">
                              <b-form-group
                                label-cols-sm="3"
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
                                  label-cols-sm="3"
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
                                label-cols-sm="3"
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
                                label-cols-sm="3"
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
                                label-cols-sm="3"
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
                        <ValidationProvider name="Pourashava" vid="paurashava_id" rules="required|min_value:1" v-slot="{ errors }">
                            <b-form-group
                                label-cols-sm="3"
                                label-for="paurashava_id"
                            >
                                <template v-slot:label>
                                    {{ $t('globalTrans.pouroshova') }} <span class="text-danger">*</span>
                                </template>
                                <b-form-select
                                    plain
                                    v-model="form.paurashava_id"
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
                                label-cols-sm="3"
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
                                label-cols-sm="3"
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
                            <b-button variant="danger" class="btn-sm" @click="cancel">{{ $t('globalTrans.cancel') }}</b-button>
                        </b-col>
                    </b-row>
                </b-form>
            </b-overlay>
        </ValidationObserver>
      </template>
    </body-card>
  </div>
</template>
<script>
  // -------New Strat----------
  import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
    import { associationProfileShow, associationProfileStore, getPreviousAssociation } from '../api/routes'
  // -------New End------------
import { mapGetters } from 'vuex'
export default {
  components: {
   },
  name: 'Form',
  data () {
    return {
       loader: false,
       loading: false,
        isShow: false,
        baseUrl: 'http://moc-auth-service.local/',
        valid: null,
        // saveBtnName: this.$t('globalTrans.update'),
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        id: 0,
        ItemShow: false,
        CityCorpItemShow: false,
        PauroshobaItemShow: false,
        UnionItemShow: false,
        hasAssociation: false,
        form: {
            user_id: 0,
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
    if (Object.values(this.authUser).length > 0) {
        this.form.user_id = this.authUser.user_id
        this.form.mobile = this.authUser.mobile
        this.form.email = this.authUser.email
        this.form.gender = this.commonProfile.gender
        this.form.nid = this.commonProfile.nid_no
        // this.loadData(this.authUser.user_id)
    }
  },
  computed: {
    genderList: function () {
        return this.$store.state.commonObj.genderList.map(el => {
            return Object.assign({ value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
        })
    },
    loading11: function () {
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
    divisionList () {
        return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    currentLocale () {
            return this.$i18n.locale
        },
    ...mapGetters({
        authUser: 'Auth/authUser',
        commonProfile: 'Auth/commonProfile'
    })
  },
  watch: {
    'form.council_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.associationInfoList = this.$store.state.ExternalUserService.eBizPanel.commonObj.associationInfoList.filter(item => item.status === 1 && item.council_info_id === parseInt(newVal))
          this.hasAssociation = false
          this.checkPreviousAssociation()
        }
    },
    'form.association_info_id': function (newVal, oldVal) {
      if ((newVal !== oldVal)) {
          this.hasAssociation = false
          this.checkPreviousAssociation()
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
    // ---------------New Start----------------
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
        this.form.paurashava_id = 0
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
    },
    // ---------------New End------------------
    cancel () {
        this.$router.push({ path: '/external-user/panel' })
    },
    async loadData (userId) {
      this.loading = true
      // --------------New Start---------------
      this.form.user_id = this.authUser.user_id
      this.form.mobile = this.authUser.mobile
      this.form.email = this.authUser.email
      this.form.gender = this.commonProfile.gender
      this.form.nid = this.commonProfile.nid_no
      // --------------New End-----------------
      // --------------Api Call Start------------------
      this.loader = true
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(eBizServiceBaseUrl, `${associationProfileShow}/${userId}`)
        if (result.success) {
          const data = result.data
          this.id = data.id
            /** redirect to profie update page */
            this.$router.push('/association-panel/association-profile-update')
        }
        this.loader = false
        this.loading = false
      // --------------Api Call End--------------------
      // this.loading = false
    },
    async saveUpdate () {
      this.loading = true
      let result = null
        const loadingState = { loading: false, listReload: false }
        if (this.id) {
            result = await RestApi.putData(eBizServiceBaseUrl, `common-profile/update/${this.id}`, this.profile)
        } else {
            result = await RestApi.postData(eBizServiceBaseUrl, associationProfileStore, this.form)
        }
        loadingState.listReload = true
        if (result.success) {
            const data = result.data
            this.$store.dispatch('ExternalUserService/setAssociationProfile', data)
            this.$toast.success({
                title: 'Success',
                message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                color: '#D6E09B'
            })
            this.$router.push({ path: '/association-panel/association-profile' })
        } else {
            this.$store.dispatch('ExternalUserService/setAssociationProfile', null)
            this.$refs.form.setErrors(result.errors)
        }
    }
  }
}
</script>
