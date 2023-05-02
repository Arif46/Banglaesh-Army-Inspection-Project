<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.pmo_approval') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('cip.pmo_approval') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction v-if="showSendBtn">
        <b-overlay :show="loading">
          <a href="javascript:" class="btn-add mr-2" @click="downloadETApplicants"> {{ $t('cip.all_verification') }}</a>
          <a href="javascript:" class="btn-add mr-2" v-b-modal.modal-meeting-resolution>{{ $t('cip.meeting_resolution') }}</a>
          <a href="javascript:" class="btn-add" @click="approve()">{{ $t('globalTrans.approve') }}</a>
        </b-overlay>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <b-row>
            <b-col md="12" class="table-responsive">
              <b-table thead-class="table_head" striped bordered hover :items="listData" :fields="columns" aria-hidden="loading | listReload ? 'true' : null" :emptyText="$t('globalTrans.noDataFound')" show-empty>
                <template v-slot:cell(index)="data">
                  {{ $n(data.index + pagination.slOffset) }}
                </template>
                <template v-slot:cell(total_application) = "data">
                  {{ $n(data.item.total_application, { useGrouping: false }) }}
                </template>
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.details variant=" action-btn status" size="sm" @click="showApplicant(data.item.product_service_sector_id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
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
    <b-modal id="modal-meeting-resolution" size="lg" :title="$t('cip.prev_meeting_resolution')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <MeetingResolution :circular_id="circularId" :key="circularId"/>
    </b-modal>
  </div>
</template>
<script>
import MeetingResolution from '../MeetingResolution.vue'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { pmoApprovalListApi, pmoApproveApplicantsApi, pmoApprovalVerifiedAppsApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ExportPdf from '../AllVerified'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    MeetingResolution
  },
  data () {
    return {
      loading: false,
      showSendBtn: false,
      overallApplication: 0,
      circularId: 0,
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
          { label: this.$t('externalUser.export_product_sector'), class: 'text-center' },
          { label: this.$t('globalTrans.total_application'), class: 'text-center' },
          { label: this.$t('globalTrans.action'), class: 'text-center' }
        ]

      let keys = []

      if (this.$i18n.locale === 'bn') {
        keys = [
          { key: 'index' },
          { key: 'product_service_name_bn' },
          { key: 'total_application' },
          { key: 'action' }
        ]
      } else {
        keys = [
          { key: 'index' },
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
    showApplicant (productServiceId) {
      this.$router.push({
        path: `/export-trophy-cip-service/export-trophy/pmo-approval-applicants?id=${productServiceId}`
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, pmoApprovalListApi, params)
      if (result.success) {
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
        this.showSendBtn = true
        this.circularId = result.data.data[0].circular_id
      } else {
        this.$store.dispatch('setList', [])
        this.paginationData([])
        this.showSendBtn = false
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async approve () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, pmoApproveApplicantsApi)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('globalTrans.sorry_error'),
          color: '#DC143C'
        })
      }
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
    },
    async downloadETApplicants () {
      this.loading = true
      const params = { circular_id: this.circularId }
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, pmoApprovalVerifiedAppsApi, params)
      this.loading = false
      if (result.success) {
        this.applications = this.getRelationalVerifiedData(result.data)
        this.pdfExport()
      } else {
        this.applications = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalVerifiedData (data) {
      const income = data[0].details[0].product_success_description[1]
      const circular = data[0].details[0].circular
      this.setYearFiscalYear(income, circular)
      const sectorList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const list = data.map((tmp, indx) => {
        const sector = sectorList.find(el => el.value === tmp.sector_id)

        const sectorObj = {
            sector_sl: indx,
            sector_name_en: typeof sector !== 'undefined' ? sector.text_en : '',
            sector_name_bn: typeof sector !== 'undefined' ? sector.text_bn : ''
        }

        const details = tmp.details.map((item, index) => {
            const orgData = {
                detail_serial: index,
                org_name_en: item.org_info !== null ? item.org_info.org_name_en : '',
                org_name_bn: item.org_info !== null ? item.org_info.org_name_bn : ''
            }
            Object.assign({}, item, orgData)
        })
        return Object.assign({}, tmp, sectorObj, details)
      })

      return list
    },
    setYearFiscalYear (income, circular) {
      const tmpFis = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === income.fiscal_year_id)
      this.year = circular.year
      this.fiscalYear_bn = tmpFis.text_bn
      this.fiscalYear_en = tmpFis.text_en
    },
    async pdfExport () {
      this.loading = true
      const reportTitle = this.$t('exportTrophy.export_trophy_application_report_head')
      await ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
      this.loading = false
    }
  }
}
</script>
