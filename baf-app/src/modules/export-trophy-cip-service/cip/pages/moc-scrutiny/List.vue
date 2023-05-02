<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.moc_scrutiny') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="2">
              <b-form-group
                label-for="year"
              >
              <template v-slot:label>
                {{$t('globalTrans.year')}}
              </template>
              <b-form-select
                plain
                v-model="search.year"
                :options="yearList"
                id="year"
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
          <b-col sm="4">
            <b-form-group
              label-for="product_service_sector_id"
            >
              <template v-slot:label>
                {{$t('exportTrophy.product_service_sector')}}
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
        <h4 class="card-title">{{ $t('cip.moc_scrutiny') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction v-if="headerAction">
        <b-overlay :show="loading">
          <a href="javascript:" v-if="$store.state.Auth.authUser.ssoLogin && showSendBtn" class="btn-add status mr-2" @click="sendToNothi()" :title="$t('cip.send_to_nothi')">{{ $t('cip.send_to_nothi') }}</a>
          <slot v-if="listData.length > 0">
            <a href="javascript:" class="btn-add mr-2" @click="downloadCipApplicants"> {{ $t('cip.all_verification') }}</a>
            <a href="javascript:" class="btn-add mr-2" v-b-modal.modal-meeting-resolution> {{ $t('cip.meeting_resolution') }}</a>
          </slot>
          <a v-if="showSendBtn" href="javascript:" class="btn-add mr-1" @click="sendToMocCommittee"> {{ $t('cip.send_to_moc_committee_approval') }}</a>
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
                <template v-slot:cell(action)="data">
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="showApplicant(data.item.product_service_sector_id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
                </template>
                <template v-slot:cell(total_application) = "data">
                  {{ $n(data.item.total_application, { useGrouping: false }) }}
                </template>
              </b-table>
              <b-pagination
                class="mt-20"
                v-model="pagination.currentPage"
                :per-page="pagination.perPage"
                :total-rows="pagination.totalRows"
                @input="searchData"
              />
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
import { mocScrutinyApi, mocScrutinySendApi, mocScrutinyNothiSend, mocScrutinyVerifiedAppsApi, mocScrutSendToMocCommitteApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ExportPdf from '../Allverified'
import Store from '@/store'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    MeetingResolution
  },
  data () {
    return {
      headerAction: false,
      meetingResolutionShow: false,
      previousRemark: null,
      showSendBtn: false,
      overallApplication: 0,
      circularId: 0,
      year: '',
      fiscalYear_en: '',
      fiscalYear_bn: '',
      search: {
        year: 0,
        sector_type: 0,
        product_service_sector_id: '',
        limit: 20
      },
      labelData: [],
      productServiceSectorList: [],
      status: 0,
      noteTitle: '',
      applications: [],
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
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
    yearList () {
      return this.$store.state.commonObj.yearList.map(el => {
        return Object.assign({}, el, { value: el, text: this.$i18n.locale === 'bn' ? this.$n(el, { useGrouping: false }) : el })
      })
    },
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    columns () {
      const labels = [
          { label: this.$t('globalTrans.sl_no'), class: 'text-center' },
          { label: this.$t('exportTrophyConfig.product_or_service_sector_name'), class: 'text-center' },
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
        path: `/export-trophy-cip-service/cip/moc-scrutiny-applicants?id=${productServiceId}`
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, mocScrutinyApi, params)
      if (result.success) {
        this.headerAction = true
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
        // send button show when meeting resolution added
        if (this.overallApplication === result.total_app) {
          this.showSendBtn = true
        } else {
          this.showSendBtn = false
        }
        this.circularId = result.data.data[0].circular_id
      } else {
        this.headerAction = false
        this.$store.dispatch('setList', [])
        this.paginationData([])
        this.showSendBtn = false
        this.circularId = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      let total = 0
      const productServiceList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const dataList = data.map((item, index) => {
        total = total + item.total_application
        const productService = productServiceList.find(tmp => tmp.value === item.product_service_sector_id)

        const productServiceData = {
          serial: index,
          product_service_name_en: productService.text_en,
          product_service_name_bn: productService.text_bn
        }
        this.circularId = item.circular_id
        return Object.assign({}, item, productServiceData)
      })
      this.overallApplication = total
      return dataList
    },
    getProductServiceSectorList (sectorType) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(sector => sector.type === sectorType && sector.assign_for === 1)
    },
    async send () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, mocScrutinySendApi)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.loadData()
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
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async downloadCipApplicants () {
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const params = { circular_id: this.circularId }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, mocScrutinyVerifiedAppsApi, params)
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
    pdfExport () {
      const reportTitle = this.$t('cip.cip_application_report_head')
      ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
    },
    productServiceLocaleChange () {
      this.productServiceSectorList = this.productServiceSectorList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    sendToNothi () {
      const countryList = this.$store.state.CommonService.commonObj.countryList
      const divisionList = this.$store.state.CommonService.commonObj.divisionList
      const districtList = this.$store.state.CommonService.commonObj.districtList
      const cityCorporationList = this.$store.state.CommonService.commonObj.cityCorporationList
      const upazilaList = this.$store.state.CommonService.commonObj.upazilaList
      const municipalityList = this.$store.state.CommonService.commonObj.municipalityList
      const unionList = this.$store.state.CommonService.commonObj.unionList
      const wardList = this.$store.state.CommonService.commonObj.wardList
      const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList

      const params = { divisionList: divisionList, districtList: districtList, cityCorporationList: cityCorporationList, upazilaList: upazilaList, municipalityList: municipalityList, countryList: countryList, unionList: unionList, wardList: wardList, fiscalYearList: fiscalYearList }
      this.returnConfirmationCheck(exportTrophyCIPServiceBaseUrl, mocScrutinyNothiSend, params)
    },
    returnConfirmationCheck (baseUrl, uri, params) {
      window.vm.$swal({
        title: window.vm.$t('globalTrans.are_you_sure_forward_to_nothi'),
        showCancelButton: true,
        confirmButtonText: window.vm.$t('globalTrans.yes'),
        cancelButtonText: window.vm.$t('globalTrans.no'),
        focusConfirm: false
      }).then((result) => {
        if (result.isConfirmed) {
          this.returnConfirmed(baseUrl, uri, params)
        }
      })
    },
    returnConfirmed (baseUrl, uri, params) {
      Store.dispatch('mutateCommonProperties', { loading: true })
      RestApi.postData(baseUrl, uri, params).then(response => {
        if (response.success) {
          window.vm.$toast.success({
            title: 'Success',
            message: 'Data Updated Successfully',
            color: '#D6E09B'
          })
        } else {
          window.vm.$toast.error({
            title: 'Error',
            message: 'Operation failed! Please, try again.',
            color: '#ee5253'
          })
        }
        Store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
      })
    },
    async sendToMocCommittee () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.loading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, mocScrutSendToMocCommitteApi)
      this.loading = false
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.loadData()
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.$t('globalTrans.update_msg'),
          color: '#D6E09B'
        })
      } else {
        this.$toast.error({
          title: this.$t('globalTrans.error'),
          message: this.$t('globalTrans.sorry_error'),
          color: '#DC143C'
        })
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    }
  }
}
</script>
