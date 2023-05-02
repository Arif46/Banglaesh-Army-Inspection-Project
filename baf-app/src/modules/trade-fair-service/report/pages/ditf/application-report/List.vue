<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('fair_report.application_report') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col sm="4">
            <b-form-group
              label-for="year"
            >
              <template v-slot:label>
                {{ $t('globalTrans.year') }} <span class="text-danger">*</span>
              </template>
              <b-form-select
                plain
                id="year"
                :options="yearList"
                v-model="search.year"
              >
                <!-- <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template> -->
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="fair_id"
            >
              <template v-slot:label>
                {{ $t('tradeFairConfig.fair_name') }}
              </template>
              <b-form-select
                disabled
                plain
                id="fair_id"
                :options="dhakaFairList"
                v-model="search.fair_id"
              >
                <template v-slot:first>
                  <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
              </b-form-select>
            </b-form-group>
          </b-col>
          <b-col sm="4">
            <b-form-group
              label-for="circular_type"
            >
              <template v-slot:label>
                {{ $t('ditfTradeFairManages.circular_type') }}
              </template>
              <b-form-select
                plain
                id="circular_type"
                :options="circularTypeList"
                v-model="search.circular_type"
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
        <h4 class="card-title">{{ $t('fair_report.application_report') }} {{ $t('globalTrans.list') }}</h4>
      </template>
      <template v-slot:headerAction>
        <b-button v-if="isResult && finalList.length === undefined" variant="primary" size="sm" @click="pdfExport" class="float-right">
            {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="loadingState">
          <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('fair_report.application_report') }}
          </list-report-head>
          <b-row class="mb-2">
            <b-col md="4">
              <span>{{ $t('globalTrans.year') }}</span>:
              <strong>{{ parseInt(search_param.year) ? $n(search_param.year, {useGrouping: false}) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-right">
              <span>{{ $t('tradeFairConfig.fair_name') }}</span>:
              <strong>{{ parseInt(search_param.fair_id) ? getSearchParamName(search_param.fair_id, 'fair') : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="4" class="text-center">
              <span>{{ $t('ditfTradeFairManages.circular_type') }}</span>:
              <strong>{{ parseInt(search_param.circular_type) ? getSearchParamName(search_param.circular_type, 'cType') : $t('globalTrans.all') }}</strong>
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
                        <th>{{ $t('globalTrans.application_id') }}</th>
                        <th>{{ $t('globalTrans.year') }}</th>
                        <th>{{ $t('globalTrans.applicant_name') }}</th>
                        <th>{{ $t('globalTrans.mobile') }}</th>
                        <th>{{ $t('globalTrans.org_name') }}</th>
                        <th>{{ $t('globalTrans.org_address') }}</th>
                      </tr>
                    </thead>
                    <tbody v-if="isResult && finalList.length === undefined">
                      <span hidden>{{ $si = 1 }}</span>
                      <template v-for="(items, index) in finalList">
                        <tr style="background: #ddd;" :key="index">
                          <td colspan="7" class="text-left">{{ circularType(index) }} </td>
                        </tr>
                          <tr v-for="(item, index2) in items" :key="index2+index">
                            <td class="text-center"> {{$n($si++)}}</td>
                            <td>{{ item.app_auto_id }}</td>
                            <td>{{ $n(item.year,{useGrouping:false}) }}</td>
                            <td>{{ currentLocale === 'bn' ? item.name_bn : item.name_en }}</td>
                            <td>{{ item.mobile_no }}</td>
                            <td>{{ currentLocale === 'bn' ? item.comp_name_bn : item.comp_name_en }}</td>
                            <td>
                              <span v-if="item.country_type === 1">
                                {{ getCountry(item.country_id) }}
                              </span>
                              <span v-else>
                                {{ (currentLocale === 'bn' ? item.city_bn : item.city_en) + ', ' + (currentLocale === 'bn' ? item.state_bn : item.state_en) + ', ' + getCountry(item.country_id)}}
                              </span>
                            </td>
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
import { ditfApplicationReport } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      sortBy: '',
      detailsItemId: '',
      isResult: false,
      itemData: [],
      finalList: [],
      dhakaFairList: [],
      search: {
        year: 0,
        fair_id: 0,
        circular_type: 0
      },
      search_param: {
        year: 0,
        fair_sector_id: 0,
        fair_name_id: 0
      },
      actions: {
        edit: true,
        details: false,
        toogle: true,
        delete: false
      }
    }
  },
  created () {
    const currentDate = new Date()
    const currentYear = currentDate.getFullYear()
    this.search.year = currentYear
    this.loadData()
  },
  watch: {
    'search.year': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.dhakaFairList = this.dhakaFair()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
      }
    }
  },
  computed: {
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    circularTypeList () {
      return this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    circularType (fair) {
      const sectorObj = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(el => el.value === parseInt(fair))
      if (sectorObj !== undefined) {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getCountry (id) {
      const sectorObj = this.$store.state.CommonService.commonObj.countryList.find(el => el.value === parseInt(id))
      if (sectorObj !== undefined) {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getSearchParamName (Id, paramName) {
      let arrayData
      if (paramName === 'fair') {
        arrayData = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList
      } else if (paramName === 'cType') {
        arrayData = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList
      } else {
        return ''
      }
      const Obj = arrayData.find(el => el.value === parseInt(Id))
      if (typeof Obj !== 'undefined') {
        return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
      } else {
        return ''
      }
    },
    dhakaFair () {
      return this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.filter(item => item.year === this.search.year).map(item => {
        if (item !== '') {
          this.search.fair_id = item.value
        }
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, ditfApplicationReport, this.search)
      if (result.success) {
        this.search_param = result.search_data
        this.finalList = result.data
        this.isResult = true
      } else {
        this.finalList = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getRelationalData (data) {
        const mapData = data.map((item, index) => {
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(item.fair_circular.fiscal_year_id))
          const fairSector = this.$store.state.TradeFairService.commonObj.fairSectorList.find(obj => obj.value === parseInt(item.fair_circular.calendar_info.fair_sector_id))
          const customItem = {
            fair_name_en: item.fair_circular.calendar_info.fair_name,
            fair_name_bn: item.fair_circular.calendar_info.fair_name_bn,
            fiscal_year_en: fiscalYear?.text_en,
            fiscal_year_bn: fiscalYear?.text_bn,
            fair_sector_en: fairSector?.text_en,
            fair_sector_bn: fairSector?.text_bn
          }
          return Object.assign({}, item, { serial: index }, customItem)
      })
      return mapData
    },
    getCompanyTypeName (id) {
      const companyType = this.$store.state.TradeFairService.commonObj.companyTypeList.find(obj => obj.value === parseInt(id))
      if (typeof companyType !== 'undefined') {
        return this.$i18n.locale === 'en' ? companyType.text_en : companyType.text_bn
      } else {
        return ''
      }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, year: this.search.year, circular_type: this.search.circular_type, fair_id: this.search.fair_id })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, ditfApplicationReport, params)
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
