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
                  v-model="stepAssign.org_id"
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
                  v-model="stepAssign.service_id"
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
            <b-col xs="12" sm="12" md="6">
              <ValidationProvider name="Order" vid="order" rules="required" v-slot="{ errors }">
                <b-form-group
                  label-for="step_name">
                  <template v-slot:label>
                    {{ $t('step_assign.order') }}<span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="step_name"
                    v-model="detailsFormData.order"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
          </b-row>
          <b-row class="text-right">
            <b-col>
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
                  <th scope="col" width="15%">{{ $t('step_assign.order') }}</th>
                  <th scope="col" >{{ $t('globalTrans.action') }}</th>
                </tr>
              </thead>
              <b-tbody>
                <slot v-for="(item, index) in stepAssign.details">
                  <b-tr>
                    <td>
                      {{ $n(index + 1) }}
                    </td>
                    <td>
                      {{ getStepName(item.step_id) }}
                    </td>
                    <td>
                      <ValidationProvider name="order" vid="order" rules="required">
                        <b-form-group
                            slot-scope="{ valid, errors }"
                        >
                        <b-form-input
                        id="order"
                        v-model="item.order"
                        :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-input>
                        <div class="invalid-feedback">
                          {{ errors[0] }}
                        </div>
                        </b-form-group>
                      </ValidationProvider>
                    </td>
                    <td>
                      <b-button type="button" :title="$t('globalTrans.delete')" @click="remove(index)" class="btn btn- iq-bg-danger btn-sm text-center ml-1"><i class="ri-delete-bin-line m-0"></i></b-button>
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
import { stepAssignStore, stepAssignUpdate } from '../../api/routes'
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
      isDisable: false,
      detailsFormData: {
        step_id: 0,
        order: ''
      },
      stepAssign: {
        org_id: 0,
        service_id: 0,
        details: []
      }
    }
  },
  created () {
    if (this.id) {
      this.isDisable = true
      this.stepAssign.org_id = this.orgId
      const tmp = this.getServiceStepData(this.item)
      this.stepAssign.details = tmp
    }
  },
  watch: {
    'stepAssign.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === newVal)
      }
    },
    'stepAssign.service_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.stepList = this.$store.state.LicenseRegistrationService.commonObj.stepNamesList.filter(item => item.status === 1 && item.service_id === newVal)
      }
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
  methods: {
    addTmp () {
      const stepId = this.detailsFormData.step_id
      const checkService = this.stepAssign.details.find(item => item.step_id === stepId)
      if (this.stepAssign.org_id !== 0 && this.stepAssign.service_id !== 0) {
        this.isDisable = true
      }
      if (typeof checkService === 'undefined') {
        this.stepAssign.details.push(JSON.parse(JSON.stringify(this.detailsFormData)))
        this.detailsFormData.step_id = 0
        this.detailsFormData.order = ''
        this.$nextTick(() => {
          this.$refs.form.reset()
        })
      }
    },
    remove (key) {
      this.stepAssign.details.splice(key, 1)
    },
    getStepName (stepId) {
      const tmpStep = this.stepList.find(step => step.value === stepId)
      return this.$i18n.locale === 'en' ? tmpStep !== undefined ? tmpStep.text_en : '' : tmpStep !== undefined ? tmpStep.text_bn : ''
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${stepAssignUpdate}/${this.id}`, this.stepAssign)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, stepAssignStore, this.stepAssign)
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
    },
    getServiceStepData (data) {
      const detailData = []
      this.stepAssign.service_id = this.id
      Object.entries(data).forEach(([key, value]) => {
        Object.entries(value).forEach(([key, value]) => {
          const stepItem = { step_id: value.step_id, order: value.order }
          detailData.push(stepItem)
        })
      })
      return detailData
    },
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
