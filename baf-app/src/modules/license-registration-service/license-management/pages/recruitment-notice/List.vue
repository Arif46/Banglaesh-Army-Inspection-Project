<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('license_management.recruitment_notice') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="memorial_no">
              <template v-slot:label>
                {{ $t('license_management.memorial_no') }}
              </template>
              <b-form-input
                  id="memorial_no"
                  v-model="search.memorial_no"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Application Start Date"
            >
              <template v-slot:label>
                {{ $t('license_management.start_date') }}
              </template>
              <date-picker
                id="start_date"
                v-model="search.start_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                :config="{ static: true }"
                >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Application End Date"
            >
              <template v-slot:label>
                {{ $t('license_management.end_date') }}
              </template>
              <date-picker
                id="end_date"
                v-model="search.end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                :config="{ static: true }"
                >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col sm="9">
          </b-col>
          <b-col sm="3" style="text-align: right;">
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
        <h4 class="card-title">{{ $t('license_management.recruitment_notice') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial +1) }}
                  </template>
                  <template v-slot:cell(approve_status)="data">
                    {{ getApproveStatusLicense(data.item.approve_status) }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-success" v-if="data.item.status == 1">{{$t('globalTrans.active')}}</span>
                    <span class="badge badge-danger" v-else>{{$t('globalTrans.inactive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-if="(actions.edit && data.item.approve_status === 1)" v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="editMethodInParent(data.item,1)" class="action-btn edit" :title="$t('globalTrans.edit')"><i class="ri-pencil-fill"></i></b-button>
                    <b-button v-if="actions.toogle" :variant="data.item.status === 1 ? ' btn-danger' : ' btn-success'" size="sm" class="action-btn status" :title="data.item.status === 1 ? $t('globalTrans.inactive') : $t('globalTrans.active')" @click="editMethodInParent(data.item,2)">
                      <i :class="data.item.status === 2  ? 'ri-toggle-line' : 'ri-toggle-fill'"></i>
                    </b-button>
                    <b-button v-if="data.item.approve_status === 1" variant="iq-bg-success mr-1" size="sm"  @click="publishNotice(data.item)" class="action-btn active" :title="$t('globalTrans.publish')"><i class="ri-check-fill"></i></b-button>
                    <b-button v-b-modal.modal-form-details variant="iq-bg-success mr-1" size="sm"  @click="details(data.item)" class="action-btn active" :title="$t('globalTrans.view')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-form-details" size="lg" :title="detailsTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId" :item="item" />
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { recruitmentList, recruitmentToggle, recruitmentApproveStatus } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import { helpers } from '@/utils/helper-functions'
import { dateFormatBn, dateFormatEn } from '@/utils/fliter'
import Store from '@/store'
import Details from './Details.vue'
// import { helpers } from '@/utils/helper-functions'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        org_id: 8,
        limit: 10,
        memorial_no: '',
        start_date: '',
        end_date: ''
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1 },
        { labels: 'license_management.title', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'license_management.memorial_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'license_management.notice_date', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'license_management.start_date', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'license_management.end_date', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'license_management.approve_status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'globalTrans.status', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 8 },
        { labels: 'globalTrans.action', class: 'text-center', sortable: true, stickyColumn: false, show: '1', order: 9 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      },
      item: ''
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
          { key: 'title_bn' },
          { key: 'memo_bn' },
          { key: 'notice_date_bn' },
          { key: 'start_date_bn' },
          { key: 'end_date_bn' },
          { key: 'approve_status' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'title_en' },
          { key: 'memorial_no' },
          { key: 'notice_date_en' },
          { key: 'start_date_en' },
          { key: 'end_date_en' },
          { key: 'approve_status' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    detailsTitle () {
      return this.$t('portal.recruitment_notice') + ' ' + this.$t('globalTrans.details')
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('license_management.create_recruitment_notice') + ' ' + this.$t('globalTrans.entry') : this.$t('license_management.create_recruitment_notice') + ' ' + this.$t('globalTrans.modify')
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    }
  },
  methods: {
    details (item) {
      this.editItemId = item.id
      this.item = item
    },
    changePublishStatus (baseUrl, uri, item, destination = null, dropdownName = null) {
      Store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      RestApi.deleteData(baseUrl, `${uri}/${item.id}`).then(response => {
      if (response.success) {
          if (response.notification) {
            this.$socket.emit('send-notification', response.notification)
          }
          if (destination !== null && dropdownName !== null) {
          Store.dispatch('toggleDropdownItemStatus', { itemId: item.id, destination: destination, dropdownName: dropdownName })
          }
          window.vm.$toast.success({
          title: this.$t('globalTrans.success'),
          message: 'Recruitment Notice Published Successfully',
          color: '#D6E09B'
          })
      } else {
          window.vm.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
          })
      }
      Store.dispatch('mutateCommonProperties', { loading: false, listReload: true })
      })
    },
    publishNotice (item) {
        window.vm.$swal({
          title: window.vm.$t('license_management.noticePublishStatus'),
          showCancelButton: true,
          confirmButtonText: window.vm.$t('globalTrans.yes'),
          cancelButtonText: window.vm.$t('globalTrans.no'),
          focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
              this.changePublishStatus(licenseRegistrationServiceBaseUrl, recruitmentApproveStatus, item)
            }
        })
    },
    getApproveStatusLicense (status) {
      if (status === 2) {
        return this.$i18n.locale === 'bn' ? 'হ্যাঁ' : 'Yes'
      } else {
        return this.$i18n.locale === 'bn' ? 'না' : 'No'
      }
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(8, licenseRegistrationServiceBaseUrl, recruitmentToggle, item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, recruitmentList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
           return Object.assign({}, item, { serial: index, memo_bn: helpers.convertEnglishToBanglaNumber(item.memorial_no), notice_date_bn: dateFormatBn(item.notice_date), notice_date_en: dateFormatEn(item.notice_date), start_date_bn: dateFormatBn(item.start_date), start_date_en: dateFormatEn(item.start_date), end_date_bn: dateFormatBn(item.end_date), end_date_en: dateFormatEn(item.end_date) })
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
