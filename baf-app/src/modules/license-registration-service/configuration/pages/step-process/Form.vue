<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchBody>
        <b-row>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
              <b-row>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="org_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formData.org_id"
                      :options="orgProfileList"
                      id="org_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="service_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formData.service_id"
                      :options="serviceList"
                      id="service_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Step Name" vid="step_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="step_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('step_name.step_name')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formData.step_id"
                      :options="stepList"
                      id="step_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="6" sm="6" md="6">
                  <ValidationProvider name="Form" vid="form_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="form_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('globalTrans.form') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="formData.form_id"
                        :options="formList"
                        id="form_id"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" xl="12">
                  <p class="form-style-2-heading">
                    <b>{{$t('component_settings.searching_section')}}</b>
                  </p>
                  <hr />
                </b-col>
              </b-row>
              <b-row v-for="(item, index) in formData.search" :key="index">
                <b-col lg="5" xl="5">
                  <ValidationProvider name="Field" :vid="`field_id`+index" rules="">
                    <b-form-group
                      class="row"
                      label-cols-sm="4"
                      :label-for="`field_id`+index"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="item.field_id"
                        :options="inputList"
                        :id="`field_id`+index"
                        :state="errors[0] ? false : (valid ? true : null)"
                        >
                        <template v-slot:first>
                          <b-form-select-option value="">{{$t('globalTrans.select')}}</b-form-select-option>
                          <b-form-select-option value="date" >{{ $t('component_settings.date_range') }}</b-form-select-option>
                          <b-form-select-option value="app" >{{ $t('license_config.application_id') }}</b-form-select-option>
                        </template>
                      </b-form-select>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="4" xl="4">
                  <ValidationProvider name="Required" :vid="`is_required`+index">
                    <b-form-group
                        class="row"
                        label-cols-sm="3"
                        :label-for="`is_required`+index"
                    >
                        <template v-slot:label>
                          {{ $t('component_settings.required') }}
                        </template>
                        <b-form-checkbox
                            class="mt-2"
                            :id="`is_required`+index"
                            v-model="item.is_required"
                        > <span v-if="item.is_required">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                        </b-form-checkbox>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="3" xl="3">
                  <b-button v-if="index === 0" @click="addNew()" type="button" variant="primary" class="mr-2">+</b-button>
                  <b-button v-if="index !== 0" @click="remove(index)" type="button" variant="danger" class="mr-2">x</b-button>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" xl="12">
                  <p class="form-style-2-heading">
                    <b>{{$t('component_settings.grid_section')}}</b>
                  </p>
                  <hr />
                </b-col>
                <b-col lg="12" xl="12" v-if="inputListGrid.length">
                  <ValidationProvider name="Grids" vid="grids" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="grids"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{ $t('globalTrans.select_field') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-checkbox-group
                        class="text-dark"
                        v-model="formData.grids"
                        checked="formData.grids"
                        :options="inputListGrid"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-checkbox-group>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="12" xl="12" v-else class="text-center">
                  <p class="text-dark">({{ $t('Field Not Found') }})</p>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" xl="12">
                  <p class="form-style-2-heading pb-0 mb-0">
                    <b>{{$t('component_settings.action_section')}}</b>
                  </p>
                  <hr />
                </b-col>
                <b-col lg="12" xl="12">
                  <ValidationProvider name="Actions" vid="actions" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="actions"
                      slot-scope="{ valid, errors }"
                      >
                      <b-form-checkbox-group
                        class="text-dark"
                        v-model="formData.actions"
                        :options="dynamicButtonList"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-checkbox-group>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                  <ValidationProvider name="Forward Document Required" vid="is_doc_required">
                      <b-form-group
                        class="row form-style-2-heading"
                        label-cols-sm="3"
                        label-for="is_doc_required"
                      >
                        <template v-slot:label>
                          <b>{{$t('component_settings.forward_doc_required')}}</b>
                        </template>
                        <b-form-checkbox
                          class="mt-2"
                          id="is_doc_required"
                          v-model="formData.is_doc_required"
                        >
                        <span v-if="formData.is_doc_required">{{ $t('globalTrans.yes') }}</span>
                        <span v-else>{{ $t('globalTrans.no') }}</span>
                        </b-form-checkbox>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12">
                  <ValidationProvider name="Custom Action" vid="is_custom_action">
                      <b-form-group
                        class="row form-style-2-heading"
                        label-cols-sm="3"
                        label-for="is_custom_action"
                      >
                        <template v-slot:label>
                          <b>{{$t('component_settings.custom_action')}}</b>
                        </template>
                        <b-form-checkbox
                          class="mt-2"
                          id="is_custom_action"
                          v-model="formData.is_custom_action"
                        >
                        <span v-if="formData.is_custom_action">{{ $t('globalTrans.yes') }}</span>
                        <span v-else>{{ $t('globalTrans.no') }}</span>
                        </b-form-checkbox>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col lg="12" sm="12" md="12" v-if="formData.is_custom_action">
                  <b-row v-for="(btn, index) in formData.custom_actions" :key="index">
                    <b-col lg="3" sm="3" md="3">
                      <ValidationProvider name="Form" vid="form_id" rules="required|min_value:1">
                        <b-form-group
                          class="row"
                          label-cols-sm="12"
                          label-for="form_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                          {{ $t('globalTrans.form') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select
                            plain
                            v-model="btn.form_id"
                            :options="formListAction"
                            id="org_id"
                            :state="errors[0] ? false : (valid ? true : null)"
                            >
                            <template v-slot:first>
                              <b-form-select-option :value="0" >{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="3" sm="3" md="3">
                      <ValidationProvider name="Button Name (En)" vid="btn_en" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="btn_en"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.btn_en')}}
                            </template>
                            <b-form-input
                            id="btn_en"
                            v-model="btn.btn_en"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="3" sm="3" md="3">
                      <ValidationProvider name="Button Name (Bn)" vid="btn_bn" rules="required">
                        <b-form-group
                            class="row"
                            label-cols-sm="12"
                            label-for="btn_bn"
                            slot-scope="{ valid, errors }"
                        >
                            <template v-slot:label>
                                {{$t('component_settings.btn_bn')}}
                            </template>
                            <b-form-input
                            id="btn_bn"
                            v-model="btn.btn_bn"
                            :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <b-col lg="3" xl="3">
                      <br>
                      <div class="mt-3">
                        <b-button v-if="index === 0" @click="addNewBtn()" type="button" variant="primary" class="mr-2">+</b-button>
                        <b-button v-if="index !== 0" @click="removeBtn(index)" type="button" variant="danger" class="mr-2">x</b-button>
                      </div>
                    </b-col>
                  </b-row>
                </b-col>
              </b-row>
              <b-row>
                <b-col lg="12" sm="12" md="12">
                  <ValidationProvider name="Custom Action" vid="is_summary_report_show">
                      <b-form-group
                        class="row form-style-2-heading"
                        label-cols-sm="3"
                        label-for="is_summary_report_show"
                      >
                        <template v-slot:label>
                          <b>{{$t('component_settings.is_summary_report_show')}}</b>
                        </template>
                        <b-form-checkbox
                          class="mt-2"
                          id="is_summary_report_show"
                          v-model="formData.is_summary_report_show"
                        >
                        <span v-if="formData.is_summary_report_show">{{ $t('globalTrans.yes') }}</span>
                        <span v-else>{{ $t('globalTrans.no') }}</span>
                        </b-form-checkbox>
                      </b-form-group>
                  </ValidationProvider>
                </b-col>
              </b-row>
              <b-row class="text-right">
                <b-col>
                    <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                    <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stepProcessStore, stepProcessUpdate, dynamicFormEditData } from '../../api/routes'
import { snakeToWords } from '@/utils/fliter'
export default {
  name: 'Form',
  props: ['item', 'id', 'orgId'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      isDisable: false,
      formData: {
        org_id: 0,
        service_id: 0,
        step_id: 0,
        form_id: 0,
        is_doc_required: false,
        is_custom_action: false,
        is_summary_report_show: false,
        search: [
          {
            field_id: '',
            is_required: false
          }
        ],
        grids: [],
        actions: [],
        custom_actions: [
          {
            form_id: 0,
            btn_en: '',
            btn_bn: ''
          }
        ]
      },
      stepList: [],
      formList: [],
      formListAction: [],
      inputList: [],
      inputListGrid: [],
      serviceList: [],
      loading: false
    }
  },
  created () {
    if (this.$route.query.id) {
      const tmp = this.getStepnameData()
      const search = JSON.parse(tmp.search)
      const actions = JSON.parse(tmp.actions)
      const grids = JSON.parse(tmp.grids)
      const customActions = JSON.parse(tmp.custom_actions)
      const isCustomAction = Boolean(tmp.is_custom_action)
      const isAppAddress = Boolean(tmp.is_summary_report_show)
      const isDocRequired = Boolean(tmp.is_doc_required)
      this.formData = Object.assign({}, tmp,
        { search: search, actions: actions, grids: grids, is_summary_report_show: isAppAddress, custom_actions: customActions, is_custom_action: isCustomAction, is_doc_required: isDocRequired }
      )
    }
  },
  computed: {
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    dynamicButtonList: function () {
      return this.$store.state.LicenseRegistrationService.commonObj.dynamicButtonList.filter(item => item.status === 1)
    }
  },
  watch: {
    'formData.org_id': function (newVal) {
      this.stepList = []
      this.serviceList = this.getServiceList(newVal)
    },
    'formData.service_id': function (n, o) {
       if (n !== o) {
        this.stepList = this.getServiceWiseStep(n)
        this.formList = this.getStepWiseForm(n, 2)
       }
    },
    'formData.step_id': function (n, o) {
       if (n !== o) {
        this.formListAction = this.getStepWiseForm(n, 1)
       }
    },
    'formData.form_id': function (n, o) {
       if (n !== o) {
        this.getInputList(n)
       }
    }
  },
  methods: {
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    getServiceWiseStep (serviceId) {
        const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === parseInt(serviceId))
        const stepList = tmpStepList.map(item => {
          if (this.$i18n.locale === 'bn') {
            return { text: item.step_name_bn, value: item.step_id }
          } else {
            return { text: item.step_name, value: item.step_id }
          }
        })
        return stepList
    },
    getStepWiseForm (stepOrServiceId, type) {
        let tmpFormList
        if (type === 2) {
          tmpFormList = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.filter(item => (item.service_id === parseInt(stepOrServiceId) && item.form_type === parseInt(type)))
        } else {
          tmpFormList = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm.filter(item => (item.step_id === parseInt(stepOrServiceId) && item.form_type === parseInt(type)))
        }
        const stepList = tmpFormList.map(item => {
          if (this.$i18n.locale === 'bn') {
            return { text: item.form_title, value: item.form_id }
          } else {
            return { text: item.form_title, value: item.form_id }
          }
        })
        return stepList
    },
    getInputList (dynamicFormId) {
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, dynamicFormEditData + '/' + dynamicFormId).then(response => {
        if (response.success) {
          const finalList = []
          const finalListGrid = []
          response.data.tabs.forEach(item => {
            const tmpList = {
                label: snakeToWords(item.tab_name),
                options: []
              }
            item.layouts.forEach(i => {
              const input = JSON.parse(i.data)
              if (input.field_type === 'text' || input.field_type === 'number' || input.field_type === 'options' || input.field_type === 'dropdown' || input.field_type === 'text_area' || input.field_type === 'text' || input.field_type === 'email' || input.field_type === 'date') {
                  tmpList.options.push({
                    text: input.label, value: i.id
                  })
                  finalListGrid.push({
                    text: input.label, value: i.id
                  })
                }
            })
            finalList.push(tmpList)
          })
          this.inputList = finalList
          this.inputListGrid = finalListGrid
        }
        this.loading = false
      })
    },
    getStepnameData () {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.$route.query.id))
      return JSON.parse(JSON.stringify(tmpData))
    },
    addNew () {
      const tmp = {
        field_id: 0,
        is_required: false
      }
      this.formData.search.push(tmp)
    },
    remove (index) {
      this.formData.search.splice(index, 1)
    },
    addNewBtn () {
      const tmp = {
        field_id: 0,
        is_required: false
      }
      this.formData.custom_actions.push(tmp)
    },
    removeBtn (index) {
      this.formData.custom_actions.splice(index, 1)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${stepProcessUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stepProcessStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$router.go(-1)
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
