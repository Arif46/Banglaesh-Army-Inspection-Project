<template>
  <b-container fluid>
    <div class="inner-section">
      <card>
        <template v-slot:body>
          <ValidationObserver ref="searchForm" v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit()" >
              <b-overlay :show="unitLoad">
                <template>
                  <div style="font-size:18px; background-color: #005B5B;margin-bottom: 12px">
                    <h5 class="text-white ml-2"> {{ $t('externalLrcpn.service_information') }} </h5>
                  </div>
                </template>
                <b-row>
                  <b-col lg="4" sm="4">
                    <ValidationProvider name="Organization" vid="org_id" rules="required">
                      <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('globalTrans.organization')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="gridSearch.org_id"
                          :options="orgList"
                          id="org_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                          <template v-slot:first>
                            <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="4" sm="4">
                    <ValidationProvider name="Service Name" vid="service_id" rules="required">
                      <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="service_id"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          v-model="gridSearch.service_id"
                          :options="serviceNamesList"
                          id="service_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                          <template v-slot:first>
                              <b-form-select-option :value="0">{{ $t('globalTrans.select') }}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="4" sm="4">
                    <ValidationProvider name="Had manual" vid="has_manual" v-if="isShowManual === true">
                        <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="has_manual"
                        >
                        <template v-slot:label>
                            {{$t('externalLrcpn.has_manual')}}
                        </template>
                        <b-form-radio-group
                          v-model="prevManualData.hasManual"
                          :options="manualList"
                        >
                        </b-form-radio-group>
                        </b-form-group>
                    </ValidationProvider>
                  </b-col>
                </b-row>
              </b-overlay>
            </b-form>
          </ValidationObserver>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" v-if="tindex > 0">
              <b-overlay :show="saveloading">
                <hr v-if="prevManualData.hasManual === true">
                <template v-if="prevManualData.hasManual === true">
                    <div style="font-size:18px; background-color: #005B5B;margin-bottom: 12px">
                      <h5 class="text-white ml-2"> {{ $t('externalLrcpn.prev_information') }} </h5>
                    </div>
                </template>
                <b-row v-if="prevManualData.hasManual === true">
                  <b-col lg="6" sm="6" md="6">
                      <ValidationProvider name="Application Id" vid="generate_id">
                      <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="generate_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('externalLrcpn.prev_license_no') }}
                          </template>
                          <b-form-input
                          plain
                          v-model="prevManualData.generate_id"
                          id="application_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          </b-form-input>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col lg="6" sm="6" md="6">
                      <ValidationProvider name="Book No" vid="book_no">
                      <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="book_no"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('externalLrcpn.book_no') }}
                          </template>
                          <b-form-input
                          plain
                          v-model="prevManualData.book_no"
                          id="application_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          </b-form-input>
                          <div class="invalid-feedback">
                              {{ errors[0] }}
                          </div>
                      </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col lg="6" sm="6" md="6">
                      <ValidationProvider name="Issue Date" vid="issue_date">
                          <b-form-group
                          class="row"
                          label-cols-sm="12"
                          :label="$t('externalLrcpn.issue_date')"
                          label-for="from_date"
                          slot-scope="{ valid, errors }"
                          >
                          <b-form-input
                              id="datepicker"
                              placeholder="yyyy-mm-dd"
                              v-model="prevManualData.issue_date"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col lg="6" sm="6" md="6">
                      <ValidationProvider name="Expire Date" vid="expire_date">
                          <b-form-group
                          class="row"
                          label-cols-sm="12"
                          :label="$t('externalLrcpn.expire_date')"
                          label-for="expire_date"
                          slot-scope="{ valid, errors }"
                          >
                          <b-form-input
                              id="datepicker"
                              placeholder="yyyy-mm-dd"
                              v-model="prevManualData.expire_date"
                              :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                </b-row>
                <hr>
                <template>
                    <div style="font-size:18px; background-color: #005B5B;margin-bottom: 12px">
                      <h5 class="text-white ml-2"> {{ $t('externalLrcpn.office_information') }} </h5>
                    </div>
                </template>
                <b-row v-if="!isOfficeSelected">
                  <b-col lg="6" sm="12" v-if="locationShow">
                    <ValidationProvider name="Area Type" vid="area_type_id">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="area_type_id "
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{$t('org_pro.area_type')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.area_type_id"
                            id="area_type_id"
                            :options="areaTypeList"
                            @change="getAreaTypeData(officeData.area_type_id)"
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
                  <b-col lg="6" sm="12" v-if="ItemShow">
                  <ValidationProvider name="Division" vid="division_id" rules="required|min_value:1">
                      <b-form-group
                          class="row"
                          label-cols-sm="4"
                          label-for="division_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('globalTrans.division')}} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                          plain
                          v-model="officeData.division_id"
                          :options="divisionList"
                          id="division_id"
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
                  <b-col lg="6" sm="12" v-if="ItemShow">
                    <ValidationProvider name="District" vid="district_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="district_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                            {{ $t('globalTrans.district')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.district_id"
                            :options="districtList"
                            id="district_id"
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
                  <b-col lg="6" sm="12" v-if="PauroshobaItemShow || UnionItemShow">
                      <ValidationProvider name="Upazila" vid="upazila_id" rules="required|min_value:1">
                          <b-form-group
                              class="row"
                              label-cols-sm="4"
                              label-for="upazila_id"
                              slot-scope="{ valid, errors }"
                              >
                              <template v-slot:label>
                              {{ $t('org_pro_upazilla.upazilla')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-select
                              plain
                              v-model="officeData.upazilla_id"
                              :options="upazilaList"
                              id="upazila_id"
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
                  <b-col lg="6" sm="12" v-if="CityCorpItemShow">
                    <ValidationProvider name="City Corporation" vid="city_corporation_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="city_corporation_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('org_pro.city_corporation') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.city_corporation_id"
                            :options="cityCorporationList"
                            id="city_corporation_id"
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
                <b-row>
                  <b-col lg="6" sm="12">
                    <ValidationProvider name="Office Type" vid="office_type_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="office_type_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('elearning_config.office_type') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.office_type_id"
                            :options="officeTypeList"
                            :disabled="isOfficeSelected"
                            id="office_type_id"
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
                  <b-col lg="6" sm="12">
                    <ValidationProvider name="Office" vid="office_id" rules="required|min_value:1">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="office_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.office') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.office_id"
                            :options="officeList"
                            :disabled="isOfficeSelected"
                            id="office_id"
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
                <b-row>
                  <b-col md="12" lg="12" sm="12">
                    <b-card no-body>
                      <b-tabs v-model="tabIndex">
                        <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                          <template v-slot:title>
                            <span>{{ local === 'bn' ? item.tab_title_bn : item.tab_title }}</span>
                          </template>
                          <template :id="index">
                            <b-overlay :show="loading">
                              <b-row>
                                <b-col md="12" lg="12" sm="12">
                                  <grid-layout :layout.sync="layout"
                                    :col-num="colNum"
                                    :row-height="13"
                                    :is-draggable="false"
                                    :is-resizable="false"
                                    :vertical-compact="true"
                                    :use-css-transforms="true"
                                  >
                                    <grid-item style="height: auto !important" v-for="(item, dindex) in layout"
                                      :x="item.x"
                                      :y="item.y"
                                      :w="item.w"
                                      :h="item.h"
                                      :i="item.i"
                                      :dataType="item.dataType"
                                      :key="dindex"
                                    >
                                    <b-row>
                                      <Input :tmpData="formIData" :index="dindex" v-if="item.dataType === 'InputField'" />
                                      <Dropdown :data="formIData[dindex]" :drpChangeData="getChildDropdown(dindex)" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                      <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                      <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                      <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                      <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                      <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                      <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                      <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
  <!--                                    <AddMore @addDetails="addMoreDetailsShow" :tmpData="formIData[dindex]" :data="formIData" v-if="item.dataType === 'Add More'" />-->
                                      <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                      <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                                    </b-row>
                                    <template v-if="item.dataType === 'Add More'">
                                      <b-row>
                                        <AddMore @addDetails="addMoreDetailsShow" :tmpData="formIData[dindex]" :data="formIData" v-if="item.dataType === 'Add More'" />
                                        <AddMoreDetails :tmpData="detailsDataAll[item.i]" :colData="getLayoutItemColumnsData(item)" class="mt-3"/>
                                      </b-row>
                                    </template>
                                    </grid-item>
                                  </grid-layout>
                                </b-col>
                              </b-row>
                            </b-overlay>
  <!--                          <div class="row" v-if="addIndex === index">-->
  <!--                            <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns" v-if="addMore"/>-->
  <!--                          </div>-->
                            <div class="row">
                              <div class="col text-right">
                                <b-button v-if="index !== 0" @click="tabIndex--" variant="primary" class="mr-2">{{ $t('component_settings.prev_tab') }}</b-button>
                                <b-button v-if="index < totalTab && index !== totalTab" @click="tabIndex++" variant="primary" class="mr-2">{{ $t('component_settings.next_tab') }}</b-button>
                                <b-button v-if="formActions.isDraft && index === totalTab" @click="save_status = 1" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                                <b-button v-if="formActions.isSubmit && index === totalTab" @click="save_status = 2" type="submit" variant="primary" class="mr-2">{{ $t('globalTrans.submit') }}</b-button>
                                <b-button v-if="formActions.isReset && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                                <router-link v-if="formActions.isCancel && index === totalTab" to="application" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                                <b-button v-if="formActions.isPayment && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('component_settings.payment') }}</b-button>
                              </div>
                            </div>
                          </template>
                        </b-tab>
                      </b-tabs>
                    </b-card>
                  </b-col>
                </b-row>
              </b-overlay>
            </b-form>
          </ValidationObserver>
        </template>
      </card>
    </div>
  </b-container>
</template>
<script>
import flatpickr from 'flatpickr'
import Input from '@/components/license/user/input-field'
import Dropdown from '@/components/license/user/dropdown-field'
import Checkbox from '@/components/license/user/checkbox-field'
import Attachment from '@/components/license/user/attachment-field'
import Radio from '@/components/license/user/radio-field'
import Textarea from '@/components/license/user/textarea-field'
import Paragraph from '@/components/license/user/paragraph-field'
import Date from '@/components/license/user/date-field'
import Header from '@/components/license/user/header-field'
import AddMore from '@/components/license/user/addMore-field'
import AddMoreDetails from '@/components/license/user/addMoreDetails'
import Payment from '@/components/license/user/payment'
import PaymentCheckbox from '@/components/license/user/payment-checkbox'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { userEntryForm, userEntryStore } from '../../api/routes'
import { wordsToSnake, snakeToWords, isNotEmpty } from '@/utils/fliter.js'
export default {
  components: {
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    ValidationObserver,
    ValidationProvider,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    AddMore,
    AddMoreDetails,
    Payment,
    PaymentCheckbox
  },
  data () {
    return {
      save_status: 1,
      isOfficeSelected: false,
      officeItemSHow: false,
      ItemShow: false,
      inputFieldShow: false,
      ItemShowPer: false,
      locationShow: false,
      CityCorpItemShow: false,
      CityCorpItemPerShow: false,
      PauroshobaItemShow: false,
      PauroshobaItemPerShow: false,
      UnionItemShow: false,
      UnionItemPerShow: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.submit'),
      gridSearch: {
        service_id: 0,
        org_id: 0
      },
      prevManualData: {
        hasManual: false,
        generate_id: '',
        issue_date: '',
        expire_date: '',
        last_step: '',
        book_no: ''
      },
      layout: [],
      layoutData: [],
      colNum: 12,
      index: 0,
      tindex: 0,
      unitLoad: false,
      loading: false,
      isFinal: false,
      stepList: [],
      formInputData: [],
      formIData: [],
      tabData: [],
      tabIndex: 0,
      componentKey: 0,
      formStatus: 0,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      serviceNamesList: [],
      step_id: '',
      totalTab: 0,
      formActions: {
        isDraft: false,
        isSubmit: false,
        isReset: false,
        isPayment: false,
        isCancel: false
      },
      service_name: '',
      sInfo: {},
      saveloading: false,
      officeData: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: '0',
        office_type_id: 0,
        office_id: 0
      },
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      officeList: [],
      addIndex: '',
      addMoreLayoutData: [],
      detailsDataAll: {},
      manualList: [
        { value: true, text: this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes' },
        { value: false, text: this.$i18n.locale === 'bn' ? 'না' : 'No' }
      ],
      isShowManual: false
    }
  },
  created () {
    this.index = this.layout.length
    this.serviceNamesList = this.getServiceList(parseInt(this.$route.query.org_id))
  },
  mounted () {
    flatpickr('#datepicker', {})
    if (this.$route.query.org_id && this.$route.query.service_id) {
      this.gridSearch.org_id = parseInt(this.$route.query.org_id)
      this.gridSearch.service_id = parseInt(this.$route.query.service_id)
    }
  },
  watch: {
    'gridSearch.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    },
    'gridSearch.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getInitialStep(newVal)
        this.service_name = this.getServiceName(newVal)
        this.step_name = this.getStepName(newVal)
        this.checkOfficeExist(newVal)
        this.loadFrom(newVal)
        this.getServiceLastStep(newVal)
      }
    },
    tabIndex: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.updateLayout()
      }
    },
    'officeData.division_id': function (newVal, oldVal) {
      this.districtList = this.getDistrictList(newVal)
    },
    'officeData.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazilaList(newVal)
    },
    'officeData.office_type_id': function (newValue) {
      this.officeList = this.getOfficeList(newValue)
    }
  },
  computed: {
    local: function () {
        return this.$i18n.locale
    },
    officeTypeList: function () {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 0 && item.org_id === this.gridSearch.org_id).map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    orgList: function () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    areaTypeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'সিটি কর্পোরেশন' : 'City Corpoation' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'পৌরসভা' : 'Pauroshoba' },
        { value: 3, text: this.$i18n.locale === 'bn' ? 'উপজেলা' : 'Upazila' }
      ]
      return list
    },
    divisionList: function () {
      const divList = this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
      return divList.map(item => {
        if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    }
  },
  methods: {
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    getInitialStep (serviceId) {
      const tmpStep = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(step => step.service_id === serviceId && step.order === 1)
      this.step_id = typeof tmpStep !== 'undefined' ? tmpStep.step_id : 0
    },
    getEntryStep (serviceId) {
      const tmpService = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    getAreaTypeData (typeId) {
      this.officeItemSHow = true
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
    loadFrom (serviceId) {
      const formData = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => item.service_id === serviceId && item.form_type === 2)
      if (typeof formData === 'undefined') {
        this.layoutData = []
        this.formInputData = []
        this.tabData = []
        this.layout = []
      } else {
        const formId = formData.form_id
        this.unitLoad = true
        const params = {
          id: formId
        }
        RestApi.getData(licenseRegistrationServiceBaseUrl, userEntryForm, params).then(response => {
          if (isNotEmpty(response.data)) {
            this.isShowManual = true
            this.formActions = JSON.parse(response.data.form_action)
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            this.locationShow = true
            response.data.tabs.forEach((item, tabIndex) => {
              const tabNo = item.tab_no
              const tabName = item.tab_name
              const tabTitle = snakeToWords(item.tab_name)
              const tabTitleBn = snakeToWords(item.tab_title_bn)
              const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle, tab_title_bn: tabTitleBn }
              this.tabData.push(data)
              item.layouts.forEach((layItem) => {
                const layJson = JSON.parse(layItem.layout)
                const dataJson = JSON.parse(layItem.data)
                this.layoutData.push(layJson)
                this.formInputData.push(dataJson)
                this.tindex++
              })
              // const addFind = this.layoutData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
              // if (addFind !== undefined) {
              //   const fieldData = this.formInputData.find(item => item.id === addFind.i)
              //   fieldData.fields.forEach(i => {
              //     const field = this.formInputData.find(item => item.id === i)
              //     this.Addcolumns.push(field.label)
              //   })
              //   this.Addcolumns.push('Action')
              //   this.addMore = true
              //   this.addIndex = addFind.tabIndex
              // }
              const addMoreLayoutData = this.layoutData.filter(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
              this.addMoreLayoutData = addMoreLayoutData
              if (addMoreLayoutData.length) {
                addMoreLayoutData.forEach((addMoreLayoutItem) => {
                  const cols = []
                  const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
                  fieldData.fields.forEach(i => {
                    const field = this.formInputData.find(item => item.id === i)
                    cols.push({ text_en: field.label, text_bn: field.label_bn })
                  })
                  cols.push({ text_en: 'Action', text_bn: 'অ্যাকশন' })
                  this.Addcolumns.push(cols)
                  this.addMore = true
                  this.addIndex = addMoreLayoutItem.tabIndex
                  this.detailsDataAll[addMoreLayoutItem.i] = []
                })
              }
            })
            this.totalTab = this.tabData.length - 1
          }
          this.unitLoad = false
          this.updateLayout()
        })
      }
    },
    async saveFormData () {
      const sData = []
      const pData = []
      const data = this.formInputData
      this.tabData.forEach((tabItem) => {
        const tData = {}
        const fData = {}
        fData.images = []
        data.forEach((item) => {
          if (item.indexId === tabItem.tab_no) {
            if (item.field_type !== 'empty' && item.field_type !== 'paragraph' && item.field_type !== 'image' && item.field_type !== 'h1' && item.field_type !== 'h2' && item.field_type !== 'h3' && item.field_type !== 'h4' && item.field_type !== 'h5' && item.field_type !== 'h6') {
              if (item.field_type === 'options') {
                if (item.value) {
                  tData[item.field_name] = item.value.toString()
                } else {
                  tData[item.field_name] = ''
                }
              } else if (item.field_type === 'paymentCheckbox') {
                tData[item.field_name] = JSON.stringify(item.value)
              } else if (item.field_type === 'addMore_button') {
                tData[item.field_name] = JSON.stringify(item.addMore_options)
              } else {
                tData[item.field_name] = item.value
              }
            }
            if (item.field_type === 'image' && item.upload_type === 'dynamic') {
              tData[item.field_name] = item.value
              fData.images.push({ field_name: item.field_name, value: item.value, fieldType: item.field_type, tabId: item.indexId })
            }
            if (item.field_type === 'file') {
              tData[item.field_name] = item.value
              fData.images.push({ field_name: item.field_name, value: item.value, fieldType: item.field_type, tabId: item.indexId })
            }
          }
        })
        sData.push(tData)
        pData.push(fData)
      })
      this.sInfo.save_status = this.save_status
      this.sInfo.org_id = this.gridSearch.org_id
      this.sInfo.service_id = this.gridSearch.service_id
      this.sInfo.service_name = wordsToSnake(this.service_name)
      this.sInfo.step_id = this.getEntryStep(this.gridSearch.service_id).step_id
      this.sInfo.step_name = wordsToSnake(this.step_name)
      this.sInfo.tabInfo = this.tabData
      this.officeData.type = 1
      const formData = {
        formInputData: this.formInputData,
        data: sData,
        service_info: this.sInfo,
        officeData: this.officeData,
        fileData: pData,
        prevManualData: this.prevManualData
      }
      let result = null
      this.saveloading = true
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, userEntryStore, formData)
      this.saveloading = false
      if (result.success === 'error') {
        this.$toast.error({
          title: 'Error',
          message: result.message,
          color: '#D6E09B'
        })
        return
      }
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push('/lrcpn/application')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    reset () {
    },
    updateDropdown: function (updata, nindex) {
      this.componentKey += 1
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    async addMoreDetailsShow (data, index = null) {
      if (data) {
        await this.$nextTick(() => {
          this.detailsData = data
          this.detailsDataAll[index] = data
          this.detailsDataAll = Object.assign({}, this.detailsDataAll, { index: data })
        })
      }
    },
    updateLayout: function (val) {
      this.layout = []
      this.formIData = []
      this.layoutData.map((item, index) => {
        const layData = item.tabIndex === this.tabIndex
        const inpData = this.formInputData[index]
        if (layData === true) {
          this.layout.push(item)
          this.formIData.push(inpData)
        }
      })
    },
    getServiceList (orgId) {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.filter(item => (item.org_id === orgId) && (item.public_application === 1))
    },
    getServiceName (sId) {
      const service = this.serviceNamesList.find(item => item.value === sId)
      return typeof service !== 'undefined' ? service.text : ''
    },
    getStepName (stId) {
      const step = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepNamesList.find(item => item.value === stId)
      return typeof step !== 'undefined' ? step.text : ''
    },
    getDistrictList (divisionId = null) {
      let districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1)
      if (divisionId) {
        districtList = districtList.filter(district => district.division_id === divisionId)
      }
      return districtList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.ExternalUserService.dealerPanel.commonObjCommonConfig.cityCorporationList.filter(item => item.status === 0 && item.district_id === districtId)
        return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
        })
    },
    getUpazilaList (districtId = null) {
      let upazilaList = this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1)
      if (districtId) {
        upazilaList = upazilaList.filter(upazila => upazila.district_id === districtId)
      }
      return upazilaList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    getOfficeTypeList (serviceId) {
      const officeTypeList = this.$store.state.CommonService.commonObj.officeTypeList
      if (serviceId) {
        return officeTypeList.filter(service => service.service_id === serviceId)
      }
      return officeTypeList
    },
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
    },
    checkOfficeExist (serviceId) {
      const service = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.find(item => (item.value === serviceId))
      if (service.office_type_id === null) {
        this.isOfficeSelected = false
      } else {
        this.isOfficeSelected = true
        this.officeData.office_type_id = service.office_type_id
        this.officeData.office_id = service.office_name_id
      }
    },
    getLayoutItemColumnsData (addMoreLayoutItem) {
      const cols = []
      const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
      fieldData.fields.forEach(i => {
        const field = this.formInputData.find(item => item.id === i)
        cols.push({ text_en: field.label, text_bn: field.label_bn })
      })
      cols.push({ text_en: 'Action', text_bn: 'অ্যাকশন' })
      return cols
    },
    getServiceLastStep (serviceId) {
      const tmpStepList = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
      const maxorder = tmpStepList.reduce(function (prev, current) {
        return (prev.order > current.order) ? prev : current
      })
      this.prevManualData.last_step = maxorder.order
    }
  }
}
</script>
<style scoped>
.vue-grid-item .resizing {
    opacity: 0.9;
}
.vue-grid-item .text {
    font-size: 24px;
    text-align: center;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 0;
    right: 0;
    margin: auto;
    height: 100%;
    width: 100%;
}
.vue-grid-item .no-drag {
    height: 100%;
    width: 100%;
}
.vue-grid-item .minMax {
    font-size: 12px;
}
.fields {
  padding: 0.375rem 0.75rem;
}
.fields:hover {
  z-index: 1;
  color: #fff;
  background-color: #5a6268;
  border-radius: 0.25rem;
}
.dark_button .btn-secondary {
  color: #000 !important;
}
hr {
    border: none;
    border-top: 3px double #333;
    color: #333;
    overflow: visible;
    text-align: center;
    height: 5px;
}
hr:after {
    background: #fff;
    content: '';
    padding: 0 4px;
    position: relative;
    top: -13px;
}
</style>
