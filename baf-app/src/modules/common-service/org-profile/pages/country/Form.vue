<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="6">
            <ValidationProvider name="Country Name (En)" vid="country_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="country_name">
                <template v-slot:label>
                  {{ $t('orgProfile.country_name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="country_name"
                  v-model="country.country_name"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Country Name (Bn)" vid="country_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="country_name_bn">
                <template v-slot:label>
                  {{ $t('orgProfile.country_name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="country_name_bn"
                  v-model="country.country_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col sm="6">
            <ValidationProvider name="Nationality (En)" vid="nationality" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="nationality">
                <template v-slot:label>
                  {{ $t('globalTrans.nationality') + ' ' + $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="nationality"
                  v-model="country.nationality"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Nationality (Bn)" vid="nationality_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="nationality_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.nationality') + ' ' + $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="nationality_bn"
                  v-model="country.nationality_bn"
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
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { countryStore, countryUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      country: {
        country_name: '',
        country_name_bn: '',
        nationality: '',
        nationality_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCountry()
      this.country = tmp
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
        result = await RestApi.putData(commonServiceBaseUrl, `${countryUpdate}/${this.id}`, this.country)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, countryStore, this.country)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-form')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    getCountry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
