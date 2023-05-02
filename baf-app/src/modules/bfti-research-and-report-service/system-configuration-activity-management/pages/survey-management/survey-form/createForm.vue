<template>
  <b-container fluid>
    <b-row class="inputSection" no-gutters>
      <b-col>
        <b-card class="text-left mt-2 bg-primary">
          <b-button variant="outline-light" v-for="item in componentList.slice(0, -3)" :key="item.i" @click="addItem(item)" class="mb-2 mr-1" size="sm">
            <i class="mr-1" :class="item.icon"></i><span class="mr-1" >{{item.text}}</span>
          </b-button>
          <b-dropdown left text="Buttons" size="sm" class="mt-0">
            <b-dropdown-item @click="addItem(componentList[11])">Add More</b-dropdown-item>
            <!-- <b-dropdown-item @click="addItem(componentList[12])">Relational Field</b-dropdown-item>
            <b-dropdown-item @click="addItem(componentList[13])">Same As</b-dropdown-item> -->
            <b-dropdown-item @click="addButton(1)">Save Draft</b-dropdown-item>
            <b-dropdown-item @click="addButton(2)">Submit</b-dropdown-item>
            <!-- <b-dropdown-item @click="addButton(3)">Reset</b-dropdown-item> -->
            <b-dropdown-item @click="addButton(4)">Cancel</b-dropdown-item>
          </b-dropdown>
        </b-card>
      </b-col>
    </b-row>
    <b-row>
      <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
        <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
          <b-overlay :show="unitLoad">
            <b-row>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Servey Name" vid="survey.survey_id" rules="required">
                  <b-form-group
                      class="row"
                      label-cols-sm="4"
                      label-for="survey_id"
                      slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{ $t('survey_management.survey_name') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="surveyInfo.survey_id"
                      :options="surveyList"
                      id="survey_id"
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
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Form title" vid="survey.form_title" rules="required">
                  <b-form-group
                      class="row"
                      label-cols-sm="4"
                      label-for="form_title"
                      slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('dynamic_form.form_title')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="form_title"
                        v-model="surveyInfo.form_title"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Form title Bn" vid="form_title_bn" rules="required">
                  <b-form-group
                      class="row"
                      label-cols-sm="4"
                      label-for="form_title_bn"
                      slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('dynamic_form.form_title_bn')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="form_title_bn"
                        v-model="surveyInfo.form_title_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
            </b-row>
          </b-overlay>
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
                            <grid-layout :layout.sync="layout"
                              :col-num="colNum"
                              :row-height="13"
                              :is-draggable="draggable"
                              :is-resizable="resizable"
                              :vertical-compact="true"
                              :use-css-transforms="true"
                              :key="layoutKey"
                            >
                              <grid-item v-for="(item, dindex) in layout" :key="dindex"
                                :x="item.x"
                                :y="item.y"
                                :w="item.w"
                                :h="item.h"
                                :i="item.i"
                                :dataType="item.dataType"
                              >
                                <b-row>
                                  <Input :tmpData="formIData" :index="dindex" v-if="item.dataType === 'InputField'" />
                                  <Dropdown :data="formIData[dindex]" v-if="item.dataType === 'Dropdown' "/>
                                  <Checkbox :data="formIData[dindex]" v-if="item.dataType === 'Checkbox'"/>
                                  <Attachment :data="formIData[dindex]" v-if="item.dataType === 'Attachment'"/>
                                  <Radio :data="formIData[dindex]" v-if="item.dataType === 'Radio'"/>
                                  <Textarea :data="formIData[dindex]" v-if="item.dataType === 'Textarea'"/>
                                  <Paragraph :data="formIData[dindex]" v-if="item.dataType === 'Paragraph'"/>
                                  <Date :data="formIData[dindex]" v-if="item.dataType === 'Date'"/>
                                  <Header :data="formIData[dindex]" v-if="item.dataType === 'Header'"/>
                                  <QRCode :data="formIData[dindex]" v-if="item.dataType === 'QRCode'"/>
                                  <AddMore @addDetails="addMoreDetailsShow" :tmpData="formIData[dindex]" :data="formIData" v-if="item.dataType === 'Add More'" />
                                  <Empty :data="formIData[dindex]" v-if="item.dataType === 'Empty'"/>
                                  <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                  <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'"/>
                                  <SameAsField :data="formIData[dindex]" v-if="item.dataType === 'SameAs'"/>
                                </b-row>
                                <template v-if="item.dataType === 'RelationalField'">
                                  <b-row>
                                    <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                    <RelationalDetails :tmpData="relationDataAll[item.i]" :key="updateDet"/>
                                  </b-row>
                                </template>
                                <span class="edit" @click="editItem(dindex)" v-if="item.dataType !== 'Empty'"><i class="ri-edit-line" style="font-size: 10px;z-index:999"></i></span>
                                <span class="remove" @click="removeItem(item.i)"><i class="ri-close-line"></i></span>
                              </grid-item>
                            </grid-layout>
                          </b-col>
                        </b-row>
                      </b-overlay>
                      <div class="row" v-if="addIndex === index">
                        <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns"/>
                      </div>
                      <div class="row">
                        <div class="col text-right">
                          <b-button v-if="formActions.isDraft" @click="isFinal = false" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                          <b-button v-if="formActions.isSubmit" @click="isFinal = true" variant="primary" class="mr-2">{{ $t('globalTrans.save') }}</b-button>
                          <b-button v-if="formActions.isReset" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                          <router-link v-if="formActions.isCancel" to="survey-form" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                        </div>
                      </div>
                      <hr />
                      <div class="row mt-4">
                        <div class="col-sm-3"></div>
                        <div class="col text-right">
                          <b-button @click="isFinal = false" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                          <b-button @click="isFinal = true" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                          <b-button @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                          <router-link to="survey-form" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                        </div>
                      </div>
                    </template>
                  </b-tab>
                </b-tabs>
              </b-card>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
    </b-row>
    <b-modal id="modal-1" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <InputModal @addInput="inputData" :formData="formInputData" :editData="editData" />
    </b-modal>
    <b-modal id="modal-2" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DropdownModal @addDropdown="inputData" :editData="editData" />
    </b-modal>
    <b-modal id="modal-3" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <CheckboxModal @addCheckbox="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-4" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <AttachmentModal :editData="editData" @addAttcahment="inputData" />
    </b-modal>
    <b-modal id="modal-5" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <RadioModal @addCheckbox="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-6" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <TextareaModal @addTextArea="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-8" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
       <ParagraphModal @addParagraph="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-7" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DateModal @addDate="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-9" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <HeaderModal @addHeader="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-10" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <AddMoreModal @addAddMore="inputData" :formData="formInputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-11" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <QRCodeModal @addQRCode="inputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-12" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <RelationalFieldModal @RelationalField="inputData" :formData="formInputData" :editData="editData"/>
    </b-modal>
    <b-modal id="modal-13" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <SameAsModal @sameAsField="inputData" :formData="formInputData" :editData="editData"/>
    </b-modal>
  </b-container>
</template>
<script>
import InputModal from '../components/create-modal/input-modal'
import DropdownModal from '../components/create-modal/dropdown-modal'
import CheckboxModal from '../components/create-modal/checkbox-modal'
import RadioModal from '../components/create-modal/radio-modal'
import AttachmentModal from '../components/create-modal/attachment-modal'
import TextareaModal from '../components/create-modal/textarea-modal'
import ParagraphModal from '../components/create-modal/paragraph-modal'
import DateModal from '../components/create-modal/date-modal'
import HeaderModal from '../components/create-modal/header-modal'
import AddMoreModal from '../components/create-modal/addMore-modal'
import RelationalFieldModal from '../components/create-modal/relational-field-modal'
import QRCodeModal from '../components/create-modal/qrcode-modal'
import SameAsModal from '../components/create-modal/sameAs-modal'
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
import RelationalDetails from '../components/relational-details'
import RelationalCheckbox from '../components/relational-checkbox'
import SameAsField from '../components/sameas-field'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyFormEditApi, surveyFormStoreApi, surveyFormUpdateApi } from '../../../api/routes'
import { isNotEmpty, wordsToSnake, getRegexString } from '@/utils/fliter'

export default {
  components: {
    InputModal,
    DropdownModal,
    CheckboxModal,
    AttachmentModal,
    TextareaModal,
    DateModal,
    HeaderModal,
    AddMoreModal,
    QRCodeModal,
    SameAsModal,
    Input,
    Dropdown,
    Checkbox,
    Attachment,
    GridLayout,
    GridItem,
    ValidationObserver,
    ValidationProvider,
    RadioModal,
    Radio,
    Textarea,
    ParagraphModal,
    Paragraph,
    Date,
    Header,
    QRCode,
    Empty,
    AddMore,
    AddMoreDetails,
    RelationalFieldModal,
    RelationalCheckbox,
    RelationalDetails,
    SameAsField
  },
  data () {
    return {
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
        { x: 2, y: 0, w: 2, h: 2, i: '11', dataType: 'Add More', text: 'Add More', icon: 'fa fa-plus' },
        { x: 2, y: 0, w: 2, h: 2, i: '12', dataType: 'RelationalField', text: 'Relational Field', icon: 'fa fa-plus' },
        { x: 2, y: 0, w: 2, h: 2, i: '13', dataType: 'SameAs', text: 'Same As', icon: 'fa fa-plus' }
      ],
      draggable: true,
      resizable: true,
      colNum: 12,
      index: 0,
      tindex: 0,
      surveyInfo: {
        form_title: '',
        form_title_bn: '',
        survey_id: 0
      },
      update: false,
      unitLoad: false,
      loading: false,
      isFinal: false,
      editIndex: '',
      editData: '',
      formInputData: [],
      formIData: [],
      toAdd: '',
      formTitle: this.$i18n.locale === 'bn' ? 'ফিল্ড যোগ করুন' : 'Add Field',
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
      tUpId: '',
      layoutKey: 0,
      formStatus: 0,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      relationDataAll: [],
      formActions: {
        isDraft: false,
        isSubmit: false,
        isReset: false,
        isCancel: false
      },
      addIndex: '',
      dynamicFormList: [],
      updateDet: 0
    }
  },
  created () {
    if (this.$route.query.id) {
      this.edit(this.$route.query.id)
      this.tabChange(0)
    }
    this.genIndex()
  },
  watch: {
    isFinal: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.formStatus = newVal ? 1 : 0
      }
    }
  },
  computed: {
    surveyList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.surveyList.filter(item => item.status === 1)
    },
    inputTypeList: function () {
      return this.inputOptionList.map(item => {
        return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    local: function () {
        return this.$i18n.locale
    }
  },
  methods: {
    genIndex () {
      this.index = Math.floor(1000 + Math.random() * 9000)
    },
    edit (dynamicFormId) {
      this.unitLoad = true
      RestApi.getData(bftiResReportServiceBaseUrl, surveyFormEditApi + '/' + dynamicFormId).then(response => {
        if (isNotEmpty(response.data)) {
          this.formActions = JSON.parse(response.data.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          this.surveyInfo.form_title = response.data.form_title
          this.surveyInfo.form_title_bn = response.data.form_title_bn
          this.surveyInfo.survey_id = response.data.survey_id
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
            })
            const addFind = this.layoutData.find(item => item.dataType === 'Add More' && item.tabIndex === tabIndex)
            if (addFind !== undefined) {
              const fieldData = this.formInputData.find(item => item.id === addFind.i)
              fieldData.fields.forEach(i => {
                const field = this.formInputData.find(item => item.id === i)
                this.Addcolumns.push({ text_en: field.label, text_bn: field.label_bn })
              })
              this.Addcolumns.push({ text_en: 'Action', text_bn: 'অ্যাকশন' })
              this.addMore = true
              this.addIndex = addFind.tabIndex
            }
          })
        }
        this.unitLoad = false
        this.updateLayout()
      })
    },
    async saveFormData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const formData = {
        survey: this.surveyInfo,
        layout: this.layoutData,
        data: this.formInputData,
        tabInfo: this.tabData,
        formStatus: this.formStatus,
        formActions: this.formActions
      }
      let result = null
      const loadingState = { loading: false, listReload: false }
      this.loading = true
      if (this.$route.query.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${surveyFormUpdateApi}/${this.$route.query.id}`, formData)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, surveyFormStoreApi, formData)
      }
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        if (this.$route.query.id) {
          this.$router.push('/bfti-research-and-report-service/system-configuration-activity-management/survey-management/survey-form')
        } else {
          this.reset()
          this.$router.go(-1)
        }
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    reset () {
      this.genIndex()
      this.surveyInfo.form_title = ''
      this.surveyInfo.form_title_bn = ''
      this.tabData = [
        {
          tab_no: 0,
          tab_title: 'Default Tab',
          tab_title_bn: 'Default Tab',
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
    addItem: function (item) {
      this.editData = ''
      this.toAdd = item.dataType
      if (item.dataType !== 'Empty') {
        this.modalOpen(item)
      } else {
        const data = {
          id: 1,
          isRequired: '',
          label: 'Empty Space',
          label_bn: 'Empty Space',
          field_name: 'empty',
          value: '',
          help_text: '',
          field_type: 'empty',
          is_show: false
        }
        this.inputData(data, 'modal-1')
      }
    },
    modalOpen: function (item) {
      if (item.dataType === 'Dropdown') {
        this.$bvModal.show('modal-2')
      } else if (item.dataType === 'Checkbox') {
        this.$bvModal.show('modal-3')
      } else if (item.dataType === 'Attachment') {
        this.$bvModal.show('modal-4')
      } else if (item.dataType === 'Radio') {
        this.$bvModal.show('modal-5')
      } else if (item.dataType === 'Textarea') {
        this.$bvModal.show('modal-6')
      } else if (item.dataType === 'Paragraph') {
        this.$bvModal.show('modal-8')
      } else if (item.dataType === 'Date') {
        this.$bvModal.show('modal-7')
      } else if (item.dataType === 'Header') {
        this.$bvModal.show('modal-9')
      } else if (item.dataType === 'QRCode') {
        this.$bvModal.show('modal-11')
      } else if (item.dataType === 'Add More') {
        this.$bvModal.show('modal-10')
      } else if (item.dataType === 'RelationalField') {
        this.$bvModal.show('modal-12')
      } else if (item.dataType === 'SameAs') {
        this.$bvModal.show('modal-13')
      } else {
        this.$bvModal.show('modal-1')
      }
    },
    removeItem: function (val) {
      const lData = this.layoutData.find(item => item.tabIndex === this.tabIndex && item.i === val)
      const formData = this.formInputData.find(item => item.indexId === this.tabIndex && item.id === val)
      const arIndex = this.layoutData.indexOf(lData)
      const arrIndex = this.formInputData.indexOf(formData)
      this.layoutData.splice(arIndex, 1)
      this.formInputData.splice(arrIndex, 1)
      this.updateLayout()
    },
    editItem: function (val) {
      this.editIndex = val
      this.update = true
      const data = this.formIData[val]
      const item = this.layout[val]
      this.editData = data
      this.modalOpen(item)
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
      this.updateDet = this.updateDet + 1
      this.layout.push()
    },
    updateLayout: function (data) {
      if (data) {
        const layfind = this.layoutData.find(litem => litem.i === data.id && litem.tabIndex === this.tabIndex)
        layfind.is_show = data.is_show
      }
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
    getChildDropdown (currentIndex) {
      const currentName = this.formIData[currentIndex].dropdownData.dropdown_name
      const child = this.formIData.find((item, index) => (currentIndex < index && item.field_type === 'dropdown' && item.dropdownData.parent_state === currentName))
      return child
    },
    inputData (data, modalName) {
      if (this.update === true) {
        const fieldName = getRegexString(data.field_name)
        data.field_name = fieldName.substring(0, 10) + '_' + data.id
        const fIData = this.formIData[this.editIndex]
        const formData = this.formInputData.find(item => item.indexId === this.tabIndex && item.id === fIData.id)
        const arrIndex = this.formInputData.indexOf(formData)
        this.formInputData[arrIndex] = data
        this.editIndex = ''
        this.update = false
        this.editData = ''
        this.$bvModal.hide(modalName)
        this.updateLayout(data)
      } else {
        data.id = this.index
        const fieldName = getRegexString(data.field_name)
        data.field_name = fieldName.substring(0, 10) + '_' + this.index
        data.indexId = this.tabIndex
        this.formInputData.push(data)
        this.addLayout(data)
        this.$bvModal.hide(modalName)
        if (modalName === 'modal-10') {
          this.Addcolumns = []
          data.fields.forEach(i => {
            const formIdata = this.formInputData.find(item => item.id === i)
            this.Addcolumns.push({ text_en: formIdata.label, text_bn: formIdata.label_bn })
          })
          this.Addcolumns.push({ text_en: 'Action', text_bn: 'অ্যাকশন' })
          this.addMore = true
        }
      }
    },
    addLayout (data) {
      this.la = {
        x: (this.layout.length * 2) % (this.colNum || 12),
        y: this.layout.length + (this.colNum || 12),
        w: 2,
        h: this.findHeight(),
        i: this.index,
        dataType: this.toAdd,
        tabIndex: this.tabIndex,
        is_show: data.is_show
      }
      this.layoutData.push(this.la)
      this.updateLayout()
      this.tindex++
      this.genIndex()
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
    addMoreDetailsShow (data) {
      if (data) {
        this.detailsData = data
      }
    },
    addButton (type) {
      if (type === 1) {
        this.formActions.isDraft = true
      } else if (type === 2) {
        this.formActions.isSubmit = true
      } else if (type === 3) {
        this.formActions.isReset = true
      } else {
        this.formActions.isCancel = true
      }
    }
  }
}
</script>
<style scoped>
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
.vue-grid-item>.vue-resizable-handle {
  z-index: 999;
}
.dark_button .btn-secondary {
  color: #000 !important;
}
.vue-grid-item:not(.vue-grid-placeholder) {
    border: 1px solid grey;
}
</style>
