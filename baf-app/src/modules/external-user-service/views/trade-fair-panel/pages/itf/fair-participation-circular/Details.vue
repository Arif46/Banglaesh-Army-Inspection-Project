<template>
  <b-card>
    <b-row>
      <b-overlay :show="loading">
        <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
          <template v-slot:projectNameSlot>
            {{ }}
          </template>
          {{ $t('externalTradeFair.circular_fair_participation') }}
        </list-report-head>
        <b-col v-if="loading" style="height: 100px">
        </b-col>
        <b-col v-else lg="12" sm="12">
          <b-row>
            <b-col sm="7"> <div class="mt-2"> <b class="small font-weight-bold"> {{$t('externalTradeFair.circular_memo_no')}} : </b>{{ detailsData.circular_memo_no }} </div></b-col>
            <b-col sm="3">
              <div class="text-right mt-2"> <b class="small font-weight-bold">{{ $t('globalTrans.date') }} :</b></div>
            </b-col>
            <b-col sm="2">
              <div class="text-left mt-2"> {{ detailsData.updated_at|dateFormat }} </div>
            </b-col>
          </b-row>
          <b-row class="mt-3 mb-3">
            <b-col sm="1">
              <div class="text-left mt-1">
                <b class="small font-weight-bold">
                  {{ $t('externalTradeFair.subject') + ':' }}
                </b>
              </div>
            </b-col>
            <b-col sm="11">
              <div class="text-left mt-1">
                {{ $t('externalTradeFair.next') + ' ' + date + ' ' + $t('externalTradeFair.in_time') + ' ' + ($i18n.locale === 'en' ? country_en : country_bn) + ', ' +
                ($i18n.locale === 'en' ? detailsData.calendar_info.city : detailsData.calendar_info.city_bn) + ' ' + $t('externalTradeFair.to_be_held') + ' ' +
                ($i18n.locale === 'en' ? detailsData.calendar_info.fair_name : detailsData.calendar_info.fair_name_bn) + ' '
                + $t('externalTradeFair.c_lan_part_1') }}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-3 mb-3">
            <b-col sm="12">
              <div class="text-left mt-1">
                {{ $t('externalTradeFair.next') + ' ' + date + ' ' + $t('externalTradeFair.in_time') + ' ' + ($i18n.locale === 'en' ? country_en : country_bn) + ', ' +
                ($i18n.locale === 'en' ? detailsData.calendar_info.city : detailsData.calendar_info.city_bn) + ' ' + $t('externalTradeFair.to_be_held') + ' ' +
                ($i18n.locale === 'en' ? detailsData.calendar_info.fair_name : detailsData.calendar_info.fair_name_bn) + ' '
                + $t('externalTradeFair.c_lan_part_2') + ' ' + $n(stall_info.length) + $t('externalTradeFair.c_lan_part_23')}}
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col lg="12" sm="12">
              <div>
                <b-table-simple bordered hover small>
                    <b-thead>
                        <tr>
                          <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.stall_cat_name') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.stall_size') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.stall_type') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.booth_rent') }}</b-th>
                          <b-th class="text-center">{{ $t('externalTradeFair.corner_booth_rent') }}</b-th>
                        </tr>
                    </b-thead>
                    <b-tbody v-for="(item, index) in stall_info" :key="index">
                      <tr v-for="(el, indx) in item.details" :key="indx">
                        <b-td v-if="indx == 0" :rowspan="item.details.length" class="text-center align-middle" style="width: 8%">{{ $n(index + 1) }}</b-td>
                        <b-td v-if="indx == 0" :rowspan="item.details.length" class="text-center align-middle" style="width: 15%">{{ getStallCategoryName(item.stall_cat_id) }}</b-td>
                        <b-td class="text-center" style="width: 10%">{{ ($n(el.stall_size)) + ' ' + (getMeasurementUnitList(el.measurement_id)) }}</b-td>
                        <b-td class="text-center" style="width: 15%">{{ getStallType(el.stall_type) }}</b-td>
                        <b-td class="text-center" style="width: 10%">{{ $n(el.booth_rent, { minimumFractionDigits: 2 }) }}</b-td>
                        <b-td class="text-center" style="width: 27%">{{ $i18n.locale === 'en' ? el.description_en : el.description_bn }}</b-td>
                      </tr>
                    </b-tbody>
                </b-table-simple>
                <b-row class="mt-3 mb-3">
                  <b-col sm="12">
                    <div class="text-left mt-1">
                        {{ $t('externalTradeFair.c_lan_part_3') }}
                    </div>
                  </b-col>
                </b-row>
                <b-table-simple bordered hover small>
                    <b-tbody>
                        <tr>
                          <b-th colspan="4" class="p-2">{{ $t('externalTradeFair.sector_name') + ' : ' + getFairSector(detailsData.calendar_info.fair_sector_id)  }}</b-th>
                        </tr>
                        <tr>
                          <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.subsidy_category') }}</b-th>
                          <b-th class="text-center">{{ $t('externalTradeFair.subsidy_range_data') }}</b-th>
                          <b-th class="text-center">{{ $t('externalTradeFair.subsidy_p') }}</b-th>
                        </tr>
                        <tr v-for="(detail, inx) in detailsData?.subsidy_info?.details.filter(el => parseInt(el.fair_sector_id) === detailsData.calendar_info.fair_sector_id)" :key="inx">
                          <b-td class="text-center" style="width: 10%">{{ $n(inx + 1) }}</b-td>
                          <b-td class="text-center" style="width: 20%">{{ getSubsidyCategory(detail.subsidy_cat_id) }}</b-td>
                          <b-td class="text-center" style="width: 15%">{{ $i18n.locale === 'en' ? detail.range_en : detail.range_bn }}</b-td>
                          <b-td class="text-center" style="width: 15%">{{ $n(detail.subsidy) + ' (%)' }}</b-td>
                        </tr>
                    </b-tbody>
                </b-table-simple>
                <b-table-simple bordered hover small>
                    <b-tbody>
                        <tr>
                          <b-th colspan="4" class="p-2">{{ $t('externalTradeFair.sector_name') + ' : ' +  $t('globalTrans.others') }}</b-th>
                        </tr>
                        <tr>
                          <b-th class="text-center">{{ $t('globalTrans.sl_no') }}</b-th>
                          <b-th class="text-center">{{ $t('tradeFairConfig.subsidy_category') }}</b-th>
                          <b-th class="text-center">{{ $t('externalTradeFair.subsidy_range_data') }}</b-th>
                          <b-th class="text-center">{{ $t('externalTradeFair.subsidy_p') }}</b-th>
                        </tr>
                        <tr v-for="(detail, indx) in detailsData.subsidy_info.details.filter(el => parseInt(el.fair_sector_id) !== detailsData.calendar_info.fair_sector_id)" :key="indx">
                          <b-td class="text-center" style="width: 10%">{{ $n(indx + 1) }}</b-td>
                          <b-td class="text-center" style="width: 20%">{{ getSubsidyCategory(detail.subsidy_cat_id) }}</b-td>
                          <b-td class="text-center" style="width: 15%">{{ $i18n.locale === 'en' ? detail.range_en : detail.range_bn }}</b-td>
                          <b-td class="text-center" style="width: 15%">{{ $n(detail.subsidy) + ' (%)' }}</b-td>
                        </tr>
                    </b-tbody>
                </b-table-simple>
                <b-row class="mt-3 mb-3">
                  <b-col sm="12">
                    <div class="text-left mt-1">
                        {{ $t('externalTradeFair.c_lan_part_4') + ' ' + deadline + ' ' + $t('externalTradeFair.c_lan_part_5') }}
                    </div>
                  </b-col>
                </b-row>
                <b-row class="mt-3 mb-3">
                  <b-col sm="12">
                    <div class="text-left mt-1">
                        {{ $t('externalTradeFair.c_lan_part_6') }}
                    </div>
                  </b-col>
                </b-row>
              </div>
            </b-col>
          </b-row>
        </b-col>
      </b-overlay>
    </b-row>
  </b-card>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairParticipationCalenderDetails, stallCategoryList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ExportPdf from './export_pdf_details'

export default {
    name: 'Details',
    props: ['id', 'item'],
    components: {
      ListReportHead
    },
    data () {
      return {
        baseUrl: internationalTradeFairServiceBaseUrl,
        valid: null,
        loading: false,
        date: '',
        deadline: '',
        country_en: '',
        country_bn: '',
        fiscal_year_en: '',
        fiscal_year_bn: '',
        fair_name_en: '',
        fair_name_bn: '',
        errors: [],
        detailsData: '',
        stallCategoryList: [],
        stall_info: []
      }
    },
    created () {
      this.loadData()
      this.getStallCategoryList(this.item.fair_name_id)
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      getSubsidyCategory (id) {
        const dataSubsidyCat = this.$store.state.ExternalUserService.tradeFair.commonObj.subsidyCategoryList.find(item => item.value === parseInt(id))
        if (typeof dataSubsidyCat !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataSubsidyCat.text_en : dataSubsidyCat.text_bn
        } else {
          return ''
        }
      },
      getFairSector (id) {
        const dataFairSector = this.$store.state.ExternalUserService.tradeFair.commonObj.fairSectorList.find(item => item.value === parseInt(id))
        if (typeof dataFairSector !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataFairSector.text_en : dataFairSector.text_bn
        } else {
          return ''
        }
      },
      getStallType (id) {
        const dataStallType = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === parseInt(id))
        if (typeof dataStallType !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataStallType.text_en : dataStallType.text_bn
        } else {
          return ''
        }
      },
      getMeasurementUnitList (id) {
        const dataMeasurementUnit = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === parseInt(id))
        if (typeof dataMeasurementUnit !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataMeasurementUnit.text_en : dataMeasurementUnit.text_bn
        } else {
          return ''
        }
      },
      getStallCategoryName (id) {
        const dataStallCategory = this.stallCategoryList.find(item => item.value === parseInt(id))
        if (typeof dataStallCategory !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataStallCategory.text_en : dataStallCategory.text_bn
        } else {
          return ''
        }
      },
      getStallCategoryList (id) {
        RestApi.getData(internationalTradeFairServiceBaseUrl, stallCategoryList, { fair_name_id: id }).then(response => {
          if (response.success) {
            this.stallCategoryList = response.data.map(el => {
              return Object.assign({}, el, { text: this.$i18n.locale === 'en' ? el.text_en : el.text_bn })
            })
          } else {
            this.stallCategoryList = []
          }
        })
      },
      mappingStallInfo (data) {
        const details = []
        data.forEach(item => {
          const Obj = details.find(el => el.stall_cat_id === item.stall_cat_id)
          if (typeof Obj === 'undefined') {
            details.push({ stall_cat_id: item.stall_cat_id })
          }
        })
        const tA = details.map(el => {
          const newArry = data.filter(item => item.stall_cat_id === el.stall_cat_id)
          return Object.assign({}, el, { details: newArry })
        })
        this.stall_info = tA
      },
      async loadData () {
        this.loading = true
        const params = {
          id: this.id,
          fiscal_year_id: this.item.fiscal_year_id,
          fair_name_id: this.item.fair_name_id
        }
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairParticipationCalenderDetails, params)
        this.loading = false
        if (result.success) {
          this.detailsData = result.data
          this.mappingStallInfo(this.detailsData.stall_info.details)
          const country = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(this.detailsData.calendar_info.country_id))
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(this.detailsData.fiscal_year_id))
          const fairName = this.$store.state.ExternalUserService.tradeFair.commonObj.fairNameList.find(obj => obj.value === parseInt(this.detailsData.fair_name_id))
          this.country_en = country ? country.text_en : ''
          this.country_bn = country ? country.text_en : ''
          this.fiscal_year_en = fiscalYear ? country.text_en : ''
          this.fiscal_year_bn = fiscalYear ? country.text_bn : ''
          this.fair_name_en = fairName ? fairName.text_en : ''
          this.fair_name_bn = fairName ? fairName.text_bn : ''
          const deadline = this.detailsData.deadline.split('-')
          const startDate = this.detailsData.calendar_info.date_from.split('-')
          const endDate = this.detailsData.calendar_info.date_to.split('-')
          let deadlineId = ''
          let startMonthId = ''
          let endMonthId = ''
          deadlineId = this.$store.state.commonObj.monthList.find(doc => doc.value === parseInt(deadline[1]))
          startMonthId = this.$store.state.commonObj.monthList.find(doc => doc.value === parseInt(startDate[1]))
          endMonthId = this.$store.state.commonObj.monthList.find(doc => doc.value === parseInt(endDate[1]))
          this.deadline = this.$n(deadline[2]) + ' ' + (this.currentLocale === 'en' ? deadlineId.text_en : deadlineId.text_bn) + ', ' + this.$n(deadline[0], { useGrouping: false })
          if (startDate[1] === endDate[1]) {
            this.date = this.$n(startDate[2]) + ' - ' + this.$n(endDate[2]) + ' ' + (this.currentLocale === 'en' ? startMonthId.text_en : startMonthId.text_bn) + ', ' + this.$n(startDate[0], { useGrouping: false })
          } else {
            this.date = this.$n(startDate[2]) + ' ' + (this.currentLocale === 'en' ? startMonthId.text_en : startMonthId.text_bn) + ' - ' + this.$n(endDate[2]) + ' ' + (this.currentLocale === 'en' ? endMonthId.text_en : endMonthId.text_bn) + ', ' + this.$n(startDate[0], { useGrouping: false })
          }
        } else {
          this.detailsData = ''
        }
      },
      pdfExport () {
        const reportTitle = this.$t('externalTradeFair.circular_fair_participation')
        ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/itf-configuration/report-head/detail', 2, reportTitle, this)
      }
    }
}
</script>
