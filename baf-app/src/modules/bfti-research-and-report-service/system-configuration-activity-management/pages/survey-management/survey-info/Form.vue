<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:headerTitle>
              <h5 class="card-title"> {{ $t('survey_management.survey_information') }}</h5>
            </template>
            <template v-slot:body>
              <b-row>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Research Topic" vid="research_req_id" rules="required|min_value:1">
                    <b-form-group
                      label-for="research_req_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('survey_management.research_topic')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="form.research_req_id"
                      :options="researchRequestList"
                      id="research_req_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                  <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Title (En)" vid="title" rules="required">
                    <b-form-group
                      class="row"
                      label-for="title"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('survey_management.title_en') }} <span class="text-danger">*</span>
                      </template>
                      <b-form-input
                        id="title"
                        v-model="form.title"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Title (Bn)" vid="title_bn">
                    <b-form-group
                      class="row"
                      label-for="title_bn">
                      <template v-slot:label>
                        {{ $t('survey_management.title_bn') }}
                      </template>
                      <b-form-input
                        id="title_bn"
                        v-model="form.title_bn"
                      ></b-form-input>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="12">
                  <ValidationProvider name="Detail (En)" vid="detail" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="detail">
                      <template v-slot:label>
                        {{ $t('survey_management.detail_en') }}<span class="text-danger">*</span>
                      </template>
                      <b-form-textarea
                        id="detail"
                        v-model="form.detail"
                        :state="errors[0] ? false : (valid ? true : null)"
                      ></b-form-textarea>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>

                <b-col xs="12" sm="12" md="12">
                  <ValidationProvider name="Detail (Bn)" vid="detail_bn">
                    <b-form-group
                      label-for="detail_bn">
                      <template v-slot:label>
                        {{ $t('survey_management.detail_bn') }}
                      </template>
                      <b-form-textarea
                        id="detail_bn"
                        v-model="form.detail_bn"
                      ></b-form-textarea>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="start Date" vid="start_date" rules="required">
                    <b-form-group
                      class="row"
                      label-for="start_date"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('survey_management.start_date') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="start_date"
                         class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        v-model="form.start_date"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :class="errors[0] ? 'is-invalid' : ''"
                      >
                      </date-picker>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="End Date" vid="end_date" rules="required">
                    <b-form-group
                      class="row"
                      label-for="end_date"
                      slot-scope="{ valid, errors }">
                      <template v-slot:label>
                        {{ $t('survey_management.end_date') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                        id="end_date"
                         class="form-control"
                        :placeholder="$t('globalTrans.select_date')"
                        v-model="form.end_date"
                        :state="errors[0] ? false : (valid ? true : null)"
                        :class="errors[0] ? 'is-invalid' : ''"
                      >
                      </date-picker>
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
            </template>
          </body-card>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { surveyInfoStoreApi, surveyInfoUpdateApi } from '../../../api/routes'
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
        research_req_id: '',
        title: '',
        title_bn: '',
        detail: '',
        detail_bn: '',
        start_date: '',
        end_date: ''
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getBudgetInstallmentData()
      this.form = tmp
      this.form.edit_id = this.id
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    researchRequestList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.researchRequestList.filter(item => item.status === 2)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${surveyInfoUpdateApi}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, surveyInfoStoreApi, this.form)
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
