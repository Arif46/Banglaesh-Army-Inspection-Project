<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4>{{ getFormName(serviceInfo.form_id) }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
              <b-row>
                <b-col md="12" lg="12" sm="12">
                  <b-card no-body>
                    <b-tabs>
                      <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                        <template v-slot:title>
                          <span>{{ item.tab_title }}</span>
                        </template>
                        <template :id="index">
                          <b-overlay :show="loading">
                            <b-row v-if="tindex > 0">
                              <b-col md="12" lg="12" sm="12">
                                <grid-layout :layout.sync="layout"
                                  :col-num="colNum"
                                  :row-height="13"
                                  :is-draggable="false"
                                  :is-resizable="false"
                                  :vertical-compact="true"
                                  :use-css-transforms="false"
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
                                    <Payment :data="formIData[dindex]" v-if="item.dataType === 'Payment'"/>
                                  </b-row>
                                  <template v-if="item.dataType === 'RelationalField'">
                                    <b-row>
                                      <RelationalCheckbox @showComponents="componentsShow" :data="formIData[dindex]"/>
                                      <RelationalDetails :tmpData="relationDataAll[item.i]" :key="updateDet"/>
                                    </b-row>
                                  </template>
                                  </grid-item>
                                </grid-layout>
                              </b-col>
                            </b-row>
                          </b-overlay>
                          <div class="row" v-if="addIndex === index">
                            <AddMoreDetails :tmpData="detailsData" :colData="Addcolumns" v-if="addMore"/>
                          </div>
                          <div class="row">
                            <div class="col text-right">
                              <b-button v-if="formActions.isDraft" @click="isFinal = false" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                              <b-button v-if="formActions.isSubmit" @click="isFinal = true" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                              <router-link v-if="formActions.isCancel" to="dynamic-form" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                              <b-button v-if="formActions.isPayment" @click="reset()" variant="warning" class="mr-1">{{ $t('component_settings.payment') }}</b-button>
                            </div>
                          </div>
                          <hr />
                          <div class="row mt-4">
                            <div class="col-sm-3"></div>
                            <div class="col text-right">
                              <router-link to="/license-registration-service/configuration/form-view-design" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.back') }}</router-link>
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
      </template>
    </card>
  </div>
</template>
<script>
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
import { GridLayout, GridItem } from 'vue-grid-layout'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepFormViewEditData, stepListget } from '../../api/routes'
import { isNotEmpty, wordsToSnake, snakeToWords } from '@/utils/fliter'
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
    RelationalCheckbox,
    RelationalDetails
  },
  data () {
    return {
      isEdit: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      layout: [],
      layoutData: [],
      relationDataAll: [],
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
      serviceInfo: {
        form_id: ''
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
      tabData: [
        {
          tab_no: 0,
          tab_title: 'Default Tab',
          tab_name: 'default_tab'
        }
      ],
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
    if (this.$route.query.id) {
      this.isEdit = true
      this.edit(this.$route.query.id)
      this.tabChange(0)
    }
  },
  mounted () {
    const oldId = this.layout[this.layout.length - 1]
    if (typeof oldId === 'undefined') {
      this.index = 0
    } else {
      this.index = oldId.i + 1
    }
  },
  watch: {
    isFinal: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.formStatus = newVal ? 1 : 0
      }
    },
    'serviceInfo.dynamic_form_id': function (newValue, oldVal) {
      if (newValue !== oldVal && this.isEdit === false) {
        this.edit(newValue)
      }
    }
  },
  computed: {
    dynamicFormList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList
    },
    inputTypeList: function () {
      return this.inputOptionList.map(item => {
        return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    }
  },
  methods: {
    getFormName (formId) {
        const formFind = this.dynamicFormList.find(item => item.value === formId)
        return this.$i18n.locale === 'en' ? formFind !== undefined ? formFind.text_en : '' : formFind !== undefined ? formFind.text_bn : ''
    },
    edit (formViewId) {
      this.unitLoad = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormViewEditData + '/' + formViewId).then(response => {
        if (isNotEmpty(response.data)) {
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
    reset () {
      this.index = 0
      this.serviceInfo.form_title = ''
      this.tabData = [
        {
          tab_no: 0,
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
      } else {
        this.$bvModal.show('modal-1')
      }
    },
    removeItem: function (val) {
      const lData = this.layoutData.find(item => item.tabIndex === this.tabIndex && item.i === val)
      const arIndex = this.layoutData.indexOf(lData)
      this.layoutData.splice(arIndex, 1)
      const formData = this.formInputData.find(item => item.indexId === this.tabIndex && item.id === val)
      const arrIndex = this.formInputData.indexOf(formData)
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
    },
    updateDropdown: function () {
      this.componentKey += 1
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
    tabSettingsUpdate (tabId) {
      this.tUpId = tabId
      this.tabUpdate = true
      const tabFind = this.tabData.find(item => item.tab_no === tabId)
      this.tabSettings.tab_no = tabFind.tab_no
      this.tabSettings.tab_title = tabFind.tab_title
      this.tabSettings.tab_name = tabFind.tab_name
      this.$bvModal.show('modal-tab')
    },
    createTab (val) {
      this.tabIndex = val
      this.$bvModal.show('modal-tab')
    },
    saveTabSettings () {
      if (this.tabUpdate === true) {
        this.tabData[this.tUpId].tab_no = this.tabSettings.tab_no
        this.tabData[this.tUpId].tab_name = this.wordsToSnake(this.tabSettings.tab_title)
        this.tabData[this.tUpId].tab_title = this.tabSettings.tab_title
        this.tabSettings.tab_no = ''
        this.tabSettings.tab_name = ''
        this.tabSettings.tab_title = ''
        this.$bvModal.hide('modal-tab')
        this.tabUpdate = false
      } else {
        this.tabSettings.tab_no = this.tabIndex + 1
        this.tabSettings.tab_name = this.wordsToSnake(this.tabSettings.tab_title)
        const tData = JSON.parse(JSON.stringify(this.tabSettings))
        this.tabData.push(tData)
        this.tabSettings.tab_no = ''
        this.tabSettings.tab_name = ''
        this.tabSettings.tab_title = ''
        this.$bvModal.hide('modal-tab')
      }
    },
    inputData (data, modalName) {
      if (this.update === true) {
        if (data.field_type !== 'text') {
          data.field_name = data.field_name + '_' + data.id
        }
        if (data.field_type === 'dropdown') {
          this.updateDropdown()
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
            this.Addcolumns.push(this.formInputData[i].label)
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
    },
    getFormTitle (formId) {
      const form = this.$store.state.licenseRegistration.commonObj.dynamicFormList.find(form => form.id === formId)
      return typeof form !== 'undefined' ? form.text : ''
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
