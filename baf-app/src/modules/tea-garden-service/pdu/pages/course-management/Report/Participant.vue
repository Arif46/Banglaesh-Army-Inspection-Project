<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenPduService.participant_report') }}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <!-- fiscal year list -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required">
              <b-form-group
                  label-for="fiscal_year_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('globalTrans.fiscal_year') }}
                  </template>
                  <b-form-select
                  plain
                  v-model="search.fiscal_year_id"
                  :options="fiscalYearList"
                  id="service_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- course list -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Course Name" vid="course_id" rules="required">
              <b-form-group
                  label-for="course_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('teaGardenPduService.course_name')}}
                  </template>
                  <b-form-select
                  @change="getCircularList"
                  plain
                  v-model="search.course_id"
                  :options="courseList"
                  id="course_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- circular list -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Circular Name" vid="circular_id" rules="required">
              <b-form-group
                  label-for="circular_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                  {{ $t('teaGardenPduService.circular_name')}}
                  </template>
                  <b-form-select
                  plain
                  v-model="search.circular_id"
                  :options="pduCircularList"
                  id="service_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  >
                  <template v-slot:first>
                      <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                  <div class="invalid-feedback">
                  {{ errors[0] }}
                  </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <!-- batch number -->
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="batch"
            >
              <template v-slot:label>
                {{ $t('teaGardenPduService.batch_no') }}
              </template>
              <b-form-input
                  id="batch"
                  type="number"
                  v-model.number="search.batch_no"
              ></b-form-input>
            </b-form-group>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-button size="sm" variant="primary" class="mt-20" @click="searchData">
              <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
            </b-button>
          </b-col>
        </b-row>
      </template>
      <!-- search section end -->
    </card>

    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('teaGardenPduService.participant_report') }}</h4>
              </template>
              <template v-slot:headerAction>
                <a href="javascript:" class="btn-add" @click="pdfExport">
                   {{ $t('globalTrans.export_pdf') }}
                </a>
              </template>
              <template v-slot:body>
                <b-overlay :show="loadingState">
                  <b-row>
                    <b-col>
                      <list-report-head :base-url="teaGardenServiceBaseUrl" uri="/configuration/report-heading/detail" :org-id="5">
                        <template v-slot:projectNameSlot>
                          {{ }}
                        </template>
                        {{ $t('teaGardenPduService.participant_report') }}
                      </list-report-head>
                    </b-col>
                  </b-row>
                  <template>
                    <div class="text-black mb-4">
                      <b-row>
                        <b-col md="8">
                          {{ $t('globalTrans.fiscal_year') }}: <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_en : searchHeaderData.fiscal_year_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="4">
                          {{ $t('teaGardenPduService.course_name') }}: <strong>{{ search.course_id  ?  ($i18n.locale === 'en' ? searchHeaderData.course_name_en : searchHeaderData.course_name_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="8">
                          {{ $t('teaGardenPduService.circular_name') }}: <strong>{{ search.circular_id  ?  ($i18n.locale === 'en' ? searchHeaderData.circular_title_en : searchHeaderData.circular_title_bn) : $t('globalTrans.all') }}</strong>
                        </b-col>
                        <b-col md="4">
                          {{ $t('teaGardenPduService.batch_no') }}: <strong>{{ search.batch_no  ?  $n(search.batch_no) : $t('globalTrans.all') }}</strong>
                        </b-col>
                      </b-row>
                    </div>
                    <div>
                      <div class="table-responsive">
                        <b-table-simple class="tg mt-3" bordered striped hover small caption-top responsive :emptyText="$t('globalTrans.noDataFound')">
                          <b-thead>
                            <b-tr>
                              <b-th style="width:7%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                              <b-th style="width:15%" class="text-center">{{ $t('globalTrans.fiscal_year') }}</b-th>
                              <b-th style="width:15%" class="text-center">{{ $t('teaGardenService.application_id') }}</b-th>
                              <b-th style="width:15%" class="text-center">{{ $t('teaGardenPduService.course_name') }}</b-th>
                              <b-th style="width:30%" class="text-center">{{ $t('teaGardenPduService.circular_name') }}</b-th>
                              <b-th style="width:15%" class="text-center">{{ $t('teaGardenPduService.batch_no') }}</b-th>
                            </b-tr>
                          </b-thead>
                          <b-tbody>
                            <b-tr v-for="(item, index) in datas" :key="index">
                              <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                              <b-td class="text-center">{{ getFiscalYearName(item.fiscal_year_id) }}</b-td>
                              <b-td class="text-center">{{ item.app_id }}</b-td>
                              <b-td class="text-center">{{ getCourseName(item.course_id) }}</b-td>
                              <b-td class="text-center">{{ getCircularName(item.circular_id) }}</b-td>
                              <b-td class="text-center"><span v-if="item.circular">{{ $n(item.circular.batch_no) }}</span></b-td>
                            </b-tr>
                            <b-tr v-if="Object.keys(datas).length === 0">
                              <th colspan="6" class="text-center">{{ $t('globalTrans.no_data_found') }}</th>
                            </b-tr>
                          </b-tbody>
                        </b-table-simple>
                      </div>
                    </div>
                  </template>
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { participantReportList } from '../../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import bazarMonitoringServiceMixin from '@/mixins/bazar-monitoring-service'
import ListReportHead from '@/components/custom/BazarMonitoringReportHead.vue'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList, bazarMonitoringServiceMixin],
  components: {
    ListReportHead
  },
  data () {
    return {
      teaGardenServiceBaseUrl: teaGardenServiceBaseUrl,
      sortBy: '',
      search: {
        course_id: 0,
        circular_id: 0,
        fiscal_year_id: 0,
        batch_no: '',
        limit: 20
      },
      editItemId: '',
      sortDesc: true,
      sortDirection: 'desc',
      datas: [],
      searchHeaderData: {
        circular_title_en: '',
        circular_title_bn: '',
        course_name_en: '',
        course_name_bn: '',
        fiscal_year_en: '',
        fiscal_year_bn: ''
      },
      showData: false,
      pduCircularList: []
    }
  },
  created () {
    this.getCircularList()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    }
  },
  computed: {
    courseList: function () {
      return this.$store.state.TeaGardenService.commonObj.pduCourseList.filter(item => item.status === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1)
    },
    formTitle () {
      return (this.editItemId === 0) ? this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.entry') : this.$t('priceMonitoring.market_inspection_report') + ' ' + this.$t('globalTrans.modify')
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    async pdfExport () {
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 5 }, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getPdfData(teaGardenServiceBaseUrl, participantReportList, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.fiscal_year_id) {
        const obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(data => data.value === this.search.fiscal_year_id)
        this.searchHeaderData.fiscal_year_en = obj !== undefined ? obj.text_en : ''
        this.searchHeaderData.fiscal_year_bn = obj !== undefined ? obj.text_bn : ''
      }
      if (this.search.course_id) {
        const obj = this.$store.state.TeaGardenService.commonObj.pduCourseList.find(data => data.value === this.search.course_id)
        this.searchHeaderData.course_name_en = obj !== undefined ? obj.text_en : ''
        this.searchHeaderData.course_name_bn = obj !== undefined ? obj.text_bn : ''
      }
      if (this.search.circular_id) {
        const obj = this.$store.state.TeaGardenService.commonObj.pduCircularList.find(data => data.value === this.search.circular_id)
        this.searchHeaderData.circular_title_en = obj !== undefined ? obj.text_en : ''
        this.searchHeaderData.circular_title_bn = obj !== undefined ? obj.text_bn : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(teaGardenServiceBaseUrl, participantReportList, params)
      if (result.success) {
        this.datas = result.data
        this.$store.dispatch('setList', this.datas)
      } else {
        this.$store.dispatch('setList', [])
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getCircularList () {
      this.search.circular_id = 0
      if (this.search.course_id) {
        this.pduCircularList = this.$store.state.TeaGardenService.commonObj.pduCircularList.filter(item => item.course_id === this.search.course_id && item.status >= 3)
      } else {
        this.pduCircularList = this.$store.state.TeaGardenService.commonObj.pduCircularList
      }
    },
    getCircularName (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.pduCircularList.find(data => data.value === id)
      if (obj) {
        return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
      }
    },
    getCourseName (id) {
      const obj = this.$store.state.TeaGardenService.commonObj.pduCourseList.find(data => data.value === id)
      if (obj) {
        return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
      }
    },
    getFiscalYearName (id) {
      const obj = this.$store.state.CommonService.commonObj.fiscalYearList.find(data => data.value === id)
      if (obj) {
        return this.currentLocale === 'en' ? obj.text_en : obj.text_bn
      }
    }
  }
}
</script>
