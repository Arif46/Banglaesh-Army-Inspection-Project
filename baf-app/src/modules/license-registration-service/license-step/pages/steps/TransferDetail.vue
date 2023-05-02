<template>
  <b-container fluid>
    <body-card>
      <template v-slot:body>
        <button @click="printDiv()" class="btn btn-success btn-sm"><i class="ri-printer-line mr-0"></i>
          {{ $t('globalTrans.print') }}
        </button>
         <div style="background-color: green;margin-bottom: 5px;float:right" v-if=" transferData.all_service_data.doc_verified === 1">
            <h6 class="text-white mr-0 p-2"> {{ $t('li_step.docu_verify') }} </h6>
          </div>
          <div class="row p-4 mt-3" id="printArea">
            <div class="col-md-12">
              <div class="p-2" style="" >
                <b-overlay :show="unitLoadDetails">
                  <b-row>
                    <b-col lg="12" sm="12">
                      <div class="stepper-wrapper">
                        <div :class="getStepOrder(stepData.step_id) >= item.order ? `stepper-item completed` : `stepper-item`" v-for="(item,index) in stepList" :key="index">
                          <div class="step-counter">
                            <i v-if="((getStepOrder(stepData.step_id) > item.order) || (transferData.all_service_data.issue_date))" class="ri-check-fill"></i>
                            <span v-else>{{ index+1 }}</span>
                          </div>
                          <div class="step-name">{{ item.text }}</div>
                        </div>
                      </div>
                    <!-- <b-button @click="backStep()" variant="primary" class="mr-1" style="float: right;">{{ $t('globalTrans.back') }}</b-button> -->
                    </b-col>
                  </b-row>
                  <template>
                    <div style="background-color: #005B5B;margin-bottom: 5px">
                      <h5 class="text-white ml-2"> {{ $t('externalLrcpn.service_information') }} </h5>
                    </div>
                  </template>
                    <b-row>
                        <b-col lg="12" sm="12">
                            <b-table-simple striped bordered small class="mt-1">
                              <b-tr>
                                  <b-th>{{$t('user_role.organization')}}</b-th>
                                  <b-td> {{ getMainStoreData('orgList', gridSearch.org_id) }} </b-td>
                                  <b-th>{{$t('org_pro.service_namel')}}</b-th>
                                  <b-td> {{ getStoreData('licenseRegistration', 'serviceNamesList', gridSearch.service_id) }} </b-td>
                              </b-tr>
                            </b-table-simple>
                        </b-col>
                    </b-row>
                  <template>
                      <div style="background-color: #005B5B;margin-bottom: 5px">
                        <h5 class="text-white ml-2"> {{ $t('externalLrcpn.office_information') }} </h5>
                      </div>
                  </template>
                    <b-row>
                        <b-col lg="12" sm="12">
                            <b-table-simple striped bordered small class="mt-1">
                              <b-tr>
                                <b-th>{{$t('org_pro.area_type')}}</b-th>
                                <b-td> {{ singleAreaType(officeData.area_type_id) }} </b-td>
                                <b-th>{{$t('globalTrans.division')}}</b-th>
                                <b-td> {{ singleDivision(officeData.division_id) }} </b-td>
                                <b-th>{{$t('globalTrans.district')}}</b-th>
                                <b-td> {{ singleDistrict(officeData.district_id) }} </b-td>
                              </b-tr>
                              <b-tr>
                                  <b-th v-show="PauroshobaItemShow || UnionItemShow">{{$t('org_pro_upazilla.upazilla')}}</b-th>
                                  <b-td v-show="PauroshobaItemShow || UnionItemShow"> {{ singleUpazilla(officeData.upazilla_id) }} </b-td>
                                  <b-th v-show="CityCorpItemShow">{{$t('org_pro.city_corporation')}}</b-th>
                                  <b-td v-show="CityCorpItemShow"> {{ singleCityCorporation(officeData.city_corporation_id) }} </b-td>
                                  <b-th v-show="officeItemSHow">{{$t('elearning_config.office_type')}}</b-th>
                                  <b-td v-show="officeItemSHow"> {{ singleOfficeType(officeData.office_type_id) }} </b-td>
                                  <b-th v-show="officeItemSHow">{{$t('globalTrans.office')}}</b-th>
                                  <b-td v-show="officeItemSHow"> {{ singleOffice(officeData.office_id) }} </b-td>
                              </b-tr>
                            </b-table-simple>
                        </b-col>
                    </b-row>
                  <b-row>
                    <b-col md="12" lg="12" sm="12" :show="unitLoadDetails">
                      <b-card no-body>
                        <b-tabs v-model="tabIndex">
                          <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                            <template v-slot:title>
                              <span>{{ local === 'bn' ? item.tab_title_bn : item.tab_title }}</span>
                            </template>
                            <template :id="index">
                              <b-row>
                                <b-col md="12" lg="12" sm="12">
                                  <grid-layout :layout.sync="layout"
                                    :col-num="colNum"
                                    :row-height="20"
                                    :is-draggable="false"
                                    :is-resizable="false"
                                    :vertical-compact="true"
                                    :use-css-transforms="true"
                                    :key="layoutKey"
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
                                      <Input :tmpData="formIData" :index="dindex" v-if="item.dataType === 'InputField'" />
                                      <Dropdown :data="formIData[dindex]" :drpChangeData="getChildDropdown(dindex)" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                      <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                      <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                      <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                      <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                      <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                      <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                      <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                    </grid-item>
                                  </grid-layout>
                                </b-col>
                              </b-row>
                              <div class="row">
                                <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns" v-if="addMore"/>
                              </div>
                            </template>
                        </b-tab>
                        <b-tab :title="$t('budget.forwardComments')" v-if="forwardComment">
                          <div class="row">
                            <b-col lg="12" sm="12">
                                <b-overlay :show="forwarLoad">
                                  <div style="background-color: #005B5B;margin-bottom: 5px">
                                    <h5 class="text-white ml-2"> {{  $t('budget.forwardComments') }} </h5>
                                  </div>
                                  <b-table-simple striped bordered small class="mt-2">
                                      <b-tr>
                                          <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                          <b-th>{{ $t('budget.sendFrom') }}</b-th>
                                          <b-th>{{ $t('budget.sendTo') }}</b-th>
                                          <b-th>{{ $t('budget.comment') }}</b-th>
                                      </b-tr>
                                      <b-tr v-for="(forward,index) in forwardList" :key="index">
                                          <b-td>{{ $n(index+1) }}</b-td>
                                          <b-td>{{ getUserName(forward.sender_id) }}</b-td>
                                          <b-td>{{ getUserName(forward.receiver_id) }}</b-td>
                                          <b-td>{{ $i18n.locale === 'bn' ? forward.note_bn : forward.note_en }}</b-td>
                                      </b-tr>
                                  </b-table-simple>
                                </b-overlay>
                            </b-col>
                          </div>
                        </b-tab>
                        <b-tab :title="$t('dynamic_form.reject_note')" v-if="rejectapprove">
                          <div class="row">
                              <b-col lg="12" sm="12">
                                <b-overlay :show="forwarLoad">
                                  <div style="background-color: #005B5B;margin-bottom: 5px">
                                    <h5 class="text-white ml-2"> {{ $t('dynamic_form.reject_note') }} </h5>
                                  </div>
                                  <b-table-simple striped bordered small class="mt-2">
                                    <b-tr>
                                        <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th>{{ $t('dynamic_form.note') }}</b-th>
                                    </b-tr>
                                    <b-tr v-for="(reject, index) in rejectList" :key="index">
                                        <b-td>{{ $n(index+1) }}</b-td>
                                        <b-td>{{ reject.note }}</b-td>
                                    </b-tr>
                                  </b-table-simple>
                                </b-overlay>
                              </b-col>
                          </div>
                        </b-tab>
                        <div v-if="actionFormView">
                          <b-tab v-for="(item, index) in actionForms" :key="index" :active="index === 0" @click="getActionData(item)">
                            <template v-slot:title>
                              <span>{{ local === 'bn' ? item.form_title_bn : item.form_title }}</span>
                            </template>
                            <template>
                              <b-overlay :show="unitLoad" class="mt-4">
                                <div class="row">
                                  <ActionDetails :ActionData="ActionData" v-if="actionLoad"/>
                                </div>
                              </b-overlay>
                            </template>
                          </b-tab>
                        </div>
                      </b-tabs>
                    </b-card>
                  </b-col>
                </b-row>
                </b-overlay>
              </div>
            </div>
            <div class="col-md-12 text-right">
              <button @click="backStep()" class="btn btn-success btn-sm mt-3"><i class="ri-arrow-left-s-line mr-0"></i> {{ $t('globalTrans.back') }}</button>
            </div>
          </div>
      </template>
    </body-card>
  </b-container>
</template>
<script>
import Vue from 'vue'
import VueHtmlToPaper from 'vue-html-to-paper'
import Input from '@/components/license/user/dissableField/input-field'
import Dropdown from '@/components/license/user/dissableField/dropdown-field-admin'
import Checkbox from '@/components/license/user/dissableField/checkbox-field'
import Attachment from '@/components/license/user/dissableField/attachment-field'
import Radio from '@/components/license/user/dissableField/radio-field'
import Textarea from '@/components/license/user/dissableField/textarea-field'
import Paragraph from '@/components/license/user/dissableField/paragraph-field'
import Date from '@/components/license/user/dissableField/date-field'
import Header from '@/components/license/user/dissableField/header-field'
import AddMoreDetails from '@/components/license/user/dissableField/addMoreDetails'
import { GridLayout, GridItem } from 'vue-grid-layout'
import RestApi, { authServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { changeLogStore, licenseCancel, licenseWithdraw, licenseIssue, stepFormDetailsData } from '../../api/routes'
import { isNotEmpty } from '@/utils/fliter'
import common from '@/mixins/common'
import ActionDetails from './ActionFormDetails'
import CommonLrcpn from '@/mixins/common-lrcpn'
const options = {
  specs: [
    'fullscreen=yes',
    'titlebar=yes',
    'scrollbars=no'
  ],
  styles: [
    'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
    'http://service.moa.gov.bd/step.css'
  ],
  autoClose: true
}
Vue.use(VueHtmlToPaper, options)
export default {
  mixins: [CommonLrcpn, common],
  props: ['transferData', 'stepData'],
  components: {
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    AddMoreDetails,
    ActionDetails
  },
  data () {
    return {
      stepChange: {
        application_id: 0,
        step_id: 0,
        service_id: 0,
        org_id: 0,
        status: 1
      },
      save_status: 1,
      officeItemSHow: false,
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
      layoutEnData: [],
      layoutBnData: [],
      colNum: 12,
      tindex: 0,
      unitLoadDetails: false,
      unitLoad: false,
      forwarLoad: false,
      isFinal: false,
      stepList: [],
      formInputData: [],
      formInputEnData: [],
      formInputBnData: [],
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
      officeData: {
        area_type_id: 0,
        city_corporation_id: 0,
        pauroshoba_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: '0'
      },
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      officeList: [],
      forwardList: {},
      rejectList: {},
      users: [],
      stepID: '',
      layoutKey: 0,
      forwardComment: false,
      rejectapprove: false,
      actionsList: '',
      actionFormData: '',
      actionForms: [],
      actionFormView: false,
      formId: '',
      ActionData: {},
      actionLoad: false
    }
  },
  created () {
    this.gridSearch.org_id = parseInt(this.stepData.org_id)
    this.gridSearch.service_id = parseInt(this.stepData.service_id)
    this.stepList = this.getServiceStep(parseInt(this.stepData.service_id))
    this.step_id = parseInt(this.stepData.step_id)
    this.actionsList = this.actions(this.stepData.service_id)
    if (this.stepData) {
      this.actionFormData = this.getActionForm(this.stepData)
    }
    this.stepChange.org_id = parseInt(this.stepData.org_id)
    this.stepChange.service_id = parseInt(this.stepData.service_id)
    this.stepChange.step_id = parseInt(this.stepData.step_id)
    this.stepChange.application_id = parseInt(this.transferData.all_service_data.application_id)
  },
  watch: {
    'gridSearch.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceNamesList = this.getServiceList(newVal)
      }
    },
    'gridSearch.service_id': function (newVal, oldVal) {
        this.service_name = this.getServiceName(newVal)
        this.step_name = this.getGridStep(newVal).step_name
        this.loadFrom()
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
    },
    local: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.updateLayout()
        }
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
    orgList: function () {
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
    divisionList: function () {
      const divList = this.$store.state.commonObj.divisionList.filter(item => item.status === 0)
      return divList.map(item => {
        if (this.$i18n.locale === 'bn') {
            return { value: item.value, text: item.text_bn }
          } else {
            return { value: item.value, text: item.text_en }
          }
      })
    },
    menuInfoList () {
      const menuId = this.menuId
      return this.$store.state.licenseRegistration.commonObj.menuInfoList.find(item => item.menu_id === parseInt(menuId))
    },
    step () {
      const stepId = this.stepData.step_id
      return this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === parseInt(stepId))
    }
  },
  methods: {
    SetStep (item, status) {
      this.stepChange.application_id = item.application_id
      this.stepChange.step_id = this.step.value
      this.stepChange.service_id = item.service_id
      this.stepChange.org_id = item.org_id
      this.stepChange.status = status
    },
    getActionForm (stepData) {
      const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(stepData.service_id))
      const stepOrder = this.getStepOrder(stepData.step_id)
      const OtherSteps = tmpStepList.filter(item => item.order === stepOrder || parseInt(item.order) < stepOrder)
      OtherSteps.forEach(step => {
        const findAcForm = this.$store.state.licenseRegistration.commonObj.serviceStepForm.find(item => item.service_id === stepData.service_id && item.step_id === step.step_id && item.org_id === stepData.org_id && item.form_type === 1)
        if (typeof findAcForm !== 'undefined') {
          this.actionForms.push(findAcForm)
        }
      })
      if (this.actionForms.length > 0) {
        this.actionFormView = true
      } else {
        this.actionFormView = false
      }
    },
    getActionData (formData) {
      this.formId = formData.form_id
      this.loadActionFrom(formData)
    },
    async loadActionFrom (formData) {
      this.unitLoad = true
      const params = {
      id: this.formId,
      service_id: parseInt(formData.service_id),
      step_id: parseInt(formData.step_id),
      applicationID: parseInt(this.stepData.application_id),
      org_id: parseInt(this.stepData.org_id)
      }
      await RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormDetailsData, params).then(response => {
          if (isNotEmpty(response.data)) {
            this.actionLoad = true
            this.ActionData = response.data
          } else {
            this.actionLoad = false
          }
      })
      this.unitLoad = false
    },
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    printDiv () {
      this.$htmlToPaper('printArea')
    },
    isOdd (num) { return num % 2 },
    backStep () {
      this.$router.go(-1)
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
    getServiceStep (sId) {
      const stepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === sId)
      const tmpList = stepList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.step_id, text: item.step_name_bn, order: item.order }
        } else {
          return { value: item.step_id, text: item.step_name, order: item.order }
        }
      })
      return tmpList.sort((a, b) => { return a.order - b.order })
    },
    loadFrom (serviceId) {
        this.unitLoadDetails = true
        if (isNotEmpty(this.transferData)) {
          if (this.transferData.all_service_data.app_forwards.length > 0) {
            this.forwardComment = true
          } else {
            this.forwardComment = false
          }
          if (this.transferData.all_service_data.app_rejects.length > 0) {
            this.rejectapprove = true
          } else {
            this.rejectapprove = false
          }
          if (this.transferData.all_service_data.app_forwards !== undefined) {
            if (this.transferData.all_service_data.app_forwards.length > 0) {
              this.forwardList = this.transferData.all_service_data.app_forwards
              this.getForwardedUsers(this.forwardList)
            }
          }
          if (this.transferData.all_service_data.app_rejects === undefined) {
            if (this.transferData.all_service_data.app_rejects.length > 0) {
              this.rejectList = this.transferData.all_service_data.app_rejects
            }
          }
            this.getAreaTypeData(this.transferData.applicationInfo.area_type_id)
            this.officeData = this.transferData.applicationInfo
            this.formActions = JSON.parse(this.transferData.item.form_action)
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            this.transferData.item.tabs.forEach((item, tabIndex) => {
              const tabNo = item.tab_no
              const tabName = item.tab_name
              const tabTitle = item.tab_title
              const tabTitleBn = item.tab_title_bn
              const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle, tab_title_bn: tabTitleBn }
              this.tabData.push(data)
              item.viewlayouts.forEach((layItem) => {
                if (layItem.lang_type === 'en') {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.transferData.applicationData !== null) {
                    this.transferData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        this.BackButtonShow = true
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                Object.assign(dataJson, { value: [item[key]] })
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        } else {
                        this.butonShow = true
                        }
                    })
                  } else {
                    this.butonShow = true
                  }
                  this.layoutEnData.push(layJson)
                  this.formInputEnData.push(dataJson)
                } else {
                  const layJson = JSON.parse(layItem.layout)
                  const dataJson = JSON.parse(layItem.data)
                  if (this.transferData.applicationData !== null) {
                    this.transferData.applicationData.map((item, index) => {
                        if (item !== null) {
                        this.table_id = item.id
                        this.BackButtonShow = true
                        Object.keys(item).forEach(key => {
                            if (key === dataJson.field_name) {
                              if (dataJson.field_type === 'options') {
                                Object.assign(dataJson, { value: [item[key]] })
                              } else {
                                Object.assign(dataJson, { value: item[key] })
                              }
                            }
                        })
                        } else {
                        this.butonShow = true
                        }
                    })
                  } else {
                    this.butonShow = true
                  }
                  this.layoutBnData.push(layJson)
                  this.formInputBnData.push(dataJson)
                }
                this.tindex++
              })
            })
            this.totalTab = this.tabData.length - 1
          }
          this.unitLoadDetails = false
          this.updateLayout()
    },
    async getForwardedUsers (forwards) {
        this.forwarLoad = true
        var userIds = []
        forwards.map((item, key) => {
          userIds.push(item.sender_id)
          userIds.push(item.receiver_id)
        })
        const params = Object.assign({}, { user_ids: userIds })
        await RestApi.getData(authServiceBaseUrl, '/user/user-list', params).then(response => {
            if (response.success) {
              this.users = response.data
            } else {
              this.users = []
            }
            this.forwarLoad = false
        })
    },
    getUserName (userId) {
      const user = this.users.find(user => user.value === userId)
      return user !== undefined ? (this.$i18n.locale === 'bn' ? user.text_bn : user.text_en) : ''
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
      if (this.$i18n.locale === 'en') {
        this.layoutEnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputEnData[index]
          if (layData === true) {
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      if (this.$i18n.locale === 'bn') {
        this.layoutBnData.map((item, index) => {
          const layData = item.tabIndex === this.tabIndex
          const inpData = this.formInputBnData[index]
          if (layData === true) {
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        })
      }
      this.layoutKey = this.layoutKey + 1
    },
    getServiceList (orgId) {
      return this.$store.state.licenseRegistration.commonObj.serviceNamesList.filter(item => (item.org_id === parseInt(orgId)))
    },
    getServiceName (sId) {
      const service = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(item => item.value === parseInt(sId))
      return service.text_en
    },
    getStepName (stId) {
      const step = this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === parseInt(stId))
      return step.text_en
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.licenseRegistration.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    getDistrictList (divisionId = null) {
      let districtList = this.$store.state.commonObj.districtList.filter(item => item.status === 0)
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
      let upazilaList = this.$store.state.commonObj.upazilaList.filter(item => item.status === 0)
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
    getOfficeList (officeTypeId) {
      const officeList = this.$store.state.commonObj.officeList.filter(item => item.status === 0)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
    },
    getStepOrder (stepId) {
      const step = this.$store.state.licenseRegistration.commonObj.serviceSteps.find(item => (item.service_id === parseInt(this.stepData.service_id) && item.step_id === parseInt(stepId)))
      if (typeof step === 'undefined') {
        return 0
      } else {
        return step.order
      }
    },
    singleAreaType (areaId) {
      const area = this.areaTypeList.find(item => parseInt(item.value) === areaId)
      if (area) {
        return area.text
      }
    },
    singleOfficeType (officeTypeId) {
      const officetype = this.$store.state.commonObj.officeTypeList.find(item => item.value === officeTypeId)
      if (officetype) {
        if (this.$i18n.locale === 'bn') {
          return officetype.text_bn
        } else {
          return officetype.text_en
        }
      }
    },
    singleOffice (officeId) {
      const office = this.$store.state.commonObj.officeList.find(item => item.value === officeId)
      if (office) {
        if (this.$i18n.locale === 'bn') {
          return office.text_bn
        } else {
          return office.text_en
        }
      }
    },
    singleDivision (divisonId) {
      const divison = this.$store.state.commonObj.divisionList.find(item => item.status === 0 && item.value === parseInt(divisonId))
      if (divison) {
        if (this.$i18n.locale === 'bn') {
          return divison.text_bn
        } else {
          return divison.text_en
        }
      }
    },
    singleDistrict (districtId) {
      const district = this.$store.state.commonObj.districtList.find(item => item.status === 0 && item.value === parseInt(districtId))
      if (district) {
        if (this.$i18n.locale === 'bn') {
          return district.text_bn
        } else {
          return district.text_en
        }
      }
    },
    singleUpazilla (upazilaId) {
      const upazila = this.$store.state.commonObj.upazilaList.find(item => item.status === 0 && item.value === parseInt(upazilaId))
      if (upazila) {
        if (this.$i18n.locale === 'bn') {
          return upazila.text_bn
        } else {
          return upazila.text_en
        }
      }
    },
    singleCityCorporation (cityCorporaId) {
      const cityCorporation = this.$store.state.commonObjCommonConfig.cityCorporationList.find(item => item.status === 0 && item.value === parseInt(cityCorporaId))
      if (cityCorporation) {
        if (this.$i18n.locale === 'bn') {
          return cityCorporation.text_bn
        } else {
          return cityCorporation.text_en
        }
      }
    },
    actions (serviceId) {
      const stepId = parseInt(this.stepData.step_id)
      const actions = this.$store.state.licenseRegistration.commonObj.seviceStepWiseButtonList.filter(item => item.step_id === stepId && item.service_id === parseInt(serviceId))
      if (typeof actions === 'undefined') {
        return {}
      } else {
        const actionl = actions[0]
        return actionl
      }
    },
    getBtn (value) {
      return this.$store.state.licenseRegistration.commonObj.dynamicButtonList.find(item => item.value === parseInt(value))
    },
    commonStatusChange (data, buttonID) {
      let msztitle = ''
      let Api = ''
      let message = ''
      if (buttonID === 6) {
        if (this.menuInfoList.is_forward === 1) {
          this.stepChange.is_forward = 1
        } else {
          this.stepChange.is_forward = 0
        }
        this.stepChange.step_id = this.getServiceWiseStep(data.service_id)
        this.stepChange.user_id = data.user_id
        msztitle = this.$t('globalTrans.verifyMsg')
        Api = changeLogStore
        message = 'Document Verified Successfully'
      }
      if (buttonID === 9) {
        this.stepChange.step_id = data.step_id
        msztitle = this.$t('globalTrans.cancelMsg')
        Api = licenseCancel
        message = 'License Cancel Successfully'
      }
      if (buttonID === 10) {
        this.stepChange.step_id = data.step_id
        msztitle = this.$t('globalTrans.withdrawMsg')
        Api = licenseWithdraw
        message = 'License Withdraw Successfully'
      }
      if (buttonID === 12) {
        this.stepChange.step_id = data.current_step
        this.stepChange.old_application_id = data.old_application_id ? data.old_application_id : 0
        msztitle = this.$t('globalTrans.issueMsg')
        Api = licenseIssue
        message = 'License Issue Successfully'
      }
      window.vm.$swal({
        title: msztitle,
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
            this.listLoading = true
            this.stepChange.application_id = data.application_id
            this.stepChange.service_id = data.service_id
            this.stepChange.org_id = data.org_id
            this.stepChange.application_id = data.application_id
            RestApi.getData(licenseRegistrationServiceBaseUrl, Api, this.stepChange).then(res => {
              this.listLoading = false
              if (res.success === true) {
                this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
                this.$toast.success({
                  title: this.$t('globalTrans.success'),
                  message: message,
                  color: '#D6E09B'
                })
                this.$store.dispatch('licenseRegistration/setLaodList', true)
              } else {
                this.$toast.error({
                  title: 'Error',
                  message: res.message
                })
              }
            })
        }
      })
    },
    previewData (item, stepId) {
      this.pData = item
      this.stepID = stepId
      this.dtlsItemId = item.id
    },
     getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.licenseRegistration.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const tmpIndVStepList = tmpStepList.find(item => item.step_id === parseInt(this.step.value))
        const order = tmpIndVStepList.order
        const orderCheck = tmpStepList.find(item => item.order === order + 1)
        if (typeof orderCheck !== 'undefined') {
          return orderCheck.step_id
        }
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
  .stepper-wrapper {
    margin-top: auto;
    display: flex;
    justify-content: space-between;
    margin-bottom: 20px;
  }
  .stepper-item {
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
    flex: 1;

    @media (max-width: 768px) {
        font-size: 12px;
    }
  }

  .stepper-item::before {
    position: absolute;
    content: "";
    border-bottom: 2px solid #ccc;
    width: 100%;
    top: 20px;
    left: -50%;
    z-index: 2;
  }

  .stepper-item::after {
    position: absolute;
    content: "";
    border-bottom: 2px solid #ccc;
    width: 100%;
    top: 20px;
    left: 50%;
    z-index: 2;
  }

  .stepper-item .step-counter {
    position: relative;
    z-index: 5;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background: #ccc;
    margin-bottom: 6px;
    color: white;
  }

  .stepper-item.active {
  font-weight: bold;
  }

  .stepper-item.completed .step-counter {
  background-color: #4bb543;
  color:white;
  }

  .stepper-item.completed::after {
    position: absolute;
    content: "";
    border-bottom: 2px solid #4bb543;
    width: 100%;
    top: 20px;
    left: 50%;
    z-index: 3;
  }

  .stepper-item:first-child::before {
    content: none;
  }
  .stepper-item:last-child::after {
    content: none;
  }
  .step-name {
    color: black;
    font-weight: bold;
    font-size: 11px;
  }
</style>
