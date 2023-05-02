<template>
  <div style="width:100%;overflow-x:auto;">
    <p class="text-center mt-2">{{ $t('tcb_report.transfer_report')}}</p>
    <table style="width:100%;">
      <tr>
        <th rowspan="2" style="text-align: left">{{ $t('tcb_report.sl_no') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.regional_office') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.district_name') }}</th>
        <th rowspan="2" style="text-align: center">{{ $t('tcb_report.number_of_beneficiary') }}</th>
        <template v-if="items.length > 0">
          <th v-for="(item, index) in items" :key="index" style="text-align: center" colspan="4">{{ getItemCategoryName(item.item_category_id) }}</th>
        </template>
        <th rowspan="2" style="text-align: center">{{ $t('globalTrans.comments') }}</th>
      </tr>
      <tr>
      <template v-for="(item, index) in items">
        <th :key="index">{{ $t('tcb_report.due_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.supplier_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.tcb_amount') }}</th>
        <th :key="index">{{ $t('tcb_report.remainder_amount') }}</th>
      </template>
      </tr>
      <tr>
        <th style="text-align: left">{{ $n('1') }}</th>
        <th style="text-align: center">{{ $n('2') }}</th>
        <th style="text-align: center">{{ $n('3') }}</th>
        <th style="text-align: center">{{ $n('4') }}</th>
        <th style="text-align: center">{{ $n('5') }}</th>
        <th style="text-align: center">{{ $n('6') }}</th>
        <th style="text-align: center">{{ $n('7') }}</th>
        <th style="text-align: center">{{ $n('8') }}</th>
        <th style="text-align: center">{{ $n('9') }}</th>
        <th style="text-align: center">{{ $n('10') }}</th>
        <th style="text-align: center">{{ $n('11') }}</th>
        <th style="text-align: center">{{ $n('12') }}</th>
        <th style="text-align: center">{{  }}</th>
      </tr>
        <template v-if="districts.length > 0">
          <tr v-for="(district, index) in districts" :key="index">
            <td style="text-align: left">{{ $n(index+1) }}</td>
            <td style="text-align: center" v-if="index == 0" :rowspan="districts.length">{{ getOfficeName(district.regional_office_id) }}</td>
            <td style="text-align: center">{{ getDistrictName(district.district_id) }}</td>
            <td style="text-align: center">{{ $n(district.total_beneficiary) }}</td>
            <template v-if="district.report_items.length > 0">
              <template v-for="(item, itemIn) in district.report_items">
                <td :key="itemIn">{{ $n(preDistricts[index].report_items[itemIn].preAmount) }}</td>
                <td :key="itemIn">{{ $n(0) }}</td>
                <td :key="itemIn">{{ $n(item.disQty) }}</td>
                <td :key="itemIn">{{ $n((preDistricts[index].report_items[itemIn].preAmount) - (item.disQty) ) }}</td>
              </template>
            </template>
            <template v-else>
                <template v-for="(item, index) in items">
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
                <td :key="index">{{ $n(0) }}</td>
              </template>
            </template>
            <td style="text-align: center"></td>
          </tr>
        </template>
    </table>
  </div>
</template>
<script>
export default {
  props: ['search', 'data'],
  data () {
    return {
      valid: '',
      items: [],
      districts: [],
      preDistricts: []
    }
  },
  created () {
    if (this.data) {
      this.districts = this.data.regeionWiseDistrict
      this.preDistricts = this.data.preRegeionWiseDistrict
      this.items = this.data.regeionWiseDistrict[0].items

      this.districts.forEach(district => {
          if (district.report_items.length > 0) {
            const summed = district.report_items.reduce((acc, cur, i) => {
            const item = i > 0 && acc.find(({ catId }) => catId === cur.catId)
            if (item) item.disQty += cur.disQty
            else acc.push({ catId: cur.catId, disQty: cur.disQty }) // don't push cur here
            return acc
            }, [])
            district.report_items = summed
          }
      })

      this.preDistricts.forEach(district => {
          if (district.report_items.length > 0) {
            const summed = district.report_items.reduce((acc, cur, i) => {
            const item = i > 0 && acc.find(({ catId }) => catId === cur.catId)
            if (item) item.preAmount += cur.preAmount
            else acc.push({ catId: cur.catId, preAmount: cur.preAmount }) // don't push cur here
            return acc
            }, [])
            district.report_items = summed
          }
      })
    } else {
      this.items = []
      this.districts = []
      this.preDistricts = []
    }
  },
  methods: {
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
    getOfficeName (id) {
            const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
            if (typeof data !== 'undefined') {
                return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
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
    }
  }
}
</script>

<style>
@import '../../style.css';

</style>
