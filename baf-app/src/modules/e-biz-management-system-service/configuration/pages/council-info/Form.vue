<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Council Name (En)" vid="council_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="council_name_en">
                <template v-slot:label>
                  {{ $t('eBizConfig.council_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="council_name_en"
                  v-model="form.council_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Council Name (Bn)" vid="council_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="council_name_bn">
                <template v-slot:label>
                  {{ $t('eBizConfig.council_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="council_name_bn"
                  v-model="form.council_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Address (En)" vid="address_en" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="address_en">
                <template v-slot:label>
                  {{ $t('eBizConfig.address') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-input
                  id="address_en"
                  v-model="form.address_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
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
                  {{ $t('eBizConfig.address') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-input
                  id="address_bn"
                  v-model="form.address_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>

          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Contact Person Name (En)" vid="contact_person_name_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="contact_person_name_en">
                <template v-slot:label>
                  {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_person_name_en"
                  v-model="form.contact_person_name_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Contact Person Name (Bn)" vid="contact_person_name_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="contact_person_name_bn">
                <template v-slot:label>
                  {{ $t('eBizConfig.contact_person_name') }} {{ $t('globalTrans.bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="contact_person_name_bn"
                  v-model="form.contact_person_name_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Mobile No" vid="mobile_no" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="mobile_no">
                <template v-slot:label>
                  {{ $t('eBizConfig.mobile_no') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="mobile_no"
                  v-model="form.mobile_no"
                  oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Email Address" vid="email_address" v-slot="{ errors }" rules="email">
              <b-form-group
                label-for="email_address">
                <template v-slot:label>
                  {{ $t('eBizConfig.email_address') }}
                </template>
                <b-form-input
                  id="email_address"
                  type="email"
                  v-model="form.email_address"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (En)" vid="description_en" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_en">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                    id="description_en"
                    rows="3"
                    v-model="form.description_en"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Description (Bn)" vid="description_bn" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.description') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                    id="description_bn"
                    rows="3"
                    v-model="form.description_bn"
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
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { councilInfoStore, councilInfoUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        council_name_en: '',
        council_name_bn: '',
        address_en: '',
        address_bn: '',
        contact_person_name_en: '',
        contact_person_name_bn: '',
        mobile_no: '',
        email_address: '',
        description_en: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getData()
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
        result = await RestApi.putData(eBizServiceBaseUrl, `${councilInfoUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(eBizServiceBaseUrl, councilInfoStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
