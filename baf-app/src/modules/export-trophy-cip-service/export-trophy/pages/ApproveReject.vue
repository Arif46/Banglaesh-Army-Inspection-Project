<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="12">
            <ValidationProvider name="Note" vid="note">
              <b-form-group
                label-for="note"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('globalTrans.note') }}
              </template>
              <b-form-textarea
                v-model="form.note"
                id="note"
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
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ noteTitle }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-approve-reject')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { approveRejectApi } from '../api/routes'
export default {
  name: 'Remark',
  props: ['id', 'item'],
  data () {
    return {
      valid: null,
      errors: [],
      noteTitle: this.item.note_title,
      form: {
        note: ''
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    ...mapGetters({
      authUser: 'Auth/authUser'
    })
  },
  methods: {
    async submit () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      const formData = Object.assign(this.form, { app_id: this.id, status: this.item.status })
      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, approveRejectApi, formData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-approve-reject')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
