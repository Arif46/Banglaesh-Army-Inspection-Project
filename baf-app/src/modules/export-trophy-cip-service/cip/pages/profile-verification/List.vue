<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('cip.profile_verification') }} {{ $t('globalTrans.search') }}</h4>
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
        <h4 class="card-title">{{ $t('cip.profile_verification') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-overlay :show="verificationLoading">
          <slot v-if="listData.length > 0">
            <a v-if="bbVerified" href="javascript:" class="btn-add mr-2" @click="pdfBBExport"> {{ $t('cip.bb_verified') }}</a>
            <a v-if="nbrVerified" href="javascript:" class="btn-add mr-2" @click="pdfNBRExport"> {{ $t('cip.nbr_verified') }}</a>
            <a v-if="mohaVerified" href="javascript:" class="btn-add mr-2" @click="pdfMHAExport"> {{ $t('cip.mha_verified') }}</a>
            <a v-if="bbSendForVerification" href="javascript:" class="btn-add mr-2" @click="sendToVerify(1)"> {{ $t('exportTrophy.send_to_bb') }}</a>
            <a v-if="nbrSendForVerification" href="javascript:" class="btn-add mr-2" @click="sendToVerify(2)"> {{ $t('exportTrophy.send_to_nbr') }}</a>
            <a v-if="mohaSendForVerification" href="javascript:" class="btn-add mr-2" @click="sendToVerify(3)"> {{ $t('exportTrophy.send_to_moha') }}</a>
            <slot v-if="bbVerified && nbrVerified && mohaVerified">
              <a href="javascript:" class="btn-add mr-2" @click="pdfExport"> {{ $t('cip.all_verification') }}</a>
              <a href="javascript:" class="btn-add mr-1" @click="sendToMocScrutiny"> {{ $t('exportTrophy.send_to_moc_scrutiny') }}</a>
            </slot>
          </slot>
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
                  <b-button v-b-modal.modal-details variant=" action-btn status mr-1" size="sm" @click="showApplicant(data.item.product_service_sector_id)" class="action-btn status" :title="$t('globalTrans.details')"><i class="ri-eye-fill"></i></b-button>
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
  </div>
</template>
<script>
import { mapGetters } from 'vuex'
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { profileVerficationApi, profileVerficationVerifiedApi, profileVerficationSendApi, profileVerficationSendOrNotApi, profVerfiSendToMocScrutinyApi } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ExportBBPdf from './bb-verified'
import ExportNBRPdf from './nbr-verified'
import ExportMHAPdf from './mha-verified'
import ExportPdf from '../Allverified'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      loading: false,
      year: '',
      fiscalYear_en: '',
      fiscalYear_bn: '',
      applications: [],
      circularId: 0,
      bbVerified: false,
      nbrVerified: false,
      mohaVerified: false,
      bbSendForVerification: true,
      nbrSendForVerification: true,
      mohaSendForVerification: true,
      verificationLoading: false,
      search: {
        year: 0,
        sector_type: 0,
        product_service_sector_id: '',
        limit: 20
      },
      labelData: [],
      productServiceSectorList: [],
      status: 0,
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl
    }
  },
  created () {
    this.loadData()
    // this.getVerifiedData()
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
    ...mapGetters({
      authUser: 'Auth/authUser'
    }),
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
        path: `/export-trophy-cip-service/cip/profile-verification-applicants?id=${productServiceId}`
      })
    },
    searchData () {
      this.loadData()
      // this.getVerifiedData()
    },
    async getVerifiedData () {
      this.loading = true
      const params = { circular_id: this.circularId }
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, profileVerficationVerifiedApi, params)
      this.loading = false
      if (result.success) {
        this.applications = this.getRelationalVerifiedData(result.data)
        this.checkVerification(result.data)
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
    async loadData () {
      this.verificationLoading = true
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, profileVerficationApi, params)
      this.verificationLoading = false
      if (result.success) {
        this.headerAction = true
        this.$store.dispatch('setList', this.getRelationalData(result.data.data))
        this.paginationData(result.data, this.search.limit)
        this.circularId = result.data.data[0].circular_id
        this.checkVerificationSendOrNot()
      } else {
        this.headerAction = false
        this.$store.dispatch('setList', [])
        this.paginationData([])
        this.circularId = 0
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
      const productServiceList = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList
      const dataList = data.map((item, index) => {
        const productService = productServiceList.find(tmp => tmp.value === item.product_service_sector_id)

        const productServiceData = {
          serial: index,
          product_service_name_en: productService.text_en,
          product_service_name_bn: productService.text_bn
        }
        this.circularId = item.circular_id
        return Object.assign({}, item, productServiceData)
      })
      return dataList
    },
    getProductServiceSectorList (sectorType) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(sector => sector.type === sectorType && sector.assign_for === 1)
    },
    productServiceLocaleChange () {
      this.productServiceSectorList = this.productServiceSectorList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    setYearFiscalYear (income, circular) {
      const tmpFis = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === income.fiscal_year_id)
      this.year = circular.year
      this.fiscalYear_bn = tmpFis.text_bn
      this.fiscalYear_en = tmpFis.text_en
    },
    async pdfBBExport () {
      this.verificationLoading = true
      const reportTitle = this.$t('cip.cip_applicants')
      await ExportBBPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
      this.verificationLoading = false
    },
    async pdfNBRExport () {
      this.loading = true
      const reportTitle = this.$t('cip.cip_applicants')
      await ExportNBRPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
      this.loading = false
    },
    async pdfMHAExport () {
      this.verificationLoading = true
      const reportTitle = this.$t('cip.cip_applicants')
      await ExportMHAPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
      this.verificationLoading = false
    },
    async pdfExport () {
      this.verificationLoading = true
      const reportTitle = this.$t('cip.cip_application_report_head')
      await ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
      this.verificationLoading = false
    },
    async checkVerificationSendOrNot () {
      this.verificationLoading = true
      const params = { circular_id: this.circularId }
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, profileVerficationSendOrNotApi, params)
      this.verificationLoading = false
      if (result.success) {
        this.checkSendOrNot(result.data)
        this.getVerifiedData()
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    async sendToVerify (type) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.verificationLoading = true
      var params
      if (type === 1) {
        params = { circular_id: this.circularId, type: type, bb_verification: 1, sender_id: this.authUser.user_id }
      } else if (type === 2) {
        params = { circular_id: this.circularId, type: type, nbr_verification: 1, sender_id: this.authUser.user_id }
      } else if (type === 3) {
        params = { circular_id: this.circularId, type: type, moha_verification: 1, sender_id: this.authUser.user_id }
      }
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, profileVerficationSendApi, params)
      this.verificationLoading = false
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
    checkVerification (data) {
      const item = data[0].details[0].profile_verification
      if (item && item.bb_verification === 1) {
        this.bbVerified = true
      } else if (item && item.bb_verification === 2) {
        this.nbrVerified = true
      } else if (item && item.bb_verification === 3) {
        this.mohaVerified = true
      }
    },
    checkSendOrNot (item) {
      this.bbSendForVerification = (item && item.bb_verification) ? 0 : 1
      this.nbrSendForVerification = (item && item.nbr_verification) ? 0 : 1
      this.mohaSendForVerification = (item && item.moha_verification) ? 0 : 1
      this.bbVerified = (item && item.bb_verification === 2) ? 1 : 0
      this.nbrVerified = (item && item.nbr_verification === 2) ? 1 : 0
      this.mohaVerified = (item && item.moha_verification === 2) ? 1 : 0
    },
    async sendToMocScrutiny () {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      const loadingState = { loading: false, listReload: false }
      this.loading = this.verificationLoading = true
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.postData(exportTrophyCIPServiceBaseUrl, profVerfiSendToMocScrutinyApi)
      this.loading = this.verificationLoading = false
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
