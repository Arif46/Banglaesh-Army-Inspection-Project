<template>
  <div class="section-wrapper">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.assign_task_basic_info') }}</h4>
            </template>
            <template v-slot:body>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('configuration.document_type') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.document_type_bn : form.document_type }}</b-td>
                  <b-th>{{ $t('globalTrans.title') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>
                      <slot v-if="form.document_type_id === 1">
                      {{ ($i18n.locale === 'bn') ? form.prepare_eoi.title_bn : form.prepare_eoi.title }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? form.prepare_rfp.rfp_title_bn : form.prepare_rfp.rfp_title_en }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? form.research.topic_bn : form.research.topic }}
                    </slot>
                    <slot v-else-if="form.document_type_id === 4">
                      {{ ($i18n.locale === 'bn') ? form.policy.policy_title_bn : form.policy.policy_title }}
                    </slot>
                  </b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? form.organization_ministry_division_bn : form.organization_ministry_division }}</b-td>
                  <b-th>{{$t('research_plan_management.eoi_reference_no')}}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ form.reference_no }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('researchRequestManagement.document_information') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Cancel Date" vid="cancel_date" rules="required" v-slot="{ valid, errors }">
                    <b-form-group
                      label-for="cancel_date"
                      label-cols-sm="4"
                    >
                      <template v-slot:label>
                        {{ $t('globalTrans.cancel') +' '+$t('globalTrans.date') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                          class="form-control"
                          :placeholder="$t('globalTrans.select_date')"
                          id="assign_date"
                          v-model="form.cancel_date"
                          :state="errors[0] ? false : (valid ? true : null)"
                          :class="errors[0] ? 'is-invalid' : ''"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                        </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                <ValidationProvider name="Comment" vid="cancel_comment" rules="">
                    <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="cancel_comment"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{ $t('globalTrans.comments')}}
                    </template>
                    <b-form-textarea
                        id="cancel_comment"
                        v-model="form.cancel_comment"
                        :state="errors[0] ? false : (valid ? true : null)"
                    ></b-form-textarea>
                    <div class="invalid-feedback">
                        {{ errors[0] }}
                    </div>
                    </b-form-group>
                </ValidationProvider>
                </b-col>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-cancel')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { researchDocumentCancelDocument } from '../../../api/routes'
export default {
  name: 'Cancel',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      userList: [],
      userLoading: false,
      form: {
       cancel_date: '',
       cancel_comment: ''
      }
    }
  },
  watch: {
  },
  created () {
    if (this.id) {
      const tmp = this.getInfo()
      this.form = tmp
      this.form.assign_task_coordinator_id = this.id
    }
  },
  computed: {
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    designationList () {
      return this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }

      const result = await RestApi.putData(bftiResReportServiceBaseUrl, `${researchDocumentCancelDocument}/${this.id}`, this.form)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('BftiResearchAndReportService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('modal-cancel')
      } else {
        if (result.errors) {
          this.$refs.form.setErrors(result.errors)
        } else {
          this.$toast.error({
            title: 'Error',
            message: result.message,
            color: '#D6E09B'
          })
        }
      }
    },
    getInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
