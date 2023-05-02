<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('task_activity_monitoring.assign_consultant') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="fiscal_year_id"
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
          <b-col xs="12" sm="12" md="6">
            <b-form-group
              label-for="topic"
            >
            <template v-slot:label>
              {{$t('bfti.topic')}}
            </template>
            <b-form-input
                id="topic"
                v-model="search.topic"
                placeholder=""
                ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Start date" vid="start_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                  {{ $t('task_activity_monitoring.project') }} {{ $t('globalTrans.start_date') }}
                </template>
                <date-picker
                 id="start_date"
                 class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                v-model="search.start_date"
                :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="End date" vid="end_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('task_activity_monitoring.project') }} {{ $t('globalTrans.end_date') }}
                </template>
                <date-picker
                id="end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                 v-model="search.end_date"
                :state="errors[0] ? false : (valid ? true : null)"
                >
                </date-picker>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
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
        <h4 class="card-title">{{ $t('task_activity_monitoring.assign_consultant') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-button class="btn-add" variant=" iq-bg-info" @click="pdfExport">
                {{ $t('globalTrans.print') }}
        </b-button>
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
                  <template v-slot:cell(duration)="data">
                    {{getDuration(data.item.duration_start_date, data.item.duration_end_date)}}
                  </template>
                  <template v-slot:cell(task_assign)="data">
                    <span class="badge badge-warning" v-if="data.item.task_assign === 1">{{$t('task_activity_monitoring.not_assign_cons')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.task_assign === 2">{{$t('task_activity_monitoring.assign_cons')}}</span>
                  </template>
                  <template v-slot:cell(assign)="data">
                    <span class="badge badge-warning" v-if="data.item.assign === 1">{{$t('task_activity_monitoring.not_assign_cons')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.assign === 2">{{$t('task_activity_monitoring.assign_cons')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn btn-success" variant="iq-bg-success mr-1" :title="$t('task_activity_monitoring.assign_consultant')" :to="`/bfti-research-and-report-service/task-activity-monitoring/assign-consultant/from/${data.item.id}`"><i class="ri-check-line"></i></router-link>
                    <router-link class="action-btn active view" variant="iq-bg-info mr-1" title="Details" :to="`/bfti-research-and-report-service/task-activity-monitoring/assign-consultant/detail/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
                    <!-- <b-button v-b-modal.modal-5 variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button> -->
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
    <!-- <b-modal id="modal-5" size="xl" :title="$t('task_activity_monitoring.assign_consultant') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId"/>
    </b-modal> -->
    <b-modal id="modal-5" size="lg" :title="$t('globalTrans.details')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger" hide-footer>
      <Details :id="recommendedItemId" hide-footer/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { bftiResearchRequestApprovedList, assignConsultantTogle, userListByDesignWise } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ExportPdf from './export_pdf_list'
export default {
  mixins: [ModalBaseMasterList],
  components: {},
  data () {
    return {
      sortBy: '',
      search: {
        document_type_id: 0,
        topic: '',
        start_date: '',
        end_date: '',
        limit: 10,
        assignTaskCoordinator_name: '',
        type: 1
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'bfti.topic', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'research_execution.project_duration', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: true,
        details: true,
        toogle: true,
        delete: false
      },
      recommendedItemId: 0
    }
  },
  created () {
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
          { key: 'organization_bn' },
          { key: 'topic_bn' },
          { key: 'duration' },
          { key: 'assign' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type' },
          { key: 'organization' },
          { key: 'topic' },
          { key: 'duration' },
          { key: 'assign' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('task_activity_monitoring.assign_consultant') + ' ' + this.$t('globalTrans.entry') : this.$t('task_activity_monitoring.assign_consultant') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    editMethodInParent (item, type) {
    },
     getDuration (startingDate, endingDate) {
            var startDate = new Date(new Date(startingDate).toISOString().substr(0, 10))
            if (!endingDate) {
                endingDate = new Date().toISOString().substr(0, 10)
            }
            var endDate = new Date(endingDate)
            if (startDate > endDate) {
                var swap = startDate
                startDate = endDate
                endDate = swap
            }
            var startYear = startDate.getFullYear()
            var february = (startYear % 4 === 0 && startYear % 100 !== 0) || startYear % 400 === 0 ? 29 : 28
            var daysInMonth = [31, february, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

            var yearDiff = endDate.getFullYear() - startYear
            var monthDiff = endDate.getMonth() - startDate.getMonth()
            if (monthDiff < 0) {
                yearDiff--
                monthDiff += 12
            }
            var dayDiff = endDate.getDate() - startDate.getDate()
            if (dayDiff < 0) {
                if (monthDiff > 0) {
                    monthDiff--
                } else {
                    yearDiff--
                    monthDiff = 11
                }
                dayDiff += daysInMonth[startDate.getMonth()]
            }

            if (this.$i18n.locale === 'bn') {
                const year = this.$n(yearDiff, { useGrouping: false })
                const month = this.$n(monthDiff, { useGrouping: false })
                const day = this.$n(dayDiff, { useGrouping: false })
                const result = year + ' বছর, ' + month + ' মাস, ' + day + ' দিন'
                return result
            } else {
                const result = yearDiff + ' Year, ' + monthDiff + ' Month, ' + dayDiff + ' Days'
                return result
            }
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
      this.changeStatus(bftiResReportServiceBaseUrl, assignConsultantTogle, item)
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, bftiResearchRequestApprovedList, params)
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
          return Object.assign({}, item, { serial: index }, documentTypeData)
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
    },
    pdfExport () {
        const reportTitle = this.$t('task_activity_monitoring.assign_consultant')
        ExportPdf.exportPdfDetails(bftiResReportServiceBaseUrl, '/configuration/report-head/detail', 10, reportTitle, this.listData, this)
    }
  }
}
</script>
