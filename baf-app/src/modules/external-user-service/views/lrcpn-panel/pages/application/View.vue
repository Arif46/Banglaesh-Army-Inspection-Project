<template>
  <b-container fluid>
    <div class="inner-section">
      <card>
        <body-card>
          <template v-slot:body>
            <button @click="printDiv()" class="btn btn-success btn-sm"><i class="ri-printer-line mr-0"></i>
              {{ $t('globalTrans.print') }}
            </button>
            <div class="row p-4" id="printArea">
              <div class="col-md-12" style="" >
                  <b-overlay :show="unitLoad">
                    <b-row class="mt-4">
                      <b-col lg="12" sm="12">
                        <div class="stepper-wrapper">
                          <div :class="getStepOrder($route.query.step_id) >= item.order ? `stepper-item completed` : `stepper-item`" v-for="(item,index) in stepList" :key="index">
                            <div class="step-counter">
                              <i v-if="((getStepOrder($route.query.step_id) > item.order) || (applicationInfo.issue_date))" class="ri-check-fill"></i>
                              <span v-else>{{ index+1 }}</span>
                            </div>
                            <div class="step-name">{{ item.text }}</div>
                          </div>
                        </div>
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
                                  <b-th>{{$t('globalTrans.organization')}}</b-th>
                                  <b-td> {{ getOrgName(gridSearch.org_id) }} </b-td>
                                  <b-th>{{$t('service_name.service_name')}}</b-th>
                                  <b-td> {{ getServiceName(gridSearch.service_id) }} </b-td>
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
                              <b-table-simple striped bordered small class="mt-1" v-if="!officeCategoryShow">
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
                              <b-table-simple striped bordered small class="mt-1" v-if="officeCategoryShow">
                                <b-tr>
                                    <b-th> {{$t('externalLrcpn.office_cat')}}</b-th>
                                    <b-td> {{ getOfficeCategory(officeData.office_cat_id) }} </b-td>
                                    <b-th> {{$t('globalTrans.division')}}</b-th>
                                    <b-td> {{ singleDivision(officeData.division_id) }} </b-td>
                                    <b-th> {{$t('globalTrans.district')}}</b-th>
                                    <b-td> {{ singleDistrict(officeData.district_id) }} </b-td>
                                </b-tr>
                                <b-tr>
                                    <b-th> {{$t('org_pro_upazilla.upazilla')}}</b-th>
                                    <b-td> {{ singleUpazilla(officeData.upazilla_id) }} </b-td>
                                    <b-th> {{$t('globalTrans.office')}}</b-th>
                                    <b-td> {{ singleOffice(officeData.office_id) }} </b-td>
                                    <b-th></b-th>
                                    <b-td></b-td>
                                </b-tr>
                              </b-table-simple>
                          </b-col>
                      </b-row>
                  </b-overlay>
                  <b-overlay :show="saveloading">
                    <b-row>
                      <b-col md="12" lg="12" sm="12">
                        <b-card no-body>
                          <b-tabs v-model="tabIndex">
                            <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                              <template v-slot:title>
                                <span>{{ item.tab_title }}</span>
                              </template>
                              <template :id="index">
                                <b-overlay :show="loading">
                                  <b-row>
                                    <b-col md="12" lg="12" sm="12">
                                      <grid-layout :layout.sync="layout"
                                        :col-num="colNum"
                                        :row-height="15"
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
                                          <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                          <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                                        </b-row>
                                        <template v-if="item.dataType === 'RelationalField'">
                                          <b-row>
                                            <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                            <RelationalDetails :tmpData="relationDataAll[item.i]"/>
                                          </b-row>
                                        </template>
                                        <template v-if="item.dataType === 'Add More'">
                                          <b-row>
                                            <AddMoreDetails :tmpData="getAddMoreData(item)" :colData="getLayoutItemColumnsData(item)" :key="addDetail" class="mt-3"/>
                                          </b-row>
                                        </template>
                                        </grid-item>
                                      </grid-layout>
                                    </b-col>
                                  </b-row>
                                </b-overlay>
                              </template>
                            </b-tab>
                            <b-tab :title="$t('boro_import.import_seed_amount')" v-if="addmore_update">
                              <div class="row">
                                <b-col lg="12" sm="12">
                                  <div style="background-color: #005B5B;margin-bottom: 5px">
                                    <h5 class="text-white ml-2"> {{  $t('boro_import.import_seed_amount') }} </h5>
                                  </div>
                                  <b-table-simple striped bordered small class="mt-2">
                                      <b-tr>
                                          <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                          <b-th>{{ $t('boro_import.variety_name') }}</b-th>
                                          <b-th>{{ $t('boro_import.meeting_date') }}</b-th>
                                          <b-th>{{ $t('boro_import.meeting_number') }}</b-th>
                                          <b-th> {{ $t('boro_import.af_1') }}</b-th>
                                          <b-th> {{ $t('boro_import.a_line') }}</b-th>
                                          <b-th> {{ $t('boro_import.r_line') }}</b-th>
                                          <b-th> {{ $t('boro_import.seed_produce') }}</b-th>
                                          <b-th> {{ $t('boro_import.abadi_jomi') }}</b-th>
                                          <b-th> {{ $t('boro_import.prev_year_prod') }}</b-th>
                                      </b-tr>
                                      <b-tr v-for="(item, index) in addmore_updateData" :key="index">
                                        <b-td>
                                          {{ $n(index + 1) }}
                                        </b-td>
                                        <b-td v-for="(ditem, dindex) in item" :key="dindex">
                                          {{ ditem }}
                                        </b-td>
                                      </b-tr>
                                  </b-table-simple>
                                </b-col>
                              </div>
                            </b-tab>
                            <b-tab :title="$t('boro_import.future_seed')" v-if="addmore_update2">
                              <div class="row">
                                <b-col lg="12" sm="12">
                                  <div style="background-color: #005B5B;margin-bottom: 5px">
                                    <h5 class="text-white ml-2"> {{  $t('boro_import.future_seed') }} </h5>
                                  </div>
                                  <b-table-simple striped bordered small class="mt-2">
                                      <b-tr>
                                          <b-th>{{ $t('globalTrans.sl_no') }}</b-th>
                                          <b-th>{{ $t('boro_import.variety_name') }}</b-th>
                                          <b-th>{{ $t('boro_import.variety_indetails') }}</b-th>
                                          <b-th> {{ $t('boro_import.af_1') }}</b-th>
                                          <b-th> {{ $t('boro_import.a_line') }}</b-th>
                                          <b-th> {{ $t('boro_import.r_line') }}</b-th>
                                          <b-th> {{ $t('boro_import.abadi_jomi') }}</b-th>
                                          <b-th> {{ $t('boro_import.prev_year_prod') }}</b-th>
                                          <b-th> {{ $t('boro_import.comment') }}</b-th>
                                      </b-tr>
                                      <b-tr v-for="(item, index) in addmore_updateData2" :key="index">
                                        <b-td>
                                          {{ $n(index + 1) }}
                                        </b-td>
                                        <b-td v-for="(ditem, dindex) in item" :key="dindex">
                                          {{ ditem }}
                                        </b-td>
                                      </b-tr>
                                  </b-table-simple>
                                </b-col>
                              </div>
                            </b-tab>
                          </b-tabs>
                        </b-card>
                      </b-col>
                    </b-row>
                  </b-overlay>
              </div>
            </div>
            <div class="row mt-3">
              <div class="col text-right">
                <b-button @click="$router.go(-1)" variant="primary" class="mr-1"><i style="margin-right: 0px !important" class="ri-arrow-drop-left-line"></i>{{ $t('globalTrans.back') }}</b-button>
              </div>
            </div>
          </template>
        </body-card>
      </card>
    </div>
  </b-container>
</template>
<script>
import Vue from 'vue'
import Input from '@/components/license/user/dissableField/input-field'
import Dropdown from '@/components/license/user/dissableField/dropdown-field'
import Checkbox from '@/components/license/user/dissableField/checkbox-field'
import Attachment from '@/components/license/user/dissableField/attachment-field-user'
import Radio from '@/components/license/user/dissableField/radio-field'
import Textarea from '@/components/license/user/dissableField/textarea-field'
import Paragraph from '@/components/license/user/dissableField/paragraph-field'
import Date from '@/components/license/user/dissableField/date-field'
import Header from '@/components/license/user/dissableField/header-field'
import Payment from '@/components/license/user/dissableField/payment'
import PaymentCheckbox from '@/components/license/user/dissableField/payment-checkbox'
import RelationalCheckbox from '@/components/license/user/dissableField/relational-checkbox'
import RelationalDetails from '@/components/license/user/dissableField/relational-details'
import AddMoreDetails from '@/components/license/user/dissableField/addMoreDetails'
import { GridLayout, GridItem } from 'vue-grid-layout'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { applicationFormData } from '../../api/routes'
import { snakeToWords, isNotEmpty } from '@/utils/fliter.js'
import VueHtmlToPaper from 'vue-html-to-paper'
const options = {
  name: '_blank',
  specs: [
    'fullscreen=yes',
    'titlebar=yes',
    'scrollbars=no'
  ],
  styles: [
    'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css',
    'https://cdn.jsdelivr.net/npm/remixicon@2.5.0/fonts/remixicon.css',
    'http://service.moa.gov.bd/step.css'
  ],
  autoClose: true
}
Vue.use(VueHtmlToPaper, options)
export default {
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
    Payment,
    PaymentCheckbox,
    RelationalCheckbox,
    RelationalDetails
  },
  data () {
    return {
      officeCategoryShow: false,
      save_status: 1,
      officeItemSHow: false,
      ItemShow: false,
      inputFieldShow: false,
      ItemShowPer: false,
      CityCorpItemShow: false,
      CityCorpItemPerShow: false,
      PauroshobaItemShow: false,
      PauroshobaItemPerShow: false,
      addmore_update: false,
      addmore_update2: false,
      addmore_updateData: '',
      addmore_updateData2: '',
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
      relationDataAll: [],
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
        upazilla_id: 0,
        type: 0
      },
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      officeList: [],
      applicationInfo: '',
      addDetail: 1,
      officeCategoryList: [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Division' : 'বিভাগ' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'District' : 'জেলা' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Upazila' : 'উপজেলা' }
      ]
    }
  },
  created () {
    this.gridSearch.org_id = parseInt(this.$route.query.org_id)
    this.gridSearch.service_id = parseInt(this.$route.query.service_id)
    this.stepList = this.getServiceStep(parseInt(this.$route.query.service_id))
    this.step_id = parseInt(this.$route.query.step_id)
    this.loadFrom(parseInt(this.$route.query.service_id))
  },
  watch: {
    tabIndex: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.updateLayout()
      }
    }
  },
  computed: {
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
      const divList = this.$store.state.ExternalUserService.dealerPanel.commonObj.divisionList.filter(item => item.status === 1)
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
    getLayoutItemColumnsData (addMoreLayoutItem) {
      const cols = []
      cols.push({ text_en: 'SL', text_bn: 'ক্রমিক নং' })
      const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
      fieldData.fields.forEach(i => {
        const field = this.formInputData.find(item => item.id === i)
        cols.push({ text_en: field.label, text_bn: field.label_bn })
      })
      return cols
    },
    getAddMoreData (addMoreLayoutItem) {
      const datas = []
      const addData = []
      this.detailsData.forEach(item => {
        item.forEach(itm => {
          if (itm.id === addMoreLayoutItem.i) {
            addData.push(itm)
          }
        })
      })
      addData.forEach(item => {
          const newFindData = Object.keys(item).reduce((obj, key) => {
            if (key !== 'id') {
              obj[key] = item[key]
            }
            return obj
          }, {})
          datas.push(newFindData)
      })
      return datas
    },
    printDiv () {
      this.$htmlToPaper('printArea')
    },
    getOfficeCategory (officeCategoryID) {
      const officeCategory = this.officeCategoryList.find(item => item.value === officeCategoryID)
      return officeCategory !== undefined ? officeCategory.text : ''
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
      const stepList = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.filter(item => item.service_id === sId)
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
          id: formId,
          service_id: this.$route.query.service_id,
          step_id: this.getGridStep(this.gridSearch.service_id).step_id,
          applicationID: parseInt(this.$route.query.application_id)
        }
        RestApi.getData(licenseRegistrationServiceBaseUrl, applicationFormData, params).then(response => {
          this.loading = false
          if (isNotEmpty(response.data)) {
            if (response.data.applicationData[0].add_more_update !== '' && this.$route.query.service_id === 22) {
              this.addmore_update = true
              this.addmore_update2 = true
              this.addmore_updateData = JSON.parse(response.data.applicationData[0].add_more_update)
              this.addmore_updateData2 = JSON.parse(response.data.applicationData[0].add_more_update_1)
            } else {
              this.addmore_update = false
              this.addmore_update2 = false
            }
            this.applicationInfo = response.data.applicationInfo
            this.getAreaTypeData(response.data.applicationInfo.area_type_id)
            this.officeData = response.data.applicationInfo
            this.formActions = JSON.parse(response.data.item.form_action)
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            response.data.item.tabs.forEach((item, tabIndex) => {
              const tabNo = item.tab_no
              const tabName = item.tab_name
              const tabTitle = snakeToWords(item.tab_name)
              const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
              this.tabData.push(data)
              item.layouts.forEach((layItem) => {
                const layJson = JSON.parse(layItem.layout)
                const dataJson = JSON.parse(layItem.data)
                this.layoutData.push(layJson)
                if (response.data.applicationData !== null) {
                  response.data.applicationData.map((item, index) => {
                      if (item !== null) {
                      this.table_id = item.id
                      this.BackButtonShow = true
                      Object.keys(item).forEach(key => {
                          if (key === dataJson.field_name) {
                            if (dataJson.field_type === 'options') {
                              Object.assign(dataJson, { value: item[key] })
                            } else if (dataJson.field_type === 'addMore_button') {
                              this.addMoreDetailsShow(JSON.parse(item[key]), dataJson.id)
                            } else if (dataJson.field_type === 'RelationalField') {
                              Object.assign(dataJson, { value: item[key] })
                            } else if (dataJson.field_type === 'number') {
                              Object.assign(dataJson, { value: this.$n(item[key], { useGrouping: false }) })
                            } else if (dataJson.field_type === 'text') {
                              if (isNaN(item[key])) {
                                Object.assign(dataJson, { value: item[key] })
                              } else {
                                Object.assign(dataJson, { value: this.$n(item[key], { useGrouping: false }) })
                              }
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
                this.formInputData.push(dataJson)
                this.tindex++
              })
            })
            this.totalTab = this.tabData.length - 1
          }
          this.unitLoad = false
          this.updateLayout()
        })
      }
    },
    addMoreDetailsShow (data, id) {
      data.forEach(item => {
        Object.assign(item, { id: id })
      })
      this.detailsData.push(data)
      this.addDetail = this.addDetail + 1
    },
    updateDropdown: function (updata, nindex) {
      this.componentKey += 1
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    getAddmoreheight (i) {
      let lengthAdd = 2
      this.detailsData.forEach(item => {
        if (item.length > 0) {
          if (item[0].id === i) {
            if (item.length > 1) {
              lengthAdd = (item.length + 1) * 2 + 2
            } else {
              lengthAdd = 8
            }
          }
        }
      })
      return lengthAdd
    },
    updateLayout: function (val) {
      const allAddMoreField = this.removeAddMoreField()
      this.layout = []
      this.formIData = []
      this.layoutData.map((item, index) => {
        const checkI = allAddMoreField.find(i => i === item.i)
        if (typeof checkI === 'undefined') {
          if (item.tabIndex === this.tabIndex && item.is_show === false) {
            if (item.dataType === 'Add More') {
              item.h = this.getAddmoreheight(item.i)
            }
            const inpData = this.formInputData[index]
            this.layout.push(item)
            this.formIData.push(inpData)
          }
        }
      })
    },
    removeAddMoreField () {
      const allField = []
      this.layoutData.map((item, index) => {
        if (item.dataType === 'Add More') {
          this.formInputData[index].fields.forEach(item => {
            allField.push(item)
          })
        }
      })
      return allField
    },
    componentsShow (data, id, value) {
      if (value === true) {
        const relData = {
          layout: [],
          formIData: []
        }
        let height = 0
        data.map(item => {
          const layFind = this.layoutData.find(litem => litem.i === item && litem.tabIndex === this.tabIndex)
          height = height + layFind.h
          const inpFind = this.formInputData.find(litem => litem.id === item && litem.indexId === this.tabIndex)
          relData.layout.push(layFind)
          relData.formIData.push(inpFind)
        })
        const layoutH = this.layout.find(item => item.i === id)
        layoutH.h = height
        this.relationDataAll[id] = relData
      } else {
        const layoutH = this.layout.find(item => item.i === id)
        layoutH.h = 2
        const relData = {
          layout: [],
          formIData: []
        }
        this.relationDataAll[id] = relData
      }
      this.layout.push()
    },
    getServiceList (orgId) {
      return this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.filter(item => (item.org_id === orgId))
     /*  return tmpService.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.service_id, text: item.service_name_bn }
        } else {
          return { value: item.service_id, text: item.service_name }
        }
      }) */
    },
    getOrgName (orgId) {
      const org = this.$store.state.CommonService.commonObj.orgProfileList.find(item => item.value === parseInt(orgId))
      if (typeof org === 'undefined') {
        return ''
        } else {
        return org.text
      }
    },
    singleAreaType (areaId) {
      const area = this.areaTypeList.find(item => parseInt(item.value) === areaId)
      if (area) {
        return area.text
      }
    },
    singleOfficeType (officeTypeId) {
      const officetype = this.$store.state.CommonService.commonObj.officeTypeList.find(item => item.value === officeTypeId)
      if (officetype) {
        if (this.$i18n.locale === 'bn') {
          return officetype.text_bn
        } else {
          return officetype.text_en
        }
      }
    },
    singleOffice (officeId) {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === officeId)
      if (office) {
        if (this.$i18n.locale === 'bn') {
          return office.text_bn
        } else {
          return office.text_en
        }
      }
    },
    singleDivision (divisonId) {
      const divison = this.$store.state.CommonService.commonObj.divisionList.find(item => item.status === 0 && item.value === parseInt(divisonId))
      if (divison) {
        if (this.$i18n.locale === 'bn') {
          return divison.text_bn
        } else {
          return divison.text_en
        }
      }
    },
    singleDistrict (districtId) {
      const district = this.$store.state.CommonService.commonObj.districtList.find(item => item.status === 0 && item.value === parseInt(districtId))
      if (district) {
        if (this.$i18n.locale === 'bn') {
          return district.text_bn
        } else {
          return district.text_en
        }
      }
    },
    singleUpazilla (upazilaId) {
      const upazila = this.$store.state.CommonService.commonObj.upazilaList.find(item => item.status === 0 && item.value === parseInt(upazilaId))
      if (upazila) {
        if (this.$i18n.locale === 'bn') {
          return upazila.text_bn
        } else {
          return upazila.text_en
        }
      }
    },
    getStepOrder (stepId) {
      const step = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceSteps.find(item => (item.service_id === parseInt(this.$route.query.service_id) && item.step_id === parseInt(stepId)))
      if (typeof step === 'undefined') {
        return 0
      } else {
        return step.order
      }
    },
    singleCityCorporation (cityCorporaId) {
      const cityCorporation = this.$store.state.ExternalUserService.dealerPanel.commonObjCommonConfig.cityCorporationList.find(item => item.status === 0 && item.value === parseInt(cityCorporaId))
      if (cityCorporation) {
        if (this.$i18n.locale === 'bn') {
          return cityCorporation.text_bn
        } else {
          return cityCorporation.text_en
        }
      }
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    getServiceName (sId) {
      const service = this.$store.state.ExternalUserService.dealerPanel.commonObj.serviceNamesList.find(item => item.value === parseInt(sId))
      if (parseInt(service.office_category_check) === 1) {
        this.officeCategoryShow = true
      } else {
        this.officeCategoryShow = false
      }
      return service.text_en
    },
    getStepName (stId) {
      const step = this.$store.state.ExternalUserService.dealerPanel.commonObj.stepNamesList.find(item => item.value === parseInt(stId))
      return step.text_en
    },
    getDistrictList (divisionId = null) {
      let districtList = this.$store.state.ExternalUserService.dealerPanel.commonObj.districtList.filter(item => item.status === 1)
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
      let upazilaList = this.$store.state.ExternalUserService.dealerPanel.commonObj.upazilaList.filter(item => item.status === 1)
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
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
      if (officeTypeId) {
        return officeList.filter(item => item.office_type_id === officeTypeId)
      }
      return officeList
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
    @media print {
      footer {page-break-after: always;}
    }
</style>
