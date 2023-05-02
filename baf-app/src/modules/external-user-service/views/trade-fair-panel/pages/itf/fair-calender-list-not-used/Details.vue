<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:headerTitle>
            <h5 class="card-title mb-0"> {{ $t('externalTradeFair.fairCalenderInfo') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                   <tr>
                    <th> {{$t('globalTrans.fiscal_year')}}</th>
                    <td>:</td>
                    <td> {{ getFiscalYear(item.fiscal_year_id) }}</td>
                    <th> {{$t('externalTradeFair.circular_memo_no')}}</th>
                    <td>:</td>
                    <td> {{ item.circular.circular_memo_number }}</td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.subject')}}</th>
                    <td>:</td>
                    <td colspan="4"> {{ currentLocale === 'bn' ? item.subject_bn : item.subject_en }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.type_of_fair')}}</th>
                    <td>:</td>
                    <td> {{ getFairType(item.type_of_fair) }}</td>
                    <th> {{$t('externalTradeFair.fair_sector')}}</th>
                    <td>:</td>
                    <td> {{ getFairSector(item.sectors) }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.fair_name')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.fair_name_bn : item.fair_name }} </td>
                    <th> {{$t('externalTradeFair.date_from')}}</th>
                    <td>:</td>
                    <td> {{ item.date_from | dateFormat}} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.date_to')}}</th>
                    <td>:</td>
                    <td> {{ item.date_to | dateFormat }}</td>
                    <th> {{$t('externalTradeFair.duration')}}</th>
                    <td>:</td>
                    <td> {{ getDuration(item.date_from, item.date_to) }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.country')}}</th>
                    <td>:</td>
                    <td> {{ getCountry(item.country_id) }}</td>
                    <th> {{$t('externalTradeFair.city')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.city_bn : item.city }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.product_service_exhibited')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.product_service_exhibited_bn : item.product_service_exhibited }} </td>
                    <th> {{$t('externalTradeFair.name_of_organizer')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.name_of_organizer_bn : item.name_of_organizer }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.proposed_by')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.proposed_by_bn : item.proposed_by }} </td>
                    <th> {{$t('externalTradeFair.organizer_profile')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.organizer_profile_bn : item.organizer_profile }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.costs_scheme_stands_services')}}</th>
                    <td>:</td>
                    <td> {{ $n(item.costs_scheme_stands_services) }}</td>
                    <th> {{$t('externalTradeFair.prospect_bangladeshi_exhibitors')}}</th>
                    <td>:</td>
                    <td> {{ currentLocale === 'bn' ? item.prospect_bangladeshi_exhibitors_bn : item.prospect_bangladeshi_exhibitors }} </td>
                  </tr>
                  <tr>
                    <th> {{$t('externalTradeFair.remarks')}}</th>
                    <td>:</td>
                    <td> {{ item.remarks }}</td>
                    <th> {{$t('globalTrans.attachment')}}</th>
                    <th>:</th>
                    <td><a target="_blank" v-if="item.attachment" :href="internationalTradeFairServiceBaseUrl + 'storage/calender-info/attachment/' + item.attachment">{{ $t('globalTrans.download')}} <i class="ri-download-cloud-fill"></i> </a> </td>
                  </tr>
                </table>
              </b-col>
              <b-col lg="12" sm="12">
                <p class="mb-2"><b>{{ $t('externalTradeFair.visitors_profile_of_last_year_event') }}</b> :</p>
              </b-col>
              <b-col lg="12" sm="12">
                <p v-if="currentLocale === 'en'" v-html="item.visitors_profile_of_last_year_event"></p>
                <p v-else v-html="item.visitors_profile_of_last_year_event_bn"></p>
              </b-col>
              <b-col lg="12" sm="12" class="mt-2">
                <b>{{ $t('externalTradeFair.exhibitors_profile_of_last_year_event') }} :</b>
              </b-col>
              <b-col lg="12" sm="12">
                <p v-if="currentLocale === 'en'" v-html="item.exhibitors_profile_of_last_year_event"></p>
                <p v-else v-html="item.exhibitors_profile_of_last_year_event_bn"></p>
              </b-col>
            </b-row>
          </template>
        </body-card>
        <body-card class="mt-1 personInfo">
          <template v-slot:headerTitle>
            <h5 class="card-title mb-0"> {{ $t('externalTradeFair.fairCalenderGiverInfo') }}</h5>
          </template>
          <template v-slot:body>
            <b-row>
              <b-col lg="12" sm="12">
                <table class="table table-borderless">
                  <tr>
                    <td> {{ $t('globalTrans.name') }} </td>
                    <td> : </td>
                    <td> {{ currentLocale === 'bn' ? item.name_bn : item.name }} </td>
                    <td> {{ $t('globalTrans.email') }} </td>
                    <td> : </td>
                    <td> {{ item.email }} </td>
                  </tr>
                  <tr>
                    <td> {{ $t('globalTrans.mobile') }} </td>
                    <td> : </td>
                    <td> {{ item.mobile_no }} </td>
                    <td> {{ $t('globalTrans.org_name') }} </td>
                    <td> : </td>
                    <td> {{ currentLocale === 'bn' ? item.org_name_bn : item.org_name }} </td>
                  </tr>
                  <tr>
                    <td> {{ $t('globalTrans.designation') }} </td>
                    <td> : </td>
                    <td colspan="5"> {{ currentLocale === 'bn' ? item.designation_bn : item.designation }} </td>
                  </tr>
                </table>
              </b-col>
            </b-row>
          </template>
        </body-card>
            <b-row class="text-right mt-1">
              <b-col>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('modal-detail')">{{ $t('globalTrans.cancel') }}</b-button>
              </b-col>
            </b-row>
      </b-col>
    </b-row>
</template>
<script>
import { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import moment from 'moment'
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      internationalTradeFairServiceBaseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loading: false,
      item: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getCalenderInfo()
      this.item = tmp
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getCalenderInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
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
          this.formData.date_from = ''
          this.formData.date_to = ''
        }
    },
    getFiscalYear (fiscalYear) {
      const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscal => fiscal.value === parseInt(fiscalYear))
      if (fiscalYearObj !== 'undefined') {
        return this.currentLocale === 'bn' ? fiscalYearObj.text_bn : fiscalYearObj.text_en
      }
    },
    getFairType (type) {
      const typeObj = this.$store.state.ExternalUserService.tradeFair.commonObj.typeOfFair.find(el => el.value === parseInt(type))
      if (typeObj !== 'undefined') {
        return this.currentLocale === 'bn' ? typeObj.text_bn : typeObj.text_en
      }
    },
    getFairSector (sector) {
      const sectorAll = []
      sector.map(item => {
        const sectorObj = this.$store.state.ExternalUserService.tradeFair.commonObj.fairSectorList.find(el => el.value === parseInt(item.fair_sector_id))
        if (sectorObj !== 'undefined') {
          sectorAll.push(this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en)
        }
      })
      return sectorAll.join()
    },
    getCountry (countryId) {
      const countryObj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === parseInt(countryId))
      if (countryObj !== 'undefined') {
        return this.currentLocale === 'bn' ? countryObj.text_bn : countryObj.text_en
      }
    }
  }
}
</script>
<style>
  .card-header {
    background: #77a0cb;
  }
  .personInfo .card-header {
    padding: 5px 10px;
  }
  .card-header h5 { color: #fff; }
</style>
