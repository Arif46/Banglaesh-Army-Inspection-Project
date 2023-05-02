<template>
    <b-row>
      <b-col lg="12" sm="12">
          <template>
            <b-overlay :show="loader">
              <b-row>
                <b-col lg="12" sm="12">
                    <b-table-simple bordered hover small class="text-center">
                      <b-tr v-if="Object.values(detailsData).length > 0">
                        <b-th style="width:10%">{{ $t('globalTrans.year') }}</b-th>
                        <b-td style="width:20%">{{ EngBangNum(detailsData.year.toString()) }}</b-td>
                        <b-th style="width:10%">{{ $t('tradeFairConfig.fair_name') }}</b-th>
                        <b-td style="width:30%">{{ getFairName(detailsData.fair_id)}}</b-td>
                        <b-th style="width:10%">{{$t('ditfConfig.circular') + ' ' + $t('ditfConfig.type')}}</b-th>
                        <b-td style="width:35%">{{ circularTypeList(detailsData.circular_type)}}</b-td>
                      </b-tr>
                    </b-table-simple>
                    <b-table-simple bordered hover small>
                      <thead>
                        <tr>
                          <b-th colspan="12" class="text-center p-2" style="background: #B6D0E2 ">{{ $t('tradeFairConfig.stall_category_info') }}</b-th>
                        </tr>
                        <tr class="bg-primary text-center">
                          <th style="width:5%">{{ $t('globalTrans.sl_no') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.stall_type') }}</th>
                          <th style="width:10%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                          <th style="width:5%">{{ $t('ditfConfig.size') }}</th>
                          <th style="width:10%">{{ $t('ditfConfig.app_porcess_fee') }}</th>
                          <th style="width:15%">{{ $t('ditfConfig.fare_floor')}}</th>
                          <th style="width:10%">{{ $t('ditfConfig.stall_qty') }}</th>
                          <th style="width:10%">{{ $t('ditfConfig.security_perc') }}</th>
                        </tr>
                      </thead>
                      <b-tbody v-if="detailsData?.details?.length > 0">
                          <b-tr v-for="(item, index) in detailsData.details" :key="index" class="text-center">
                              <b-td>{{ $n(index + 1) }}</b-td>
                              <b-td>{{ getStallType(item.stall_type) }}</b-td>
                              <b-td>{{ currentLocale == 'bn' ? item.cat_name_bn : item.cat_name_en }}</b-td>
                              <b-td>{{ currentLocale == 'bn' ? item.size_bn : item.size_en }}</b-td>
                              <b-td>{{ $n(item.processing_fee, { minimumFractionDigits: 2 }) }}</b-td>
                              <b-td>{{ $n(item.floor_price, { minimumFractionDigits: 2 }) + ' ( ' + getPriceType(item.price_type) + ' ) ' }}</b-td>
                              <b-td>{{ $n(item.stall_qty) }}</b-td>
                              <b-td>{{ $n(item.security_perc) }}</b-td>
                          </b-tr>
                      </b-tbody>
                    </b-table-simple>
                </b-col>
              </b-row>
            </b-overlay>
          </template>
      </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { stallCategoryShow } from '../../api/routes'

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
       this.getStallCatInfo()
      }
    },
    methods: {
    currentLocale () {
      return this.$i18n.locale
    },
    EngBangNum (n) {
      if (this.$i18n.locale === 'bn') {
        return n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
      } else {
        return n.replace(/[০-৯]/g, d => '০১২৩৪৫৬৭৮৯'.indexOf(d))
      }
    },
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
    circularTypeList (id) {
      const circularType = this.$store.state.TradeFairService.ditfCommonObj.circularTypeList.find(obj => obj.value === parseInt(id))
      if (typeof circularType !== 'undefined') {
        return this.$i18n.locale === 'en' ? circularType.text_en : circularType.text_bn
      } else {
        return ''
      }
    },
    getStallType (id) {
      const dataStallType = this.$store.state.TradeFairService.ditfCommonObj.stallTypeList.find(item => item.value === (id))
      if (typeof dataStallType !== 'undefined') {
        return this.$i18n.locale === 'en' ? dataStallType.text_en : dataStallType.text_bn
      } else {
        return ''
      }
    },
    getPriceType (id) {
      const priceType = this.$store.state.TradeFairService.ditfCommonObj.priceTypeList.find(item => item.value === parseInt(id))
      if (typeof priceType !== 'undefined') {
        return this.$i18n.locale === 'en' ? priceType.text_en : priceType.text_bn
      } else {
        return ''
      }
    },
    getFairName (Id) {
      const fairName = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.find(obj => obj.value === parseInt(Id))
      if (typeof fairName !== 'undefined') {
        return this.$i18n.locale === 'en' ? fairName.text_en : fairName.text_bn
      } else {
        return ''
      }
    },
    async getStallCatInfo () {
        this.loader = true
        const resultData = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallCategoryShow + '/' + this.id)
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
