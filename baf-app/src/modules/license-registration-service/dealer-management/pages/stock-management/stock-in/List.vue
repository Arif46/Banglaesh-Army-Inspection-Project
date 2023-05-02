<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('stock_management.stock_in') }} {{$t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="office_id"
              >
                <template v-slot:label>
                  {{ $t('stock_management.regional_office') }}
                </template>
                <b-form-select
                  plain
                  :disabled="lock_office"
                  id="office_id"
                  :options="officeList"
                  v-model="search.office_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="warehouse_id"
              >
                <template v-slot:label>
                  {{ $t('stock_management.warehouse') }}
                </template>
                <b-form-select
                  plain
                  id="warehouse_id"
                  :options="warehouseList"
                  v-model="search.warehouse_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="end_date"
            >
              <template v-slot:label>
                {{ $t('globalTrans.to_date') }}
              </template>
              <date-picker
                id="start_date"
                v-model="search.end_date"
                class="form-control"
                :placeholder="$t('globalTrans.select_date')"
                >
              </date-picker>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <ValidationProvider name="Stock In Id" vid="stock_in_id">
              <b-form-group
                label-for="stock_in_id">
                <template v-slot:label>
                  {{ $t('stock_management.stock_in_id') }}
                </template>
                <b-form-input
                  id="stock_in_id"
                  v-model="search.stock_in_id"
                ></b-form-input>
              </b-form-group>
            </ValidationProvider>
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
        <h4 class="card-title">{{ $t('stock_management.stock_in') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <a href="javascript:" class="btn-add" @click="resetId" v-b-modal.modal-form><i class="ri-add-fill"></i> {{ $t('globalTrans.add_new') }}</a>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <base-table v-on:editMethodInParent="editMethodInParent" :labelData="labelData" :columns="columns" :search="search" :searchData="searchData" :paginations="pagination" :actions="actions" :imageUrl ="licenseRegistrationServiceBaseUrl" />
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-form" size="lg" :title="formTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Form :id="editItemId" :key="editItemId"/>
    </b-modal>
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { stockInList, stockInToggle } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

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
        office_id: 0,
        warehouse_id: 0,
        start_date: '',
        end_date: '',
        contract_no_id: 0,
        stock_in_id: '',
        limit: 10
      },
      items: [],
      warehouseList: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'stock_management.regional_office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'stock_management.warehouse', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'stock_management.stock_in_id', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'stock_management.stock_in_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '25%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9 }
      ],
      actions: {
        edit: false,
        details: true,
        toogle: false,
        delete: false
      },
      lock_office: false
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
        if (this.lock_office === false) {
          this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === newVal)
        }
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === this.search.office_id)
      }
    }
  },
  computed: {
    auth () {
      return this.$store.state.Auth
    },
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
          { key: 'regional_office_bn' },
          { key: 'warehouse_name_bn' },
          { key: 'stock_id' },
          { key: 'stock_in_date' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'regional_office' },
          { key: 'warehouse_name_en' },
          { key: 'stock_id' },
          { key: 'stock_in_date' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('stock_management.stock_in') + ' ' + this.$t('globalTrans.entry') : this.$t('stock_management.stock_in') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.editItemId === 0) ? this.$t('stock_management.stock_in') + ' ' + this.$t('globalTrans.details') : this.$t('stock_management.stock_in') + ' ' + this.$t('globalTrans.modify')
    },
    officeList () {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    contractNumberList () {
      return this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(8, licenseRegistrationServiceBaseUrl, stockInToggle, item)
      } else if (type === 3) {
        this.details(item)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, stockInList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(law => law.value === parseInt(item.warehouse.office_id))
          const officeData = {}
          const wareHouData = {}
            if (typeof officeObj !== 'undefined') {
                officeData.regional_office = officeObj.text_en
                officeData.regional_office_bn = officeObj.text_bn
            } else {
              officeData.regional_office = ''
              officeData.regional_office_bn = ''
            }
            wareHouData.warehouse_name_en = item.warehouse.warehouse_name_en
            wareHouData.warehouse_name_bn = item.warehouse.warehouse_name_bn

          return Object.assign({}, item, { serial: index }, officeData, wareHouData)
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
