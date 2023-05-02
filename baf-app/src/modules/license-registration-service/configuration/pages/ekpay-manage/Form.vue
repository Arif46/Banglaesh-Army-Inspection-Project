<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
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
                v-model="form.org_id"
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
                v-model="form.service_id"
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
            <ValidationProvider name="Whitelisted IP" vid="whitelist_ip" rules="required">
              <b-form-group
                label-for="whitelist_ip"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('service_name.whitelist_ip') }} <span class="text-danger">*</span>
                </template>
                  <b-form-input
                    id="whitelist_ip"
                    v-model="form.whitelist_ip"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="API Type" vid="api_type" rules="required">
              <b-form-group
                label-for="api_type"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('service_name.api_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.api_type"
                  :options="apiList"
                  id="api_type"
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
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Registration ID" vid="registration_id" rules="required">
              <b-form-group
                  label-for="registration_id"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('step_name.registration_id')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="registration_id"
                    v-model="form.registration_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Password" vid="password" rules="required">
              <b-form-group
                  label-for="password"
                  slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('step_name.password')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="password"
                    v-model="form.password"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <h5 style='font-weight:bold' class="mb-2"><u>{{ $t('component_settings.echallan') }}</u></h5>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="API Type" vid="challan_api_type" rules="">
              <b-form-group
                label-for="challan_api_type"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                {{ $t('service_name.api_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  v-model="form.challan_api_type"
                  :options="apiList"
                  id="challan_api_type"
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
          <b-col xs="12" sm="12" md="6"></b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Registration ID" vid="challan_registration_id" rules="">
              <b-form-group
                label-for="challan_registration_id"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('step_name.registration_id')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="challan_registration_id"
                    v-model="form.challan_registration_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Password" vid="challan_password" rules="">
              <b-form-group
                label-for="challan_password"
                slot-scope="{ valid, errors }"
              >
                <template v-slot:label>
                  {{$t('step_name.password')}} <span class="text-danger">*</span>
                </template>
                <b-form-input
                    id="challan_password"
                    v-model="form.challan_password"
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
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { ekpayStore, ekpayUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      serviceList: [],
      form: {
        registration_id: '',
        service_id: 0,
        api_type: 0,
        org_id: 0,
        password: '',
        whitelist_ip: '',
        challan_api_type: 0,
        challan_registration_id: '',
        challan_password: ''
      }
    }
  },
  created () {
    if (this.id) {
      this.form = this.getItemEntry()
    }
  },
  watch: {
    'form.org_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.serviceList = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === newVal)
      }
    }
  },
  computed: {
    apiList: function () {
      const apiList = [
        {
          text_en: 'Sandbox Api',
          text_bn: 'স্যান্ডবক্স এপিআই',
          value: 1
        },
        {
          text_en: 'Live Api',
          text_bn: 'লাইভ অপি',
          value: 2
        }
      ]
      return apiList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { text: item.text_bn, value: item.value }
        } else {
          return { text: item.text_en, value: item.value }
        }
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    commonGridList () {
      return [
        {
          text: 'Organization',
          text_bn: 'সংস্থা',
          value: 'org_id'
        },
        {
          text: 'Service',
          text_bn: 'সার্ভিস',
          value: 'service_id'
        },
        {
          text: 'Status',
          text_bn: 'অবস্থা',
          value: 'status'
        },
        {
          text: 'Application Id',
          text_bn: 'আবেদন আইডি',
          value: 'application_id'
        }
      ]
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${ekpayUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, ekpayStore, this.form)
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
    getItemEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
