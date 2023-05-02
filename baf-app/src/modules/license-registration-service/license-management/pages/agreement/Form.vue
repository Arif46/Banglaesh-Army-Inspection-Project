<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="6" sm="6" md="6">
            <ValidationProvider name="Application Id" vid="application_id" rules="required">
              <b-form-group
                label-for="application_id"
                slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{ $t('globalTrans.application_id') }}<span class="text-danger">*</span>
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
                  {{ $t('license_management.agreement_date') }}<span class="text-danger">*</span>
                </template>
                <date-picker
                  :config="config"
                  id="agreement_date"
                  v-model="formData.agreement_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
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
                  {{ $t('license_management.agreement_expire_date') }}<span class="text-danger">*</span>
                </template>
                <date-picker
                  :config="{ static: true, minDate: new Date(approval_date) }"
                  id="agreement_expire_date"
                  v-model="formData.agreement_expire_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                  disabled
                >
                </date-picker>
                <div class="d-block invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Distance" vid="distance_id" rules="required|min_value:1">
              <b-form-group
                label-for="distance_id"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('license_config.distance')}} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                v-model="formData.distance_id"
                :options="distanceList"
                id="distance_id"
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
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Attachment" vid="attachment" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('license_management.agreement_attachment') }}
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
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { tcbAgreementStore } from '../../api/routes'
// import moment from 'moment'
export default {
  name: 'Form',
  props: ['id', 'application_id', 'approval_date'],
  data () {
    return {
      value: {},
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        tcb_application_id: '',
        application_id: this.application_id,
        agreement_no: '',
        agreement_date: '',
        agreement_expire_date: '',
        distance_id: 0,
        attachment: ''
      },
      config: { static: true, minDate: new Date(this.approval_date) }
    }
  },
  created () {
    this.getCurrentFiscalYear()
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    distanceList () {
      const distanceList = this.$store.state.LicenseRegistrationService.commonObj.distanceList
        return distanceList.map(item => {
          return { value: item.value, text: this.$i18n.locale === 'bn' ? item.text_bn : item.text_en }
        })
    }
  },
  watch: {
    'formData.agreement_date': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.afterTwoYearDate()
      }
    }
  },
  methods: {
    // afterTwoYearDate () {
    //   const result = new Date(this.formData.agreement_date)
    //   result.setMonth(result.getMonth() + 24)
    //   this.formData.agreement_expire_date = result.toISOString().slice(0, 10)
    // },
    afterTwoYearDate () {
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
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, tcbAgreementStore, storeData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-agreement')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getCurrentFiscalYear () {
      const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList
      const currentDate = new Date()
      const [month, year] = [currentDate.getMonth() + 1, currentDate.getFullYear()]
      const yearPosition = month < 7 ? 5 : 0
      const yearStr = `${year}`
      fiscalYearList.forEach(element => {
        if (element.text_en.indexOf(yearStr) === yearPosition) {
          this.currentFiscalYearId = element.value
        }
      })
    }
  }
}
</script>
