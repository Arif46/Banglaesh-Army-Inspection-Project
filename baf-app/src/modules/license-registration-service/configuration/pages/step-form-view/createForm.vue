<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchBody>
        <b-row>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
              <b-overlay :show="unitLoad">
                <b-row>
                  <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="Organization" vid="org_id" rules="required">
                      <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="org_id"
                          slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{ $t('orgProfile.org_name') }} <span class="text-danger">*</span>
                        </template>
                        <b-form-select
                          plain
                          v-model="serviceInfo.org_id"
                          :options="organizationList"
                          id="org_id"
                          :state="errors[0] ? false : (valid ? true : null)"
                          >
                          <template v-slot:first>
                            <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                          </template>
                        </b-form-select>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="6" sm="12" md="6">
                      <ValidationProvider name="Language Type" vid="lang_type" rules="required">
                          <b-form-group
                              class="row"
                              label-cols-sm="12"
                              label-for="lang_type"
                              slot-scope="{ valid, errors }"
                          >
                              <template v-slot:label>
                                  {{$t('component_settings.lang_type')}}<span class="text-danger">*</span>
                              </template>
                              <b-form-select
                              plain
                              v-model="serviceInfo.lang_type"
                              id="lang_type"
                              :options="languageTypeList"
                              :state="errors[0] ? false : (valid ? true : null)"
                              >
                              </b-form-select>
                                  <div class="invalid-feedback">
                              {{ errors[0] }}
                              </div>
                          </b-form-group>
                      </ValidationProvider>
                  </b-col>
                  <b-col lg="6" sm="6" md="6">
                    <ValidationProvider name="Dynamic Form Name" vid="form_id">
                      <b-form-group
                        class="row"
                        label-cols-sm="12"
                        label-for="form_id"
                      >
                        <template v-slot:label>
                          {{$t('dynamic_form.form')}}
                        </template>
                        <b-form-select
                          plain
                          v-model="serviceInfo.form_id"
                          :options="formList"
                          id="form_id"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                        </b-form-select>
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
                          <span>{{ item.tab_title }}</span><i class="fa fa-pen ml-2"></i><i class="fa fa-plus ml-2"></i>
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
                                    <Dropdown :data="formIData[dindex]" :drpChangeData="formIData[dindex + 1]" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
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
                                    <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'" :key="componentKey" />
                                    <PaymentCheckbox :data="formIData[dindex]" v-if="item.dataType === 'PaymentCheckbox'" :key="componentKey" />
                                  </b-row>
                                    <template v-if="item.dataType === 'RelationalField'">
                                      <b-row>
                                        <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                        <RelationalDetails :tmpData="relationDataAll[item.i]" :key="updateDet"/>
                                      </b-row>
                                    </template>
                                    <span class="edit" @click="editItem(dindex)" v-if="item.dataType !== 'Empty'"><i class="fa fa-pen" style="font-size: 10px;z-index:999"></i></span>
                                    <span class="remove" @click="removeItem(item.i)"><i class="fa fa-times"></i></span>
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
                              <b-button v-if="formActions.isDraft" @click="isFinal = false" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                              <b-button v-if="formActions.isSubmit" @click="isFinal = true" type="submit" variant="primary" class="mr-2">{{ $t('globalTrans.save') }}</b-button>
                              <b-button v-if="formActions.isReset" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                              <router-link v-if="formActions.isCancel" to="step-form-view" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                              <b-button v-if="formActions.isPayment" @click="reset()" variant="warning" class="mr-1">{{ $t('component_settings.payment') }}</b-button>
                            </div>
                          </div>
                          <hr />
                          <div class="row mt-4">
                            <div class="col-sm-3"></div>
                            <div class="col text-right">
                              <b-button @click="isFinal = false" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                              <b-button @click="isFinal = true" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                              <b-button @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                              <router-link to="step-form-view" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
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
          <b-modal id="modal-tab" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <ValidationObserver ref="tabAddUpdate"  v-slot="{ handleSubmit, reset }">
              <b-form @submit.prevent="handleSubmit(saveTabSettings)" @reset.prevent="reset">
                <b-row>
                  <b-col lg="12" sm="12" md="12">
                    <ValidationProvider name="Tab Title" vid="tab_title" rules="required">
                      <b-form-group
                        class="row"
                        label-cols-sm="3"
                        label-for="tab_title"
                        slot-scope="{ valid, errors }"
                      >
                        <template v-slot:label>
                          {{$t('dynamic_form.tab_title')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-input
                          id="label"
                          v-model="tabSettings.tab_title"
                          :placeholder="$t('dynamic_form.tab_input')"
                          :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                      </b-form-group>
                    </ValidationProvider>
                  </b-col>
                  <b-col lg="2" sm="2" md="2">
                    <b-button type="submit" variant="primary" v-if="tabUpdate">{{ 'Update'}}</b-button>
                    <b-button type="submit" variant="primary" v-else>{{ 'Save'}}</b-button>
                  </b-col>
                </b-row>
              </b-form>
            </ValidationObserver>
          </b-modal>
          <b-modal id="modal-1" size="lg" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <InputModal @addInput="inputData" :formData="formInputData" :editData="editData" />
          </b-modal>
          <b-modal id="modal-2" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <DropdownModal @addDropdown="inputData" :editData="editData" />
          </b-modal>
          <b-modal id="modal-3" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <CheckboxModal @addCheckbox="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-4" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <AttachmentModal :editData="editData" @addAttcahment="inputData" />
          </b-modal>
          <b-modal id="modal-5" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <RadioModal @addCheckbox="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-6" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <TextareaModal @addTextArea="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-8" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <ParagraphModal @addParagraph="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-7" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <DateModal @addDate="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-9" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <HeaderModal @addHeader="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-10" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <AddMoreModal @addAddMore="inputData" :formData="formInputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-11" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <QRCodeModal @addQRCode="inputData" :editData="editData"/>
          </b-modal>
          <b-modal id="modal-12" size="lg" :title="$i18n.locale === 'bn' ? `পেমেন্ট` : `Payment`" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <PaymentModal @addDropdown="inputData" :editData="editData" />
          </b-modal>
          <b-modal id="modal-13" size="lg" :title="$i18n.locale === 'bn' ? `পেমেন্ট চেকবক্স` : `Payment Checkbox`" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <PaymentCheckboxModal @addDropdown="inputData" :editData="editData" />
          </b-modal>
          <b-modal id="modal-14" size="md" :title="formTitle" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
            <RelationalFieldModal @RelationalField="inputData" :formData="formInputData" :editData="editData"/>
          </b-modal>
        </b-row>
      </template>
    </card>
  </div>
</template>
<script>
import RelationalFieldModal from '../components/create-modal/relational-field-modal'
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
import QRCodeModal from '../components/create-modal/qrcode-modal'
import PaymentModal from '../components/create-modal/payment-modal'
import PaymentCheckboxModal from '../components/create-modal/payment-checkbox-modal'
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
import RelationalCheckbox from '../components/relational-checkbox'
import RelationalDetails from '../components/relational-details'
import Payment from '../components/payment'
import PaymentCheckbox from '../components/payment-checkbox'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dynamicFormData, stepFormViewEditData, stepFormViewStore, stepFormViewUpdate, stepListget } from '../../api/routes'
import { isNotEmpty, wordsToSnake, snakeToWords, getRegexString } from '@/utils/fliter'

export default {
  components: {
    RelationalFieldModal,
    InputModal,
    DropdownModal,
    CheckboxModal,
    AttachmentModal,
    TextareaModal,
    DateModal,
    HeaderModal,
    AddMoreModal,
    QRCodeModal,
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
    PaymentModal,
    PaymentCheckboxModal,
    Payment,
    PaymentCheckbox,
    RelationalCheckbox,
    RelationalDetails
  },
  data () {
    return {
      isEdit: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      layout: [],
      layoutData: [],
      draggable: true,
      resizable: true,
      colNum: 12,
      index: 0,
      tindex: 0,
      serviceInfo: {
        org_id: 0,
        lang_type: 'en',
        form_id: 0
      },
      update: false,
      unitLoad: false,
      loading: false,
      isFinal: false,
      editIndex: '',
      editData: '',
      stepList: [],
      formInputData: [],
      formIData: [],
      toAdd: '',
      formTitle: '',
      relationDataAll: [],
      tabData: [
        {
          tab_no: 0,
          tab_title: 'Default Tab',
          tab_name: 'default_tab'
        }
      ],
      formList: [],
      la: '',
      tabIndex: 0,
      tabUpdate: false,
      tabSettings: {
        tab_no: '',
        tab_title: '',
        tab_name: ''
      },
      tUpId: '',
      componentKey: 0,
      layoutKey: 0,
      formStatus: 0,
      addMore: false,
      detailsData: [],
      Addcolumns: [],
      formActions: {
        isDraft: false,
        isSubmit: false,
        isReset: false,
        isPayment: false,
        isCancel: false
      },
      addIndex: ''
    }
  },
  created () {
    // this.serviceInfo.org_id = this.userCheck()
    if (this.$route.query.id) {
      this.isEdit = true
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
    },
    'serviceInfo.org_id': function (newValue, oldVal) {
      if (newValue !== oldVal) {
        this.formList = this.getFormList(newValue)
      }
    },
    'serviceInfo.form_id': function (newValue, oldVal) {
      if (newValue !== oldVal && this.isEdit === false) {
        this.getForm(newValue)
      }
    }
  },
  computed: {
    languageTypeList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.languageTypeList.filter(item => {
        return Object.assign(item, { value: item.value, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    organizationList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    inputTypeList: function () {
      return this.inputOptionList.map(item => {
        return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    }
  },
  methods: {
    isNotEmpty (val) {
      return isNotEmpty(val)
    },
    getFormList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList.filter(form => form.org_id === orgId)
    },
    genIndex () {
      this.index = Math.floor(1000 + Math.random() * 9000)
    },
    edit (formViewId) {
      this.unitLoad = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormViewEditData + '/' + formViewId).then(response => {
        if (isNotEmpty(response.data)) {
          this.serviceInfo.org_id = response.data.org_id
          this.serviceInfo.lang_type = response.data.lang_type
          this.serviceInfo.form_id = response.data.form_id
          this.formActions = JSON.parse(response.data.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          response.data.tabs.forEach((item, tabIndex) => {
            const tabNo = item.tab_no
            const tabId = item.id
            const tabName = item.tab_name
            const tabTitle = snakeToWords(item.tab_name)
            const data = { tab_id: tabId, tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
            this.tabData.push(data)
            item.viewlayouts.forEach((layItem) => {
              if (response.data.id === layItem.view_form_id) {
                const layJson = JSON.parse(layItem.layout)
                const dataJson = JSON.parse(layItem.data)
                this.layoutData.push(layJson)
                this.formInputData.push(dataJson)
                this.tindex++
              }
            })
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
        }
        this.unitLoad = false
        this.updateLayout()
      })
    },
    getForm (dynamicFormId) {
      this.unitLoad = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormData + '/' + dynamicFormId).then(response => {
        if (isNotEmpty(response.data)) {
          this.formActions = JSON.parse(response.data.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          response.data.tabs.forEach((item, tabIndex) => {
            const tabNo = item.tab_no
            const tabId = item.id
            const tabName = item.tab_name
            const tabTitle = snakeToWords(item.tab_name)
            const data = { tab_id: tabId, tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
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
                this.Addcolumns.push(field.label)
              })
              this.Addcolumns.push('Action')
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
      this.formInputData.map(item => {
        if (item.field_type === 'dropdown' && item.dropdownData.component_id !== '0') {
          item.dropdownData.dropdown_options = []
        }
      })
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const formData = {
        service: this.serviceInfo,
        layout: this.layoutData,
        data: this.formInputData,
        tabInfo: this.tabData,
        formStatus: this.formStatus,
        formActions: this.formActions
      }
      let result = null
      const loadinState = { loading: false, listReload: false }
      this.loading = true
      if (this.$route.query.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${stepFormViewUpdate}/${this.$route.query.id}`, formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stepFormViewStore, formData)
      }
      this.loading = false
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push('/license-registration-service/configuration/form-view-design')
        this.reset()
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    reset () {
      this.genIndex()
      this.tabData = [
        {
          tab_no: 0,
          tab_id: 0,
          tab_title: 'Default Tab',
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
          label: '',
          field_name: 'empty',
          value: '',
          help_text: '',
          field_type: 'empty'
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
      } else if (item.dataType === 'Payment') {
        this.$bvModal.show('modal-12')
      } else if (item.dataType === 'PaymentCheckbox') {
        this.$bvModal.show('modal-13')
      } else if (item.dataType === 'RelationalField') {
        this.$bvModal.show('modal-14')
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
      this.layout.push()
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
    updateDropdown: function (updateData, updateIndex) {
      this.componentKey = this.componentKey + 1
    },
    updatePage: function (updata, nindex) {
      this.layout.push(this.layoutData[nindex])
      this.formIData.push(updata)
    },
    wordsToSnake (val) {
      return wordsToSnake(val)
    },
    getStepList (serviceId) {
      this.unitLoad = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepListget + '/' + serviceId).then(response => {
        if (isNotEmpty(response.data)) {
          const steps = this.$store.state.licenseRegistration.commonObj.stepNamesList
          this.stepList = response.data.map(item => {
            const tmpStep = steps.find(fee => fee.value === item.step_id)
            return tmpStep
          })
        }
        this.unitLoad = false
      })
    },
    tabChange (val) {
      this.tabIndex = val
      this.updateLayout()
    },
    inputData (data, modalName) {
      if (this.update === true) {
        // if (data.field_type !== 'text') {
          const fieldName = getRegexString(data.field_name)
          data.field_name = fieldName.substring(0, 15) + '_' + data.id
        // }
        if (data.field_type === 'dropdown' || data.field_type === 'payment') {
          this.updateDropdown()
        }
        if (data.field_type === 'payment') {
          data.field_name = 'payment'
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
        const fieldName = getRegexString(data.field_name)
        data.field_name = fieldName.substring(0, 10) + '_' + this.index
        if (data.field_type === 'payment') {
          data.field_name = 'payment'
        }
        data.indexId = this.tabIndex
        this.formInputData.push(data)
        this.addLayout()
        this.$bvModal.hide(modalName)
        if (modalName === 'modal-10') {
          this.Addcolumns = []
          data.fields.forEach(i => {
            const formIdata = this.formInputData.find(item => item.id === i)
            this.Addcolumns.push(formIdata.label)
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
      // this.index++
      this.tindex++
      this.genIndex()
    },
    findHeight () {
      if (this.toAdd === 'Textarea') {
        return 3
      } else if (this.toAdd === 'Attachment') {
        return 4
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
      } else if (type === 4) {
        this.formActions.isCancel = true
      } else {
        this.formActions.isPayment = true
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
.vue-grid-item:not(.vue-grid-placeholder) {
    border: 1px solid grey;
}
</style>
