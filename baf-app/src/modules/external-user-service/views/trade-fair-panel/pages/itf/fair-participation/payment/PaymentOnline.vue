<template>
    <b-overlay :show="loader">
        <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
            <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                <b-row>
                    <b-col lg="8" class="m-auto">
                    <!-- <b-card> -->
                        <b-table-simple bordered small>
                            <b-tbody>
                                <b-tr>
                                    <b-td class="text-right" colspan="4">{{ $t('globalTrans.total_payable_amount') + ' ' + $t('globalTrans.tk') }}</b-td>
                                    <b-td class="text-right">{{ $n(payment.grand_total, { minimumFractionDigits: 2 }) }}</b-td>
                                </b-tr>
                            </b-tbody>
                        </b-table-simple>
                    <!-- </b-card> -->
                    </b-col>
                    <b-col class="text-right" lg="12">
                        <b-button @click="back()" class="btn btn-warning btn-sm mr-2"><span><i class="ri-arrow-left-line"></i>{{ $t('globalTrans.back') }}</span></b-button>
                        <b-button type="button" @click="finalSave()" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.payment') }}</b-button>
                        <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-payment')">{{ $t('globalTrans.cancel') }}</b-button>
                    </b-col>
                </b-row>
            </b-form>
        </ValidationObserver>
    </b-overlay>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { paymentOnlineApi } from '../../../../api/routes'

export default {
  name: 'PaymentOnline',
  props: ['id', 'payment'],
  data () {
    return {
      valid: null,
      loader: false,
      errors: []
    }
  },
  created () {
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    back () {
        this.$emit('back')
    },
    finalSave () {
        this.$swal({
            title: this.$t('globalTrans.surePrompt'),
            showCancelButton: true,
            confirmButtonText: this.$t('globalTrans.yes'),
            cancelButtonText: this.$t('globalTrans.no'),
            focusConfirm: false
        }).then((result) => {
            if (result.isConfirmed) {
                this.saveUpdate()
            }
        })
    },
    async saveUpdate () {
        var check = await this.$refs.form.validate()
        if (check) {
            this.$store.dispatch('mutateCommonProperties', { loading: true })
            let result = null
            this.loader = true
            const loadingState = { loading: false, listReload: false }
            this.payment.participation_id = this.id
            this.payment.pay_type = 1

            if (this.id) {
                result = await RestApi.postData(internationalTradeFairServiceBaseUrl, paymentOnlineApi, this.payment)
            }
            this.loader = false
            loadingState.listReload = true
            this.$store.dispatch('mutateCommonProperties', loadingState)
            if (result.success) {
                this.$store.dispatch('TradeFairService/mutateCommonObj', { hasDropdownLoaded: false })
                this.$toast.success({
                    title: this.$t('globalTrans.success'),
                    message: this.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
                    color: '#D6E09B'
                })
                window.location = result.url
                this.$bvModal.hide('modal-payment')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
        }
    }
  }
}
</script>
<style scoped>
  .blink_me {
    animation: blinker 2.5s linear infinite;
    color: red;
  }
  @keyframes blinker {
    50% {
      opacity: .09;
      /* background-color: green; */
    }
  }
</style>
