<template>
  <div class="section-wrapper">
      <card>
        <template v-slot:searchBody>
          <b-row>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" offset="1">
              <ValidationProvider name="Award Type" vid="award_type" rules="required">
                <b-form-group
                  label-for="award_type"
                >
                <template v-slot:label>
                  {{$t('exportTrophyConfig.awardType')}}
                </template>
                <b-form-select
                  plain
                  v-model="search.award_type"
                  :options="assignTypeList"
                  id="award_type"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=3>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="hideFiscalYear">
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
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="hideYear">
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
              <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
                <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
              </b-button>
            </b-col>
          </b-row>
        </template>
      </card>
      <!--Cip && Export Trophy  award type wise search line card-->
      <b-overlay :show ="loader">
        <div class="form-wrapper bms-db-wrapper etcs-db-wrapper">
          <b-row>
            <template v-if="search.award_type === 1">
              <b-col sm="4">
                <div class="bms-item cases">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.total_cip_application') }}</p>
                  <i class="ri-checkbox-circle-fill"></i>
                  <h4 class="count">{{ cipDatas.totalCipApplication ? $n(cipDatas.totalCipApplication) : $n(0)}}</h4>
                </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item market">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.epb_sorting_list') }}</p>
                  <i class="ri-open-arm-fill"></i>
                  <h4 class="count">{{ cipDatas.EPBSorting ? $n(cipDatas.EPBSorting) : $n(0) }}</h4>
                </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item fine-amount">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.total_gazette_approved') }}</p>
                  <i class="ri-exchange-funds-fill"></i>
                  <h4 class="count">{{ cipDatas.totalGazetteApprove ? $n(cipDatas.totalGazetteApprove) : $n(0) }}</h4>
                </div>
              </b-col>
            </template>
            <template v-if="search.award_type === 2">
              <b-col sm="4">
                <div class="bms-item cases">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.total_export_trophy_application') }}</p>
                  <i class="ri-checkbox-multiple-fill"></i>
                    <h4 class="count">{{ exportTrophyData.totalExportTrophyApp ?  $n(exportTrophyData.totalExportTrophyApp) : $n(0) }}</h4>
                </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item commodity">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.epb_sorting_list') }}</p>
                  <i class="ri-picture-in-picture-line"></i>
                  <h4 class="count">{{ exportTrophyData.EPBSorting ?  $n(exportTrophyData.EPBSorting) : $n(0) }}</h4>
                </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item market">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.total_gazette_approved') }}</p>
                  <i class="ri-shield-check-fill"></i>
                  <h4 class="count">{{ exportTrophyData.totalGazetteApprove ? $n(exportTrophyData.totalGazetteApprove) : $n(0)}}</h4>
                </div>
              </b-col>
            </template>
          </b-row>
        </div>
        <!--Cip All Search-->
        <div class="form-wrapper bms-db-wrapper etcs-db-wrapper">
          <b-row  v-if="search.award_type === 3">
            <template>
              <b-col sm="4">
                  <div class="bms-item cases">
                    <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                    <p class="title">{{ $t('exportTrophyConfig.total_cip_application') }}</p>
                    <i class="ri-checkbox-circle-fill"></i>
                    <h4 class="count">{{ cipDatas.totalCipApplication ?  $n(cipDatas.totalCipApplication) : $n(0)}}</h4>
                  </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item market">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.epb_sorting_list') }}</p>
                  <i class="ri-open-arm-fill"></i>
                  <h4 class="count">{{ cipDatas.EPBSorting ? $n(cipDatas.EPBSorting) : $n(0) }}</h4>
                </div>
              </b-col>
              <b-col sm="4">
                <div class="bms-item fine-amount">
                  <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                  <p class="title">{{ $t('exportTrophyConfig.total_gazette_approved') }}</p>
                  <i class="ri-exchange-funds-fill"></i>
                  <h4 class="count">{{ cipDatas.totalGazetteApprove ? $n(cipDatas.totalGazetteApprove) : $n(0) }}</h4>
                </div>
              </b-col>
            </template>
          </b-row>
          <b-row  v-if="search.award_type === 3">
            <div class="mt-3">
              <b-card class="mt-3" :title="cipTitle">
                <div id="chart">
                  <apexchart type="bar" height="350" :options="CipChartOptions" :series="cipAllSeries"></apexchart>
                </div>
              </b-card>
            </div>
          </b-row>
        </div>
        <!--Export Trophy All Condition Search-->
        <div class="form-wrapper bms-db-wrapper etcs-db-wrapper">
          <b-row v-if="search.award_type === 3">
            <template>
               <b-col sm="4">
                  <div class="bms-item cases">
                    <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                    <p class="title">{{ $t('exportTrophyConfig.total_export_trophy_application') }}</p>
                    <i class="ri-checkbox-multiple-fill"></i>
                     <h4 class="count">{{ exportTrophyData.totalExportTrophyApp ?  $n(exportTrophyData.totalExportTrophyApp) : $n(0) }}</h4>
                  </div>
                </b-col>
                <b-col sm="4">
                  <div class="bms-item commodity">
                    <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                    <p class="title">{{ $t('exportTrophyConfig.epb_sorting_list') }}</p>
                    <i class="ri-picture-in-picture-line"></i>
                    <h4 class="count">{{ exportTrophyData.EPBSorting ? $n(exportTrophyData.EPBSorting) : $n(0) }}</h4>
                  </div>
                </b-col>
                <b-col sm="4">
                  <div class="bms-item market">
                    <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
                    <p class="title">{{ $t('exportTrophyConfig.total_gazette_approved') }}</p>
                    <i class="ri-shield-check-fill"></i>
                    <h4 class="count">{{ exportTrophyData.totalGazetteApprove  ? $n(exportTrophyData.totalGazetteApprove) : $n(0)}}</h4>
                  </div>
                </b-col>
            </template>
          </b-row>
          <b-row v-if="search.award_type === 3">
              <b-card class="mt-3" :title="exportTrophyTitle">
              <div id="chart">
                <apexchart type="bar" height="350" :options="exportTrophyChartOptions" :series="exportTrophyAllSeries"></apexchart>
              </div>
            </b-card>
          </b-row>
        </div>
        <!--Cip && Export Trophy  Award Type Wise search Line chart-->
        <row>
          <template v-if="search.award_type === 1">
            <b-card class="mt-3" :title="cipTitle">
              <div id="chart">
                <apexchart type="bar" height="350" :options="CipChartOptions" :series="cipSeries"></apexchart>
              </div>
            </b-card>
          </template>
          <template v-if="search.award_type === 2">
            <b-card class="mt-3" :title="exportTrophyTitle">
              <div id="chart">
                <apexchart type="bar" height="350" :options="exportTrophyChartOptions" :series="exportTrophySeries"></apexchart>
              </div>
            </b-card>
          </template>
        </row>
       </b-overlay>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { cipDashboardList, exportTrophyApiList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import moment from 'moment'

export default {
  mixins: [ModalBaseMasterList],
  data () {
    return {
      search: {
        award_type: 3,
        fiscal_year_id: 0,
        year: 0
      },
      currentYear: moment().format('YYYY'),
      cipDatas: [],
      hideFiscalYear: false,
      hideYear: false,
      showdata: false,
      loader: false,
      cipApplicationData: [],
      cipGazApproveData: [],
      cipCategories: [],
      exportTrophyData: [],
      exportTrophyApplicationData: [],
      exportTrophyGazApproveData: [],
      exportTrophyCategories: [],
      currentFiscalYearId: 0,
      currentFiscalSortingId: 0
    }
  },
  created () {
    this.setCurrentFiscalYear()
    this.CipDashboard()
    this.exportTrophyDashboard()
  },
  computed: {
    cipSeries () {
      return [{
          name: this.$t('exportTrophyConfig.total_cip_application'),
          data: this.cipApplicationData
        }, {
          name: this.$t('exportTrophyConfig.total_gazette_approved'),
          data: this.cipGazApproveData
      }]
    },
    cipAllSeries () {
      return [{
          name: this.$t('exportTrophyConfig.total_cip_application'),
          data: this.cipApplicationData
        }, {
          name: this.$t('exportTrophyConfig.total_gazette_approved'),
          data: this.cipGazApproveData
      }]
    },
    exportTrophySeries () {
      return [{
          name: this.$t('exportTrophyConfig.total_cip_application'),
          data: this.exportTrophyApplicationData
        }, {
          name: this.$t('exportTrophyConfig.total_gazette_approved'),
          data: this.cipGazApproveData
      }]
    },
    exportTrophyAllSeries () {
      return [{
          name: this.$t('exportTrophyConfig.total_cip_application'),
          data: this.exportTrophyApplicationData
        }, {
          name: this.$t('exportTrophyConfig.total_gazette_approved'),
          data: this.cipGazApproveData
      }]
    },
    cipTitle () {
      return this.$t('exportTrophyConfig.cip_data_chart')
    },
    exportTrophyTitle () {
      return this.$t('exportTrophyConfig.export_trophy_data_chart')
    },
    CipChartOptions () {
      return {
        chart: {
            type: 'bar',
            height: 350
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          }
        },
        dataLabels: {
          enabled: true,
          formatter: function (val) {
            return val
          },
          style: {
            fontSize: '12px',
            colors: ['#304758']
          }
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: this.cipCategories
        },
        yaxis: {
          title: {
            text: ''
          }
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val
            }
          }
        }
      }
    },
    exportTrophyChartOptions () {
      return {
        chart: {
            type: 'bar',
            height: 350
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: '55%',
            endingShape: 'rounded'
          }
        },
        dataLabels: {
          enabled: true,
          formatter: function (val) {
            return val
          },
          style: {
            fontSize: '12px',
            colors: ['#304758']
          }
        },
        stroke: {
          show: true,
          width: 2,
          colors: ['transparent']
        },
        xaxis: {
          categories: this.exportTrophyCategories
        },
        yaxis: {
          title: {
            text: ''
          }
        },
        fill: {
          opacity: 1
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val
            }
          }
        }
      }
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    yearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, sorting_order: item.sorting_order, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, sorting_order: item.sorting_order, text: item.text_en }
        }
      })
    }
  },
  watch: {
    'search.award_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal === 1) {
          this.CipDashboard()
          this.hideYear = true
          this.hideFiscalYear = false
        }
        if (newVal === 2) {
          this.exportTrophyDashboard()
          this.hideFiscalYear = true
          this.hideYear = false
        }
      }
    }
  },
  methods: {
    currentLocale () {
      return this.$i18n.locale
    },
    searchData () {
      this.CipDashboard()
      this.exportTrophyDashboard()
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    setCurrentFiscalYear () {
      const tmpFiscalYearList = this.fiscalYearList
      if (tmpFiscalYearList.length === 0) {
        return
      }
      const currentDate = new Date()
      const [month, year] = [currentDate.getMonth() + 1, currentDate.getFullYear()]
      /** Define the year position  */
      const yearPosition = month < 7 ? 5 : 0
      const yearStr = `${year}`
      tmpFiscalYearList.forEach(element => {
        if (element.text.indexOf(yearStr) === yearPosition) {
          this.currentFiscalYearId = element.value
          this.currentFiscalSortingId = element.sorting_order
        }
      })
    },
    async CipDashboard () {
      this.loader = true
      const params = Object.assign({}, this.search)
      this.cipApplicationData = []
      this.cipGazApproveData = []
      this.cipCategories = []
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, cipDashboardList, params)
      this.loader = false
      if (result.success) {
        this.cipDatas = result.data
        const yearListValues = this.cipDatas.cipDataChart
        const tmpYearList = this.yearList.filter(el => el.value <= this.currentYear).slice(-5)

        return tmpYearList.map(el => {
          const tmpYearVal = yearListValues.find(tmp => parseInt(tmp.year) === parseInt(el.value))

          const year = el.text
          const totalApplication = typeof tmpYearVal !== 'undefined' ? parseInt(tmpYearVal.totalApplication) : 0
          const totalGazete = typeof tmpYearVal !== 'undefined' ? parseInt(tmpYearVal.totalGazete) : 0

          this.cipApplicationData.push(parseInt(totalApplication))
          this.cipGazApproveData.push(parseInt(totalGazete))
          this.cipCategories.push(year)
        })
      } else {
        this.cipDatas = this.cipApplicationData = this.cipGazApproveData = this.cipCategories = []
      }
    },
    async exportTrophyDashboard () {
      this.loader = true
      const params = Object.assign({}, this.search)
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, exportTrophyApiList, params)
      this.loader = false
      if (result.success) {
        this.exportTrophyData = result.data
        const fiscalYearListValues = this.exportTrophyData.exportDataChart
        const tmpFiscalYearList = this.fiscalYearList.filter(el => {
          if (el.sorting_order <= this.currentFiscalSortingId) {
            return el
          }
        }).filter(el => el.value <= this.currentFiscalYearId).slice(-5)

        this.exportTrophyApplicationData = []
        this.exportTrophyGazApproveData = []
        this.exportTrophyCategories = []

        return tmpFiscalYearList.map(el => {
          const tmpFiscalYearVal = fiscalYearListValues.find(tmp => parseInt(tmp.fiscalYear) === parseInt(el.value))

          const fiscalYear = el.text
          const totalApplication = typeof tmpFiscalYearVal !== 'undefined' ? parseInt(tmpFiscalYearVal.totalApplication) : 0
          const totalGazete = typeof tmpFiscalYearVal !== 'undefined' ? parseInt(tmpFiscalYearVal.totalGazete) : 0

          this.exportTrophyApplicationData.push(parseInt(totalApplication))
          this.exportTrophyGazApproveData.push(parseInt(totalGazete))
          this.exportTrophyCategories.push(fiscalYear)
        })
      } else {
        this.exportTrophyData = this.exportTrophyApplicationData = this.exportTrophyGazApproveData = this.exportTrophyCategories = []
      }
    }
  }
}
</script>

<style>
  .mc-report-card {
    position: relative;
    margin-bottom: 10px;
    border-radius: var(--border-radius-md);
  }
  .icon-wrapper {
    position: absolute;
    top: 50%;
    right: 5px;
    transform: translate(0, -50%);
    color: rgba(255, 255, 255, .3);
    font-size: 3.6rem;
  }
</style>
