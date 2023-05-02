<template>
  <b-row>
    <b-overlay :show="loading">
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(addTmp)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
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
                  v-model="formAssign.org_id"
                  :options="orgProfileList"
                  :disabled="isDisable"
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
                  v-model="formAssign.service_id"
                  :options="serviceList"
                  :disabled="isDisable"
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
                  v-model="detailsFormData.step_id"
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
                    v-model="detailsFormData.application_id"
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
            <b-col lg="6" sm="6" md="6">
              <ValidationProvider name="Form Type" vid="form_type" rules="required|min_value:1">
                <b-form-group
                  label-for="form_type"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('component_settings.form_type') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="detailsFormData.form_type"
                    :options="formTypeList"
                    id="form_type"
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
            <b-col class="text-right mt-2">
              <b-button type="button" variant="primary" class="btn-sm mb-2" @click="addTmp()">{{ $t('globalTrans.add') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </ValidationObserver>
      <ValidationObserver ref="form1" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off" enctype="multipart/form-data">
          <b-row>
            <b-table-simple bordered>
              <thead>
                <tr class="">
                  <th scope="col">{{ $t('globalTrans.sl_no') }}</th>
                  <th scope="col">{{ $t('step_name.step_name') }}</th>
                  <th scope="col">{{ $t('dynamic_form.form_title') }}</th>
                  <th scope="col">{{ $t('component_settings.form_type') }}</th>
                  <th scope="col" class="text-center">{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                <slot v-for="(item, index) in formAssign.details">
                  <b-tr>
                    <td>
                      {{ $n(index + 1) }}
                    </td>
                    <td>
                      {{ getStepName(item.step_id) }}
                    </td>
                    <b-td> {{ getFormName(item.application_id) }} </b-td>
                    <b-td> {{ getFormType(item.form_type) }} </b-td>
                    <td>
                      <b-button type="button" @click="remove(index)" class="btn btn- iq-bg-danger btn-sm text-center ml-1"><i class="ri-delete-bin-line m-0"></i></b-button>
                    </td>
                  </b-tr>
                </slot>
              </b-tbody>
            </b-table-simple>
          </b-row>
          <b-row class="text-right">
            <b-col>
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { formAssignStore, formAssignUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item', 'id', 'orgId'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      serviceList: [],
      stepList: [],
      formList: [],
      isDisable: false,
      detailsFormData: {
        step_id: 0,
        application_id: 0,
        form_type: 0
      },
      formAssign: {
        org_id: 0,
        service_id: 0,
        details: []
      },
      formTypeList: [
        { value: 1, text: this.$t('globalTrans.action') },
        { value: 2, text: this.$t('globalTrans.entry') }
      ]
    }
  },
  created () {
    if (this.id) {
      this.isDisable = true
      const tmp = this.getServiceStepData(this.item)
      this.formAssign.org_id = this.item.org_id
      this.formAssign.service_id = this.item.service_id
      this.formAssign.details = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
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
    'formAssign.service_id': function (newVal) {
      this.stepList = this.getStepList(newVal)
    },
    'detailsFormData.step_id': function (n, o) {
       if (n !== o) {
        this.formList = this.getStepWiseForm(n)
       }
    }
  },
  methods: {
    getServiceList (orgId) {
      const serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
      const formasigned = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm
      if (this.id) {
        return serviceList
      } else {
        const newServiceList = []
        serviceList.forEach(item => {
          const findForm = formasigned.find(assignedItem => assignedItem.service_id === item.value && assignedItem.org_id === item.org_id)
          if (!findForm) {
            if (this.$i18n.locale === 'bn') {
              newServiceList.push({ value: item.value, text: item.text_en })
            } else {
              newServiceList.push({ value: item.value, text: item.text_en })
            }
          }
        })
        return newServiceList
      }
    },
    addTmp () {
      const applicationId = this.detailsFormData.application_id
      const stepId = this.detailsFormData.step_id
      if (this.formAssign.org_id !== 0 && this.formAssign.service_id !== 0) {
        this.isDisable = true
      }
      const checkService = this.formAssign.details.find(item => item.application_id === applicationId && item.step_id === stepId)
      const checkEntryForm = this.formAssign.details.find(item => item.form_type === 2 && this.details.form_type === 2)
      if (typeof checkService === 'undefined' && typeof checkEntryForm === 'undefined') {
        this.formAssign.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
        this.detailsFormData.step_id = 0
        this.detailsFormData.application_id = 0
        this.detailsFormData.form_type = 0
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      }
    },
    remove (key) {
      this.formAssign.details.splice(key, 1)
    },
    getServiceStepData (data) {
      const detailData = []
      Object.entries(data.details).forEach(([key, value]) => {
          const stepItem = { step_id: value.step_id, application_id: value.form_id, form_type: value.form_type }
          detailData.push(stepItem)
      })
      return detailData
    },
    getStepName (stepId) {
      const tmpStep = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.find(step => step.value === stepId)
      return this.$i18n.locale === 'en' ? tmpStep !== undefined ? tmpStep.text_en : '' : tmpStep !== undefined ? tmpStep.text_bn : ''
    },
    getFormName (applicationId) {
      const tmpStep = this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList.find(item => item.value === applicationId)
      return this.$i18n.locale === 'en' ? tmpStep !== undefined ? tmpStep.text_en : '' : tmpStep !== undefined ? tmpStep.text_en : ''
    },
    getFormType (typeID) {
      const tmpStep = this.formTypeList.find(item => item.value === typeID)
      return tmpStep !== undefined ? tmpStep.text : ''
    },
    getStepWiseForm () {
      const tmpFormList = this.$store.state.LicenseRegistrationService.commonObj.dynamicFormList.filter(item => item.status === 1)
      const formasigned = this.$store.state.LicenseRegistrationService.commonObj.serviceStepForm
      const newList = []
      tmpFormList.forEach(item => {
        const findForm = formasigned.find(assignedItem => assignedItem.form_id === item.value && assignedItem.service_id !== this.formAssign.service_id)
        if (!findForm) {
          if (this.$i18n.locale === 'bn') {
            newList.push({ value: item.value, text: item.text_en })
          } else {
            newList.push({ value: item.value, text: item.text_en })
          }
        }
      })
      return newList
    },
    getStepList (serviceId) {
      const tmpStepList = this.$store.state.LicenseRegistrationService.commonObj.serviceSteps.filter(item => item.service_id === serviceId)
      const stepList = tmpStepList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.step_id, text: item.step_name_bn }
        } else {
          return { value: item.step_id, text: item.step_name }
        }
      })
      return stepList
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${formAssignUpdate}/${this.id}`, this.formAssign)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, formAssignStore, this.formAssign)
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

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
