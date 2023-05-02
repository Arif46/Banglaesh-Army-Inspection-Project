<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.beneficiary_report')}}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
          <b-row>
            <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3">
              <ValidationProvider name="Area Type" vid="pre_area_type_id" rules="required|min_value:1">
                  <b-form-group
                      label-cols-sm="5"
                      style="margin-left:12px;"
                      label-for="pre_area_type_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('bazarMonitoring.area_type')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.pre_area_type_id"
                      :options="preareaTypeList"
                      id="pre_area_type_id"
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
            <b-col xs="6" sm="6" md="6" lg="6" xl="6" class="mt-3">
              <ValidationProvider name="Division" vid="pre_division_id" rules="required|min_value:1">
                  <b-form-group
                    label-cols-sm="5"
                    label-for="pre_division_id"
                    slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.division')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.pre_division_id"
                      :options="predivisionList"
                      id="pre_division_id"
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
          </b-row>
          <b-row>
            <b-col xs="6" sm="6" md="6" lg="6" xl="6">
              <ValidationProvider name="District" vid="pre_district_id" rules="required|min_value:1">
                  <b-form-group
                      label-cols-sm="5"
                      style="margin-left:12px;"
                      label-for="pre_district_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.district')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.pre_district_id"
                      :options="predistrictList"
                      id="pre_district_id"
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
            <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="search.pre_area_type_id === 1">
              <ValidationProvider name="City Corporation" vid="pre_city_corporation_id" rules="required|min_value:1">
                  <b-form-group
                      label-cols-sm="5"
                      label-for="pre_city_corporation_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.city_corporation')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.pre_city_corporation_id"
                      :options="precityCorporationList"
                      id="pre_city_corporation_id"
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
            <b-col xs="6" sm="6" md="6" lg="6" xl="6" v-if="search.pre_area_type_id === 2 || search.pre_area_type_id === 3">
              <ValidationProvider name="Upazila" vid="pre_upazila_id" rules="required|min_value:1">
                  <b-form-group
                      label-cols-sm="5"
                      style="margin-left:12px;"
                      label-for="pre_upazila_id"
                      slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                      {{$t('globalTrans.upazila')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                      plain
                      v-model="search.pre_upazila_id"
                      :options="preupazilaList"
                      id="pre_upazila_id"
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
      <b-row class="text-right mb-5 mt-5">
        <b-col>
          <b-button variant="primary" @click="pdfExport" class="mr-2">
            {{  $t('globalTrans.print') }}
          </b-button>
          <export-excel
            class="btn btn-primary ml-2 mr-2"
            :title="headerValue"
            default-value="headerExcelDefault"
            :data="excelData"
            worksheet="Report Sheet"
            name="beneficiary_information_report.xls">
            {{ $t('globalTrans.export_excel') }}
          </export-excel>
        </b-col>
      </b-row>
      <!-- table section start -->
    <div>
      <div style="width:100%;overflow-x:auto;padding: 10px;">
        <b-overlay :show="loading">
          <template>
            <ReportHeading />
              <div class="text-black mb-4" style="width: 98%;margin-left: 100px;">
                <b-overlay :show="loading">
                  <b-row style="width: 100; margin-top:20px;">
                    <b-col style="width: 100; margin-top:20px;" xl="4" lg="4" sm="12" v-if="parseInt(search.pre_area_type_id) > 0">
                          {{$t('bazarMonitoring.area_type')}} :  <strong>{{getAreaTypeName(search.pre_area_type_id)}} </strong>
                    </b-col>
                  <b-col style="width: 100; margin-top:20px;" xl="4" lg="4" sm="12" v-if="parseInt(search.pre_division_id) > 0">
                          {{$t('globalTrans.division')}} :  <strong>{{getDivisionName(search.pre_division_id)}} </strong>
                    </b-col>
                    <b-col style="width: 100; margin-top:20px;" xl="4" lg="4" sm="12" v-if="parseInt(search.pre_district_id) > 0">
                      {{$t('globalTrans.district')}} :  <strong>{{AddressHelper.getDistrictName(search.pre_district_id)}} </strong>
                    </b-col>
                    <b-col style="width: 100; margin-top:20px;" xl="4" lg="4" sm="12" v-if="parseInt(search.pre_upazila_id) > 0 && parseInt(search.pre_area_type_id) > 1">
                        {{$t('globalTrans.upazila')}} :   <strong> {{AddressHelper.getUpazilaName(search.pre_upazila_id)}} </strong>
                    </b-col>
                    <b-col style="width: 100; margin-top:20px;" xl="4" lg="4" sm="12" v-if="parseInt(search.pre_city_corporation_id) > 0 && parseInt(search.pre_area_type_id) === 1">
                        {{$t('orgProfile.city_corporation')}} : <strong> {{ AddressHelper.getCityCorporationName(search.pre_city_corporation_id)}} </strong>
                    </b-col>
                  </b-row>
                </b-overlay>
              </div>
              <template v-if="reportData.length">
              <table class="table-sm" style="width: 100; margin-top:20px;">
                <tr>
                  <th colspan="15" style="text-align: center;">{{ $t('tcb_report.beneficiary_report') }}</th>
                </tr>
                <template>
                <tr>
                  <th>{{ $t('globalTrans.sl_no') }}</th>
                  <th>{{ $t('tcbconfiguration.name_of_head_of_family_un') }}</th>
                  <th>{{ $t('tcbconfiguration.father_name_un') }}</th>
                  <th>{{ $t('globalTrans.dob') }}</th>
                  <th>{{ $t('tcbconfiguration.age_un') }}</th>
                  <th>{{ $t('globalTrans.gender')}}</th>
                  <th>{{ $t('globalTrans.present_address')}}</th>
                  <th>{{ $t('globalTrans.permanent_address')}}</th>
                  <th>{{ $t('globalTrans.occupation')}}</th>
                  <th>{{ $t('tcbconfiguration.mobile_un')}}</th>
                  <th>{{ $t('tcbconfiguration.nid_un') }}</th>
                  <th>{{ $t('tcbconfiguration.is_allowance_recipient') }}</th>
                  <th>{{ $t('tcbconfiguration.member_in_family') }}</th>
                  <th>{{ $t('tcbconfiguration.family_net_monthly_income') }}</th>
                  <th>{{ $t('tcbconfiguration.family_net_monthly_expense') }}</th>
                </tr>
                    <tr v-for="(item, index) in reportData" :key="index">
                    <!-- <pre>{{ item }}</pre> -->
                      <td>{{ $n(index+1) }}</td>
                      <td>{{ currentLocale == 'en' ? item.beneficiary_name : item.beneficiary_name_bn }}</td>
                      <td>{{ currentLocale == 'en' ? item.father_name : item.father_name_bn }}</td>
                      <td>{{ currentLocale == 'en' ? item.DateEn : item.DateBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.age : item.ageBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.genderEn : item.genderBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.pre_address_en : item.pre_address_bn }}</td>
                      <td>{{ currentLocale == 'en' ? item.per_address_en : item.per_address_bn }}</td>
                      <td>{{ currentLocale == 'en' ? item.occupationEn : item.occupationBn }}</td>
                      <td>{{ currentLocale == 'en' ? '0' : '০' }}{{ currentLocale == 'en' ? item.mobile : item.mobileBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.nid : item.nidBn }}</td>
                      <td v-if="item.is_allowance_recipient == 1">{{ currentLocale == 'en' ? 'Yes' : 'হ্যাঁ' }}</td>
                      <td v-else>{{ currentLocale == 'en' ? 'No' : 'না' }}</td>
                      <td>{{ currentLocale == 'en' ? item.member_in_family : item.member_in_familyBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.family_net_monthly_income : item.family_net_monthly_incomeBn }}</td>
                      <td>{{ currentLocale == 'en' ? item.family_net_monthly_expense : item.family_net_monthly_expenseBn }}</td>
                    </tr>
                  </template>
              </table>
              </template>
              <template v-if="reportData.length == 0">
              <table class="table-sm" style="width: 100; margin-top:20px;">
                <tr>
                  <th colspan="15" style="text-align: center;">{{ $t('tcb_report.beneficiary_report') }}</th>
                </tr>
                <template>
                <tr>
                  <th>{{ $t('globalTrans.sl_no') }}</th>
                  <th>{{ $t('tcbconfiguration.name_of_head_of_family_un') }}</th>
                  <th>{{ $t('tcbconfiguration.father_name_un') }}</th>
                  <th>{{ $t('globalTrans.dob') }}</th>
                  <th>{{ $t('tcbconfiguration.age_un') }}</th>
                  <th>{{ $t('globalTrans.gender')}}</th>
                  <th>{{ $t('globalTrans.present_address')}}</th>
                  <th>{{ $t('globalTrans.permanent_address')}}</th>
                  <th>{{ $t('globalTrans.occupation')}}</th>
                  <th>{{ $t('tcbconfiguration.mobile_un')}}</th>
                  <th>{{ $t('tcbconfiguration.nid_un') }}</th>
                  <th>{{ $t('tcbconfiguration.is_allowance_recipient') }}</th>
                  <th>{{ $t('tcbconfiguration.member_in_family') }}</th>
                  <th>{{ $t('tcbconfiguration.family_net_monthly_income') }}</th>
                  <th>{{ $t('tcbconfiguration.family_net_monthly_expense') }}</th>
                </tr>
                    <tr>
                      <td colspan="15">{{ $t('globalTrans.noDataFound') }}</td>
                    </tr>
                  </template>
              </table>
              </template>
          </template>
        </b-overlay>
      </div>
    </div>
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { beneficiaryReport, getRegionDvision } from '../../api/routes'
import Pdf from './pdf'
import AddressHelper from '@/utils/area-type-address'
import { helpers } from '@/utils/helper-functions'
import ReportHeading from '../../components/ReportHeading.vue'
import excel from 'vue-excel-export'
import Vue from 'vue'

Vue.use(excel)
export default {
  components: {
    ReportHeading
  },
  data () {
    return {
      loading: false,
      pre_ward_id: 0,
      AddressHelper: AddressHelper,
      search: {
        pre_area_type_id: 0,
        pre_division_id: 0,
        pre_ward_id: 0,
        pre_district_id: 0,
        pre_upazila_id: 0,
        pre_city_corporation_id: 0
      },
      divisionList: [],
      divDistrictList: [],
      districtList: [],
      upazilaList: [],
      cityCorporationList: [],
      ItemShow: false,
      locationShow: false,
      CityCorpItemShow: false,
      PauroshobaItemShow: false,
      divRequrire: '',
      predistrictList: [],
      preupazilaList: [],
      preunionList: [],
      prewardList: [],
      prepauroshobaList: [],
      precityCorporationList: [],
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
    'search.pre_division_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.predistrictList = this.getDistrictList(newVal)
        if (oldVal) {
          this.search.pre_district_id = 0
        }
      } else {
        this.predistrictList = []
      }
    },
    'search.pre_district_id': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.preupazilaList = this.getUpazilaList(newVal)
        this.precityCorporationList = this.getcityCorporationList(newVal)
        if (oldVal) {
          this.search.pre_upazila_id = 0
        }
      } else {
        this.preupazilaList = []
        this.precityCorporationList = []
      }
      },
        'search.pre_upazila_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.preunionList = this.getUnionList(newVal)
            this.prepauroshobaList = this.getPauroshobaList(newVal)
            if (oldVal) {
              this.search.pre_union_id = 0
              this.search.pre_pauroshoba_id = 0
            }
        } else {
          this.preunionList = []
          this.prepauroshobaList = []
        }
    },
    'search.pre_city_corporation_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.prewardList = this.getWardList(newVal)
          if (oldVal) {
            this.search.pre_ward_id = 0
          }
        } else {
          this.prewardList = []
        }
    },
    'search.pre_pauroshoba_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
          this.prewardList = this.getPauroshobaWardList(newVal)
          if (oldVal) {
            this.search.pre_ward_id = 0
          }
        } else {
          this.prewardList = []
        }
    },
    'search.pre_union_id': function (newVal, oldVal) {
        if (newVal !== oldVal) {
            this.prewardList = this.getUnionWardList(newVal)
            if (oldVal) {
              this.search.pre_ward_id = 0
            }
        } else {
          this.prewardList = []
        }
    }
  },
  computed: {
    headerValue: function () {
        const headerVal = []
        if (this.$i18n.locale === 'en') {
          headerVal[0] = this.$t('tcb_report.government_text')
          headerVal[1] = this.$t('tcb_report.trading_corporation_of_bangladesh')
          headerVal[2] = this.$t('tcb_report.tcb_address')
          headerVal[3] = this.$t('tcb_report.beneficiary_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        } else {
          headerVal[0] = this.$t('tcb_report.government_text')
          headerVal[1] = this.$t('tcb_report.trading_corporation_of_bangladesh')
          headerVal[2] = this.$t('tcb_report.tcb_address')
          headerVal[3] = this.$t('tcb_report.beneficiary_report')
          headerVal[4] = ''
          headerVal[5] = ''
          headerVal[6] = ''
        }
        let areaTypeText = this.$t('bazarMonitoring.area_type') + ' : '
        if (this.pre_area_type_id > 0) {
            areaTypeText += this.getAreaTypeName(this.search.pre_area_type_id) + '; '
        } else {
          areaTypeText += this.$t('globalTrans.all') + '; '
        }
        let textDivision = this.$t('globalTrans.division') + ' : '
        if (this.search.pre_division_id > 0) {
            textDivision += this.getDivisionName(this.search.pre_division_id) + '; '
        } else {
          textDivision += this.$t('globalTrans.all') + '; '
        }
        let textDistrict = this.$t('globalTrans.district') + ' : '
        if (parseInt(this.search.pre_district_id) > 0) {
            textDistrict += this.AddressHelper.getDistrictName(this.search.pre_district_id) + '; '
        } else {
          textDistrict += this.$t('globalTrans.all') + '; '
        }
        let textUpazilla = this.$t('globalTrans.upazila') + ' : '
        if (parseInt(this.search.pre_upazilla_id) > 0) {
          textUpazilla += AddressHelper.getUpazilaName(this.search.pre_upazilla_id) + '; '
        } else {
          textUpazilla += this.$t('globalTrans.all') + '; '
        }
        let textCityCorporation = this.$t('globalTrans.city_corporation') + ' : '
        if (parseInt(this.search.pre_city_corporation_id) > 0) {
          textCityCorporation += AddressHelper.getCityCorporationName(this.search.pre_city_corporation_id)
        } else {
          textCityCorporation += this.$t('globalTrans.all') + '; '
        }

        headerVal[5] = areaTypeText + textDivision + textDistrict + textUpazilla + textCityCorporation
        return headerVal
      },
    excelData: function () {
        const listData = this.reportData
        var serial = 0
        const listContractor = listData.map(item => {
        serial++
            if (this.$i18n.locale === 'en') {
            return {
                'sl ': serial,
                'Name Of Head Of Family': item.beneficiary_name,
                'Father Name ': item.father_name,
                'Date Of Birth ': item.DateEn,
                'Age (year) ': item.age,
                'Gender ': item.genderEn,
                'Present Address ': item.pre_address_en !== null ? item.pre_address_en : ' ',
                'Permanent Address ': item.per_address_en !== null ? item.per_address_en : ' ',
                'Occupation ': item.occupationEn !== null ? item.occupationEn : '',
                'Mobile number ': item.mobile,
                'NID ': item.nid,
                'Have You Received Any Allowances Under The Social Security Net? ': (item.is_allowance_recipient === 1 ? (this.currentLocale === 'en' ? 'Yes' : 'হ্যাঁ') : (this.currentLocale === 'en' ? 'No' : 'না')),
                'Number Of Family Members ': item.member_in_family,
                'Family Net Monthly Income ': item.family_net_monthly_income,
                'Family Net Monthly Expense ': item.family_net_monthly_expense
            }
            } else {
            return {
                'ক্রমিক নং ': helpers.convertEnglishToBanglaNumber(serial),
                'পরিবারের প্রধানের নাম ': item.beneficiary_name_bn,
                'পিতার নাম ': item.father_name_bn,
                'জন্ম তারিখ ': item.DateBn,
                'বয়স (বছর) ': item.ageBn,
                'লিঙ্গ ': item.genderBn,
                'বর্তমান ঠিকানা ': item.pre_address_bn === null || item.pre_address_bn === '' ? '' : item.pre_address_bn,
                'স্থায়ী ঠিকানা ': item.per_address_bn === null || item.per_address_bn === '' ? '' : item.per_address_bn,
                'পেশা ': item.occupationBn !== null || item.occupationBn !== undefined ? item.occupationBn : '',
                'মোবাইল নম্বর ': item.mobileBn,
                'জাতীয় পরিচয় পত্র নাম্বার ': item.nidBn,
                'সামাজিক নিরাপত্তা বেষ্টনির আওতায় কোন ভাতা গ্রহণ করেছে কিনা? ': this.currentLocale === 'en' ? 'No' : 'না',
                'পরিবারের সদস্য সংখ্যা ': item.member_in_familyBn,
                'পরিবারের মাসিক মোট আয় ': item.family_net_monthly_incomeBn,
                'পরিবারের মাসিক মোট খরচ ': item.family_net_monthly_expenseBn
            }
            }
        })
        return listContractor
    },
    preareaTypeList: function () {
        const list = this.$store.state.commonObj.typeList
        return list.map((obj, key) => {
            if (this.$i18n.locale === 'bn') {
                return { value: obj.id, text: obj.name_bn }
            } else {
                return { value: obj.id, text: obj.name }
            }
        })
    },
    predivisionList: function () {
      return this.$store.state.CommonService.commonObj.divisionList.filter(item => item.status === 1)
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
          this.PauroshobaItemShow = false
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
    this.loading = true
    RestApi.getData(licenseRegistrationServiceBaseUrl, beneficiaryReport, this.search).then(response => {
    if (response.success) {
      this.reportData = response.data
      var occupationn = [
        {
            value: 1,
            text_en: 'Housewife',
            text_bn: 'গৃহিণী',
            text: 'Housewife'
        },
        {
            value: 2,
            text_en: 'employee',
            text_bn: 'চাকুরিজীবী',
            text: 'employee'
        },
        {
            value: 3,
            text_en: 'day laborer',
            text_bn: 'দিন মজুর',
            text: 'day laborer'
        },
        {
            value: 4,
            text_en: 'Farmer',
            text_bn: 'কৃষক',
            text: 'Farmer'
        }
      ]
      this.reportData.map(element => {
        element.DateBn = this.$options.filters.dateFormatBn(element.dob)
        element.DateEn = this.$options.filters.dateFormatEn(element.dob)
        element.ageBn = helpers.convertEnglishToBanglaNumber(element.age)
        element.genderEn = this.$store.state.commonObj.genderList.find(ele => ele.value === element.gender)?.text_en
        element.genderBn = this.$store.state.commonObj.genderList.find(ele => ele.value === element.gender)?.text_bn
        element.mobileBn = helpers.convertEnglishToBanglaNumber(element.mobile)
        element.nidBn = helpers.convertEnglishToBanglaNumber(element.nid)
        element.member_in_familyBn = helpers.convertEnglishToBanglaNumber(element.member_in_family)
        element.family_net_monthly_incomeBn = helpers.convertEnglishToBanglaNumber(element.family_net_monthly_income)
        element.family_net_monthly_expenseBn = helpers.convertEnglishToBanglaNumber(element.family_net_monthly_expense)
        element.occupationEn = occupationn.find(elef => elef.value === element.occupation)?.text_en
        element.occupationBn = occupationn.find(elef => elef.value === element.occupation)?.text_bn
      })
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
    getAreaTypeName (Id) {
      const Obj = this.$store.state.commonObj.areaTypeList.find(item => item.value === parseInt(Id))
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
        return ''
      }
    },
  pdfExport () {
    const reportTitle = this.$t('li_step.expiration_passed_report')
    Pdf.exportPdfDetails(this, this.reportData, reportTitle)
  },
  getDistrictList (id) {
    return this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1 && item.division_id === id)
  },
  getUpazilaList (id) {
    return this.$store.state.CommonService.commonObj.upazilaList.filter(item => item.status === 1 && item.district_id === id)
  },
  getUnionList (upazilaId) {
    return this.$store.state.CommonService.commonObj.unionList.filter(item => item.status === 1 && item.upazila_id === upazilaId)
  },
  getWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.city_corporation_id === id)
  },
  getPauroshobaWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.municipality_id === id)
  },
  getUnionWardList (id) {
    return this.$store.state.CommonService.commonObj.wardList.filter(item => item.status === 1 && item.union_id === id)
  },
  getPauroshobaList (id) {
     return this.$store.state.CommonService.commonObj.municipalityList.filter(item => item.status === 1 && item.upazila_id === id)
  },
  getcityCorporationList (id) {
    return this.$store.state.CommonService.commonObj.cityCorporationList.filter(item => item.status === 1 && item.district_id === id)
  }
  }
}
</script>
<style>
@import '../../style.css'
</style>
