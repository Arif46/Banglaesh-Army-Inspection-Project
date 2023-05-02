<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meetingManagement.search_parameter') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="meeting_start_date"
            >
              <template v-slot:label>
                {{ $t('meetingManagement.meeting_date_from') }}
              </template>
              <date-picker
                id="meeting_start_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                v-model="search.meeting_start_date"
              ></date-picker>
            </b-form-group>
          </b-col>
           <b-col sm="4">
            <b-form-group
              label-for="meeting_end_date"
            >
              <template v-slot:label>
                {{ $t('meetingManagement.meeting_date_to') }}
              </template>
              <date-picker
                id="meeting_end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                v-model="search.meeting_end_date"
              ></date-picker>
            </b-form-group>
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
        <h4 class="card-title">{{ $t('meetingManagement.meeting') + ' ' + $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
         <b-table head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
            <template v-slot:cell(serial)="data">
              {{ $n(data.item.serial + pagination.slOffset) }}
            </template>
            <template v-slot:cell(meeting_date)="data">
              {{ data.item.meeting_date | dateFormat }}
            </template>
            <template v-slot:cell(attachment)="data">
              <a target="_blank" v-if="data.item.attachment" :href="bftiResReportServiceBaseUrl + data.item.attachment">{{ $t('bfti.attachment_down')}}</a>
            </template>
            <template v-slot:cell(status)="data">
              <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
              <span class="badge badge-success" v-else-if="data.item.status == 2 && data.item.is_draft == 2">{{$t('globalTrans.inactive')}}</span>
              <span class="badge badge-danger" v-else-if="data.item.status == 2 && data.item.is_draft == 1">{{$t('globalTrans.draft')}}</span>
            </template>
            <template v-slot:cell(action)="data">
              <b-button v-if="data.item.is_notified === 1" v-b-modal.modal-employee variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('meetingManagement.meeting_notification')"><i class="ri-notification-fill"></i></b-button>
              <b-button v-b-modal.modal-attachment variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('meetingManagement.meeting_min_upload')"><i class="ri-attachment-line"></i></b-button>
              <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
              <b-button class="mr-1" title="View" v-b-modal.details variant="action-btn status mr-1" size="sm" @click="edit(data.item)"><i class="ri-eye-fill"></i></b-button>
              <b-button v-if="data.item.notifications.length > 0" class="mr-1" title="Notification View" v-b-modal.notificationView variant="action-btn status mr-1" size="sm" @click="edit(data.item)"><i class="ri-notification-3-line"></i></b-button>
            </template>
          </b-table>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-attachment" size="lg" :title="$t('meetingManagement.meeting_min_upload')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <AttachmentForm :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="$t('meetingManagement.meeting') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <b-button @click="pdfExport" class="ml-4 btn-success download-pdf-button">
        {{  $t('globalTrans.export_pdf') }}
      </b-button>
      <Details :id="editItemId" :key="editItemId" ref="details"/>
    </b-modal>
    <b-modal id="notificationView" size="lg" :title="$t('meetingManagement.meeting_notification') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <NotificationView :id="editItemId" :key="editItemId" ref="notificationView"/>
    </b-modal>
    <b-modal id="modal-employee" size="lg" :title="$t('meetingManagement.meeting_notification')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <EmployeeForm :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details'
import AttachmentForm from './AttachmentForm'
import EmployeeForm from './EmployeeForm'
import NotificationView from './NotificationView'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { createMeetingListApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Details,
    AttachmentForm,
    NotificationView,
    EmployeeForm
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        meeting_start_date: '',
        meeting_end_date: '',
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'meetingManagement.meeting_title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'meetingManagement.memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'meetingManagement.meeting_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'meetingManagement.meeting_min_upload', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7 }
      ],
      actions: {
        edit: true,
        details: true,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
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
          { key: 'meeting_title_bn' },
          { key: 'memo_no' },
          { key: 'meeting_date' },
          { key: 'attachment' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'meeting_title_en' },
          { key: 'memo_no' },
          { key: 'meeting_date' },
          { key: 'attachment' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('meetingManagement.meeting') + ' ' + this.$t('globalTrans.entry') : this.$t('meetingManagement.meeting') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, createMeetingListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    pdfExport () {
      this.$refs.details.pdfExport()
    }
  }
}
</script>
