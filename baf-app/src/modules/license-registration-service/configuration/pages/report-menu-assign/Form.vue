<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
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
                v-model="reportMenuAssign.org_id"
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
              <ValidationProvider name="Module" vid="module_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-cols-sm="12"
                  label-for="module_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('orgProfile.module')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="reportMenuAssign.module_id"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Menu name (En)" vid="menu_name" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="menu"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{ $t('orgProfile.menu_name')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="menu_name"
                  v-model="reportMenuAssign.menu_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Menu name (Bn)" vid="menu_name_bn" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="email"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{ $t('orgProfile.menu_name_bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="name"
                  v-model="reportMenuAssign.menu_name_bn"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Search Title (En)" vid="search_title_en" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="search_title_en"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('component_settings.search_title_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  plain
                  v-model="reportMenuAssign.search_title_en"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Search Title (Bn)" vid="search_title_bn" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="search_title_bn"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('component_settings.search_title_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  plain
                  v-model="reportMenuAssign.search_title_bn"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Grid Title (En)" vid="grid_title_en" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="grid_title_en"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('component_settings.grid_title_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  plain
                  v-model="reportMenuAssign.grid_title_en"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Grid Title (Bn)" vid="grid_title_bn" rules="required">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="grid_title_bn"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('component_settings.grid_title_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  plain
                  v-model="reportMenuAssign.grid_title_bn"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Service Name" vid="service_id" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="service_id"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('service_name.service_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="reportMenuAssign.service_id"
                  :options="serviceList"
                  id="service_id"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Report Process" vid="report_process_id" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="report_process_id"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('component_settings.report_process') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="reportMenuAssign.report_process_id"
                  :options="reportProcessList"
                  id="report_process_id"
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
        <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl, licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { menuStore, menuUpdate, reportMenuAssignStore, reportMenuAssignUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      loading: false,
      reportMenuAssign: {
        grid_title_en: '',
        grid_title_bn: '',
        search_title_en: '',
        search_title_bn: '',
        component_id: 7,
        module_id: 0,
        menu_name: '',
        menu_name_bn: '',
        service_id: 0,
        url: '',
        sorting_order: 100000000,
        associated_urls: '',
        org_id: 0,
        report_menu_details: [],
        menu_id: 0,
        report_process_id: ''
      },
      serviceList: [],
      reportProcessList: []
    }
  },
  created () {
    if (this.id) {
      this.reportMenuAssign = this.getItemEntry()
    }
  },
  watch: {
    'reportMenuAssign.org_id': function (newValue) {
      this.serviceList = this.getServiceList(newValue)
    },
    'reportMenuAssign.service_id': function (newValue) {
      this.reportProcessList = this.getReportProcessList(newValue)
    }
  },
  computed: {
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    getServiceList (orgId) {
      const serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.org_id === orgId)
      return serviceList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    async saveUpdate () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const tmpMenu = Object.assign(this.reportMenuAssign, { url: '/license-registration-service/license-step/reports/' + this.reportMenuAssign.menu_id })
      if (this.id) {
        const tmpUpdateMenu = Object.assign(this.reportMenuAssign, { url: '/license-registration-service/license-step/reports/' + this.reportMenuAssign.menu_id }, { component_id: 7 }, { sorting_order: 100000000 })
          result = await RestApi.putData(commonServiceBaseUrl, `${menuUpdate}/${this.item.menu_id}`, tmpUpdateMenu)
          if (result.success) {
            this.reportMenuAssign.menu_id = result.model.id
            const tmpMenuAssign = Object.assign(result.data, this.reportMenuAssign, { step_id: this.reportMenuAssign.step_id })
            result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${reportMenuAssignUpdate}/${this.item.id}`, tmpMenuAssign)
          }
      } else {
          const resultCommon = await RestApi.postData(commonServiceBaseUrl, menuStore, tmpMenu)
          if (resultCommon.success) {
            this.reportMenuAssign.menu_id = resultCommon.model.id
            result = await RestApi.postData(licenseRegistrationServiceBaseUrl, reportMenuAssignStore, this.reportMenuAssign)
            const saveMenu = Object.assign(resultCommon, this.reportMenuAssign, { url: '/license-registration-service/license-step/reports/' + resultCommon.model.id })
            // menu url update
            await RestApi.putData(commonServiceBaseUrl, `${menuUpdate}/${resultCommon.model.id}`, saveMenu)
          }
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
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
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.loading = false
        this.$refs.form.setErrors(result.errors)
      }
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
    getReportProcessList (serviceID) {
      return this.$store.state.LicenseRegistrationService.commonObj.reportProcess.filter(item => item.service_id === serviceID)
    }
  }
}
</script>
