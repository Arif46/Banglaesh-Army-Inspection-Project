<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper fertilizer-distribution">
            <b-overlay :show="loading">
                <b-card :title="$t('teaGardenConfig.small_tea_farmer_registration')">
                    <b-card-text class="mb-3">
                        <b-row>
                            <b-col sm="3">
                                <div class="info-card total-app">
                                    <div class="icon">
                                        <i class="ri-file-3-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('sitePreference.total') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.new') }})</small>
                                        <h3>{{ $n(totalInfo.newApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card approved">
                                    <div class="icon">
                                        <i class="ri-checkbox-circle-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('globalTrans.approved') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.new') }})</small>
                                        <h3>{{ $n(totalInfo.newApprovedApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card pending">
                                    <div class="icon">
                                        <i class="ri-time-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('globalTrans.pending') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.new') }})</small>
                                        <h3>{{ $n(totalInfo.newPendingApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card reject">
                                    <div class="icon">
                                        <i class="ri-close-line"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('globalTrans.rejected') }} {{ $t('globalTrans.application') }}</p>
                                        <small> &nbsp; </small>
                                        <h3>{{ $n(totalInfo.rejectedApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card total-app">
                                    <div class="icon">
                                        <i class="ri-file-3-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('sitePreference.total') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.renew') }})</small>
                                        <h3>{{ $n(totalInfo.renewApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card approved">
                                    <div class="icon">
                                        <i class="ri-checkbox-circle-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('globalTrans.approved') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.renew') }})</small>
                                        <h3>{{ $n(totalInfo.renewApprovedApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card pending">
                                    <div class="icon">
                                        <i class="ri-time-fill"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('globalTrans.pending') }} {{ $t('globalTrans.application') }}</p>
                                        <small>({{ $t('globalTrans.renew') }})</small>
                                        <h3>{{ $n(totalInfo.renewPendingApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                            <b-col sm="3">
                                <div class="info-card reject">
                                    <div class="icon">
                                        <i class="ri-close-line"></i>
                                    </div>
                                    <div class="content">
                                        <p>{{ $t('teaGardenConfig.expired') }} {{ $t('globalTrans.application') }}</p>
                                        <small> &nbsp; </small>
                                        <h3>{{ $n(totalInfo.expiredApplication) }}</h3>
                                    </div>
                                </div>
                            </b-col>
                        </b-row>
                    </b-card-text>
                </b-card>
                <b-card>
                    <div id="chart" class="px-3">
                        <apexchart type="bar" height="350" :options="chartOptions" :series="series"></apexchart>
                        <div class="tea-chart-number">
                            <p><i>{{ $t('globalTrans.number') }}</i></p>
                        </div>
                        <p class="tea-chart-year"><i>{{ $t('globalTrans.fiscal_year') }}</i></p>
                    </div>
                </b-card>
            </b-overlay>
        </div>
    </div>
</template>
<script>
    import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
    export default {
        name: 'SmallTeaFarmerRegistration',
        data () {
            return {
                teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
                totalInfo: {
                    newApplication: 0,
                    newApprovedApplication: 0,
                    newPendingApplication: 0,
                    rejectedApplication: 0,
                    renewApplication: 0,
                    renewApprovedApplication: 0,
                    renewPendingApplication: 0,
                    expiredApplication: 0
                },
                newSeriesData: [],
                renewSeriesData: [],
                categories: [],
                categoriesBn: []
            }
        },
        created () {
            this.loadData()
        },
        computed: {
            currentLocale () {
                return this.$i18n.locale
            },
            loading () {
                return this.$store.state.commonObj.loading
            },
            series () {
                return [{
                    name: `${this.$t('globalTrans.approved')} ${this.$t('globalTrans.application')} (${this.$t('globalTrans.new')})`,
                    data: this.newSeriesData
                }, {
                    name: `${this.$t('globalTrans.approved')} ${this.$t('globalTrans.application')} (${this.$t('globalTrans.renew')})`,
                    data: this.renewSeriesData
                }]
            },
            chartOptions () {
                return {
                    chart: {
                        type: 'bar',
                        height: 350
                    },
                    plotOptions: {
                        bar: {
                            horizontal: false,
                            columnWidth: '10%',
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
                    }
                }
            }
        },
        methods: {
            back () {
                this.$router.go(-1)
            },
            async loadData () {
                this.$store.dispatch('mutateCommonProperties', { loading: true })
                const result = await RestApi.getData(teaGardenServiceBaseUrl, 'dashboard/small-tea-farmer-registration')
                if (result.success) {
                    this.totalInfo = result.data.totalInfo
                    const fiscalYearList = this.$store.state.CommonService.commonObj.fiscalYearList
                    const chartInfo = result.data.chartInfo.map(item => {
                        const fiscalYear = fiscalYearList.find(obj => obj.value === parseInt(item.fiscal_year_id))
                        if (fiscalYear) {
                                const customItem = {
                                fiscal_year_en: fiscalYear.text_en,
                                fiscal_year_bn: fiscalYear.text_bn,
                                sorting_order: fiscalYear.sorting_order
                            }
                            return Object.assign({}, item, customItem)
                        } else {
                            const customItem = {
                                fiscal_year_en: '',
                                fiscal_year_bn: '',
                                sorting_order: ''
                            }
                            return Object.assign({}, item, customItem)
                        }
                    }).sort((a, b) => a.sorting_order - b.sorting_order)
                    const categoryArr = []
                    const categoryBnArr = []
                    const newSeriesArr = []
                    const renewSeriesArr = []
                    chartInfo.forEach(item => {
                        categoryArr.push(item.fiscal_year_en)
                        categoryBnArr.push(item.fiscal_year_bn)
                        newSeriesArr.push(item.totalNewApplication)
                        renewSeriesArr.push(item.totalRenewApplication)
                    })
                    this.categories = categoryArr
                    this.categoriesBn = categoryBnArr
                    this.newSeriesData = newSeriesArr
                    this.renewSeriesData = renewSeriesArr
                }
                this.$store.dispatch('mutateCommonProperties', { loading: false })
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
    transform: translate(-15px, -50%);
}
.tea-chart-number p {
    transform: rotate(-90deg);
    font-weight: 600;
}
.font-bn .tea-chart-number {
    transform: translate(0, -50%);
}
.tea-chart-year {
    text-align: center;
    margin: -12px 0 10px;
    font-weight: 600;
}
/* custom chart design  end*/
.fertilizer-distribution .info-card {
    margin-top: 35px;
    color: #fff;
    padding: 1rem;
    border-radius: 8px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.fertilizer-distribution .info-card .icon {
    margin-top: -40px;
    display: flex;
    font-size: 25px;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 60px;
    border: 2px solid #fff;
    border-radius: 60px;
}

.fertilizer-distribution .info-card .content {
    margin-top: 5px;
}

.fertilizer-distribution .info-card .content h3 {
    margin-top: 5px;
    padding: 3px;
    border-radius: 10px;
}

.fertilizer-distribution .info-card.submitted {
    background: #0F95CF;
}

.fertilizer-distribution .info-card.submitted .icon,
.fertilizer-distribution .info-card.submitted .content h3 {
    background: #0785bb;
}

.fertilizer-distribution .info-card.approved {
    background: #1DCD6E;
}

.fertilizer-distribution .info-card.approved .icon,
.fertilizer-distribution .info-card.approved .content h3 {
    background: #11b75f;
}

.fertilizer-distribution .info-card.pending {
    background: #DE960D;
}

.fertilizer-distribution .info-card.pending .icon,
.fertilizer-distribution .info-card.pending .content h3 {
    background: #c78406;
}

.fertilizer-distribution .info-card.requested-far {
    background: #0fc9cf;
}

.fertilizer-distribution .info-card.requested-far .icon,
.fertilizer-distribution .info-card.requested-far .content h3 {
    background: #06abb1;
}

.fertilizer-distribution .info-card.total-app {
    background: #1930e2;
}

.fertilizer-distribution .info-card.total-app .icon,
.fertilizer-distribution .info-card.total-app .content h3 {
    background: #1127cd;
}

.fertilizer-distribution .info-card.reject {
    background: #e22619;
}

.fertilizer-distribution .info-card.reject .icon,
.fertilizer-distribution .info-card.reject .content h3 {
    background: #bd180c;
}
</style>
