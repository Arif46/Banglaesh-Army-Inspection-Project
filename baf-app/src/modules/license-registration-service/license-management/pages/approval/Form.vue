<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col lg="12" sm="12">
            <ValidationProvider name="Action Type" vid="action_type" rules="required">
                <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="action_type"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    <div >
                        {{ $t('license_management.action_type') }} <span class="text-danger">*</span>
                    </div>
                </template>
                  <b-form-radio-group
                    id="action_type"
                    v-model="formData.action_type"
                    value="1"
                    :options="options"
                    name="action_type"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-radio-group>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Note (En)" vid="note_en" rules="required">
              <b-form-group
                label-for="note_en"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{ $t('license_management.note_en') }}<span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="note_en"
                  v-model="formData.note_en"
                  rows="5"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Note (Bn)" vid="note_bn" rules="required">
              <b-form-group
                label-for="note_bn"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{ $t('license_management.note_bn') }}<span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="note_bn"
                  v-model="formData.note_bn"
                  rows="5"
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
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { tcbLicenseReject } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      formData: {
        action_type: 3,
        note_en: '',
        note_bn: ''
      }
    }
  },
  created () {
  },
  computed: {
    options () {
      const datas = this.$store.state.LicenseRegistrationService.commonObj.actionTypeList
      return datas.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { text: item.text_bn, value: item.value }
        } else {
          return { text: item.text_en, value: item.value }
        }
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    onChange (e) {
      const selectedFile = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.formData[e.target.name] = event.target.result
      }
      reader.readAsDataURL(selectedFile)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const storeData = Object.assign(this.formData, { tcb_application_id: this.id })
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, tcbLicenseReject, storeData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
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
