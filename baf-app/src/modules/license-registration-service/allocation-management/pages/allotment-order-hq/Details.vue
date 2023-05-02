<template>
  <b-container fluid>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.fiscal_year')}}</th>
                                <td style="width: 30%">{{ this.currentLocale == 'bn' ? items.fiscal_year_bn : items.fiscal_year }}</td>
                                <th style="width: 20%">{{ $t('allocation_management.allotment_count')}}</th>
                                <td style="width: 30%">{{ $n(items.allotment_count_id, { useGrouping: false })}}</td>
                            </tr>
                            <tr>
                                <th style="width: 20%">{{ $t('allocation_management.approval_date') }}</th>
                                <td style="width: 30%">{{  items.approval_date | dateFormat }} </td>
                                <th style="width: 20%">{{$t('allocation_management.approval_dispatch_no')}}</th>
                                <td style="width: 30%">{{ items.approval_dispatch_no }}</td>
                            </tr>
                            <tr>
                                <th style="width: 30%">{{ $t('allocation_management.attachment') }}</th>
                                <td style="width: 30%" class="text-center">
                                    <span v-if="items.allotment_attachment"><a target="_blank" class="btn btn-primary mr-2" :href="licenseRegistrationServiceBaseUrl+'download-attachment?file='+items.allotment_attachment" title="Allotment Attachment"><i class="ri-file-download-line"></i>&nbsp;</a></span>
                                    <span v-else>{{items.allotment_attachment}}</span>
                                </td>
                                <th style="width: 20%">{{$t('allocation_management.seller_type')}}</th>
                                <td style="width: 30%">{{  sellerTypeList(items.seller_type) }}</td>
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
                                      <th scope="col" style="width: 10%;"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('stock_management.item_category') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('allocation_management.selling_amount') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('allocation_management.dealer_per_allocation_qty') }}</div></th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="allotmentOrderData && allotmentOrderData.length > 0">
                                      <tr v-for="(item, index) in allotmentOrderData" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }}</td>
                                          <td class="text-center">{{ categoryName(item.item_category_id) }}</td>
                                          <td class="text-center">{{ $n(item.selling_amount) }}</td>
                                          <td class="text-center">{{ $n(item.allocation_quantity) }}</td>
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
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
    props: ['items'],
    components: {
    },
    created () {
      this.allotmentOrderData = this.items.details
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
            allotmentOrderData: [],
            licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl
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
        sellerTypeList (itemId) {
            const sellerTypeList = this.$store.state.LicenseRegistrationService.commonObj.sellerTypeList.find(item => item.value === itemId)
            if (sellerTypeList !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return sellerTypeList.text_bn
                } else {
                    return sellerTypeList.text_en
                }
            }
        }
    }
}

</script>
