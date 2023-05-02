<template>
  <div class="inner-section">
    <b-row>
      <b-col>
        <b-row class="text-right">
          <b-col class="mb-2">
            <b-button variant="primary" @click="pdfExport" class="mr-2">
              {{  $t('globalTrans.print') }}
            </b-button>
          </b-col>
        </b-row>
        <b-row>
          <b-col>
            <table class="table table-borderless table-sm">
              <tr>
                <th class="w-25">{{$t('globalTrans.fiscal_year')}}</th>
                <td class="w-25">: {{getFiscalYear(formData.fiscal_year_id)}}</td>
                <th class="w-25">{{$t('allocation_management.allotment_count')}}</th>
                <td class="w-25">: {{$n(formData.allotment_count_id)}}</td>
              </tr>
              <tr>
                <th>{{$t('allocation_dc_office.allotment_date')}}</th>
                <td>: {{formData.allotment_date | dateFormat}}</td>
                <th>{{$t('allocation_dc_office.delivery_order_no')}}</th>
                <td>: {{$n(formData.delivery_order_no, { useGrouping: false }) }}</td>
              </tr>
              <tr>
                <th>{{$t('allocation_management.regional_office')}}</th>
                <td colspan="3">: {{regionName(formData.regional_office_id)}}</td>
              </tr>
            </table>
          </b-col>
        </b-row>
        <!-- =============End Main========= -->
        <div class="table-wrapper table-responsive">
          <table class="table table-responsive table-striped table-hover table-bordered">
            <thead class="small">
            <tr class="bg-primary">
              <th rowspan="2" scope="col" style="width: 10%"><div>{{ $t('globalTrans.sl_no') }}</div></th>
              <th rowspan="2" scope="col" class="text-center"><div>{{ $t('globalTrans.district') }}</div></th>
              <th rowspan="2" scope="col" class="text-center"><div>{{ $t('allocation_dc_office.beneficiary_no') }}</div></th>
              <template v-if="deliveryOrderItems.headerData">
                <th scope="col" colspan="2" class="text-center"  v-for="(item, index) in deliveryOrderItems.headerData" :key="index">
                  <div>{{ currentLocale === 'en'? item.text_en : item.text_bn }} ({{$t('allocation_dc_office.unit')}})</div>
                </th>
              </template>
            </tr>
            <tr class="bg-primary">
              <template v-if="deliveryOrderItems.childHeaderData">
                <th class="text-center"  v-for="(item, index) in deliveryOrderItems.childHeaderData" :key="index">
                  {{item.delivery_qty_en ? currentLocale === 'en'? item.delivery_qty_en : item.delivery_qty_bn : currentLocale === 'en'? item.allocated_qty_en : item.allocated_qty_bn }}
                </th>
              </template>
            </tr>
            </thead>
            <tbody>
            <template v-if="Object.keys(deliveryOrderItems).length > 0">
              <tr v-for="(item, index) in deliveryOrderItems.tableData" :key="index">
                <td  class="text-center">{{ $n(index+1) }}</td>
                <td class="text-center">{{ currentLocale === 'en'? item.district_name_en : item.district_name_bn }}</td>
                <td class="text-center">{{ $n(item.no_of_benificiary) }}</td>
                <template v-if="item.child">
                  <td  class="text-center"  v-for="(item2, index2) in item.child" :key="index2">
                    {{isNaN(item2.allocated_qty ? item2.allocated_qty : item2.delivery_qty) ? $n(0) : $n(item2.allocated_qty ? item2.allocated_qty : item2.delivery_qty)}}
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
        <b-row>
          <b-col xs="12" sm="12" md="12" lg="12" xl="12" v-if="formData.remarks">
            <p class="font-weight-bold"> {{ $t('globalTrans.remarks') }}</p>
            <p>{{formData.remarks}}</p>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
 </div>
</template>
<script>
  import Pdf from './pdf'
  import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
  export default {
    name: 'Form',
    props: ['items'],
    data () {
      return {
        valid: null,
        saveBtnName: this.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        formData: {
          fiscal_year_id: 0,
          allotment_count_id: 0,
          allotment_date: null,
          regional_office_id: 0,
          remarks: '',
          is_draft: false,
          deliveryOrderItems: []
        },
        loader: false,
        deliveryOrderItems: [],
        showDistrict: false,
        itemList: [],
        listLoad: true,
        otherDistrictList: [],
        otherDistrictListEdit: []
      }
    },
    created () {
      if (this.items) {
        const items = this.items
        this.formData.fiscal_year_id = items.fiscal_year_id
        this.formData.allotment_count_id = items.allotment_count_id
        this.formData.allotment_date = items.allotment_date
        this.formData.delivery_order_no = items.delivery_order_no
        this.formData.regional_office_id = items.regional_office_id
        this.formData.remarks = items.remarks
        this.formData.is_draft = items.is_draft
        this.listLoad = false
        this.dataFormatterEdit(items.details)
      }
    },
    computed: {
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      dataFormatterEdit (data) {
        const headerData = []
        const childHeaderData = []
        const tableData = []
        data.forEach((element, index) => {
          if (index === 0) {
            element.items.forEach((element2, index2) => {
              headerData.push({
                text: this.getItemCategoryName(element2.item_category_id),
                text_en: this.getItemCategoryName(element2.item_category_id, 'en'),
                text_bn: this.getItemCategoryName(element2.item_category_id, 'bn'),
                id: element2.item_category_id
              })
              childHeaderData.push({
                allocated_qty_en: 'Allocated Qty',
                allocated_qty_bn: 'বরাদ্দকৃত পরিমাণ'
              })
              childHeaderData.push({
                delivery_qty_en: 'Delivery Qty',
                delivery_qty_bn: 'ডেলিভারির পরিমাণ'
              })
            })
          }
          const child = []
          element.items.forEach((element2, index2) => {
            child.push({
              allocated_qty: element2.allocated_qty,
              id: element2.id,
              item: element2.item_category_id
            })
            child.push({
              delivery_qty: element2.delivered_qty,
              id: element2.id,
              item: element2.item_category_id
            })
          })
          tableData.push({
            district_name_en: this.getDistrictName(element.district_id, 'en'),
            district_name_bn: this.getDistrictName(element.district_id, 'bn'),
            district_id: element.district_id,
            is_other: element.is_other_district,
            no_of_benificiary: element.total_beneficiary,
            child: child
          })
          if (element.is_other_district) {
            this.otherDistrictListEdit.push(element.district_id)
          }
        })
        this.deliveryOrderItems = {
          headerData: headerData,
          childHeaderData: childHeaderData,
          tableData: tableData
        }
      },
      getDistrictName (itemCategoryId, lang = this.$i18n.locale) {
        const cateObj = this.$store.state.CommonService.commonObj.districtList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
        if (cateObj !== undefined) {
          if (lang === 'bn') {
            return cateObj.text_bn
          } else {
            return cateObj.text_en
          }
        }
      },
      getItemName (itemCategoryId, lang = this.$i18n.locale) {
        const cateObj = this.$store.state.LicenseRegistrationService.commonObj.itemList.filter(item => item.status === 1).find(item => item.value === itemCategoryId)
        if (cateObj !== undefined) {
          if (lang === 'bn') {
            return cateObj.text_bn
          } else {
            return cateObj.text_en
          }
        }
      },
      getFiscalYear (id, lang = this.$i18n.locale) {
        const data = this.$store.state.CommonService.commonObj.fiscalYearList.find(item => item.value === id)
        if (data !== undefined) {
          if (lang === 'bn') {
            return data.text_bn
          } else {
            return data.text_en
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
      regionName (region, lang = this.$i18n.locale) {
        const data = this.$store.state.CommonService.commonObj.officeList.filter(item => item.status === 1 && item.org_id === 7 && item.is_regional_office === 1).find(item => item.value === region)
        if (data !== undefined) {
          if (lang === 'bn') {
            return data.text_bn
          } else {
            return data.text_en
          }
        }
      },
      pdfExport () {
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, this.items, this, this.deliveryOrderItems)
      }
    }
  }
</script>
