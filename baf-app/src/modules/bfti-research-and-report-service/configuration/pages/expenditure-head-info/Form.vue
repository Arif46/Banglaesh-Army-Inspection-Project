<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
        <b-row>
          <b-col sm="12">
            <ValidationProvider name="Expenditure Head (En)" vid="expenditure_head_en" rules="required" v-slot="{ errors }">
              <b-form-group
                label-for="expenditure_head_en">
                <template v-slot:label>
                  {{ $t('configuration.expenditure_head_en') }} <span class="text-danger">*</span>
                </template>
                <b-form-input
                  id="expenditure_head_en"
                  v-model="form.expenditure_head_en"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="12">
            <ValidationProvider name="Expenditure Head (Bn)" vid="expenditure_head_bn" v-slot="{ errors }">
              <b-form-group
                label-for="expenditure_head_bn">
                <template v-slot:label>
                  {{ $t('configuration.expenditure_head_bn') }}
                </template>
                <b-form-input
                  id="expenditure_head_bn"
                  v-model="form.expenditure_head_bn"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
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
import { expenditureHeadStoreApi, expenditureHeadUpdateApi } from '../../api/routes'
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
        expenditure_head_en: '',
        expenditure_head_bn: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getExpenditureData()
      this.form = tmp
      this.form.edit_id = this.id
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
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${expenditureHeadUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, expenditureHeadStoreApi, this.form)
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
    getExpenditureData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
