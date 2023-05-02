<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('license_management.application') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
         <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
                label-for="application_id"
                >
                <template v-slot:label>
                    {{ $t('globalTrans.application_id') }}
                </template>
                <b-form-input
                    id="application_id"
                    v-model="search.application_id"
                    >
                    </b-form-input>
                </b-form-group>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
                label-for="from_date"
                >
                <template v-slot:label>
                    {{ $t('globalTrans.from_date') }}
                </template>
                <date-picker
                  id="from_date"
                  v-model="search.from_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                >
                </date-picker>
                </b-form-group>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
                <b-form-group
                label-for="to_date"
                >
                <template v-slot:label>
                    {{ $t('globalTrans.to_date') }}
                </template>
                <date-picker
                  id="to_date"
                  v-model="search.to_date"
                  class="form-control"
                  :placeholder="$t('globalTrans.select_date')"
                >
                </date-picker>
                </b-form-group>
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
        <h4 class="card-title">{{ $t('license_management.application_list') }}</h4>
      </template>
      <template v-slot:headerAction>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
            <div class="row">
              <div class="col-md-4">
                <b-form-checkbox
                class="mb-2"
                  v-model="search.select"
                  @change="checkAll($event)"
                > <span class="badge badge-success">{{ $t('license_management.check_all') }}</span>
                </b-form-checkbox>
              </div>
              <div class="col-md-8 text-right">
                {{ $t('license_management.selected_applications') }} :
                <span v-if="applications.length">
                  <span v-for="(app, index) in applications" :key="index" class="ml-2 badge badge-success"> {{ $n(app.application_id, { useGrouping: false }) }}</span>
                </span>
                <span v-else>({{ $t('license_management.empty') }})</span>
              </div>
            </div>
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" :sort-desc.sync="sortDesc" :sort-direction="sortDirection" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })">
                  <template v-slot:cell(select)="data">
                      <b-form-checkbox
                        v-model="data.item.select"
                        @change="checkApplication(data.item)"
                      >
                      </b-form-checkbox>
                    </template>
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(application_id)="data">
                    {{ $n(data.item.application_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(date)="data">
                    {{ data.item.created_at | dateFormat }}
                  </template>
                  <template v-slot:cell(applicant_name)="data">
                    {{ data.item.details.applicant_name }}
                  </template>
                  <template v-slot:cell(applicant_name_bn)="data">
                    {{ data.item.details.applicant_name_bn }}
                  </template>
                  <template v-slot:cell(mobile)="data">
                    {{ data.item.details.mobile | mobileNumber }}
                  </template>
                  <template v-slot:cell(district_id)="data">
                    {{ getDistrictName(data.item.details.company_district_id) }}
                  </template>
                  <template v-slot:cell(type)="data">
                    {{ getTypeName(data.item.type) }}
                  </template>
                  <template v-slot:cell(status)>
                    <span class="badge badge-primary">{{$t('globalTrans.archive')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn btn-warning view" :title="$t('globalTrans.view')" :to="`/license-registration-service/license-management/application-show/${data.item.id}`"><i class="ri-eye-fill"></i></router-link>
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
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { tcbArchiveList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      applications: [],
      search: {
       application_id: '',
       from_date: '',
       to_date: '',
       office_id: '',
       limit: 10
      },
      labelData: [
        { labels: 'globalTrans.select', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'dealer.applicant_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'dealer.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'globalTrans.type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 8, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: false,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.search.office_id = this.$store.state.Auth.authUser.office_detail.office_id
    }
    this.loadData()
  },
  mounted () {
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    loggedUserPrivilege: function () {
      return this.$store.state.BazarMonitoringService.commonObj.loggedUserPrivilege
    },
    addressCustomUser: function () {
      return this.$store.state.BazarMonitoringService.commonObj.addressCustomUser
    },
    areaTypeList: function () {
      const list = this.$store.state.commonObj.areaTypeList
      return list.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    },
    divisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
          { key: 'select' },
          { key: 'serial' },
          { key: 'date' },
          { key: 'application_id' },
          { key: 'applicant_name_bn' },
          { key: 'mobile' },
          { key: 'district_id' },
          { key: 'type' },
          { key: 'status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'select' },
          { key: 'serial' },
          { key: 'date' },
          { key: 'application_id' },
          { key: 'applicant_name' },
          { key: 'mobile' },
          { key: 'district_id' },
          { key: 'type' },
          { key: 'status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    }
  },
  methods: {
    clickForward () {
      const appIds = this.applications.map(item => {
        return item.id
      })
      this.$router.push({
        path: '/license-registration-service/license-management/forward',
        query: { applications: JSON.stringify(appIds) }
      })
    },
    checkApplication (value) {
      if (value.select) {
        this.applications.push({
          application_id: value.application_id,
          id: value.id
        })
      } else {
        this.applications = this.applications.filter(item => {
          return item.application_id !== value.application_id
        })
      }
    },
    checkAll (value) {
      if (value) {
        this.listData.map(item => {
          return Object.assign(item, { select: true })
        })
        const applications = this.listData.map(item => {
          return { application_id: item.application_id, id: item.id }
        })
        this.applications = applications
      } else {
        this.applications = []
        this.listData.map(item => {
          return Object.assign(item, { select: false })
        })
      }
    },
    editMethodInParent (item, type) {
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, tcbArchiveList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          return Object.assign({}, item, { serial: index, select: 0 })
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getDistrictName (id) {
      const data = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
    },
    getTypeName (id) {
      const data = this.$store.state.LicenseRegistrationService.commonObj.applicationTypeList.find(item => item.value === id)
      if (typeof data !== 'undefined') {
        return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
      } else {
        return ''
      }
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
