<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
          <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" v-if="tindex > 0">
            <b-overlay :show="saveloading">
              <b-row>
                <b-col md="12" lg="12" sm="12">
                  <b-button variant="primary" class="mr-4" @click="print" style="float: right;"><i class="fa fa-print"> {{ $t('globalTrans.print') }} </i></b-button>
                </b-col>
                <b-col md="12" lg="12" sm="12">
                  <b-card no-body>
                    <b-tabs v-model="tabIndex">
                      <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                        <template v-slot:title>
                          <span>{{ item.tab_title }}</span>
                        </template>
                        <template :id="index">
                          <span id="printMe">
                          <b-overlay :show="loading">
                            <b-row style="margin-top: 10px;">
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
                                    <Dropdown :data="formIData[dindex]" :drpChangeData="formIData[dindex + 1]" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
                                    <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                    <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                    <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                    <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                    <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                    <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                    <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                    <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                    <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'" />
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
                          </span>
                          <div class="row">
                            <div class="col text-right">
                              <b-button v-if="index !== 0" @click="tabIndex--" variant="primary" class="mr-2">{{ $t('component_settings.prev_tab') }}</b-button>
                              <b-button v-if="index < totalTab && index !== totalTab" @click="tabIndex++" variant="primary" class="mr-2">{{ $t('component_settings.next_tab') }}</b-button>
                              <b-button v-if="formActions.isDraft && index === totalTab" @click="save_status = 1" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                              <b-button v-if="formActions.isSubmit && index === totalTab" @click="save_status = 2" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
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
    </iq-card>
  </b-container>
</template>
<script>
import Vue from 'vue'
import Input from '@/components/license/user/input-field'
import Dropdown from '@/components/license/user/dropdown-field-admin'
import Checkbox from '@/components/license/user/checkbox-field'
import Attachment from '@/components/license/user/attachment-field'
import Radio from '@/components/license/user/radio-field'
import Textarea from '@/components/license/user/textarea-field'
import Paragraph from '@/components/license/user/paragraph-field'
import Date from '@/components/license/user/date-field'
import Header from '@/components/license/user/header-field'
import AddMore from '@/components/license/user/addMore-field'
import AddMoreDetails from '@/components/license/user/addMoreDetails'
import Payment from '@/components/license/user//payment'
import PaymentCheckbox from '@/components/license/user/payment-checkbox'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { actionFormStore, surveyDataStore, loadOldFormData } from '../../../api/routes'
import { wordsToSnake, snakeToWords, isNotEmpty } from '@/utils/fliter'
import VueHtmlToPaper from 'vue-html-to-paper'
Vue.use(VueHtmlToPaper)
export default {
  components: {
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
    PaymentCheckbox
  },
  data () {
    return {
      save_status: 1,
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
      formInputData: [],
      addMoreLayoutData: [],
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
      districtList: [],
      pauroshobaList: [],
      cityCorporationList: [],
      upazilaList: [],
      addIndex: '',
      detailsDataAll: {},
      pageStyle: {
        name: '_blank',
        specs: [
          'fullscreen=yes',
          'titlebar=yes',
          'scrollbars=yes'
        ],
        autoClose: true,
        styles: [
          'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
        ]
      }
    }
  },
  created () {
    this.loadFrom()
  },
  watch: {
    tabIndex: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.updateLayout()
      }
    }
  },
  methods: {
    print () {
      this.$htmlToPaper('printMe', this.pageStyle)
    },
    loadFrom () {
      this.unitLoad = true
      const params = {
        id: parseInt(this.$route.query.form_id)
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, actionFormStore, params).then(response => {
        if (isNotEmpty(response.data)) {
          this.formActions = JSON.parse(response.data.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          this.locationShow = true
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
            const addFind = this.layoutData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
            if (addFind !== undefined) {
              const fieldData = this.formInputData.find(item => item.id === addFind.i)
              fieldData.fields.forEach(i => {
                const field = this.formInputData.find(item => item.id === i)
                this.Addcolumns.push(field.label)
              })
              this.Addcolumns.push('Action')
              this.addMore = true
              this.addIndex = addFind.tabIndex
            }
          })
          this.totalTab = this.tabData.length - 1
          this.loadApplicationData()
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
                 if (item.value) {
                  tData[item.field_name] = item.value.toString()
                } else {
                  tData[item.field_name] = ''
                }
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
      this.sInfo.org_id = parseInt(this.$route.query.org_id)
      this.sInfo.service_id = parseInt(this.$route.query.service_id)
      this.sInfo.step_id = parseInt(this.$route.query.step_id)
      this.sInfo.application_id = parseInt(this.$route.query.application_id)
      this.sInfo.service_name = wordsToSnake(this.getServiceName(this.sInfo.service_id))
      this.sInfo.step_name = wordsToSnake(this.getStepName(this.$route.query.step_id))
      this.sInfo.tabInfo = this.tabData
      const formData = {
        formInputData: this.formInputData,
        data: sData,
        service_info: this.sInfo,
        fileData: pData
      }
      let result = null
      this.saveloading = true
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, surveyDataStore, formData)
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
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.go(-1)
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
    getLayoutItemColumnsData (addMoreLayoutItem) {
      const cols = []
      cols.push({ text_en: 'SL', text_bn: 'ক্রমিক নং' })
      const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
      fieldData.fields.forEach(i => {
        const field = this.formInputData.find(item => item.id === i)
        cols.push({ text_en: field.label, text_bn: field.label_bn })
      })
      cols.push({ text_en: 'Action', text_bn: 'অ্যাকশন' })
      return cols
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
    getServiceName (sId) {
      const service = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(item => item.value === sId)
      if (service !== 'undefined') {
        return service.text
      }
    },
    getStepName (stId) {
      const step = this.$store.state.licenseRegistration.commonObj.stepNamesList.find(item => item.value === parseInt(stId))
      if (step !== 'undefined') {
        return step.text
      }
    },
    loadApplicationData () {
      if (this.$route.query.form_id) {
        const formId = this.$route.query.form_id
        const params = {
          form_id: formId,
          service_id: parseInt(this.$route.query.service_id),
          grid_step_id: this.getEntryStep(parseInt(this.$route.query.service_id)).step_id,
          tabList: this.getTabList(),
          application_id: parseInt(this.$route.query.application_id)
        }
        RestApi.getData(licenseRegistrationServiceBaseUrl, loadOldFormData, params).then(response => {
          if (response.success) {
            if (response.data && response.app_data) {
              Object.keys(response.app_data).forEach(key => {
                const data = response.data.details.find(item => item.field_id_from === key)
                if (typeof data !== 'undefined') {
                  const input = this.formInputData.find(item => item.field_name === data.field_id_to)
                  if (typeof input !== 'undefined') {
                    input.value = response.app_data[key]
                  }
                }
              })
            }
          }
        })
      }
    },
    getEntryStep (serviceId) {
      const tmpService = this.$store.state.licenseRegistration.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
      }
    },
    getTabList () {
      const formId = this.getEntryStep(parseInt(this.$route.query.service_id)).form_id
      const form = this.$store.state.licenseRegistration.commonObj.dynamicFormList.find(item => item.value === formId)
      if (typeof form === 'undefined') {
        return []
      }
      return form.tabs
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
