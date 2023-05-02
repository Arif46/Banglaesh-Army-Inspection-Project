<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-card class="mt-2">
        <p style="font-weight:bold">{{ $t('license_management.review') }} :</p>
        <b-card-text class="mt-3">
          <b-form-rating v-model="form.rating" readonly variant="warning" class="mb-2"></b-form-rating>
          <div class="mt-2">
            {{ $t('globalTrans.note') }} : <span>{{ form.comment }}</span>
          </div>
        </b-card-text>
      </b-card>
      <p class="mt-2" style="font-weight:bold">{{ $t('dealer.feedback') }} : </p>
      <b-form class="mt-2" @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Feedback (En)" vid="feedback_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('license_config.feedback_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="feedback_en"
                  v-model="form.feedback"
                  :readonly="check_feedback"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="6"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Feedback (Bn)" vid="feedback_bn" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="heading">
                <template v-slot:label>
                  {{ $t('license_config.feedback_bn') }} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                  id="feedback_bn"
                  :readonly="check_feedback"
                  v-model="form.feedback_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                  rows="6"
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
              <b-button v-if="!form.feedback" type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
              <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { fdReviewStore, fdReviewUpdate } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      form: {
        org_id: 0,
        feedback_en: '',
        answer: ''
      },
      check_feedback: false
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getItemEntry()
      this.form = tmp
      if (this.form.feedback) {
        this.check_feedback = true
      } else {
        this.check_feedback = false
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    orgProfileList () {
        return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(licenseRegistrationServiceBaseUrl, `${fdReviewUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(licenseRegistrationServiceBaseUrl, fdReviewStore, this.form)
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
