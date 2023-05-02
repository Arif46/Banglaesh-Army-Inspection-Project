<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                        <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('stock_management.brand')}}</th>
                                <td style="width: 30%">{{ brandName(items.contract_no_id) }}</td>
                                <th style="width: 20%">{{ $t('stock_management.contract_no')}}</th>
                                <td style="width: 30%">{{ contractNumber(items.contract_no_id) }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('stock_management.stock_in_id')}}</th>
                                <td style="width: 30%">{{ items.stock_id }}</td>
                                <th style="width: 20%">{{ $t('stock_management.stock_in_date')}}</th>
                                <td style="width: 30%">{{ items.stock_in_date | dateFormat }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('stock_management.regional_office')}}</th>
                                <td style="width: 30%">{{currentLocale === 'en'? items.regional_office : items.regional_office_bn}}</td>
                                <th style="width: 20%">{{$t('stock_management.warehouse')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? items.warehouse_name_en : items.warehouse_name_bn}} </td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
                 <b-row>
                  <b-col md="12">
                <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                    <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                                <tr class="bg-primary">
                                    <th scope="col" style="width: 10%;" class="text-center">{{ $t('globalTrans.sl_no') }}</th>
                                    <th scope="col" class="text-center">{{ $t('stock_management.item_category') }}</th>
                                    <th scope="col" class="text-center">{{ $t('stock_management.item') }}</th>
                                    <th scope="col" class="text-center">{{ $t('stock_management.quantity') }}</th>
                                </tr>
                            </thead>
                        <tbody>
                            <template v-if="arrStockItemData && arrStockItemData.length > 0">
                                <tr v-for="(item, index) in arrStockItemData" :key="index">
                                    <td  class="text-center">{{ $n(index+1) }}</td>
                                    <td class="text-center">{{ categoryName(item.item_category_id) }}</td>
                                    <td class="text-center">{{ itemName(item.item_id) }}</td>
                                    <td class="text-center">{{ $n(item.quantity) }}</td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td colspan="13" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                                </tr>
                            </template>
                        </tbody>
                        </table>
                    </div>
                <!-- &&&&&&&&&&&&&&Manual Info Details End&&&&&&&&&&&&&&& -->
                  </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
export default {
    props: ['items'],
    components: {
    },
    created () {
      this.arrStockItemData = this.items.indetails
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
            arrStockItemData: []
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    methods: {
        categoryName (catId) {
            const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        itemName (itemId) {
            const itemObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.find(item => item.value === itemId)
            if (itemObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return itemObj.text_bn
                } else {
                    return itemObj.text_en
                }
            }
        },
        contractNumber (id) {
            const contractObj = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === id)
            if (contractObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return contractObj.contract_no
                } else {
                    return contractObj.contract_no
                }
            }
        },
        brandName (id) {
            const brandObj = this.$store.state.LicenseRegistrationService.commonObj.contractNumberList.find(item => item.value === id)
            if (brandObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return brandObj.text_bn
                } else {
                    return brandObj.text_en
                }
            }
        }
    }
}

</script>
