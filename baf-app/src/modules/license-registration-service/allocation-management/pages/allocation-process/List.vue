<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_management.allocation_process') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="org_id">
              <template v-slot:label>
                {{ $t('manage_information.regional_office') }}
              </template>
              <b-form-select
                plain
                id="org_id"
                :options="officeList"
                v-model="search.office_id"
                :disabled="lock_office"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="org_id">
              <template v-slot:label>
                {{ $t('globalTrans.district') }}
              </template>
              <b-form-select
                plain
                id="district_id"
                :options="districtList"
                v-model="search.district_id"
                :disabled="false"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Mobile No"
            >
              <template v-slot:label>
                {{ $t('userManagement.mobile_no') }}
              </template>
              <b-form-input
                  id="mobile_no"
                  type="text"
                  v-model="search.mobile_no"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="Item Name"
            >
              <template v-slot:label>
                {{ $t('license_management.agreement_no') }}
              </template>
              <b-form-input
                  id="agreement_no"
                  type="text"
                  v-model="search.agreement_no"
              ></b-form-input>
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
        <h4 class="card-title">{{ $t('dealer.dealer_list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <select-column-check v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :search="search" :columns="columns" />
          <b-row>
            <b-col md="12" class="table-responsive">
              <slot v-if ="columns.filter(item => item.show === '1').length > 0">
                <b-table :sort-by.sync="sortBy" head-variant="primary" class="tg" :items="listData" :emptyText="$t('globalTrans.noDataFound')" show-empty bordered hover :fields="columns.filter(item => item.show === '1').sort((a, b) => { return a.order - b.order })" :tbody-tr-class="rowClass">
                  <template v-slot:cell(serial)="data">
                    {{ $n(data.item.serial + pagination.slOffset) }}
                  </template>
                  <template v-slot:cell(agreement_no)="data">
                    {{ $n(data.item.agreement_no, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(mobile)="data">
                    {{ $n(data.item.details.mobile, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(agreement_date)="data">
                    {{ data.item.first_agreement_date | dateFormat }}
                  </template>
                  <template v-slot:cell(renew_date)="data">
                    <span v-if="data.item.type === 2">
                      {{ data.item.agreement_date | dateFormat }}
                    </span>
                  </template>
                  <template v-slot:cell(expire_date)="data">
                    {{ data.item.expire_date | dateFormat }}
                  </template>
                  <template v-slot:cell(action)="data">
                    <router-link class="action-btn active view" variant=" iq-bg-success mr-1" :title="$t('allocation_management.allocate')" :to="`/license-registration-service/allocation-management/allocation-process-form/${data.item.id}`"><i class="ri-add-fill"></i></router-link>
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
import { allocationProcessList } from '../../api/routes'
import RouteBaseMasterList from '@/mixins/route-based-list'

export default {
  mixins: [RouteBaseMasterList],
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      districtList: [],
      lock_office: false,
      search: {
        office_id: 0,
        district_id: 0,
        mobile_no: '',
        agreement_no: '',
        org_id: 7,
        limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'allocation_management.dealer_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2 },
        { labels: 'globalTrans.district', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3 },
        { labels: 'dealer.dealer_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4 },
        { labels: 'dealer.company_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5 },
        { labels: 'globalTrans.address', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6 },
        { labels: 'dealer.mobile', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7 },
        { labels: 'license_management.agreement_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8 },
        { labels: 'license_management.agreement_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 9 },
        { labels: 'tcb_report.renew_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 10 },
        { labels: 'externalLrcpn.expire_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 11 },
        { labels: 'license_config.distance', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 12 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 13 }
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
    if (!(this.$store.state.Auth.authUser.user_id === 1 || this.$store.state.Auth.authUser.org_admin === 2)) {
      this.search.office_id = this.$store.state.Auth.authUser.office_detail.office_id
    }
    this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => item.value === newVal)
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
          { key: 'dealer_type_bn' },
          { key: 'district_bn' },
          { key: 'dealer_name_bn' },
          { key: 'company_name_bn' },
          { key: 'address_bn' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'agreement_date' },
          { key: 'renew_date' },
          { key: 'expire_date' },
          { key: 'distance_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'dealer_type_en' },
          { key: 'district_en' },
          { key: 'dealer_name_en' },
          { key: 'company_name_en' },
          { key: 'address_en' },
          { key: 'mobile' },
          { key: 'agreement_no' },
          { key: 'first_agreement_date' },
          { key: 'renew_date' },
          { key: 'expire_date' },
          { key: 'distance_en' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return this.$t('allocation_management.allocation_letter') + ' ' + this.$t('globalTrans.entry')
    },
    sellerTypeList () {
      return this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList
    },
    distanceList () {
      return this.$store.state.LicenseRegistrationService.commonObj.distanceList
    },
    officeList () {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    auth () {
      return this.$store.state.Auth
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allocationProcessList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const distance = this.distanceList.find(law => law.value === parseInt(item.distance_id))
          const distanceData = { distance_en: distance !== undefined ? distance.text_en : '', distance_bn: distance !== undefined ? distance.text_bn : '' }
          const sellerType = this.sellerTypeList.find(law => law.value === parseInt(item.dealer_type))
          const sellerData = { dealer_type_en: sellerType !== undefined ? sellerType.text_en : '', dealer_type_bn: sellerType !== undefined ? sellerType.text_bn : '' }
          const districtObj = this.$store.state.CommonService.commonObj.districtList.find(district => district.value === parseInt(item.details.district_id))
          const districtData = { district_en: districtObj !== undefined ? districtObj.text_en : '', district_bn: districtObj !== undefined ? districtObj.text_bn : '' }
          const applicantData = {
            dealer_name_en: item.details.applicant_name,
            dealer_name_bn: item.details.applicant_name_bn,
            company_name_en: item.details.company_name,
            company_name_bn: item.details.company_name_bn,
            address_en: item.details.village,
            address_bn: item.details.village_bn
          }
          return Object.assign({}, item, { serial: index }, distanceData, sellerData, applicantData, districtData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    rowClass (item, type) {
        if (!item || type !== 'row') return
        if (item.cancel_count > 2) return 'table-danger'
    }
  }
}
</script>
