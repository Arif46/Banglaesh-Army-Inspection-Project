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
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Heading (En)" vid="heading" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.heading') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="heading"
                  v-model="form.heading"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Heading (Bn)" vid="heading_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading_bn">
                <template v-slot:label>
                  {{ $t('bazarMonitoring.heading') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="heading_bn"
                  v-model="form.heading_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Left Logo" vid="left_logo" v-slot="{ errors }" rules="">
                <b-form-group
                  label-for="photo"
                >
                <template v-slot:label>
                  {{ $t('bazarMonitoring.left_logo')}}
                  </template>
                  <b-form-file
                    id="upload_left_logo"
                    v-on:change="handleLeftPhoto"
                    accept="image/*"
                    v-model="form.left_logo"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Right Logo" vid="right_logo" v-slot="{ errors }" rules="">
                <b-form-group
                  label-for="photo"
                >
                <template v-slot:label>
                  {{ $t('bazarMonitoring.right_logo')}}
                  </template>
                  <b-form-file
                    id="upload_right_logo"
                    v-on:change="handleRightPhoto"
                    accept="image/*"
                    v-model="form.right_logo"
                    :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-file>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Address (En)" vid="address" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.address') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="address"
                    rows="2"
                    v-model="form.address"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Address (Bn)" vid="address_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="address_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.address') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="address_bn"
                    rows="3"
                    v-model="form.address_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
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
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'
import { reportHeadStore, reportHeadUpdate } from '../../api/routes'
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
        heading: '',
        heading_bn: '',
        address: '',
        address_bn: '',
        left_logo: [],
        right_logo: []
      },
      upload_left_logo: [],
      upload_right_logo: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getLawEntry()
      this.form = tmp
      this.form.left_logo = []
      this.form.right_logo = []
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
     handleLeftPhoto (e) {
      const selectedPhoto = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.left_logo = event.target.result
      }
      reader.readAsDataURL(selectedPhoto)
    },
     handleRightPhoto (e) {
      const selectedPhoto = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.right_logo = event.target.result
      }
      reader.readAsDataURL(selectedPhoto)
    },
    onFileChange (e) {
      this.left_logo = e.target.files[0]
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bazarMonitoringServiceBaseUrl, `${reportHeadUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bazarMonitoringServiceBaseUrl, reportHeadStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BazarMonitoringService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getLawEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
