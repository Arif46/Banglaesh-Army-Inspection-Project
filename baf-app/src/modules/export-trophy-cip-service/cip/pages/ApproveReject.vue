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
                {{ $t('globalTrans.note')}}
              </template>
              <b-form-textarea
                plain
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
          <b-col sm="12" v-if="status === 4">
            <ValidationProvider name="Export Income" vid="export_income" rules="required|min_value:1">
              <b-form-group
                label-for="export_income"
                slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                {{ $t('exportTrophy.export_income')}} ({{ $t('cip.us_million_dollar') }}) <span class="text-danger">*</span>
              </template>
              <b-form-input
                plain
                v-model="form.export_income"
                id="export_income"
                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                :state="errors[0] ? false : (valid ? true : null)"
              >
              </b-form-input>
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
  props: ['id', 'status', 'exportIncome'],
  data () {
    return {
      valid: null,
      errors: [],
      // noteTitle: this.status === 3 ? this.$t('globalTrans.reject') : this.$t('globalTrans.approve'),
      noteTitle: '',
      form: {
        note: '',
        export_income: 0
      }
    }
  },
  created () {
    if (this.status === 3) {
      this.noteTitle = this.$t('globalTrans.reject')
    } else if (this.status === 9) {
      this.noteTitle = this.$t('cip.primary_scrutiny')
    } else if (this.status === 4) {
      this.noteTitle = this.$t('cip.primary_select')
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
      let formData = ''
      const loadingState = { loading: false, listReload: false }
      if (this.exportIncome) {
        formData = Object.assign(this.form, { app_id: this.id, status: this.status, export_income: this.exportIncome ? this.exportIncome : 0 })
      } else {
        formData = Object.assign(this.form, { app_id: this.id, status: this.status })
      }
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
    },
    handleAttachment (e) {
      const selectedFile = e.target.files[0]
      const reader = new FileReader()
      reader.onload = (event) => {
        this.form.attachment = event.target.result
      }
      reader.readAsDataURL(selectedFile)
    }
  }
}
</script>
