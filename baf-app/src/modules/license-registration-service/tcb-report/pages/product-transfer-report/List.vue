<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('tcb_report.product_transfer_report_dc_office') }}</h4>
      </template>
      <template v-slot:searchBody>
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
          <b-row class="mt-4">
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Regional Office" vid="regional_office_id" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="regional_office_id"
                  slot-scope="{ valid, errors }"
                  >
                  <template v-slot:label>
                    {{$t('organogram.regional_office_name')}} <span class="text-danger">*</span>
                  </template>
                  <b-form-select
                    plain
                    v-model="search.regional_office_id"
                    :options="regionOfficeList"
                    id="regional_office_id"
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
            <b-col xs="12" sm="12" md="4" lg="4" xl="4">
              <ValidationProvider name="Report Type" vid="report_type" rules="required|min_value:1">
                <b-form-group
                  class="row"
                  label-for="report_type"
                  slot-scope="{ valid, errors }"
                  >
                    <template v-slot:label>
                        {{$t('tcb_report.report_type')}} <span class="text-danger">*</span>
                    </template>
                  <b-form-select
                    plain
                    v-model="search.report_type"
                    :options="reportTypeList"
                    id="report_type"
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
             <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <b-form-group
              label-for="allotment_count"
              >
                <template v-slot:label>
                  {{ $t('allocation_management.allotment_count') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="allotment_count"
                  :options="allotmentCount"
                  v-model="search.allotment_count_id"
                >
                  <template v-slot:first>
                    <b-form-select-option :value='0'>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
              </b-form-group>
          </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.report_type === 1">
              <ValidationProvider name="date" vid="date" rules="" v-slot="{ errors }">
                <b-form-group label-for="date">
                  <template v-slot:label>
                    {{ $t('globalTrans.date') }}
                  </template>
                  <date-picker
                    id="date"
                    class="form-control"
                    v-model="search.date"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select_date')"
                    :locale="currentLocale"
                  >
                  </date-picker>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.report_type === 2">
              <ValidationProvider name="From Date" vid="from_date" rules="" v-slot="{ errors }">
                <b-form-group label-for="from_date">
                  <template v-slot:label>
                    {{ $t('globalTrans.from_date') }}
                  </template>
                  <date-picker
                    id="from_date"
                    class="form-control"
                    v-model="search.from_date"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select_date')"
                    :locale="currentLocale"
                  >
                  </date-picker>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col xs="12" sm="12" md="4" lg="4" xl="4" v-if="search.report_type === 2">
              <ValidationProvider name="To Date" vid="to_date" rules="" v-slot="{ errors }">
                <b-form-group label-for="to_date">
                  <template v-slot:label>
                    {{ $t('globalTrans.to_date') }}
                  </template>
                  <date-picker
                    id="to_date"
                    class="form-control"
                    v-model="search.to_date"
                    :state="errors[0] ? false : (valid ? true : null)"
                    :placeholder="$t('globalTrans.select_date')"
                    :locale="currentLocale"
                  >
                  </date-picker>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
            </b-col>
            <b-col class="mt-3">
              <b-button type="submit" variant="success" class="mr-2 btn-sm">{{$t('globalTrans.search')}}</b-button>
          </b-col>
          </b-row>
        </b-form>
        </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>
    <body-card style="overflow-x: clip;">
      <b-row class="text-right mb-5">
        <b-col>
          <b-button variant="primary" @click="pdfExport">
            {{  $t('globalTrans.print') }}
          </b-button>
        </b-col>
      </b-row>
      <!-- Main Body start -->
      <b-overlay :show="loadData">
        <report-heading/>
           <slot v-if="dailyCom">
            <Daily :search="search" :data="dailyData"></Daily>
           </slot>
           <slot v-if="totalCom">
              <Total :search="search" :data="TotalData"></Total>
           </slot>
        </b-overlay>
      <!-- Main Body end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { productTransferReportDaily, productTransferReportTotal } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import Daily from './Daily.vue'
import Total from './Total.vue'
import ReportHeading from '../../components/ReportHeading.vue'
import dailyPdf from './dailyPdf'
import totalPdf from './totalPdf'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    Daily,
    Total,
    ReportHeading
  },
  data () {
    return {
      search: {
        regional_office_id: 3,
        allotment_count_id: 0,
        report_type: 0,
        date: '',
        from_date: '',
        to_date: '',
        warehouseList: []
      },
      customYear: '',
      section: 0,
      mycom: '',
      comkey: 0,
      componentData: {},
      loadData: false,
      valid: '',
      dailyData: {},
      TotalData: {},
      dailyCom: false,
      totalCom: false,
      data: {
        itemList: [],
        all_product_sold_amount: 0,
        all_product_avg_amount: 0,
        final_amount: 0
      }
    }
  },
  created () {
  },
  watch: {
  },
  computed: {
    regionOfficeList () {
      const officeList = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1)
      return officeList
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
    allotmentCount () {
      return this.$store.state.commonObj.gradeList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text }
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
    reportTypeList () {
      let list = [
        {
          value: 1,
          text_en: 'Daily',
          text_bn: 'দৈনিক'
        },
        {
          value: 2,
          text_en: 'Total',
          text_bn: 'সর্বমোট'
        }
      ]
      list = list.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return list
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getOfficeName () {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(this.search.regional_office_id))
      if (typeof office !== 'undefined') {
        return office.text
      } else {
        return ''
      }
    },
     getItemCategoryName (itemId) {
      const item = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === itemId)
      return item.text
    },
    getDistrictName (id) {
        const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
        if (obj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return obj.text_bn
            } else {
                return obj.text_en
            }
        }
    },
    getMonthName () {
      const month = this.$store.state.commonObj.monthList.find(item => item.value === parseInt(this.search.month))
      if (typeof month !== 'undefined') {
        if (this.$i18n.locale === 'bn') {
          return month.text_bn
        } else {
          return month.text_en
        }
      } else {
        return ''
      }
    },
    setCurrentFiscalYear (fiscalYearList, date) {
        if (fiscalYearList.length === 0) {
            return
        }
        const currentDate = new Date(date)
        const [month, year] = [currentDate.getMonth(), currentDate.getFullYear()]
        const yearPosition = month < 7 ? 5 : 0
        const yearStr = `${year}`
        let currentFiscalYearId = 0
        fiscalYearList.forEach(element => {
            if (element.text_en.indexOf(yearStr) === yearPosition) {
                currentFiscalYearId = element.value
            }
        })
        return currentFiscalYearId
    },
    async searchData () {
      if (this.search.report_type === 1) {
        this.loadData = true
        this.dailyCom = false
        const fiscalYear = this.setCurrentFiscalYear(this.$store.state.CommonService.commonObj.fiscalYearList, this.search.date)
        this.search.fiscal_year_id = fiscalYear
          const params = Object.assign({}, this.search)
          const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, productTransferReportDaily, params)
            if (result.success) {
                this.dailyData = result.data
                this.dailyCom = true
            }
            this.loadData = false
      } else {
        this.loadData = true
        this.totalCom = false
        const fiscalYear = this.setCurrentFiscalYear(this.$store.state.CommonService.commonObj.fiscalYearList, this.search.from_date)
        this.search.fiscal_year_id = fiscalYear
          const params = Object.assign({}, this.search)
          const result = await RestApi.getData(licenseRegistrationServiceBaseUrl, productTransferReportTotal, params)
            if (result.success) {
                this.TotalData = result.data
                this.totalCom = true
            }
         this.loadData = false
      }
    },
    getWarehouse (officeId) {
      const warehouseList = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1 && item.office_id === officeId)
      this.search.warehouseList = []
      warehouseList.forEach(item => {
        this.search.warehouseList.push(item.value)
      })
    },
    EngBangNum (n) {
        if (this.$i18n.locale === 'bn') {
          return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        } else {
          return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
        }
    },
    pdfExport () {
      if (this.dailyCom) {
         dailyPdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this, this.search, this.dailyData)
      } else {
        totalPdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this, this.search, this.TotalData)
      }
  }
  }
}
</script>
<style>
@import '../../style.css'
</style>
