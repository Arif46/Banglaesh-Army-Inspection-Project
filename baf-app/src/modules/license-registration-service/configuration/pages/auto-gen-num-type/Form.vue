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
                v-model="form.service_name_id"
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
            <ValidationProvider name="Auto Gen Number Type (En)" vid="auto_gen_num_type_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="auto_gen_num_type_en">
                <template v-slot:label>
                  {{ $t('auto_gen_num_type.auto_gen_num_type_en') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="auto_gen_num_type_en"
                  v-model="form.auto_gen_num_type_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Auto Gen Number Type (Bn)" vid="auto_gen_num_type_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="auto_gen_num_type_bn">
                <template v-slot:label>
                  {{ $t('auto_gen_num_type.auto_gen_num_type_bn') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="auto_gen_num_type_bn"
                  v-model="form.auto_gen_num_type_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Starting prefix" vid="starting_prefix" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="starting_prefix">
                <template v-slot:label>
                  {{ $t('auto_gen_num_type.starting_prefix') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="starting_prefix"
                  v-model="form.starting_prefix"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="starting Number" vid="starting_number" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="starting_number">
                <template v-slot:label>
                  {{ $t('auto_gen_num_type.starting_number') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="starting_number"
                  v-model="form.starting_number"
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
import { autoGenNumTypeStore, autoGenNumTypeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        service_name_id: 0,
        auto_gen_num_type_en: '',
        auto_gen_num_type_bn: '',
        starting_prefix: '',
        starting_number: ''
      },
      serviceList: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAutoEntry()
      this.form = tmp
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
    'form.org_id': function (newVal) {
      this.serviceList = this.getServiceList(newVal)
    }
  },
  methods: {
    getServiceList (orgId) {
      return this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.filter(item => item.status === 1 && item.org_id === orgId)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${autoGenNumTypeUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, autoGenNumTypeStore, this.form)
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
    getAutoEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
