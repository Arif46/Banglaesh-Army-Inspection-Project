<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('exportCipReport.new_product_report') }} {{ $t('globalTrans.search')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit }">
          <b-form @submit.prevent="handleSubmit(saveUpdate)" autocomplete="off">
            <b-row>
              <b-col sm="3">
                  <ValidationProvider name="Award Type" vid="award_type" rules="required|min_value:1">
                      <b-form-group
                        label-for="award_type"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                          {{$t('exportTrophyConfig.awardType')}} <span class="text-danger">*</span>
                        </template>
                        <b-form-radio-group
                            v-model="search.award_type"
                            :options="assignTypeList"
                            value-field="value"
                            text-field="text"
                            :state="errors[0] ? false : (valid ? true : null)"
                        ></b-form-radio-group>
                        <div class="invalid-feedback d-block">
                        {{ errors[0] }}
                        </div>
                      </b-form-group>
                  </ValidationProvider>
              </b-col>
              <b-col sm="3">
                <ValidationProvider name="Service Product" vid="type" rules="required|min_value:1">
                  <b-form-group
                    label-for="type"
                    slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                      {{$t('globalTrans.type')}} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      v-model="search.type"
                      :options="productServiceTypeList"
                      id="type"
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
              <b-col sm="3" v-if="hideFiscalYear">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="fiscal_year_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="search.fiscal_year_id"
                    :options="fiscalYear"
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
              <b-col sm="3" v-if="hideYear">
                <ValidationProvider name="Year" vid="year" rules="required|min_value:1">
                  <b-form-group
                    label-for="year"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('globalTrans.year')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="search.year"
                    :options="YearList"
                    id="year"
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
              <b-col sm="3">
                <ValidationProvider name="Product service" vid="product_service_id" rules="required|min_value:1">
                  <b-form-group
                    label-for="product_service_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('exportCipReport.sector')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.product_service_id"
                      :options="exportSectorList"
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
              <b-col xs="4" sm="4" md="4" lg="4" xl="4">
                <b-button type="submit" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.search') }}</b-button>
              </b-col>
            </b-row>
          </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <b-row>
      <b-col md="12" v-if="showData">
        <body-card>
              <!-- table section start -->
              <template v-slot:headerTitle>
                <h4 class="card-title">{{ $t('exportCipReport.new_product_report') }} {{ $t('globalTrans.list')}}</h4>
              </template>
              <template v-slot:headerAction>
                <b-button @click="pdfExport" class="btn-add" variant="primary">
                  {{  $t('globalTrans.print') }}
                </b-button>
                <!-- <export-excel
                  class="btn btn-success mr-2"
                  :data="excelData"
                  :title="headerValue"
                  worksheet="Report Sheet"
                  :default-value="headerExcelDefault"
                  name="export_trophy_candidate_report.xls">
                  {{ $t('globalTrans.export_excel') }}
                </export-excel> -->
                <export-excel
                class="btn btn-add ml-2"
                :title="headerValue"
                :default-value="headerExcelDefault"
                :data="excelData"
                worksheet="Report Sheet"
                name="export_trophy_candidate_report.xls">
                {{ $t('globalTrans.export_excel') }}
              </export-excel>
              </template>
              <template v-slot:body>
                <b-overlay :show="loading">
                  <div style="border:2px solid;margin:10px;padding:10px">
                    <b-row>
                      <b-col>
                        <list-report-head :base-url="exportTrophyCIPServiceBaseUrl" uri="/configuration/report-heading/detail" :org-id="2">
                          <template v-slot:projectNameSlot>
                            {{ }}
                          </template>
                          {{ $t('exportCipReport.new_product_report') }}
                        </list-report-head>
                      </b-col>
                    </b-row>
                    <template>
                      <div class="text-black mb-4">
                        <b-row>
                          <b-col md="3">
                            {{ $t('exportTrophyConfig.awardType') }}: <strong>{{ search.award_type ? ($i18n.locale === 'en' ? searchHeaderData.award_type_name : searchHeaderData.award_type_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('globalTrans.type') }}: <strong>{{ search.type  ?  ($i18n.locale === 'en' ? searchHeaderData.type_name : searchHeaderData.type_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3" v-if="search.award_type === 1">
                              {{ $t('globalTrans.year') }}: <strong>{{ search.year ? EngBangNum(searchHeaderData.year_name.toString()) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3" v-if="search.award_type === 2">
                              {{ $t('globalTrans.fiscal_year') }}: <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_name : searchHeaderData.fiscal_year_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                          <b-col md="3">
                            {{ $t('exportCipReport.sector') }}: <strong>{{ search.product_service_id  ?  ($i18n.locale === 'en' ? searchHeaderData.product_service_name : searchHeaderData.product_service_name_bn) : $t('globalTrans.all') }}</strong>
                          </b-col>
                        </b-row>
                        <template v-if="datas.length">
                          <b-row>
                              <b-col>
                                <b-table-simple class="tg mt-3" bordered hover small caption-top responsive>
                                  <b-thead>
                                    <b-tr>
                                      <b-th style="width:10%" class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                                      <b-th style="width:10%" class="text-center">{{ $t('exportCipReport.sector') }}</b-th>
                                      <b-th style="width:10%" class="text-center">{{ $t('exportCipReport.owner_name_address') }}</b-th>
                                      <b-th style="width:10%" class="text-center">{{ $t('exportCipReport.org_name_address') }}</b-th>
                                      <b-th style="width:10%" class="text-center">{{ $t('exportCipReport.new_product') }}</b-th>
                                      <b-th style="width:10%" class="text-center">{{ $t('exportCipReport.new_destination') }}</b-th>
                                    </b-tr>
                                  </b-thead>
                                  <b-tbody  v-for="(info, index) in datas" :key="index">
                                    <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                    <b-td class="text-center">{{ ($i18n.locale === 'bn') ? info.service_sector_name_bn : info.service_sector_name}}</b-td>
                                    <b-td class="text-center">
                                      <slot v-if="search.award_type === 1">
                                        {{ getExterUserName(info.user_id) }}
                                      </slot>
                                      <slot v-if="search.award_type === 2">
                                       {{ ($i18n.locale === 'bn') ? info.org_info.org_name_bn : info.org_info.org_name_en}}
                                      </slot>
                                    </b-td>
                                    <b-td class="text-center">{{ getAddress(info.org_address) }} </b-td>
                                    <b-td class="text-center">{{ info.export_product.length > 0 ? getNewProduct(info.export_product) : $t('exportCipReport.new_product_not_found') }} </b-td>
                                    <b-td class="text-center">{{ info.export_destination.length > 0 ? getNewDestination(info.export_destination) : $t('exportCipReport.new_destination_not_found') }} </b-td>
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
import { newProductApi } from '../../api/routes'
import AddressHelper from '@/utils/area-type-address'
import ModalBaseMasterList from '@/mixins/list'
import ListReportHead from '@/components/custom/ListReportHead.vue'
// import { dateFormat } from '@/utils/fliter'
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
        award_type: 0,
        type: 0,
        fiscal_year_id: 0,
        product_service_id: 0,
        year: 0,
        limit: 20
      },
      hideYear: false,
      hideFiscalYear: false,
      applicants: [],
      datas: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      searchHeaderData: {
        award_type_name: '',
        award_type_name_bn: '',
        type_name: '',
        type_name_bn: '',
        year_name: '',
        year_name_bn: '',
        fiscal_year_name: '',
        fiscal_year_name_bn: '',
        product_service_name: '',
        product_service_name_bn: ''
      },
      showData: false,
      loading: false
    }
  },
  created () {
    this.search.award_type = 1
  },
  watch: {
    'search.award_type': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        if (newVal === 1) {
          this.hideYear = true
          this.hideFiscalYear = false
          this.search.fiscal_year_id = null
        }
        if (newVal === 2) {
          this.hideFiscalYear = true
          this.hideYear = false
          this.search.year = null
        }
        this.datas = []
      }
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
      const local = this.$i18n.locale
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgName
        headerVal[2] = this.headerExcelDefault.address
        headerVal[3] = this.$t('exportCipReport.new_product_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('globalTrans.government_republic_of_bangladesh')
        headerVal[1] = this.headerExcelDefault.orgNameBn
        headerVal[2] = this.headerExcelDefault.address_bn
        headerVal[3] = this.$t('exportCipReport.new_product_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      }
      const awardType = this.$t('exportTrophyConfig.awardType') + ' : ' + (this.search.award_type ? (local === 'en' ? this.searchHeaderData.award_type_name : this.searchHeaderData.award_type_name_bn) : this.$t('globalTrans.all')) + '; '
      const type = this.$t('globalTrans.type') + ' : ' + (this.search.type ? (local === 'en' ? this.searchHeaderData.type_name : this.searchHeaderData.type_name_bn) : this.$t('globalTrans.all')) + '; '
      let yearFiscal
      if (this.search.award_type === 1) {
        yearFiscal = this.$t('globalTrans.year') + ' : ' + (this.search.year ? this.EngBangNum(this.searchHeaderData.year_name.toString()) : this.$t('globalTrans.all')) + '; '
      }
      if (this.search.award_type === 2) {
        yearFiscal = this.$t('globalTrans.fiscal_year') + ' : ' + (this.search.fiscal_year_id ? (local === 'en' ? this.searchHeaderData.fiscal_year_name : this.searchHeaderData.fiscal_year_name_bn) : this.$t('globalTrans.all')) + '; '
      }
      const exportSector = this.$t('exportCipReport.sector') + ' : ' + (this.search.product_service_id ? (local === 'en' ? this.searchHeaderData.product_service_name : this.searchHeaderData.product_service_name_bn) : this.$t('globalTrans.all')) + '; '
      headerVal[5] = awardType + type + yearFiscal + exportSector
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
              'Sector ': keyItem.service_sector_name,
              'Owner Name & Address ': this.search.award_type === 1 ? this.getExterUserName(keyItem.user_id) : (this.$i18n.locale === 'bn') ? keyItem.org_info.org_name_bn : keyItem.org_info.org_name_en,
              'Organization Name & Address': this.getAddress(keyItem.org_address),
              'New Product': keyItem.export_product.length > 0 ? this.getNewProduct(keyItem.export_product) : this.$t('exportCipReport.new_product_not_found'),
              'Destination ': keyItem.export_destination.length > 0 ? this.getNewDestination(keyItem.export_destination) : this.$t('exportCipReport.new_destination_not_found')
            }
          } else {
            return {
              'ক্রমিক সংখ্যা': this.$n(serial),
              'সেক্টর ': keyItem.service_sector_name_bn,
              'প্রার্থীর নাম ও ঠিকানা': this.search.award_type === 1 ? this.getExterUserName(keyItem.user_id) : (this.$i18n.locale === 'bn') ? keyItem.org_info.org_name_bn : keyItem.org_info.org_name_en,
              'প্রতিষ্ঠানের নাম ও ঠিকানা': this.getAddress(keyItem.org_address),
              'নতুন প্রোডাক্ট': keyItem.export_product.length > 0 ? this.getNewProduct(keyItem.export_product) : this.$t('exportCipReport.new_product_not_found'),
              'নতুন গন্তব্য': keyItem.export_destination.length > 0 ? this.getNewDestination(keyItem.export_destination) : this.$t('exportCipReport.new_destination_not_found')
            }
          }
      })
      return listContractor
    },
    YearList () {
      return this.$store.state.commonObj.yearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item, text: this.EngBangNum(item.toString()) }
        } else {
          return { value: item, text: item }
        }
      })
    },
    assignTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    productServiceTypeList () {
      return this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    exportSectorList () {
      return this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.filter(sectorItm => sectorItm.assign_for === this.search.award_type && sectorItm.type === this.search.type).map(el => {
        return Object.assign({}, el, { text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en })
      })
    },
    fiscalYear () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
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
      this.loading = true
      const reportTitle = this.$t('exportCipReport.new_product_report')
      ExportPdf.exportPdfDetails(exportTrophyCIPServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this)
    },
    saveUpdate () {
      this.loadData()
    },
    async loadData () {
      if (this.search.award_type) {
        const awardTypeObj = this.$store.state.ExportTrophyCipService.commonObj.assignTypeList.find(awardType => awardType.value === this.search.award_type)
        this.searchHeaderData.award_type_name = awardTypeObj !== undefined ? awardTypeObj.text_en : ''
        this.searchHeaderData.award_type_name_bn = awardTypeObj !== undefined ? awardTypeObj.text_bn : ''
      }
      if (this.search.type) {
        const typeObj = this.$store.state.ExportTrophyCipService.commonObj.productServiceTypeList.find(type => type.value === this.search.type)
        this.searchHeaderData.type_name = typeObj !== undefined ? typeObj.text_en : ''
        this.searchHeaderData.type_name_bn = typeObj !== undefined ? typeObj.text_bn : ''
      }
      if (this.search.year) {
        const yearObj = this.YearList.find(year => year.value === parseInt(this.search.year))
        this.searchHeaderData.year_name = yearObj !== undefined ? this.EngBangNum(yearObj.value.toString()) : ''
        this.searchHeaderData.year_name_bn = yearObj !== undefined ? this.EngBangNum(yearObj.value.toString()) : ''
      }
      if (this.search.fiscal_year_id) {
        const fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(fiscalYear => fiscalYear.value === this.search.fiscal_year_id)
        this.searchHeaderData.fiscal_year_name = fiscalYearObj !== undefined ? fiscalYearObj.text_en : ''
        this.searchHeaderData.fiscal_year_name_bn = fiscalYearObj !== undefined ? fiscalYearObj.text_bn : ''
      }
      if (this.search.product_service_id) {
        const productServiceTypeObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(data => data.value === this.search.product_service_id)
        this.searchHeaderData.product_service_name = productServiceTypeObj !== undefined ? productServiceTypeObj.text_en : ''
        this.searchHeaderData.product_service_name_bn = productServiceTypeObj !== undefined ? productServiceTypeObj.text_bn : ''
      }
      this.showData = true
      this.loading = true
      const params = Object.assign({}, this.search)
      this.$store.dispatch('mutateCommonProperties', { loading: true, listReload: false })
      const result = await RestApi.getData(exportTrophyCIPServiceBaseUrl, newProductApi, params)
      if (result.success) {
        if (this.search.award_type === 1) {
          this.applicants = result.users
        }
        this.datas = result.data.map(item => {
          const productServiceSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(sector => sector.value === item.product_service_sector_id)
            const customData = {
              service_sector_name: productServiceSectorObj !== undefined ? productServiceSectorObj.text_en : '',
              service_sector_name_bn: productServiceSectorObj !== undefined ? productServiceSectorObj.text_bn : ''
            }
         return Object.assign({}, item, customData)
        })
      } else {
        this.datas = []
      }
      this.loading = false
      this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
    },
    getExterUserName (id) {
      const userName = this.applicants.find(user => user.value === parseInt(id))
        if (userName !== undefined) {
          if (this.$i18n.locale === 'bn') {
            return userName.text_bn
          } else {
            return userName.text_en
          }
        }
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    getAddress (address) {
      const newAddress = {
        pr_area_type_id: address.area_type_id,
        pr_division_id: address.division_id,
        pr_district_id: address.district_id,
        pr_upazila_id: address.upazila_id,
        pr_city_corporation_id: address.city_corporation_id,
        pr_union_id: address.union_id,
        pr_ward_id: address.ward_id,
        pr_paurashava_id: address.paurashava_id
      }
      const fullAddress = this.AddressHelper.getPresentAddress(newAddress)
      return fullAddress
    },
    getNewProduct (data) {
      const newProduct = []
      data.map(item => {
        const productServiceSectorObj = this.$store.state.ExportTrophyCipService.commonObj.exportSectorList.find(sector => sector.value === item.product_id)
        if (productServiceSectorObj !== undefined) {
          if (this.currentLocale === 'bn') {
            newProduct.push(productServiceSectorObj.text_bn)
          } else {
            newProduct.push(productServiceSectorObj.text_en)
          }
        }
      })
      return newProduct.join()
    },
    getNewDestination (data) {
      const newDestination = []
      data.map(item => {
        const countryObj = this.$store.state.CommonService.commonObj.countryList.find(country => country.value === parseInt(item.country_id))
        if (countryObj !== undefined) {
          if (this.currentLocale === 'bn') {
            newDestination.push(countryObj.text_bn)
          } else {
            newDestination.push(countryObj.text_en)
          }
        }
      })
      return newDestination.join()
    }
  }
}
</script>
