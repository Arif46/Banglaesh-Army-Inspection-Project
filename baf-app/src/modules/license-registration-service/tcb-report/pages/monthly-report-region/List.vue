<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{$t('tcb_report.monthly_report_region')}}</h4>
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
                  :options="regionOfficeList"
                  id="org_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                  @change="getWarehouse($event)"
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
            <ValidationProvider name="Fiscal Year id" vid="fiscal_year_id" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="fiscal_year_id"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('globalTrans.fiscal_year')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.fiscal_year_id"
                  :options="fiscalYearList"
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
            <ValidationProvider name="Month" vid="month" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="month"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.month')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="search.month"
                  :options="banglaMonthList"
                  id="month"
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
            <ValidationProvider name="Report Section" vid="report_section" rules="required|min_value:1">
              <b-form-group
                class="row"
                label-for="report_section"
                slot-scope="{ valid, errors }"
                >
                  <template v-slot:label>
                      {{$t('tcb_report.report_section')}} <span class="text-danger">*</span>
                  </template>
                <b-form-select
                  plain
                  v-model="section"
                  :options="sectionList"
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
              {{ customYear }}
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
          </b-col>
        </b-row>
      <!-- table section start -->
      <b-overlay :show="loadData">
      <report-heading/>
      <p class="mb-4 text-center mt-4">{{ $t('tcb_report.office_text') }} : {{ getOfficeName() }}</p>
        <component :search="search" v-if="data.itemList.length > 0" :data="data" :is="mycom" :key="comkey"></component>
      </b-overlay>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import { monthlyStockReportRegionA, monthlyStockReportRegionB } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
import SectionA from './SectionA.vue'
import SectionB from './SectionB.vue'
import ReportHeading from '../../components/ReportHeading.vue'
import Pdf from './pdf'

export default {
  mixins: [ModalBaseMasterList],
  components: {
    SectionA,
    SectionB,
    ReportHeading
  },
  data () {
    return {
      search: {
        fiscal_year_id: 0,
        month: 0,
        regional_office: 0,
        warehouseList: []
      },
      customYear: '',
      section: 0,
      mycom: 'SectionA',
      comkey: 0,
      loadData: false,
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
    banglaMonthList () {
      return this.$store.state.commonObj.monthList.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
    },
    sectionList () {
      let sectionlist = [{
          value: '1',
          text_en: 'ka',
          text_bn: 'ক'
      },
      {
          value: '2',
          text_en: 'kha',
          text_bn: 'খ'
      }]
       sectionlist = sectionlist.map(item => {
        if (this.$i18n.locale === 'bn') {
          return { value: item.value, text: item.text_bn }
        } else {
          return { value: item.value, text: item.text_en }
        }
      })
      return sectionlist
    }
  },
  methods: {
    getOfficeName () {
      const office = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === parseInt(this.search.regional_office))
      if (typeof office !== 'undefined') {
        return office.text
      } else {
        return ''
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
    async searchData () {
      if (this.section === '1') {
        this.mycom = 'SectionA'
      } else if (this.section === '2') {
        this.mycom = 'SectionB'
      }
      let result = null
      const params = Object.assign({}, { fiscal_year_id: this.search.fiscal_year_id, month: this.search.month, warehouseList: this.search.warehouseList })
      this.loadData = true
      result = await RestApi.getData(licenseRegistrationServiceBaseUrl, this.section === '1' ? monthlyStockReportRegionA : monthlyStockReportRegionB, params)
      this.loadData = false
      if (result.success) {
          this.comkey = this.comkey + 1
          this.data = result.data
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
      Pdf.exportPdfDetails(this, this.data, this.section)
    }
  }
}
</script>
<style>
@import '../../style.css'
</style>
