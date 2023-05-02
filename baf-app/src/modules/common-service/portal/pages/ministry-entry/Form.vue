<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.ministry_name_en')" vid="ministry_name" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="ministry_name">
              <template v-slot:label>
                {{ $t('moc_portal.ministry_name_en') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="ministry_name"
                v-model="ministry.ministry_name"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col sm="12">
          <ValidationProvider :name="$t('moc_portal.ministry_name_bn')" vid="ministry_name_bn" rules="required" v-slot="{ errors }">
            <b-form-group
              label-for="ministry_name_bn">
              <template v-slot:label>
                {{ $t('moc_portal.ministry_name_bn') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                id="ministry_name_bn"
                v-model="ministry.ministry_name_bn"
                :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
        <b-col lg="12" sm="12">
            <ValidationProvider name="Logo" vid="logo" :rules="id ? '' : 'required'">
              <b-form-group
                class="row"
                label-cols-sm="12"
                label-for="logo"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('moc_portal.logo')}} <span v-if="!id" class="text-danger">*</span>
                </template>
                <b-form-file
                  id="logo"
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
import { ministryEntryStoreApi, ministryEntryUpdateApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      ministry: {
        ministry_name: '',
        ministry_name_bn: '',
        logo: null
      },
      photo: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCategory()
      this.ministry = tmp
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
        this.ministry.logo = event.target.result
        this.ministry.update_logo = 1
      }
      reader.readAsDataURL(selectedPhoto)
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${ministryEntryUpdateApi}/${this.id}`, this.ministry)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, ministryEntryStoreApi, this.ministry)
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
