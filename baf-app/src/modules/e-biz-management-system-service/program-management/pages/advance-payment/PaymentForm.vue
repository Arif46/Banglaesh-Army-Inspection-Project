<template>
<b-container fluid>
    <b-row>
      <b-overlay :show="loading">
      <ValidationObserver ref="mainForm" v-slot="{ handleSubmit, reset }">
        <b-form @submit.prevent="handleSubmit(saveData)" @reset.prevent="reset" autocomplete="off"  enctype="multipart/form-data">
               <!-- -----------------Start--------------------- -->
      <b-card>
        <template>
         <h4 class="card-title">{{ $t('associationPnl.advanced_payment') }} {{ $t('associationPnl.schedule') }}</h4>
        </template>
        <!-- <hr> -->
        <b-row>
          <b-col xs="12" sm="12" md="12">
          <!-- Budget Details Start -->
          <div class="table-wrapper table-responsive">
                <table class="table table-striped table-hover table-bordered">
                    <thead>
                      <tr class="bg-primary">
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.schedule_no') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.pay_date') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount_percent') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('associationPnl.amount') }}</div></th>
                          <th scope="col" class="text-center"><div>{{ $t('globalTrans.action') }}</div></th>
                      </tr>
                    </thead>
                    <tbody>
                        <template v-if="items.adv_payments && items.adv_payments.length > 0">
                            <tr v-for="(item, index) in items.adv_payments" :key="index">
                                <td  class="text-center">{{ $n(index+1) }}</td>
                                <td class="text-center">{{ item.pay_date | dateFormat }}</td>
                                <td class="text-center">{{ $n(item.amt_percent) }}</td>
                                <td class="text-right">{{ $n(item.amount) }}</td>
                                <td class="text-center">
                                  <button v-if="item.status === 1" type="button" :class="`btn btn-sm ${item.is_color == true ? 'btn-warning' : 'btn-success'}`" @click="pay(item)">{{$t('eBizProgram.pay')}}</button>
                                </td>
                            </tr>
                        </template>
                        <template v-else>
                            <tr>
                                <td colspan="5" align="center">{{ $t('globalTrans.noDataFound') }}</td>
                            </tr>
                        </template>
                    </tbody>
              </table>
          </div>
          <!-- Budget Details End -->
          </b-col>
        </b-row>
      </b-card>
      <b-row>
        <template class="mt-3">
         <h4 class="card-title mt-4">{{ $t('eBizProgram.payment_details') }}</h4>
        </template>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
          <ValidationProvider name="Bank Name" vid="bank_name" v-slot="{ errors }" rules="required">
            <b-form-group
              label-for="bank_name"
            >
              <template v-slot:label>
                {{ $t('eBizProgram.bank_name') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                  id="bank_name"
                  type="text"
                  v-model="formData.bank_name"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                  {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
          <ValidationProvider name="Branch Name" vid="branch_name" v-slot="{ errors }" rules="required">
            <b-form-group
              label-for="branch_name"
            >
              <template v-slot:label>
                {{ $t('eBizProgram.branch_name') }} <span class="text-danger">*</span>
              </template>
              <b-form-input
                  id="branch_name"
                  type="text"
                  v-model="formData.branch_name"
                  :state="errors[0] ? false : (valid ? true : null)"
              ></b-form-input>
              <div class="invalid-feedback">
                  {{ errors[0] }}
              </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="4" lg="4" xl="4">
            <ValidationProvider name="Cheque No" vid="cheque_no" v-slot="{ errors }" rules="required">
                <b-form-group
                  label-for="cheque_no"
                >
                  <template v-slot:label>
                    {{ $t('eBizProgram.cheque_no') }} <span class="text-danger">*</span>
                  </template>
                  <b-form-input
                      id="cheque_no"
                      type="text"
                      v-model="formData.cheque_no"
                      :state="errors[0] ? false : (valid ? true : null)"
                  ></b-form-input>
                  <div class="invalid-feedback">
                      {{ errors[0] }}
                  </div>
                </b-form-group>
              </ValidationProvider>
          </b-col>
          <b-col xs="12" sm="12" md="6">
                <ValidationProvider name="Amount" vid="amount" rules="required" v-slot="{ errors }">
                    <b-form-group
                      label-for="amount">
                      <template v-slot:label>
                        {{ $t('associationPnl.amount') }}
                      </template>
                      <b-form-input
                        id="amount"
                        v-model="formData.amount"
                        :state="errors[0] ? false : (valid ? true : null)"
                        disabled
                      ></b-form-input>
                      <div class="invalid-feedback">
                        {{ errors[0] }}
                      </div>
                    </b-form-group>
                  </ValidationProvider>
              </b-col>
      </b-row>
      <!-- -----------------End----------------------- -->
        <b-row>
          <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Remark" vid="remarks" v-slot="{ errors }" rules="">
              <b-form-group
                label-for="remarks">
                <template v-slot:label>
                  {{ $t('globalTrans.remark') }}
                </template>
                <b-form-textarea
                    id="remarks"
                    rows="3"
                    v-model="formData.remarks"
                    :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-textarea>
                <div class="invalid-feedback">
                  {{ errors[0] }}
                </div>
              </b-form-group>
            </ValidationProvider>
          </b-col>
         <b-col xs="12" sm="12" md="6">
            <ValidationProvider name="Attachment" vid="attachment" rules="required">
                <b-form-group
                    label-for="attachment"
                    slot-scope="{ valid, errors }"
                    >
                    <template v-slot:label>
                    {{ $t('globalTrans.attachment') }} <span class="text-danger">*</span>
                    </template>
                <b-form-file id="attachment"
                v-model="formData.file"
                v-on:change="onFileChange"
                accept=".doc,.docx,.pdf"
                class="mt-2" plain
                :state="errors[0] ? false : (valid ? true : null)"
                ></b-form-file>
                    <div class="invalid-feedback">
                    {{ errors[0] }}
                    </div>
                </b-form-group>
            </ValidationProvider>
            </b-col>
        </b-row>
        <!-- </b-overlay> -->
        </b-form>
    </ValidationObserver>
        <b-row class="text-right">
            <b-col>
                <b-button type="submit" variant="success" @click="saveData" class="mr-2 btn-sm">{{ saveBtnName }}</b-button>
                <b-button variant="danger" class="btn-sm" @click="$bvModal.hide('payment')">{{ $t('globalTrans.cancel') }}</b-button>
            </b-col>
        </b-row>
    </b-overlay>
    </b-row>
  </b-container>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { payAdvance } from '../../api/routes'
export default {
  name: 'PaymentForm',
  props: ['items'],
  data () {
    return {
      valid: null,
      saveBtnName: this.$t('eBizProgram.pay_advance'),
      eBizServiceBaseUrl: eBizServiceBaseUrl,
      errors: [],
      formData: {
        id: 0,
        attachment: '',
        file: [],
        remarks: '',
        bank_name: '',
        cheque_no: '',
        amount: '',
        payment_id: 0,
        branch_name: ''
      },
      bankList: [],
      toggle: false
    }
  },
  created () {
    if (this.items.id) {
      const tmp = this.getFeeEntry()
      // this.formData = tmp
      this.formData.id = tmp.id
      this.bankList = this.getBank()
      this.items.adv_payments.map(item => {
          item.is_color = false
      })
    }
  },
  computed: {
    loading: function () {
      return this.$store.state.commonObj.loading
    },
    councilInfoList () {
      return this.$store.state.EBizManagementSystemService.commonObj.councilInfoList.filter(item => item.status === 1)
    }
  },
  watch: {
  },
  methods: {
    pay (item) {
        this.formData.amount = this.$n(item.amount)
        this.formData.payment_id = item.id
        item.is_color = true
        this.items.adv_payments.filter(payment => payment.id !== item.id).map(payment => {
            payment.is_color = false
        })
    },
    getBank () {
      return this.$store.state.CommonService.commonObj.bankList.filter(item => item.status === 1).map(itemObj => {
        if (this.$i18n.locale === 'bn') {
          return { value: itemObj.value, text: itemObj.text_bn }
        } else {
          return { value: itemObj.value, text: itemObj.text_en }
        }
      })
    },
     onFileChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
          const reader = new FileReader()
          reader.onload = (e) => {
            this.formData.attachment = e.target.result
          }
          reader.readAsDataURL(input.files[0])
        } else {
          this.formData.attachment = ''
        }
    },
    async saveData () {
      const isValid = await this.$refs.mainForm.validate()
      if (isValid) {
      this.$store.dispatch('mutateCommonProperties', { loading: true })
      let result = null
      const loadingState = { loading: false, listReload: false }
      if (this.items.id) {
        result = await RestApi.putData(eBizServiceBaseUrl, `${payAdvance}/${this.formData.payment_id}`, this.formData)
      }
      loadingState.listReload = true
      this.$store.dispatch('mutateCommonProperties', loadingState)

      if (result.success) {
        this.$store.dispatch('EBizManagementSystemService/mutateCommonObj', { hasDropdownLoaded: false })
        this.$toast.success({
          title: 'Success',
          message: this.items.id ? this.$t('globalTrans.update_msg') : this.$t('globalTrans.save_msg'),
          color: '#D6E09B'
        })

        this.$bvModal.hide('payment')
      } else {
        this.$refs.mainForm.setErrors(result.errors)
      }
    }
    },
    getFeeEntry () {
      const tmpData = this.$store.state.list.find(item => item.id === this.items.id)
      return JSON.parse(JSON.stringify(tmpData))
    }
  }
}
</script>
<style scoped>
.red {
  background-color: red;
}
</style>
