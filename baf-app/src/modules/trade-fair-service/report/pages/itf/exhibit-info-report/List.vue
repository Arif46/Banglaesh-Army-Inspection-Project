<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('fair_report.exhibition_info_report') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="fiscal_year"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.fiscal_year') }}
              </template>
              <b-form-select
                plain
                id="fiscal_year_id"
                :options="fiscalYearList"
                v-model="search.fiscal_year_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="fair_name_id">
              <template v-slot:label>
                {{ $t('externalTradeFair.fair_name') }}
              </template>
              <b-form-select
                plain
                id="fair_name_id"
                :options="fairNameList"
                v-model="search.fair_name_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
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
        <h4 class="card-title">{{ $t('fair_report.exhibition_info_report') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-button v-if="isResult && finalList.length !== undefined" variant="primary" size="sm" @click="pdfExport" class="float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="customloading">
          <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('fair_report.exhibition_info_report') }}
          </list-report-head>
          <b-row>
            <b-col md="4">
              <span>{{ $t('tradeFairConfig.fiscal_year') }}</span>:
              <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_en : searchHeaderData.fiscal_year_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-center">
              <span>{{ $t('externalTradeFair.fair_name') }}</span>:
              <strong>{{ search.fair_name_id ? ($i18n.locale === 'en' ? searchHeaderData.fair_name_en : searchHeaderData.fair_name_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
          </b-row>
          <b-row>
            <b-overlay>
              <b-row>
                <b-col lg="12" sm="12">
                  <table style="width:100%;">
                    <thead>
                      <tr>
                        <th>{{ $t('globalTrans.sl_no') }}</th>
                        <th>{{ $t('globalTrans.fiscal_year') }}</th>
                        <th>{{ $t('tradeFairConfig.fair_name') }}</th>
                        <th>{{ $t('exhibitCircularManagement.company_name') }}</th>
                        <th>{{ $t('exhibitCircularManagement.company_type') }}</th>
                        <th>{{ $t('exhibitCircularManagement.quantity') }}</th>
                        <th>{{ $t('globalTrans.action') }}</th>
                      </tr>
                    </thead>
                    <tbody v-if="isResult && finalList.length !== undefined">
                      <span hidden>{{ $si = 1 }}</span>
                          <tr v-for="(item, index) in finalList" :key="index">
                            <td class="text-center"> {{$n($si++)}} </td>
                            <td> {{ currentLocale === 'bn' ? item.fiscal_year_bn : item.fiscal_year_en }}</td>
                            <td> {{ currentLocale === 'bn' ? item.fair_name_bn : item.fair_name_en }}</td>
                            <td> {{ currentLocale === 'bn' ? item.fair_parti.name_bn : item.fair_parti.name_en }}</td>
                            <td> {{ getCompanyTypeName(item.fair_parti.company_type) }}</td>
                            <td> {{ $n(getDetailsData(item.details)) }}</td>
                            <!-- <td><span v-for="(itm, indx) in item.details" :key="indx">
                                  <span><li>{{ currentLocale === 'bn' ? itm.exhibit_desc_bn : itm.exhibit_desc_en }} {{ '-' }} {{ $n(itm.quantity) }}</li></span>
                                </span>
                            </td> -->
                            <td><b-button :title="$t('globalTrans.details')" v-b-modal.modal-details variant=" action-btn status" size="sm" @click="details(item)"><i class="ri-eye-fill"></i></b-button></td>
                          </tr>
                    </tbody>
                    <tbody v-else>
                      <tr>
                        <td colspan="7" class="text-center"> {{ $t('fair_report.not_found') }} </td>
                      </tr>
                    </tbody>
                  </table>
                </b-col>
              </b-row>
            </b-overlay>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
    <b-modal id="modal-details" size="lg" :title="$t('globalTrans.details')" hide-footer :ok-title="$t('globalTrans.close')" ok-only ok-variant="danger">
      <template #modal-title class="flex-grow">
        {{ $t('exhibitCircularManagement.exhibition_info_report') }}
        <b-button variant="success" @click="pdfExportDetails" class="ml-5 btn-sm float-right">
          {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <Details :id="detailsItemId" :item="itemData" :key="detailsItemId"  ref="details"/>
    </b-modal>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import Details from './Details'
import { exhibitInfoReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    Details, ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      sortBy: '',
      detailsItemId: '',
      itemData: [],
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        limit: 20
      },
      customloading: false,
      isResult: false,
      finalList: [],
      fairNameList: [],
      // search_param: {
      //   fiscal_year_id: 0,
      //   fair_name_id: 0
      // },
      searchHeaderData: {
        fiscal_year_en: '',
        fiscal_year_bn: '',
        fair_name_en: '',
        fair_name_bn: ''
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'globalTrans.fiscal_year', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'tradeFairConfig.fair_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_name', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.company_type', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'exhibitCircularManagement.quantity', class: 'text-center', show: '1', order: 6 },
        { labels: 'globalTrans.action', class: 'text-center', show: '1', order: 7 }
      ],
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
    // this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (this.search.fiscal_year_id) {
        this.fairNameList = this.getFairNameList()
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    listData: function () {
      const tmpData = this.$store.state.list
      return JSON.parse(JSON.stringify(tmpData))
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
          { key: 'fiscal_year_bn' },
          { key: 'fair_name_bn' },
          { key: 'company_name_bn' },
          { key: 'company_type' },
          { key: 'quantity' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fiscal_year_en' },
          { key: 'fair_name_en' },
          { key: 'company_name_en' },
          { key: 'company_type' },
          { key: 'quantity' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
    }
  },
  methods: {
    getFairNameList () {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    editMethodInParent (item, type) {
      if (type === 1) {
        this.edit(item)
      }
    },
    details (item) {
      this.detailsItemId = item.id
      this.itemData = item
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.customloading = true
      if (this.search.fiscal_year_id) {
        const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === this.search.fiscal_year_id)
        const customItem = {
          fiscal_year_en: fiscalYear?.text_en,
          fiscal_year_bn: fiscalYear?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      if (this.search.fair_name_id) {
        const fairObj = this.$store.state.TradeFairService.commonObj.fairNameList.find(obj => obj.value === this.search.fair_name_id)
        const fairData = {
          fair_name_en: fairObj?.text_en,
          fair_name_bn: fairObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, fairData)
      }

      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      // this.$store.dispatch('mutateCommonProperties', { customloading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, exhibitInfoReportList, params)
      if (result.success) {
        this.finalList = this.getRelationalData(result.data)
        this.customloading = false
        this.isResult = true
      }
    },
    getRelationalData (data) {
        const mapData = data.map((item, index) => {
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
          const customItem = {
            fair_name_en: item.fair_parti.fair_circular.calendar_info.fair_name,
            fair_name_bn: item.fair_parti.fair_circular.calendar_info.fair_name_bn,
            fiscal_year_en: fiscalYear?.text_en,
            fiscal_year_bn: fiscalYear?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
      })
      return mapData
    },
    getDetailsData (data) {
      let quantity = 0
      data.map((item, index) => {
        quantity += item.quantity
      })
      return quantity
    },
    getCompanyTypeName (id) {
      const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
      if (typeof companyType !== 'undefined') {
        return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
      } else {
        return ''
      }
    },
    getFairName (id) {
      const fairName = this.$store.state.TradeFairService.commonObj.fairNameList.find(obj => obj.value === parseInt(id))
      if (typeof fairName !== 'undefined') {
        return this.$i18n.locale === 'en' ? fairName.text_en : fairName.text_bn
      } else {
        return ''
      }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, fiscal_year_id: this.search.fiscal_year_id, fair_name_id: this.search.fair_name_id })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, exhibitInfoReportList, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.customloading = false
    }
  }
}
</script>
<style>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
  .modal-title {
    flex-grow: 1 !important;
  }
</style>
