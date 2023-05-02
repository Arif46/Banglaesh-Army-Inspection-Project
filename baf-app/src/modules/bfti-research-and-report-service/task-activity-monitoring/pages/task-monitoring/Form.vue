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
              <router-link class="btn-add" to="/bfti-research-and-report-service/task-activity-monitoring/activity-monitoring"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
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
                  <b-table-simple bordered style="width: 100%" class="main-table-list">
                    <b-tr>
                      <b-th style="width:5% !important">{{ $t('globalTrans.sl_no') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.task_name') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.sub_task_name') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('research_plan_management.responsible_person') }} & {{ $t('globalTrans.designation') }} </b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.note') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.approx_start_date') }} & {{ $t('task_activity_monitoring.approx_end_date') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.actual_start_date') }} & {{ $t('task_activity_monitoring.actual_end_date') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('task_activity_monitoring.assign_status') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('globalTrans.status') }}</b-th>
                      <b-th style="width:13% !important">{{ $t('globalTrans.action') }}</b-th>
                    </b-tr>
                    <template v-if="taskHeading.length === 0">
                      <tr>
                        <th colspan="10" class="text-center text-danger">{{$t('globalTrans.noDataFound')}}</th>
                      </tr>
                    </template>
                    <template v-else>
                      <slot v-for="(task, index) in taskHeading">
                        <b-tr v-for="(head, index1) in task.task_history" :key="index + '_' +index1">
                          <slot v-if="index1 === 0">
                            <b-td :rowspan="task.task_history.length">{{ $n(index + 1) }}</b-td>
                            <b-td :rowspan="task.task_history.length">
                              {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskHeadingList,'value', task.task_heading_id) }}
                            </b-td>
                            <b-td :rowspan="task.task_history.length">
                              {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskSubHeadingList,'value', task.sub_task_heading_id) }}
                            </b-td>
                            <b-td :rowspan="task.task_history.length">
                              {{ getColumnName(allUserList,'id', task.employee_user_id, 'other') }} <br/>
                              {{ getColumnName($store.state.CommonService.commonObj.componentDesignationList,'value', task.designation_id) }}
                            </b-td>
                          </slot>
                          <b-td :class="rowClass(head)"> {{head.note}} </b-td>
                          <b-td :class="rowClass(head)">
                            {{head.start_date | dateFormat }} -
                            {{head.end_date | dateFormat }}
                            <br/>
                            <div style="padding: 0px !important;font-weight:bold; background: none !important;">
                              <slot v-if="head.days">
                                {{ $t('globalTrans.total_days') }}
                                {{ $n(head.days) }}
                              </slot>
                            </div>
                          </b-td>
                          <b-td :class="rowClass(head)">
                            <slot v-if="head.actual_start_date">
                              {{ head.actual_start_date| dateFormat }}
                            </slot> -
                            <slot v-if="head.actual_end_date">
                              {{ head.actual_end_date| dateFormat }}
                            </slot>
                            <div style="padding: 0px !important;font-weight:bold; background: none !important;">
                              <slot v-if="head.actual_days">
                                {{ $t('globalTrans.total_days') }}
                                {{ $n(head.actual_days)}}
                              </slot>
                            </div>
                          </b-td>
                          <b-td :class="rowClass(head)">
                            <span class="badge badge-primary" v-if="head.status === 1">{{$t('globalTrans.pending')}}</span>
                            <span class="badge badge-info" v-else-if="head.status === 2">{{$t('task_activity_monitoring.ongoing')}}</span>
                            <span class="badge badge-success" v-else-if="head.status === 3">{{$t('task_activity_monitoring.done')}}</span>
                          </b-td>
                          <b-td :class="rowClass(head)">
                            <span class="badge badge-primary" v-if="head.task_type === 1">{{$t('globalTrans.regular')}}</span>
                            <span class="badge badge-info" v-else-if="head.task_type === 2">{{$t('globalTrans.review')}}</span>
                          </b-td>
                          <b-td :class="rowClass(head)">
                            <!-- <pre>{{head.status}}</pre>
                            <pre>{{task}}</pre> -->
                            <b-button class="action-btn btn-success" v-if="head.status === 3 && head.task_type === 1 && task.status === 1" @click="remove(head)" :title="$t('task_activity_monitoring.done')" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
                            <b-button title="Regular" v-if="head.status === 3 && head.task_type === 1 && task.status === 1" v-b-modal.modal-form-details variant="iq-bg-info" class="action-btn btn-info" size="sm" @click="recommended(task, head)"><i class="ri-share-forward-line"></i></b-button>
                            <b-button class="action-btn btn-primary" v-b-modal.modal-form-details-view v-if="head.status === 3" variant="iq-bg-primary mr-2" size="sm" @click="detailData(task, head)" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-chat-upload-fill"></i></b-button>
                          </b-td>
                        </b-tr>
                      </slot>
                    </template>
                  </b-table-simple>
                </b-col>
              </b-row>
            </template>
          </body-card>
        </b-form>
      </b-overlay>
      <b-modal id="modal-form-details" size="lg" :title="$t('task_activity_monitoring.review') + ' ' + $t('globalTrans.add')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <Details v-on:updateParent="updateParent" :item="item" :taskHistoryId="taskHistoryId"/>
      </b-modal>
      <b-modal id="modal-form-details-view" size="lg" :title="$t('task_activity_monitoring.task_details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DetailsView :item="item" :head="head"/>
    </b-modal>
    </ValidationObserver>
  </div>
</template>
<style>
  .datepicker-form {
    font-size: 8px !important;
  }
  .badge-primary {
    background-color: var(--primary) !important;
  }
  .badge-info {
    background-color: #17a2b8 !important;
  }
  .badge-success {
      background-color: var(--success) !important;
  }
  .main-table-list .table-orange, .table-orange > th, .table-orange > td {
    background-color: #DAA06D;
    color: #000 !important;
  }
  .main-table-list .table-warning, .table-warning > th, .table-warning > td {
    background-color: #FFDB58;
  }
  .main-table-list .table-success, .table-success > th, .table-success > td {
    background-color: #AFE192;
  }
  .main-table-list .table-danger, .table-danger > th, .table-danger > td {
    background-color: #D22B37 !important;
  }
  .main-table-list .table-hover .table-orange:hover {
    background-color: #d3a37a !important;
  }
  .main-table-list .table-hover .table-danger:hover {
    background-color: #c4434b !important;
  }
</style>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { taskShow, userListByDesignWise, taskToggle } from '../../api/routes'
import Details from './Details'
import DetailsView from './DetailsView'
import moment from 'moment'
export default {
  name: 'Form',
  components: {
    Details,
    DetailsView
  },
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
      districtList: [],
      item: [],
      head: [],
      exclusions: this.$store.state.BftiResearchAndReportService.commonObj.holidayList,
      weekday: [1, 2, 3, 4, 5],
      taskHistoryId: 0
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
    rowClass (item) {
      if (item.days) {
        require('moment-weekday-calc')
        var startDate = moment(item.start_date)
        var endDate = moment(item.end_date)
        var actualStartDate = moment(item.actual_start_date)
        var actualEndDate = moment(item.actual_end_date)
        const today = new Date().toISOString().slice(0, 10)
        if (item.actual_start_date && item.actual_end_date) {
          var diffStart = actualStartDate.diff(endDate, 'days')
          var diffEnd = actualEndDate.diff(endDate, 'days')
          if (diffStart > 0 || diffEnd > 0) {
            return 'table-orange'
          }
          if (diffEnd <= 0) {
            return 'table-success'
          }
        }
        if (item.actual_start_date) {
          const actualStartDateINTime = actualStartDate.isBetween(startDate, endDate, 'days', true)
          if (actualStartDateINTime) {
            const todayDiff = moment().weekdayCalc({
              rangeStart: item.start_date,
              rangeEnd: today,
              weekdays: this.weekday,
              exclusions: this.exclusions
            })
            const percentage = this.dateDiffCheck(item.days, todayDiff)
            const taskAlert = this.$store.state.BftiResearchAndReportService.commonObj.taskAlertList.find(taskAlertList => taskAlertList.value === item.task_alert_id)
            if (typeof taskAlert !== 'undefined') {
              if (parseInt(percentage) > taskAlert.task_alert) {
                return 'table-warning'
              }
            }
          }
        }
        if (item.status !== 3) {
          var todayDate = moment(today)
          var isTodayBig = todayDate.diff(endDate, 'days')
          if (isTodayBig > 0) {
            return 'table-danger'
          }
        }
      }
    },
    dateDiffCheck (days, todayDiff) {
      const amnt = parseFloat(todayDiff) * 100
      const totalPercentage = amnt / days
      return totalPercentage
    },
    updateParent () {
      this.loadData()
    },
    recommended (item, head) {
      this.item = item
      this.taskHistoryId = head.id
    },
    remove (item) {
      this.$swal({
        title: this.$t('globalTrans.recommendentChangeMsg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
          this.confirmData(item)
        }
      })
      // this.changeStatus(3, bftiResReportServiceBaseUrl, taskToggle, item)
    },
    async confirmData (item) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      result = await RestApi.postData(bftiResReportServiceBaseUrl, taskToggle, item)
      if (result.success) {
        this.$toast.success({
          title: 'Success',
          message: 'Data saved successfully',
          color: '#D6E09B'
        })
        this.loadData()
      } else {
        this.$store.dispatch('mutateCommonProperties', { loading: false })
      }
    },
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
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, taskShow + '/' + this.$route.params.id)
      if (result.success) {
        this.taskHeading = result.task
        this.condinatorInfo = result.condinatorInfo
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
    },
    detailData (head, item) {
      this.item = item
      this.head = head
    }
  }
}
</script>
