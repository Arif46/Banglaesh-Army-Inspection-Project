<template>
  <b-row>
    <b-overlay :show="loading">
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(storeUpdate)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
          <b-row>
            <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Organization" vid="org_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="org_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('orgProfile.org_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAssign.org_id"
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
                  class="row"
                  label-cols-sm="12"
                  label-for="service_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('service_name.service_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="details.service_id"
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
                  class="row"
                  label-cols-sm="12"
                  label-for="step_id"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('step_name.step_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="formAssign.step_id"
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
              <ValidationProvider name="Choose Panel" vid="choose_panel" rules="required|min_value:1">
                  <b-form-group
                      class="row"
                      label-cols-sm="12"
                      label-for="choose_panel"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                      {{ $t('step_name.choose_panel') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                      plain
                      v-model="formAssign.panel"
                      :options="chosePanel"
                      id="choose_panel"
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
            <b-col sm="6" lg="6" md="6" v-if="menuUrlShow">
                <ValidationProvider name="Module" vid="public_menu" rules="required">
                  <b-form-group
                    class="row"
                    label-cols-sm="5"
                    label-for="public_menu"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{ $t('form_menu_assign.menu_url')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formAssign.public_menu"
                      :options="getMenuList"
                      id="public_menu"
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
            <b-col sm="6" lg="6" md="6" v-if="moduleShow">
                <ValidationProvider name="Module" vid="module_id" rules="required|min_value:1">
                  <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="module_id"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{ $t('form_menu_assign.module')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formAssign.module_id"
                      :options="getModuleList(7)"
                      id="module_id"
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
            <b-col sm="6" lg="6" md="6" v-if="moduleShow">
                <ValidationProvider name="Step Type" vid="step_type" rules="required">
                  <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="step_type"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{ $t('component_settings.step_type')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="formAssign.step_type"
                      :options="choseStepType"
                      id="step_type"
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
            <b-col lg="6" sm="6" md="6" v-if="formAssign.step_type === 'static'">
              <ValidationProvider name="Static Url" vid="static_url">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="static_url"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{ $t('component_settings.static_url')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="static_url"
                    v-model="formAssign.static_url"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="6" md="6" v-if="formAssign.step_type === 'static'">
            </b-col>
            <b-col lg="6" sm="6" md="6" v-if="moduleShow">
              <ValidationProvider name="Menu name (En)" vid="menu_name" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="menu"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{ $t('form_menu_assign.menu_name_en')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="menu_name"
                    v-model="formAssign.menu_name"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" sm="6" md="6" v-if="moduleShow">
              <ValidationProvider name="Menu name (Bn)" vid="menu_name_bn" rules="required">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="email"
                  slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{ $t('form_menu_assign.menu_name_bn')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="name"
                    v-model="formAssign.menu_name_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row>
            <b-col lg="6" xl="6">
              <ValidationProvider name="Search Title (En)" vid="search_title_en" rules="required">
                <b-form-group
                  label-cols-sm="12"
                  label-for="search_title_en"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('component_settings.search_title_en') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    plain
                    v-model="formAssign.search_title_en"
                    id="search_title_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                    autocomplete="off"
                    >
                  </b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col lg="6" xl="6">
              <ValidationProvider name="Search Title (Bn)" vid="search_title_bn" rules="required">
                <b-form-group
                  label-cols-sm="12"
                  label-for="search_title_bn"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('component_settings.search_title_bn') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    plain
                    v-model="formAssign.search_title_bn"
                    id="search_title_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                    autocomplete="off"
                    >
                  </b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row>
                <b-col lg="6" xl="6">
                <ValidationProvider name="Grid Title (En)" vid="grid_title_en" rules="required">
                  <b-form-group
                    label-cols-sm="12"
                    label-for="grid_title_en"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('component_settings.grid_title_en') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      plain
                      v-model="formAssign.grid_title_en"
                      id="grid_title_en"
                      :state="errors[0] ? false : (valid ? true : null)"
                      autocomplete="off"
                      >
                    </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" xl="6">
                <ValidationProvider name="Grid Title (Bn)" vid="grid_title_bn" rules="required">
                  <b-form-group
                    label-cols-sm="12"
                    label-for="grid_title_bn"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('component_settings.grid_title_bn') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-input
                      plain
                      v-model="formAssign.grid_title_bn"
                      id="grid_title_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                      autocomplete="off"
                      >
                    </b-form-input>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" xl="6">
                <ValidationProvider name="Required" vid="is_forward">
                  <b-form-group
                      class="row"
                      label-cols-sm="5"
                      label-for="is_forward"
                  >
                      <template v-slot:label>
                        {{ $t('component_settings.forward') }}
                      </template>
                      <b-form-checkbox
                          class="mt-2"
                          id="is_forward"
                          v-model="formAssign.is_forward"
                      > <span v-if="formAssign.is_forward">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                      </b-form-checkbox>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col lg="6" xl="6">
                <ValidationProvider name="Required" vid="is_application">
                  <b-form-group
                      class="row"
                      label-cols-sm="5"
                      label-for="is_application"
                  >
                      <template v-slot:label>
                        {{ $t('component_settings.application') }}
                      </template>
                      <b-form-checkbox
                          class="mt-2"
                          id="is_application"
                          v-model="formAssign.is_application"
                      > <span v-if="formAssign.is_application">{{ $t('globalTrans.yes') }}</span><span v-else>{{ $t('globalTrans.no') }}</span>
                      </b-form-checkbox>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
          </b-row>
          <b-row>
            <b-col class="text-right mt-2">
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
    </b-overlay>
  </b-row>
</template>
<script>
import RestApi, { commonServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { menuStore, menuUpdate, menuAssignStore, menuAssignUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item', 'id', 'orgId'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      details: {
        service_id: 0
      },
      formAssign: {
        grid_title_en: '',
        grid_title_bn: '',
        search_title_en: '',
        search_title_bn: '',
        component_id: 7,
        module_id: 0,
        step_type: 'dynamic',
        menu_name: '',
        menu_name_bn: '',
        url: '',
        sorting_order: 100000000,
        associated_urls: '',
        panel: 2,
        public_menu: 0,
        org_id: 0,
        step_id: 0,
        menu_id: 0,
        is_forward: 0,
        is_application: 0,
        details: [],
        static_url: '',
        service_id: 0
      },
      stepList: [],
      serviceList: [],
      menuUrlShow: false,
      moduleShow: false,
      getMenuList: [
        { value: 'application', text: 'Apllication' }
      ],
      storeData: []
    }
  },
  created () {
    if (this.id) {
      this.storeData = this.item
      const tmp = this.getServiceStepData(this.storeData)
      const isForward = Boolean(this.storeData.is_forward)
      const isApplication = Boolean(this.storeData.is_application)
      const tmpData = Object.assign(this.storeData, { is_forward: isForward, is_application: isApplication })
      this.formAssign = tmpData
      this.formAssign.service_id = this.item.service_id
      this.details.service_id = tmp[0] !== undefined ? tmp[0].service_id : 0
    }
    this.menuUrlShow = false
    this.moduleShow = true
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    chosePanel: function () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Public' : 'পাবলিক' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Admin' : 'এডমিন' }
      ]
      return list
    },
    choseStepType: function () {
      const list = [
        { value: 'dynamic', text: this.$i18n.locale === 'en' ? 'Dynamic' : 'ডাইনামিক' },
        { value: 'static', text: this.$i18n.locale === 'en' ? 'Static' : 'স্ট্যাটিক' }
      ]
      return list
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  watch: {
    'formAssign.org_id': function (newVal) {
      this.stepList = []
      this.serviceList = this.getServiceList(newVal)
    },
    'details.service_id': function (newVal) {
      this.stepList = this.getStepList(newVal)
    }
  },
  methods: {
    getServiceList (orgId) {
      const stepList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.org_id === orgId)
      return stepList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text }
        }
      })
    },
    getStepList (serviceID) {
      const stepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === serviceID)
      return stepList.map(stepItem => {
        if (this.$i18n.locale === 'bn') {
          return { value: stepItem.step_id, text: stepItem.step_name_bn }
        } else {
          return { value: stepItem.step_id, text: stepItem.step_name }
        }
      })
    },
    getServiceStepData (data) {
      const detailData = []
      Object.entries(data.details).forEach(([key, value]) => {
          const stepItem = { service_id: value.service_id }
          detailData.push(stepItem)
      })
      return detailData
    },
    getModuleList (componentId = 7) {
      const moduleList = this.$store.state.CommonService.commonObj.moduleList.filter(item => item.status === 1)
      if (componentId) {
        const moduleData = moduleList.filter(module => module.component_id === componentId)
        const tmpList = moduleData.map((obj, index) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text }
          }
        })
        return tmpList
      }
    },
    async storeUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      let tmpMenu = ''
      let tmpUpdateMenu = ''
      const loadinState = { loading: false, listReload: false }
      if (this.formAssign.step_type === 'static') {
        tmpMenu = Object.assign(this.formAssign, { url: this.formAssign.static_url })
      } else {
        tmpMenu = Object.assign(this.formAssign, { url: '/license-registration-service/license-step/steps/' + this.formAssign.menu_id })
      }
      if (this.id) {
        if (this.formAssign.panel === 1) {
          result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${menuAssignUpdate}/${this.item.id}`, this.formAssign)
        } else {
          if (this.formAssign.step_type === 'static') {
            tmpUpdateMenu = Object.assign(this.formAssign, { url: this.formAssign.static_url + '/' + this.formAssign.menu_id }, { component_id: 7 }, { sorting_order: 100000000 })
          } else {
            tmpUpdateMenu = Object.assign(this.formAssign, { url: '/license-registration-service/license-step/steps/' + this.formAssign.menu_id }, { component_id: 7 }, { sorting_order: 100000000 })
          }
          result = await RestApi.putData(commonServiceBaseUrl, `${menuUpdate}/${this.item.menu_id}`, tmpUpdateMenu)
          if (result.success) {
            this.formAssign.menu_id = result.data.id
            const tmpMenuAssign = Object.assign(result.data, this.formAssign, { step_id: this.formAssign.step_id })
            result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${menuAssignUpdate}/${this.item.id}`, tmpMenuAssign)
          }
        }
      } else {
        this.formAssign.details.push(JSON.parse(JSON.stringify(this.details)))
        this.formAssign.service_id = this.formAssign.details[0].service_id
        // for public user
        if (this.formAssign.panel === 1) {
          result = await RestApi.postData(licenseRegistrationServiceBaseUrl, menuAssignStore, this.formAssign)
        } else {
          const resultCommon = await RestApi.postData(commonServiceBaseUrl, menuStore, tmpMenu)
          if (resultCommon.success) {
            this.formAssign.menu_id = resultCommon.model.id
            result = await RestApi.postData(licenseRegistrationServiceBaseUrl, menuAssignStore, this.formAssign)
            let saveMenu = ''
            if (this.formAssign.step_type === 'dynamic') {
              saveMenu = Object.assign(resultCommon, this.formAssign, { url: '/license-registration-service/license-step/steps/' + resultCommon.model.id })
              // menu url update
            } else {
              saveMenu = Object.assign(resultCommon, this.formAssign, { url: this.formAssign + '/' + resultCommon.model.id })
            }
            await RestApi.putData(commonServiceBaseUrl, `${menuUpdate}/${resultCommon.model.id}`, saveMenu)
          }
        }
      }
      loadinState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadinState)
      this.loading = false
      if (result.exist) {
        this.$toast.error({
          title: 'Error',
          message: result.message
        })
        return
      }
      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
