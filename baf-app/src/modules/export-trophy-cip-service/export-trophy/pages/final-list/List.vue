<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.final_list') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="3">
            <b-form-group
              label-for="fiscal_year_id"
            >
              <template v-slot:label>
                {{$t('globalTrans.fiscal_year')}}
              </template>
              <b-form-select
                plain
                v-model="search.fiscal_year_id"
                :options="fiscalYearList"
                id="fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="3">
              <b-form-group
                label-for="type"
              >
              <template v-slot:label>
                {{$t('globalTrans.type')}}
              </template>
              <b-form-select
                plain
                v-model="search.sector_type"
                :options="productServiceTypeList"
                id="type"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
              </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-form-group
              label-for="product_service_sector_id"
            >
              <template v-slot:label>
                {{$t('externalUser.export_product_sector')}}
              </template>
              <v-select name="production_season_id"
                v-model="search.product_service_sector_id"
                label="text"
                :reduce="item => item.value"
                :options= productServiceSectorList
                :placeholder="$t('globalTrans.select')"
              />
            </b-form-group>
          </b-col>
          <b-col sm="3">
            <b-button class="mt-20" size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">{{ $t('cip.final_list') }}</h4>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(fiscal_year_id)="data">
                  {{ getFiscalYear(data.item.fiscal_year_id) }}
                </template>
                <template v-slot:cell(total_application) = "data">
                  {{ $n(data.item.total_application, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.details variant=" action-btn status" size="sm" @click="showApplicant(data.item.product_service_sector_id, data.item.fiscal_year_id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                </template>
              </b-table>
              <div class="pagination-wrapper mt-3">
                <b-pagination
                  v-model="pagination.currentPage"
                  :per-page="pagination.perPage"
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
    <b-modal id="modal-details" size="xl" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <Details :id="editItemId" :key="editItemId"/>
    </b-modal>
  </div>
</template>
<script>
import Details from '../Details.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { finalListApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details
  },
  data () {
    return {
      search: {
        fiscal_year_id: 0,
        sector_type: 0,
        product_service_sector_id: '',
        limit: 20
      },
      productServiceSectorList: []
    }
  },
  created () {
    this.loadData()
  },
  watch: {
    'search.sector_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.search.product_service_sector_id = ''
        this.productServiceSectorList = this.getProductServiceSectorList(newVal)
      }
    },
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.productServiceLocaleChange()
      }
    }
  },
  computed: {
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList
    },
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('globalTrans.fiscalYear'), class: 'text-center' },
          { label: this.$t('externalUser.export_product_sector'), class: 'text-center' },
          { label: this.$t('globalTrans.total_application'), class: 'text-center' },
          { label: this.$t('globalTrans.action'), class: 'text-center' }
        ]
      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'fiscal_year_id' },
          { key: 'product_service_name_bn' },
          { key: 'total_application' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
          { key: 'fiscal_year_id' },
          { key: 'product_service_name_en' },
          { key: 'total_application' },
          { key: 'action' }
        ]
      }

      return labels.map((item, index) => {
          return Object.assign(item, keys[index])
        })
    },
    pageOptions () {
      return this.$store.state.commonObj.pageOptions
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    showApplicant (productServiceId, fiscalYearId) {
      this.$router.push({
        path: '/export-trophy-cip-service/export-trophy/final-list-applicants', query: { id: productServiceId, fiscal_year: fiscalYearId }
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, finalListApi, params)
      if (result.success) {
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      let total = 0
      const productServiceList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const listAll = data.map((item, index) => {
        total = total + item.total_application
        const productService = productServiceList.find(tmp => tmp.value === item.product_service_sector_id)

        const productServiceData = {
          serial: index,
          product_service_name_en: productService !== 'undefined' ? productService.text_en : '',
          product_service_name_bn: productService !== 'undefined' ? productService.text_bn : ''
        }
        return Object.assign({}, item, productServiceData)
      })
      this.overallApplication = total
      return listAll
    },
    getProductServiceSectorList (sectorType) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(sector => sector.type === sectorType && sector.assign_for === 2)
    },
    productServiceLocaleChange () {
      this.productServiceSectorList = this.productServiceSectorList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    }
  }
}
</script>
