<template>
    <!-- <body-card> -->
        <b-overlay :show="loader">
          <b-row>
            <b-col lg="12" sm="12">
                <b-table-simple v-if="Object.values(detailsData).length > 0" bordered hover small>
                    <b-tr>
                      <b-th style="width:10%">{{ $t('tradeFairConfig.fiscal_year') }}</b-th>
                      <b-td colspan="3" style="width:30%">{{ getFiscalYearName(detailsData.fiscal_year_id) }}</b-td>
                    </b-tr>
                    <b-tr>
                      <b-th style="width:10%">{{ $t('tradeFairConfig.fair_name') }}</b-th>
                      <b-td colspan="3" style="width:30%">{{ getFairName(detailsData.fair_name_id)}}</b-td>
                    </b-tr>
                </b-table-simple>
                <b-table-simple bordered hover small>
                    <thead>
                      <tr>
                        <b-th colspan="8" class="text-center p-2" style="background: #e3e3e3">{{ $t('tradeFairConfig.subsidy_information') }}</b-th>
                      </tr>
                      <tr class="bg-primary text-align-center">
                        <th class="text-center" style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                        <th style="width:10%">{{ $t('tradeFairConfig.fair_sector') }}</th>
                        <th class="text-center" style="width:10%">{{ $t('tradeFairConfig.subsidy_category') }}</th>
                        <th class="text-center" style="width:10%">{{ $t('tradeFairConfig.measurement_unit') }}</th>
                        <th style="width:10%">{{ $t('tradeFairConfig.range') }}</th>
                        <th class="text-center" style="width:10%">{{ $t('tradeFairConfig.export_range_from') }}</th>
                        <th class="text-center" style="width:10%">{{ $t('tradeFairConfig.export_range_to') }}</th>
                        <th class="text-center" style="width:10%">{{ $t('tradeFairConfig.subsidy') }} {{'(%)'}} </th>
                      </tr>
                    </thead>
                    <b-tbody v-if="detailsData?.details?.length > 0">
                        <b-tr v-for="(item, index) in detailsData.details" :key="index">
                            <b-td class="text-center">{{ $n(index + 1, { useGrouping: false }) }}</b-td>
                            <b-td>{{ getFairSectorName(item.fair_sector_id) }}</b-td>
                            <b-td class="text-center">{{ getSubsidyCatName(item.subsidy_cat_id) }}</b-td>
                            <b-td class="text-center">{{ getMeasurementUnitName(item.measurement_id) }}</b-td>
                            <b-td>{{ $i18n.locale == 'bn' ? item.range_bn : item.range_en }}</b-td>
                            <b-td class="text-center">{{ $n(item.export_range_from, { minimumFractionDigits: 2 }) }}</b-td>
                            <b-td class="text-center">{{ item.range_status == 1 ? ($i18n.locale === 'en' ? 'Above of ' +  $n(item.export_range_from, { minimumFractionDigits: 2 }) : $n(item.export_range_from, { minimumFractionDigits: 2 }) + ' এর উপরে') : $n(item.export_range_to, { minimumFractionDigits: 2 }) }}</b-td>
                            <b-td class="text-center">{{ $n(item.subsidy) }}</b-td>
                        </b-tr>
                    </b-tbody>
                </b-table-simple>
            </b-col>
          </b-row>
        </b-overlay>
    <!-- </body-card> -->
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { subsidyInformationShow } from '../../api/routes'

export default {
    name: 'Details',
    props: ['id'],
    data () {
      return {
        loader: false,
        detailsData: {}
      }
    },
    created () {
      if (this.id) {
       const tmp = this.getSubsidyInfo()
       this.detailsData = tmp
      }
    },
    methods: {
      getSubsidyCatName (id) {
        const dataSubsidyCategory = this.$store.state.TradeFairService.commonObj.subsidyCategoryList.find(item => item.value === id)
        if (this.$i18n.locale === 'bn') {
          return dataSubsidyCategory !== undefined ? dataSubsidyCategory.text_bn : ''
        } else {
          return dataSubsidyCategory !== undefined ? dataSubsidyCategory.text_en : ''
        }
      },
      getMeasurementUnitName (id) {
        const dataMeasurement = this.$store.state.TradeFairService.commonObj.measurementUnitList.find(item => item.value === id)
        if (this.$i18n.locale === 'bn') {
          return dataMeasurement !== undefined ? dataMeasurement.text_bn : ''
        } else {
          return dataMeasurement !== undefined ? dataMeasurement.text_en : ''
        }
      },
      getFairSectorName (Id) {
        const obj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(Id))
        if (typeof obj !== 'undefined') {
          return this.$i18n.locale === 'en' ? obj.text_en : obj.text_bn
        } else {
          return ''
        }
      },
      getFiscalYearName (Id) {
        const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === parseInt(Id))
        if (typeof fiscalYear !== 'undefined') {
          return this.$i18n.locale === 'en' ? fiscalYear.text_en : fiscalYear.text_bn
        } else {
          return ''
        }
      },
      getFairName (Id) {
        const fairName = this.$store.state.TradeFairService.commonObj.fairNameList.find(obj => obj.value === parseInt(Id))
        if (typeof fairName !== 'undefined') {
          return this.$i18n.locale === 'en' ? fairName.text_en : fairName.text_bn
        } else {
          return ''
        }
      },
      async getSubsidyInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, subsidyInformationShow + '/' + this.id)
        if (resultData.success) {
          this.detailsData = resultData.data
          this.loader = false
        } else {
          this.detailsData = {}
        }
      }
    }
}
</script>
