<template>
    <b-row>
        <b-col lg="12" sm="12">
            <b-overlay :show="loader">
                <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(saveUpdate)" @reset.prevent="reset" autocomplete="off">
                        <b-row>
                            <b-col lg="8" class="m-auto">
                                <b-table-simple bordered small>
                                    <b-tbody>
                                        <b-tr>
                                            <b-td class="text-right" colspan="4">{{ $t('globalTrans.total_payable_amount') + ' ' + $t('globalTrans.tk') }}</b-td>
                                            <b-td class="text-right">{{ $n(payment.grand_total, { minimumFractionDigits: 2 }) }}</b-td>
                                        </b-tr>
                                    </b-tbody>
                                </b-table-simple>
                            </b-col>
                        </b-row>
                        <b-row>
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider :name="$t('globalTrans.voucher_no', 'en')" vid="voucher_no" rules="required" v-slot="{ errors }">
                                    <b-form-group label-for="voucher_no" label-cols-sm="4">
                                        <template v-slot:label>
                                            {{$t('globalTrans.voucher_no')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-input
                                            plain
                                            v-model="payment.voucher_no"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        >
                                        </b-form-input>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider :name="$t('globalTrans.date', 'en')" vid="pay_date" rules="required" v-slot="{ errors }">
                                    <b-form-group class="row mb-2"
                                    label-cols-sm="4"
                                    label-for="pay_date"
                                    >
                                    <template v-slot:label>
                                        {{ $t('globalTrans.date') }} <span class="text-danger">*</span>
                                    </template>
                                    <date-picker
                                        class="form-control"
                                        id="pay_date"
                                        v-model="payment.pay_date"
                                        :placeholder="$t('globalTrans.select_date')"
                                        :state="errors[0] ? false : (valid ? true : null)"
                                        :config="{ static: true }"
                                    >
                                    </date-picker>
                                    <div class="invalid-feedback d-block">
                                        {{ errors[0] }}
                                    </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider :name="$t('externalUser.bank_name', 'en')" vid="bank_id" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group label-for="bank_id" label-cols-sm="4">
                                        <template v-slot:label>
                                            {{$t('externalUser.bank_name')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            v-model="payment.bank_id"
                                            :options="bankNameList"
                                            @change="getBranchList(payment.bank_id)"
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
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider :name="$t('externalUser.branch_name', 'en')" vid="branch_id" rules="required|min_value:1" v-slot="{ errors }">
                                    <b-form-group label-for="branch_id" label-cols-sm="4">
                                        <template v-slot:label>
                                            {{$t('externalUser.branch_name')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-select
                                            plain
                                            v-model="payment.branch_id"
                                            :options="branchNameList"
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
                            <b-col xs="12" sm="12" md="6" lg="6" xl="6">
                                <ValidationProvider :name="$t('globalTrans.voucher', 'en')" vid="attachment" rules="required" v-slot="{ errors }">
                                    <b-form-group class="row mb-2"
                                        label-cols-sm="4"
                                        label-for="attachment">
                                        <template v-slot:label>
                                            {{ $t('globalTrans.voucher')}} <span class="text-danger">*</span>
                                        </template>
                                        <b-form-file
                                            plain
                                            v-on:change="onFileChange($event)"
                                            v-model="attachment_input"
                                            accept=".jpg,.jpeg,.pdf"
                                            :state="errors[0] ? false : (valid ? true : null)"
                                        ></b-form-file>
                                        <div class="invalid-feedback">
                                            {{ errors[0] }}
                                        </div>
                                        <div class="invalid-feedback d-block text-muted">
                                            {{ $i18n.locale == 'en' ? '[Maximum file size is 2 MB and file format is JPG/JPEG/PDF]' : '[সর্বোচ্চ ফাইল সাইজ 2 MB এবং ফাইল ফরমেট JPG/JPEG/PDF]' }}
                                        </div>
                                    </b-form-group>
                                </ValidationProvider>
                            </b-col>
                            <b-col xs="12" sm="12" md="12" lg="12" xl="12" class="text-right">
                                <b-button @click="back()" class="btn btn-warning btn-sm mr-2"><span><i class="ri-arrow-left-line"></i>{{ $t('globalTrans.back') }}</span></b-button>
                                <b-button type="button" @click="finalSave" variant="success" class="mr-2 btn-sm">{{ $t('globalTrans.payment') }}</b-button>
                                <b-button variant="danger" type="button" class="btn-sm" @click="$bvModal.hide('modal-payment')">{{ $t('globalTrans.cancel') }}</b-button>
                            </b-col>
                        </b-row>
                    </b-form>
                </ValidationObserver>
            </b-overlay>
        </b-col>
    </b-row>
</template>
<script>
import RestApi, { internationalTradeFairServiceBaseUrl } from '@/config/api_config'
import { paymentOfflineApi } from '../../../../api/routes'

export default {
  name: 'PaymentOffline',
  props: ['id', 'payment'],
  data () {
    return {
      baseUrl: internationalTradeFairServiceBaseUrl,
      valid: null,
      loader: false,
      errors: [],
      attachment_input: [],
      branchNameList: []
    }
  },
  created () {
      if (this.payment) {
          this.payment.bank_id = 0
          this.payment.branch_id = 0
      }
  },
  computed: {
    bankNameList () {
        return this.$store.state.CommonService.commonObj.bankNameList.filter(item => item.status === 1)
    },
    currentLocale () {
      return this.$i18n.locale
    }
  },
  methods: {
    getBranchList (Id) {
        this.branchNameList = this.$store.state.CommonService.commonObj.branchNameList.filter(item => item.bank_id === parseInt(Id))
    },
    back () {
        this.$emit('back')
    },
    onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
            this.payment.attachment = event.target.files[0]
        }
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
            this.payment.pay_type = 2
            const formData = new FormData()
            Object.keys(this.payment).map(key => {
                if (key === 'attachment') {
                    formData.append(key, this.attachment_input)
                } else {
                    formData.append(key, this.payment[key])
                }
            })

            if (this.id) {
                result = await RestApi.postData(internationalTradeFairServiceBaseUrl, paymentOfflineApi, formData)
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
                this.$bvModal.hide('modal-payment')
            } else {
                this.$refs.form.setErrors(result.errors)
            }
        }
    }
  }
}
</script>
