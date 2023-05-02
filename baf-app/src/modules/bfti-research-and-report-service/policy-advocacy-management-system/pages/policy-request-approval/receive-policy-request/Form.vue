<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
            <b-col md="12 text-center">
                    <span class="badge badge-primary card-title"><h5>{{ $t('globalTrans.remarks') }}</h5></span>
            </b-col>
            <b-col xs="12" sm="12" md="12" lg="12" xl="12">
            <ValidationProvider name="remarks" vid="remarks">
              <b-form-group
              class="row"
              label-for="remarks"
              slot-scope="{ valid, errors }">
              <template v-slot:label>
                {{ $t('globalTrans.remarks') }}
              </template>
              <b-form-textarea
              rows="3"
              id="remarks"
              v-model="form.remarks"
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
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { policyRequestStoreApi, policyRequestUpdateApi } from '../../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        edit_id: '',
        remarks: '',
        user_id: this.$store.state.Auth.authUser.user_id
      }
    }
  },
  // created () {
  //   if (this.id) {
  //     const tmp = this.getBudgetInstallmentData()
  //     this.form = tmp
  //     this.form.edit_id = this.id
  //   }
  // },
  created () {
  if (this.item) {
    this.required = ''
    this.form = this.item
    this.form.contact_no = this.item.contact_no
  } else {
    this.required = 'required'
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
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${policyRequestUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, policyRequestStoreApi, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
         this.$bvModal.hide('modal-form')
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getBudgetInstallmentData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
