<template>
  <b-container fluid>
    <b-row class="inputSection" no-gutters>
      <b-col>
        <b-card class="text-left mt-2 p-0 bg-primary">
          <h4 class="card-title">{{ $t('dynamic_form.document_builder') }}</h4>
        </b-card>
      </b-col>
    </b-row>
    <b-row>
      <ValidationObserver ref="form" v-slot="{ handleSubmit }">
        <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
          <b-overlay :show="loading">
            <b-row>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Document title (En)" vid="document_title_en" rules="required">
                  <b-form-group
                      label-for="document_title_en"
                      slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('dynamic_form.document_title_en')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="document_title_en"
                        v-model="serviceInfo.document_title"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Document title (Bn)" vid="document_title_bn" rules="required">
                  <b-form-group
                      label-for="document_title_bn"
                      slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('dynamic_form.document_title_bn')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                        id="document_title_bn"
                        v-model="serviceInfo.document_title_bn"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" sm="6" md="6">
                <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="org_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.organization') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="serviceInfo.org_id"
                      :options="orgList"
                      id="org_id"
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
                <ValidationProvider name="Service" vid="service_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="service_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('service_name.service_name') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="serviceInfo.service_id"
                      :options="serviceList"
                      id="service_id"
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
                <ValidationProvider name="Step" vid="service.step_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="service.step_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('step_name.step_name') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="serviceInfo.step_id"
                      :options="stepList"
                      id="service.step_id"
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
              <b-col v-if="serviceInfo.step_id !== 0" lg="6" sm="6" md="6">
                <ValidationProvider name="Page Size" vid="service.page_size" rules="required">
                  <b-form-group
                    label-for="service.page_size"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('component_settings.page_size') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="serviceInfo.page_size"
                      :options="printTypeList"
                      id="service.page_size"
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
              <b-col v-if="serviceInfo.step_id !== 0" lg="6" sm="6" md="6">
                <ValidationProvider name="Border Design" vid="service.border_pattern" rules="required">
                  <b-form-group
                    label-for="service.border_pattern"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('component_settings.border_pattern') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="serviceInfo.border_pattern"
                      :options="bPatternTypeList"
                      id="service.border_pattern"
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
              <b-col v-if="serviceInfo.step_id !== 0" lg="6" sm="6" md="6">
                <span class="col-sm-4 float-right fields" style="cursor:pointer;" @click="addItem(component)">
                  <i class="mr-1" :class="component.icon"></i><span class="mr-1" >{{ component.text }}</span>
                </span>
              </b-col>
            </b-row>
          </b-overlay>
          <b-row>
            <b-col md="12" lg="12" sm="12" >
              <b-card no-body>
                <template :id="index">
                  <b-overlay :show="loading">
                    <b-row class="p-0 m-0">
                      <b-col md="12">
                        <div v-bind:class="page_pattern" style="margin: auto">
                          <grid-layout :layout.sync="layout"
                            :col-num="colNum"
                            :row-height="12"
                            :is-draggable="draggable"
                            :is-resizable="resizable"
                            :vertical-compact="true"
                            :use-css-transforms="false"
                            :key="layoutkey"
                            style="width: 100%"
                          >
                            <grid-item v-for="(item, dindex) in layout"
                              :x="item.x"
                              :y="item.y"
                              :w="item.w"
                              :h="item.h"
                              :i="item.i"
                              :key="dindex"
                            >
                              <commonComponent :Sdata="formInputData[dindex]" :key="componentKey"/>
                              <span class="edit" @click="editItem(dindex)"><i class="fa fa-pen" style="font-size: 10px;"></i></span>
                              <span class="remove" @click="removeItem(dindex)"><i class="fa fa-times"></i></span>
                            </grid-item>
                          </grid-layout>
                        </div>
                      </b-col>
                    </b-row>
                  </b-overlay>
                  <hr />
                  <div class="row mt-4">
                    <div class="col-sm-3"></div>
                    <div class="col text-right">
                      <b-button type="submit" variant="primary" class="mr-2">{{ saveBtnName }}</b-button>
                      <b-button @click="reset()" variant="warning" class="mr-1">{{ $t('globalTrans.reset') }}</b-button>
                      <router-link to="document-builder" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.cancel') }}</router-link>
                    </div>
                  </div>
                </template>
              </b-card>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
    </b-row>
    <b-modal id="modal-form" size="lg" :title="$t('component_settings.add_column')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ColumnModal @addColumnData="inputData" :formList="formList" :editData="editData"/>
    </b-modal>
  </b-container>
</template>
<script>
import commonComponent from './components/commonComponent'
import ColumnModal from './components/modal/column-modal'
import { GridLayout, GridItem } from 'vue-grid-layout'
import { ValidationObserver, ValidationProvider } from 'vee-validate'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { documentStore, documentUpdate, documentShow } from '../../api/routes'
import { isNotEmpty, wordsToSnake } from '@/utils/fliter'

export default {
  components: {
    ColumnModal,
    GridLayout,
    GridItem,
    ValidationObserver,
    ValidationProvider,
    commonComponent
  },
  data () {
    return {
      isEdit: false,
      saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      layout: [],
      component: { x: 2, y: 0, w: 2, h: 2, i: '1', text: this.$t('component_settings.add_column'), icon: 'fa fa-list' },
      draggable: true,
      resizable: true,
      colNum: 12,
      index: 0,
      serviceInfo: {
        document_title: '',
        document_title_bn: '',
        org_id: 0,
        service_id: 0,
        step_id: 0,
        page_size: 'A4',
        border_pattern: 'design_one'
      },
      serviceList: [],
      stepList: [],
      formList: [],
      columnLoading: false,
      update: false,
      loading: false,
      editIndex: '',
      editData: '',
      formInputData: [],
      la: '',
      componentKey: 0,
      layoutkey: 0,
      printTypes: [
          { value: 'A4', text_en: 'A4', text_bn: 'এ ফোর' },
          { value: 'landscape', text_en: 'Landscape', text_bn: 'ল্যান্ডস্কেপ' }
      ],
      bPatternTypes: [
        { value: 'none', text_en: 'None', text_bn: 'কোনটি না' },
        { value: 'design_one', text_en: 'Uncontrolled Crop', text_bn: 'অনিয়ন্ত্রিত ফসল' },
        { value: 'design_two', text_en: 'Seed Dealer', text_bn: 'বীজ ডিলার' },
        { value: 'design_three', text_en: 'Agri marketing License', text_bn: 'এগ্রি মার্কেটিং লাইসেন্স' },
        { value: 'design_four', text_en: 'Irrigation License', text_bn: 'সেচ লাইসেন্স' },
        { value: 'design_five', text_en: 'New Tube Well License(BADC)', text_bn: 'নতুন নলকূপ লাইসেন্স (BADC)' }
      ],
      page_pattern: 'A4_design_one'
    }
  },
  created () {
    if (this.$route.query.id) {
      this.isEdit = true
      this.getDynamicFormData()
    }
    this.genIndex()
  },
  watch: {
    'serviceInfo.org_id': function (newValue, oldVal) {
      if (newValue !== oldVal) {
        this.serviceList = this.getServiceList(newValue)
      }
    },
    'serviceInfo.service_id': function (newValue, oldVal) {
      if (newValue !== oldVal) {
        this.stepList = this.getStepList(newValue)
        this.formList = this.getFormList(newValue)
      }
    },
    'serviceInfo.page_size': function (newValue, oldVal) {
      if (newValue !== oldVal) {
        this.page_pattern = newValue + '_' + this.serviceInfo.border_pattern
      }
    },
    'serviceInfo.border_pattern': function (newValue, oldVal) {
      if (newValue !== oldVal) {
        this.page_pattern = this.serviceInfo.page_size + '_' + newValue
      }
    }
  },
  computed: {
    orgList: function () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    dynamicFormList: function () {
      return this.$store.state.licenseRegistration.commonObj.dynamicFormList
    },
    inputTypeList: function () {
      return this.inputOptionList.map(item => {
        return Object.assign({}, item, { value: item.item, text: this.$i18n.locale === 'en' ? item.text_en : item.text_bn })
      })
    },
    printTypeList: function () {
      return this.printTypes.map(item => {
          if (this.$i18n.locale === 'bn') {
              return Object.assign(item, { text: item.text_bn, value: item.value })
          } else {
              return Object.assign(item, { text: item.text_en, value: item.value })
          }
      })
    },
    bPatternTypeList: function () {
      return this.bPatternTypes.map(item => {
          if (this.$i18n.locale === 'bn') {
              return Object.assign(item, { text: item.text_bn, value: item.value })
          } else {
              return Object.assign(item, { text: item.text_en, value: item.value })
          }
      })
    }
  },
  methods: {
    isNotEmpty (val) {
      return isNotEmpty(val)
    },
    genIndex () {
      this.index = Math.floor(1000 + Math.random() * 9000)
    },
    getServiceList (orgId = null) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(service => service.org_id === orgId)
    },
    getStepList (serviceId = null) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(step => step.service_id === serviceId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.step_id, text: obj.step_name_bn }
        } else {
          return { value: obj.step_id, text: obj.step_name }
        }
      })
    },
    getFormList (serviceId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.filter(form => form.service_id === serviceId).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.form_id, text: obj.form_title }
        } else {
          return { value: obj.form_id, text: obj.form_title }
        }
      })
    },
    getDynamicFormData () {
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, documentShow + '/' + this.$route.query.id).then(response => {
        if (isNotEmpty(response.data)) {
          this.serviceInfo.document_title = response.data.document_title
          this.serviceInfo.document_title_bn = response.data.document_title_bn
          this.serviceInfo.org_id = response.data.org_id
          this.serviceInfo.service_id = response.data.service_id
          this.serviceInfo.step_id = response.data.step_id
          this.serviceInfo.page_size = response.data.page_size
          this.serviceInfo.border_pattern = response.data.border_pattern
          response.data.document_layouts.forEach((layItem) => {
            const layJson = JSON.parse(layItem.layout)
            const dataJson = JSON.parse(layItem.data)
            this.layout.push(layJson)
            this.formInputData.push(dataJson)
          })
        }
        this.loading = false
      })
    },
    async saveFormData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const formData = {
        service: this.serviceInfo,
        layout: this.layout,
        data: this.formInputData
      }
      let result = null
      const loadinState = { loading: false, listReload: false }
      this.loading = true

      if (this.$route.query.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${documentUpdate}/${this.$route.query.id}`, formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, documentStore, formData)
      }
      this.loading = false
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      if (result.success) {
        this.$store.dispatch('licenseRegistration/mutateLicenseRegistrationProperties', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$route.query.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.push('/license-registration-service/configuration/document-builder')
        if (this.$route.query.id) {
          this.$router.push('/license-registration-service/configuration/document-builder')
        }
        // this.reset()
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    reset () {
      this.genIndex()
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
    },
    addItem: function (item) {
      this.editData = ''
      this.$bvModal.show('modal-form')
    },
    removeItem: function (val) {
      const index = val
      this.layout.splice(index, 1)
      this.formInputData.splice(index, 1)
      this.layoutkey = this.layoutkey + 1
    },
    editItem: function (val) {
      this.editIndex = val
      this.update = true
      const data = this.formInputData[val]
      this.editData = data
      this.$bvModal.show('modal-form1')
    },
    updateDropdown: function (updata, nindex) {
      this.componentKey += 1
    },
    wordsToSnake (val) {
      return wordsToSnake(val)
    },
    inputData (data, modalName) {
      if (this.update === true) {
        this.formInputData[this.editIndex] = data
        this.editIndex = ''
        this.update = false
        this.editData = ''
        this.$bvModal.hide(modalName)
        this.componentKey += 1
      } else {
        this.$bvModal.hide(modalName)
        this.addLayout()
        this.formInputData.push(data)
      }
    },
    addLayout () {
      this.la = {
        x: (this.layout.length * 2) % (this.colNum || 12),
        y: this.layout.length + (this.colNum || 12),
        w: 2,
        h: 2,
        i: this.index
      }
      this.layout.push(this.la)
      this.genIndex()
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
}
.edit {
    position: absolute;
    right: 17px;
    top: 0;
    cursor: pointer;
    font-size: 12px;
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
    width: 10px!important;
    height: 10px!important;
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
  background-color: #66aee6;
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
.A4_none {
  width:21cm;
  height: 1200pt !important;
  margin: auto !important;
}
.A4_design_one {
  width:21cm;
  height: 1217px;
  margin: auto !important;
  background: url('../../../../../assets/images/design-one-A4.jpg');
  background-size: cover;
  padding: 45px;
  /* border: 10px solid transparent;
  border-image: url('../../../../../assets/images/border.png') 30 repeat;
  border-image-width: 14px; */
}
.A4_design_two {
  width:21cm;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-two-A4.jpg');
  background-size: cover;
  border: 10px solid #01035c;
}
.A4_design_two::before {
  width:21cm;
  content: '';
  position: absolute;
  left: 4px;
  right: 4px;
  top: 4px;
  bottom: 4px;
  border: 7px solid #564b00;
}
.A4_design_three {
  width:21cm;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-three-A4.jpg');
  background-size: cover;
}
.A4_design_four {
  width:21cm;
  height: 1200pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-four-A4.jpg');
  background-size: cover;
}
.A4_design_five {
  width:21cm;
  height: 42cm !important;
  background: url('../../../../../assets/images/design-four-A4.jpg');
  background-size: cover;
  border: 5px solid #01035c;
  margin: auto;
  background-position-y: 150%;
}
.landscape_none {
  height: 780pt !important;
  margin: auto !important;
}
.landscape_design_one {
  position: relative;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-one-landscape.jpg');
  background-size: cover;
}
.landscape_design_two {
  position: relative;
  width: 100% !important;
  background: url('../../../../../assets/images/design-two-landscape.jpg');
  background-size: cover;
  border: 10px solid #01035c;
  padding: 10px;
  margin: 20px;
}
.landscape_design_two::before {
  content: '';
  position: absolute;
  left: 4px;
  right: 4px;
  top: 4px;
  bottom: 4px;
  border: 7px solid #564b00;
}
.landscape_design_three {
  position: relative;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-three-landscape.jpg');
  background-size: cover;
}
.landscape_design_four {
  position: relative;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-four-landscape.jpg');
  background-size: cover;
}
.landscape_design_five {
  position: relative;
  height: 780pt !important;
  margin: auto !important;
  background: url('../../../../../assets/images/design-four-landscape.jpg');
  background-size: cover;
}
.report-wrapper {
    font-size: 1rem
}
</style>
