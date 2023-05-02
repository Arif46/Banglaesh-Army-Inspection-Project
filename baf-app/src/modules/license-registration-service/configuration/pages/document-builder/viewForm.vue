<template>
  <b-container fluid>
    <iq-card>
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('dynamic_form.document_builder') }}</h4>
      </template>
      <template v-slot:body>
        <ValidationObserver ref="form" v-slot="{ handleSubmit }">
          <b-form  @submit.prevent="handleSubmit(saveFormData)" @reset.prevent="reset">
            <b-overlay :show="loading">
              <b-row>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="Document title (En)" vid="document_title_en" rules="required">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
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
                          disabled
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
                        class="row"
                        label-cols-sm="4"
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
                          disabled
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
                      class="row"
                      label-cols-sm="4"
                      label-for="org_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('org_pro.organization') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="serviceInfo.org_id"
                        :options="orgList"
                        id="org_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        disabled
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
                      class="row"
                      label-cols-sm="4"
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
                        disabled
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
                      class="row"
                      label-cols-sm="4"
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
                        disabled
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
              </b-row>
            </b-overlay>
            <b-row>
              <b-col md="12" lg="12" sm="12">
                <b-card no-body>
                  <template :id="index">
                    <b-overlay :show="loading">
                      <b-row>
                        <b-col md="12" lg="12" sm="12" style="overflow-y: scroll">
                          <grid-layout :layout.sync="layout"
                            :col-num="colNum"
                            :row-height="12"
                            :is-draggable="false"
                            :is-resizable="false"
                            :vertical-compact="true"
                            :use-css-transforms="false"
                            v-bind:class="page_pattern"
                          >
                            <grid-item v-for="(item, dindex) in layout"
                              :x="item.x"
                              :y="item.y"
                              :w="item.w"
                              :h="item.h"
                              :i="item.i"
                              :key="dindex"
                            >
                            <b-row>
                              <commonComponent :Sdata="formInputData[dindex]" :key="componentKey"/>
                            </b-row>
                            </grid-item>
                          </grid-layout>
                        </b-col>
                      </b-row>
                    </b-overlay>
                    <hr />
                    <div class="row mt-4">
                      <div class="col-sm-3"></div>
                      <div class="col text-right">
                        <router-link to="document-builder" :class="'btn btn-danger mr-1'">{{ $t('globalTrans.back') }}</router-link>
                      </div>
                    </div>
                  </template>
                </b-card>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
    </iq-card>
    <b-modal id="modal-1" size="lg" :title="$t('component_settings.add_column')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
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
      page_pattern: 'A4_design_one'
    }
  },
  created () {
    if (this.$route.query.id) {
      this.isEdit = true
      this.getDynamicFormData()
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
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 0)
    },
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
    isNotEmpty (val) {
      return isNotEmpty(val)
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
            this.index = layJson.i + 1
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
    },
    addItem: function (item) {
      this.editData = ''
      this.$bvModal.show('modal-1')
    },
    removeItem: function (val) {
      const index = val
      this.layout.splice(index, 1)
      this.formInputData.splice(index, 1)
    },
    editItem: function (val) {
      this.editIndex = val
      this.update = true
      const data = this.formInputData[val]
      this.editData = data
      this.$bvModal.show('modal-1')
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
      this.index++
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
    padding: 5px;
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
.vue-grid-layout {
    background: #eee;
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
.A4_none {
  height: 1122px !important;
  margin: auto !important;
}
.A4_design_one {
  height: 1122px !important;
  margin: auto !important;
  border: 10px solid transparent;
  border-image: url('../../../../../assets/images/border.png') 30 repeat;
  border-image-width: 14px;
}
.A4_design_two {
  height: 1122px !important;
  margin: auto !important;
  border: 10px solid #01035c;
}
.A4_design_two::before {
  content: '';
  position: absolute;
  left: 4px;
  right: 4px;
  top: 4px;
  bottom: 4px;
  border: 7px solid #564b00;
}
.landscape_none {
  height: 793px !important;
  margin: auto !important;
}
.landscape_design_one {
  position: relative;
  height: 793px !important;
  margin: auto !important;
  border: 10px solid transparent;
  border-image: url('../../../../../assets/images/border.png') 30 repeat;
  border-image-width: 14px;
}
.landscape_design_two {
  position: relative;
  height: 793px !important;
  margin: auto !important;
  border: 10px solid #01035c;
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
</style>
