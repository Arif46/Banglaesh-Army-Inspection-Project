<template>
    <div class="section-wrapper bfti-dashboard-wrapper">
        <breadcumb />
         <b-overlay :show="loading">
            <div class="form-wrapper edu-trust-schol-wrapper">
                <b-card title="Professional Course Management">
                    <b-card-text style="padding: 2rem 2rem 1rem;">
                        <b-row class="justify-content-center mb-4" style="background: #214162;padding: 15px 10px 8px;color: #fff;margin: 0;border-radius: 5px;">
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
                            <!-- course list  -->
                            <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                                <b-form-group
                                label-for="course_id"
                                >
                                <template v-slot:label>
                                    {{ $t('teaGardenPduService.course_name') }}
                                </template>
                                <b-form-select
                                    plain
                                    v-model="search.course_id"
                                    :options="courseList"
                                    id="course_id"
                                    >
                                <template v-slot:first>
                                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                                </template>
                                </b-form-select>
                                </b-form-group>
                            </b-col>
                            <b-col sm="2">
                                <b-button variant="primary" @click="searchData" size="sm" style="margin-top:18px">{{ $t('globalTrans.search') }}</b-button>
                            </b-col>
                        </b-row>
                        <b-row class="justify-content-center">
                            <b-col>
                                <b-card-text>
                                    <div id="chart" class="px-3">
                                        <apexchart type="bar" height="450" :options="chartOptions" :series="series"></apexchart>
                                        <div class="tea-chart-number">
                                            <p><i>{{ $t('globalTrans.pdu_circular_participant_number') }}</i></p>
                                        </div>
                                        <p class="tea-chart-year"><i> {{ $t('teaGardenPduService.course_name') }} | {{ $t('globalTrans.fiscal_year') }} ({{ fiscalYearName(this.search.fiscal_year_id) }})</i></p>
                                    </div>
                                </b-card-text>
                            </b-col>
                        </b-row>
                    </b-card-text>
                </b-card>
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
      search: {
        fiscal_year_id: this.$store.state.currentFiscalYearId,
        course_id: 0
      },
      newSeriesData: [],
      categories: [],
      categoriesBn: []
    }
  },
  created () {
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
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    courseList () {
      return this.$store.state.TeaGardenService.commonObj.pduCourseList.filter(item => item.status === 1)
    },
    series () {
        return [{
            name: `${this.$t('globalTrans.application')}`,
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
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(teaGardenServiceBaseUrl, 'dashboard/professional-course-management', this.search)
        if (result.success) {
            const categoryArr = []
            const categoryBnArr = []
            const newSeriesArr = []
            result.data.chartInfo.forEach(item => {
                categoryArr.push(this.courseNameEn(item.course_id))
                categoryBnArr.push(this.courseNameBn(item.course_id))
                newSeriesArr.push(item.total_application)
            })
            this.categories = categoryArr
            this.categoriesBn = categoryBnArr
            this.newSeriesData = newSeriesArr
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
    courseNameEn (id) {
        const obj = this.$store.state.TeaGardenService.commonObj.pduCourseList.find(item => (item.value === id))
        return obj.text_en ? obj.text_en : ''
    },
    courseNameBn (id) {
        const obj = this.$store.state.TeaGardenService.commonObj.pduCourseList.find(item => (item.value === id))
        return obj.text_bn ? obj.text_bn : ''
    },
    fiscalYearName (id) {
        const obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => (item.value === id))
        if (obj) {
            return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
        }
    }
  }
}
</script>
<style scoped>
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
</style>
