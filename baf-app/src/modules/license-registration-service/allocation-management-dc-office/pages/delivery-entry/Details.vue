<template>
  <b-container fluid>
    <b-row class="pb-2">
        <b-col>
         <table class="table table-borderless table-sm">
           <tr>
             <th style="width: 20%">{{ $t('allocation_management.regional_office')}}</th>
             <td style="width: 30%">: {{ getOfficeName(allotmentOrderData.regional_office_id) }}</td>
             <th style="width: 20%">{{ $t('allocation_dc_office.dc_office_name')}}</th>
             <td style="width: 30%">: {{ getDistrictName(allotmentOrderData.district_id) }}</td>
           </tr>
           <tr>
             <th>{{ $t('allocation_dc_office.beneficiary_no')}}</th>
             <td>: {{ $n(allotmentOrderData.total_beneficiary, { useGrouping: false }) }}</td>
             <th v-if="allotmentOrderData.warehouse_id">{{ $t('allocation_management.warehouse')}}</th>
             <td v-if="allotmentOrderData.warehouse_id">: {{ getwarehouseName(allotmentOrderData.warehouse_id) }}</td>
           </tr>
         </table>
        </b-col>
    </b-row>
    <b-row>
      <b-col sm="12">
        <b-overlay :show="loading">
            <table class="table table-sm table-bordered">
                <tr class="tboder bg-primary text-center">
                    <th style="width:10%;" class="tboder">{{$t('globalTrans.sl_no')}}</th>
                    <th class="tboder" style="width:20%;">&nbsp;{{ $t('allocation_management.item_name') }}</th>
                    <th style="width:20%;" class="tboder">{{ $t('allocation_management.allocated_quantity') }} ({{$t('allocation_dc_office.unit')}})</th>
                    <th style="width:20%;" class="tboder">{{ $t('allocation_dc_office.delivery_qty') }} ({{$t('allocation_dc_office.unit')}})</th>
                </tr>
                <tr class="tboder text-center" v-for="(detail,index) in allotmentOrderData.items" :key="detail.id">
                   <template v-if="detail.delivered_qty > 0">
                     <td class="tboder">{{ $n(index+1) }}</td>
                     <td class="tboder">{{ getItemCategoryName(detail.item_category_id) }}</td>
                     <td class="tboder">{{ $n(detail.delivered_qty, { useGrouping: false }) }}</td>
                     <td class="tboder">{{ $n(detail.total_distribution_qty, { useGrouping: false }) }}</td>
                   </template>
                </tr>
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
        getItemCategoryName (itemCategoryId) {
          const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
            if (cateObj !== undefined) {
              if (this.$i18n.locale === 'bn') {
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
        },
        getOfficeName (id) {
            const data = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === id)
            if (typeof data !== 'undefined') {
                return this.$i18n.locale === 'bn' ? data.text_bn : data.text_en
            } else {
                return ''
            }
        }
    }
}

</script>
