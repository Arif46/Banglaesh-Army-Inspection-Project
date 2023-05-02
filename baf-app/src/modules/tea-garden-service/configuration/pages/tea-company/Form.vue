<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Company Name (En)" vid="company_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="company_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_name_en"
                  v-model="teaCompany.company_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Company Name (Bn)" vid="company_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="company_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="company_name_bn"
                  v-model="teaCompany.company_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Company Owner Name (Bn)" vid="owner_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="owner_name_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_owner_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="owner_name_en"
                  v-model="teaCompany.owner_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Company Owner Name (Bn)" vid="owner_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="owner_name_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_owner_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="owner_name_bn"
                  v-model="teaCompany.owner_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Contact No." vid="contact_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="contact_no">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.contact_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_no"
                  v-model="teaCompany.contact_no"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="email" vid="email" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="email">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.email') }}<span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="email"
                  v-model="teaCompany.email"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (En)" vid="address_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_address') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_en"
                  v-model="teaCompany.address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6" lg="6" xl="6">
            <ValidationProvider name="Address (Bn)" vid="address_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="address_bn">
                <template v-slot:label>
                  {{ $t('teaGardenConfig.company_address') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="address_bn"
                  v-model="teaCompany.address_bn"
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
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { teaCompanyStore, teaCompanyUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      teaCompany: {
        company_name_en: '',
        company_name_bn: '',
        owner_name_en: '',
        owner_name_bn: '',
        email: '',
        contact_no: '',
        address_en: '',
        address_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getTeaCompany()
      this.teaCompany = tmp
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
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${teaCompanyUpdate}/${this.id}`, this.teaCompany)
      } else {
        result = await RestApi.postData(teaGardenServiceBaseUrl, teaCompanyStore, this.teaCompany)
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
    getTeaCompany () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
