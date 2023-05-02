<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider name="Comments" vid="comments" rules="required|max:255">
            <b-form-group
              label-for="comments"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('tradeFairConfig.cause_of_refund')}} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
                  id="comments"
                  v-model="formData.comments"
                  :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-textarea>
            <div class="invalid-feedback">
              {{ errors[0] }}
            </div>
            </b-form-group>
          </ValidationProvider>
        </b-col>
      </b-row>
      <b-row class="text-right">
        <b-col>
          <b-button type="button" @click="refundSubmit()" variant="success" class="mr-1 btn-sm">{{ $t('globalTrans.refund') }}</b-button>
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-refund')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { visaProcessingRefundApi } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      errors: [],
      formData: {
        comments: ''
      }
    }
  },
  created () {
   if (this.id) {
      this.formData.id = this.id
    }
  },
  watch: {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    }
  },
  methods: {
    refundSubmit () {
      this.$swal({
        title: this.$t('globalTrans.refundMsg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.saveUpdate()
        }
      })
    },
    async saveUpdate () {
      var check = await this.$refs.form.validate()
      if (check) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadingState = { loading: false, listReload: false }

        result = await RestApi.postData(internationalTradeFairServiceBaseUrl, visaProcessingRefundApi, this.formData)
        loadingState.listReload = true
        this.$store.dispatch('mutateCommonProperties', loadingState)

        if (result.success) {
          this.$toast.success({
            title: 'Success',
            message: result.message,
            color: '#D6E09B'
          })

          this.$bvModal.hide('modal-refund')
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      }
    }
  }
}
</script>
