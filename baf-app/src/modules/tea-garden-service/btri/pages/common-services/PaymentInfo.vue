<template>
  <b-container fluid>
    <b-row>
      <b-col lg="12" sm="12">
        <body-card>
          <template v-slot:body>
                <b-overlay :show="loading">
                    <b-row>
                        <b-col xl="12" lg="12" sm="12">
                            <b-table-simple hover bordered small caption-top responsive>
                              <b-tbody>
                                <b-tr>
                                  <b-td><strong>{{ $t('globalTrans.organization') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ currentLocale === 'en' ? 'BTRI' : 'বিটিআরই' }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('teaGardenConfig.service_name') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ currentLocale === 'en' ? data.service.service_name_en : data.service.service_name_bn }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('teaGardenService.application_id') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ data.app_id }}
                                  </b-td>
                                </b-tr>
                                <b-tr v-if="data.payment.payment_type === 1">
                                  <b-td><strong>{{ $t('teaGardenBtriService.receipt') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ data.payment.received_number }}
                                  </b-td>
                                </b-tr>
                                <b-tr v-else-if="data.payment.payment_type === 2">
                                  <b-td><strong>{{ $t('teaGardenBtriService.check_no') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ data.payment.check_no }}
                                  </b-td>
                                </b-tr>
                                <b-tr v-else>
                                  <b-td><strong>{{ $t('teaGardenBtriService.transaction_number') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ data.payment.transaction_number }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('teaGardenBtriService.transaction_date') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ data.payment.date | dateFormat }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('globalTrans.payment_type') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ getPaymentTypeName(data.payment.payment_type) }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('teaGardenBtriService.total_samples') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ $n(data.total_samples) }}
                                  </b-td>
                                </b-tr>
                                <b-tr>
                                  <b-td><strong>{{ $t('priceMonitoring.amount_in_taka') }}</strong></b-td>
                                  <b-td class="text-left">
                                    {{ $n(data.payment.amount) }} /-
                                  </b-td>
                                </b-tr>
                              </b-tbody>
                            </b-table-simple>
                            <div class="mt-4 text-right">
                              <b-button variant="danger" class="mr-1" @click="$bvModal.hide('modal-6')">{{ $t('globalTrans.cancel') }}</b-button>
                            </div>
                        </b-col>
                    </b-row>
                </b-overlay>
          </template>
        </body-card>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
import { applicationReturn } from '../../api/routes'
import ExportPdf from './payment-info-pdf.js'

export default {
    name: 'FormLayout',
    props: ['item', 'id'],
    created () {
      if (this.item) {
        this.data = this.item
      }
    },
    data () {
        return {
          data: {
          }
        }
    },
    computed: {
      loading () {
        return this.$store.state.commonObj.loading
      },
      btriPaymentType () {
        return this.$store.state.TeaGardenService.commonObj.btriPaymentType
      },
      currentLocale () {
        return this.$i18n.locale
      }
    },
    methods: {
      async register () {
        this.$store.dispatch('mutateCommonProperties', { loading: true })
        let result = null
        const loadinState = { loading: false, listReload: true }
        result = await RestApi.putData(teaGardenServiceBaseUrl, `${applicationReturn}/${this.id}`, this.data)
        this.$store.dispatch('mutateCommonProperties', loadinState)
        if (result.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
            color: '#D6E09B'
          })
          this.$bvModal.hide('modal-4')
        } else {
          this.$refs.form.setErrors(result.errors)
        }
      },
      pdfExport () {
        const reportTitle = this.$t('externalLrcpn.payment_receipt')
        ExportPdf.exportPdfDetails(teaGardenServiceBaseUrl, '/configuration/report-heading/detail', 5, reportTitle, this)
      },
      getPaymentTypeName (id) {
        const obj = this.btriPaymentType.find(item => item.value === parseInt(id))
        return this.currentLocale === 'en' ? obj?.text_en : obj?.text_bn
      }
    }
}
</script>
