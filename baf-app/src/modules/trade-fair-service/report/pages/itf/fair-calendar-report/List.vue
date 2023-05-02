<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('fair_report.fair_calendar_report') }} {{ $t('globalTrans.search') }}</h4>
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
                id="fiscal_year"
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
              label-for="fair_sector_id">
              <template v-slot:label>
                {{ $t('externalTradeFair.fair_sector') }}
              </template>
              <b-form-select
                plain
                id="fair_sector_id"
                :options="fairSectorList"
                v-model="search.fair_sector_id"
              >
              <template v-slot:first>
                <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
              </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="country_id"
            >
              <template v-slot:label>
                {{ $t('externalTradeFair.country') }}
              </template>
              <b-form-select
                plain
                id="country_id"
                :options="countryList"
                v-model="search.country_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-button size="sm" variant="primary" @click="searchData">
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
        <h4 class="card-title">
          {{ $t('fair_report.fair_calendar_report') }} {{ $t('globalTrans.list') }}
        </h4>
      </template>
      <template v-slot:headerAction>
        <b-button v-if="isResult && finalList.length === undefined" variant="primary" size="sm" @click="pdfExport" class="float-right">
            {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="customloading">
          <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('fair_report.fair_calendar_report') }}
          </list-report-head>
          <b-row>
            <b-col md="4">
              <span>{{ $t('tradeFairConfig.fiscal_year') }}</span>:
              <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_en : searchHeaderData.fiscal_year_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-center">
              <span>{{ $t('externalTradeFair.fair_sector') }}</span>:
              <strong>{{ search.fair_sector_id ? ($i18n.locale === 'en' ? searchHeaderData.fair_sector_en : searchHeaderData.fair_sector_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-right">
              <span>{{ $t('externalTradeFair.country') }}</span>:
              <strong>{{ search.country_id ? ($i18n.locale === 'en' ? searchHeaderData.country_en : searchHeaderData.country_bn) : $t('globalTrans.all') }}</strong>
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
                        <th>{{ $t('tradeFairProposalManagement.name_and_title') }}</th>
                        <th>{{ $t('tradeFairProposalManagement.city_country') }}</th>
                        <th>{{ $t('externalTradeFair.date_from') }} {{  currentLocale === 'bn' ? 'হতে' : 'to' }} {{  $t('externalTradeFair.date_to') }}</th>
                        <th>{{ $t('externalTradeFair.duration') }}</th>
                        <th>{{ $t('externalTradeFair.product_service_exhibited') }}</th>
                        <th>{{ $t('externalTradeFair.proposed_by') }}</th>
                      </tr>
                    </thead>
                    <tbody v-if="isResult && finalList.length === undefined">
                      <span hidden>{{ $i = 1 }} {{ $si = 1 }}</span>
                      <template v-for="(items, index) in finalList">
                        <tr style="background: #ddd;" :key="index">
                          <td colspan="7" class="text-left"> <span class="mr-3">{{ $n($i++) + '.' }}</span>{{ getFairSector(index) }} </td>
                        </tr>
                          <tr v-for="(item, index2) in items" :key="index2">
                            <td class="text-center"> {{$n($si++)}}</td>
                            <td> {{ currentLocale === 'bn' ? item.fair_name_bn : item.fair_name }}</td>
                            <td> {{ currentLocale === 'bn' ? item.city_bn : item.city }},  {{ getCountry(item.country_id) }}</td>
                            <td>
                              {{ item.date_from|dateFormat }}
                              {{ currentLocale === 'bn' ? 'হতে' : 'to' }}
                              {{ item.date_to|dateFormat }}
                            </td>
                            <td> {{ getDuration(item.date_from, item.date_to) }}</td>
                            <td> {{ currentLocale === 'bn' ? item.product_service_exhibited_bn : item.product_service_exhibited }}</td>
                            <td> {{ currentLocale === 'bn' ? item.proposed_by_bn : item.proposed_by }}</td>
                          </tr>
                      </template>
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
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairCalanderInfoReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ModalBaseMasterList from '@/mixins/list'
import moment from 'moment'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      sortBy: '',
      customloading: false,
      isResult: false,
      finalList: [],
      search: {
        fiscal_year_id: 0,
        fair_sector_id: 0,
        country_id: 0,
        limit: 20
      },
      searchHeaderData: {
        fiscal_year_en: '',
        fiscal_year_bn: '',
        fair_sector_en: '',
        fair_sector_bn: '',
        country_en: '',
        country_bn: ''
      },
      labelData: [
        { labels: 'globalTrans.sl_no', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 1, thStyle: { width: '9%' } },
        { labels: 'fair_report.name_title_event', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 2, thStyle: { width: '20%' } },
        { labels: 'fair_report.city_country', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 3, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.duration', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 4, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.product_service_exhibited', class: 'text-center', sortable: true, stickyColumn: true, show: '1', order: 5, thStyle: { width: '20%' } },
        { labels: 'externalTradeFair.proposed_by', class: 'text-center', show: '1', order: 6 }
      ]
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
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    countryList () {
      return this.$store.state.CommonService.commonObj.countryList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    fairSectorList () {
      return this.$store.state.TradeFairService.commonObj.fairSectorList
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1)
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
          { key: 'fair_name_bn' },
          { key: 'country_id' },
          { key: 'duration' },
          { key: 'product_service_exhibited_bn' },
          { key: 'proposed_by_bn' }
        ]
      } else {
        keys = [
          { key: 'serial' },
          { key: 'fair_name' },
          { key: 'country_id' },
          { key: 'duration' },
          { key: 'product_service_exhibited' },
          { key: 'proposed_by' }
        ]
      }
      return labels.map((item, index) => {
        return Object.assign(item, keys[index])
      })
    }
  },
  methods: {
    getFairSector (sector) {
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== undefined) {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getCountry (countryId) {
      const countryObj = this.countryList.find(el => el.value === parseInt(countryId))
      if (countryObj !== 'undefined') {
        return this.currentLocale === 'bn' ? countryObj.text_bn : countryObj.text_en
      }
    },
    searchData () {
      this.loadData()
    },
    getDuration (fromDate, toDate) {
      const start = moment(fromDate, 'YYYY-MM-DD')
      const end = moment(toDate, 'YYYY-MM-DD')
      const numberOfDays = end.diff(start, 'days')
      if (numberOfDays > 0) {
        const years = Math.floor(numberOfDays / 365)
        const months = Math.floor(numberOfDays % 365 / 30)
        const days = Math.floor(numberOfDays % 365 % 30)

        const yearsDisplay = years > 0 ? this.currentLocale === 'bn' ? this.$n(years) + ' বছর ' : years + (years === 1 ? ' year, ' : ' years, ') : ''
        const monthsDisplay = months > 0 ? this.currentLocale === 'bn' ? this.$n(months) + ' মাস ' : months + (months === 1 ? ' month, ' : ' months, ') : ''
        const daysDisplay = days > 0 ? this.currentLocale === 'bn' ? this.$n(days) + ' দিন ' : days + (days === 1 ? ' day' : ' days') : ''
        return yearsDisplay + monthsDisplay + daysDisplay
      }
    },
    async loadData () {
      this.customloading = true
      if (this.search.fiscal_year_id) {
        const fiscalYear = this.fiscalYearList.find(obj => obj.value === this.search.fiscal_year_id)
        const customItem = {
          fiscal_year_en: fiscalYear?.text_en,
          fiscal_year_bn: fiscalYear?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, customItem)
      }
      if (this.search.fair_sector_id) {
        const fairObj = this.fairSectorList.find(obj => obj.value === this.search.fair_sector_id)
        const fairData = {
          fair_sector_en: fairObj?.text_en,
          fair_sector_bn: fairObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, fairData)
      }
      if (this.search.country_id) {
        const countryObj = this.countryList.find(obj => obj.value === this.search.country_id)
        const countryData = {
          country_en: countryObj?.text_en,
          country_bn: countryObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, countryData)
      }

      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      // this.$store.dispatch('mutateCommonProperties', { customloading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairCalanderInfoReportList, params)
      if (result.success) {
        this.finalList = result.data
        this.customloading = false
        this.isResult = true
      }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, fiscal_year_id: this.search.fiscal_year_id, fair_sector_id: this.search.fair_sector_id, country_id: this.search.country_id })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, fairCalanderInfoReportList, params)
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
<style scoped>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
</style>
