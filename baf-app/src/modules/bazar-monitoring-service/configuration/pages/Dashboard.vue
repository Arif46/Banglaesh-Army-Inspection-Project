<template>
  <div class="section-wrapper">
    <breadcumb />
    <b-overlay :show="loading">
      <div class="form-wrapper bms-db-wrapper">
        <b-row>
          <b-col sm="6" md="6" lg="3">
            <div class="bms-item market">
              <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
              <p class="title"><i class="ri-store-2-line"></i> {{ $t('bazarMonitoring.total_market') }}</p>
              <h4 class="count" style="margin: 10px 0 6px;">{{ $n(dashboardData.totalMarketDirectories) }}</h4>
              <div class="sub-item">
                <div>
                  <small>{{ $t('bazarMonitoring.today_monitor') }}</small>
                  <p class="sub-count">{{ $n(dashboardData.totalMarketDirectoriesTodayMonitored) }}</p>
                </div>
                <div>
                  <small>{{ $t('bazarMonitoring.this_month_monitor') }}</small>
                  <p class="sub-count">{{ $n(dashboardData.totalMarketDirectoriesMonthMonitored) }}</p>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="6" md="6" lg="3">
            <div class="bms-item cases">
              <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
              <p class="title"><i class="ri-file-damage-line"></i> {{ $t('bazarMonitoring.total_cases') }}</p>
              <h4 class="count">{{ $n(dashboardData.totalCases) }}</h4>
              <div class="sub-item">
                <div>
                  <small>{{ $t('bazarMonitoring.today_cases') }}</small>
                  <p class="sub-count">{{ $n(dashboardData.totalCasesToday) }}</p>
                </div>
                <div>
                  <small>{{ $t('bazarMonitoring.this_month_cases') }}</small>
                  <p class="sub-count">{{ $n(dashboardData.totalCasesMonth) }}</p>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="6" md="6" lg="3">
            <div class="bms-item fine-amount">
              <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
              <p class="title"><i class="ri-exchange-funds-fill"></i> {{ $t('bazarMonitoring.total_fine_amount') }}</p>
              <h4 class="count"><sup>৳</sup>{{ $n(dashboardData.totalFineAmount) }}</h4>
              <div class="sub-item">
                <div>
                  <small>{{ $t('bazarMonitoring.today_fine') }}</small>
                  <p class="sub-count"><span>৳</span>{{ $n(dashboardData.totalFineAmountToday) }}</p>
                </div>
                <div>
                  <small>{{ $t('bazarMonitoring.this_month_fine') }}</small>
                  <p class="sub-count"><span>৳</span>{{ $n(dashboardData.totalFineAmountMonth) }}</p>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="6" md="6" lg="3">
            <div class="bms-item commodity">
              <svg viewBox="0 0 1440 320"><path fill-opacity="1" d="M0,96L48,122.7C96,149,192,203,288,192C384,181,480,107,576,90.7C672,75,768,117,864,165.3C960,213,1056,267,1152,261.3C1248,256,1344,192,1392,160L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path></svg>
              <p class="title"><i class="ri-picture-in-picture-line"></i> {{ $t('bazarMonitoring.total_commodity') }}</p>
              <h4 class="count">
                {{ $n(commodityNameList.length) }}
                <!-- <small style="color:#a1a1a3;font-size: 1rem;">({{ $t('bazarMonitoring.products') }})</small> -->
              </h4>
              <marquee class="bazar-name-wrapper">
                <h6 class="bazar-name-item" v-for="(item, index) in commodityNameList" :key="index"><b-badge>{{ currentLocale === 'en'? item.text_en : item.text_bn }}</b-badge></h6>
              </marquee>
              <!-- <div class="sub-item">
                <div>
                  <small>Today Fine</small>
                  <p class="sub-count"><span>৳</span> 545</p>
                </div>
                <div>
                  <small>This Month Fine</small>
                  <p class="sub-count"><span>৳</span> 65,000</p>
                </div>
              </div> -->
            </div>
          </b-col>
        </b-row>
        <b-row>
          <b-col lg="6">
            <b-card class="mt-3" :title="$t('bazarMonitoring.month_wise_total_cases_chart')">
              <apexchart type="bar" height="350" class="bar-chart-wrapper" :options="chartOptionsCases" :series="seriesCases"></apexchart>
            </b-card>
          </b-col>
          <b-col lg="6">
            <b-card class="mt-3" :title="$t('bazarMonitoring.month_wise_total_fine_chart')">
              <apexchart type="bar" height="350" class="bar-chart-wrapper" :options="chartOptionsFines" :series="seriesFines"></apexchart>
            </b-card>
          </b-col>
        </b-row>
      </div>
    </b-overlay>
  </div>
</template>
<script>
import RestApi, { bazarMonitoringServiceBaseUrl } from '@/config/api_config'

export default {
  data () {
    return {
      dashboardData: {
        totalMarketDirectories: 0,
        totalMarketDirectoriesTodayMonitored: 0,
        totalMarketDirectoriesMonthMonitored: 0,
        totalCases: 0,
        totalCasesToday: 0,
        totalCasesMonth: 0,
        totalFineAmount: 0,
        totalFineAmountToday: 0,
        totalFineAmountMonth: 0,
        monthWiseCaseInfo: [],
        monthWiseFineAmountInfo: []
      },
      loading: false,
      seriesDataCases: [],
      categoriesDataCases: [],
      categoriesDataCasesBn: [],
      seriesDataFines: [],
      categoriesDataFines: [],
      categoriesDataFinesBn: []
    }
  },
  computed: {
    commodityNameList () {
      return this.$store.state.BazarMonitoringService.commonObj.commodityNameList
    },
    // monthList () {
    //   return this.$store.state.commonObj.monthList
    // },
    currentLocale () {
      return this.$i18n.locale
    },
    monthList () {
      const monthList = []
      for (let i = 0; i <= 11; i++) {
        const shortMonth = new Date(2020, i, 22).toLocaleString('en-us', { month: 'short' })
        monthList.push(shortMonth)
      }
      return monthList
    },
    monthListBn () {
      const monthList = []
      for (let i = 0; i <= 11; i++) {
        const shortMonth = new Date(2020, i, 22).toLocaleString('bn-bd', { month: 'short' })
        monthList.push(shortMonth)
      }
      return monthList
    },
    seriesCases () {
      return [{
        data: this.seriesDataCases
      }]
    },
    chartOptionsCases () {
      return {
        chart: {
          type: 'bar',
          height: 350
        },
        plotOptions: {
          bar: {
            borderRadius: 3,
            horizontal: false,
            columnWidth: '70%'
          }
        },
        dataLabels: {
          enabled: false
        },
        xaxis: {
          title: {
            text: this.$t('globalTrans.month')
          },
          categories: this.currentLocale === 'en' ? this.categoriesDataCases : this.categoriesDataCasesBn
        },
        yaxis: {
          title: {
            text: this.$t('bazarMonitoring.no_of_cases')
          }
        }
      }
    },
    seriesFines () {
      return [{
        data: this.seriesDataFines
      }]
    },
    chartOptionsFines () {
      return {
        chart: {
          type: 'bar',
          height: 350
        },
        plotOptions: {
          bar: {
            borderRadius: 3,
            horizontal: false,
            columnWidth: '70%'
          }
        },
        dataLabels: {
          enabled: false
        },
        xaxis: {
          title: {
            text: this.$t('globalTrans.month')
          },
          categories: this.currentLocale === 'en' ? this.categoriesDataFines : this.categoriesDataFinesBn
        },
        yaxis: {
          title: {
            text: this.$t('bazarMonitoring.price')
          }
        }
      }
    }
  },
  created () {
    this.loadData()
  },
  methods: {
    async loadData () {
      this.loading = true
      this.seriesDataCases = []
      this.categoriesDataCases = []
      this.categoriesDataCasesBn = []
      this.seriesDataFines = []
      this.categoriesDataFines = []
      this.categoriesDataFinesBn = []
      const result = await RestApi.getData(bazarMonitoringServiceBaseUrl, 'dashboard')
      if (result.success) {
        this.dashboardData = result.data
        // if (this.dashboardData.monthWiseCaseInfo.length) {
        //   this.dashboardData.monthWiseCaseInfo.forEach(item => {
        //     this.seriesDataCases.push(parseFloat(item.total_cases))
        //     const monthIndex = parseInt(item.month) - 1
        //     this.categoriesDataCases.push(this.monthList[monthIndex])
        //   })
        // }
        this.monthList.forEach((item, mothIndex) => {
          const seriesDataItem = this.dashboardData.monthWiseCaseInfo.find(obj => obj.month === (parseInt(mothIndex) + 1))
          const totalCases = seriesDataItem !== undefined ? seriesDataItem.total_cases : 0
          this.seriesDataCases.push(parseFloat(totalCases))
          this.categoriesDataCases.push(item)
          this.categoriesDataCasesBn.push(this.monthListBn[mothIndex])

          const seriesDataItem2 = this.dashboardData.monthWiseFineAmountInfo.find(obj => obj.month === (parseInt(mothIndex) + 1))
          const totalFines2 = seriesDataItem2 !== undefined ? seriesDataItem2.total_fine_amount : 0
          this.seriesDataFines.push(parseFloat(totalFines2))
          this.categoriesDataFines.push(item)
          this.categoriesDataFinesBn.push(this.monthListBn[mothIndex])
        })
        // if (this.dashboardData.monthWiseFineAmountInfo.length) {
        //   this.dashboardData.monthWiseFineAmountInfo.forEach(item => {
        //     this.seriesDataFines.push(parseFloat(item.total_fine_amount))
        //     const monthIndex = parseInt(item.month) - 1
        //     this.categoriesDataFines.push(this.monthList[monthIndex])
        //   })
        // }
        // this.monthList.forEach((item, mothIndex) => {
        //   const seriesDataItem = this.dashboardData.monthWiseFineAmountInfo.find(obj => obj.month === (parseInt(mothIndex) + 1))
        //   const totalFines = seriesDataItem !== undefined ? seriesDataItem.total_fine_amount : 0
        //   this.seriesDataFines.push(parseFloat(totalFines))
        //   this.categoriesDataFines.push(item)
        //   this.categoriesDataFinesBn.push(this.monthListBn[mothIndex])
        // })
      } else {
        this.dashboardData = Object.assign({}, this.dashboardData, {
          totalMarketDirectories: 0,
          totalMarketDirectoriesTodayMonitored: 0,
          totalMarketDirectoriesMonthMonitored: 0,
          totalCases: 0,
          totalCasesToday: 0,
          totalCasesMonth: 0,
          totalFineAmount: 0,
          totalFineAmountToday: 0,
          totalFineAmountMonth: 0,
          monthWiseCaseInfo: [],
          monthWiseFineAmountInfo: []
        })
      }
      this.loading = false
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
  .bar-chart-wrapper {
    padding: 15px 0;
  }
  /* .bar-chart-wrapper svg path {
    fill: #77a0cb;
  } */
</style>
