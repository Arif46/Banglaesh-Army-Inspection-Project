<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportCipReport.cip_candidate_report') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="3" lg="3" xl="3">
            <ValidationProvider name="Cip Category" vid="cip_category">
                <b-form-group
                    label-for="cip_category"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('exportTrophyConfig.cip_category')}} <span class="text-danger">*</span>
                </template>
                <b-form-select
                    plain
                    v-model="search.cip_category"
                    :options="cipCategoryList"
                    id="cip_category"
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
           <b-col xs="12" sm="12" md="3" lg="3" xl="3">
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
          <b-col xs="12" sm="12" md="3" lg="3" xl="3" v-if="search.cip_category === 1">
             <ValidationProvider name="Export Sector" vid="sector_type">
                <b-form-group
                    label-for="sector_type"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                  {{$t('globalTrans.type')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.sector_type"
                    :options="exportSectorTypeList"
                    id="sector_type"
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
          <b-col xs="12" sm="12" md="3" lg="3" xl="3" v-if="search.cip_category === 1">
            <ValidationProvider name="Product Service Sector" vid="product_service_sector_id">
              <b-form-group
                  label-for="sector_id"
                  slot-scope="{ valid, errors }"
              >
              <template v-slot:label>
                  {{$t('exportCipReport.sector')}}
              </template>
              <v-select name="production_season_id"
                v-model="search.product_service_sector_id"
                label="text"
                :reduce="item => item.value"
                :options= productServiceSectorList
                :placeholder="$t('globalTrans.select')"
                :state="errors[0] ? false : (valid ? true : null)"
                />
              <div class="invalid-feedback">
                  {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
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
                <h4 class="card-title">{{ $t('exportCipReport.cip_candidate_report') }} {{ $t('globalTrans.list')}}</h4>
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
                name="cip_candidate_report.xls">
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
                          {{ $t('exportCipReport.cip_candidate_report') }}
                        </list-report-head>
                      </b-col>
                    </b-row>
                    <template>
                      <div class="text-black mb-4">
                        <b-row v-if="search.cip_category === 1">
                          <b-col md="3">
                            <slot>{{ $t('exportTrophyConfig.cip_category') }}: <strong>{{ search.cip_category  === 1 ? $i18n.locale === 'en' ? 'CIP Export' : 'সিআইপি রপ্তানি' : $t('globalTrans.all') }}</strong> </slot>
                          </b-col>
                          <b-col md="3">
                            {{ $t('globalTrans.year') }}: <strong>{{ search.year ? EngBangNum(search.year.toString()) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('globalTrans.type') }}: <strong>{{ search.sector_type  ?  ($i18n.locale === 'en' ? searchHeaderData.sector_type_name : searchHeaderData.sector_type_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('exportCipReport.sector') }}: <strong>{{ search.product_service_sector_id  ?  ($i18n.locale === 'en' ? searchHeaderData.product_service_sector_name : searchHeaderData.product_service_sector_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                        </b-row>
                        <b-row v-if="search.cip_category === 2">
                          <b-col md="4">
                            <slot>{{ $t('exportTrophyConfig.cip_category') }}: <strong>{{ search.cip_category  === 2 ? $i18n.locale === 'en' ? 'CIP Trade' : 'সিআইপি ট্রেড' : $t('globalTrans.all') }}</strong> </slot>
                          </b-col>
                          <b-col md="4">
                            {{ $t('globalTrans.year') }}: <strong>{{ search.year ? EngBangNum(searchHeaderData.year.toString()) : $t('globalTrans.all') }}</strong>
                          </b-col>
                        </b-row>
                         <template v-if="datas.length">
                            <b-row>
                              <b-col>
                                <template v-if="search.cip_category === 1">
                                  <b-table-simple class="tg mt-3" bordered hover small caption-top responsive>
                                    <b-thead>
                                      <b-tr>
                                        <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('exportCipReport.sector') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.candidate_name_address') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.org_name_address') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('globalTrans.status') }}</b-th>
                                      </b-tr>
                                    </b-thead>
                                    <b-tbody  v-for="(info, index) in datas" :key="index">
                                      <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.product_service_sector_name_bn : info.product_service_sector_name}}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.name_bn : info.name_en }},{{ AddressHelper.getPresentAddress(info) }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.org_name_bn : info.org_name_en }},{{ AddressHelper.getCommonAddress(info) }} </b-td>
                                      <slot v-if="info.status === 3">
                                        <b-td class="text-center">{{ $t('globalTrans.rejected')  }}</b-td>
                                      </slot>
                                      <slot v-else>
                                        <b-td class="text-center">{{ $t('exportCipReport.selected')}}</b-td>
                                      </slot>
                                    </b-tbody>
                                  </b-table-simple>
                                </template>
                                <template v-else-if="search.cip_category === 2">
                                  <b-table-simple class="tg mt-3" bordered hover small caption-top responsive>
                                    <b-thead>
                                      <b-tr>
                                        <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('globalTrans.name') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.fbcci_desingation') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.association') }}</b-th>
                                        <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.address') }}</b-th>
                                        <b-th style="width:15%" class="text-center">{{ $t('globalTrans.status') }}</b-th>
                                      </b-tr>
                                    </b-thead>
                                    <b-tbody  v-for="(info2, index) in datas" :key="index">
                                      <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info2.name_bn : info2.name_en}}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info2.fbcci_designation_bn : info2.fbcci_designation_en}}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info2.referred_association_bn : info2.referred_association_en}}</b-td>
                                      <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info2.address_bn : info2.address_en}}</b-td>
                                      <slot v-if="info2.status === 6">
                                        <b-td class="text-center">{{ $t('exportCipReport.nominated')  }}</b-td>
                                      </slot>
                                    </b-tbody>
                                  </b-table-simple>
                                </template>
                                <template v-else>
                                  <div class="text-center text-danger mt-5">
                                    {{ $t('globalTrans.noDataFound') }}
                                  </div>
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
import { cipCandidateRouteApi } from '../../api/routes'
import AddressHelper from '@/utils/area-type-address'
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
      AddressHelper: AddressHelper,
      exportTrophyCIPServiceBaseUrl: exportTrophyCIPServiceBaseUrl,
      sortBy: '',
      search: {
        product_service_sector_id: '',
        sector_type: 0,
        cip_category: 0,
        year: 0
      },
      datas: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        product_service_sector_name: '',
        product_service_sector_name_bn: '',
        sector_type_name: '',
        sector_type_name_bn: '',
        year: '',
        year_bn: ''
      },
      showData: false,
      productServiceSectorList: []
    }
  },
  mounted () {
    this.headerDataExcel()
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    headerValue: function () {
      const headerVal = []
      const headerValYear = []
      const local = this.$i18n.locale
      if (this.search.cip_category === 1) {
        if (this.$i18n.locale === 'en') {
          headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerVal[1] = this.headerExcelDefault.orgName
          headerVal[2] = this.headerExcelDefault.address
          headerVal[3] = this.$t('exportCipReport.cip_candidate_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        } else {
          headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerVal[1] = this.headerExcelDefault.orgNameBn
          headerVal[2] = this.headerExcelDefault.address_bn
          headerVal[3] = this.$t('exportCipReport.cip_candidate_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        }
        const cipCategory = this.$t('exportTrophyConfig.cip_category') + ' : ' + (this.search.cip_category === 1 ? (local === 'en' ? 'CIP Export' : 'সিআইপি রপ্তানি') : this.$t('globalTrans.all')) + ' ; '
        const year = this.$t('globalTrans.year') + ' : ' + (this.search.year ? (local === 'en' ? this.searchHeaderData.year : this.searchHeaderData.year_bn) : this.$t('globalTrans.all')) + ' ; '
        const exportSectorType = this.$t('globalTrans.type') + ' : ' + (this.search.sector_type ? (local === 'en' ? this.searchHeaderData.sector_type_name : this.searchHeaderData.sector_type_name_bn) : this.$t('globalTrans.all')) + '; '
        const productServiceSector = this.$t('exportCipReport.sector') + ' : ' + (this.search.product_service_sector_id ? (local === 'en' ? this.searchHeaderData.product_service_sector_name : this.searchHeaderData.product_service_sector_name_bn) : this.$t('globalTrans.all')) + '; '
        headerVal[5] = cipCategory + this.EngBangNum(year.toString()) + exportSectorType + productServiceSector
        return headerVal
      } else {
          if (this.$i18n.locale === 'en') {
          headerValYear[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerValYear[1] = this.headerExcelDefault.orgName
          headerValYear[2] = this.headerExcelDefault.address
          headerValYear[3] = this.$t('exportCipReport.cip_candidate_report')
          headerValYear[4] = ''
          headerValYear[5] = ''
          headerValYear[6] = ''
        } else {
          headerValYear[0] = this.$t('globalTrans.government_republic_of_bangladesh')
          headerValYear[1] = this.headerExcelDefault.orgNameBn
          headerValYear[2] = this.headerExcelDefault.address_bn
          headerValYear[3] = this.$t('exportCipReport.cip_candidate_report')
          headerValYear[4] = ''
          headerValYear[5] = ''
          headerValYear[6] = ''
        }
        const year = this.$t('globalTrans.year') + ' : ' + (this.search.year ? (local === 'en' ? this.searchHeaderData.year : this.searchHeaderData.year_bn) : this.$t('globalTrans.all'))
        const category = this.$t('exportTrophyConfig.cip_category') + ' : ' + (this.search.cip_category === 2 ? (local === 'en' ? 'CIP Export' : 'সিআইপি রপ্তানি') : this.$t('globalTrans.all'))
        headerValYear[5] = year + category
        return headerValYear
      }
    },
    excelData: function () {
      if (this.search.cip_category === 1) {
        const listData = this.datas
        var serial = 0
        const listContractor = listData.map(keyItem => {
        serial++
            if (this.$i18n.locale === 'en') {
            return {
                'sl ': serial,
                'Sector ': keyItem.product_service_sector_name,
                'Candidate Name & Address ': keyItem.name_en + AddressHelper.getPresentAddress(keyItem),
                'Organization Name & Address': keyItem.org_name_en + AddressHelper.getCommonAddress(keyItem),
                'Status ': keyItem.status === 3 ? 'Reject' : 'Selected'
            }
            } else {
            return {
                'ক্রমিক সংখ্যা': this.$n(serial),
                'সেক্টর ': keyItem.product_service_sector_name_bn,
                'প্রার্থীর নাম ও ঠিকানা': keyItem.name_bn + ' , ' + AddressHelper.getPresentAddress(keyItem),
                'প্রতিষ্ঠানের নাম ও ঠিকানা': keyItem.org_name_bn + ' , ' + AddressHelper.getCommonAddress(keyItem),
                'স্ট্যাটাস ': keyItem.status === 3 ? 'প্রত্যাখ্যান' : 'নির্বাচিত'
            }
            }
        })
        return listContractor
      } else {
        const listData = this.datas
        let serial = 0
        const listContractor = listData.map(item => {
        serial++
            if (this.$i18n.locale === 'en') {
            return {
                'sl ': serial,
                'Name ': item.name_en,
                'FBCCI Desingation ': item.fbcci_designation_en,
                'Association ': item.referred_association_en,
                'Address ': item.address_en,
                'Status ': item.status === 6 ? 'Nominated' : ''
            }
            } else {
              return {
                'ক্রমিক সংখ্যা': this.$n(serial),
                'নাম ': item.name_bn,
                'এফবিসিসিআই পদবী ': item.fbcci_designation_bn,
                'সংঘ ': item.referred_association_bn,
                'ঠিকানা ': item.address_bn,
                'স্ট্যাটাস ': item.status === 6 ? 'মনোনীত' : ''
              }
            }
        })
        return listContractor
      }
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
    exportSectorTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    cipCategoryList () {
       const list = [
        { value: 1, text: this.currentLocale === 'bn' ? 'সিআইপি রপ্তানি' : 'CIP Export' },
        { value: 2, text: this.currentLocale === 'bn' ? 'সিআইপি ট্রেড' : 'CIP Trade' }
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
    }
  },
  watch: {
    'search.sector_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.productServiceSectorList = this.getProductServiceSectorLtst(newVal)
      }
    }
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
        const reportTitle = this.$t('exportCipReport.cip_candidate_report')
        ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.datas, this.search, this.searchHeaderData, this.getExterUserName)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.sector_type) {
        const productServiceTypeObj = this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.find(data => data.value === this.search.sector_type)
        this.searchHeaderData.sector_type_name = productServiceTypeObj !== undefined ? productServiceTypeObj.text_en : ''
        this.searchHeaderData.sector_type_name_bn = productServiceTypeObj !== undefined ? productServiceTypeObj.text_bn : ''
      }
      if (this.search.product_service_sector_id) {
        const productSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(sector => sector.value === this.search.product_service_sector_id)
        this.searchHeaderData.product_service_sector_name = productSectorObj !== undefined ? productSectorObj.text_en : ''
        this.searchHeaderData.product_service_sector_name_bn = productSectorObj !== undefined ? productSectorObj.text_bn : ''
      }
      if (this.search.year) {
        const yearObj = this.$store.state.commonObj.yearList.find(item => item === parseInt(this.search.year))
        this.searchHeaderData.year = yearObj !== undefined ? this.EngBangNum(yearObj.toString()) : ''
        this.searchHeaderData.year_bn = yearObj !== undefined ? this.EngBangNum(yearObj.toString()) : ''
      }
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, cipCandidateRouteApi, params)
      if (result.success) {
        this.datas = result.data.map(item => {
          const productServiceSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(product => product.value === item.product_service_sector_id)
            const customData = {
              product_service_sector_name: productServiceSectorObj !== undefined ? productServiceSectorObj.text_en : '',
              product_service_sector_name_bn: productServiceSectorObj !== undefined ? productServiceSectorObj.text_bn : ''
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
    },
    getProductServiceSectorLtst (id) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(item => item.type === id && item.assign_for === 1) // 1 mean CIP
    }
  }
}
</script>
