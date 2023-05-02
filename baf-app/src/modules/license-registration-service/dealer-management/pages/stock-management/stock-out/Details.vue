<template>
  <b-container fluid>
       <b-row style="line-height: 20px">
            <template>
                <b-row>
                    <b-col md="9">
                        <table style="line-height: 20px" class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('stock_management.stock_out_id')}}</th>
                                <td style="width: 30%">{{ items.stock_out_id }}</td>
                                <th style="width: 20%">{{ $t('stock_management.request_date')}}</th>
                                <td style="width: 30%">{{ items.request_date | dateFormat }}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{$t('stock_management.regional_office')}}</th>
                                <td style="width: 30%">{{currentLocale === 'en'? items.regional_office : items.regional_office_bn}}</td>
                                <th style="width: 20%">{{$t('stock_management.warehouse')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? items.warehouse_name_en : items.warehouse_name_bn}} </td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ currentLocale === 'en'? $t('stock_management.reason_en') : $t('stock_management.reason_bn')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? items.reason : items.reason_bn}}</td>
                                <th style="width: 20%">{{ currentLocale === 'en'? $t('stock_management.purpose_en') : $t('stock_management.purpose_bn')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? items.purpose : items.purpose_bn}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ currentLocale === 'en'? $t('stock_management.remarks_en') : $t('stock_management.remarks_bn')}}</th>
                                <td style="width: 30%">{{ currentLocale === 'en'? items.remarks : items.remarks_bn}}</td>
                                <th style="width: 20%">&nbsp;</th>
                                <td style="width: 30%">&nbsp;</td>
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
                                      <th scope="col" style="width: 10%;" class="text-center"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('stock_management.contract_no') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('stock_management.quantity') }}</div></th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="arrStockItemData && arrStockItemData.length > 0">
                                      <tr v-for="(item, index) in arrStockItemData" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }}</td>
                                          <td class="text-center">{{ item.contractnum.contract_no }} ({{ currentLocale === 'en'? item.contractnum.supplier_name : item.contractnum.supplier_name_bn }})</td>
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
            // trainingElearningServiceBaseUrl: trainingElearningServiceBaseUrl,
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
        }
    }
}

</script>
