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
                <b-table-simple bordered responsive>
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
                    <b-th>{{$t('research_plan_management.reference_no')}}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ form.reference_no }}</b-td>
                  </b-tr>
                </b-table-simple>
            </template>
          </body-card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.assign_task_coordinator') }}</h4>
            </template>
            <template v-slot:body>
                <b-table-simple bordered>
                  <b-tr>
                    <b-th>{{ $t('globalTrans.designation') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.designation_bn : form.designation }}</b-td>
                    <b-th>{{$t('research_plan_management.responsible_person')}}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ ($i18n.locale === 'bn') ? form.responsible_person_bn : form.responsible_person }}</b-td>
                  </b-tr>
                  <b-tr>
                    <b-th>{{ $t('research_plan_management.assign_date') }}</b-th>
                    <b-th class="text-center">:</b-th>
                    <b-td>{{ form.assign_date | dateFormat }}</b-td>
                    <b-th></b-th>
                    <b-th class="text-center"></b-th>
                    <b-td></b-td>
                  </b-tr>
                </b-table-simple>
            </template>
          </body-card>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<script>
import RestApi, { authServiceBaseUrl, bftiResReportServiceBaseUrl } from '@/config/api_config'
import { assignTaskCoordinatorStore, assignTaskCoordinatorUpdate, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['id'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      userList: [],
      userLoading: false,
      form: {
        designation_id: 0
      }
    }
  },
  watch: {
    'form.designation_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.userList = this.getUserList(newVal)
      } else {
        this.userList = []
      }
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getInfo()
      this.form = tmp
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
      return this.$store.state.CommonService.commonObj.designationList.filter(item => item.org_id === 10)
    }
  },
  methods: {
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }

      if (this.id) {
        result = await RestApi.putData(bftiResReportServiceBaseUrl, `${assignTaskCoordinatorUpdate}/${this.id}`, this.form)
      } else {
        result = await RestApi.postData(bftiResReportServiceBaseUrl, assignTaskCoordinatorStore, this.form)
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
    getUserList (designationId) {
      if (designationId) {
        this.userLoading = true
        const params = Object.assign({}, { designation_id: designationId })
        RestApi.getData(authServiceBaseUrl, userListByDesignWise, params).then(response => {
          if (response.success) {
            this.userList = response.data.map((obj, index) => {
              if (this.$i18n.locale === 'bn') {
                return { value: obj.id, text: obj.name_bn }
              } else {
                return { value: obj.id, text: obj.name }
              }
            })
          }
          this.userLoading = false
        })
      }
    },
    getInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
