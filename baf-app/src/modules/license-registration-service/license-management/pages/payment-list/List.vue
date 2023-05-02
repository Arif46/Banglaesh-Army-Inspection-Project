<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('license_management.payment') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4" vid="payment_type">
            <b-form-group
              label-for="payment_type"
              >
                <template v-slot:label>
                  {{ $t('dealer.payment_type') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="payment_type"
                  :options="paymentTypeList"
                  v-model="search.payment_type"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
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
        <h4 class="card-title">{{ $t('license_management.payment') }} {{ $t('globalTrans.list')}}</h4>
      </template>
      <template v-slot:headerAction>
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
                  <template v-slot:cell(applicationId)="data">
                    {{ data.item.applications  === null ? '' : $n(data.item.applications.application_id, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(payment_type)="data">
                    {{ getPaymentList(data.item.payment_type) }}
                  </template>
                  <template v-slot:cell(paid_type)="data">
                    {{ getPaidType(data.item.paid_type) }}
                  </template>
                  <template v-slot:cell(amount)="data">
                    {{ $n(data.item.amount, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(applicant_name)="data">
                    {{ data.item.applications  === null ? '' : data.item.applications.details.applicant_name }}
                  </template>
                  <template v-slot:cell(applicant_name_bn)="data">
                    {{ data.item.applications !== null ? data.item.applications.details.applicant_name_bn : '' }}
                  </template>
                  <template v-slot:cell(type)="data">
                    {{ getTypeName(data.item.type) }}
                  </template>
                  <template v-slot:cell(pay_status)>
                    <span class="badge badge-primary">{{$t('globalTrans.success')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <slot v-if="data.item.applications">
                      <span v-if="data.item.applications.status === 4 && data.item.applications.pay_status === 0" v-b-modal.payment @click="paymentCom(data.item)" class="badge badge-warning">{{ $t('license_management.agreement')}} {{ $t('dealer.pay') }}</span>
                      <!-- <span v-if="data.item.applications.status === 4 && data.item.applications.pay_status > 0" v-b-modal.receipt @click="receiptPayment(data.item)" class="badge badge-success">{{ $t('dealer.receipt') }}</span> -->
                      <span v-if="data.item.applications.status === 4 && data.item.applications.pay_status > 0" class="badge badge-success">{{ $t('globalTrans.paid') }}</span>
                      <span v-else class="badge badge-info">{{ $t('license_management.application_fee') }} {{ $t('globalTrans.paid')}}</span>
                    </slot>
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
    <b-modal id="payment" size="lg" :title="$t('dealer.payment')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Payment :application="item"  :key="editItemId"/>
    </b-modal>
    <b-modal id="receipt" size="lg" :title="$t('dealer.receipt')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Receipt :application="item" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Payment from './Payment.vue'
import Receipt from './Receipt.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allPaymentLIst, adminTcbPaymentStatusUpdate } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import userTypeModule from '@/utils/userType'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Payment,
    Receipt
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      item: '',
      editItemId: '',
      search: {
       payment_type: 0,
       from_date: '',
       to_date: '',
       limit: 10
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.application_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '10%' } },
        { labels: 'dealer.applicant_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '10%' } },
        { labels: 'dealer.payment_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '10%' } },
        { labels: 'license_management.amount', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '5%' } },
        { labels: 'license_management.paid_type', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 6, thStyle: { width: '10%' } },
        { labels: 'license_management.transaction_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 7, thStyle: { width: '10%' } },
        { labels: 'globalTrans.status', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 8, thStyle: { width: '10%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9, thStyle: { width: '10%' } }
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
    this.adminPaymentStatusUpdate()
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
          { key: 'serial' },
          { key: 'applicationId' },
          { key: 'applicant_name_bn' },
          { key: 'payment_type' },
          { key: 'amount' },
          { key: 'paid_type' },
          { key: 'transaction_no' },
          { key: 'pay_status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'applicationId' },
          { key: 'applicant_name' },
          { key: 'payment_type' },
          { key: 'amount' },
          { key: 'paid_type' },
          { key: 'transaction_no' },
          { key: 'pay_status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.entry') : this.$t('orgProfile.org_profile') + ' ' + this.$t('globalTrans.modify')
    },
    paymentTypeList () {
      const paymentlist = this.$store.state.LicenseRegistrationService.commonObj.adminPaymentTypeList
      return paymentlist.map((obj, key) => {
        if (this.$i18n.locale === 'bn') {
          return { value: obj.value, text: obj.text_bn }
        } else {
          return { value: obj.value, text: obj.text_en }
        }
      })
    }
  },
  methods: {
    paymentCom (item) {
      this.item = item
    },
    receiptPayment (item) {
      this.item = item
    },
    getPaidType (status) {
      if (status === 1) {
        return this.$i18n.locale === 'bn' ? 'অনলাইন' : 'Online'
      } else if (status === 2) {
        return this.$i18n.locale === 'bn' ? 'অফলাইন' : 'Offline'
      }
    },
    getPaymentList (type) {
      if (type === 1) {
        return this.$i18n.locale === 'bn' ? 'আবেদন ফি' : 'Registration Fee'
      } else if (type === 2) {
        return this.$i18n.locale === 'bn' ? 'নিরাপত্তার ফি' : 'Security Money'
      } else if (type === 3) {
        return this.$i18n.locale === 'bn' ? 'লাইসেন্স ফি' : 'License Fee'
      } else if (type === 4) {
        return this.$i18n.locale === 'bn' ? 'নবায়ন ফি' : 'Renewal Fee'
      } else if (type === 5) {
        return this.$i18n.locale === 'bn' ? 'বিলম্ব ফি' : 'Late Fee'
      } else if (type === 6) {
        return this.$i18n.locale === 'bn' ? 'বরাদ্দ ফি' : 'Allocation Fee'
      }
    },
    editMethodInParent (item, type) {
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, {
        page: this.pagination.currentPage,
        per_page: this.search.limit,
        is_office_user: userTypeModule.userType('is_office_user')
       })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allPaymentLIst, params)
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
    },
    async adminPaymentStatusUpdate () {
      if (this.$route.params.status && this.$route.query.transId) {
        const status = this.$route.params.status
        const tranId = this.$route.query.transId
        await RestApi.getData(licenseRegistrationServiceBaseUrl, adminTcbPaymentStatusUpdate + status, { transId: tranId }).then(response => {
          if (response.success) {
            this.$toast.success({
              title: this.$t('globalTrans.success'),
              message: response.message,
              color: '#D6E09B'
            })
          } else {
            this.$toast.error({
              title: 'Error',
              message: response.message
            })
          }
        })
        this.loadData()
        this.$router.push('/license-registration-service/license-management/payment')
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
