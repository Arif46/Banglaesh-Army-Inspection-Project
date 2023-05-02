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
                        <tr>
                          <b-th colspan="8" class="text-center p-2" style="background: #e3e3e3">{{ $t('tradeFairConfig.stall_category_info') }}</b-th>
                        </tr>
                        <tr class="bg-primary text-align-center">
                          <th style="width:7%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                          <!-- <th style="width:10%">{{ $t('tradeFairConfig.measurement_unit_name') }}</th> -->
                          <th style="width:10%">{{ $t('tradeFairConfig.stall_size') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.stall_type') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.booth_rent') + ' ' + $t('globalTrans.tk') }}</th>
                          <th style="width:10%">{{ $t('globalTrans.description') }}</th>
                        </tr>
                      </thead>
                      <b-tbody v-if="detailsData?.details?.length > 0">
                          <b-tr v-for="(item, index) in detailsData.details" :key="index">
                              <b-td>{{ $n(index + 1) }}</b-td>
                              <b-td>{{ getStallCategory(item.stall_cat_id) }}</b-td>
                              <!-- <b-td>{{ getMeasurementUnit(item.measurement_id) }}</b-td> -->
                              <b-td>{{ $n(item.stall_size) + ' ' + getMeasurementUnit(item.measurement_id) }}</b-td>
                              <b-td>{{ getStallType(item.stall_type) }}</b-td>
                              <b-td>{{ $n(item.booth_rent, { minimumFractionDigits: 2 }) }}</b-td>
                              <b-td>{{ $i18n.locale == 'bn' ? item.description_bn : item.description_en }}</b-td>
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
import { stallInformationShow, getStallCatByFairApi } from '../../api/routes'

export default {
    name: 'Details',
    props: ['id'],
    data () {
      return {
        loader: false,
        detailsData: {},
        stallCategoryList: []
      }
    },
    created () {
      if (this.id) {
       this.getStallInfo()
      }
    },
    methods: {
    getStallCategory (id) {
      const dataStallCategory = this.stallCategoryList.find(item => item.value === id)
      if (this.$i18n.locale === 'bn') {
        return dataStallCategory !== undefined ? dataStallCategory.text_bn : ''
      } else {
        return dataStallCategory !== undefined ? dataStallCategory.text_en : ''
      }
    },
    getMeasurementUnit (id) {
      const dataMeasurementUnit = this.$store.state.TradeFairService.commonObj.measurementUnitList.find(item => item.value === id)
      if (this.$i18n.locale === 'bn') {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_bn : ''
      } else {
        return dataMeasurementUnit !== undefined ? dataMeasurementUnit.text_en : ''
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
    getStallCategoryList (id) {
      this.loader = true
      RestApi.getData(internationalTradeFairServiceBaseUrl, getStallCatByFairApi, { fair_name_id: id }).then(response => {
        this.loader = false
        if (response.success) {
          this.stallCategoryList = response.data.map(el => {
            return Object.assign({}, el, { text: this.$i18n.locale === 'en' ? el.text_en : el.text_bn })
          })
        } else {
          this.stallCategoryList = []
        }
      })
    },
    async getStallInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallInformationShow + '/' + this.id)
        if (resultData.success) {
          this.detailsData = resultData.data
          this.loader = false
          this.getStallCategoryList(this.detailsData.fair_name_id)
        } else {
          this.detailsData = {}
        }
      }
    }
}
</script>
