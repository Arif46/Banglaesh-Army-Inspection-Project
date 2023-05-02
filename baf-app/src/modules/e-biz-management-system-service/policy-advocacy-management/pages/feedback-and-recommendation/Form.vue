<template>
  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
    <b-overlay :show="loading">
      <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Feedback Description (En)" vid="feedback_description" v-slot="{ errors }" rules="required|min:10">
              <b-form-group
                label-for="feedback_description">
                <template v-slot:label>
                  {{ $t('globalTrans.feedback') }} {{ $t('globalTrans.description') }} {{$t('globalTrans.en')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="feedback_description"
                    rows="3"
                    v-model="form.feedback_description"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Feedback Description (Bn)" vid="feedback_description_bn" v-slot="{ errors }" rules="required|min:10">
              <b-form-group
                label-for="feedback_description_bn">
                <template v-slot:label>
                  {{ $t('globalTrans.feedback') }} {{ $t('globalTrans.description') }} {{$t('globalTrans.bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="feedback_description_bn"
                    rows="3"
                    v-model="form.feedback_description_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Feedback Attachment" vid="feedback_attachment" rules="required">
                  <b-form-group
                    label-for="feedback_attachment"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('globalTrans.feedback')}} <span class="text-danger">{{ $t('Advocacy.attachment_type') }} *</span>
                    </template>
                    <b-form-file id="feedback_attachment"
                      v-model="form.file"
                      v-on:change="onFileChangeFeedback"
                      accept=".doc,.docx,.pdf"
                      class="mt-2" plain
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-file>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                  </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Policy Recommendation (En)" vid="policy_recommendation" v-slot="{ errors }" rules="required|min:10">
              <b-form-group
                label-for="policy_recommendation">
                <template v-slot:label>
                 {{ $t('policyAdvocacy.policy') }} {{ $t('policyAdvocacy.recommendation') }} {{$t('globalTrans.en')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="policy_recommendation"
                    rows="3"
                    v-model="form.policy_recommendation"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Policy Recommendation (Bn)" vid="policy_recommendation_bn" v-slot="{ errors }" rules="required|min:10">
              <b-form-group
                label-for="policy_recommendation_bn">
                <template v-slot:label>
                 {{ $t('policyAdvocacy.policy') }} {{ $t('policyAdvocacy.recommendation') }} {{$t('globalTrans.bn')}} <span class="text-danger">*</span>
                </template>
                <b-form-textarea
                    id="policy_recommendation_bn"
                    rows="3"
                    v-model="form.policy_recommendation_bn"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12">
              <ValidationProvider name="Recommendation Attachment" vid="recommendation_attachment" rules="required">
                  <b-form-group
                    label-for="recommendation_attachment"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('policyAdvocacy.recommendation')}} <span class="text-danger">{{ $t('Advocacy.attachment_type') }} *</span>
                    </template>
                    <b-form-file id="recommendation_attachment"
                      v-model="form.recommendation_file"
                      v-on:change="onFileChangeRecommendation"
                      accept=".doc,.docx,.pdf"
                      class="mt-2" plain
                      :state="errors[0] ? false : (valid ? true : null)"
                      >
                    </b-form-file>
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
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { feedbackRecommendationStore } from '../../api/routes'
export default {
  name: 'Form',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      isDisable: false,
      ItemShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      UnionItemShow: false,
      form: {
        council_info_id: 0,
        association_info_id: 0,
        application_id: 0,
        workshop_id: 0,
        feedback_description: '',
        feedback_description_bn: '',
        policy_recommendation: '',
        policy_recommendation_bn: '',
        feedback_attachment: '',
        recommendation_attachment: ''
      }
    }
  },
  created () {
      if (this.items !== undefined) {
        this.form.council_info_id = this.items.council_info_id
        this.form.association_info_id = this.items.association_info_id
        this.form.application_id = this.items.application.id
        this.form.workshop_id = this.items.id
      }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
       return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  watch: {
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.changeEnBn()
        }
    }
  },
  methods: {
      onFileChangeFeedback (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.feedback_attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.feedback_attachment = ''
          }
      },
      onFileChangeRecommendation (event) {
          const input = event.target
          if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
              this.form.recommendation_attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
          } else {
            this.form.recommendation_attachment = ''
          }
      },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(eBizServiceBaseUrl, feedbackRecommendationStore, this.form)
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
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
    getData () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
