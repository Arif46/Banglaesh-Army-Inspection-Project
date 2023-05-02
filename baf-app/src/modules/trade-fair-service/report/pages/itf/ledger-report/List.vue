<template>
  <div class="inner-section">
    <card>
      <!-- search section start -->
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('fair_report.ledger_report') }} {{ $t('globalTrans.search') }}</h4>
      </template>
      <template v-slot:searchBody>
          <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form id="form" @submit.prevent="handleSubmit(searchData)" @reset.prevent="reset" autocomplete="off">
            <b-row>
              <b-col sm="6">
                <ValidationProvider name="Fiscal Year" vid="fiscal_year_id" rules="required|min_value:1" v-slot="{ errors }">
                  <b-form-group
                    label-for="fiscal_year_id">
                    <template v-slot:label>
                      {{ $t('globalTrans.fiscal_year') }} <span class="text-danger">*</span>
                    </template>
                    <b-form-select
                      plain
                      id="fiscal_year_id"
                      :options="fiscalYearList"
                      v-model="search.fiscal_year_id"
                      :state="errors[0] ? false : (valid ? true : null)"
                    >
                      <template v-slot:first>
                        <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                      </template>
                    </b-form-select>
                  <div class="invalid-feedback">
                    {{ errors[0] }}
                  </div>
                  </b-form-group>
                </ValidationProvider>
              </b-col>
              <b-col sm="6">
              <ValidationProvider name="Fair name" vid="fair_name" rules="required|min_value:1" v-slot="{ errors }">
              <b-form-group
                label-for="fair_name">
                <template v-slot:label>
                  {{ $t('externalTradeFair.fair_name') }} <span class="text-danger">*</span>
                </template>
                <b-form-select
                  plain
                  id="fair_name"
                  :options="fairNameList"
                  v-model="search.fair_name_id"
                  :state="errors[0] ? false : (valid ? true : null)"
                >
                  <template v-slot:first>
                    <b-form-select-option :value=0 disabled>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                </b-form-select>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
              </b-col>
              <b-col sm="6">
                <b-form-group
                  label-for="fair_sector_id">
                  <template v-slot:label>
                    {{ $t('externalTradeFair.fair_sector') }}
                  </template>
                  <b-form-select
                    plain
                    id="fair_sector_id"
                    :options="fairSectorCusList"
                    v-model="search.fair_sector_id"
                  >
                  <template v-slot:first>
                    <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                  </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group
                  label-for="payment_status"
                >
                  <template v-slot:label>
                    {{ $t('fair_report.payment_status') }}
                  </template>
                  <b-form-select
                    plain
                    id="payment_status"
                    :options="paymentStatusList"
                    v-model="search.pay_status"
                  >
                    <template v-slot:first>
                      <b-form-select-option :value=0>{{$t('globalTrans.select')}}</b-form-select-option>
                    </template>
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="4">
                <b-button type="submit" size="sm" variant="primary">
                  <i class="ri-search-line"></i> {{ $t('globalTrans.search') }}
                </b-button>
              </b-col>
        </b-row>
          </b-form>
          </ValidationObserver>
      </template>
      <!-- search section end -->
    </card>

    <body-card>
      <!-- table section start -->
      <template v-slot:headerTitle>
        <h4 class="card-title">
          {{ $t('fair_report.ledger_report') }} {{ $t('globalTrans.list') }}
        </h4>
      </template>
      <template v-slot:headerAction>
        <b-button v-if="isResult && ledgerList.length === undefined" variant="primary" size="sm" @click="pdfExport" class="float-right">
            {{  $t('globalTrans.export_pdf') }}
        </b-button>
      </template>
      <template v-slot:body>
        <b-overlay :show="customloading">
          <list-report-head :base-url="baseUrl" uri="/itf-configuration/report-head/detail" :org-id="2">
            <template v-slot:projectNameSlot>
              {{ }}
            </template>
            {{ $t('fair_report.ledger_report') }}
          </list-report-head>
          <b-row>
            <b-col md="3">
              <span>{{ $t('tradeFairConfig.fiscal_year') }}</span>:
              <strong>{{ search.fiscal_year_id ? ($i18n.locale === 'en' ? searchHeaderData.fiscal_year_en : searchHeaderData.fiscal_year_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="3" class="text-left">
              <span>{{ $t('globalTrans.fair_name') }}</span>:
              <strong>{{ search.fair_name_id ? ($i18n.locale === 'en' ? searchHeaderData.fair_name_en : searchHeaderData.fair_name_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="3" class="text-center">
              <span>{{ $t('externalTradeFair.fair_sector') }}</span>:
              <strong>{{ search.fair_sector_id ? ($i18n.locale === 'en' ? searchHeaderData.fair_sector_en : searchHeaderData.fair_sector_bn) : $t('globalTrans.all') }}</strong>
            </b-col>
            <b-col md="3" class="text-right">
              <span>{{ $t('fair_report.payment_status') }}</span>:
              <strong>{{ search.pay_status ? searchHeaderData.payment : $t('globalTrans.all') }}</strong>
            </b-col>
          </b-row>
          <b-row>
            <b-overlay>
              <b-row>
                <b-col lg="12" sm="12">
                  <table style="width:100%;">
                    <thead>
                      <tr>
                        <th>{{ $t('globalTrans.sl_no') }}</th>
                        <th>{{ $t('externalTradeFair.comp_name') }}</th>
                        <th>{{ $t('fair_report.payment_status') }}</th>
                        <th>{{ $t('globalTrans.mobile') }}</th>
                        <th>{{ $t('fair_report.stall_name') }}</th>
                        <th>{{ $t('globalTrans.price') }}</th>
                        <th>{{ $t('fair_report.total_price') }}</th>
                        <th>{{ $t('externalTradeFair.subsidy_amount') }}</th>
                        <th>{{ $t('fair_report.payable_amount') }}</th>
                      </tr>
                    </thead>
                    <tbody v-if="isResult && ledgerList.length === undefined">
                      <span hidden>{{ $i = 1 }} {{ $si = 1 }}</span>
                      <template v-for="(items, index) in ledgerList">
                        <tr style="background: #ddd;" :key="index+1">
                          <td colspan="9" class="text-left"> <span class="mr-3">{{ $n($i++) + '.' }}</span>{{ getFairSector(index) }} </td>
                        </tr>
                        <template v-for="(item, index2) in items">
                          <template v-for="(el, index3) in item.stalls">
                            <tr :key="index + index2 + index3">
                              <td v-if="index3 === 0" :rowspan="item.stalls.length" class="text-center"> {{$n($si++)}}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length"> {{ currentLocale === 'bn' ? item.name_bn : item.name_en }}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length"> {{ getPaymentStatus(item.pay_status) }}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length"> {{ currentLocale === 'bn' ? 'o' : '0' }}{{ $n(item.phone_no, { useGrouping: false }) }} </td>
                              <td width="20%"> {{ currentLocale === 'bn' ? el.stall_info_details.stall_category_name.stall_cat_name_bn : el.stall_info_details.stall_category_name.stall_cat_name_en }}</td>
                              <td>{{ $n(el.stall_info_details.booth_rent, { useGrouping: false }) }}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length">{{ $n(item.payment.total_amount, { useGrouping: false }) }}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length">{{ $n(item.payment.subsidy_amount, { useGrouping: false }) }}</td>
                              <td v-if="index3 === 0" :rowspan="item.stalls.length"> {{ $n(item.payment.grand_total, { useGrouping: false }) }}</td>
                            </tr>
                          </template>
                        </template>
                      </template>
                      <tr>
                        <td colspan="6" class="text-right"> <b> {{ $t('fair_report.refund') }} </b> : </td>
                        <td class="text-center"> {{ $n(refund_amount, { useGrouping: false }) }} </td>
                        <td colspan="1" class="text-right"> <b>{{ $t('fair_report.paid') }}</b> : </td>
                        <td class="text-center"> {{ $n(paid_amount, { useGrouping: false }) }} </td>
                      </tr>
                    </tbody>
                    <tbody v-else>
                      <tr>
                        <td colspan="9" class="text-center"> {{ $t('fair_report.not_found') }} </td>
                      </tr>
                    </tbody>
                  </table>
                </b-col>
              </b-row>
            </b-overlay>
          </b-row>
        </b-overlay>
      </template>
      <!-- table section end -->
    </body-card>
  </div>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { fairLedgerReportList } from '../../../api/routes'
import ListReportHead from '@/components/custom/ListReportHead.vue'
import ModalBaseMasterList from '@/mixins/list'
export default {
  mixins: [ModalBaseMasterList],
  components: {
    ListReportHead
  },
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      sortBy: '',
      customloading: false,
      isResult: false,
      ledgerList: [],
      fairNameList: [],
      fairSectorCusList: [],
      paid_amount: 0,
      refund_amount: 0,
      search: {
        fiscal_year_id: 0,
        fair_name_id: 0,
        fair_sector_id: 0,
        pay_status: 0,
        limit: 20
      },
      searchHeaderData: {
        fiscal_year_en: '',
        fiscal_year_bn: '',
        fair_sector_en: '',
        fair_sector_bn: '',
        fair_name_en: '',
        fair_name_bn: '',
        payment_en: '',
        payment_bn: ''
      }
    }
  },
  created () {
    this.search.fiscal_year_id = this.$store.state.currentFiscalYearId
    // this.loadData()
  },
  watch: {
    'search.limit': function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.loadData()
      }
    },
    'search.fiscal_year_id': function (newVal, oldVal) {
      this.search.fair_name_id = 0
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
      }
    },
    'search.fair_name_id': function (newVal, oldVal) {
      this.search.fair_sector_id = 0
      if (newVal !== oldVal) {
        this.fairSectorCusList = this.getFairSectorList()
      }
    },
    currentLocale: function (newVal, oldVal) {
      if (newVal !== oldVal) {
        this.fairNameList = this.getFairNameList()
        this.fairSectorCusList = this.getFairSectorList()
        this.getSearchParametter()
      }
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    fiscalYearList () {
      return this.$store.state.CommonService.commonObj.fiscalYearList.filter(el => el.status === 1).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    fairList () {
      return this.$store.state.TradeFairService.commonObj.fairNameList.filter(el => el.status === 4)
    },
    paymentStatusList () {
      return this.$store.state.TradeFairService.commonObj.paymentStatusList.map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    }
  },
  methods: {
    getSearchParametter () {
      if (this.search.fiscal_year_id) {
        const fiscalYear = this.$store.state.CommonService.commonObj.fiscalYearList.find(obj => obj.value === this.search.fiscal_year_id)
        const fiscalYearData = {
          fiscal_year_en: fiscalYear?.text_en,
          fiscal_year_bn: fiscalYear?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, fiscalYearData)
      }
      if (this.search.fair_sector_id) {
        const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(obj => obj.value === this.search.fair_sector_id)
        const sectorData = {
          fair_sector_en: sectorObj?.text_en,
          fair_sector_bn: sectorObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, sectorData)
      }
      if (this.search.pay_status) {
        const paymentStatusObj = this.paymentStatusList.find(obj => obj.value === parseInt(this.search.pay_status))
        const paymentStatusData = {
          payment: paymentStatusObj?.text
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, paymentStatusData)
      }
      if (this.search.fair_name_id) {
        const fairNameObj = this.fairList.find(obj => obj.value === this.search.fair_name_id)
        const fairNameData = {
          fair_name_en: fairNameObj?.text_en,
          fair_name_bn: fairNameObj?.text_bn
        }
        this.searchHeaderData = Object.assign({}, this.searchHeaderData, fairNameData)
      }
    },
    getFairSector (sector) {
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.find(el => el.value === parseInt(sector))
      if (sectorObj !== undefined) {
        return this.currentLocale === 'bn' ? sectorObj.text_bn : sectorObj.text_en
      }
    },
    getPaymentStatus (statusId) {
      const statusObj = this.paymentStatusList.find(el => el.value === parseInt(statusId))
      if (statusObj !== 'undefined') {
        return statusObj.text
      }
    },
    getFairNameList () {
      return this.fairList.filter(item => item.fiscal_year_id === this.search.fiscal_year_id).map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
    },
    getFairSectorList () {
      const fairObj = this.fairList.find(el => el.value === this.search.fair_name_id)
      const sectorObj = this.$store.state.TradeFairService.commonObj.fairSectorList.filter(el => el.value === parseInt(fairObj.fair_sector_id) || el.text_en.toLowerCase() === 'others').map(el => {
        return { value: el.value, text: this.$i18n.locale === 'bn' ? el.text_bn : el.text_en }
      })
      return sectorObj
    },
    searchData () {
      this.loadData()
    },
    async loadData () {
      this.customloading = true
      this.getSearchParametter()
      const params = Object.assign({}, this.search, { page: this.pagination.currentPage, per_page: this.pagination.perPage })
      // this.$store.dispatch('mutateCommonProperties', { customloading: true, listReload: false })
      const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, fairLedgerReportList, params)
      if (result.success) {
        this.ledgerList = result.data
        this.paid_amount = result.paid_amount
        this.refund_amount = result.refund_amount
        this.customloading = false
        this.isResult = true
      }
    },
    async pdfExport () {
      this.customloading = true
      const params = Object.assign({ request_type: 'pdf', local: this.$i18n.locale, org_id: 2, fiscal_year_id: this.search.fiscal_year_id, fair_sector_id: this.search.fair_sector_id, fair_name_id: this.search.fair_name_id, pay_status: this.search.pay_status })
      const result = await RestApi.getPdfData(internationalTradeFairServiceBaseUrl, fairLedgerReportList, params)
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
<style scoped>
  table, th, td {
    border: 1px solid black;
    padding:5px;
  }
</style>
