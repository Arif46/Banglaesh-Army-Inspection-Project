<template>
  <b-container fluid>
    <b-overlay :show="loading">
      <b-col v-if="loadHistory" md="12" lg="12" sm="12">
        <b-overlay :show="true" class="p-5">
          <div class="text-center">
            <h5> {{ $t('externalLrcpn.receipt_checking') }}</h5>
          </div>
        </b-overlay>
      </b-col>
      <b-col v-else md="12" lg="12" sm="12">
        <div>
          <b-tabs content-class="mt-3">
            <span v-for="(deliverItem, index) in item.delivery_items" :key="index">
              <b-tab v-if="deliverItem.is_paid > 0" :title="deliverItem.is_paid == 1 ? `* ${$t('allocation_dc_office.challan')} - ${$n(deliverItem.challan_id, {useGrouping: false})}` : `${$t('allocation_dc_office.challan')} - ${$n(deliverItem.challan_id, {useGrouping: false})}`">
                <ChallanView :items="item" :challan_id="deliverItem.challan_id" />
                 <b-overlay :show="loading">
                <div class="card mt-3">
                  <div class="card-body">
                     <table class="table table-sm table-bordered">
                    <tr>
                      <th style="width: 20%;"> {{ $t('allocation_dc_office.bank_challan') }}</th>
                      <td style="width: 40%;">{{deliverItem.payment.bank_chalan}}</td>
                      <th style="width: 20%;">{{ $t('allocation_dc_office.payment_date') }}</th>
                      <td style="width: 20%;">{{deliverItem.payment.payment_date | dateFormat}}</td>
                    </tr>
                      <tr>
                      <th>{{ $t('allocation_dc_office.bank_name') }}</th>
                      <td colspan="3">{{deliverItem.payment.bank_name}}</td>
                     </tr>
                      <tr>
                      <th>{{ $t('allocation_dc_office.branch_name') }}</th>
                      <td colspan="3">{{deliverItem.payment.branch_name}}</td>
                    </tr>
                      <tr>
                      <th>{{ $t('globalTrans.attachment') }}</th>
                      <td colspan="3">
                        <a v-if="deliverItem.payment.attachment" target="_blank" class="btn btn-primary mr-2" :href="licenseRegistrationServiceBaseUrl+'download-attachment?file=storage'+deliverItem.payment.attachment" title="Attachment">{{$t('globalTrans.download')}}</a>
                      </td>
                    </tr>
                  </table>
                     <b-button v-if="deliverItem.is_paid == 1" variant="success" class="mr-1 mt-3" @click="saveData(deliverItem.payment.id)">{{ $t('allocation_dc_office.do_receive') }}</b-button>
                    <b-alert v-if="deliverItem.is_paid == 2" show variant="success">{{$i18n.locale == 'bn'? 'পেমেন্ট ইতিমধ্যে অনুমোদিত' : 'Payment already approved'}}</b-alert>
                  </div>
                </div>
                 </b-overlay>
              </b-tab>
            </span>
          </b-tabs>
        </div>
        <div class="row mt-3">
          <div class="col-md-12 text-right">
            <b-button variant="danger" class="mr-1 mt-3" @click="$bvModal.hide('challan-payment')">{{ $t('globalTrans.cancel') }}</b-button>
          </div>
        </div>
      </b-col>
    </b-overlay>
  </b-container>
</template>
<script>
  import RestApi, { licenseRegistrationServiceBaseUrl } from '@/config/api_config'
import ChallanView from './ChallanView.vue'
  import { paymentConfirm } from '../../api/routes'
export default {
  name: 'Challan',
  props: ['item'],
  components: {
    ChallanView
  },
   data () {
    return {
      licenseRegistrationServiceBaseUrl: licenseRegistrationServiceBaseUrl,
        loadHistory: false,
        loading: false,
        history: [],
        receipt: {}
    }
  },
  created () {
  },
  methods: {
    saveData (id) {
      this.$swal({
        title: this.$t('globalTrans.approveConfirmMsg'),
        showCancelButton: true,
        confirmButtonText: this.$t('globalTrans.yes'),
        cancelButtonText: this.$t('globalTrans.no'),
        focusConfirm: false
      }).then((resultSwal) => {
        if (resultSwal.isConfirmed) {
         this.saveUpdate(id)
        }
      })
    },
    async saveUpdate (id) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      this.loading = true
      let result = null
      const loadingState = { loading: false, listReload: false }
      result = await RestApi.postData(licenseRegistrationServiceBaseUrl, paymentConfirm, {
        pay_id: id
      })
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)
      if (result.success) {
        this.loading = false
        this.$store.dispatch('LicenseRegistrationService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: this.$t('globalTrans.success'),
          message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })
        this.$bvModal.hide('challan-payment')
      } else {
        this.loading = false
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
  }
}
</script>
