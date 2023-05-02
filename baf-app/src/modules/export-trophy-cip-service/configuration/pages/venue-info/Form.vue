<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="6">
            <ValidationProvider name="Venue Name (En)" vid="venue_name" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="venue_name">
                <template v-slot:label>
                  {{ $t('exportTrophyConfig.venue_name_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="venue_name"
                  v-model="form.venue_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="6">
            <ValidationProvider name="Venue Name (Bn)" vid="venue_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="venue_name_bn">
                <template v-slot:label>
                  {{ $t('exportTrophyConfig.venue_name_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="venue_name_bn"
                  v-model="form.venue_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Mobile" vid="contact_person_mobile" rules="required|max:11|min:11" v-slot="{ errors }">
              <b-form-group
                label-for="contact_person_mobile">
                <template v-slot:label>
                  {{ $t('globalTrans.mobile') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_person_mobile"
                  v-model="form.contact_person_mobile"
                  :state="errors[0] ? false : (valid ? true : null)"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Email" vid="email" rules="email" v-slot="{ errors }">
              <b-form-group
                label-for="email">
                <template v-slot:label>
                  {{ $t('globalTrans.email') }}
                </template>
                <b-form-input
                  id="email"
                  v-model="form.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Total Capacity" vid="total_capacity" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="total_capacity">
                <template v-slot:label>
                  {{ $t('exportTrophyConfig.total_capacity') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="total_capacity"
                  v-model="form.total_capacity"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Address (En)" vid="address_en" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('globalTrans.address_en') }}
                </template>
                <b-form-textarea
                    id="address_en"
                    rows="3"
                    v-model="form.address_en"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Address (Bn)" vid="address_bn" rules="" v-slot="{ errors }">
              <b-form-group
                label-for="address_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.address_bn') }}
                </template>
                <b-form-textarea
                    id="address_bn"
                    v-model="form.address_bn"
                    rows="3"
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
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { venueStoreApi, venueUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        venue_name_en: '',
        venue_name_bn: '',
        contact_person_mobile: '',
        email: '',
        total_capacity: '',
        address_en: '',
        address_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getVenueInfo()
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
        result = await RestApi.putData(exportTrophyCIPServiceBaseUrl, `${venueUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, venueStoreApi, this.form)
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
    getVenueInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
