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
              <router-link class="btn-add" to="/bfti-research-and-report-service/task-activity-monitoring/checklist"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
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
                <b-table-simple responsive bordered table-class="tc-table" style="width: 100% !important;">
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
                      <th colspan="10" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                    </tr>
                  </template>
                  <template v-else>
                    <b-tr v-for="(head, index) in taskHeading" :key="index">
                      <b-td>{{ $n(index + 1) }}</b-td>
                      <b-td>{{ ($i18n.locale === 'bn') ? head.task_heading_bn : head.task_heading_en }}</b-td>
                      <b-td>{{ ($i18n.locale === 'bn') ? head.task_sub_heading_bn : head.task_sub_heading_en }}</b-td>
                      <b-td>
                        <ValidationProvider :vid="'note' + index" name="Note">
                          <div slot-scope="{ valid, errors }">
                            <b-form-textarea
                              :id="'head[task_history]['+ index +'].note'"
                              v-model="head.task_history[0].note"
                              :state="errors[0] ? false : (valid ? true : null)"
                            ></b-form-textarea>
                            <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider :vid="'start_date' + index" rules="required" name="Start Date">
                          <div slot-scope="{ valid, errors }">
                            <date-picker
                              :id="'head[task_history]['+index+'].start_date'"
                              class="form-control"
                              v-model="head['task_history'][0].start_date"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :class="errors[0] ? 'is-invalid' : ''"
                              @input="dateDiff(head['task_history'][0])"
                              :config="head['task_history'][0].config1"
                            >
                            </date-picker>
                            <div class="invalid-feedback d-block" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider :vid="'end_date' + index" rules="required" name="End Date">
                          <div slot-scope="{ valid, errors }">
                            <date-picker
                              :id="'head[task_history]['+index+'].end_date'"
                              v-model="head['task_history'][0].end_date"
                              class="form-control"
                              :state="errors[0] ? false : (valid ? true : null)"
                              :class="errors[0] ? 'is-invalid' : ''"
                              @input="dateDiff(head['task_history'][0])"
                              :config="head['task_history'][0].config"
                            >
                            </date-picker>
                            <div class="invalid-feedback d-block" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider :vid="'days' + index" rules="required" name="Days">
                          <div slot-scope="{ valid, errors }">
                            <b-form-input
                              :id="'head[task_history]['+ index +'].days'"
                              v-model="head.task_history[0].days"
                              :state="errors[0] ? false : (valid ? true : null)"
                              disabled
                            ></b-form-input>
                            <div class="invalid-feedback d-block" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider :vid="'designation_id' + index" rules="required|min_value:1" name="Designation">
                          <div slot-scope="{ valid, errors }">
                            <b-form-select
                              plain
                              v-model="head.designation_id"
                              :options="$i18n.locale === 'en' ? head.designationList : head.designationListBn"
                              :id="'designation_id['+index+']'"
                              :state="errors[0] ? false : (valid ? true : null)"
                              @change="getUserList(head.designation_id, head)"
                            >
                              <template v-slot:first>
                                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                            </b-form-select>
                            <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                      <b-td>
                        <ValidationProvider :vid="'employee_user_id' + index" rules="required|min_value:1" name="Employee User">
                          <div slot-scope="{ valid, errors }">
                            <b-form-select
                              plain
                              v-model="head.employee_user_id"
                              :options="$i18n.locale === 'en' ? head.employeeList : head.employeeListBn"
                              :id="'employee_user_id['+index+']'"
                              :state="errors[0] ? false : (valid ? true : null)"
                            >
                              <template v-slot:first>
                                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                              </template>
                            </b-form-select>
                            <div class="error invalid-feedback" role="alert">
                                {{ errors[0] }}
                            </div>
                          </div>
                        </ValidationProvider>
                      </b-td>
                    </b-tr>
                  </template>
                </b-table-simple>
              </b-row>
            </template>
          </body-card>
          <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <router-link class="btn-sm btn btn-danger" to="/bfti-research-and-report-service/task-activity-monitoring/checklist">{{ $t('globalTrans.cancel') }}</router-link>
            </b-col>
          </b-row>
        </b-form>
      </b-overlay>
    </ValidationObserver>
  </div>
</template>
<style>
  .datepicker-form {
    font-size: 8px !important;
  }
  .tc-table th, td{
    font-size: 12px !important;
  }
  .tc-table td{
    padding-left: 3px !important;
    padding-right: 3px !important;
  }
</style>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { checkListStore, checkListShow, userListByDesignWise } from '../../api/routes'
import moment from 'moment'
export default {
  name: 'Form',
  props: ['item'],
  data () {
    return {
      valid: null,
      errors: [],
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      condinatorInfo: [],
      taskHeading: [],
      userList: [],
      allUserList: [],
      districtList: [],
      config: { minDate: '' },
      exclusions: this.$store.state.BftiResearchAndReportService.commonObj.holidayList,
      weekday: [1, 2, 3, 4, 5]
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
    saveBtnName: function () {
      return this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save')
    },
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
    dateDiff (item) {
      item.config.minDate = item.start_date
      item.config1.maxDate = item.end_date
      if (item.start_date && item.end_date) {
        require('moment-weekday-calc')
        const todayDiff = moment().weekdayCalc({
          rangeStart: item.start_date,
          rangeEnd: item.end_date,
          weekdays: this.weekday,
          exclusions: this.exclusions
        })
        item.days = todayDiff
      }
      return item
    },
    getColumnName (list, field, groupId) {
      const obj = list.find(item => item[field] === groupId)
      if (typeof obj !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return obj.text_bn
        } else {
          return obj.text_en
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
          let userList = []
          let userListBn = []
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
              days: 0,
              start_date: '',
              end_date: '',
              config: { minDate: '' },
              config1: { maxDate: '' }
            }
          ]
          if (typeof isTaskBefore !== 'undefined') {
            taskHistory = isTaskBefore.task_history
            // taskHistory[0].config.minDate = taskHistory[0].start_date
            taskHistory[0].config = {
              minDate: taskHistory[0].start_date
            }
            taskHistory[0].config1 = {
              maxDate: taskHistory[0].end_date
            }
            userList = this.getUserListLoop(isTaskBefore.designation_id, 'en')
            userListBn = this.getUserListLoop(isTaskBefore.designation_id, 'bn')
          }
          const itemCheck = {
            id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.id : 0,
            assign_task_coordinator_id: this.condinatorInfo.id,
            designation_id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.designation_id : 0,
            employee_user_id: typeof isTaskBefore !== 'undefined' ? isTaskBefore.employee_user_id : 0,
            designationList: this.designationList,
            designationListBn: this.designationListBn,
            employeeList: userList,
            employeeListBn: userListBn,
            task_history: taskHistory
          }
          return Object.assign({}, item, itemCheck)
        })
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      } else {
        this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      }
    },
    getUserListLoop (designationId, lng) {
      const userList = this.allUserList.filter(item => item.designation_id === designationId)
      if (userList.length > 0) {
         const tmpList = userList.map((obj, index) => {
          return { value: obj.id, text: lng === 'en' ? obj.name : obj.name_bn }
        })
        return tmpList
      } else {
        return []
      }
    },
    getUserList (designationId, item) {
      const userList = this.allUserList.filter(item => item.designation_id === designationId)
      if (userList.length > 0) {
        const tmpList = userList.map((obj, index) => {
          return { value: obj.id, text: obj.name }
        })
        item.employeeList = tmpList
        const tmpListBn = userList.map((obj, index) => {
          return { value: obj.id, text: obj.name_bn }
        })
        item.employeeListBn = tmpListBn
      } else {
        item.employeeList = []
        item.employeeListBn = []
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
    },
    async saveUpdate () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(bftiResReportServiceBaseUrl, checkListStore, this.taskHeading)

      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$router.push('/bfti-research-and-report-service/task-activity-monitoring/checklist')
      } else {
        this.$refs.form.setErrors(result.errors)
      }
    }
  }
}
</script>
