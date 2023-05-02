<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('research_execution.approved_document') }} {{ $t('globalTrans.search') }}</h4>
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
            <ValidationProvider name="Topic" vid="topic" v-slot="{ errors }">
              <b-form-group
                label-for="topic">
                <template v-slot:label>
                  {{ $t('bfti.topic') }}
                </template>
                <b-form-input
                  id="topic"
                  v-model="search.topic"
                  :placeholder="$t('bfti.topic')"
                  :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-input>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4">
            <ValidationProvider name="Organization/Ministry/Division (En)" vid="organization_ministry_division" v-slot="{ errors }">
              <b-form-group
                label-for="organization_ministry_division">
                <template v-slot:label>
                  {{ $t('research_plan_management.organization_ministry_division') }}
                </template>
                <b-form-input
                  id="organization_ministry_division"
                  v-model="search.organization_ministry_division"
                  :placeholder="$t('research_plan_management.organization_ministry_division')"
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
        <h4 class="card-title">{{ $t('research_execution.approved_document') }} {{ $t('globalTrans.list') }}</h4>
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
                      {{ ($i18n.locale === 'bn') ? data.item.research.topic: data.item.research.topic }}
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
                  <template v-slot:cell(document_approve_status)="data">
                    <span class="badge badge-primary" v-if="data.item.document_approve_status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-info" v-else-if="data.item.document_approve_status == 2">{{$t('globalTrans.submitted')}}</span>
                    <slot v-if="data.item.document_type_id != 4">
                      <span class="badge badge-success" v-if="data.item.document_approve_status == 3">{{$t('research_execution.awarded')}}</span>
                      <span class="badge badge-danger" v-if="data.item.document_approve_status == 4">{{$t('research_execution.non_awarded')}}</span>
                    </slot>
                    <span class="badge badge-warning" v-else-if="data.item.document_approve_status == 5">{{$t('research_execution.cancelled')}}</span>
                  </template>
                  <template v-slot:cell(document_action)="data">
                    <b-button v-b-modal.modal-submit variant=" iq-bg-info mr-1" size="sm" @click="edit(data.item)" class="badge badge-success" :title="$t('globalTrans.submit')" :disabled="data.item.document_approve_status >=2">{{$t('globalTrans.submit')}}</b-button>
                    <b-button v-if="data.item.document_type_id != 4" v-b-modal.modal-awarded variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="badge badge-info" :title="$t('research_execution.awarded')" :disabled="data.item.document_approve_status >=3">{{$t('research_execution.awarded')}}</b-button>
                    <b-button v-if="data.item.document_type_id != 4" v-b-modal.modal-nonAwarded variant=" iq-bg-primary mr-1" size="sm" @click="edit(data.item)" class="badge badge-primary" :title="$t('research_execution.non_awarded')" :disabled="data.item.document_approve_status >=3">{{$t('research_execution.non_awarded')}}</b-button>
                    <b-button v-b-modal.modal-cancel variant=" iq-bg-danger mr-1" size="sm" @click="edit(data.item)" class="badge badge-danger" :title="$t('globalTrans.cancel')" :disabled="data.item.document_approve_status >=3">{{$t('globalTrans.cancel')}}</b-button>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-detail variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn active view" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-detail" size="lg" :title="$t('research_plan_management.assign_task_coordinator') + ' ' + $t('globalTrans.details')"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Detail :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-nonAwarded" size="lg" :title="formNonAwarded"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <NAwarded :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-awarded" size="lg" :title="formAwarded"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Award :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-submit" size="lg" :title="formSubmit"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Submt :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-cancel" size="lg" :title="formCancel"  hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Cancel :id="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import NAwarded from '../research-document-upload/NAwarded.vue'
import Award from '../research-document-upload/Award.vue'
import Cancel from '../research-document-upload/Cancel.vue'
import Submt from '../research-document-upload/Submt.vue'
import Detail from '../research-document-upload/Detail.vue'
import RestApi, { bftiResReportServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { researchDocumentApprovedList, assignTaskCoordinatorToggle, userListByDesignWise } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    NAwarded, Award, Cancel, Submt, Detail
  },
  data () {
    return {
      sortBy: '',
      search: {
        document_type_id: 0,
        topic: '',
        end_date: '',
        limit: 10,
        assignTaskCoordinator_name: ''
      },
      allDesignationList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'configuration.document_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'bfti.topic', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'research_plan_management.organization_ministry_division', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'research_plan_management.assign_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'research_execution.document_status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '20%' } },
        { labels: 'research_execution.document_action', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '15%' } },
        { labels: 'globalTrans.action', class: 'text-left', show: '1', order: 8 }
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
          { key: 'organization_ministry_division_bn' },
          { key: 'assign_date' },
          { key: 'document_approve_status' },
          { key: 'document_action' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'document_type' },
          { key: 'title' },
          { key: 'organization_ministry_division' },
          { key: 'assign_date' },
          { key: 'document_approve_status' },
          { key: 'document_action' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('research_execution.approved_document') + ' ' + this.$t('globalTrans.entry') : this.$t('research_execution.approved_document') + ' ' + this.$t('globalTrans.modify')
    },
    formNonAwarded () {
      return this.$t('research_execution.document_non_award') + ' ' + this.$t('globalTrans.entry')
    },
    formAwarded () {
      return this.$t('research_execution.document_award') + ' ' + this.$t('globalTrans.entry')
    },
    formSubmit () {
      return this.$t('research_execution.document_submit') + ' ' + this.$t('globalTrans.entry')
    },
    formCancel () {
      return this.$t('research_execution.document_cancel') + ' ' + this.$t('globalTrans.entry')
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(bftiResReportServiceBaseUrl, assignTaskCoordinatorToggle, item)
      }
    },
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
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      const result = await RestApi.getData(bftiResReportServiceBaseUrl, researchDocumentApprovedList, params)
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
          return Object.assign({}, item, { serial: index }, documentTypeData, designatonData)
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
