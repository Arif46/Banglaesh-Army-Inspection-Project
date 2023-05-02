<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportCipReport.export_trophy_candidate_report') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <b-row>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id">
                <b-form-group
                    label-for="fiscal_year_id"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('globalTrans.fiscal_year')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.fiscal_year_id"
                    :options="fiscalYearList"
                    id="fiscal_year_id"
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Product Service Sector" vid="sector_id">
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
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Trophy Type" vid="trophy">
                <b-form-group
                    label-for="trophy"
                    slot-scope="{ valid, errors }"
                >
                <template v-slot:label>
                    {{$t('exportCipReport.trophy_type')}}
                </template>
                <b-form-select
                    plain
                    v-model="search.trophy"
                    :options="trophyTypeList"
                    id="trophy"
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
                <h4 class="card-title">{{ $t('exportCipReport.export_trophy_candidate_report') }} {{ $t('globalTrans.list')}}</h4>
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
                name="export_trophy_candidate_report.xls">
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
                          {{ $t('exportCipReport.export_trophy_candidate_report') }}
                        </list-report-head>
                      </b-col>
                    </b-row>
                    <template>
                      <div class="text-black mb-4">
                        <b-row>
                          <b-col md="3">
                            {{ $t('globalTrans.fiscalYear') }}: <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_name : searchHeaderData.fiscal_year_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('globalTrans.type') }}: <strong>{{ search.sector_type  ?  ($i18n.locale === 'en' ? searchHeaderData.sector_type_name : searchHeaderData.sector_type_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('exportCipReport.sector') }}: <strong>{{ search.product_service_sector_id  ?  ($i18n.locale === 'en' ? searchHeaderData.product_service_sector_name : searchHeaderData.product_service_sector_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                              <slot>
                                {{ $t('exportCipReport.trophy_type') }} :
                                <strong>{{ search.trophy  === 1 ? $i18n.locale === 'en' ? 'Gold' : 'সোনা' : '' }}</strong>
                                <strong>{{ search.trophy  === 2 ? $i18n.locale === 'en' ? 'Silver' : 'সিলভার' : ''}}</strong>
                                <strong>{{ search.trophy  === 3 ? $i18n.locale === 'en' ? 'Bronze' : 'ব্রোঞ্জ' : '' }}</strong>
                                <strong v-if="!search.trophy">{{ $t('globalTrans.all') }} </strong>
                              </slot>
                          </b-col>
                        </b-row>
                        <template v-if="datas.length">
                          <b-row>
                              <b-col>
                                <b-table-simple class="tg mt-3" bordered hover small caption-top responsive>
                                  <b-thead>
                                    <b-tr>
                                      <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                      <b-th style="width:15%" class="text-center">{{ $t('exportCipReport.sector') }}</b-th>
                                      <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.candidate_name_address') }}</b-th>
                                      <b-th style="width:20%" class="text-center">{{ $t('exportCipReport.org_name_address') }}</b-th>
                                      <b-th style="width:15%" class="text-center">{{ $t('exportCipReport.trophy_status') }}</b-th>
                                    </b-tr>
                                  </b-thead>
                                  <b-tbody  v-for="(info, index) in datas" :key="index">
                                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.product_service_sector_name_bn : info.product_service_sector_name}}</b-td>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.name_bn : info.name_en }},{{ AddressHelper.getPresentAddress(info) }}</b-td>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.org_name_bn : info.org_name_en }},{{ AddressHelper.getCommonAddress(info) }} </b-td>
                                    <slot v-if="info.status === 3">
                                      <b-td class="text-center">{{ $t('globalTrans.reject')  }}</b-td>
                                    </slot>
                                    <slot v-else>
                                      <b-td class="text-center">{{ $t('exportCipReport.achieved')}} {{ getTrophyStatus(info.trophy) }} {{ $t('exportCipReport.trophy')}}</b-td>
                                    </slot>
                                  </b-tbody>
                                </b-table-simple>
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
import { exportTrophyCandidateRouteApi } from '../../api/routes'
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
        fiscal_year_id: 0,
        sector_type: 0,
        product_service_sector_id: '',
        trophy: 0
      },
      datas: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        fiscal_year_name: '',
        fiscal_year_name_bn: '',
        sector_type_name: '',
        sector_type_name_bn: '',
        product_service_sector_name: '',
        product_service_sector_name_bn: '',
        trophy_name: '',
        trophy_name_bn: ''
      },
      showData: false,
      productServiceSectorList: []
    }
  },
  mounted () {
    this.headerDataExcel()
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      const local = this.$i18n.locale
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('exportCipReport.export_trophy_candidate_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('exportCipReport.export_trophy_candidate_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      }
      const fiscalYear = this.$t('globalTrans.fiscalYear') + ' : ' + (this.search.fiscal_year_id ? (local === 'en' ? this.searchHeaderData.fiscal_year_name : this.searchHeaderData.fiscal_year_name_bn) : this.$t('globalTrans.all')) + '; '
      const exportSectorType = this.$t('globalTrans.type') + ' : ' + (this.search.sector_type ? (local === 'en' ? this.searchHeaderData.sector_type_name : this.searchHeaderData.sector_type_name_bn) : this.$t('globalTrans.all')) + '; '
      const productServiceSector = this.$t('exportCipReport.sector') + ' : ' + (this.search.product_service_sector_id ? (local === 'en' ? this.searchHeaderData.product_service_sector_name : this.searchHeaderData.product_service_sector_name_bn) : this.$t('globalTrans.all')) + '; '
      const TrophyType = this.$t('exportCipReport.trophy_type') + ' : ' + (this.search.trophy === 1 ? (local === 'en' ? 'Gold' : 'সোনা') : '') + ' ' + (this.search.trophy === 2 ? (local === 'en' ? 'Silver' : 'সিলভার') : '') + ' ' + (this.search.trophy === 3 ? (local === 'en' ? 'Bronze' : 'ব্রোঞ্জ') : '') + ' ' + (this.search.trophy === 0 ? (local === 'en' ? 'All' : 'সকল') : '')
      headerVal[5] = fiscalYear + exportSectorType + productServiceSector + TrophyType
      return headerVal
    },
    excelData: function () {
      const listData = this.datas
      var serial = 0
      const listContractor = listData.map(keyItem => {
      serial++
          if (this.$i18n.locale === 'en') {
          return {
              'sl ': serial,
              'Sector ': keyItem.product_service_sector_name,
              'Candidate Name & Address ': keyItem.name_en + ' , ' + AddressHelper.getPresentAddress(keyItem),
              'Organization Name & Address': keyItem.org_name_en + AddressHelper.getCommonAddress(keyItem),
              'Trophy Status': keyItem.status === 3 ? 'Reject' : 'Achieved' + ',' + this.getTrophyStatus(keyItem.trophy) + ',' + 'Trophy'
          }
          } else {
          return {
              'ক্রমিক সংখ্যা': this.$n(serial),
              'সেক্টর ': keyItem.product_service_sector_name_bn,
              'প্রার্থীর নাম ও ঠিকানা': keyItem.name_bn + ' , ' + AddressHelper.getPresentAddress(keyItem),
              'প্রতিষ্ঠানের নাম ও ঠিকানা': keyItem.org_name_bn + ' , ' + AddressHelper.getCommonAddress(keyItem),
              'ট্রফি স্ট্যাটাস': keyItem.status === 3 ? 'প্রত্যাখ্যান' : 'অর্জন করেছে' + ',' + this.getTrophyStatus(keyItem.trophy) + ',' + 'ট্রফি'
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
    exportSectorTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    trophyTypeList () {
      const list = [
        { value: 1, text: this.$i18n.locale === 'en' ? 'Gold' : 'সোনা' },
        { value: 2, text: this.$i18n.locale === 'en' ? 'Silver' : 'সিলভার' },
        { value: 3, text: this.$i18n.locale === 'en' ? 'Bronze' : 'ব্রোঞ্জ' }
      ]
      return list
    }
  },
  watch: {
    'search.sector_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.productServiceSectorList = this.getProductServiceSectorList(newVal)
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
        const reportTitle = this.$t('exportCipReport.export_trophy_candidate_report')
        ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this, this.datas, this.search, this.searchHeaderData, this.getTrophyStatus)
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      if (this.search.fiscal_year_id) {
        const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscalYear => fiscalYear.value === this.search.fiscal_year_id)
        this.searchHeaderData.fiscal_year_name = fiscalYearObj !== undefined ? fiscalYearObj.text_en : ''
        this.searchHeaderData.fiscal_year_name_bn = fiscalYearObj !== undefined ? fiscalYearObj.text_bn : ''
      }
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
      this.showData = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, exportTrophyCandidateRouteApi, params)
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
    getTrophyStatus (value) {
      if (value === 1) {
        return this.$i18n.locale === 'en' ? 'Gold' : 'সোনা'
      } else if (value === 2) {
        return this.$i18n.locale === 'en' ? 'Silver' : 'সিলভার'
      } else if (value === 3) {
        return this.$i18n.locale === 'en' ? 'Bronze' : 'ব্রোঞ্জ'
      }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    getProductServiceSectorList (id) {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(item => item.type === id && item.assign_for === 2) // 2 mean export trophy
    }
  }
}
</script>
