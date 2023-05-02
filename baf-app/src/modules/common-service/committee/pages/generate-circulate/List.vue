<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('committee.generate_circulate') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
         <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Organization" vid="org_id">
                    <b-form-group
                        label-for="org_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('organogram.org')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.org_id"
                      :options="orgList"
                      id="org_id"
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
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Committee" vid="cmt_committee_id">
                    <b-form-group
                        label-for="cmt_committee_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('committee.committee')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.cmt_committee_id"
                      :options="committeeList"
                      id="cmt_committee_id"
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
             <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <ValidationProvider name="Agenda" vid="cmt_agenda_id">
                    <b-form-group
                        label-for="cmt_agenda_id"
                        slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('committee.agenda')}}
                    </template>
                    <b-form-select
                      plain
                      v-model="search.cmt_agenda_id"
                      :options="agendaList"
                      id="cmt_agenda_id"
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
            <b-col sm="4" class="mt-4">
                <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('committee.generate_circulate') }} {{ $t('globalTrans.list') }}</h4>
      </template>
        <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                    <template v-slot:cell(attendance_attachment)="data">
                    <div class="text-center">
                      <a :href="commonServiceBaseUrl + 'download-attachment?file=' + data.item.attendance_attachment" class="badge badge-primary">
                        <i class="ri-cloud-fill"></i>
                        {{ $t('globalTrans.attachment') }}
                      </a>
                    </div>
                  </template>
                   <template v-slot:cell(document_attachment)="data">
                    <div class="text-center">
                      <a :href="commonServiceBaseUrl + 'download-attachment?file=' + data.item.document_attachment" class="badge badge-primary">
                        <i class="ri-cloud-fill"></i>
                        {{ $t('globalTrans.attachment') }}
                      </a>
                    </div>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-form variant="iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button class="action-btn btn-success" @click="remove(data.item)" title="Approve Btn" v-b-modal.details size="sm"><i class="ri-arrow-right-circle-fill"></i></b-button>
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
      <!-- table section end-->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { meetingMinuteList, manageAgendaToggleStatus } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      commonServiceBaseUrl: commonServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        org_id: 0,
        cmt_committee_id: 0,
        cmt_agenda_id: 0,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.organization', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'committee.committee', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'committee.agenda', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '10%' } },
        { labels: 'committee.decisionl', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'committee.attendance_attachment', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'committee.document_attachment', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: true,
        details: false,
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
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList
    },
    committeeList () {
      return this.$store.state.CommonService.commonObj.committeeList.filter(committee => committee.org_id === this.search.org_id)
    },
    agendaList () {
      return this.$store.state.CommonService.commonObj.agendaList.filter(committee => committee.cmt_committee_id === this.search.cmt_committee_id)
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
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
          { key: 'org_name_bn' },
          { key: 'cmt_name_bn' },
          { key: 'agenda_name_bn' },
          { key: 'decision_bn' },
          { key: 'attendance_attachment' },
          { key: 'document_attachment' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'org_name' },
          { key: 'cmt_name' },
          { key: 'agenda_name' },
          { key: 'decision' },
          { key: 'attendance_attachment' },
          { key: 'document_attachment' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('committee.generate_circulate_entry') : this.$t('committee.generate_circulate_modify')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, manageAgendaToggleStatus, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, meetingMinuteList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const orgObj = this.$store.state.CommonService.commonObj.orgProfileList.find(org => org.value === parseInt(item.org_id))
          const cmtObj = this.$store.state.CommonService.commonObj.committeeList.find(cmt => cmt.value === parseInt(item.cmt_committee_id))
          const agendaObj = this.$store.state.CommonService.commonObj.agendaList.find(cmt => cmt.value === parseInt(item.cmt_agenda_id))

          const orgData = {}
          if (typeof orgObj !== 'undefined') {
            orgData.org_name = orgObj.text_en
            orgData.org_name_bn = orgObj.text_bn
          } else {
            orgData.org_name = ''
            orgData.org_name_bn = ''
          }

          const cmtData = {}
          if (typeof cmtObj !== 'undefined') {
            cmtData.cmt_name = cmtObj.text_en
            cmtData.cmt_name_bn = cmtObj.text_bn
          } else {
            cmtData.cmt_name = ''
            cmtData.cmt_name_bn = ''
          }

          const agendaData = {}
          if (typeof agendaObj !== 'undefined') {
            agendaData.agenda_name = agendaObj.text_en
            agendaData.agenda_name_bn = agendaObj.text_bn
          } else {
            agendaData.agenda_name = ''
            agendaData.agenda_name_bn = ''
          }
          return Object.assign({}, item, { serial: index + 0 }, orgData, cmtData, agendaData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    remove (item) {
      this.changeStatus(1, commonServiceBaseUrl, manageAgendaToggleStatus, item)
    }
  }
}
</script>

<style>
.btn-success {
  background-color: var(--success) !important;
  border-color: var(--success);
}
</style>
