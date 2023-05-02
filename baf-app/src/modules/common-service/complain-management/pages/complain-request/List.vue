<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('complain_management.complain_request') }}</h4>
      </template>
      <template v-slot:searchBody>
       <b-row>
          <b-col sm="3">
            <b-form-group
              label-for="org_id"
            >
            <template v-slot:label>
              {{$t('organogram.org')}}
            </template>
            <b-form-select
              plain
              v-model="search.org_id"
              :options="orgList"
              id="org_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="service_id"
            >
            <template v-slot:label>
              {{$t('menu.service')}}
            </template>
            <b-form-select
              plain
              v-model="search.service_id"
              :options="serviceList"
              id="service_id"
            >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
            </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="division_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.division')}}
              </template>
              <b-form-select
                plain
                v-model="search.division_id"
                :options="divisionList"
                id="division_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="district_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.district')}}
              </template>
              <b-form-select
                plain
                v-model="search.district_id"
                :options="districtList"
                id="district_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="upazila_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.upazila')}}
              </template>
              <b-form-select
                plain
                v-model="search.upazila_id"
                :options="upazilaList"
                id="upazila_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="union_id"
              >
              <template v-slot:label>
                {{$t('orgProfile.union')}}
              </template>
              <b-form-select
                plain
                v-model="search.union_id"
                :options="unionList"
                id="union_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button size="sm" variant="primary" @click="searchData" class="mt-3">
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
        <h4 class="card-title">{{ $t('complain_management.complain_request') + ' ' + $t('globalTrans.list')}}</h4>
      </template>
      <template v-slot:headerAction>
        <!-- <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a> -->
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col sm="12">
              <div class="quick-filter-wrapper">
                <div class="quick-filter-left">
                  <b-dropdown split split-variant="outline-secondary" size="sm" id="dropdown-form" :text="$t('globalTrans.column_visibility')" ref="dropdown">
                    <b-dropdown-form>
                      <div
                        class="form-group"
                        v-for="(field, index) in labelData"
                        :key="index"
                        >
                          <b-form-checkbox
                            :id="'checkbox-' + field.label_en"
                            v-model="field.show"
                            :name="'checkbox-' + field.label_en"
                            value=1
                            unchecked-value=0
                          >
                            {{ ($i18n.locale==='bn') ? field.label_bn : field.label_en }}
                          </b-form-checkbox>
                      </div>
                    </b-dropdown-form>
                  </b-dropdown>
                </div>
                <div class="quick-filter-right">
                  <b-form-group
                    :label="$t('menu.perpage')"
                    label-for="per-page-select"
                  >
                    <b-form-select
                      id="per-page-select"
                      v-model="search.limit"
                      :options="pageOptions"
                      size="sm"
                    ></b-form-select>
                  </b-form-group>
                </div>
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <!-- <b-button v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button> -->
                    <!-- <b-button variant=" iq-bg-danger" size="sm" @click="remove(data.item)" class="action-btn delete" :title="$t('globalTrans.delete')"><i class="ri-delete-bin-2-line"></i></b-button> -->
                    <b-button class="mr-1" title="View Complain" v-b-modal.modal-5 variant="action-btn status mr-1" size="sm" @click="edit(data.item)"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status !== 3 && data.item.status !== 4 && data.item.status !== 6" class="mr-1"  title="Add Committee" v-b-modal.modal-6 variant=" action-btn bg-primary" size="sm" @click="addCommittee(data.item)"><i class="ri-add-line m-0 "></i></b-button>
                    <b-button v-if="data.item.status !== 3 && data.item.status !== 4 && data.item.status !== 6" class="mr-1" title="Complain Report" v-b-modal.modal-4 variant="action-btn bg-success mr-1" size="sm" @click="edit(data.item)"><i class="ri-edit-line"></i></b-button>
                    <b-button v-if="data.item.status !== 3 && data.item.status !== 4 && data.item.status !== 6" class="mr-1" title="Approve" v-b-modal.modal-1 variant="action-btn bg-primary mr-1" size="sm" @click="edit(data.item)"><i class="ri-check-line"></i></b-button>
                    <b-button v-if="data.item.status !== 3 && data.item.status !== 4 && data.item.status !== 6" title="Reject" v-b-modal.modal-2 variant="action-btn bg-danger mr-1" size="sm" @click="reject(data.item)"><i class="ri-close-line"></i></b-button>
                    <b-button v-if="data.item.status !== 3 && data.item.status !== 4 && data.item.status !== 6" title="Send Compalin" v-b-modal.modal-send variant=" action-btn bg-info mr-1" size="sm" @click="sendComplain(data.item)"><i class="ri-send-plane-fill"></i></b-button>
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
    <!-- <b-modal id="modal-form" size="md" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal> -->
       <b-modal  id="modal-1" size="md" :title="$t('complain_management.complain_approve')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <ApproveModal :id="editItemId"/>
    </b-modal>
    <b-modal  id="modal-2" size="md" :title="$t('complain_management.complain_reject')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <RejectModal :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-4" size="md" :title="$t('complain_management.complain_report')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <ReportModal :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-5" size="xl" :title="$t('complain_management.complain_info_detail')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <DetailModal :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-6" size="xl" :title="$t('complain_management.committee_list')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <AddCommitteeModal :id="editItemId"/>
    </b-modal>
    <b-modal id="modal-send" size="md" :title="$t('complain_management.send_complain')" :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
        <SendModal :complainId="editItemId"/>
    </b-modal>
  </div>
</template>
<style scoped>
table#table-transition-example .flip-list-move {
  transition: transform 1s;
}
</style>
<script>
// import Form from './Form.vue'
import DetailModal from './DetailModal'
import ReportModal from './ReportSubmit'
import ApproveModal from './ApproveModal'
import RejectModal from './RejectModal'
import AddCommitteeModal from './AddCommittee'
import SendModal from './SendModal'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import { complainDesignationList, complainDesignationToggle } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import i18n from '@/i18n'

const defaultColumn = [
  { label_en: i18n.messages.en.globalTrans.sl_no, label_bn: i18n.messages.bn.globalTrans.sl_no, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '8%' } },
  { label_en: i18n.messages.en.globalTrans.organization, label_bn: i18n.messages.bn.globalTrans.organization, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '30%' } },
  { label_en: i18n.messages.en.menu.service, label_bn: i18n.messages.bn.menu.service, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.complain_management.complain_title, label_bn: i18n.messages.bn.complain_management.complain_title, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
  { label_en: i18n.messages.en.globalTrans.status, label_bn: i18n.messages.bn.globalTrans.status, class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
  { label_en: i18n.messages.en.globalTrans.action, label_bn: i18n.messages.bn.globalTrans.action, class: 'text-center', show: '1', order: 8, thStyle: { width: '25%' } }
]
export default {
  mixins: [ModalBaseMasterList],
  components: {
    // Form,
    DetailModal,
    ReportModal,
    RejectModal,
    ApproveModal,
    AddCommitteeModal,
    SendModal
  },
  data () {
    return {
      transProps: {
        name: 'flip-list'
      },
      sortBy: '',
      search: {
        org_id: 0,
        service_id: 0,
        division_id: 0,
        district_id: 0,
        upazila_id: 0,
        union_id: 0,
        limit: 20
      },
      districtList: [],
      upazilaList: [],
      unionList: [],
      sortDesc: true,
      sortDirection: 'desc',
      labelData: []
    }
  },
  created () {
    this.labelData = this.labelList
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.getDistrictList()
      }
    },
    'search.district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.upazilaList = this.getUpazilaList()
      }
    },
    'search.upazila_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.unionList = this.getUnionList()
      }
    }
  },
  computed: {
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    serviceList () {
      return this.$store.state.CommonService.commonObj.serviceList.filter(item => item.status === 1).map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    divisionList () {
      return this.$store.state.CommonService.commonObj.divisionList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    labelList: function () {
      const dataList = defaultColumn
      return dataList.map(item => {
        if (this.$i18n.locale === 'bn') {
          const data = { value: item.label_en, text: item.label_bn }
          return Object.assign({}, item, data)
        } else {
          const data = { value: item.label_en, text: item.label_en }
          return Object.assign({}, item, data)
        }
      })
    },
    columns () {
      const labelData = this.labelData
      const labels = labelData.map((item, index) => {
        const labelData = {}
        labelData.label = this.$i18n.locale === 'bn' ? item.label_bn : item.label_en
        return Object.assign(item, labelData)
      })
      let keys = []
      if (this.$i18n.locale === 'bn') {
        keys = [
       { key: 'serial' },
          { key: 'com_title_bn' },
          { key: 'org_name_bn' },
          { key: 'service_name_bn' },
          { key: 'status_name_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'com_title' },
          { key: 'org_name' },
          { key: 'service_name' },
          { key: 'status_name' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('notification.notification_type') + ' ' + this.$t('globalTrans.entry') : this.$t('notification.notification_type') + ' ' + this.$t('globalTrans.modify')
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    edit (item) {
      this.editItemId = item.id
    },
    reject (item) {
      this.editItemId = item.id
    },
    sendComplain (item) {
      this.editItemId = item.id
    },
    addCommittee (item) {
      this.editItemId = item.id
    },
       editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(1, commonServiceBaseUrl, complainDesignationToggle, item)
      }
    },
     getDistrictList () {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.division_id === this.search.division_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUpazilaList () {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.district_id === this.search.district_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    getUnionList () {
      return this.$store.state.CommonService.commonObj.unionList.filter(item => item.division_id === this.search.division_id && item.district_id === this.search.district_id && item.upazila_id === this.search.upazila_id).map(obj => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(commonServiceBaseUrl, complainDesignationList, params)
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
    }
    // async loadData () {
    //   const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
    //   const result = await RestApi.getData(commonServiceBaseUrl, complainDesignationList, params)
    //   if (result.success) {
    //     this.$store.dispatch('addComplainRequestList', this.getRelationalData(result.data.data))
    //     this.paginationData(result.data)
    //   }
    //   this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    // },
    // getRelationalData (data) {
    //     const statusList = this.$store.state.commonObj.comStatusList
    //     return data.map(item => {
    //       const statusObj = statusList.find(statusItem => statusItem.id === item.status)
    //       const statusData = {
    //         status_name: statusObj.name,
    //         status_name_bn: statusObj.name_bn
    //       }
    //       return Object.assign({}, item, statusData)
    //     })
    // }
  }
}
</script>
