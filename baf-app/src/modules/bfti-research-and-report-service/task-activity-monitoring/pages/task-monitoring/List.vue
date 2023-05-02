<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('task_activity_monitoring.task_activity_monitoring') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4">
            <b-form-group
              label-for="document_type_id"
            >
              <template v-slot:label>
                {{$t('configuration.document_type')}}
              </template>
              <b-form-select
                plain
                v-model="search.document_type_id"
                :options="docTypeList"
                id="fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Title" vid="topic" v-slot="{ valid, errors }">
              <b-form-group
                label-for="topic">
                <template v-slot:label>
                  {{ $t('globalTrans.title') }}
                </template>
                <b-form-input
                  id="title"
                  v-model="search.topic"
                  :placeholder="$t('globalTrans.title')"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">{{ $t('task_activity_monitoring.task_activity_monitoring') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(title)="data">
                    <slot v-if="data.item.document_type_id === 1">
                      {{ ($i18n.locale === 'bn') ? data.item.prepare_eoi.title_bn : data.item.prepare_eoi.title }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 2">
                      {{ ($i18n.locale === 'bn') ? data.item.prepare_rfp.rfp_title_bn : data.item.prepare_rfp.rfp_title_en }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 3">
                      {{ ($i18n.locale === 'bn') ? data.item.research.topic_bn: data.item.research.topic }}
                    </slot>
                    <slot v-else-if="data.item.document_type_id === 4">
                      {{ ($i18n.locale === 'bn') ? data.item.policy.policy_title_bn: data.item.policy.policy_title }}
                    </slot>
                  </template>
                  <template v-slot:cell(assign_date)="data">
                    <slot v-if="data.item.assign_date">
                      {{ data.item.assign_date| dateFormat }}
                    </slot>
                  </template>
                  <template v-slot:cell(task_assign)="data">
                    <span class="badge badge-warning" v-if="data.item.task_assign === 1">{{$t('task_activity_monitoring.not_assign')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.task_assign === 2">{{$t('task_activity_monitoring.assign')}}</span>
                  </template>
                  <template v-slot:cell(approve_status)="data">
                    <span class="badge badge-primary" v-if="data.item.approve_status == 1">{{$t('globalTrans.draft')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.approve_status == 2">{{$t('globalTrans.finalSave')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.approve_status == 3">{{$t('globalTrans.forward')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.approve_status == 4">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.approve_status == 5">{{$t('globalTrans.rejected')}}</span>
                    <span class="badge badge-warning" v-else-if="data.item.approve_status == 6">{{$t('globalTrans.review')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn edit" variant="iq-bg-success mr-1" title="Edit" :to="`/bfti-research-and-report-service/task-activity-monitoring/activity-monitoring/from/${data.item.id}`"><i class="ri-ball-pen-fill"></i></router-link>
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
    <b-modal id="modal-form" size="lg" :title="formTitle"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-detail" size="lg" :title="$t('task_activity_monitoring.checklist') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Detail :id="editItemId"/>
    </b-modal>
    <!-- <pre>{{this.$t('globalTrans.sl_no', 'bn') }}</pre> -->
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { coordinatorTask, assignTaskCoordinatorToggle, userListByDesignWise } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
  },
  data () {
    return {
      sortBy: '',
      search: {
        document_type_id: 0,
        topic: '',
        task_assign: 2,
        limit: 10,
        employee_user_id: 0,
        assignTaskCoordinator_name: ''
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'globalTrans.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'globalTrans.designation', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'research_plan_management.responsible_person', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      recommendedItemId: 0
    }
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
          { key: 'document_type_bn' },
          { key: 'title' },
          { key: 'designation_bn' },
          { key: 'responsible_person_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type' },
          { key: 'title' },
          { key: 'designation' },
          { key: 'responsible_person' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('research_plan_management.assign_task_coordinator') + ' ' + this.$t('globalTrans.entry') : this.$t('research_plan_management.assign_task_coordinator') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    getAllUserList () {
      this.userLoading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      RestApi.getData(authServiceBaseUrl, userListByDesignWise).then(response => {
        if (response.success) {
          this.allDesignationList = response.data
          this.loadData()
        } else {
          this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        }
      })
    },
    remove (item) {
      this.changeStatus(3, bftiResReportServiceBaseUrl, assignTaskCoordinatorToggle, item)
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, coordinatorTask, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const documentTypeListObj = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(doc => doc.value === parseInt(item.document_type_id))
          const documentTypeData = {}
          if (typeof documentTypeListObj !== 'undefined') {
            documentTypeData.document_type = documentTypeListObj.text_en
            documentTypeData.document_type_bn = documentTypeListObj.text_bn
          } else {
            documentTypeData.document_type = ''
            documentTypeData.document_type_bn = ''
          }
          const designatonObj = this.$store.state.CommonService.commonObj.designationList.find(designationList => designationList.value === parseInt(item.designation_id))
          const designatonData = {}
          if (typeof designatonObj !== 'undefined') {
            designatonData.designation = designatonObj.text_en
            designatonData.designation_bn = designatonObj.text_bn
          } else {
            designatonData.designation = ''
            designatonData.designation_bn = ''
          }
          const userObj = this.allDesignationList.find(allDesignation => allDesignation.id === parseInt(item.employee_user_id))
          const userData = {}
          if (typeof userObj !== 'undefined') {
            userData.responsible_person = userObj.name
            userData.responsible_person_bn = userObj.name_bn
          } else {
            userData.responsible_person = ''
            userData.responsible_person_bn = ''
          }
          return Object.assign({}, item, { serial: index }, documentTypeData, designatonData, userData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    recommended (item) {
      this.recommendedItemId = item.id
    }
  }
}
</script>
