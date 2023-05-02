<template>
  <div>
      <div class="row">
        <b-row class="text-right mb-2">
          <b-col>
              <b-button variant="primary" @click="pdfExport" class="mr-2">
                <i class="ri-printer-line"></i> {{  $t('globalTrans.print') }}
              </b-button>
          </b-col>
        </b-row>
        <div class="col-md-10 offset-md-1" id="moneyReceiptArea">
          <table v-if="receipt.length" class="table table-bordered table-sm">
            <tbody>
              <tr>
                <th colspan="2">{{  $t('dealer.company_name') }}</th>
                <td colspan="2">{{ $i18n.locale === 'bn' ? application.details.company_name_bn : application.details.company_name }}</td>
              </tr>
              <tr>
                <th colspan="2">{{  $t('globalTrans.name') }}</th>
                <td colspan="2">{{ $i18n.locale === 'bn' ? application.details.applicant_name_bn : application.details.applicant_name }}</td>
              </tr>
              <tr>
                <th colspan="2">{{  $t('globalTrans.application_id') }}</th>
                <td colspan="2">{{ $n(application.application_id , { useGrouping: false }) }}</td>
              </tr>
              <tr>
                <th colspan="2">{{  $t('dealer.transaction_no') }}</th>
                <td colspan="2">{{ transaction_no }}</td>
              </tr>
              <tr>
                <th colspan="2">{{  $t('dealer.payment_type') }}</th>
                <td colspan="2">{{ getPaidType(receipt[0].paid_type) }}</td>
              </tr>
              <tr>
                <th colspan="4" class="text-center">{{ $t('dealer.payment_history') }}</th>
              </tr>
              <tr>
                  <th>{{ $t('fee_name.fee_name') }}</th>
                  <th>{{ $t('globalTrans.amount') }}</th>
                  <th>{{ $t('globalTrans.vat') }} (%) </th>
                  <th>{{ $t('globalTrans.tax') }} (%) </th>
              </tr>
              <tr v-for="(item, index) in receipt" :key="index">
                <td>{{ getFeeName(item.payment_type) }}</td>
                <td>{{ $n(item.amount) }}</td>
                <td v-if="item.vat">({{ $n(item.vat) }}%) = {{  $n(item.amount_vat) }}</td>
                <td v-else>{{ $n(0) }}</td>
                <td v-if="item.tax">({{ $n(item.tax) }}%) = {{ $n(item.amount_tax) }}</td>
                <td v-else>{{ $n(0) }}</td>
              </tr>
              <tr>
                <th>{{ $t('globalTrans.subtotal') }}</th>
                <td>{{ $n(getTotal(receipt)) }}</td>
                <td>{{ $n(getTotalVat(receipt)) }}</td>
                <td>{{ $n(getTotalTax(receipt)) }}</td>
              </tr>
              <tr>
                <th colspan="3">{{ $t('globalTrans.total') }}</th>
                <td colspan="1">{{ $n(getTotal(receipt) + getTotalVat(receipt) + getTotalTax(receipt)) }}</td>
              </tr>
            </tbody>
          </table>
           <slot v-else>
              <b-tr>
                  <td colspan="3" class="text-center">Sorry, Data not found</td>
              </b-tr>
            </slot>
        </div>
      </div>
  </div>
</template>
<script>
import Pdf from './pdfTwo'
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
export default {
  props: ['application', 'receipt', 'transaction_no'],
  data () {
    return {
    }
  },
  methods: {
    getTotal (data) {
      const total = data.reduce(function (a, b) {
        return parseFloat(a) + parseFloat(b.amount)
      }, 0)
      this.total_amount = total
      return total
    },
    getTotalVat (data) {
      const total = data.reduce(function (a, b) {
        return parseFloat(a) + parseFloat(b.amount_vat)
      }, 0)
      this.total_vat = total
      return total
    },
    getTotalTax (data) {
      const total = data.reduce(function (a, b) {
        return parseFloat(a) + parseFloat(b.amount_tax)
      }, 0)
      this.total_tax = total
      return total
    },
    getPaidType (paidType) {
      if (paidType === 1) {
        return this.$i18n.locale === 'en' ? 'Online' : 'অনলাইন'
      }
      if (paidType === 2) {
        return this.$i18n.locale === 'en' ? 'Offline' : 'অফলাইন'
      }
      if (paidType === 3) {
        return this.$i18n.locale === 'en' ? 'PayRoll' : 'পে রোল'
      }
    },
    getFeeName (id) {
      const fee = this.$store.state.ExternalUserService.dealerPanel.commonObj.paymentTypeList.find(item => item.value === parseInt(id))
      return typeof fee === 'undefined' ? '' : (this.$i18n.locale === 'bn' ? fee.text_bn : fee.text_en)
    },
    pdfExport () {
        const reportTitle = this.$t('li_step.expiration_passed_report')
        Pdf.exportPdfDetails(this, reportTitle, licenseRegistrationServiceBaseUrl, this.receipt, this.application, this.transaction_no)
    }
  }
}
</script>
