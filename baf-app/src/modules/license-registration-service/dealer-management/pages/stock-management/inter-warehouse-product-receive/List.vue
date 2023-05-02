<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('stock_management.inter_warehouse_product_receive') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="warehouse_id_from"
              >
                <template v-slot:label>
                  {{ $t('stock_management.warehouse_from') }}
                </template>
                <b-form-select
                  plain
                  id="warehouse_id_from"
                  :options="fromWarehouseList"
                  v-model="search.warehouse_id_from"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="warehouse_to_id"
              >
                <template v-slot:label>
                  {{ $t('stock_management.warehouse_to') }}
                </template>
                <b-form-select
                  plain
                  id="warehouse_to_id"
                  :options="toWarehouseList"
                  v-model="search.warehouse_to_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="start_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.from_date') }}
              </template>
              <date-picker
                id="start_date"
                v-model="search.start_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
              >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="end_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.to_date') }}
              </template>
              <date-picker
                id="end_date"
                v-model="search.end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
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
        <h4 class="card-title">{{ $t('stock_management.inter_warehouse_product_receive') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <!-- <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template> -->
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
                  <template v-slot:cell(budget)="data">
                    {{ $n(data.item.budget) }}
                  </template>
                  <template v-slot:cell(request_date)="data">
                    {{ data.item.request_date | dateFormat }}
                  </template>
                  <template v-slot:cell(transfer_date)="data">
                    {{ data.item.transfer_date | dateFormat }}
                  </template>
                  <template v-slot:cell(status)="data">
                    <span class="badge badge-primary" v-if="data.item.status == 1">{{$t('globalTrans.pending')}}</span>
                    <span class="badge badge-success" v-else-if="data.item.status == 2">{{$t('globalTrans.approved')}}</span>
                    <span class="badge badge-danger" v-else-if="data.item.status == 3">{{$t('globalTrans.rejected')}}</span>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.modal-details variant="iq-bg-success mr-1" size="sm" @click="details(data.item)" class="action-btn edit" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-b-modal.modal-recivereport variant="iq-bg-success mr-1" size="sm" @click="receivReport(data.item)" class="action-btn active" :title="$t('stock_management.received_report')"><i class="ri-file-chart-line m-0"></i></b-button>
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
    <b-modal id="modal-recivereport" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <ReciveReportForm :id="editItemId" :items="items" :key="editItemId" />
    </b-modal>
    <b-modal id="modal-details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import ReciveReportForm from './ReciveReportForm.vue'
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { innerWarehProReceiveList, innerWarehProReceiveToggle } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import userTypeModule from '@/utils/userType'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form, Details, ReciveReportForm
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      authUser: this.$store.state.Auth.authUser,
      search: {
        warehouse_id_from: 0,
        warehouse_to_id: 0,
        start_date: '',
        end_date: '',
        limit: 10
      },
      items: [],
      fromWarehouseList: [],
      toWarehouseList: [],
      viewitemId: 0,
      editItemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'stock_management.warehouse_from', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'stock_management.warehouse_to', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'stock_management.request_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'stock_management.transfer_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'stock_management.receive_status', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9 },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9, thStyle: { width: '10%' } }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.checkGetWarehosueUserList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    // 'search.warehouse_id_from': function (newVal, oldVal) {
    //   if (newVal !== oldVal) {
    //     this.toWarehouseList = []
    //     this.toWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.org_id === 7 && item.value !== newVal)
    //   }
    // },
    currentLocale: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.toWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.org_id === 7 && item.value !== this.search.warehouse_id_from)
        }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
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
          { key: 'warehouse_name_from_bn' },
          { key: 'warehouse_name_to_bn' },
          { key: 'request_date' },
          { key: 'transfer_date' },
          { key: 'receive_status' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'warehouse_name_from_en' },
          { key: 'warehouse_name_to_en' },
          { key: 'request_date' },
          { key: 'transfer_date' },
          { key: 'receive_status' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('stock_management.inter_warehouse_product_receive') + ' ' + this.$t('globalTrans.entry') : this.$t('stock_management.inter_warehouse_product_receive') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.editItemId === 0) ? this.$t('stock_management.inter_warehouse_product_receive') + ' ' + this.$t('globalTrans.details') : this.$t('stock_management.inter_warehouse_product_receive') + ' ' + this.$t('globalTrans.details')
    },
    officeList () {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
    },
    receiveStatusList: function () {
      const list = [
      { value: 1, text: this.$i18n.locale === 'en' ? 'On Transport' : 'পরিবহনে' },
      { value: 2, text: this.$i18n.locale === 'en' ? 'Partially Recieved' : 'আংশিকভাবে গৃহীত' },
      { value: 3, text: this.$i18n.locale === 'en' ? 'Receieved' : 'গৃহীত' }
      ]
      return list
    },
    auth () {
      return this.$store.state.Auth
    }
  },
  methods: {
      receivReport (item) {
        this.items = item
        this.editItemId = item.id
      },
      details (item) {
        this.items = item
      },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(8, licenseRegistrationServiceBaseUrl, innerWarehProReceiveToggle, item)
      } else if (type === 3) {
        this.details(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const warehouseList = this.toWarehouseList.map(item => {
        return item.value
      })
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage, warehouses: warehouseList })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, innerWarehProReceiveList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fromWhouseObj = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(flaw => flaw.value === parseInt(item.warehouse_id_from))
          const toWhouseObj = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(tlaw => tlaw.value === parseInt(item.warehouse_to_id))
          const receiveStatusObj = this.receiveStatusList.find(tlaw => tlaw.value === parseInt(item.status))
          const fromWhouseData = {}
          const toWhouseData = {}
          const otherData = {}
            if (typeof fromWhouseObj !== 'undefined') {
                fromWhouseData.warehouse_name_from_en = fromWhouseObj.text_en
                fromWhouseData.warehouse_name_from_bn = fromWhouseObj.text_bn
            } else {
              fromWhouseData.warehouse_name_from_en = ''
              fromWhouseData.warehouse_name_from_bn = ''
            }

            if (typeof toWhouseObj !== 'undefined') {
                toWhouseData.warehouse_name_to_en = toWhouseObj.text_en
                toWhouseData.warehouse_name_to_bn = toWhouseObj.text_bn
            } else {
              toWhouseData.warehouse_name_to_en = ''
              toWhouseData.warehouse_name_to_bn = ''
            }
            if (typeof receiveStatusObj !== 'undefined') {
                otherData.receive_status = receiveStatusObj.text
            }
          return Object.assign({}, item, { serial: index }, fromWhouseData, toWhouseData, otherData)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    checkGetWarehosueUserList () {
      this.fromWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      this.toWarehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
      const warehouseUser = this.$store.state.LicenseRegistrationService.commonObj.userWarehouseList.filter(item => item.user_id === parseInt(this.auth.authUser.user_id))
      if (userTypeModule.userType('is_office_user')) {
        if (warehouseUser.length) {
          const tmpWarehouses = []
          warehouseUser.forEach(itm => {
            const tmpWare = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === parseInt(itm.warehouse_id))
            tmpWarehouses.push(tmpWare)
          })
          this.toWarehouseList = tmpWarehouses
        }
      }
      this.loadData()
    }
  }
}
</script>
