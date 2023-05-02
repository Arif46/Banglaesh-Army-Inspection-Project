<template>
  <div>
  <b-row>
    <b-col lg="12" sm="12">
      <b-overlay :show="loading">
        <b-row>
          <b-col sm="12" class="mt-2 float-right" v-if="isResult">
            <b-button variant="primary" @click="pdfExport" class="mb-2 float-right">
              {{  $t('globalTrans.export_pdf') }}
            </b-button>
          </b-col>
          <b-col sm="12">
            <h3 class="card-title mb-0 text-center"> {{ $t('tradeFairProposalManagement.exportPromotionBureau') }}</h3>
            <h5 class="card-title mb-3 text-center"> <b style="border-bottom: 3px solid #333">{{ '(' + $t('tradeFairProposalManagement.fair_list') }}{{ getFiscalYear(items.fiscal_year_id) }}{{ ') ' + $t('tradeFairProposalManagement.product_wise') }}</b></h5>
          </b-col>
        </b-row>
        <!-- <p v-if="isResult"> {{ $t('externalTradeFair.type_of_fair') }}: {{ getTypeOfFair() }}</p> -->
        <b-row v-if="isResult">
          <b-col lg="12" sm="12">
            <table style="width:100%">
              <thead>
                <tr>
                  <th>{{ $t('globalTrans.sl_no') }}</th>
                  <th>{{ $t('tradeFairProposalManagement.name_and_title') }}</th>
                  <th>{{ $t('tradeFairProposalManagement.city_country') }}</th>
                  <th>{{ $t('externalTradeFair.duration') }}</th>
                </tr>
              </thead>
              <tbody>
                <span hidden>{{ $i = 1 }} {{ $si = 1 }}</span>
                <template v-for="(items, index) in finalList">
                  <tr style="background: #ddd;" :key="index">
                    <td colspan="4"> <span class="mr-3">{{ $n($i++) + '.' }}</span>{{ getFairSector(index) }} </td>
                  </tr>
                    <tr v-for="(item, index2) in items" :key="index2">
                      <td class="text-center"> {{$n($si++)}}</td>
                      <td> {{ currentLocale === 'bn' ? item.fair_name_bn : item.fair_name }}</td>
                      <td> {{ currentLocale === 'bn' ? item.city_bn : item.city }}, {{ getCountry(item.country_id) }}</td>
                      <td> {{ getDuration(item.date_from, item.date_to) }}</td>
                    </tr>
                </template>
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
import ExportPdf from './export_calendar'
import moment from 'moment'
export default {
  name: 'Details',
  props: ['items', 'dropdown'],
  data () {
    return {
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
    if (this.items) {
      this.getFinalList()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
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
      const params = Object.assign({}, { fiscal_year_id: this.items.fiscal_year_id })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, '/portal/itf-calendar-details', params)
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
      const fiscalYearObj = this.$store.state.Portal.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== undefined) {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getFairSector (sector) {
      const sectorObj = this.dropdown.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== 'undefined') {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getCountry (countryId) {
      const countryObj = this.$store.state.Portal.commonObj.countryList.find(el => el.value === parseInt(countryId))
      if (countryObj !== undefined) {
        return this.currentLocale === 'bn' ? countryObj.text_bn : countryObj.text_en
      }
    },
    pdfExport () {
      ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/configuration/report-heading/detail', 2, this)
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
