<template>
  <b-card>
    <b-row>
      <b-overlay :show="loading">
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
            <b-col sm="2">
              <div class="text-center mt-1">
                <b class="small font-weight-bold">
                  {{ $t('externalTradeFair.subject') + ' :' }}
                </b>
              </div>
            </b-col>
            <b-col sm="10">
              <div class="text-left mt-1">
                {{ $t('externalTradeFair.next') + ' ' + date + ' ' + $t('externalTradeFair.in_time') + ' ' + ($i18n.locale === 'en' ? country_en : country_bn) + ', ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.city : detailsData.parti_circular.calendar_info.city_bn) + ' ' + $t('externalTradeFair.to_be_held') + ' ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.fair_name : detailsData.parti_circular.calendar_info.fair_name_bn) + ' '
                + $t('externalTradeFair.c_lan_part_1') }}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-3 mb-3">
            <b-col sm="12">
              <div class="text-left mt-1">
                {{ $t('externalTradeFair.next') + ' ' + date + ' ' + $t('externalTradeFair.in_time') + ' ' + ($i18n.locale === 'en' ? country_en : country_bn) + ', ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.city : detailsData.parti_circular.calendar_info.city_bn) + ' ' + $t('externalTradeFair.to_be_held') + ' ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.fair_name : detailsData.parti_circular.calendar_info.fair_name_bn) + ' '
                + $t('externalTradeFair.c_lan_part_2') + ' ' + $n(detailsData.parti_circular.stall_info.length) + $t('externalTradeFair.c_lan_part_23')}}
              </div>
            </b-col>
          </b-row>
          <b-row>
            <b-col lg="12" sm="12">
              <div>
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
import { fairExhibitCircularDetails } from '../../api/routes'
// import ExportPdf from './export_pdf_details'

export default {
    name: 'Details',
    props: ['id', 'item'],
    data () {
      return {
        valid: null,
        loading: false,
        errors: [],
        detailsData: []
      }
    },
    created () {
      this.loadData()
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      async loadData () {
        this.loading = true
        const params = {
          id: this.id,
          fiscal_year_id: this.item.fiscal_year_id,
          fair_name_id: this.item.fair_name_id
        }
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairExhibitCircularDetails, params)
        this.loading = false
        if (result.success) {
          this.detailsData = result.data
          const country = this.$store.state.CommonService.commonObj.countryList.find(obj => obj.value === parseInt(this.detailsData.parti_circular.calendar_info.country_id))
          const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(this.detailsData.fiscal_year_id))
          const fairName = this.$store.state.TradeFairService.commonObj.fairNameList.find(obj => obj.value === parseInt(this.detailsData.parti_circular.fair_name_id))
          this.country_en = country?.text_en
          this.country_bn = country?.text_bn
          this.fiscal_year_en = fiscalYear?.text_en
          this.fiscal_year_bn = fiscalYear?.text_bn
          this.fair_name_en = fairName?.text_en
          this.fair_name_bn = fairName?.text_bn
          const deadline = this.detailsData.deadline.split('-')
          const startDate = this.detailsData.parti_circular.calendar_info.date_from.split('-')
          const endDate = this.detailsData.parti_circular.calendar_info.date_to.split('-')
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
        // const reportTitle = this.$t('priceMonitoring.fine_receipt') + ' ' + this.$t('globalTrans.details')
        // ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/configuration/report-head/detail', 11, reportTitle, this)
      }
    }
}
</script>
