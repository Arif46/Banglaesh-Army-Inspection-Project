<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_dc_office.assign_warehouse') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="fiscal_year"
              >
                <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }}
                </template>
                <b-form-select
                  plain
                  id="fiscal_year"
                  :options="fiscalYearList"
                  v-model="search.fiscal_year_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
                label-for="allotment_count_id"
                >
                  <template v-slot:label>
                    {{ $t('allocation_dc_office.allonment_count') }}
                  </template>
                  <b-form-select
                    plain
                    id="allotment_count_id"
                    :options="allotmentCount"
                    v-model="search.allotment_count_id"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Delivery Order No" vid="delivery_order_no"  v-slot="{ errors }">
                <b-form-group
                  label-for="delivery_order_no">
                  <template v-slot:label>
                    {{ $t('allocation_dc_office.delivery_order_no') }}
                  </template>
                  <b-form-input
                    id="dispatch_no"
                    v-model="search.delivery_order_no"
                    :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <b-form-group
              label-for="district_id"
              >
                <template v-slot:label>
                  {{ $t('allocation_dc_office.dc_office_name') }}
                </template>
                <b-form-select
                  plain
                  id="district_id"
                  :options="districtList"
                  v-model="search.district_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
        <h4 class="card-title">{{ $t('allocation_dc_office.assign_warehouse_list') }}</h4>
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
                  <template v-slot:cell(allotment_date)="data">
                    {{ data.item.allotment_date | dateFormat}}
                  </template>
                  <template v-slot:cell(delivery_order_no)="data">
                    {{ $n(data.item.delivery_order_no, { useGrouping: false }) }}
                  </template>
                  <template v-slot:cell(attachment)="data">
                    <a target="_blank" :href="licenseRegistrationServiceBaseUrl + data.item.allotment_attachment" class="text-muted"><i class="ri-cloud-fill"></i> {{ $t('globalTrans.attachment') }}</a>
                  </template>
                  <template v-slot:cell(action)="data">
                    <b-button v-b-modal.details variant="iq-bg-success mr-1" size="sm"  @click="details(data.item, 3)" class="action-btn btn-warning view"  :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                    <b-button v-if="data.item.status == 1" :title="$t('allocation_dc_office.assign_warehouse')" v-b-modal.modal-form variant=" iq-bg-success mr-1" size="sm" @click="edit(data.item, 1)" class="action-btn edit"><i class="ri-window-2-line"></i></b-button>
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
    <b-modal id="details" size="lg" :title="viewTitle" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
     <Details :item="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { assignWarehouseList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Form from './Form.vue'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, Form
  },
  data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
      sortBy: '',
      sortDesc: true,
      sortDirection: 'desc',
      search: {
        fiscal_year_id: 0,
        allotment_count_id: 0,
        delivery_order_no: '',
        district_id: 0,
        limit: 10
      },
      valid: '',
      items: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '15%' } },
        { labels: 'allocation_management.allotment_count', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'allocation_dc_office.dc_office_name', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '15%' } },
        { labels: 'allocation_dc_office.delivery_order_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'allocation_dc_office.delivery_order_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
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
          { key: 'fiscal_year_bn' },
          { key: 'allotment_count_bn' },
          { key: 'district_name_bn' },
          { key: 'delivery_order_no' },
          { key: 'allotment_date' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'allotment_count' },
          { key: 'district_name' },
          { key: 'delivery_order_no' },
          { key: 'allotment_date' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return this.$t('allocation_dc_office.assign_warehouse') + ' ' + this.$t('globalTrans.entry')
    },
    viewTitle () {
      return this.$t('allocation_dc_office.assign_warehouse') + ' ' + this.$t('globalTrans.details')
    },
    allotmentCount () {
      return this.$store.state.commonObj.gradeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text }
        }
      })
    },
    districtList () {
      return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1)
    },
    officeList () {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList
    },
    warehouseList () {
      return this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1)
    }
  },
  methods: {
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      } else if (type === 2) {
        this.changeStatus(8, licenseRegistrationServiceBaseUrl, item)
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
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, assignWarehouseList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList
          const fiscalYearService = fiscalYearList.find(tmp => tmp.value === item.fiscal_year_id)
          const allCountObj = this.$store.state.commonObj.gradeList.find(gradeId => gradeId.value === item.allotment_count_id)
          const districtObj = this.$store.state.CommonService.commonObj.districtList.find(dis => dis.value === item.district_id)
          const customData = {
            serial: index,
            allotment_count_bn: allCountObj !== undefined ? allCountObj.text_bn : '',
            allotment_count: allCountObj !== undefined ? allCountObj.text : '',

            fiscal_year: fiscalYearService !== 'undefined' ? fiscalYearService.text_en : '',
            fiscal_year_bn: fiscalYearService !== 'undefined' ? fiscalYearService.text_bn : '',

            district_name: districtObj !== 'undefined' ? districtObj.text_en : '',
            district_name_bn: districtObj !== 'undefined' ? districtObj.text_bn : ''
          }
          return Object.assign({}, item, { serial: index }, customData)
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
