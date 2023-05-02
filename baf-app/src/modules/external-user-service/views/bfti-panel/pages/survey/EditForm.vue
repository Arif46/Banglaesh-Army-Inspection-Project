<template>
  <b-container fluid>
    <div class="inner-section">
      <body-card>
        <template v-slot:body>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-overlay :show="unitLoad">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" v-if="tindex > 0">
              <b-overlay :show="saveloading">
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
                                    <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'" />
                                    <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'" />
                                    <Empty :data="formIData[dindex]" v-if="item.dataType === 'Empty'"/>
                                  </b-row>
                                  <template v-if="item.dataType === 'RelationalField'">
                                    <b-row>
                                      <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                      <RelationalDetails :tmpData="relationDataAll[item.i]"/>
                                    </b-row>
                                  </template>
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
                            <div class="row">
                              <div class="col text-right">
                                <b-button v-if="index !== 0" @click="tabIndex--" variant="primary" class="mr-2">{{ $t('component_settings.prev_tab') }}</b-button>
                                <b-button v-if="index < totalTab && index !== totalTab" @click="tabIndex++" variant="primary" class="mr-2">{{ $t('component_settings.next_tab') }}</b-button>
                                <b-button v-if="formActions.isDraft && index === totalTab" @click="save_status = 1" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                                <b-button v-if="formActions.isSubmit && index === totalTab" @click="save_status = 2" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                <b-button v-if="formActions.isReset && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                                <router-link v-if="formActions.isCancel && index === totalTab" to="survey-list" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
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
          </b-overlay>
          </ValidationObserver>
        </template>
      </body-card>
    </div>
  </b-container>
</template>
<script>
import Input from '../components/input-field'
import Dropdown from '../components/dropdown-field'
import Checkbox from '../components/checkbox-field'
import Attachment from '../components/attachment-field-edit'
import Radio from '../components/radio-field'
import Textarea from '../components/textarea-field'
import Paragraph from '../components/paragraph-field'
import Date from '../components/date-field'
import Header from '../components/header-field'
import Empty from '../components/empty-field'
import AddMore from '../components/addMore-field'
import AddMoreDetails from '../components/addMoreDetails'
import Payment from '../components/payment'
import PaymentCheckbox from '../components/payment-checkbox'
import RelationalCheckbox from '../components/relational-checkbox'
import RelationalDetails from '../components/relational-details'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver } from 'vee-validate'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { applicationFormData, surveyUpdateApi, loadOldFormData } from '../../api/routes'
import { snakeToWords, isNotEmpty } from '@/utils/fliter.js'
export default {
  components: {
    Empty,
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    ValidationObserver,
    Radio,
    Textarea,
    Paragraph,
    Date,
    Header,
    AddMore,
    AddMoreDetails,
    Payment,
    PaymentCheckbox,
    RelationalCheckbox,
    RelationalDetails
  },
  data () {
    return {
      layoutKey: 0,
      officeTypeShow: false,
      officeCategoryShow: false,
      save_status: 1,
      isOfficeSelected: false,
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
        survey_id: 0,
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
        office_id: 0,
        office_cat_id: 0
      },
      relationDataAll: [],
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
    this.loadFrom(parseInt(this.$route.params.id))
  },
  mounted () {
  },
  computed: {
    local: function () {
      return this.$i18n.locale
    },
    areaTypeList: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'bn' ? 'সিটি কর্পোরেশন' : 'City Corpoation' },
        { value: 2, text: this.$i18n.locale === 'bn' ? 'পৌরসভা' : 'Pauroshoba' },
        { value: 3, text: this.$i18n.locale === 'bn' ? 'উপজেলা' : 'Upazila' }
      ]
      return list
    }
  },
  methods: {
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    loadFrom () {
      const params = {
        id: this.$route.query.form_id,
        survey_id: this.$route.query.survey_id,
        applicationID: parseInt(this.$route.query.application_id)
      }
      RestApi.getData(bftiResReportServiceBaseUrl, applicationFormData, params).then(response => {
          this.loading = false
          if (isNotEmpty(response.data)) {
            this.isShowManual = true
            this.formActions = JSON.parse(response.data.item.form_action)
            this.layoutData = []
            this.formInputData = []
            this.tabData = []
            response.data.item.tabs.forEach((item, tabIndex) => {
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
          this.loadApplicationData()
        })
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
      this.layoutKey = this.layoutKey + 1
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
     getLayoutItemColumnsData (addMoreLayoutItem) {
      const cols = []
      const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
      fieldData.fields.forEach(i => {
        const field = this.formInputData.find(item => item.id === i)
        cols.push({ text_en: field.label, text_bn: field.label_bn })
      })
      return cols
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
              if (item.value && typeof item.value !== 'string') {
                fData.images.push({ field_name: item.field_name, value: item.value, fieldType: item.field_type, tabId: item.indexId })
              }
            }
          }
        })
        sData.push(tData)
        pData.push(fData)
      })
      this.sInfo.save_status = this.save_status
      this.sInfo.application_id = parseInt(this.$route.query.application_id)
      this.sInfo.survey_id = this.$route.query.survey_id
      this.sInfo.tabInfo = this.tabData
      if (parseInt(this.$route.query.type)) {
        this.officeData.type = parseInt(this.$route.query.type)
      }
      const formData = {
        formInputData: this.formInputData,
        data: sData,
        survey_info: this.sInfo,
        officeData: this.officeData,
        fileData: pData,
        prevManualData: this.prevManualData
      }
      let result = null
      this.saveloading = true
      result = await RestApi.putData(bftiResReportServiceBaseUrl, `${surveyUpdateApi}/${this.table_id}`, formData)
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
        this.$router.push('/bfti-panel/survey-list')
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
    loadApplicationData () {
      const params = {
        form_id: this.$route.query.form_id,
        application_id: this.$route.query.application_id,
        survey_id: this.$route.query.survey_id
      }
      RestApi.getData(bftiResReportServiceBaseUrl, loadOldFormData, params).then(response => {
        if (response.success) {
          if (response.data && response.app_data) {
            Object.keys(response.app_data).forEach(key => {
              const data = response.data.details.find(item => item.field_id_to === key)
              if (typeof data !== 'undefined') {
                const input = this.formInputData.find(item => item.field_name === key)
                if (typeof input !== 'undefined') {
                  input.value = response.app_data[key]
                }
              }
            })
          }
        }
      })
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
