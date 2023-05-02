<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('meeting_management.create_program_info') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3">
            <ValidationProvider name="Start date" vid="start_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="start_date">
                <template v-slot:label>
                  {{ $t('globalTrans.start_date') }}
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
          <b-col xs="12" sm="12" md="3">
            <ValidationProvider name="End date" vid="end_date" rules="''" v-slot="{ errors }">
              <b-form-group
                label-for="end_date">
                <template v-slot:label>
                  {{ $t('globalTrans.end_date') }}
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
        <h4 class="card-title">{{ $t('meeting_management.create_program_info') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
        <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.index + 1) }}
                  </template>
                  <template v-slot:cell(program_date)="data">
                    {{ data.item.program_date | dateFormat}}
                  </template>
                  <template v-slot:cell(action)="data">
                    <!-- <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm" @click="details(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button> -->
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-2" size="sm" @click="detailsData(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
                    <template>
                      <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" v-b-tooltip.hover :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                      <b-button v-b-modal.modal-invite v-if="data.item.invite_status === 0 && data.item.draft === 1" variant="iq-bg-primary mr-2" size="sm" @click="edit(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('meeting_management.invitation_pending')"><i class="ri-mail-send-line"></i></b-button>
                      <b-button v-b-modal.modal-invite v-if="data.item.invite_status === 1 && data.item.draft === 1" variant="iq-bg-primary mr-2" size="sm" @click="edit(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('meeting_management.invitation_file_ready')"><i class="ri-mail-send-line"></i></b-button>
                      <b-button v-b-modal.modal-invitation-form v-if="data.item.invite_status === 2 && data.item.draft === 1" variant="iq-bg-primary mr-2" size="sm" @click="edit(data.item)" class="action-btn status" v-b-tooltip.hover :title="$t('meeting_management.send_invitation')"><i class="ri-send-plane-fill"></i></b-button>
                    </template>
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-danger" v-if="data.item.invite_status === 0">{{$t('meeting_management.invitation_not_created')}}</span>
                    <span class="badge badge-warning" v-if="data.item.invite_status === 1">{{$t('meeting_management.invitation_pending')}}</span>
                    <span class="badge badge-primary" v-if="data.item.invite_status === 2">{{$t('meeting_management.invitation_file_ready')}}</span>
                    <span class="badge badge-success" v-if="data.item.invite_status === 3">{{$t('meeting_management.invited')}}</span>
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
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-form-details" size="lg" :title="$t('meeting_management.create_program_info') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :item="item"/>
    </b-modal>
    <b-modal id="modal-invite" size="xl" :title="formTitleInvite" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Invite :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="modal-invitation-form" size="xl" :title="formTitleInvite" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <InvitationForm :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Invite from './Invite.vue'
import Form from './Form.vue'
import Details from './Details'
import InvitationForm from './InvitationForm'
import RestApi, { bftiResReportServiceBaseUrl } from '@/config/api_config'
import { programInfoListApi, programInfoToggleApi } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form,
    Invite,
    Details,
    InvitationForm
  },
  data () {
    return {
      bftiResReportServiceBaseUrl: bftiResReportServiceBaseUrl,
      sortBy: '',
      search: {
        start_date: 0,
        end_date: 0,
        limit: 20
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
        { labels: 'meeting_management.program_type_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '16%' } },
        { labels: 'meeting_management.title', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'meeting_management.memo_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '14%' } },
        { labels: 'meeting_management.program_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '13%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 7 }
      ],
      item: '',
      actions: {
        edit: true,
        toogle: true,
        details: true,
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
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        return Object.assign(item, { label: this.$t(item.labels, this.$i18n.locale) })
      })

      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'serial' },
          { key: 'program_type_bn' },
          { key: 'title_bn' },
          { key: 'memo_no' },
          { key: 'program_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'program_type_en' },
          { key: 'title' },
          { key: 'memo_no' },
          { key: 'program_date' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('meeting_management.create_program_info') + ' ' + this.$t('globalTrans.entry') : this.$t('meeting_management.create_program_info') + ' ' + this.$t('globalTrans.modify')
    },
    formTitleInvite () {
      return (this.editItemId === 0) ? this.$t('meeting_management.pii') + ' ' + this.$t('globalTrans.entry') : this.$t('meeting_management.pii')
    },
    documentTypeList () {
      return this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(bftiResReportServiceBaseUrl, programInfoToggleApi, item)
      }
    },
    detailsData (item) {
      this.item = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, programInfoListApi, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const storeObj = this.$store.state.BftiResearchAndReportService.commonObj.programTypeList.find(law => law.value === parseInt(item.program_type_id))
          const textData = {}
            if (typeof storeObj !== 'undefined') {
                textData.program_type_en = storeObj.text_en
                textData.program_type_bn = storeObj.text_bn
            } else {
              textData.program_type_en = ''
              textData.program_type_bn = ''
            }
          const documentObj = this.$store.state.BftiResearchAndReportService.commonObj.documentTypeList.find(data => data.value === parseInt(item.document_type_id))
          const documentData = {}
            if (typeof documentObj !== 'undefined') {
                documentData.document_type_en = documentObj.text_en
                documentData.document_type_bn = documentObj.text_bn
            } else {
              documentData.document_type_en = ''
              documentData.document_type_bn = ''
            }
          return Object.assign({}, item, { serial: index }, textData, documentData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
