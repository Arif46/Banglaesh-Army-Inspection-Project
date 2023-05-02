<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.service_customer_type')" vid="name" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="name">
              <template v-slot:label>
                {{ $t('moc_portal.service_customer_type') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="name"
                v-model="customer.name"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.service_customer_type_bn')" vid="name_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="name_bn">
              <template v-slot:label>
                {{ $t('moc_portal.service_customer_type_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
              id="name_bn"
              v-model="customer.name_bn"
              :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col lg="12" sm="12">
            <ValidationProvider name="Logo" vid="image" :rules="id ? '' : 'required'">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="image"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('moc_portal.icon')}} <span v-if="!id" class="text-danger">*</span>
                </template>
                <b-form-file
                id="image"
                v-model="photo"
                v-on:change="handlePhoto"
                accept="image/*"
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
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { serviceCustomerTypeStore, serviceCustomerTypeUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      customer: {
        name: '',
        name_bn: '',
        image: null
      },
      photo: [],
      upload_logo: '',
      load: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCategory()
      this.customer = tmp
    }
  },
   computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    handlePhoto (e) {
      const selectedPhoto = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.customer.image = event.target.result
        this.customer.update_logo = 1
      }
      reader.readAsDataURL(selectedPhoto)
    },
    onFileChange (e) {
      this.upload_logo = e.target.files[0]
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${serviceCustomerTypeUpdate}/${this.id}`, this.customer)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, serviceCustomerTypeStore, this.customer)
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
    getCategory () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
