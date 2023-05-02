<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
          <div class="row p-4 mt-3" id="printArea">
            <div class="col-md-12">
              <div class="p-2" style="" >
                <b-overlay :show="unitLoad">
                <b-row>
                    <b-col md="12" lg="12" sm="12">
                      <b-card no-body>
                        <b-tabs v-model="tabIndex">
                          <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                            <template v-slot:title>
                              <span>{{ item.tab_title }}</span>
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
                                      <Dropdown :data="formIData[dindex]" :drpChangeData="formIData[dindex + 1]" :nextIndex="dindex + 1" @updateDropdownData="updateDropdown" :key="componentKey" v-if="item.dataType === 'Dropdown'"/>
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
                      </b-tabs>
                    </b-card>
                  </b-col>
                </b-row>
                </b-overlay>
              </div>
            </div>
          </div>
      </template>
    </iq-card>
  </b-container>
</template>
<script>
import Vue from 'vue'
import VueHtmlToPaper from 'vue-html-to-paper'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
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
import { snakeToWords, isNotEmpty } from '@/utils/fliter'
import common from '@/mixins/common'
import CommonLrcpn from '@/mixins/common-lrcpn'
import { stepFormData } from '../../../api/routes'

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
  props: ['id'],
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
    AddMoreDetails
  },
  data () {
    return {
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
      colNum: 12,
      tindex: 0,
      unitLoad: false,
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
      service_name: ''
    }
  },
  created () {
    this.gridSearch.org_id = parseInt(this.$route.query.org_id)
    this.gridSearch.service_id = parseInt(this.$route.query.service_id)
    this.step_id = parseInt(this.$route.query.step_id)
    this.loadFrom()
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
    }
  },
  computed: {
  },
  methods: {
    printDiv () {
      this.$htmlToPaper('printArea')
    },
    loadFrom () {
      const formId = this.id
      const serviceId = this.$route.query.service_id
      const stepId = this.$route.query.step_id
      const params = {
        id: formId,
        service_id: serviceId,
        step_id: stepId,
        applicationID: parseInt(this.$route.query.application_id)
      }
      this.unitLoad = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormData, params).then(response => {
        this.unitLoad = false
        if (isNotEmpty(this.transferData)) {
          this.formActions = JSON.parse(this.transferData.item.form_action)
          this.layoutData = []
          this.formInputData = []
          this.tabData = []
          this.transferData.item.tabs.forEach((item, tabIndex) => {
            const tabNo = item.tab_no
            const tabName = item.tab_name
            const tabTitle = snakeToWords(item.tab_name)
            const data = { tab_no: tabNo, tab_name: tabName, tab_title: tabTitle }
            this.tabData.push(data)
            item.layouts.forEach((layItem) => {
              const layJson = JSON.parse(layItem.layout)
              const dataJson = JSON.parse(layItem.data)
              this.layoutData.push(layJson)
              if (this.transferData.applicationData !== null) {
                this.transferData.applicationData.map((item, index) => {
                    if (item !== null) {
                    this.table_id = item.id
                    this.BackButtonShow = true
                    Object.keys(item).forEach(key => {
                        if (key === dataJson.field_name) {
                          if (dataJson.field_type === 'options') {
                            dataJson.value = [item[key]]
                          } else {
                            dataJson.value = item[key]
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
        this.updateLayout()
      })
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
      return this.$store.state.licenseRegistration.commonObj.serviceNamesList.filter(item => (item.org_id === parseInt(orgId)))
    },
    getServiceName (sId) {
      const service = this.$store.state.licenseRegistration.commonObj.serviceNamesList.find(item => item.value === parseInt(sId))
      return service.text_en
    },
    getGridStep (serviceId) {
      const tmpService = this.$store.state.licenseRegistration.commonObj.serviceStepForm.find(item => (item.service_id === serviceId && item.form_type === 2))
      if (typeof tmpService === 'undefined') {
        return {}
      } else {
        return tmpService
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
