<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcbconfiguration.user_wise_warehouse') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="office_type_id">
              <template v-slot:label>
                {{ $t('tcbconfiguration.office_type') }}
              </template>
              <b-form-select
                plain
                id="office_type_id"
                :options="officeTypeList"
                v-model="search.office_type_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group label-for="office_id">
              <template v-slot:label>
                {{ $t('tcbconfiguration.office') }}
              </template>
              <b-form-select
                plain
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
            <b-form-group label-for="warehosue_id">
              <template v-slot:label>
                {{ $t('tcbconfiguration.warehouse') }}
              </template>
              <b-form-select
                plain
                id="warehosue_id"
                :options="warehouseList"
                v-model="search.warehosue_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
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
        <h4 class="card-title">{{ $t('tcbconfiguration.user_wise_warehouse') }} {{ $t('globalTrans.list') }}</h4>
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
  </div>
</template>
<script>
import Form from './Form.vue'
import RestApi, { licenseRegistrationServiceBaseUrl, authServiceBaseUrl } from '@/config/api_config'
import { tcbUserList, userWarehouseList, userWarehouseToggle } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Form
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        org_id: 7,
        office_type_id: 0,
        office_id: 0,
        warehouse_id: 0,
        limit: 10
      },
      officeList: [],
      warehouseList: [],
      userList: [],
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'tcbconfiguration.office', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.username', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'tcbconfiguration.warehouse', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '25%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 5 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: false,
        delete: false
      }
    }
  },
  created () {
    this.loadData()
    this.getTcbUserList()
  },
  watch: {
    'search.office_type_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.office_type_id === newVal)
      }
    },
    'search.office_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.warehouseList = this.getWareHouseList(newVal)
      }
    },
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
          { key: 'office_name_bn' },
          { key: 'user_name_bn' },
          { key: 'warehouses_bn' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'office_name' },
          { key: 'user_name' },
          { key: 'warehouses_en' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('tcbconfiguration.user_wise_warehouse') + ' ' + this.$t('globalTrans.entry') : this.$t('tcbconfiguration.user_wise_warehouse') + ' ' + this.$t('globalTrans.modify')
    },
    orgList () {
      return this.$store.state.CommonService.commonObj.orgProfileList.filter(item => item.status === 1)
    },
    officeTypeList () {
      return this.$store.state.CommonService.commonObj.officeTypeList.filter(item => item.status === 1 && item.org_id === 7)
    }
  },
  methods: {
    getWareHouseList (officeId) {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.office_id === parseInt(officeId))
    },
    getWareHouse (id) {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === parseInt(id))
    },
    editMethodInParent (warehouse, type) {
      if (type === 1) {
        this.edit(warehouse)
      } else if (type === 2) {
        this.changeStatus(7, licenseRegistrationServiceBaseUrl, userWarehouseToggle, warehouse)
      }
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, userWarehouseList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const officeObj = this.$store.state.CommonService.commonObj.officeList.find(office => office.value === parseInt(item.office_id))
          const officeData = {}
            if (typeof officeObj !== 'undefined') {
                officeData.office_name = officeObj.text_en
                officeData.office_name_bn = officeObj.text_bn
            } else {
              officeData.office_name = ''
              officeData.office_name_bn = ''
            }
          const userObj = this.userList.find(user => user.value === parseInt(item.user_id))
          const userData = {}
            if (typeof userObj !== 'undefined') {
                userData.user_name = userObj.text_en
                userData.user_name_bn = userObj.text_bn
            } else {
              userData.user_name = ''
              userData.user_name_bn = ''
            }
          const enWare = item.warehouseList.map(item => {
            return this.getWareHouse(item.warehouse_id).text_en
          })
          const bnWare = item.warehouseList.map(item => {
            return this.getWareHouse(item.warehouse_id).text_bn
          })
          const warehouses = {}
          warehouses.warehouses_en = enWare.toString()
          warehouses.warehouses_bn = bnWare.toString()
          return Object.assign({}, item, { serial: index }, officeData, userData, warehouses)
        })
        this.$store.dispatch('setList', listData)
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async getTcbUserList () {
      const result = await RestApi.getData(authServiceBaseUrl, tcbUserList, { org_id: 7 })
      this.userList = result.data.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.id, text: item.text_bn, text_bn: item.text_bn, text_en: item.text_en }
        } else {
          return { value: item.id, text: item.text_en, text_bn: item.text_bn, text_en: item.text_en }
        }
      })
    }
  }
}
</script>
