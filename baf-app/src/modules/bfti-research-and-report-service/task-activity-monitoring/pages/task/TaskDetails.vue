<template>
  <div class="inner-section">
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title"> {{ $t('task_activity_monitoring.task_details') }} {{ $t('globalTrans.information') }}</h4>
      </template>
      <template v-slot:searchHeaderAction>
        <router-link class="btn-add" to="/bfti-research-and-report-service/task-activity-monitoring/task"><i class="ri-arrow-left-line"></i> {{ $t('globalTrans.back') }}</router-link>
      </template>
      <template v-slot:searchBody>
        <b-table-simple bordered v-if="condinatorInfo">
          <b-tr>
            <b-th>{{ $t('configuration.document_type') }}</b-th>
            <b-th class="text-center">:</b-th>
            <b-td>
              {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.documentTypeList,'value', condinatorInfo.document_type_id) }}
            </b-td>
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
            <b-th>{{$t('task_activity_monitoring.task_coordinator')}}</b-th>
            <b-th class="text-center">:</b-th>
            <b-td>
               {{ ($i18n.locale === 'bn') ? condinatorInfo.responsible_person_bn : condinatorInfo.responsible_person }}
            </b-td>
            <b-th>{{ $t('globalTrans.designation') }}</b-th>
            <b-th class="text-center">:</b-th>
            <b-td>
              {{ getColumnName($store.state.CommonService.commonObj.componentDesignationList,'value', condinatorInfo.designation_id) }}
            </b-td>
          </b-tr>
        </b-table-simple>
      </template>
    </card>
    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('task_activity_monitoring.task_details') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive main-table-list">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :tbody-tr-class="rowClass" :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                    <!-- {{dateDiffCheck(data.item)}} -->
                  </template>
                   <template v-slot:cell(attachment)="data">
                    <div class="text-center">
                      <a  target="_blank" v-if="data.item.file" :href="bftiResReportServiceBaseUrl + data.item.file" class="badge badge-primary">
                        <i class="ri-cloud-fill"></i>
                        {{ $t('globalTrans.attachment') }}
                      </a>
                    </div>
                  </template>
                  <template v-slot:cell(task_heading_id)="data">
                    {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskHeadingList,'value', data.item.task_heading_id) }}
                  </template>
                  <template v-slot:cell(sub_task_heading_id)="data">
                    {{ getColumnName($store.state.BftiResearchAndReportService.commonObj.taskSubHeadingList,'value', data.item.sub_task_heading_id) }}
                  </template>
                  <template v-slot:cell(designation_id)="data">
                    {{ getColumnName($store.state.CommonService.commonObj.componentDesignationList,'value', data.item.designation_id) }}
                  </template>
                  <template v-slot:cell(employee_user_id)="data">
                    {{ getEmployeeName(data.item.employee_user_id) }}
                  </template>
                  <template v-slot:cell(document_type_id)="data">
                    {{ getDocumentList(data.item.document_type_id) }}
                  </template>
                  <template v-slot:cell(start_date)="data">
                    <slot v-if="data.item.start_date">
                      {{ data.item.start_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(end_date)="data">
                    <slot v-if="data.item.end_date">
                      {{ data.item.end_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(actual_start_date)="data">
                    <slot v-if="data.item.actual_start_date">
                      {{ data.item.actual_start_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(actual_end_date)="data">
                    <slot v-if="data.item.actual_end_date">
                      {{ data.item.actual_end_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(coordinator_assign)="data">
                    <span class="badge badge-warning" v-if="data.item.coordinator_assign === 1">{{$t('task_activity_monitoring.not_assign')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.coordinator_assign === 2">{{$t('task_activity_monitoring.assign')}}</span>
                  </template>
                  <template v-slot:cell(task_type)="data">
                    <span class="badge badge-info" v-if="data.item.task_type === 1">{{$t('globalTrans.regular')}}</span>
                    <span class="badge badge-warning" v-else-if="data.item.task_type === 2">{{$t('globalTrans.review')}}</span>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.status == 2">{{$t('task_activity_monitoring.ongoing')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 3">{{$t('task_activity_monitoring.done')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                   <b-button v-b-modal.modal-form-details v-if="data.item.status !== 3" variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                   <b-button v-b-modal.modal-form-details-view v-if="data.item.status === 3" variant="iq-bg-primary mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-chat-upload-fill"></i></b-button>
                  </template>
                </b-table>
              </slot>
              <div class="pagination-wrapper mt-3" v-if="columns.filter(item => item.show === '1').length > 0">
                <b-pagination
                  v-model="pagination.currentPage"
                  :perPage="search.limit"
                  :total-rows="pagination.totalRows"
                  @input="searchData"
                />
               </div>
            </b-col>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form-details-view" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <DetailsView :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<style>
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
import { taskHistory, userListByDesignWise } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Details from './Details'
import DetailsView from './DetailsView'
import moment from 'moment'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details,
    DetailsView
  },
  data () {
    return {
      sortBy: '',
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      search: {
        assign_task_coordinator_id: this.$route.params.id,
        employee_user_id: 0,
        limit: 10
      },
      allUserList: [],
      userList: [],
      item: [],
      condinatorInfo: [],
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.task_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.sub_task_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'research_plan_management.responsible_person', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.approx_start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.approx_end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.actual_start_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.actual_end_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 10, thStyle: { width: '20%' } },
        { labels: 'globalTrans.attachment', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 11, thStyle: { width: '20%' } },
        { labels: 'task_activity_monitoring.assign_status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 12, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 13, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 14 }
      ],
      editItemId: 0,
      exclusions: this.$store.state.BftiResearchAndReportService.commonObj.holidayList,
      weekday: [1, 2, 3, 4, 5],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    // if (this.$route.params.id) {
    //   this.getAllUserList()
    // }
  },
  mounted () {
    if (this.$store.state.Auth.activeRoleId !== 1) {
      this.search = Object.assign({}, this.search, {
        employee_user_id: this.$store.state.Auth.authUser.user_id
      })
    }
    this.getAllUserList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    detailsTitle () {
      return this.$t('task_activity_monitoring.task_details')
    },
    docTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    },
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'document_type_id' },
          { key: 'task_heading_id' },
          { key: 'sub_task_heading_id' },
          { key: 'employee_user_id' },
          { key: 'designation_id' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'actual_start_date' },
          { key: 'actual_end_date' },
          { key: 'attachment' },
          { key: 'status' },
          { key: 'task_type' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type_id' },
          { key: 'task_heading_id' },
          { key: 'sub_task_heading_id' },
          { key: 'employee_user_id' },
          { key: 'designation_id' },
          { key: 'start_date' },
          { key: 'end_date' },
          { key: 'actual_start_date' },
          { key: 'actual_end_date' },
          { key: 'attachment' },
          { key: 'status' },
          { key: 'task_type' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('task_activity_monitoring.task_details') + ' ' + this.$t('globalTrans.entry') : this.$t('research_plan_management.assign_task_coordinator') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    rowClass (item, type) {
      if (!item || type !== 'row') return ''
      else if (item.days) {
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
    getDocumentTypeName (documentTypeId) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === documentTypeId)
      return data !== undefined ? data.text : ''
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
    },
    getEmployeeName (empID) {
      const empData = this.allUserList.find(user => user.id === empID)
      if (empData) {
        if (this.$i18n.locale === 'bn') {
          return empData.name_bn
        } else {
          return empData.name
        }
      }
    },
    getDocumentList (id) {
      const data = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(desig => desig.value === parseInt(id))
      return data !== 'undefined' ? data.text : ''
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
    editMethodInParent (item, type) {
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, taskHistory, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.$store.dispatch('setList', listData)
        this.condinatorInfo = result.condinatorInfo
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    details (item) {
      this.editItemId = item.id
    }
  }
}
</script>
