<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportCipReport.guest_report') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <ValidationProvider name="Guest Status" vid="award_type" rules="required|min_value:1">
                <b-form-group
                    label-for="award_type"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('exportTrophyConfig.awardType')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                    plain
                    v-model="search.award_type"
                    :options="guestStatusList"
                    id="award_type"
                    :state="errors[0] ? false : (valid ? true : null)"
                >
                    <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                </b-form-select>
                <div class="invalid-feedback">
                    {{ errors[0] }}
                </div>
                </b-form-group>
            </ValidationProvider>
          </b-col>
           <b-col xs="12" sm="12" md="3" lg="3" xl="3" v-if="search.award_type === 1">
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
            <b-col xs="12" sm="12" md="3" lg="3" xl="3" v-if="search.award_type === 2">
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
            <b-col xs="12" sm="12" md="3" lg="3" xl="3">
                <b-form-group
                label-for="venue_id"
                >
                <template v-slot:label>
                {{$t('eventManage.venue')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.venue_id"
                    :options="venueList"
                    id="venue_id"
                >
                <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                </template>
                </b-form-select>
                </b-form-group>
            </b-col>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
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
                <h4 class="card-title">{{ $t('exportCipReport.guest_report') }} {{ $t('globalTrans.list')}}</h4>
              </template>
              <template v-slot:headerAction>
                <b-button @click="pdfExport" class="btn-add" variant="primary">
                  {{  $t('globalTrans.print') }}
                </b-button>
                <export-excel
                class="btn btn-add ml-2"
                :title="headerValue"
                default-value="headerExcelDefault"
                :data="excelData"
                worksheet="Report Sheet"
                name="guest_report.xls">
                {{ $t('globalTrans.export_excel') }}
              </export-excel>
              </template>
              <template v-slot:body>
                <b-overlay :show="loadingState">
                  <div style="border:2px solid;margin:10px;padding:10px">
                    <b-row>
                      <b-col>
                        <list-report-head :base-url="exportTrophyCIPServiceBaseUrl" uri="/configuration/report-heading/detail" :org-id="2">
                          <template v-slot:projectNameSlot>
                            {{ }}
                          </template>
                          {{ $t('exportCipReport.guest_report') }}
                        </list-report-head>
                      </b-col>
                    </b-row>
                    <template>
                      <div class="text-black mb-4">
                        <b-row v-if="search.award_type === 1">
                          <b-col md="4">
                            {{ $t('exportTrophyConfig.awardType') }}: <strong>{{ search.award_type === 1  ?  $i18n.locale === 'en' ? 'CIP' : 'সিআইপি' : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="4">
                            {{ $t('globalTrans.year') }}: <strong>{{ search.year  ?  ($i18n.locale === 'en' ? searchHeaderData.year : searchHeaderData.year_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="4">
                            <slot>{{ $t('eventManage.venue') }}: <strong>{{ search.venue_id  ? $i18n.locale === 'en' ? searchHeaderData.venue_name : searchHeaderData.venue_name_bn: $t('globalTrans.all') }}</strong></slot>
                          </b-col>
                        </b-row>
                        <b-row v-if="search.award_type === 2">
                          <b-col md="4">
                            {{ $t('exportTrophyConfig.awardType') }}: <strong>{{ search.award_type === 2  ?  $i18n.locale === 'en' ? 'Export Trophy' : 'রপ্তানি ট্রফি' : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="4">
                            <slot>{{ $t('globalTrans.fiscal_year') }}: <strong>{{ search.fiscal_year_id  ? $i18n.locale === 'en' ? searchHeaderData.fiscal_year : searchHeaderData.fiscal_year_bn : $t('globalTrans.all') }}</strong></slot>
                          </b-col>
                          <b-col md="4">
                            <slot>{{ $t('eventManage.venue') }}: <strong>{{ search.venue_id  ? $i18n.locale === 'en' ? searchHeaderData.venue_name : searchHeaderData.venue_name_bn: $t('globalTrans.all') }}</strong></slot>
                          </b-col>
                        </b-row>
                         <template v-if="datas.length">
                            <b-row>
                              <b-col>
                                <template>
                                  <b-table-simple class="tg mt-3" bordered hover small caption-top responsive>
                                    <b-thead>
                                      <b-tr>
                                        <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('eventManage.venue') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.invitation_titile') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.total_invited') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('exportCipReport.total_attend') }}</b-th>
                                      </b-tr>
                                    </b-thead>
                                    <b-tbody  v-for="(info, index) in datas" :key="index">
                                      <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.venue_name_bn : info.venue_name}}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.title_bn : info.title_en }}</b-td>
                                      <b-td class="text-center">{{ $n(info.total_invited_guest) }}</b-td>
                                      <b-td class="text-center">{{ $n(info.total_attend_guest) }} </b-td>
                                    </b-tbody>
                                  </b-table-simple>
                                </template>
                              </b-col>
                            </b-row>
                          </template>
                          <template v-else>
                            <div class="text-center text-danger mt-5">
                              {{ $t('globalTrans.noDataFound') }}
                            </div>
                        </template>
                      </div>
                    </template>
                  </div>
                </b-overlay>
              </template>
              <!-- table section end -->
        </body-card>
      </b-col>
    </b-row>
  </div>
</template>
<script>
import RestApi, { exportTrophyCIPServiceBaseUrl } from '@/config/api_config'
import { guestReportList } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'
import excel from 'vue-excel-export'
import Vue from 'vue'
Vue.use(excel)

export default {
  mixins: [ModalBaseMasterList],
  components: {
    ListReportHead
  },
  data () {
    return {
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      sortBy: '',
      search: {
        year: 0,
        award_type: 0,
        fiscal_year_id: 0,
        venue_id: 0
      },
      datas: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        fiscal_year: '',
        fiscal_year_bn: '',
        venue_name: '',
        venue_name_bn: '',
        year: '',
        year_bn: ''
      },
      showData: false,
      sectorList: []
    }
  },
  mounted () {
    this.headerDataExcel()
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      const headerValYear = []
      const local = this.$i18n.locale
      if (this.search.award_type === 1) {
        if (this.$i18n.locale === 'en') {
          headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerVal[1] = this.headerExcelDefault.orgName
          headerVal[2] = this.headerExcelDefault.address
          headerVal[3] = this.$t('exportCipReport.guest_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        } else {
          headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerVal[1] = this.headerExcelDefault.orgNameBn
          headerVal[2] = this.headerExcelDefault.address_bn
          headerVal[3] = this.$t('exportCipReport.guest_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        }
        const awardType = this.$t('exportTrophyConfig.awardType') + ' : ' + (this.search.award_type === 1 ? (local === 'en' ? 'CIP' : 'সিআইপি') : this.$t('globalTrans.all')) + ' ; '
        const year = this.$t('globalTrans.year') + ' : ' + (this.search.year ? (local === 'en' ? this.searchHeaderData.year : this.searchHeaderData.year_bn) : this.$t('globalTrans.all')) + ' ; '
        const venue = this.$t('eventManage.venue') + ' : ' + (this.search.venue_id ? (local === 'en' ? this.searchHeaderData.venue_name : this.searchHeaderData.venue_name_bn) : this.$t('globalTrans.all')) + ' ; '
        headerVal[5] = awardType + year + venue
        return headerVal
      } else {
          if (this.$i18n.locale === 'en') {
          headerValYear[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerValYear[1] = this.headerExcelDefault.orgName
          headerValYear[2] = this.headerExcelDefault.address
          headerValYear[3] = this.$t('exportCipReport.guest_report')
          headerValYear[4] = ''
          headerValYear[5] = ''
          headerValYear[6] = ''
        } else {
          headerValYear[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerValYear[1] = this.headerExcelDefault.orgNameBn
          headerValYear[2] = this.headerExcelDefault.address_bn
          headerValYear[3] = this.$t('exportCipReport.guest_report')
          headerValYear[4] = ''
          headerValYear[5] = ''
          headerValYear[6] = ''
        }
        const awardType = this.$t('exportTrophyConfig.awardType') + ' : ' + (this.search.award_type === 2 ? (local === 'en' ? 'Export Trophy' : 'রপ্তানি ট্রফি') : this.$t('globalTrans.all')) + ' ; '
        const fiscalYear = this.$t('globalTrans.fiscal_year') + ' : ' + (this.search.fiscal_year_id ? (local === 'en' ? this.searchHeaderData.fiscal_year : this.searchHeaderData.fiscal_year_bn) : this.$t('globalTrans.all')) + ' ; '
        const venue = this.$t('eventManage.venue') + ' : ' + (this.search.venue_id ? (local === 'en' ? this.searchHeaderData.venue_name : this.searchHeaderData.venue_name_bn) : this.$t('globalTrans.all')) + ' ; '
        headerValYear[5] = awardType + fiscalYear + venue
        return headerValYear
      }
    },
    excelData: function () {
        const listData = this.datas
        let serial = 0
        const listContractor = listData.map(item => {
        serial++
            if (this.$i18n.locale === 'en') {
            return {
                'sl ': serial,
                'Venue ': item.venue_name,
                'Invitation Title ': item.title_en,
                'Total Invited Guest ': item.total_invited_guest,
                'Total Attend  Guest ': item.total_attend_guest
            }
            } else {
              return {
                'ক্রমিক সংখ্যা': this.$n(serial),
                'ভেন্যু ': item.venue_name_bn,
                'আমন্ত্রণ শিরোনাম ': item.title_bn,
                'মোট আমন্ত্রিত অতিথি ': this.$n(item.total_invited_guest),
                'মোট অতিথি উপস্থিতি ': this.$n(item.total_attend_guest)
              }
            }
        })
        return listContractor
    },
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    guestStatusList () {
       const list = [
        { value: 1, text: this.currentLocale === 'bn' ? 'সিআইপি' : 'CIP' },
        { value: 2, text: this.currentLocale === 'bn' ? 'এক্সপোর্ট ট্রফি' : 'Export Trophy' }
      ]
      return list
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
    venueList: function () {
      return this.$store.state.ExportTrophyCipService.commonObj.venueList.filter(item => item.status === 1)
    }
  },
  watch: {
  },
  methods: {
    headerDataExcel () {
      RestApi.getData(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail/2').then(response => {
        if (response.success) {
          const orgList = this.$store.state.CommonService.commonObj.componentOrgList.find(item => item.value === 2)
          const orgName = typeof orgList !== 'undefined' ? orgList.text_en : ''
          const orgNameBn = typeof orgList !== 'undefined' ? orgList.text_bn : ''
          this.headerExcelDefault.orgName = orgName
          this.headerExcelDefault.orgNameBn = orgNameBn
          this.headerExcelDefault.address = response.data.address
          this.headerExcelDefault.address_bn = response.data.address_bn
        }
      })
    },
    pdfExport () {
      const reportTitle = this.$t('exportCipReport.guest_report')
      ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.datas, this.search, this.searchHeaderData)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.fiscal_year_id) {
        const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscalYear => fiscalYear.value === this.search.fiscal_year_id)
        this.searchHeaderData.fiscal_year = fiscalYearObj !== undefined ? fiscalYearObj.text_en : ''
        this.searchHeaderData.fiscal_year_bn = fiscalYearObj !== undefined ? fiscalYearObj.text_bn : ''
      }
      if (this.search.venue_id) {
        const venueObj = this.$store.state.ExportTrophyCipService.commonObj.venueList.find(venue => venue.value === this.search.venue_id)
        this.searchHeaderData.venue_name = venueObj !== undefined ? venueObj.text_en : ''
        this.searchHeaderData.venue_name_bn = venueObj !== undefined ? venueObj.text_bn : ''
      }
      if (this.search.year) {
        const yearObj = this.$store.state.commonObj.yearList.find(item => item === this.search.year)
        this.searchHeaderData.year = yearObj !== undefined ? yearObj : ''
        this.searchHeaderData.year_bn = yearObj !== undefined ? this.EngBangNum(yearObj.toString()) : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, guestReportList, params)
      if (result.success) {
        this.datas = result.data.map(item => {
          const venueObj = this.$store.state.ExportTrophyCipService.commonObj.venueList.find(venue => venue.value === item.venue_id)
            const customData = {
              venue_name: venueObj !== undefined ? venueObj.text_en : '',
              venue_name_bn: venueObj !== undefined ? venueObj.text_bn : ''
            }
         return Object.assign({}, item, customData)
        })
      } else {
        this.datas = []
      }
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    }
  }
}
</script>
