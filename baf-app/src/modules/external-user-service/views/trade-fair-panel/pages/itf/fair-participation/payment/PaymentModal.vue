<template>
    <b-row>
        <b-col lg="12" sm="12">
            <b-overlay :show="loader">
                <b-row>
                    <b-col class="mb-3">
                        <h5 class="text-center">{{ $i18n.locale == 'en' ? fair_info.fair_name_en : fair_info.fair_name_bn }}</h5>
                        <!-- <div class="text-center">{{ $i18n.locale == 'en' ? fair_info.fiscal_year_en : fair_info.fiscal_year_bn }}</div> -->
                    </b-col>
                </b-row>
                <b-row v-if="is_payment">
                    <b-col class="text-dark mb-3" lg="12" sm="12">
                        <div class="bg-dark w-50 m-auto rounded-pill">
                            <h6 class="text-white text-center py-1"> {{ $t('globalTrans.payment') }}</h6>
                        </div>
                        <div class="text-center mt-2">
                            <b-form-radio-group
                                v-model="payment_type"
                                :options="paymentTypeList"
                            ></b-form-radio-group>
                        </div>
                    </b-col>
                    <b-col lg="12" sm="12">
                        <keep-alive>
                            <component v-bind:is="comp" :id="id" :payment="payment" @clicked="onClickChild" @back="unsetPayment"></component>
                        </keep-alive>
                    </b-col>
                </b-row>
                <b-row v-else>
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
                                <b-td class="text-right">{{ $n(payment.total_amount, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('tradeFairConfig.subsidy') + ' (%)' }}</b-td>
                                <b-td class="text-right">{{ $n(payment?.subsidy, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('externalTradeFair.subsidy_amount') + ' ' + $t('globalTrans.tk') }}</b-td>
                                <b-td class="text-right">{{ $n(payment?.subsidy_amount, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                            <b-tr>
                                <b-td class="text-right" colspan="4">{{ $t('sitePreference.grandTotal') + ' ' + $t('globalTrans.tk') }}</b-td>
                                <b-td class="bg-warning text-right">{{ $n(payment.grand_total, { minimumFractionDigits: 2 }) }}</b-td>
                            </b-tr>
                        </b-tbody>
                    </b-table-simple>
                    <b-col class="text-right">
                        <b-button type="button" @click="setPayment()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.payment') }} <i class="ri-arrow-right-line"></i></b-button>
                        <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-payment')">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
            </b-overlay>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { stallInformationDetailsApi } from '../../../../api/routes'
import PaymentOnline from './PaymentOnline'
import PaymentOffline from './PaymentOffline'

export default {
  name: 'Form',
  props: ['id'],
  components: {
    PaymentOnline, PaymentOffline
  },
  data () {
    return {
        comp: 'PaymentOnline',
        loader: false,
        fair_info: {},
        stallCategoryList: [],
        stalls: [],
        payment: {},
        is_payment: false,
        payment_type: 1
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
    payment_type: function (newVal, oldVal) {
        if (newVal !== oldVal) {
          if (newVal === 2) {
              this.comp = 'PaymentOffline'
          } else {
              this.comp = 'PaymentOnline'
          }
        }
    }
  },
  computed: {
    paymentTypeList () {
      return [
        { text: this.$i18n.locale === 'bn' ? 'অনলাইন' : 'Online', value: 1 },
        { text: this.$i18n.locale === 'bn' ? 'অফলাইন' : 'Offline', value: 2 }
      ]
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    onClickChild () {
      this.$bvModal.hide('modal-payment')
    },
    setPayment () {
        this.is_payment = true
    },
    unsetPayment () {
        this.is_payment = false
    },
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
        const result = await RestApi.getData(internationalTradeFairServiceBaseUrl, stallInformationDetailsApi, myObj)
        this.loader = false
        if (result.success) {
            this.stalls = result.data.stall_list
            this.payment.subsidy = result.data.subsidy
            this.calculateTotal()
        }
    },
    calculateTotal () {
        this.payment.total_amount = this.stalls.reduce((a, b) => a + parseFloat(b.booth_rent), 0)
        const percAmount = (parseFloat(this.payment.total_amount) * parseFloat(this.payment.subsidy)) / 100
        this.payment.subsidy_amount = percAmount
        this.payment.grand_total = parseFloat(this.payment.total_amount) - percAmount
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
    }
  }
}
</script>
