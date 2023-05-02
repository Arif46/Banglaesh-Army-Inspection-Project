<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(submit)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="12">
            <ValidationProvider name="Remark" vid="remark" rules="required">
              <b-form-group
                label-for="remark"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{$t('globalTrans.remark')}} <span class="text-danger">*</span>
              </template>
              <b-form-textarea
                plain
                v-model="form.remark"
                id="remark"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-textarea>
              <div class="invalid-feedback">
                {{ errors[0] }}
              </div>
              </b-form-group>
          </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Attachment" vid="attachment" v-slot="{ errors }">
              <b-form-group
                label-for="attachment">
                <template v-slot:label>
                  {{ $t('globalTrans.attachment') }} {{ $t('externalUser.attachment_type')}}
                </template>
                <b-form-file
                  id="attachment"
                  @change="handleAttachment"
                  accept="application/pdf,application/doc,application/docx,application/csv"
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
            <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.submit') }}</b-button>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-remark')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
        </b-row>
      </b-form>
    </b-overlay>
  </ValidationObserver>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { circularRemarkApi } from '../api/routes'
export default {
  name: 'Remark',
  props: ['circular_id', 'current_status', 'status', 'menu_name_id'],
  data () {
    return {
      valid: null,
      errors: [],
      form: {
        remark: '',
        attachment: null
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
      const formData = Object.assign(this.form, { circular_id: this.circular_id, menu_name_id: this.menu_name_id, status: this.status, current_status: this.current_status })
      result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, circularRemarkApi, formData)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-remark')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    },
    handleAttachment (e) {
      const bytesize = e.target.files[0].size
      const kbsize = bytesize / 1024
      if (kbsize > 2048) {
        this.form.attachment = null
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('exportTrophyCircular.fileType'),
          color: '#ee5253'
        })
        return
      }

      const input = e.target
      if (input.files && input.files[0]) {
        const selectedFile = input.files[0]
        const reader = new FileReader()
        reader.onload = (event) => {
          this.form.attachment = event.target.result
        }
        reader.readAsDataURL(selectedFile)
      } else {
        this.form.attachment = null
      }
    }
  }
}
</script>
