<template>
  <b-container fluid>
    <b-row>
        <b-col xs="12" sm="12" md="8" lg="8" xl="8" offset="3">
            <tr>
              <td style="width: 20%">{{ $t('allocation_dc_office.dc_office_name')}}</td>
              <td style="width: 3%">:</td>
              <td style="width: 40%">{{ getDistrictName(receiveProduct.district_id) }}</td>
            </tr>
            <tr>
              <td style="width: 20%">{{ $t('allocation_dc_office.regional_office')}}</td>
              <td style="width: 3%" class="text-left">:</td>
              <td style="width: 40%">{{ getRegionalOfficeName(receiveProduct.regional_office_id) }}</td>
            </tr>
            <tr>
              <td style="width: 20%">{{ $t('allocation_management.warehouse')}}</td>
              <td style="width: 3%" class="text-left">:</td>
              <td style="width: 40%">{{ getwarehouseName(receiveProduct.warehouse_id) }}</td>
            </tr>
            <!-- <tr>
                <td style="width: 40%">{{ $t('allocation_dc_office.beneficiary_no')}}</td>
                <td style="width: 5%">:</td>
                <td style="width: 30%">{{ $n(allotmentOrderData.total_beneficiary, { useGrouping: false }) }}</td>
            </tr> -->
        </b-col>
    </b-row>
    <b-row>
      <b-col sm="12" class="mt-3">
        <b-overlay :show="loading">
            <table class="table table-bordered">
                <tr class="tboder bg-primary font-weight-bold">
                    <td style="width:10%;" class="tboder">{{ $t('globalTrans.sl_no') }}</td>
                     <td class="tboder" style="width:20%;">&nbsp;{{ $t('stock_management.item_category') }}</td>
                     <td style="width:20%;" class="tboder">{{ $t('allocation_management.allocated_quantity') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td class="tboder" style="width:20%;">&nbsp;{{ $t('allocation_management.item_name') }}</td>
                    <td style="width:20%;" class="tboder">{{ $t('allocation_dc_office.delivery_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td style="width:20%;" class="tboder" v-if="receiveProduct.details[0].recieved_qty">{{ $t('allocation_dc_office.received_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                    <td style="width:20%;" class="tboder" v-if="hasShortage">{{ $t('allocation_dc_office.shortage_qty') }} ({{$t('allocation_dc_office.unit')}})</td>
                </tr>
                <template v-if="receiveProduct.details.length > 0">
                  <tr class="tboder" v-for="(detail,index) in receiveProduct.details" :key="index">
                      <td style="vertical-align : middle;text-align:center">{{ $n(index+1) }}</td>
                      <td style="vertical-align : middle;text-align:center">{{ getItemCategoryName(detail.item_category_id) }}</td>
                      <td style="vertical-align : middle;text-align:center">{{ $n(detail.asking_delivery_qty, { useGrouping: false }) }}</td>
                      <td style="vertical-align : middle;text-align:center">{{ getItemName(detail.item_id) }}</td>
                      <td style="vertical-align : middle;text-align:center">{{ $n(detail.distribution_qty, { useGrouping: false }) }}</td>
                      <td style="vertical-align : middle;text-align:center" v-if="detail.recieved_qty">{{ $n(detail.recieved_qty, { useGrouping: false }) }}</td>
                      <td style="vertical-align : middle;text-align:center" v-if="hasShortage">{{ $n(detail.shortage_qty ? detail.shortage_qty : 0, { useGrouping: false }) }}</td>
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
        this.receiveProduct = this.item
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
        },
      hasShortage () {
          let st = false
          this.receiveProduct.details.map(function (item, index) {
            if (item.shortage_qty > 0) {
              st = true
            }
          })
        return st
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
      getRegionalOfficeName (regionalOfficeId) {
        const officeObj = this.$store.state.CommonService.commonObj.officeList.find(item => item.value === regionalOfficeId)
          if (officeObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
              return officeObj.text_bn
            } else {
              return officeObj.text_en
            }
          }
      },
      getwarehouseName (warehouseId) {
        const wareObj = this.$store.state.LicenseRegistrationService.commonObj.warehouseList.find(item => item.value === warehouseId)
        if (wareObj !== undefined) {
            if (this.$i18n.locale === 'bn') {
                return wareObj.text_bn
            } else {
                return wareObj.text_en
            }
        }
      },
      spanCalculate (selected, data) {
       const maindata = data.sort((a, b) => a.item_category_id > b.item_category_id ? 1 : -1).filter(item => item.item_category_id === selected)
       maindata.map(function (item, index) {
         if (selected === item.item_category_id && index === 0) {

         }
       })
      }
    }
}

</script>
