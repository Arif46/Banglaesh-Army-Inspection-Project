<template>
  <div>
  <b-row style="border: 1px solid #ddd">
    <b-col sm="4" offset="3">
      <b-form-group
        label-for="type_of_fair"
      >
        <template v-slot:label>
          {{ $t('externalTradeFair.type_of_fair') }}
        </template>
        <b-form-select
          plain
          id="type_of_fair"
          :options="typeOfFair"
          v-model="search.type_of_fair"
        >
          <template v-slot:first>
            <b-form-select-option :value=0>{{$t('globalTrans.all')}}</b-form-select-option>
          </template>
        </b-form-select>
      </b-form-group>
    </b-col>
    <b-col sm="4">
      <b-button size="sm" variant="primary" class="mt-20" @click="getFinalList">
        <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
      </b-button>
    </b-col>
  </b-row>
  <b-row>
    <b-col lg="12" sm="12">
      <b-overlay :show="loading">
        <b-row>
          <b-col sm="12" class="mt-2 float-right" v-if="isResult">
            <b-button variant="primary" @click="pdfExport" class="mb-2 float-right">
              <i class="ri-file-pdf-line"></i>
              {{  $t('globalTrans.export_pdf') }}
            </b-button>
          </b-col>
        </b-row>
        <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            <span style="border-bottom:1px solid #000;margin-bottom: 5px">{{ '(' + $t('tradeFairProposalManagement.fair_list') }} {{ getFiscalYear(items.fiscal_year_id) }}{{ ') ' + $t('tradeFairProposalManagement.product_wise') }}</span>
          </list-report-head>
        <p v-if="isResult"> {{ $t('externalTradeFair.type_of_fair') }}: {{ getTypeOfFair() }}</p>
        <b-row v-if="isResult">
          <b-col lg="12" sm="12">
            <table style="width:100%">
              <thead>
                <tr>
                  <th class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                  <th class="text-center">{{ $t('tradeFairProposalManagement.name_and_title') }}</th>
                  <th class="text-center">{{ $t('tradeFairProposalManagement.city_country') }}</th>
                  <th class="text-center">{{ $t('externalTradeFair.duration') }}</th>
                </tr>
              </thead>
              <tbody v-if="finalList.length === undefined">
                <tr>
                  <td class="text-center"> {{ (currentLocale === 'bn' ? 'o' : '0') + $n(1) }} </td>
                  <td class="text-center"> {{ (currentLocale === 'bn' ? 'o' : '0') + $n(2) }} </td>
                  <td class="text-center"> {{ (currentLocale === 'bn' ? 'o' : '0') + $n(3) }} </td>
                  <td class="text-center"> {{ (currentLocale === 'bn' ? 'o' : '0') + $n(4) }} </td>
                </tr>
                <span hidden>{{ $i = 1 }} {{ $si = 1 }}</span>
                <template v-for="(items, index) in finalList">
                  <tr style="background: #ddd;" :key="index">
                    <td colspan="4"> <span class="mr-3">{{ $n($i++) + '.' }}</span>{{ getFairSector(index) }} ({{ $n(items.length) }}) </td>
                  </tr>
                    <tr v-for="(item, index2) in items" :key="index2+index">
                      <td class="text-center"> {{$n($si++)}}</td>
                      <td> {{ currentLocale === 'bn' ? item.fair_name_bn : item.fair_name }}</td>
                      <td> {{ currentLocale === 'bn' ? item.city_bn : item.city }}, {{ getCountry(item.country_id) }}</td>
                      <td> {{ dateData(item.date_from) }} <b> {{ (currentLocale === 'bn' ? 'হতে' : 'to') }} </b> {{ dateData(item.date_to) }}</td>
                    </tr>
                </template>
              </tbody>
              <tbody v-else>
                <tr>
                  <td colspan="4" class="text-center"> {{ $t('fair_report.not_found') }} </td>
                </tr>
              </tbody>
            </table>
          </b-col>
        </b-row>
        <b-row class="text-right mt-1">
          <b-col> <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-final')">{{ $t('globalTrans.cancel') }}</b-button></b-col>
        </b-row>
      </b-overlay>
    </b-col>
  </b-row>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { getFinalCalanderList } from '../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_calendar'
import moment from 'moment'
export default {
  name: 'Details',
  props: ['items', 'status'],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      finalList: [],
      isResult: false,
      search: {
        type_of_fair: 0
      }
    }
  },
  created () {
    this.getFinalList()
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    typeOfFair () {
      return this.$store.state.TradeFairService.commonObj.typeOfFair.map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    }
  },
  watch: {
    'search.type_of_fair': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.isResult = false
      }
    }
  },
  methods: {
    dateData (fdate) {
      require('moment/min/locales.min')
      moment.locale(this.$i18n.locale)
      const date = moment(fdate).format('Do MMMM, YYYY')
      return date
    },
    getTypeOfFair () {
      const typeObj = this.$store.state.TradeFairService.commonObj.typeOfFair.find(el => el.value === this.search.type_of_fair)
      if (typeObj) {
        return this.$i18n.locale === 'bn' ? typeObj.text_bn : typeObj.text_en
      } else {
        return this.$i18n.locale === 'bn' ? 'সকল' : 'All'
      }
    },
    async getFinalList () {
      this.loading = true
      const params = Object.assign({}, { circular_id: this.items.id, fiscal_year_id: this.items.fiscal_year_id, type_of_fair: this.search.type_of_fair, status: this.status })
      let result = null
      result = await RestApi.getData(internationalTradeFairServiceBaseUrl, getFinalCalanderList, params)
      if (result.success) {
        this.finalList = result.data
        this.loading = false
      }
      this.isResult = true
    },
    getDuration (dateFrom, dateTo) {
        const start = moment(dateFrom, 'YYYY-MM-DD')
        const end = moment(dateTo, 'YYYY-MM-DD')
        const numberOfDays = end.diff(start, 'days')
        if (numberOfDays > 0) {
          const years = Math.floor(numberOfDays / 365)
          const months = Math.floor(numberOfDays % 365 / 30)
          const days = Math.floor(numberOfDays % 365 % 30)

          const yearsDisplay = years > 0 ? this.currentLocale === 'bn' ? this.$n(years) + ' বছর ' : years + (years === 1 ? ' year, ' : ' years, ') : ''
          const monthsDisplay = months > 0 ? this.currentLocale === 'bn' ? this.$n(months) + ' মাস ' : months + (months === 1 ? ' month, ' : ' months, ') : ''
          const daysDisplay = days > 0 ? this.currentLocale === 'bn' ? this.$n(days) + ' দিন ' : days + (days === 1 ? ' day' : ' days') : ''
          return yearsDisplay + monthsDisplay + daysDisplay
        } else {
          return 0
        }
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== undefined) {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getFairType (type) {
      const typeObj = this.$store.state.TradeFairService.commonObj.typeOfFair.find(el => el.value === parseInt(type))
      if (typeObj !== undefined) {
        return this.currentLocale === 'bn' ? typeObj.text_bn : typeObj.text_en
      }
    },
    getFairSector (sector) {
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== undefined) {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getCountry (countryId) {
      const countryObj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === parseInt(countryId))
      if (countryObj !== undefined) {
        return this.currentLocale === 'bn' ? countryObj.text_bn : countryObj.text_en
      }
    },
    pdfExport () {
      this.loading = true
      ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/itf-configuration/report-head/detail', 2, this)
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
