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
        <div class="col-md-12" id="moneyReceiptArea">
          <table v-if="receipt.length" class="table table-bordered table-sm">
            <tr>
              <th colspan="3">{{  $t('dealer.company_name') }}</th>
              <td colspan="4">{{ $i18n.locale === 'bn' ? application.applications.details.company_name_bn : application.applications.details.company_name }}</td>
            </tr>
            <tr>
              <th colspan="3">{{  $t('globalTrans.name') }}</th>
              <td colspan="4">{{ $i18n.locale === 'bn' ? application.applications.details.applicant_name_bn : application.applications.details.applicant_name }}</td>
            </tr>
            <tr>
              <th colspan="3">{{  $t('globalTrans.application_id') }}</th>
              <td colspan="4">{{ $n(application.applications.application_id, { useGrouping: false }) }}</td>
            </tr>
            <tr>
              <th colspan="3">{{  $t('dealer.transaction_no') }}</th>
              <td colspan="4">{{ transaction_no }}</td>
            </tr>
            <tr>
              <th colspan="3">{{  $t('dealer.payment_type') }}</th>
              <td colspan="4">{{ getPaidType(receipt[0].paid_type) }}</td>
            </tr>
            <tr>
              <th colspan="7" class="text-center">{{ $t('dealer.payment_history') }}</th>
            </tr>
            <tr>
                <th>{{ $t('fee_name.fee_name') }}</th>
                <th colspan="2">{{ $t('globalTrans.fees') + ' ' + $t('globalTrans.amount') }}</th>
                <th colspan="2">{{ $t('globalTrans.vat') }} (%) </th>
                <th colspan="2">{{ $t('globalTrans.tax') }} (%) </th>
            </tr>
            <slot v-for="(item, index) in receipt">
              <tr :key="index + 45">
                <td rowspan="7">{{ getFeeName(item.payment_type) }}</td>
              </tr>
              <tr :key="index + 45451">
                <th>{{ $t('globalTrans.amount') }}</th>
                <td>{{ $n(item.amount) }}</td>
                <th>{{ $t('globalTrans.amount') }}</th>
                <td>{{ item.amount_vat ? $n(item.amount_vat) : '' }}</td>
                <th>{{ $t('globalTrans.amount') }}</th>
                <td>{{ item.amount_tax ? $n(item.amount_tax) : '' }}</td>
              </tr>
              <tr :key="index + 455451">
                <th> {{ item.paid_type === 2 ? $t('dealer.challan_no') : $t('li_step.payroll') }}</th>
                <td>{{ item.challan_no }}</td>
                <th> {{ item.paid_type === 2 ? $t('dealer.challan_no') : $t('li_step.payroll') }}</th>
                <td>{{ item.challan_no_vat }}</td>
                <th> {{ item.paid_type === 2 ? $t('dealer.challan_no') : $t('li_step.payroll') }}</th>
                <td>{{ item.challan_no_tax }}</td>
              </tr>
              <tr :key="index + 455451">
                <th>{{ $t('globalTrans.date') }}</th>
                <td>
                  <span v-if="item.pay_date ">{{ item.pay_date | dateFormat }}</span>
                </td>
                <th>{{ $t('globalTrans.date') }}</th>
                <td><span v-if="item.pay_date_vat">{{ item.pay_date_vat | dateFormat }}</span></td>
                <th>{{ $t('globalTrans.date') }}</th>
                <td><span v-if="item.pay_date_tax">{{ item.pay_date_tax | dateFormat }}</span></td>
              </tr>
              <tr :key="index + 4555451">
                <th>{{ $t('dealer.bank_name') }}</th>
                <td>{{ item.bank_name }}</td>
                <th>{{ $t('dealer.bank_name') }}</th>
                <td>{{ item.bank_name_vat }}</td>
                <th>{{ $t('dealer.bank_name') }}</th>
                <td>{{ item.bank_name_tax }}</td>
              </tr>
              <tr :key="index + 4555451">
                <th>{{ $t('dealer.branch_name') }}</th>
                <td>{{ item.branch_name }}</td>
                <th>{{ $t('dealer.branch_name') }}</th>
                <td>{{ item.branch_name_vat }}</td>
                <th>{{ $t('dealer.branch_name') }}</th>
                <td>{{ item.branch_name_tax }}</td>
              </tr>
              <tr :key="index + 4555451">
                <th>{{ $t('globalTrans.attachment') }}</th>
                <td>
                  <a v-if="item.attachment" target="_blank" :href="lrcpanBaseUrl + item.attachment" class="btn btn-sm btn-success"><i style="margin: 15px 1px 15px !important; font-size: 12px" class="ri-download-line"></i></a>
                </td>
                <th>{{ $t('globalTrans.attachment') }}</th>
                <td>
                  <a v-if="item.attachment_vat" target="_blank" :href="lrcpanBaseUrl + item.attachment_vat" class="btn btn-sm btn-success"><i style="margin: 15px 1px 15px !important; font-size: 12px" class="ri-download-line"></i></a>
                </td>
                <th>{{ $t('globalTrans.attachment') }}</th>
                <td>
                  <a v-if="item.attachment_tax" target="_blank" :href="lrcpanBaseUrl + item.attachment_tax" class="btn btn-sm btn-success"><i style="margin: 15px 1px 15px !important; font-size: 12px" class="ri-download-line"></i></a>
                </td>
              </tr>
            </slot>
            <tr>
              <th>{{ $t('globalTrans.subtotal') }}</th>
              <td colspan="2">{{ $n(getTotal(receipt)) }}</td>
              <td colspan="2">{{ $n(getTotalVat(receipt)) }}</td>
              <td colspan="2">{{ $n(getTotalTax(receipt)) }}</td>
            </tr>
            <tr>
              <th>{{ $t('globalTrans.total') }}</th>
              <td colspan="6">{{ $n(getTotal(receipt) + getTotalVat(receipt) + getTotalTax(receipt)) }}</td>
            </tr>
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
import { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import Pdf from './pdf'

export default {
  props: ['receipt', 'transaction_no', 'application'],
  data () {
    return {
      lrcpanBaseUrl: licenseRegistrationServiceBaseUrl
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
    getServiceName (serviceId) {
      const ServiceName = this.$store.state.LicenseRegistrationService.commonObj.serviceNamesList.find(item => item.value === serviceId)
      return this.$i18n.locale === 'en' ? ServiceName !== undefined ? ServiceName.text_en : '' : ServiceName !== undefined ? ServiceName.text_bn : ''
    },
    getPaidType (paidType) {
      if (paidType === 1) {
        return this.$i18n.locale === 'en' ? 'Online' : 'অনলাইন'
      }
      if (paidType === 2) {
        return this.$i18n.locale === 'en' ? 'Offline' : 'অফলাইন'
      }
    },
    getFeeName (id) {
      const fee = this.$store.state.LicenseRegistrationService.commonObj.paymentTypeList.find(item => item.value === parseInt(id))
      return typeof fee === 'undefined' ? '' : (this.$i18n.locale === 'bn' ? fee.text_bn : fee.text_en)
    },
    pdfExport () {
        const reportTitle = this.$t('li_step.expiration_passed_report')
        Pdf.exportPdfDetails(licenseRegistrationServiceBaseUrl, '/configuration/report-heading/detail', 2, reportTitle, this.receipt, this, this.application.applications, this.transaction_no)
    }
  }
}
</script>
