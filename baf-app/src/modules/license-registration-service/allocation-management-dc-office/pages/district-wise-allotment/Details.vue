<template>
  <b-container fluid>
        <b-row class="text-right">
            <b-col class="mb-2">
                <b-button variant="primary" @click="pdfExport" class="mr-2">
                        {{  $t('globalTrans.print') }}
                </b-button>
            </b-col>
        </b-row>
       <b-row>
            <template>
                <b-row>
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th style="width: 20%">{{ $t('globalTrans.fiscal_year')}}</th>
                                <td style="width: 30%">: {{ getFiscalYear(items.fiscal_year_id) }}</td>
                                <th style="width: 20%">{{ $t('allocation_management.allotment_count')}}</th>
                                <td style="width: 30%">: {{ $n(items.allotment_count_id, {useGrouping:false}) }}</td>
                            </tr>
                            <tr>
                                <th>{{ $t('allocation_dc_office.allotment_date') }}</th>
                                <td>: {{  items.allotment_date | dateFormat }} </td>
                                <th>{{ $t('allocation_dc_office.dispatch_no') }}</th>
                                <td>: {{ items.dispatch_no }}</td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
                 <b-row>
                  <b-col md="12">
                    <!-- &&&&&&&&&&&&&&Manual Info Details Start&&&&&&&&&&&&& -->
                        <div class="table-wrapper table-responsive tableFixHead">
                          <table class="table table-striped table-hover table-bordered">
                              <thead>
                                  <tr class="bg-primary">
                                      <th scope="col" style="width: 10%;"><div>{{ $t('globalTrans.sl_no') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('globalTrans.district_name') }}</div></th>
                                      <th scope="col" class="text-center"><div>{{ $t('allocation_management.no_of_beneficary') }}</div></th>
                                       <template v-if="items.districts[0].details && items.districts[0].details.length > 0">
                                          <th  v-for="(item, index) in items.districts[0].details" :key="index">
                                            <div>{{ getItemCategoryName(item.item_category_id) }} ({{$t('allocation_dc_office.unit')}})</div>
                                          </th>
                                        </template>
                                  </tr>
                              </thead>
                              <tbody>
                                  <template v-if="items.districts && items.districts.length > 0">
                                      <tr v-for="(item, index) in items.districts.filter(i => i.total_beneficiary > 0)" :key="index">
                                          <td  class="text-center">{{ $n(index+1) }}</td>
                                          <td class="text-center">{{ getDistrictName(item.district_id) }}</td>
                                          <td class="text-center">{{ $n(item.total_beneficiary) }}</td>
                                           <template v-if="item.details && item.details.length > 0">
                                              <td v-for="(detail, itemIndex) in item.details" :key="itemIndex" class="text-center" >
                                              {{ $n(detail.allocated_quantity)}}
                                              </td>
                                            </template>
                                      </tr>
                                      <tr>
                                          <td class="text-right" colspan="2"> {{$t('globalTrans.total')}}:</td>
                                          <td class="text-center">{{ $n(getTotalBeneficiary()) }}</td>
                                          <template v-if="items.districts[0].details && items.districts[0].details.length > 0">
                                          <td class="text-center" v-for="(item, index) in items.districts[0].details" :key="index">
                                            {{ $n(getTotalBeneficiaryItem(item.item_category_id)) }}
                                          </td>
                                        </template>
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
                <b-row v-if="items.remarks || items.remarks_bn">
                    <b-col md="12">
                          <table class="table table-sm table-borderless">
                            <tr>
                                <th >{{ $t('globalTrans.remark') }}</th>
                                <td colspan="3" class="text-center">
                                   {{ currentLocale == 'en' ? items.remarks : items.remarks_bn }}
                                </td>
                            </tr>
                        </table>
                    </b-col>
                </b-row>
            </template>
    </b-row>
  </b-container>
</template>
<script>
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
// import ReportHeading from '../../components/ReportHeading.vue'
import Pdf from './pdf'
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
        getTotalBeneficiary () {
            return this.items.districts.reduce((total, item) => total + parseFloat(item.total_beneficiary), 0)
        },
        getTotalBeneficiaryItem (itemId) {
            let total = 0
            this.items.districts.map((dsitrict, index) => {
                dsitrict.details.map((element, index2) => {
                    if (element.item_category_id === itemId) {
                        total += element.allocated_quantity
                    }
                })
            })
            return total
        },
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

     getFiscalYear (yearId) {
            const cateObj = this.$store.state.CommonService.commonObj.fiscalYearList.filter(item => item.status === 1).find(item => item.value === yearId)
            if (cateObj !== undefined) {
                if (this.$i18n.locale === 'bn') {
                    return cateObj.text_bn
                } else {
                    return cateObj.text_en
                }
            }
        },
       getDistrictName (id) {
            if (id) {
                const obj = this.$store.state.CommonService.commonObj.districtList.find(item => item.value === id)
                if (this.$i18n.locale === 'bn') {
                    return obj.text_bn
                } else {
                    return obj.text_en
                }
            }
        },
        pdfExport () {
            Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.items, this)
        }
    }
}

</script>
<style scoped>
.tableFixHead          { overflow: auto; height: 500px; }
.tableFixHead thead th { position: sticky; top: 0; z-index: 1;background-color: #77a0cb;}
</style>
