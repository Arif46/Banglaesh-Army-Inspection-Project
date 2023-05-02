<template>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template>
            <b-overlay :show="loader">
              <b-row>
                <b-col lg="12" sm="12">
                    <b-table-simple bordered hover small>
                      <b-tr v-if="Object.values(detailsData).length > 0">
                        <b-th style="width:20%">{{ $t('tradeFairConfig.fiscal_year') }}</b-th>
                        <b-td style="width:30%">{{ getFiscalYearName(detailsData.fiscal_year_id) }}</b-td>
                        <b-th style="width:20%">{{ $t('tradeFairConfig.fair_name') }}</b-th>
                        <b-td style="width:30%">{{ getFairName(detailsData.fair_name_id)}}</b-td>
                      </b-tr>
                    </b-table-simple>
                    <b-table-simple bordered hover small>
                      <thead>
                        <tr class="bg-primary">
                          <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.criteria_name') }}</th>
                        </tr>
                      </thead>
                      <b-tbody v-if="detailsData?.details?.length > 0">
                          <b-tr v-for="(item, index) in detailsData.details.filter(el => el.is_active === 1)" :key="index">
                              <b-td>{{ index + 1 }}</b-td>
                              <b-td>
                                {{ $i18n.locale == 'bn' ? item.criteria_name_bn : item.criteria_name_en }}
                              </b-td>
                          </b-tr>
                      </b-tbody>
                    </b-table-simple>
                </b-col>
              </b-row>
            </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { evaluationChecklistShow } from '../../api/routes'

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
       const tmp = this.getChecklistInfo()
       this.detailsData = tmp
      }
    },
    methods: {
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
      async getChecklistInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, evaluationChecklistShow + '/' + this.id)
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
