<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <div v-if="old_app_loading">
      <b-card>
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="85%"></b-skeleton>
        <b-skeleton animation="wave" width="70%"></b-skeleton>
      </b-card>
    </div>
    <div v-else>
      <b-overlay>
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
          <b-row>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Application Id" vid="old_application_id" rules="required">
                <b-form-group
                  label-for="old_application_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('license_management.old_application_id') }}<span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    readonly
                    id="old_application_id"
                    v-model="formData.old_application_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Application Id" vid="application_id" rules="required">
                <b-form-group
                  label-for="application_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('globalTrans.renew') + ' ' +$t('globalTrans.application_id') }}<span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    readonly
                    id="application_id"
                    v-model="formData.application_id"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Agreement Date" vid="first_agreement_date" rules="required">
                <b-form-group
                  label-for="first_agreement_date"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('manage_information.first_agreement_no') }}<span class="text-danger">*</span>
                  </template>
                  <date-picker
                    id="old_agreement_date"
                    v-model="formData.old_agreement_date"
                    class="form-control"
                    :placeholder="$t('globalTrans.select_date')"
                    :config="{ static: true }"
                    >
                  </date-picker>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Agreement Date" vid="ageement_expire_date" rules="required">
                <b-form-group
                  label-for="ageement_expire_date"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('manage_information.ageement_expire_date') }}<span class="text-danger">*</span>
                  </template>
                  <b-form-datepicker b-form-datepicker
                    id="ageement_expire_date"
                    v-model="formData.old_expire_date"
                    :state="errors[0] ? false : (valid ? true : null)"
                    disabled
                  ></b-form-datepicker>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Agreement No" vid="agreement_no" rules="required">
                <b-form-group
                  label-for="agreement_no"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('license_management.agreement_no') }}<span class="text-danger">*</span>
                  </template>
                  <b-form-input
                    id="agreement_no"
                    v-model="formData.agreement_no"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Agreement Date" vid="agreement_date" rules="required">
                <b-form-group
                  label-for="agreement_date"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('globalTrans.renew') + ' ' + $t('license_management.agreement_date') }}<span class="text-danger">*</span>
                  </template>
                <date-picker
                  id="agreement_date"
                  v-model="formData.agreement_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                >
                </date-picker>
                  <div class="d-block invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="6" sm="6" md="6">
              <ValidationProvider name="Agreement Expire Date" vid="agreement_expire_date" rules="required">
                <b-form-group
                  label-for="agreement_expire_date"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('globalTrans.renew') + ' ' + $t('license_management.agreement_expire_date') }}<span class="text-danger">*</span>
                  </template>
                  <date-picker
                  id="agreement_expire_date"
                  v-model="formData.agreement_expire_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :config="{ static: true }"
                  disabled
                >
                </date-picker>
                  <div class="d-block invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
              <ValidationProvider name="Attachment" vid="attachment" rules="">
                <b-form-group
                  label-for="attachment"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{ $t('license_management.attachment') }}
                  </template>
                  <b-form-file
                    name="attachment"
                    v-model="formData.attachment"
                    @change="onChange"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-file>
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
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-agreement')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </div>
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { tcbAgreementStore, tcbOldAppData } from '../../api/routes'
export default {
  name: 'Form',
  props: ['application'],
  data () {
    return {
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      formData: {
        tcb_application_id: '',
        old_application_id: '',
        old_agreement_no: '',
        old_expire_date: '',
        old_agreement_date: '',
        agreement_no: '',
        agreement_date: '',
        agreement_expire_date: '',
        attachment: ''
      },
      old_app_loading: false
    }
  },
  created () {
    this.getOldAppData()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  watch: {
    'formData.agreement_date': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.afterTwoYearDateCalculation()
      }
    }
  },
  methods: {
    afterTwoYearDateCalculation () {
      const date = this.formData.agreement_date
      const arr1 = date.split('-')
      const month = parseInt(arr1[1])
      let year = ''
      if (month > 6) {
        year = parseInt(arr1[0]) + 2
      } else {
        year = parseInt(arr1[0]) + 1
      }
      const fullDate = year + '-06-30'
      this.formData.agreement_expire_date = fullDate
    },
    async getOldAppData () {
      this.old_app_loading = true
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `${tcbOldAppData}/${this.application.old_tcb_application_id}`)
      this.old_app_loading = false
      if (result.success) {
        this.formData = Object.assign(this.formData, {
          application_id: this.application.application_id,
          tcb_application_id: this.application.id,
          old_application_id: result.data.application_id,
          old_agreement_no: result.data.agreement_no,
          old_agreement_date: result.data.agreement_date,
          old_expire_date: result.data.expire_date
        })
      }
    },
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
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, tcbAgreementStore, this.formData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-agreement')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
