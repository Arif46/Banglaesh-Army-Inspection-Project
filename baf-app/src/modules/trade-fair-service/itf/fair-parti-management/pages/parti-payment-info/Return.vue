<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
      <b-row>
        <b-col sm="12">
          <ValidationProvider name="Return note" vid="comments" rules="required|max:255">
            <b-form-group
              label-for="comments"
              slot-scope="{ errors }"
            >
              <template v-slot:label>
                {{$t('globalTrans.comments')}} <span class="text-danger">*</span>
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
          <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
          <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-return')">{{ $t('globalTrans.cancel') }}</b-button>
        </b-col>
      </b-row>
    </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { itfFairPariPaymentInfoReturn } from '../../api/routes'
export default {
  name: 'Form',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('globalTrans.save'),
      errors: [],
      formData: {
        comments: '',
        id: this.items.id
      }
    }
  },
  created () {
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
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      result = await RestApi.postData(internationalTradeFairServiceBaseUrl, itfFairPariPaymentInfoReturn, this.formData)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('CommonService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: result.message,
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-return')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
