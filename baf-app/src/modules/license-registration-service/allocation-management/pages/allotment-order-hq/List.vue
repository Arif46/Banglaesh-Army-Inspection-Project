<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('allocation_management.allotment_order') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
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
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <b-form-group
              label-for="allotment_count"
              >
                <template v-slot:label>
                  {{ $t('allocation_management.allotment_count') }}
                </template>
                <b-form-select
                  plain
                  id="allotment_count"
                  :options="allotmentCount"
                  v-model="search.allotment_count"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
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
        <h4 class="card-title">{{ $t('allocation_management.allotment_order') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
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
                  <template v-slot:cell(fiscal_year_id)="data">
                    {{ data.item.fiscal_year_id }}
                  </template>
                  <template v-slot:cell(allotment_count_id)="data">
                    {{ data.item.allotment_count_id }}
                  </template>
                  <template v-slot:cell(approval_date)="data">
                    {{ data.item.approval_date | dateFormat}}
                  </template>
                  <template v-slot:cell(attachment)="data">
                    <a target="_blank" :href="licenseRegistrationServiceBaseUrl + data.item.allotment_attachment" class="text-muted"><i class="ri-cloud-fill"></i> {{ $t('globalTrans.attachment') }}</a>
                  </template>
                  <template v-slot:cell(action)="data">
                     <b-button :title="$t('globalTrans.details')" class="btn action-btn status active view mx-2" v-b-modal.details @click="editMethodInParent(data.item,3)"> <i class="ri-eye-fill"></i>
                     </b-button>
                     <b-button v-if="data.item.is_ordered == 1" v-b-modal.modal-form @click="editMethodInParent(data.item,1)" class="btn btn-sm btn-success">{{$t('allocation_management.order')}}
                     </b-button>
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
     <Details :items="items" :key="viewitemId"/>
    </b-modal>
  </div>
</template>
<script>
import Form from './Form.vue'
import Details from './Details.vue'
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { allotmentOrderhqList } from '../../api/routes'
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
        fiscal_year_id: 0,
        allotment_count: 0,
        limit: 10
      },
      items: [],
      viewitemId: 0,
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '5%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'allocation_management.allotment_count', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '15%' } },
        { labels: 'allocation_management.approval_date', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'allocation_management.attachment', class: 'text-left', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'globalTrans.action', class: 'text-left', sortable: true, stickyColumn: false, show: '1', order: 9 }
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
          { key: 'approval_date' },
          { key: 'attachment' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year' },
          { key: 'allotment_count' },
          { key: 'approval_date' },
          { key: 'attachment' },
          { key: 'action' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.entry') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
    },
    viewTitle () {
      return (this.editItemId === 0) ? this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.details') : this.$t('allocation_management.allotment_order') + ' ' + this.$t('globalTrans.modify')
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
    // detailsData (viewitem) {
    //   this.items = viewitem
    // },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, allotmentOrderhqList, params)
      if (result.success) {
        const listData = result.data.data.map((item, index) => {
          const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList
          const fiscalYearService = fiscalYearList.find(tmp => tmp.value === item.fiscal_year_id)
          const allCountObj = this.$store.state.commonObj.gradeList.find(gradeId => gradeId.value === item.allotment_count_id)
        const productServiceData = {
          serial: index,
          allotment_count_bn: allCountObj !== undefined ? allCountObj.text_bn : '',
          allotment_count: allCountObj !== undefined ? allCountObj.text : '',

          fiscal_year: fiscalYearService !== 'undefined' ? fiscalYearService.text_en : '',
          fiscal_year_bn: fiscalYearService !== 'undefined' ? fiscalYearService.text_bn : ''
        }

          return Object.assign({}, item, { serial: index }, productServiceData)
          // return Object.assign({}, item, { serial: index }, officeData, wareHouData)
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
