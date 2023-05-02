<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Service Name (En)" vid="service_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="service_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.service_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="service_name_en_en"
                  v-model="formData.service_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Service Name (Bn)" vid="service_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="service_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.service_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="service_name_bn"
                  v-model="formData.service_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Service Id" vid="service_id" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="service_id">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.service_id') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="service_name_en_en"
                  v-model="formData.service_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Prefix" vid="prefix" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="prefix">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.prefix') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="prefix"
                  v-model="formData.prefix"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Is Paid" vid="has_payment" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="prefix">
                <b-form-checkbox
                  id="checkbox-1"
                  v-model="formData.has_payment"
                  name="checkbox-1"
                  value="1"
                  unchecked-value="0"
                >
                  {{ $t('teaGardenConfig.is_paid') }}
                </b-form-checkbox>
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { masterServiceStore, masterServiceUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      formData: {
        service_id: '',
        service_name_en: '',
        service_name_bn: '',
        has_payment: 0
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getformData()
      this.formData = tmp
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
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${masterServiceUpdate}/${this.id}`, this.formData)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, masterServiceStore, this.formData)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getformData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
