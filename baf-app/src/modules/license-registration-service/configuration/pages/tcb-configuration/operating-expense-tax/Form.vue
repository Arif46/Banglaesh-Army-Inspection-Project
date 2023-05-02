<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Tax Value" vid="tax_value" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('license_config.tax_value') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="tax_value"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  v-model="form.tax_value"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="4" lg="4" xl="4">
             <ValidationProvider name="Effective date" vid="effective_date" rules="required" v-slot="{ errors }">
               <b-form-group
                 label-for="effective_date">
                 <template v-slot:label>
                   {{ $t('tcbconfiguration.effective_date') }} <span class="text-danger">*</span>
                 </template>
                 <date-picker
                   id="effective_date"
                   v-model="form.effective_date"
                   class="form-control"
                   :placeholder="$t('globalTrans.select_date')"
                   :state="errors[0] ? false : (valid ? true : null)"
                   :class="errors[0] ? 'is-invalid' : ''"
                 >
                 </date-picker>
                 <div class="invalid-feedback">
                   {{ errors[0] }}
                 </div>
               </b-form-group>
             </ValidationProvider>
          <!--  <ValidationProvider name="Effective Date" vid="effective_date" rules="required">
              <b-form-group
                class="row"
                label-for="effective_date"
                slot-scope="{ valid, errors }">
                <template v-slot:label>
                  {{ $t('license_config.effective_date') }}  <span class="text-danger">*</span>
                </template>
                <date-picker
                  :config="{ static: true, minDate: new Date() }"
                  id="effective_date"
                  v-model="form.effective_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                  :state="errors[0] ? false : (valid ? true : null)"
                  :class="errors[0] ? 'is-invalid' : ''"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>-->
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
import { optExpTaxStore, optExpTaxUpdate } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        tax_value: '',
        effective_date: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getItemEntry()
      this.form = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${optExpTaxUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, optExpTaxStore, this.form)
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
