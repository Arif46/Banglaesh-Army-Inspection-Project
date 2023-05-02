<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Task Alert" vid="task_alert" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="task_alert">
                <template v-slot:label>
                  {{ $t('configuration.alert_percentage_f') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="task_alert"
                  type="number"
                  v-model="form.task_alert"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
        </b-row>
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remark En" vid="remark_en" v-slot="{ errors }">
              <b-form-group
                label-for="remark_en">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }} {{ $t('globalTrans.en') }}
                </template>
                <b-form-textarea
                  id="remark_en"
                  v-model="form.remark_en"
                  rows="3"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remark Bn" vid="remark_bn" v-slot="{ errors }">
              <b-form-group
                label-for="remark_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.remarks') }} {{ $t('globalTrans.bn') }}
                </template>
                <b-form-textarea
                  id="remark_bn"
                  v-model="form.remark_bn"
                  rows="3"
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
import { alertPercentageStore, alertPercentageUpdate } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      form: {
        task_alert: '',
        remark_en: '',
        remark_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getAlertPercentage()
      this.form = tmp
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
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${alertPercentageUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, alertPercentageStore, this.form)
      }

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
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
    getAlertPercentage () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
