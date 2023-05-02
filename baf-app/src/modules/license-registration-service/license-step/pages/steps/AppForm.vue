<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
          <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" v-if="tindex > 0">
             <b-overlay :show="unitLoad">
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
                        {{$t('user_role.organization')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="gridSearch.org_id"
                        :options="orgList"
                        id="org_id"
                        :disabled="is_disable"
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
                        {{$t('org_pro.service_namel')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        v-model="gridSearch.service_id"
                        :options="serviceNamesList"
                        id="service_id"
                        :disabled="is_disable"
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
              </b-row>
              <hr>
              <b-row>
                <b-col lg="6" sm="12">
                  <ValidationProvider name="Area Type" vid="area_type_id" rules="required|min_value:1">
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
                <b-col lg="6" sm="12" v-show="ItemShow">
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
                <b-col lg="6" sm="12" v-show="ItemShow">
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
                <b-col lg="6" sm="12" v-show="PauroshobaItemShow || UnionItemShow">
                    <ValidationProvider name="Upazila" vid="upazila_id">
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
                <!-- <b-col lg="6" sm="12" v-show="UnionItemShow">
                    <ValidationProvider name="Union" vid="union_id">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="union_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                            {{ $t('org_pro_union.union')}} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.union_id"
                            :options="unionList"
                            id="union_id"
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
                </b-col> -->
                <b-col lg="6" sm="12" v-show="CityCorpItemShow">
                  <ValidationProvider name="City Corporation" vid="city_corporation_id">
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
                <b-col lg="6" sm="12" v-show="officeItemShow">
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
                <b-col lg="6" sm="12" v-show="officeItemShow">
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
                <!-- <b-col lg="6" sm="12" v-show="PauroshobaItemShow">
                    <ValidationProvider name="Pauroshoba" vid="pauroshoba_id">
                        <b-form-group
                            class="row"
                            label-cols-sm="4"
                            label-for="pauroshoba_id"
                            slot-scope="{ valid, errors }"
                            >
                            <template v-slot:label>
                                {{ $t('org_pro.pauroshoba') }} <span class="text-danger">*</span>
                            </template>
                            <b-form-select
                            plain
                            v-model="officeData.pauroshoba_id"
                            :options="pauroshobaList"
                            id="pauroshoba_id"
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
                </b-col> -->
              </b-row>
            </b-overlay>
            <b-overlay :show="unitLoad">
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
                                  :row-height="20"
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
                                    <Dropdown :data="formIData[dindex]" :drpChangeData="formIData[dindex + 1]" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                    <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                    <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                    <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                    <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                    <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                    <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                    <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                    <AddMore @addDetails="addMoreDetailsShow" :tmpData="formIData[dindex]" :data="formIData" v-if="item.dataType === 'Add More'" />
                                  </b-row>
                                  </grid-item>
                                </grid-layout>
                              </b-col>
                            </b-row>
                          </b-overlay>
                          <div class="row">
                            <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns" v-if="addMore"/>
                          </div>
                          <div class="row">
                            <div class="col text-right">
                              <b-button v-if="index !== 0" @click="tabIndex--" variant="primary" class="mr-2">{{ $t('component_settings.prev_tab') }}</b-button>
                              <b-button v-if="index < totalTab && index !== totalTab" @click="tabIndex++" variant="primary" class="mr-2">{{ $t('component_settings.next_tab') }}</b-button>
                              <!-- <b-button v-if="formActions.isDraft && index === totalTab" @click="save_status = 1" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button> -->
                              <b-button v-if="formActions.isSubmit && index === totalTab" @click="save_status = 2" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                              <b-button v-if="formActions.isReset && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                              <router-link v-if="formActions.isCancel && index === totalTab" to="step-form" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
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
    </iq-card>
  </b-container>
</template>
<script>
// import Input from '../../../configuration/pages/components/input-field'
import Input from '@/components/license/admin/app-form/input-field'
import Dropdown from '@/components/license/admin/app-form/dropdown-field'
import Checkbox from '@/components/license/admin/app-form/checkbox-field'
import Attachment from '@/components/license/admin/app-form/attachment-field'
import Radio from '@/components/license/admin/app-form/radio-field'
import Textarea from '@/components/license/admin/app-form/textarea-field'
import Paragraph from '@/components/license/admin/app-form/paragraph-field'
import Date from '@/components/license/admin/app-form/date-field'
import Header from '@/components/license/admin/app-form/header-field'
import AddMore from '@/components/license/admin/app-form/addMore-field'
import AddMoreDetails from '@/components/license/admin/app-form/addMoreDetails'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepFormView, formDataStore } from '../../api/routes'
import { snakeToWords, wordsToSnake, isNotEmpty } from '@/utils/fliter'
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
    AddMoreDetails
  },
  data () {
    return {
      save_status: 1,
      officeItemShow: false,
      ItemShow: false,
      inputFieldShow: false,
      ItemShowPer: false,
      CityCorpItemShow: false,
      CityCorpItemPerShow: false,
      PauroshobaItemShow: false,
      PauroshobaItemPerShow: false,
      UnionItemShow: false,
      UnionItemPerShow: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      gridSearch: {
        service_id: 0,
        org_id: 0
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
      is_disable: false,
      officeData: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: 0,
        office_type_id: 0,
        office_id: 0
      },
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      officeList: []
    }
  },
  created () {
    this.unitLoad = true
    // this.getAreaTypeData(this.officeData.area_type_id)
    this.step_id = parseInt(this.$route.query.step_id)
    this.index = this.layout.length
    this.checkSingleService()
  },
  watch: {
    'gridSearch.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    },
    'gridSearch.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.service_name = this.getServiceName(newVal)
        this.step_name = this.getStepName(this.step_id)
        this.loadFrom(newVal)
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
      return this.$store.state.commonObj.officeTypeList.filter(item => item.status === 0 && item.org_id === this.gridSearch.org_id).map(item => {
          if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    divisionList: function () {
      return this.$store.state.commonObj.divisionList.filter(item => item.status === 0)
    },
    orgList () {
        return this.$store.state.commonObj.organizationProfileList.filter(item => item.status === 0)
    },
    areaTypeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'সিটি কর্পোরেশন' : 'City Corpoation' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'পৌরসভা' : 'Pauroshoba' },
        { value: 3, text: this.$i18n.locale === 'bn' ? 'উপজেলা' : 'Upazila' }
      ]
      return list
    },
    menuInfoList () {
      const menuId = this.$route.query.menu_id
      return this.$store.state.LicenseRegistrationService.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    }
  },
  methods: {
    getAreaTypeData (typeId) {
      this.ItemShow = true
      this.officeItemShow = true
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
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.commonObj.officeList.filter(item => item.status === 0)
      let offices = ''
      if (officeTypeId && this.officeData.area_type_id === 1) {
        offices = officeList.filter(item => item.office_type_id === officeTypeId && item.city_corporation_id === this.officeData.city_corporation_id)
        if (offices.length < 1) {
          offices = officeList.filter(item => item.office_type_id === officeTypeId && item.district_id === this.officeData.district_id)
        }
      } else {
        offices = officeList.filter(item => item.office_type_id === officeTypeId && item.upazilla_id === this.officeData.upazilla_id)
        if (offices.length < 1) {
          offices = officeList.filter(item => item.office_type_id === officeTypeId && item.district_id === this.officeData.district_id)
        }
      }
      return offices
    },
    loadFrom (serviceId) {
      const formData = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.find(item => item.service_id === serviceId && item.step_id === this.step_id && item.form_type === 2)
      const formId = formData.form_id
      this.unitLoad = true
      const params = {
        id: formId
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormView, params).then(response => {
        if (isNotEmpty(response.data)) {
          this.formActions = JSON.parse(response.data.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          response.data.tabs.forEach((item, tabIndex) => {
            const tabNo = item.tab_no
            const tabName = item.tab_name
            const tabTitle = snakeToWords(item.tab_name)
            const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
            this.tabData.push(data)
            item.layouts.forEach((layItem) => {
              const layJson = JSON.parse(layItem.layout)
              const dataJson = JSON.parse(layItem.data)
              this.layoutData.push(layJson)
              this.formInputData.push(dataJson)
              this.tindex++
            })
          })
          this.totalTab = this.tabData.length - 1
        }
        this.unitLoad = false
        this.updateLayout()
      })
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
                tData[item.field_name] = item.value.toString()
              } else {
                tData[item.field_name] = item.value
              }
            }
            if (item.field_type === 'image' && item.upload_type === 'dynamic') {
              tData[item.field_name] = item.value
              fData.images.push({ field_name: item.field_name, value: item.value })
            }
            if (item.field_type === 'file' && item.upload_type === 'dynamic') {
              tData[item.field_name] = item.value
              fData.images.push({ field_name: item.field_name, value: item.value })
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
      this.sInfo.step_id = this.step_id
      this.sInfo.step_name = wordsToSnake(this.step_name)
      this.sInfo.tabInfo = this.tabData
      const formData = {
        data: sData,
        service_info: this.sInfo,
        officeData: this.officeData,
        fileData: pData
      }
      let result = null
      this.unitLoad = true
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, formDataStore, formData)
      this.unitLoad = false
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$refs.form.setErrors(result.errors)
      }
      this.$router.go(-1)
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
    addMoreDetailsShow (data) {
      if (data) {
        this.detailsData = data
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
      const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => (item.org_id === orgId && item.step_id === this.step_id))
      return tmpService.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.service_id, text: item.service_name_bn }
        } else {
          return { value: item.service_id, text: item.service_name }
        }
      })
    },
    getServiceName (sId) {
      const service = this.serviceNamesList.find(item => item.value === sId)
      return service.text
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(item => item.value === stId)
      return step.text
    },
    checkSingleService () {
      // const tmpService = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => (item.step_id === parseInt(this.$route.query.step_id)))
      if (this.menuInfoList.details.length === 1) {
        this.gridSearch.org_id = this.menuInfoList.org_id
        this.gridSearch.service_id = this.menuInfoList.details[0].service_id
        this.is_disable = true
      } else {
        const gridSearch = {
            service_id: 0,
            org_id: 0,
            from_date: '',
            to_date: '',
            application_id: ''
        }
        this.gridSearch = gridSearch
        this.layout = []
        this.formInputData = []
        this.is_disable = false
      }
    },
    getDistrictList (divisionId = null) {
      const districtList = this.$store.state.commonObj.districtList.filter(item => item.status === 0)
        if (divisionId) {
          return districtList.filter(district => district.division_id === divisionId)
        }
        return districtList
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.commonObjCommonConfig.cityCorporationList.filter(item => item.status === 0 && item.district_id === districtId)
        return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
              return { value: obj.value, text: obj.text_bn }
          } else {
              return { value: obj.value, text: obj.text_en }
          }
        })
    },
    getUpazilaList (districtId = null) {
      const upazilaList = this.$store.state.commonObj.upazilaList.filter(item => item.status === 0)
      if (districtId) {
        return upazilaList.filter(upazila => upazila.district_id === districtId)
      }
      return upazilaList
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
</style>
