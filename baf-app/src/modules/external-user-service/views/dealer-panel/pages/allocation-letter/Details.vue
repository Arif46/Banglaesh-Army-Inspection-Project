<template>
    <b-container fluid>
        <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                        <div class="table-wrapper table-responsive">
                        <table class="table table-striped table-hover table-bordered">
                            <thead>
                                <tr class="bg-primary">
                                    <th scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('stock_management.item') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('stock_management.quantity') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('allocation_management.unit_price') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('tcb_report.total_price') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('license_config.operating_expense') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('allocation_management.selling_amount') }}</div></th>
                                    <th scope="col" class="text-center"><div>{{ $t('globalTrans.tax') }}</div></th>
                                </tr>
                            </thead>
                            <tbody>
                                <template v-if="items.details.length > 0">
                                    <tr v-for="(item, index) in items.details" :key="index">
                                        <td class="text-center">{{ index+1 }}</td>
                                        <td class="text-center">{{ getItemCategoryName(item.item_category_id) }}</td>
                                        <td class="text-center">{{ getItemName(item.item_id) }}</td>
                                        <td class="text-center">{{ $n(item.quantity) }}</td>
                                        <td class="text-center">{{ $n(item.unit_price) }}</td>
                                        <td class="text-center">{{ $n(item.total_price) }}</td>
                                        <td class="text-center">{{ $n(item.expense) }}</td>
                                        <td class="text-center">{{ $n(item.selling_amount) }}</td>
                                        <td class="text-center">{{ $n(item.tax_amount) }}</td>
                                    </tr>
                                    <tr class="text-bold">
                                        <td class="text-center" style="font-weight: bold;" colspan="5">{{ $t('globalTrans.total') }}</td>
                                        <td class="text-center" style="font-weight: bold;">{{ $n(items.total_price) }}</td>
                                        <td class="text-center" style="font-weight: bold;">{{ $n(items.operating_expense) }}</td>
                                        <td class="text-center" style="font-weight: bold;">{{ $n(items.selling_amount)  }}</td>
                                        <td class="text-center" style="font-weight: bold;">{{ $n(items.tax_amount)  }}</td>
                                    </tr>
                                    <tr>
                                        <td class="text-center" style="font-weight: bold;" colspan="5"></td>
                                        <td class="text-center" style="font-weight: bold;" colspan="2">{{ $t('allocation_management.payable_amount') }}</td>
                                        <td class="text-center" style="font-weight: bold;" colspan="3"> {{ $n(items.selling_amount + items.tax_amount) }}</td>
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
                    </b-col>
                </b-row>
            </template>
        </b-row>
    </b-container>
  </template>
  <script>
  import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
  export default {
      props: ['items'],
      data () {
          return {
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
          }
      },
      computed: {
          currentLocale () {
              return this.$i18n.locale
          }
      },
      methods: {
        getItemCategoryName (catId) {
            const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemCategoryList.find(item => item.value === catId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
        getItemName (itemId) {
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
