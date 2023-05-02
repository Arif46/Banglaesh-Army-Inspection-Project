<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('bfti.submit_survey') }}</h4>
      </template>
      <template v-slot:searchBody>
        <!-- <b-row>
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="research_id"
            >
              <template v-slot:label>
                {{$t('bfti.research')}}
              </template>
              <b-form-select
                plain
                v-model="surveyInfo.research_id"
                :options="researchRequestList"
                id="research_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="survey_id"
            >
              <template v-slot:label>
                {{$t('survey_management.survey')}}
              </template>
              <b-form-select
                plain
                v-model="surveyInfo.survey_id"
                :options="surveyList"
                id="survey_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
        </b-row> -->
        <b-row>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-overlay :show="unitLoad">
              <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
                <b-row>
                  <b-col md="12" lg="12" sm="12">
                    <b-card no-body>
                      <b-tabs>
                        <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                          <template v-slot:title>
                            <span>{{ local === 'bn' ? surveyInfo.form_title_bn : surveyInfo.form_title }}</span>
                          </template>
                          <template :id="index">
                            <b-overlay :show="loading">
                              <b-row v-if="tindex > 0">
                                <b-col md="12" lg="12" sm="12">
                                  <ValidationObserver>
                                    <fieldset>
                                      <grid-layout :layout.sync="layout"
                                        :col-num="colNum"
                                        :row-height="13"
                                        :is-draggable="false"
                                        :is-resizable="false"
                                        :vertical-compact="true"
                                        :use-css-transforms="false"
                                        :key="layoutKey"
                                      >
                                        <grid-item v-for="(item, dindex) in layout"
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
                                          <Dropdown :data="formIData[dindex]" :drpChangeData="formIData[dindex + 1]" v-if="item.dataType === 'Dropdown'"/>
                                          <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                          <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                          <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                          <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                          <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                          <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                          <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                          <QRCode :data="formIData[dindex]" v-if="item.dataType === 'QRCode'"/>
        <!--                                  <AddMore @addDetails="addMoreDetailsShow" :tmpData="formIData[dindex]" :data="formIData" v-if="item.dataType === 'Add More'" />-->
                                          <Empty :data="formIData[dindex]" v-if="item.dataType === 'Empty'"/>
                                          <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                          <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                                          <SameAsField @updateSameData="updateSameAsData" :data="formIData[dindex]" v-if="item.dataType === 'SameAs'"/>
                                        </b-row>
                                          <template v-if="item.dataType === 'RelationalField'">
                                            <b-row>
                                              <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                              <RelationalDetails :tmpData="relationDataAll[item.i]" :key="updateDet"/>
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
                                    </fieldset>
                                  </ValidationObserver>
                                </b-col>
                              </b-row>
                            </b-overlay>
                            <div class="row">
                              <div class="col text-right">
                                <b-button v-if="formActions.isDraft" @click="save_status = 1" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                                <b-button v-if="formActions.isSubmit" @click="save_status = 2" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                <b-button v-if="formActions.isReset" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                                <router-link v-if="formActions.isCancel" to="/bfti-panel/survey-list" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                                <b-button v-if="formActions.isPayment" @click="reset()" variant="warning" class="mr-1">{{ $t('component_settings.payment') }}</b-button>
                              </div>
                            </div>
                          </template>
                        </b-tab>
                      </b-tabs>
                    </b-card>
                  </b-col>
                </b-row>
              </b-form>
            </b-overlay>
          </ValidationObserver>
        </b-row>
      </template>
    </card>
  </div>
</template>
<script>
import flatpickr from 'flatpickr'
import Input from '../components/input-field'
import Dropdown from '../components/dropdown-field'
import Checkbox from '../components/checkbox-field'
import Attachment from '../components/attachment-field'
import Radio from '../components/radio-field'
import Textarea from '../components/textarea-field'
import Paragraph from '../components/paragraph-field'
import Date from '../components/date-field'
import Header from '../components/header-field'
import QRCode from '../components/qrcode-field'
import Empty from '../components/empty-field'
import AddMore from '../components/addMore-field'
import AddMoreDetails from '../components/addMoreDetails'
import Payment from '../components/payment'
import PaymentCheckbox from '../components/payment-checkbox'
import SameAsField from '../components/sameas-field'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver } from 'vee-validate'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { getSurveyForm, surveyStoreApi } from '../../api/routes'
import { wordsToSnake, isNotEmpty } from '@/utils/fliter'
import RelationalCheckbox from '../components/relational-checkbox'
import RelationalDetails from '../components/relational-details'
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
    QRCode,
    Empty,
    AddMore,
    AddMoreDetails,
    Payment,
    PaymentCheckbox,
    RelationalCheckbox,
    RelationalDetails,
    SameAsField
  },
  data () {
    return {
      layoutKey: 0,
      isEdit: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      layout: [],
      layoutData: [],
      componentList: [
        { x: 2, y: 0, w: 2, h: 2, i: '0', dataType: 'InputField', text: 'Input Field', icon: 'fa fa-pen' },
        { x: 2, y: 0, w: 2, h: 2, i: '1', dataType: 'Dropdown', text: 'Dropdown', icon: 'fa fa-list' },
        { x: 2, y: 0, w: 2, h: 2, i: '2', dataType: 'Attachment', text: 'Image', icon: 'fas fa-image' },
        { x: 4, y: 0, w: 2, h: 2, i: '3', dataType: 'Textarea', text: 'Textarea', icon: 'fa fa-info-circle' },
        { x: 2, y: 0, w: 2, h: 2, i: '4', dataType: 'Checkbox', text: 'Checkbox', icon: 'fa fa-check-square' },
        { x: 2, y: 0, w: 2, h: 2, i: '5', dataType: 'Radio', text: 'Radio', icon: 'fa fa-dot-circle' },
        { x: 2, y: 0, w: 2, h: 2, i: '6', dataType: 'Paragraph', text: 'Paragraph', icon: 'fa fa-paragraph' },
        { x: 2, y: 0, w: 2, h: 2, i: '7', dataType: 'Date', text: 'Date', icon: 'fa fa-calendar' },
        { x: 2, y: 0, w: 2, h: 2, i: '8', dataType: 'Header', text: 'Header', icon: 'fa fa-calendar' },
        { x: 2, y: 0, w: 2, h: 2, i: '9', dataType: 'QRCode', text: 'QR Code', icon: 'fa fa-qrcode' },
        { x: 2, y: 0, w: 2, h: 2, i: '10', dataType: 'Empty', text: 'Empty Space', icon: 'fa fa-border-all' },
        { x: 2, y: 0, w: 2, h: 2, i: '11', dataType: 'Add More', text: 'Add More', icon: 'fa fa-plus' }
      ],
      draggable: true,
      resizable: true,
      colNum: 12,
      index: 0,
      tindex: 0,
      surveyInfo: {
        research_id: 0,
        survey_id: 0,
        form_title: ''
      },
      surveyList: [],
      update: false,
      unitLoad: false,
      loading: false,
      isFinal: false,
      editIndex: '',
      editData: '',
      stepList: [],
      formInputData: [],
      relationDataAll: [],
      formIData: [],
      toAdd: '',
      formTitle: '',
      tabData: [
        {
          tab_no: 0,
          tab_title: 'Default Tab',
          tab_title_bn: 'ডিফল্ট ট্যাব',
          tab_name: 'default_tab'
        }
      ],
      la: '',
      tabIndex: 0,
      tabUpdate: false,
      tabSettings: {
        tab_no: '',
        tab_title: '',
        tab_title_bn: '',
        tab_name: ''
      },
      tUpId: '',
      componentKey: 0,
      save_status: 1,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      sInfo: {},
      formActions: {
        isDraft: false,
        isSubmit: false,
        isReset: false,
        isPayment: false,
        isCancel: false
      },
      addIndex: '',
      addMoreLayoutData: [],
      detailsDataAll: {}
    }
  },
  created () {
    if (this.$route.query.id) {
      this.isEdit = true
      this.edit(this.$route.query.id)
      this.tabChange(0)
    }
    if (this.$route.params.id) {
      this.surveyInfo.survey_id = this.$route.params.id
    }
  },
  mounted () {
    flatpickr('#datepicker', {})
    const oldId = this.layout[this.layout.length - 1]
    if (typeof oldId === 'undefined') {
      this.index = 0
    } else {
      this.index = oldId.i + 1
    }
  },
  watch: {
    'surveyInfo.survey_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.getSurveyForm(newVal)
      }
    }
  },
  computed: {
    inputTypeList: function () {
      return this.inputOptionList.map(item => {
        return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    local: function () {
        return this.$i18n.locale
    },
    researchRequestList () {
      return this.$store.state.ExternalUserService.bftiPanel.commonObj.researchRequestList.filter(item => item.status === 2)
    }
  },
  methods: {
    getSurveyForm (surveyId) {
      const params = {
        survey_id: surveyId
      }
      this.unitLoad = true
      RestApi.getData(bftiResReportServiceBaseUrl, getSurveyForm, params).then(response => {
        if (isNotEmpty(response.data)) {
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          this.surveyInfo.form_title = response.data.form_title
          this.formActions = JSON.parse(response.data.form_action)
          response.data.tabs.forEach((item, tabIndex) => {
            const tabNo = item.tab_no
            const tabName = item.tab_name
            const tabTitle = item.tab_title
            const tabTitleBn = item.tab_title_bn
            const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle, tab_title_bn: tabTitleBn }
            this.tabData.push(data)
            item.layouts.forEach((layItem) => {
              const layJson = JSON.parse(layItem.layout)
              const dataJson = JSON.parse(layItem.data)
              this.layoutData.push(layJson)
              this.formInputData.push(dataJson)
              this.tindex++
              this.index = layJson.i + 1
            })
            const addMoreLayoutData = this.layoutData.filter(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
            this.addMoreLayoutData = addMoreLayoutData
            if (addMoreLayoutData.length) {
              addMoreLayoutData.forEach((addMoreLayoutItem) => {
                const cols = []
                // const addMoreLayoutItem = this.layoutData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
                // if (addMoreLayoutItem !== undefined) {
                  const fieldData = this.formInputData.find(item => item.id === addMoreLayoutItem.i)
                  fieldData.fields.forEach(i => {
                    const field = this.formInputData.find(item => item.id === i)
                    cols.push(field.label)
                  })
                  cols.push('Action')
                  this.Addcolumns.push(cols)
                  this.addMore = true
                  this.addIndex = addMoreLayoutItem.tabIndex
                  this.detailsDataAll[addMoreLayoutItem.i] = []
                // }
              })
            }
          })
        }
        this.unitLoad = false
        this.updateLayout()
      })
    },
    reset () {
      this.index = 0
      this.surveyInfo.form_title = ''
      this.tabData = [
        {
          tab_no: 0,
          tab_title: 'Default Tab',
          tab_title_bn: 'ডিফল্ট ট্যাব',
          tab_name: 'default_tab'
        }
      ]
      this.formInputData = []
      this.formIData = []
      this.layout = []
      this.$nextTick(() => {
        this.$refs.form.reset()
      })
      this.updateLayout()
    },
    updateLayout: function (val) {
      this.layout = []
      this.formIData = []
      this.layoutData.map((item, index) => {
        if (item.tabIndex === this.tabIndex && item.is_show === false) {
          const inpData = this.formInputData[index]
          this.layout.push(item)
          this.formIData.push(inpData)
        }
      })
      this.layoutKey = this.layoutKey + 1
    },
    updatePage: function (updata, nindex) {
      this.layout.push(this.layoutData[nindex])
      this.formIData.push(updata)
    },
    wordsToSnake (val) {
      return wordsToSnake(val)
    },
    isNotEmpty (val) {
      return isNotEmpty(val)
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    inputData (data, modalName) {
      if (this.update === true) {
        if (data.field_type !== 'text') {
          data.field_name = data.field_name + '_' + data.id
        }
        const fIData = this.formIData[this.editIndex]
        const formData = this.formInputData.find(item => item.indexId === this.tabIndex && item.id === fIData.id)
        const arrIndex = this.formInputData.indexOf(formData)
        this.formInputData[arrIndex] = data
        this.editIndex = ''
        this.update = false
        this.editData = ''
        this.$bvModal.hide(modalName)
        this.updateLayout()
      } else {
        data.id = this.index
        data.field_name = data.field_name + '_' + this.index
        data.indexId = this.tabIndex
        this.formInputData.push(data)
        this.addLayout()
        this.$bvModal.hide(modalName)
        if (modalName === 'modal-10') {
          data.fields.forEach(i => {
            this.Addcolumns.push({ text_en: this.formInputData[i].label, text_bn: this.formInputData[i].label_bn })
          })
          this.Addcolumns.push('Action')
          this.addMore = true
        }
      }
    },
    addLayout () {
      this.la = {
        x: (this.layout.length * 2) % (this.colNum || 12),
        y: this.layout.length + (this.colNum || 12),
        w: 2,
        h: this.findHeight(),
        i: this.index,
        dataType: this.toAdd,
        tabIndex: this.tabIndex
      }
      this.layoutData.push(this.la)
      this.updateLayout()
      this.index++
      this.tindex++
    },
    findHeight () {
      if (this.toAdd === 'Textarea') {
        return 3
      } else if (this.toAdd === 'Attachment') {
        return 4
      } else if (this.toAdd === 'Add More') {
        return 10
      } else {
        return 2
      }
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
    addButton (type) {
      if (type === 1) {
        this.formActions.isDraft = true
      } else if (type === 2) {
        this.formActions.isSubmit = true
      } else if (type === 3) {
        this.formActions.isReset = true
      } else if (type === 4) {
        this.formActions.isCancel = true
      } else {
        this.formActions.isPayment = true
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
    updateSameAsData (updata, status) {
      if (updata && status) {
        updata.fields.forEach((i, index) => {
          const sameField = updata.same_fields[index]
          const formField = this.formInputData.find(item => item.id === i)
          const formSameField = this.formInputData.find(item => item.id === sameField)
          formSameField.value = formField.value
        })
      } else {
        updata.same_fields.forEach(i => {
          const formSameField = this.formInputData.find(item => item.id === i)
          formSameField.value = ''
        })
      }
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
            if (item.field_type !== 'empty' && item.field_type !== 'paragraph' && item.field_type !== 'image' && item.field_type !== 'h1' && item.field_type !== 'h2' && item.field_type !== 'h3' && item.field_type !== 'h4' && item.field_type !== 'h5' && item.field_type !== 'h6' && item.field_type !== 'sameAs_button') {
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
      this.sInfo.survey_id = this.surveyInfo.survey_id
      this.sInfo.tabInfo = this.tabData
      const formData = {
        formInputData: this.formInputData,
        data: sData,
        survey_info: this.sInfo,
        fileData: pData,
        personaInfo: {
          name: this.$store.state.Auth.authUser.name,
          name_bn: this.$store.state.Auth.authUser.name_bn
        }
      }
      let result = null
      this.saveloading = true
      result = await RestApi.postData(bftiResReportServiceBaseUrl, surveyStoreApi, formData)
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
    }
  }
}
</script>
<style scoped>
.inputSection {
  margin-top: 10px;
}
.remove {
    position: absolute;
    right: 2px;
    top: 0;
    cursor: pointer;
    z-index: 999;
}
.edit {
    position: absolute;
    right: 17px;
    top: 0;
    cursor: pointer;
    font-size: 12px;
    z-index: 999;
}
.vue-grid-layout {
    background: #eee;
    min-height: 130px;
}
.vue-grid-item .resizing {
    opacity: 0.9;
    background: green;
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
.vue-draggable-handle {
    position: absolute;
    width: 5px;
    height: 5px;
    top: 0;
    left: 0;
    bottom: 0;
    background: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='10' height='10'><circle cx='5' cy='5' r='5' fill='#999999'/></svg>") no-repeat;
    background-position: bottom right;
    padding: 0 2px 2px 0;
    background-repeat: no-repeat;
    background-origin: content-box;
    box-sizing: border-box;
    cursor: pointer;
}
.fields {
  padding: 0.375rem 0.75rem;
  margin: 4px;
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
