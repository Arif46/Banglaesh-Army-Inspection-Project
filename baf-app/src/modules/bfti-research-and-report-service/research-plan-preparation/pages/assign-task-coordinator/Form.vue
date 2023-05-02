<template>
  <div class="section-wrapper cord-page">
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
              <b-row>
                <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                  <ValidationProvider name="Designation" vid="designation_id" rules="required|min_value:1">
                      <b-form-group
                        class="row"
                        label-cols-sm="4"
                        label-for="designation_id"
                        slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                        {{$t('globalTrans.designation')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                        plain
                        v-model="form.designation_id"
                        :options="designationList"
                        id="designation_id"
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
                  <ValidationProvider name="Employee User" vid="employee_user_id" rules="required|min_value:1">
                    <b-form-group
                      class="row"
                      label-cols-sm="4"
                      label-for="employee_user_id"
                      slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                      {{$t('research_plan_management.employee_user')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="form.employee_user_id"
                      :options="userList"
                      id="user_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                         <b-form-select-option :value="0">{{ userLoading ? 'Loading....' : $t('globalTrans.select') }}</b-form-select-option>
                      </template>
                    </b-form-select>
                    <div class="invalid-feedback">
                      {{ errors[0] }}
                    </div>
                    </b-form-group>
                  </ValidationProvider>
                </b-col>
                <b-col xs="12" sm="12" md="6">
                  <ValidationProvider name="Assign Date" vid="assign_date" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="assign_date"
                      label-cols-sm="4"
                    >
                      <template v-slot:label>
                        {{ $t('research_plan_management.assign_date') }}  <span class="text-danger">*</span>
                      </template>
                      <date-picker
                          id="assign_date"
                          class="form-control"
                          v-model="form.assign_date"
                          :class="errors[0] ? 'is-invalid' : ''"
                          :placeholder="$t('globalTrans.select_date')"
                          :state="errors[0] ? false : (valid ? true : null)"
                        >
                        </date-picker>
                        <div class="invalid-feedback d-block">
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
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-form')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<style>
.cord-page .card .card-body {
  padding: 0px !important;
}
.cord-page .card .col-form-label {
  font-size: 13px !important;
}
</style>
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
        designation_id: 0,
        employee_user_id: 0,
        responsible_person: '',
        responsible_person_bn: ''
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
    },
    'form.employee_user_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal > 0) {
          const userList = this.userList.find(item => item.value === newVal)
          this.form.responsible_person = userList.text_en
          this.form.responsible_person_bn = userList.text_bn
        }
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
      return this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
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
                return { value: obj.id, text: obj.name_bn, text_en: obj.name, text_bn: obj.name_bn }
              } else {
                return { value: obj.id, text: obj.name, text_en: obj.name, text_bn: obj.name_bn }
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
