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
                      <b-td style="width:20%">{{ $n(detailsData.stall_category.year, {useGrouping: false}) }}</b-td>
                      <b-th style="width:10%">{{ $t('tradeFairConfig.fair_name') }}</b-th>
                      <b-td style="width:30%">{{ getFairName(detailsData.stall_category.fair_id)}}</b-td>
                      <b-th style="width:10%">{{$t('ditfConfig.circular') + ' ' + $t('ditfConfig.type')}}</b-th>
                      <b-td style="width:35%">{{ circularTypeList(detailsData.stall_category.circular_type)}}</b-td>
                    </b-tr>
                  </b-table-simple>
                  <b-table-simple bordered hover small>
                    <thead>
                      <tr>
                        <b-th colspan="12" class="text-center p-2" style="background: #B6D0E2 ">{{ $t('ditfConfig.stall_info') }}</b-th>
                      </tr>
                      <tr class="bg-primary text-center">
                        <th style="width:5%">{{ $t('globalTrans.sl_no') }}</th>
                        <th style="width:10%">{{ $t('ditfConfig.stall_no') }}</th>
                        <th style="width:10%">{{ $t('ditfConfig.stall_location') }}</th>
                      </tr>
                    </thead>
                    <b-tbody v-if="detailsData?.stall_numbers?.length > 0">
                        <b-tr v-for="(item, index) in detailsData.stall_numbers" :key="index" class="text-center">
                            <b-td>{{ $n(index + 1) }}</b-td>
                            <b-td>{{ $n(item.stall_no) }}</b-td>
                            <b-td>{{ ($i18n.locale === 'bn') ? item.stall_location_bn : item.stall_location_en }}</b-td>
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
export default {
  name: 'Details',
  props: ['id'],
  data () {
    return {
      loader: false,
      detailsData: []
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditStallInfo()
      this.detailsData = tmp
    }
  },
  methods: {
    // currentLocale () {
    //   return this.$i18n.locale
    // },
    getStallCategory (id) {
      const dataStallCategory = this.stallCategoryList.find(item => item.value === id)
      if (this.$i18n.locale === 'bn') {
        return dataStallCategory !== undefined ? dataStallCategory.text_bn : ''
      } else {
        return dataStallCategory !== undefined ? dataStallCategory.text_en : ''
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
    getFairName (Id) {
      const fairName = this.$store.state.TradeFairService.ditfCommonObj.dhakaFairList.find(obj => obj.value === parseInt(Id))
      if (typeof fairName !== 'undefined') {
        return this.$i18n.locale === 'en' ? fairName.text_en : fairName.text_bn
      } else {
        return ''
      }
    },
    getEditStallInfo () {
      const tmpData = this.$store.state.list.find(item => item.id === this.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
