<template>
  <div class="inner-section">
    <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
      <b-overlay :show="loading">
        <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
          <card v-if="condinatorInfo">
            <template v-slot:searchHeaderTitle>
              <h4 class="card-title"> {{ $t('research_plan_management.assign_task_basic_info') }}</h4>
            </template>
            <template v-slot:searchHeaderAction>
              <a href="javascript:void(0)" @click="hasHistory() ? $router.go(-1) : '/bfti-research-and-report-service/task-activity-monitoring/checklist'" aria-current="page" class="btn-add active"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</a>
              <!-- <router-link  class="btn-add" to="/bfti-research-and-report-service/task-activity-monitoring/checklist"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link> -->
            </template>
            <template v-slot:searchBody>
              <b-table-simple bordered>
                <b-tr>
                  <b-th>{{ $t('configuration.document_type') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ getColumnName($store.state.BftiResearchAndReportService.commonObj.documentTypeList,'value', condinatorInfo.document_type_id) }}</b-td>
                  <b-th>{{ $t('globalTrans.title') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>
                      <slot v-if="condinatorInfo.document_type_id === 1">
                      {{ ($i18n.locale === 'bn') ? condinatorInfo.prepare_eoi.title_bn : condinatorInfo.prepare_eoi.title }}
                    </slot>
                    <slot v-else-if="condinatorInfo.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? condinatorInfo.prepare_rfp.rfp_title_bn : condinatorInfo.prepare_rfp.rfp_title_en }}
                    </slot>
                    <slot v-else-if="condinatorInfo.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? condinatorInfo.research.topic_bn : condinatorInfo.research.topic }}
                    </slot>
                    <slot v-else-if="condinatorInfo.document_type_id === 4">
                      {{ ($i18n.locale === 'bn') ? condinatorInfo.policy.policy_title_bn : condinatorInfo.policy.policy_title }}
                    </slot>
                  </b-td>
                </b-tr>
                <b-tr>
                  <b-th>{{ $t('research_plan_management.organization_ministry_division') }}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ ($i18n.locale === 'bn') ? condinatorInfo.organization_ministry_division_bn : condinatorInfo.organization_ministry_division }}</b-td>
                  <b-th>{{$t('research_plan_management.reference_no')}}</b-th>
                  <b-th class="text-center">:</b-th>
                  <b-td>{{ condinatorInfo.reference_no }}</b-td>
                </b-tr>
              </b-table-simple>
            </template>
          </card>
          <body-card>
            <template v-slot:headerTitle>
              <h4 class="card-title"> {{ $t('task_activity_monitoring.assign_task') }}</h4>
            </template>
            <template v-slot:body>
              <b-row>
                <b-col>
                  <b-table-simple bordered style="width: 100%">
                    <b-tr>
                     <b-th style="width:30px !important">{{ $t('globalTrans.sl_no') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('task_activity_monitoring.task_name') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('task_activity_monitoring.sub_task_name') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('task_activity_monitoring.note') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('globalTrans.start_date') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('globalTrans.end_date') }}</b-th>
                    <b-th style="width:80px !important">{{ $t('globalTrans.total_days') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('globalTrans.designation') }}</b-th>
                    <b-th style="width:130px !important">{{ $t('research_plan_management.responsible_person') }}</b-th>
                    </b-tr>
                    <template v-if="taskHeading.length === 0">
                      <tr>
                        <th colspan="8" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                      </tr>
                    </template>
                    <template v-else>
                      <b-tr v-for="(head, index) in taskHeading" :key="index">
                        <b-td>{{ $n(index + 1) }}</b-td>
                        <b-td>{{ ($i18n.locale === 'bn') ? head.task_heading_bn : head.task_heading_en }}</b-td>
                        <b-td>{{ ($i18n.locale === 'bn') ? head.task_sub_heading_bn : head.task_sub_heading_en }}</b-td>
                        <b-td>
                          {{head['task_history'][0].note}}
                        </b-td>
                        <b-td>
                          {{head['task_history'][0].start_date | dateFormat }}
                        </b-td>
                        <b-td>
                          {{head['task_history'][0].end_date | dateFormat }}
                        </b-td>
                        <b-td>{{ $n(head['task_history'][0].days ) }}</b-td>
                        <b-td>
                          {{ getColumnName($store.state.CommonService.commonObj.componentDesignationList,'value', head.designation_id) }}
                        </b-td>
                        <b-td>
                          {{ getColumnName(allUserList,'id', head.employee_user_id, 'other') }}
                        </b-td>
                      </b-tr>
                    </template>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<style>
  .datepicker-form {
    font-size: 8px !important;
  }
</style>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { checkListShow, userListByDesignWise } from '../../api/routes'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      condinatorInfo: [],
      taskHeading: [],
      userList: [],
      allUserList: [],
      districtList: []
    }
  },
  created () {
    if (this.$route.params.id) {
      this.getAllUserList()
    }
  },
  watch: {
    'form.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList(newVal)
      } else {
        this.districtList = []
      }
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
    },
    designationList: function () {
      const listObject = this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
      const tmpList = listObject.map((obj, index) => {
        return { value: obj.value, text: obj.text_en }
      })
      return tmpList
    },
    designationListBn: function () {
      const listObject = this.$store.state.CommonService.commonObj.componentDesignationList.filter(item => item.org_id === 10)
      const tmpList = listObject.map((obj, index) => {
        return { value: obj.value, text: obj.text_bn }
      })
      return tmpList
    }
  },
  methods: {
    hasHistory () { return window.history.length > 2 },
    getColumnName (list, field, groupId, type = null) {
      const obj = list.find(item => item[field] === groupId)
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          if (type) {
            return obj.name_bn
          } else {
            return obj.text_bn
          }
        } else {
          if (type) {
            return obj.name
          } else {
            return obj.text_en
          }
        }
      } else {
        return ''
      }
    },
    getAllUserList () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      this.userLoading = true
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allUserList = response.data
          this.loadData()
        } else {
          this.$store.dispatch('mutateCommonProperties', { loading: false })
        }
      })
    },
    async loadData () {
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, checkListShow + '/' + this.$route.params.id)
      if (result.success) {
        this.condinatorInfo = result.condinatorInfo
        const task = result.task
        this.taskHeading = result.taskHeading.map((item, index) => {
          let isTaskBefore = []
          if (item.sub_task_heading_id) {
            isTaskBefore = task.find(task => task.task_heading_id === item.task_heading_id && task.sub_task_heading_id === parseInt(item.sub_task_heading_id))
          } else {
            isTaskBefore = task.find(task => task.task_heading_id === item.task_heading_id)
          }
          let taskHistory = [
            {
              id: 0,
              note: '',
              start_date: '',
              end_date: ''
            }
          ]
          if (typeof isTaskBefore !== 'undefined') {
            taskHistory = isTaskBefore.task_history
          }
          const itemCheck = {
            task_heading_id: item.id,
            sub_task_heading_id: item.task_heading_id,
            id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.id : 0,
            assign_task_coordinator_id: this.condinatorInfo.id,
            designation_id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.designation_id : 0,
            employee_user_id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.employee_user_id : 0,
            task_history: taskHistory
          }
          return Object.assign({}, item, itemCheck)
        })
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      } else {
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      }
    },
    getDistrictList (id) {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
    },
    onChange (event) {
      const input = event.target
      if (input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = (e) => {
          this.form.attachment = e.target.result
        }
        reader.readAsDataURL(input.files[0])
      } else {
        this.form.attachment = ''
      }
    }
  }
}
</script>
