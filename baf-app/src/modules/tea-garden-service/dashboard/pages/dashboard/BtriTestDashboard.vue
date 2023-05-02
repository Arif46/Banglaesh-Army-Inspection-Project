<template>
    <div class="section-wrapper soil-test-wrapper">
        <breadcumb />
        <b-overlay :show="loading">
        <div class="form-wrapper">
            <b-row>
                <b-col>
                    <b-card :title="$t('globalTrans.search')">
                        <b-card-text>
                        <b-row>
                            <!-- check box all  -->
                        <b-col xs="12" sm="12" md="2" lg="2" xl="2">
                            <b-form-checkbox v-model="check_all"  class="d-inline-block ml-1"> Check All
                            </b-form-checkbox>
                        </b-col>
                        <!-- fiscal year list  -->
                        <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                            <b-form-group
                            label-for="fiscal_year_id"
                            >
                            <template v-slot:label>
                                {{ $t('globalTrans.fiscal_year') }}
                            </template>
                            <b-form-select
                                plain
                                v-model="search.fiscal_year_id"
                                :options="fiscalYearList"
                                id="fiscal_year_id"
                                >
                            <template v-slot:first>
                                <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                            </b-form-select>
                            </b-form-group>
                        </b-col>
                        </b-row>
                        <b-row>
                            <b-col sm="4" v-for="(item, index) in serviceList" :key="index">
                                <b-form-checkbox :id="`service_id_${index}`" v-model="search.service_ids" :name="`checkbox-${index}`" :value="item.value"
                                    unchecked-value="not_accepted">
                                    {{ item.text }}
                                </b-form-checkbox>
                            </b-col>
                        </b-row>
                            <b-row class="mt-3 text-right">
                                <b-col>
                                    <b-button @click="searchData" class="btn btn-primary">{{ $t('globalTrans.search') }}</b-button>
                                </b-col>
                            </b-row>
                        </b-card-text>
                    </b-card>
                </b-col>
            </b-row>
            <b-row>
                <b-col>
                    <div class="info-card-wrapper">
                        <b-card>
                            <b-card-text>
                                <b-row>
                                    <b-col class="bdr" sm="3">
                                        <div class="info-card">
                                            <i class="ri-file-copy-2-fill"></i>
                                            <div class="content">
                                                <p>{{ $t('teaGardenConfig.total_application') }}</p>
                                                <h3>{{ $n(totalInfo.totalApplication) }}</h3>
                                            </div>
                                        </div>
                                    </b-col>
                                    <b-col class="bdr" sm="3">
                                        <div class="info-card">
                                            <i class="ri-file-copy-2-fill"></i>
                                            <div class="content">
                                                <p>{{ $t('teaGardenConfig.pending_application') }}</p>
                                                <h3>{{ $n(totalInfo.totalPendingApplication) }}</h3>
                                            </div>
                                        </div>
                                    </b-col>
                                    <b-col class="bdr" sm="3">
                                        <div class="info-card">
                                            <i class="ri-file-copy-2-fill"></i>
                                            <div class="content">
                                                <p>{{ $t('teaGardenConfig.processing_application') }}</p>
                                                <h3>{{ $n(totalInfo.totalProcessingApplication) }}</h3>
                                            </div>
                                        </div>
                                    </b-col>
                                    <b-col class="bdr" sm="3">
                                        <div class="info-card">
                                            <i class="ri-file-copy-2-fill"></i>
                                            <div class="content">
                                                <p>{{ $t('teaGardenConfig.publish_application') }}</p>
                                                <h3>{{ $n(totalInfo.totalPublishedApplication) }}</h3>
                                            </div>
                                        </div>
                                    </b-col>
                                </b-row>
                            </b-card-text>
                        </b-card>
                    </div>
                    <b-card-text>
                        <div id="chart" class="px-3">
                            <apexchart type="bar" height="450" :options="chartOptions" :series="series"></apexchart>
                            <div class="tea-chart-number">
                                <p><i>{{ $t('globalTrans.approved_application_number') }}</i></p>
                            </div>
                            <p class="tea-chart-year"><i>{{ $t('globalTrans.fiscal_year') }} ({{ fiscalYearName(this.search.fiscal_year_id) }})</i></p>
                        </div>
                    </b-card-text>
                </b-col>
            </b-row>
        </div>
        </b-overlay>
    </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import teaGardenService from '@/mixins/tea-garden-service'
export default {
  mixins: [teaGardenService],
  components: {},
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      errors: [],
      check_all: false,
      search: {
        service_ids: [],
        fiscal_year_id: this.$store.state.currentFiscalYearId
      },
      totalInfo: {
        totalApplication: 0,
        totalPendingApplication: 0,
        totalProcessingApplication: 0,
        totalPublishedApplication: 0
      },
      newSeriesData: [],
      categories: [],
      categoriesBn: []
    }
  },
  created () {
    this.check_all = true
    setTimeout(() => {
        this.loadData()
    }, 2000)
  },
  computed: {
    currentLocale () {
        return this.$i18n.locale
    },
    loading () {
      return this.$store.state.commonObj.loading
    },
    serviceList: function () {
      return this.$store.state.TeaGardenService.commonObj.masterServiceList.filter(item => JSON.parse(item.service_type).includes(2))
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    series () {
        return [{
            name: `${this.$t('globalTrans.approved')} ${this.$t('globalTrans.application')} (${this.$t('globalTrans.new')})`,
            data: this.newSeriesData
        }]
    },
    chartOptions () {
        return {
            chart: {
                type: 'bar',
                height: 450
            },
            plotOptions: {
                bar: {
                    horizontal: false,
                    distributed: true,
                    columnWidth: '20%',
                    endingShape: 'rounded'
                }
            },
            dataLabels: {
                enabled: false
            },
            stroke: {
                show: true,
                width: 2,
                colors: ['transparent']
            },
            xaxis: {
                categories: this.currentLocale === 'en' ? this.categories : this.categoriesBn
            },
            fill: {
                opacity: 1
            },
            colors: ['#77B6EA', '#B90E03', '#034092', '#F9EB17', '#172FF9', '#17F939', '#7D0EDA', '#755D58', '#2F2C61', '#9F4E40', '#9F3E40', '#304E40']
        }
    }
  },
  methods: {
    searchData () {
      this.loadData()
    },
    async loadData () {
        // check service_ids[] can't empty
        if (this.search.service_ids.length === 0) {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('globalTrans.form_error_msg'),
                color: '#ee5253'
            })
            return
        }
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, 'dashboard/btri-test', this.search)
        if (result.success) {
            this.totalInfo = result.data.totalInfo
            const categoryArr = []
            const categoryBnArr = []
            const newSeriesArr = []
            result.data.chartInfo.forEach(item => {
                categoryArr.push(this.serviceNameEn(item.service_id))
                categoryBnArr.push(this.serviceNameBn(item.service_id))
                newSeriesArr.push(item.total_application)
            })
            this.categories = categoryArr
            this.categoriesBn = categoryBnArr
            this.newSeriesData = newSeriesArr
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    serviceNameEn (id) {
        const obj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(item => (item.value === id))
        return obj.text_en ? obj.text_en : ''
    },
    serviceNameBn (id) {
        const obj = this.$store.state.TeaGardenService.commonObj.masterServiceList.find(item => (item.value === id))
        return obj.text_bn ? obj.text_bn : ''
    },
    fiscalYearName (id) {
        const obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => (item.value === id))
        if (obj) {
            return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
        }
    }
  },
  watch: {
    check_all: function (newValue) {
      const arr = []
      if (newValue) {
        this.serviceList.forEach(item => {
            arr.push(item.value)
        })
      }
      this.search.service_ids = arr
    }
  }
}
</script>
<style>
/* custom chart design  */
.tea-chart-number {
    position: absolute;
    left: 0;
    top: 45%;
    transform: translate(-77px, -50%);
}
.tea-chart-number p {
    transform: rotate(-90deg);
    font-weight: 600;
}
.font-bn .tea-chart-number {
    transform: translate(-30%, -50%);
}
.tea-chart-year {
    text-align: center;
    margin: -12px 0 10px;
    font-weight: 600;
}
/* custom chart design  end*/
.soil-test-wrapper .card .card-body .card-title {
    background: var(--primary) !important;
}

.soil-test-wrapper .info-card-wrapper .card {
    color: #fff;
    background: var(--alt);
    border: none;
}

.soil-test-wrapper .info-card-wrapper .info-card {
    text-align: center;
}

.soil-test-wrapper .info-card-wrapper .info-card i {
    font-size: 25px;
}

.soil-test-wrapper .info-card-wrapper .row .bdr {
    border-right: 1px solid #ddd;
}

.soil-test-wrapper .info-card-wrapper .row .bdr:last-child {
    border: none;
}

.soil-test-wrapper .card .card-body h2 {
    color: #fff;
    text-transform: uppercase;
}
</style>
