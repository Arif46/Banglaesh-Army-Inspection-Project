<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
  <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col xl="12" lg="12" md="12" sm="12">
            <ValidationProvider name="About Service Portal (En)" vid="about_service_portal_en" rules="required">
                <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="about_service_portal_en"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('moc_portal.about_service_portal_en')}} <span class="text-danger">*</span>
                </template>
                    <vue-editor
                      id="about_service_portal_en"
                      v-model="service.description"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </vue-editor>
                    <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                    </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xl="12" lg="12" md="12" sm="12">
            <ValidationProvider name="About Service Portal (Bn)" vid="about_service_portal_bn" rules="required">
                <b-form-group
                    class="row"
                    label-cols-sm="12"
                    label-for="about_service_portal_bn"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('moc_portal.about_service_portal_bn')}} <span class="text-danger">*</span>
                </template>
                    <vue-editor
                      id="about_service_portal_bn"
                      v-model="service.description_bn"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                    </vue-editor>
                    <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                    </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-4')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
  </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { aboutPortalStoreApi, aboutPortalUpdateApi } from '../../api/routes'
import { VueEditor } from 'vue2-editor'

export default {
  name: 'Form',
  props: ['id'],
  components: {
    VueEditor
  },
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      service: {
        description: '',
        description_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getServiceServiceData()
      this.service = tmp
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    getServiceServiceData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(commonServiceBaseUrl, `${aboutPortalUpdateApi}/${this.id}`, this.service)
      } else {
        result = await RestApi.postData(commonServiceBaseUrl, aboutPortalStoreApi, this.service)
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

        this.$bvModal.hide('modal-4')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
