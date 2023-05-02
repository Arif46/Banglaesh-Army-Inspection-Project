<template>
  <b-card>
    <b-row>
      <b-overlay :show="loading">
        <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
          <template v-slot:projectNameSlot>
            {{ }}
          </template>
          {{ $t('externalTradeFair.circular_exhibition') }}
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
            <b-col sm="2">
              <div class="text-left mt-1">
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
                + $t('portal.exhi_txt_6') }}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-3 mb-3">
            <b-col sm="12">
              <div class="text-left mt-1">
                {{ $t('portal.exhi_txt_1') + ' ' + date + ' ' + $t('portal.exhi_txt_2') + ' ' + ($i18n.locale === 'en' ? country_en : country_bn) + ', ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.city : detailsData.parti_circular.calendar_info.city_bn) + ' ' + $t('portal.exhi_txt_3') + ' ' +
                ($i18n.locale === 'en' ? detailsData.parti_circular.calendar_info.fair_name : detailsData.parti_circular.calendar_info.fair_name_bn) + ' '
                + $t('portal.exhi_txt_4') + ' ' + deadline + ' ' + $t('portal.exhi_txt_5')}}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-2 mb-2">
            <b-col sm="1">
              <div class="text-right mt-1">
                <b class="small">
                  {{ $t('portal.a') }}
                </b>
              </div>
            </b-col>
            <b-col sm="11">
              <div class="text-left mt-1">
                {{ $t('portal.a_text') }}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-2 mb-2">
            <b-col sm="1">
              <div class="text-right mt-1">
                <b class="small">
                  {{ $t('portal.b') }}
                </b>
              </div>
            </b-col>
            <b-col sm="11">
              <div class="text-left mt-1">
                {{ $t('portal.b_text') }}
              </div>
            </b-col>
          </b-row>
          <b-row class="mt-2 mb-2">
            <b-col sm="1">
              <div class="text-right mt-1">
                <b class="small">
                  {{ $t('portal.c') }}
                </b>
              </div>
            </b-col>
            <b-col sm="11">
              <div class="text-left mt-1">
                {{ $t('portal.c_text') }}
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
                      <b-th class="text-center">{{ $t('externalTradeFair.description_exhibition') }}</b-th>
                      <b-th class="text-center">{{ $t('externalTradeFair.hs_code_no') }}</b-th>
                      <b-th class="text-center">{{ $t('globalTrans.quantity') }}</b-th>
                      <b-th class="text-center">{{ $t('externalTradeFair.unit_price_us') }}</b-th>
                      <b-th class="text-center">{{ $t('externalTradeFair.total_value_us') }}</b-th>
                      <b-th class="text-center">{{ $t('externalTradeFair.exporter_name') }}</b-th>
                    </tr>
                  </b-thead>
                </b-table-simple>
                <b-row class="mt-2 mb-2">
                  <b-col sm="1">
                    <div class="text-right mt-1">
                      <b class="small">
                        {{ $t('portal.d') }}
                      </b>
                    </div>
                  </b-col>
                  <b-col sm="11">
                    <div class="text-left mt-1">
                      {{ $t('portal.d_text') }}
                    </div>
                  </b-col>
                </b-row>
                <b-row class="mt-2 mb-2">
                  <b-col sm="1">
                    <div class="text-right mt-1">
                      <b class="small">
                        {{ $t('portal.e') }}
                      </b>
                    </div>
                  </b-col>
                  <b-col sm="11">
                    <div class="text-left mt-1">
                      {{ $t('portal.e_text') }}
                    </div>
                  </b-col>
                </b-row>
                <b-row class="mt-3 mb-3">
                  <b-col sm="12">
                    <div class="text-left mt-1">
                        {{ $t('portal.exhi_text_2') }}
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
        errors: [],
        detailsData: ''
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
      async loadData () {
        this.loading = true
        const params = {
          id: this.id
        }
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, '/portal/itf-circular-exhibition-details', params)
        this.loading = false
        if (result.success) {
          this.detailsData = result.data
          const country = this.$store.state.Portal.commonObj.countryList.find(obj => obj.value === parseInt(result.data.parti_circular.calendar_info.country_id))
          this.country_en = country ? country.text_en : ''
          this.country_bn = country ? country.text_en : ''
          const deadline = result.data.deadline.split('-')
          const startDate = result.data.parti_circular.calendar_info.date_from.split('-')
          const endDate = result.data.parti_circular.calendar_info.date_to.split('-')
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
        const reportTitle = this.$t('externalTradeFair.circular_exhibition')
        ExportPdf.exportPdfDetails(internationalTradeFairServiceBaseUrl, '/itf-configuration/report-head/detail', 2, reportTitle, this)
      }
    }
}
</script>
