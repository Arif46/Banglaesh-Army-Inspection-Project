<template>
    <b-row>
        <b-col lg="12" sm="12">
            <b-overlay :show="loader">
                <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
                  <template v-slot:projectNameSlot>
                    {{ }}
                  </template>
                  <b-row>
                    <b-col>
                        <h6 class="text-center" style="font-weight:bold">{{ $i18n.locale == 'en' ? fair_info.fair_name_en : fair_info.fair_name_bn }}</h6>
                        <!-- <div class="text-center">{{ $i18n.locale == 'en' ? fair_info.fiscal_year_en : fair_info.fiscal_year_bn }}</div> -->
                    </b-col>
                  </b-row>
                </list-report-head>
                <b-row>
                    <b-col md="6" class="mb-2 text-center mx-auto">
                        <h5  style="font-weight:bold;background-color:#ddd">{{ $t('globalTrans.payment') + ' ' + $t('globalTrans.receipt') }}</h5>
                    </b-col>
                </b-row>
                <b-row class="mb-3 mx-2 mt-2">
                  <b-col md="3" style="font-weight:bold">{{$t('externalTradeFair.participation_id')}} {{":"}}</b-col>
                  <b-col md="9">{{ fair_info.app_auto_id }}</b-col>
                  <b-col md="3" style="font-weight:bold">{{$t('globalTrans.payment_type')}} {{":"}}</b-col>
                  <b-col md="3">{{ getPayType(paymentData.pay_type) }}</b-col>
                  <b-col md="3" style="font-weight:bold">{{ $t('globalTrans.voucher_no') }} {{":"}}</b-col>
                  <b-col md="3"> {{ paymentData.voucher_no }}</b-col>
                  <b-col md="3" style="font-weight:bold">{{ $t('globalTrans.date') }} {{":"}}</b-col>
                  <b-col md="3"> {{ paymentData.pay_date }}</b-col>
                  <b-col md="3" style="font-weight:bold">{{ $t('sideBar.bank') + ' ' + $t('globalTrans.name')  }} {{":"}}</b-col>
                  <b-col md="3"> {{ getBankName(paymentData.bank_id) }}</b-col>
                  <b-col md="3" style="font-weight:bold">{{ $t('sideBar.branch') + ' ' + $t('globalTrans.name')  }} {{":"}}</b-col>
                  <b-col md="3"> {{ getBranchName(paymentData.branch_id) }}</b-col>
                </b-row>
                <b-row>
                    <b-table-simple bordered small>
                        <thead>
                            <tr>
                                <b-th colspan="6" class="text-white text-center p-2 bg-dark">{{ $t('tradeFairConfig.stall_information') }}</b-th>
                            </tr>
                            <tr class="bg-primary text-center text-align-center">
                                <th style="width:10%">{{ $t('globalTrans.sl_no') }}</th>
                                <th style="width:20%">{{ $t('tradeFairConfig.stall_cat_name') }}</th>
                                <th style="width:15%">{{ $t('tradeFairConfig.stall_size') }}</th>
                                <th style="width:15%">{{ $t('tradeFairConfig.stall_type') }}</th>
                                <th style="width:15%">{{ $t('tradeFairConfig.booth_rent') + ' ' + $t('globalTrans.tk') }}</th>
                                <!-- <th style="width:25%">{{ $t('globalTrans.description') }}</th> -->
                            </tr>
                        </thead>
                        <b-tbody v-if="stalls.length > 0">
                            <b-tr v-for="(item, index) in stalls" :key="index">
                                <b-td class="text-center">{{ $n(index + 1) }}</b-td>
                                <b-td>{{ getStallCategoryName(item.stall_cat_id) }}</b-td>
                                <b-td>{{ $n(item.stall_size) + ' ' + getMeasurementUnitName(item.measurement_id) }}</b-td>
                                <b-td class="text-center">{{ getStallType(item.stall_type) }}</b-td>
                                <b-td class="text-right">{{ $n(item.booth_rent, { minimumFractionDigits: 2 }) }}</b-td>
                                <!-- <b-td class="text-left">{{ $i18n.locale == 'bn' ? item.description_bn : item.description_en }}</b-td> -->
                            </b-tr>
                            <b-tr style="background: #ddd">
                                <b-td class="text-right" colspan="4">{{ $t('sitePreference.total') + ' ' + $t('globalTrans.tk') }}</b-td>
                                <b-td class="text-right">{{ $n(paymentData?.total_amount, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('tradeFairConfig.subsidy') + ' (%)' }}</b-td>
                                <b-td class="text-right">{{ $n(paymentData?.subsidy, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('externalTradeFair.subsidy_amount') + ' ' + $t('globalTrans.tk') }}</b-td>
                                <b-td class="text-right">{{ $n(paymentData?.subsidy_amount, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('sitePreference.grandTotal') + ' ' + $t('globalTrans.tk') }}</b-td>
                                <b-td class="text-right">{{ $n(paymentData?.grand_total, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                        </b-tbody>
                    </b-table-simple>
                </b-row>
            </b-overlay>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { paymentReceiptApi } from '../../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
export default {
  name: 'Form',
  props: ['id'],
  components: {
    ListReportHead
  },
  data () {
    return {
        baseUrl: internationalTradeFairServiceBaseUrl,
        comp: 'PaymentOnline',
        loader: false,
        fair_info: {},
        stallCategoryList: [],
        stalls: [],
        paymentData: {},
        paymentTypeList: [
          { text: this.$i18n.locale === 'bn' ? 'অনলাইন' : 'Online', value: 1 },
          { text: this.$i18n.locale === 'bn' ? 'অফলাইন' : 'Offline', value: 2 }
        ]
    }
  },
  created () {
    if (this.id) {
      const tmp = this.getEditData()
      this.fair_info = tmp
      this.getStallCategoryList()
      this.getPayInfo()
    }
  },
  watch: {
//
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getStallCategoryList () {
        this.loader = true
        const apis = '/itf-configuration/stall-information/stall-cat-by-fair'
        const params = {
            fair_name_id: this.fair_info.fair_circular.fair_name_id
        }
        RestApi.getData(internationalTradeFairServiceBaseUrl, apis, params).then(response => {
            if (response.success) {
                this.stallCategoryList = response.data.map(el => {
                    return Object.assign({}, el, { text: this.$i18n.locale === 'en' ? el.text_en : el.text_bn })
                })
            } else {
                this.stallCategoryList = []
            }
        })
        this.loader = false
    },
    async getPayInfo () {
        this.loader = true
        const myObj = {
             participation_id: this.id,
             fair_name_id: this.fair_info.fair_circular.fair_name_id,
             applied_sector_id: this.fair_info.applied_sector_id
        }
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, paymentReceiptApi, myObj)
        this.loader = false
        if (result.success) {
            this.paymentData = result.data.payment
            this.stalls = result.data.stall_list
        }
    },
    getStallCategoryName (id) {
        const Obj = this.stallCategoryList.find(item => item.value === id)
        if (this.currentLocale === 'bn') {
          return Obj !== undefined ? Obj.text_bn : ''
        } else {
          return Obj !== undefined ? Obj.text_en : ''
        }
    },
    getMeasurementUnitName (Id) {
        const Obj = this.$store.state.ExternalUserService.tradeFair.commonObj.measurementUnitList.find(item => item.value === parseInt(Id))
        if (typeof Obj !== 'undefined') {
            return this.$i18n.locale === 'en' ? Obj.text_en : Obj.text_bn
        }
        return ''
    },
    getStallType (id) {
        const dataStallType = this.$store.state.TradeFairService.commonObj.stallTypeList.find(item => item.value === parseInt(id))
        if (typeof dataStallType !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataStallType.text_en : dataStallType.text_bn
        } else {
          return ''
        }
    },
    getEditData () {
      const tmpData = this.$store.state.list.find(item => item.id === parseInt(this.id))
      return JSON.parse(JSON.stringify(tmpData))
    },
    getPayType (id) {
        const dataPayType = this.paymentTypeList.find(item => item.value === parseInt(id))
        if (typeof dataPayType !== 'undefined') {
          return dataPayType.text
        } else {
          return ''
        }
    },
    getBankName (id) {
        const dataBankData = this.$store.state.CommonService.commonObj.bankNameList.find(item => item.value === parseInt(id))
        if (typeof dataBankData !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataBankData.text_en : dataBankData.text_bn
        } else {
          return ''
        }
    },
    getBranchName (id) {
        const dataBranchData = this.$store.state.CommonService.commonObj.branchNameList.find(item => item.value === parseInt(id))
        if (typeof dataBranchData !== 'undefined') {
          return this.$i18n.locale === 'en' ? dataBranchData.text_en : dataBranchData.text_bn
        } else {
          return ''
        }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, participation_id: this.id, fiscal_year_id: this.fair_info.fair_circular.fiscal_year_id, fair_name_id: this.fair_info.fair_circular.fair_name_id, applied_sector_id: this.fair_info.applied_sector_id })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, paymentReceiptApi, params)
      var blob = new Blob([result], {
        type: 'application/pdf'
      })
      var url = window.URL.createObjectURL(blob)
      window.open(url).print()
      this.customloading = false
    }
  }
}
</script>
