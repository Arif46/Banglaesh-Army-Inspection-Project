<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.dealer_report')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
        <b-row class="mt-4">
        <b-col lg="4" sm="4">
            <ValidationProvider name="Regional Office" vid="regional_office" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="regional_office"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('organogram.regional_office_name')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.regional_office"
                  :options="regionalOfficeList"
                  id="org_id"
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
          <b-col lg="4" sm="4">
            <ValidationProvider name="Report type" vid="report_type" rules="">
              <b-form-group
                class="row"
                label-for="report_type"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.report_type')}}
                  </template>
                <b-form-select
                  plain
                  v-model="search.report_type"
                  :options="reportTypeList"
                  id="org_id"
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
          <b-col lg="4" sm="4">
            <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="">
              <b-form-group
                class="row"
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
                    <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col lg="4" sm="4" v-if="parseInt(search.report_type) === 2">
            <ValidationProvider name="Month" vid="bn_month" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="bn_month"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.month')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.bn_month"
                  :options="banglaMonthList"
                  id="bn_month"
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
           <b-col lg="4" sm="4">
              <ValidationProvider name="Area Type" vid="area_type_id" rules="">
                <b-form-group
                    class="row"
                    label-for="area_type_id "
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                        {{$t('orgProfile.area_type')}}
                    </template>
                    <b-form-select
                    plain
                    v-model="search.area_type_id"
                    id="area_type_id"
                    :options="getAreaTypeList"
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
            <b-col lg="4" sm="4"  v-if="ItemShow">
              <ValidationProvider name="Division" vid="division_id" :rules="divRequrire">
                  <b-form-group
                      class="row"
                      label-for="division_id"
                      slot-scope="{ valid, errors }"
                      >
                      <template v-slot:label>
                      {{ $t('orgProfile.division')}} <span class="text-danger">*</span>
                      </template>
                      <b-form-select
                      plain
                      v-model="search.division_id"
                      :options="divisionList"
                      id="division_id"
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
             <b-col lg="4" sm="4" v-if="ItemShow">
                <ValidationProvider name="District" vid="district_id" rules="">
                    <b-form-group
                        class="row"
                        label-for="district_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.district')}}
                        </template>
                        <b-form-select
                        plain
                        v-model="search.district_id"
                        :options="districtList"
                        id="district_id"
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
             <b-col lg="4" sm="4" v-if="PauroshobaItemShow">
                <ValidationProvider name="Upazila" vid="upazilla_id">
                    <b-form-group
                        class="row"
                        label-for="upazilla_id"
                        slot-scope="{ valid, errors }"
                        >
                        <template v-slot:label>
                        {{ $t('orgProfile.upazila')}}
                        </template>
                        <b-form-select
                        plain
                        v-model="search.upazilla_id"
                        :options="upazilaList"
                        id="upazilla_id"
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
              <b-col lg="4" sm="4"  v-if="CityCorpItemShow">
                  <ValidationProvider name="City Corporation" vid="city_corporation_id">
                      <b-form-group
                          class="row"
                          label-for="city_corporation_id"
                          slot-scope="{ valid, errors }"
                          >
                          <template v-slot:label>
                              {{ $t('orgProfile.city_corporation') }}
                          </template>
                          <b-form-select
                          plain
                          v-model="search.city_corporation_id"
                          :options="cityCorporationList"
                          id="city_corporation_id"
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
        </b-row>
          <b-row class="text-right">
          <b-col>
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{$t('globalTrans.search')}}</b-button>
          </b-col>
        </b-row>
        </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>
    <body-card style="overflow-x: clip;">
    <b-row class="text-right mt-2">
        <b-col>
            <b-button variant="primary" @click="pdfExport" class="mr-2">
                  {{  $t('globalTrans.print') }}
            </b-button>
              <export-excel
              class="btn btn-primary ml-2 mr-2"
              :title="headerValue"
              :data="excelData"
              worksheet="Report Sheet"
              name="dealer_report.xls">
              {{ $t('globalTrans.export_excel') }}
            </export-excel>
        </b-col>
    </b-row>
    <ReportHeading />
    <div class="text-black mb-4" style="width: 98%;margin: auto;">
     <!-- <b-overlay :show="loading"> -->
      <b-row class="mt-3">
        <b-col xl="4" lg="4" sm="12">
          {{ $t('organogram.regional_office_name') }}: <strong>{{ search.regional_office ? ($i18n.locale === 'en' ? officeObj.text_en : officeObj.text_bn) : $t('globalTrans.all') }}</strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.report_type) === 2">
          {{ $t('tcb_report.report_type') }}: <strong>{{ search.report_type ? ($i18n.locale === 'en' ? 'Monthly' : 'মাসিক') : $t('globalTrans.all') }}</strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.report_type) === 1">
          {{ $t('tcb_report.report_type') }}: <strong>{{ search.report_type ? ($i18n.locale === 'en' ? 'Yearly' : 'বার্ষিক') : $t('globalTrans.all') }}</strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12">
          {{ $t('globalTrans.fiscal_year') }}: <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? fiscalYearObj.text_en : fiscalYearObj.text_bn) : $t('globalTrans.all') }}</strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.report_type) === 2">
          {{ $t('tcb_report.month') }}: <strong>{{ search.bn_month ? ($i18n.locale === 'en' ? monthObj.text_en : monthObj.text_bn) : $t('globalTrans.all') }}</strong>
        </b-col>
       <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.division_id) > 0">
               {{$t('globalTrans.division')}} :  <strong>{{getDivisionName(search.division_id)}} </strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.district_id) > 0">
           {{$t('globalTrans.district')}} :  <strong>{{AddressHelper.getDistrictName(search.district_id)}} </strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.upazilla_id) > 0">
            {{$t('globalTrans.upazila')}} :   <strong> {{AddressHelper.getUpazilaName(search.upazilla_id)}} </strong>
        </b-col>
        <b-col xl="4" lg="4" sm="12" v-if="parseInt(search.city_corporation_id) > 0">
            {{$t('orgProfile.city_corporation')}} : <strong> {{ AddressHelper.getCityCorporationName(search.city_corporation_id)}} </strong>
        </b-col>
      </b-row>
     <!-- </b-overlay> -->
    </div>
      <!-- table section start -->
  <b-overlay :show="loading">
    <div v-if="reportType > 0 && reportType < 4">
        <div style="width:100%;overflow-x:auto;padding: 10px;">
          <template v-for="(divData, index) in reportData">
              <div :key="index+1" class="text-center p-2">
                <h4 v-if="reportType === 1"> {{$t('globalTrans.division')}} : {{getDivisionName(index)}}</h4>
                <h4 v-if="reportType === 2"> {{$t('globalTrans.district')}} : {{AddressHelper.getDistrictName(index)}}</h4>

                <h4 v-if="reportType === 3 && search.district_id > 0 && search.area_type_id > 1"> {{$t('globalTrans.upazila')}} : {{AddressHelper.getUpazilaName(index)}}</h4>

                <h4 v-if="reportType === 3 && search.area_type_id == 1 && search.district_id > 0"> {{$t('orgProfile.city_corporation')}} : {{ index > 0 ? AddressHelper.getCityCorporationName(index) : 'N/A' }}</h4>

              </div>
              <table class="table-sm" style="width: 100%; padding:10px" :key="index+2">
                <tr>
                  <th>{{$t('globalTrans.sl_no')}}</th>
                  <th v-if="reportType == 1">{{$t('tcb_report.district')}}</th>
                  <th v-if="reportType == 1 || reportType == 2">{{$t('tcb_report.upazila')}}</th>
                  <th>{{$t('tcb_report.dealer_name')}}</th>
                  <th>{{$t('tcb_report.institute_name')}}</th>
                  <th>{{$t('tcb_report.address')}}</th>
                  <th>{{$t('tcb_report.mobile_no')}}</th>
                  <th>{{$t('tcb_report.contract_date')}}</th>
                  <!-- <th>{{$t('tcb_report.renew_date')}}</th> -->
                  <th>{{$t('tcb_report.contract_duration')}}</th>
                  <th>{{$t('tcb_report.distance_km')}}</th>
                </tr>
                  <template v-if="divData.length > 0">
                    <tr v-for="(item, index) in divData" :key="index">
                      <td>{{ $n(index + 1) }}</td>
                      <td v-if="reportType == 1">{{ AddressHelper.getDistrictName(item.company_district_id) }}</td>
                      <td v-if="(reportType == 1 || reportType == 2)">{{ parseInt(item.company_area_type_id) > 1 ? AddressHelper.getUpazilaName(item.company_upazilla_id) : AddressHelper.getCityCorporationName(item.company_city_corporation_id)}}</td>
                      <td>{{ currentLocale == 'en' ? item.applicant_name : item.applicant_name_bn }}</td>
                      <td>{{ currentLocale == 'en' ? item.company_name : item.company_name_bn}}</td>
                      <td>{{  currentLocale == 'en' ? item.company_address : item.company_address_bn }}</td>
                      <td>{{ $n('0') + $n(item.mobile, { useGrouping: false }) }}</td>
                      <td>{{ item.agreement_date |dateFormat }}</td>
                      <!-- <td></td> -->
                      <td>{{ item.expire_date|dateFormat }}</td>
                      <td>{{ getDistanceFromTcb(item.distance_id)}}</td>
                    </tr>
                  </template>
                   <tr v-else>
                      <td colspan="11" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                    </tr>
              </table>
            </template>
      </div>
    </div>
    <div v-if="reportType < 4">
      <p v-if="reportData.length == 0 && searching" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</p>
    </div>
  </b-overlay>
    <div v-if="reportType == 4">
        <div style="width:100%;overflow-x:auto;">
        <b-overlay :show="loading">
          <table class="table-sm" style="width: 100%;" :key="index+2">
            <tr>
              <th>{{$t('globalTrans.sl_no')}}</th>
              <th>{{$t('tcb_report.dealer_name')}}</th>
              <th>{{$t('tcb_report.institute_name')}}</th>
              <th>{{$t('tcb_report.address')}}</th>
              <th>{{$t('tcb_report.mobile_no')}}</th>
              <th>{{$t('tcb_report.contract_date')}}</th>
              <th>{{$t('tcb_report.renew_date')}}</th>
              <th>{{$t('tcb_report.contract_duration')}}</th>
              <th>{{$t('tcb_report.distance_km')}}</th>
            </tr>
              <template v-if="reportData.length > 0">
                <tr v-for="(item, index) in reportData" :key="index">
                  <td>{{ $n(index + 1) }}</td>
                  <td>{{ currentLocale == 'en' ? item.applicant_name : item.applicant_name_bn }}</td>
                  <td>{{ currentLocale == 'en' ? item.company_name : item.company_name_bn}}</td>
                  <td>{{  currentLocale == 'en' ? item.company_address : item.company_address_bn }}</td>
                  <td>{{ $n('0') + $n(item.mobile, { useGrouping: false }) }}</td>
                  <td>{{ item.agreement_date|dateFormat }}</td>
                  <td></td>
                  <td>{{ item.expire_date|dateFormat }}</td>
                  <td>{{ getDistanceFromTcb(item.distance_id)}}</td>
                </tr>
              </template>
              <tr v-else>
                  <td colspan="9" class="text-center text-danger">{{ $t('teaGardenPanel.no_data_found') }}</td>
                </tr>
          </table>
        </b-overlay>
      </div>
    </div>
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { dealerReport, getRegionDvision } from '../../api/routes'
import Pdf from './pdf'
import AddressHelper from '@/utils/area-type-address'
import ReportHeading from '../../components/ReportHeading.vue'
import excel from 'vue-excel-export'
import Vue from 'vue'
import { dateFormat } from '@/utils/fliter'
Vue.use(excel)
export default {
  components: {
    ReportHeading
  },
  data () {
    return {
      loading: false,
      AddressHelper: AddressHelper,
      search: {
        fiscal_year_id: '',
        regional_office: 0,
        area_type_id: 0,
        division_id: 0,
        district_id: 0,
        upazilla_id: 0,
        city_corporation_id: 0,
        report_type: 0,
        bn_month: 0
      },
      divisionList: [],
      headerExcelDefault: {
        orgName: null,
        orgNameBn: null,
        address: null,
        address_bn: null
      },
      divDistrictList: [],
      districtList: [],
      upazilaList: [],
      cityCorporationList: [],
      ItemShow: false,
      locationShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      searching: false,
      divRequrire: '',
      reportType: 0,
      reportData: [],
      officeObj: {
        text_en: 'null',
        text_bn: 'null'
      },
      fiscalYearObj: {
        text_en: 'null',
        text_bn: 'null'
      },
      monthObj: {
        text_en: 'null',
        text_bn: 'null'
      },
      show: false,
      listDataa: []
    }
  },
  created () {
  },
  watch: {
    'search.regional_office': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.officeObj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === newVal)
        this.getRegionDivision(newVal)
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fiscalYearObj = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => parseInt(item.text_en.substr(0, 4)) === newVal)
      }
    },
    'search.bn_month': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.monthObj = this.$store.state.commonObj.monthList.find(item => item.value === newVal)
      }
    },
    'search.area_type_id': function (n, o) {
      if (o !== n) {
        this.getAreaTypeData(n)
          this.search.division_id = 0
          this.search.district_id = 0
          this.search.upazilla_id = 0
          this.search.city_corporation_id = 0
          if (n > 0) {
            this.divRequrire = 'required|min_value:1'
          }
      }
    },
    'search.division_id': function (newVal, oldVal) {
      if (oldVal !== newVal) {
        const disIds = []
        this.divDistrictList[newVal].forEach(element => {
          disIds.push(element.district_id)
        })
        this.districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => disIds.includes(item.value))
      }
    },
     'search.district_id': function (newVal, oldVal) {
      this.cityCorporationList = this.getCityCorporationList(newVal)
      this.upazilaList = this.getUpazillaList(newVal)
    }
  },
  computed: {
    headerValue: function () {
      const headerVal = []
      if (this.$i18n.locale === 'en') {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('tcb_report.trading_corporation_of_bangladesh')
        headerVal[2] = this.$t('tcb_report.tcb_address')
        headerVal[3] = this.$t('tcb_report.dealer_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      } else {
        headerVal[0] = this.$t('tcb_report.government_text')
        headerVal[1] = this.$t('tcb_report.trading_corporation_of_bangladesh')
        headerVal[2] = this.$t('tcb_report.tcb_address')
        headerVal[3] = this.$t('tcb_report.dealer_report')
        headerVal[4] = ''
        headerVal[5] = ''
        headerVal[6] = ''
      }
      const fiscalYear = this.$t('globalTrans.fiscalYear') + ' : ' + (this.search.fiscal_year_id ? (this.currentLocale === 'en' ? this.fiscalYearObj.text_en : this.fiscalYearObj.text_bn) : this.$t('globalTrans.all')) + '; '

      let dealerReportType = this.$t('globalTrans.type') + ' : '
      if (this.search.report_type === 1) {
        dealerReportType += (this.currentLocale === 'bn' ? 'বার্ষিক' : 'Yearly') + '; '
      } else if (this.search.report_type === 2) {
        dealerReportType += (this.currentLocale === 'bn' ? 'মাসিক' : 'Monthly') + '; '
      } else {
        dealerReportType += this.$t('globalTrans.all') + '; '
      }
      let textDivision = this.$t('globalTrans.division') + ' : '
      if (this.search.division_id > 0) {
          textDivision += this.getDivisionName(this.search.division_id) + '; '
      } else {
         textDivision += this.$t('globalTrans.all') + '; '
      }
      let textDistrict = this.$t('globalTrans.district') + ' : '
      if (parseInt(this.search.district_id) > 0) {
          textDistrict += this.AddressHelper.getDistrictName(this.search.district_id) + '; '
      } else {
        textDistrict += this.$t('globalTrans.all') + '; '
      }
      let textUpazilla = this.$t('globalTrans.upazila') + ' : '
      if (parseInt(this.search.upazilla_id) > 0) {
        textUpazilla += AddressHelper.getUpazilaName(this.search.upazilla_id) + '; '
      } else {
        textUpazilla += this.$t('globalTrans.all') + '; '
      }
      let textCityCorporation = this.$t('globalTrans.city_corporation') + ' : '
      if (parseInt(this.search.city_corporation_id) > 0) {
        textCityCorporation += AddressHelper.getCityCorporationName(this.search.city_corporation_id)
      } else {
        textCityCorporation += this.$t('globalTrans.all') + '; '
      }

      headerVal[5] = fiscalYear + dealerReportType + textDivision + textDistrict + textUpazilla + textCityCorporation
      return headerVal
    },
    excelData: function () {
      if (this.reportData.length <= 0) return []
      const listData = this.reportData
      var serial = 0
      const excelData = []
      if (this.reportType === 1) {
          for (const groupItem in listData) {
            const groupRow = []
            if (this.$i18n.locale === 'en') {
              groupRow.sl = ' '
              groupRow.district_name = ' '
              groupRow.upazilla_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.division') + ' : '
              groupRow.mobile = this.getDivisionName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            } else {
              groupRow.sl = ' '
              groupRow.district_name = ' '
              groupRow.upazilla_name = ' '
              groupRow.dealer_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.division') + ' : '
              groupRow.mobile = this.getDivisionName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            }
           excelData.push(groupRow)
           const headerRow = []
            if (this.$i18n.locale === 'en') {
              headerRow.sl = 'Sl No'
              headerRow.district_name = 'District name'
              headerRow.upazilla_name = 'Upazilla name'
              headerRow.company_name = 'Company Name'
              headerRow.address = 'Address'
              headerRow.mobile = 'Mobile No.'
              headerRow.deal_date = 'Deal Date'
              // headerRow.renew_date = 'Renew Date'
              headerRow.deal_duration = 'Deal Duration'
              headerRow.distance = 'Distance (Km)'
            } else {
              headerRow.sl = 'ক্রমিক সংখ্য'
              headerRow.district_name = 'জেলার নাম'
              headerRow.upazilla_name = 'উপজেলার নাম'
              headerRow.dealer_name = 'ডিলারের নাম'
              headerRow.company_name = 'প্রতিষ্ঠানের নাম'
              headerRow.address = 'ঠিকানা'
              headerRow.mobile = 'মোবাইল নং'
              headerRow.deal_date = 'চুক্তি সম্পাদনের তারিখ'
              // headerRow.renew_date = 'নবায়নের তারিখ'
              headerRow.deal_duration = 'চুক্তির মেয়াদ'
              headerRow.distance = 'দূরত্ব (কিঃমিঃ)'
            }
           excelData.push(headerRow)
           listData[groupItem].map((item, index) => {
              const loopRow = []
              if (this.reportType === 1) {
                  if (this.$i18n.locale === 'en') {
                  loopRow.sl = this.$n(index + 1)
                  loopRow.district_name = AddressHelper.getDistrictName(item.company_district_id)
                  loopRow.upazilla_name = item.company_area_type_id > 1 ? AddressHelper.getUpazilaName(item.company_upazilla_id) : AddressHelper.getCityCorporationName(item.company_city_corporation_id)
                  loopRow.dealer_name = item.applicant_name
                  loopRow.company_name = item.company_name
                  loopRow.address = item.company_address
                  loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                  loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                  // loopRow.renew_date = ' '
                  loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                  loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                } else {
                  loopRow.sl = this.$n(index + 1)
                  loopRow.district_name = AddressHelper.getDistrictName(item.company_district_id)
                  loopRow.upazilla_name = item.company_area_type_id > 1 ? AddressHelper.getUpazilaName(item.company_upazilla_id) : AddressHelper.getCityCorporationName(item.company_city_corporation_id)
                  loopRow.dealer_name = item.applicant_name_bn
                  loopRow.company_name = item.company_name_bn
                  loopRow.address = item.company_address_bn
                  loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                  loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                  // loopRow.renew_date = ' '
                  loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                  loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                }
                excelData.push(loopRow)
              }
            })
          }
      }
      if (this.reportType === 2) {
        for (const groupItem in this.reportData) {
          const groupRow2 = []
          if (this.$i18n.locale === 'en') {
            groupRow2.sl = ' '
            groupRow2.upazilla_name = ' '
            groupRow2.company_name = ' '
            groupRow2.address = this.$t('globalTrans.district') + ' : '
            groupRow2.mobile = AddressHelper.getDistrictName(groupItem)
            groupRow2.deal_date = ' '
            // groupRow2.renew_date = ' '
            groupRow2.deal_duration = ' '
            groupRow2.distance = ' '
          } else {
            groupRow2.sl = ' '
            groupRow2.upazilla_name = ' '
            groupRow2.dealer_name = ' '
            groupRow2.company_name = ' '
            groupRow2.address = this.$t('globalTrans.district') + ' : '
            groupRow2.mobile = AddressHelper.getDistrictName(groupItem)
            groupRow2.deal_date = ' '
            // groupRow2.renew_date = ' '
            groupRow2.deal_duration = ' '
            groupRow2.distance = ' '
          }
          excelData.push(groupRow2)
          const headerRow2 = []
          if (this.$i18n.locale === 'en') {
            headerRow2.sl = 'Sl No'
            headerRow2.upazilla_name = 'Upazilla name'
            headerRow2.company_name = 'Company Name'
            headerRow2.address = 'Address'
            headerRow2.mobile = 'Mobile No.'
            headerRow2.deal_date = 'Deal Date'
            // headerRow2.renew_date = 'Renew Date'
            headerRow2.deal_duration = 'Deal Duration'
            headerRow2.distance = 'Distance (Km)'
          } else {
            headerRow2.sl = 'ক্রমিক সংখ্য'
            headerRow2.upazilla_name = 'উপজেলার নাম'
            headerRow2.dealer_name = 'ডিলারের নাম'
            headerRow2.company_name = 'প্রতিষ্ঠানের নাম'
            headerRow2.address = 'ঠিকানা'
            headerRow2.mobile = 'মোবাইল নং'
            headerRow2.deal_date = 'চুক্তি সম্পাদনের তারিখ'
            // headerRow2.renew_date = 'নবায়নের তারিখ'
            headerRow2.deal_duration = 'চুক্তির মেয়াদ'
            headerRow2.distance = 'দূরত্ব (কিঃমিঃ)'
          }
          excelData.push(headerRow2)
          listData[groupItem].map((item, index) => {
              const loopRow = []
                  if (this.$i18n.locale === 'en') {
                  loopRow.sl = this.$n(index + 1)
                  loopRow.upazilla_name = item.company_area_type_id > 1 ? AddressHelper.getUpazilaName(item.company_upazilla_id) : AddressHelper.getCityCorporationName(item.company_city_corporation_id)
                  loopRow.dealer_name = item.applicant_name
                  loopRow.company_name = item.company_name
                  loopRow.address = item.company_address
                  loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                  loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                  // loopRow.renew_date = ' '
                  loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                  loopRow.distance = this.getDistanceFromTcb(item.distance_id)
              } else {
                  loopRow.sl = this.$n(index + 1)
                  loopRow.upazilla_name = item.company_area_type_id > 1 ? AddressHelper.getUpazilaName(item.company_upazilla_id) : AddressHelper.getCityCorporationName(item.company_city_corporation_id)
                  loopRow.dealer_name = item.applicant_name_bn
                  loopRow.company_name = item.company_name_bn
                  loopRow.address = item.company_address_bn
                  loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                  loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                  // loopRow.renew_date = ' '
                  loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                  loopRow.distance = this.getDistanceFromTcb(item.distance_id)
              }
              excelData.push(loopRow)
            })
        }
      }
      if (this.reportType === 3 && this.search.area_type_id > 1) {
          for (const groupItem in listData) {
            const groupRow = []
            if (this.$i18n.locale === 'en') {
              groupRow.sl = ' '
              groupRow.dealer_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.upazila') + ' : '
              groupRow.mobile = AddressHelper.getUpazilaName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            } else {
              groupRow.sl = ' '
              groupRow.dealer_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.upazila') + ' : '
              groupRow.mobile = AddressHelper.getUpazilaName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            }
           excelData.push(groupRow)
           const headerRow = []
            if (this.$i18n.locale === 'en') {
              headerRow.sl = 'Sl No'
              groupRow.dealer_name = 'Dealer Name'
              headerRow.company_name = 'Company Name'
              headerRow.address = 'Address'
              headerRow.mobile = 'Mobile No.'
              headerRow.deal_date = 'Deal Date'
              // headerRow.renew_date = 'Renew Date'
              headerRow.deal_duration = 'Deal Duration'
              headerRow.distance = 'Distance (Km)'
            } else {
              headerRow.sl = 'ক্রমিক সংখ্য'
              headerRow.dealer_name = 'ডিলারের নাম'
              headerRow.company_name = 'প্রতিষ্ঠানের নাম'
              headerRow.address = 'ঠিকানা'
              headerRow.mobile = 'মোবাইল নং'
              headerRow.deal_date = 'চুক্তি সম্পাদনের তারিখ'
              // headerRow.renew_date = 'নবায়নের তারিখ'
              headerRow.deal_duration = 'চুক্তির মেয়াদ'
              headerRow.distance = 'দূরত্ব (কিঃমিঃ)'
            }
           excelData.push(headerRow)
           listData[groupItem].map((item, index) => {
                 const loopRow = []
                       if (this.$i18n.locale === 'en') {
                       loopRow.sl = this.$n(index + 1)
                       loopRow.dealer_name = item.applicant_name
                       loopRow.company_name = item.company_name
                       loopRow.address = item.company_address
                       loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                       loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                      //  loopRow.renew_date = ' '
                       loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                       loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                   } else {
                       loopRow.sl = this.$n(index + 1)
                       loopRow.dealer_name = item.applicant_name_bn
                       loopRow.company_name = item.company_name_bn
                       loopRow.address = item.company_address_bn
                       loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                       loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                      //  loopRow.renew_date = ' '
                       loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                       loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                   }
                   excelData.push(loopRow)
             })
          }
      }
      if (this.reportType === 3 && this.search.area_type_id === 1) {
          for (const groupItem in listData) {
            const groupRow = []
            if (this.$i18n.locale === 'en') {
              groupRow.sl = ' '
              groupRow.dealer_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.city_corporation') + ' : '
              groupRow.mobile = AddressHelper.getCityCorporationName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            } else {
              groupRow.sl = ' '
              groupRow.dealer_name = ' '
              groupRow.company_name = ' '
              groupRow.address = this.$t('globalTrans.city_corporation') + ' : '
              groupRow.mobile = AddressHelper.getCityCorporationName(groupItem)
              groupRow.deal_date = ' '
              // groupRow.renew_date = ' '
              groupRow.deal_duration = ' '
              groupRow.distance = ' '
            }
           excelData.push(groupRow)
           const headerRow = []
            if (this.$i18n.locale === 'en') {
              headerRow.sl = 'Sl No'
              groupRow.dealer_name = 'Dealer Name'
              headerRow.company_name = 'Company Name'
              headerRow.address = 'Address'
              headerRow.mobile = 'Mobile No.'
              headerRow.deal_date = 'Deal Date'
              // headerRow.renew_date = 'Renew Date'
              headerRow.deal_duration = 'Deal Duration'
              headerRow.distance = 'Distance (Km)'
            } else {
              headerRow.sl = 'ক্রমিক সংখ্য'
              headerRow.dealer_name = 'ডিলারের নাম'
              headerRow.company_name = 'প্রতিষ্ঠানের নাম'
              headerRow.address = 'ঠিকানা'
              headerRow.mobile = 'মোবাইল নং'
              headerRow.deal_date = 'চুক্তি সম্পাদনের তারিখ'
              // headerRow.renew_date = 'নবায়নের তারিখ'
              headerRow.deal_duration = 'চুক্তির মেয়াদ'
              headerRow.distance = 'দূরত্ব (কিঃমিঃ)'
            }
           excelData.push(headerRow)
           listData[groupItem].map((item, index) => {
                 const loopRow = []
                       if (this.$i18n.locale === 'en') {
                       loopRow.sl = this.$n(index + 1)
                       loopRow.dealer_name = item.applicant_name
                       loopRow.company_name = item.company_name
                       loopRow.address = item.company_address
                       loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                       loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                      //  loopRow.renew_date = ' '
                       loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                       loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                   } else {
                       loopRow.sl = this.$n(index + 1)
                       loopRow.dealer_name = item.applicant_name_bn
                       loopRow.company_name = item.company_name_bn
                       loopRow.address = item.company_address_bn
                       loopRow.mobile = this.$n(item.mobile, { useGrouping: false })
                       loopRow.deal_date = item.agreement_date === null ? ' ' : dateFormat(item.agreement_date)
                      //  loopRow.renew_date = ' '
                       loopRow.deal_duration = item.expire_date === null ? ' ' : dateFormat(item.expire_date)
                       loopRow.distance = this.getDistanceFromTcb(item.distance_id)
                   }
                   excelData.push(loopRow)
             })
          }
      }
      if (this.reportType === 4) {
           const firstData = []
           if (this.$i18n.locale === 'en') {
             firstData.sl = 'Sl No'
             firstData.dealer_name = 'Dealer name'
             firstData.company_name = 'Company Name'
             firstData.address = 'Address'
             firstData.mobile = 'Mobile No.'
             firstData.deal_date = 'Deal Date'
            //  firstData.renew_date = 'Renew Date'
             firstData.deal_duration = 'Deal Duration'
             firstData.distance = 'Distance (Km)'
           } else {
             firstData.sl = 'ক্রমিক সংখ্য'
             firstData.dealer_name = 'ডিলারের নাম'
             firstData.company_name = 'প্রতিষ্ঠানের নাম'
             firstData.address = 'ঠিকানা'
             firstData.mobile = 'মোবাইল নং'
             firstData.deal_date = 'চুক্তি সম্পাদনের তারিখ'
            //  firstData.renew_date = 'নবায়নের তারিখ'
             firstData.deal_duration = 'চুক্তির মেয়াদ'
             firstData.distance = 'দূরত্ব (কিঃমিঃ)'
           }
          excelData.push(firstData)
          listData.map((item, index) => {
             const newLoop = []
                serial++
                if (this.$i18n.locale === 'en') {
                    newLoop.sl = serial
                    newLoop.dealer_name = item.applicant_name
                    newLoop.company_name = item.company_name
                    newLoop.address = item.company_address
                    newLoop.mobile = this.$n(item.mobile, { useGrouping: false })
                    newLoop.deal_date = dateFormat(item.agreement_date)
                    // newLoop.renew_date = ''
                    newLoop.deal_duration = dateFormat(item.expire_date)
                    newLoop.distance = this.getDistanceFromTcb(item.distance_id)
                } else {
                    newLoop.sl = this.$n(serial)
                    newLoop.dealer_name = item.applicant_name_bn
                    newLoop.company_name = item.company_name_bn
                     newLoop.address = item.company_address_bn
                    newLoop.mobile = this.$n(item.mobile, { useGrouping: false })
                    newLoop.deal_date = dateFormat(item.agreement_date)
                    // newLoop.renew_date = ''
                    newLoop.deal_duration = dateFormat(item.expire_date)
                    newLoop.distance = this.getDistanceFromTcb(item.distance_id)
                }
                excelData.push(newLoop)
            })
      }
      return excelData
    },
    currentLocale () {
      return this.$i18n.locale
    },
    getAreaTypeList: function () {
      const objectData = this.$store.state.commonObj.typeList
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.id, text: obj.name_bn }
          } else {
            return { value: obj.id, text: obj.name }
          }
      })
    },
    regionalOfficeList (orgId = null) {
      return this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: parseInt(item.text_en), text: this.EngBangNum(item.text_bn) }
        } else {
          return { value: parseInt(item.text_en), text: item.text_en }
        }
      })
    },
    banglaMonthList () {
      return this.$store.state.commonObj.monthList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
     tcbDistanceList () {
      let distanceType = [
        {
          value: 1,
          text_en: '0-50 km',
          text_bn: '০-৫০ কিঃ মিঃ'
        },
        {
          value: 2,
          text_en: '51-100 km',
          text_bn: '৫১-১০০ কিঃ মিঃ'
        },
        {
          value: 3,
          text_en: '100+ km',
          text_bn: '১০০+ কিঃ মিঃ'
        }
      ]
      distanceType = distanceType.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn, text_en: item.text_en, text_bn: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en, text_en: item.text_en, text_bn: item.text_bn }
        }
      })
      return distanceType
    },
    reportTypeList () {
      let reportTypeList = [{
          value: '1',
          text_en: 'Yearly',
          text_bn: 'বার্ষিক'
      },
      {
          value: '2',
          text_en: 'Monthly',
          text_bn: 'মাসিক'
      }]
       reportTypeList = reportTypeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return reportTypeList
    }
  },
  methods: {
    getUpazillaList (districtId) {
      return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === districtId)
    },
    getCityCorporationList (districtId) {
      const objectData = this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === districtId)
      return objectData.map((obj, key) => {
          if (this.$i18n.locale === 'bn') {
            return { value: obj.value, text: obj.text_bn }
          } else {
            return { value: obj.value, text: obj.text_en }
          }
      })
    },
    getAreaTypeData (typeId) {
      if (typeId) {
        this.ItemShow = true
        if (typeId === 1) {
          this.CityCorpItemShow = true
          this.PauroshobaItemShow = false
        } else if (typeId === 2) {
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
        } else if (typeId === 3) {
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = true
        }
      }
      if (typeId === 0) {
          this.ItemShow = false
          this.CityCorpItemShow = false
          this.PauroshobaItemShow = false
      }
    },
   async getRegionDivision (officeId) {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, `${getRegionDvision}/${officeId}`)
        if (result.success) {
            const divIds = []
            const divWiseDistrict = {}
            result.data.map((item, index) => {
                divIds.push(item.division_id)
                divWiseDistrict[item.division_id] = item.district_details
            })
            this.divDistrictList = divWiseDistrict
            this.divisionList = this.$store.state.CommonService.commonObj.divisionList.filter(item => divIds.includes(item.value))
            // if (this.profile.division_id > 0) {
            //     const disIds = []
            //     this.divDistrictList[this.profile.UnionItemShow].forEach(element => {
            //         disIds.push(element.district_id)
            //     })
            //     this.districtList = this.$store.state.CommonService.commonObj.districtList.filter(item => disIds.includes(item.value))
            // }
        }
        this.$store.dispatch('mutateCommonProperties', { loading: false })
    },
  searchData () {
      this.show = true
      this.searching = true
      this.loading = true
      RestApi.getData(licenseRegistrationServiceBaseUrl, dealerReport, this.search).then(response => {
      if (response.success) {
        this.reportType = response.report_type
        this.reportData = response.data
      }
       this.loading = false
      })
  },
  EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
    getDivisionName (Id) {
      const Obj = this.$store.state.CommonService.commonObj.divisionList.find(item => item.value === parseInt(Id))
      if (Obj) {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ''
      }
    },
     getCityCorporationName (id) {
        const cityCorporation = this.$store.state.CommonService.commonObj.cityCorporationList.find(item => item.value === id)
            if (cityCorporation && this.$i18n.locale === 'bn') {
                return cityCorporation.text_bn
            } else if (cityCorporation && this.$i18n.locale === 'en') {
                return cityCorporation.text_en
            }
        },
    getDistanceFromTcb (Id) {
      const Obj = this.tcbDistanceList.find(item => item.value === parseInt(Id))
      if (Obj) {
        return this.$i18n.locale === 'bn' ? Obj.text_bn : Obj.text_en
      } else {
        return ' '
      }
    },
    pdfExport () {
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.reportData, this.reportType, this, this.search, this.officeObj, this.fiscalYearObj, this.monthObj, this.search.report_type)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
