<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:body>
        <ValidationObserver ref="form"  v-slot="{ handleSubmit }">
          <b-overlay :show="actionLoad || actionLoad">
            <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset" v-if="tindex > 0">
                <b-row>
                  <b-col md="12" lg="12" sm="12">
                    <template>
                      <div style="font-size:18px; background-color: #005B5B;margin-bottom: 12px">
                        <h5 class="text-white text-center"> Action Form </h5>
                      </div>
                  </template>
                    <b-card no-body>
                      <b-tabs v-model="tabIndex">
                        <b-tab v-for="(item, index) in tabData" :key="index" :active="index === 0" @click="tabChange(index)">
                          <template v-slot:title>
                            <span>{{ item.tab_title }}</span>
                          </template>
                          <template :id="index">
                            <b-overlay>
                              <b-row v-if ="BackButtonShow">
                                <b-col lg="12" sm="12">
                                  <b-table-simple striped bordered small class="mt-1">
                                    <b-tr v-for="(item, index) in formIData" :key="index">
                                      <b-th v-if="formIData[index].field_type === 'text_area' || formIData[index].field_type === 'text' || formIData[index].field_type === 'email' || formIData[index].field_type === 'number' || formIData[index].field_type === 'options'"> {{ formIData[index].label }} </b-th>
                                      <b-td v-if="formIData[index].field_type === 'text_area' || formIData[index].field_type === 'text' || formIData[index].field_type === 'email' || formIData[index].field_type === 'number' || formIData[index].field_type === 'options'"> {{ formIData[index].value }} </b-td>
                                    </b-tr>
                                  </b-table-simple>
                                  </b-col>
                              </b-row>
                              <b-row v-if ="!BackButtonShow">
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
                                <b-overlay v-if ="butonShow">
                                  <b-button v-if="index !== 0" @click="tabIndex--" variant="primary" class="mr-2">{{ $t('component_settings.prev_tab') }}</b-button>
                                  <b-button v-if="index < totalTab && index !== totalTab" @click="tabIndex++" variant="primary" class="mr-2">{{ $t('component_settings.next_tab') }}</b-button>
                                  <b-button v-if="formActions.isDraft && index === totalTab" @click="isFinal = false" type="submit" variant="secondary" class="mr-2">{{$t('component_settings.save_draft')}}</b-button>
                                  <b-button v-if="formActions.isSubmit && index === totalTab" @click="isFinal = true" type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                                  <b-button v-if="formActions.isReset && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                                  <router-link v-if="formActions.isCancel && index === totalTab" to="step-form" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                                  <b-button v-if="formActions.isPayment && index === totalTab" @click="reset()" variant="warning" class="mr-1">{{ $t('component_settings.payment') }}</b-button>
                                </b-overlay>
                                <b-overlay v-if ="BackButtonShow">
                                  <b-button @click="backStep()" variant="primary" class="mr-1">{{ $t('globalTrans.back') }}</b-button>
                                </b-overlay>
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
      </template>
    </iq-card>
  </b-container>
</template>
<script>
import Input from '../../../configuration/pages/components/input-field'
import Dropdown from '../../../configuration/pages/components/dropdown-field'
import Checkbox from '../../../configuration/pages/components/checkbox-field'
import Attachment from '../../../configuration/pages/components/attachment-field'
import Radio from '../../../configuration/pages/components/radio-field'
import Textarea from '../../../configuration/pages/components/textarea-field'
import Paragraph from '../../../configuration/pages/components/paragraph-field'
import Date from '../../../configuration/pages/components/date-field'
import Header from '../../../configuration/pages/components/header-field'
import AddMore from '../../../configuration/pages/components/addMore-field'
import AddMoreDetails from '../../../configuration/pages/components/addMoreDetails'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { surveyDataStore, stepFormData } from '../../api/routes'
import { wordsToSnake, snakeToWords, isNotEmpty } from '@/utils/fliter'
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
    AddMoreDetails
  },
  data () {
    return {
      loading: false,
      butonShow: false,
      BackButtonShow: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      gridSearch: {
        service_id: 0,
        org_id: 0
      },
      surveyData: [],
      layout: [],
      layoutData: [],
      colNum: 12,
      index: 0,
      tindex: 0,
      unitLoad: false,
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
      actionLoad: false
    }
  },
  created () {
    this.step_id = parseInt(this.$route.query.step_id)
    this.index = this.layout.length
    this.loadFromWithData()
  },
  methods: {
    loadFromWithData () {
      this.loading = true
      const formId = parseInt(this.$route.query.form_id)
      const serviceId = this.$route.query.service_id
      const stepId = this.$route.query.step_id
      const params = {
        id: formId,
        service_id: serviceId,
        step_id: stepId,
        applicationID: parseInt(this.$route.query.application_id)
      }
      RestApi.getData(licenseRegistrationServiceBaseUrl, stepFormData, params).then(response => {
        if (isNotEmpty(response.data)) {
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
                this.formInputData.push(dataJson)
                this.tindex++
              })
            })
            this.totalTab = this.tabData.length - 1
          }
          this.loading = false
        this.updateLayout()
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
    },
    async saveFormData () {
      const sData = []
      const data = this.formInputData
      this.tabData.forEach((tabItem) => {
        const tData = {}
        data.forEach((item) => {
          if (item.indexId === tabItem.tab_no) {
            tData[item.field_name] = item.value
          }
        })
        sData.push(tData)
      })
      this.sInfo.org_id = this.$route.query.org_id
      this.sInfo.service_id = this.$route.query.service_id
      this.sInfo.service_name = wordsToSnake(this.getServiceName(this.$route.query.service_id))
      this.sInfo.step_id = this.step_id
      this.sInfo.step_name = wordsToSnake(this.getStepName(this.$route.query.step_id))
      this.sInfo.tabInfo = this.tabData
      this.sInfo.application_id = this.$route.query.application_id
      const formData = {
        data: sData,
        service_info: this.sInfo
      }
      let result = null
      this.actionLoad = true
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, surveyDataStore, formData)
      this.actionLoad = false
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
    getServiceName (sId) {
      const service = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => item.service_id === parseInt(sId))
      return service.service_name
    },
    getStepName (stId) {
      const step = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.find(item => item.step_id === parseInt(stId))
      return step.step_name
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
    backStep () {
      this.$router.go(-1)
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
