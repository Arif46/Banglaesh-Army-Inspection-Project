<template>
  <b-container fluid>
    <b-row class="pb-3">
        <b-col >
         <table class="table table-borderless table-sm">
           <tr>
             <th class="p-0 text-right w-50">{{ $t('allocation_dc_office.dc_office_name')}}</th>
             <th class=" p-0 w-50">: {{ getDistrictName(allotmentOrderData.district_id) }}</th>
         </tr>
           <tr v-if="allotmentOrderData.warehouse_id" >
             <th v-if="allotmentOrderData.warehouse_id" class="text-right p-0">{{ $t('allocation_management.warehouse')}}</th>
             <th v-if="allotmentOrderData.warehouse_id" class=" p-0">: {{ getwarehouseName(allotmentOrderData.warehouse_id) }}</th>
           </tr>
           <!--<tr>
               <td style="width: 40%">{{ $t('allocation_dc_office.beneficiary_no')}}</td>
               <td style="width: 5%">:</td>
               <td style="width: 30%">{{ $n(allotmentOrderData.total_beneficiary, { useGrouping: false }) }}</td>
           </tr>-->
         </table>
        </b-col>
    </b-row>
    <b-row>
      <b-col sm="12">
        <b-overlay :show="loading">
            <table class="table table-bordered text-center">
                <tr class="tboder bg-primary font-weight-bold">
                    <td class="tboder" style="width:10%;">{{$t('globalTrans.sl_no')}}</td>
                    <td class="tboder" style="width:20%;">{{ $t('allocation_management.item_name') }}</td>
                    <td class="tboder" style="width:35%;">{{ $t('allocation_management.allocated_quantity') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td class="tboder" style="width:35%;">{{ $t('allocation_dc_office.delivery_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                </tr>
                <template v-if="allotmentOrderData.items.length > 0">
                  <tr class="tboder" v-for="(detail,index) in allotmentOrderData.items.filter(item => item.delivered_qty > 0)" :key="detail.id">
                      <td class="tboder">{{ $n(index+1) }}</td>
                      <td class="tboder">{{ getItemCategoryName(detail.item_category_id) }}</td>
                      <td class="tboder">{{ $n(detail.allocated_qty, { useGrouping: false }) }}</td>
                      <td class="tboder">{{ $n(detail.delivered_qty, { useGrouping: false }) }}</td>
                  </tr>
                </template>
            </table>
        </b-overlay>
      <b-row class="text-right">
          <b-col>
            <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('details')">{{ $t('globalTrans.cancel') }}</b-button>
          </b-col>
      </b-row>
  </b-col>
    </b-row>
  </b-container>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
    props: ['item'],
    components: {
    },
    created () {
        this.allotmentOrderData = this.item
    },
    data () {
        return {
            allotmentOrderData: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
            loading: false
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        getItemName (itemCategoryId) {
          const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
            if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                return cateObj.text_bn
              } else {
                return cateObj.text_en
              }
            }
        },
        getItemCategoryName (itemCategoryId, lang = this.$i18n.locale) {
        const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
        if (cateObj !== undefined) {
          if (lang === 'bn') {
            return cateObj.text_bn
          } else {
            return cateObj.text_en
          }
        }
      },
      getwarehouseName (warehouseId) {
          const wareObj = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.filter(item => item.status === 1).find(item => item.value === warehouseId)
          if (wareObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
                  return wareObj.text_bn
              } else {
                  return wareObj.text_en
              }
          }
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
      }
    }
}

</script>
