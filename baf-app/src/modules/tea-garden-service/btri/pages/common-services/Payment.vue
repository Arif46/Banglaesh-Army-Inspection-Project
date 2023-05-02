<template>
  <div>
    <card>
      <template v-slot:searchHeaderTitle>
        <h4 class="card-title">{{ $t('teaGardenBtriService.payment_for') }}
          <span v-if="data.service">{{ currentLocale === 'en' ? data.service.service_name_en: data.service.service_name_bn }}</span>
        </h4>
      </template>
      <template v-slot:searchBody>
      <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
          <b-overlay :show="loading">
          <b-form @submit.prevent="handleSubmit(paymentSubmit)" @reset.prevent="reset" autocomplete="off">
              <!-- custom design -->
            <div class="d-flex justify-content-center">
              <b-card class="payment-wrapper">
                <p>{{ $t('teaGardenBtriService.payment_option') }}</p>
                <div class="pay-options">
                  <input type="radio" v-model="payment_info.payment_type" :value="1" name="select" v-if="paymentTypeList[0].text_en === 'Cash'" id="cash" :checked="paymentTypeList[0].text_en === 'Cash' ? true : false">
                  <input type="radio" v-model="payment_info.payment_type" :value="2" name="select" v-if="paymentTypeList[0].text_en === 'Bank' || paymentTypeList[1].text_en === 'Bank'" id="bank" :checked="paymentTypeList[0].text_en === 'Bank' ? true : false">
                  <input type="radio" v-model="payment_info.payment_type" :value="3" name="select" id="ekpay" v-if="paymentTypeList[1].text_en === 'ekPay'">
                  <label for="cash" class="option cash" v-if="paymentTypeList[0].text_en === 'Cash'">
                    <div class="dot"></div>
                    <span>{{ currentLocale === 'en' ? paymentTypeList[0].text_en : paymentTypeList[0].text_bn }}</span>
                  </label>
                  <label for="bank" class="option bank" v-if="paymentTypeList[0].text_en === 'Bank' || paymentTypeList[1].text_en === 'Bank'">
                    <div class="dot"></div>
                    <span v-if="paymentTypeList[0].text_en === 'Bank'">{{ currentLocale === 'en' ? paymentTypeList[0].text_en : paymentTypeList[0].text_bn }}</span>
                    <span v-if="paymentTypeList[1].text_en === 'Bank'">{{ currentLocale === 'en' ? paymentTypeList[1].text_en : paymentTypeList[1].text_bn }}</span>
                  </label>
                  <label for="ekpay" class="option ekpay" v-if="paymentTypeList[1].text_en === 'ekPay'">
                    <div class="dot"></div>
                    <span>{{ currentLocale === 'en' ? paymentTypeList[1].text_en : paymentTypeList[1].text_bn }}</span>
                  </label>
                </div>
                <div class="payment-info-boxs">
                  <b-row>
                    <!-- bank name  -->
                    <b-col sm="6" v-if="payment_info.payment_type === 2">
                      <ValidationProvider name="Bank Name" vid="bank_id" rules="required|min_value:1">
                        <b-form-group slot-scope="{ valid, errors }" label-for="bank_id">
                          <template v-slot:label>
                            {{ $t('teaGardenBtriService.bank_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select plain v-model="payment_info.bank_id" :options="bankList" id="bank_name"
                            :state="errors[0] ? false : (valid ? true : null)">
                            <template v-slot:first>
                              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <!-- branch name  -->
                    <b-col sm="6" v-if="payment_info.payment_type === 2">
                      <ValidationProvider name="Branch Name" vid="branch_id" rules="required|min_value:1">
                        <b-form-group slot-scope="{ valid, errors }" label-for="branch_id">
                          <template v-slot:label>
                            {{ $t('teaGardenBtriService.branch_name') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-select plain v-model="payment_info.branch_id" :options="branchList" id="bank_name"
                            :state="errors[0] ? false : (valid ? true : null)">
                            <template v-slot:first>
                              <b-form-select-option :value="0">{{$t('globalTrans.select')}}</b-form-select-option>
                            </template>
                          </b-form-select>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <b-row>
                    <!-- check_no -->
                    <b-col sm="6" v-if="payment_info.payment_type === 2">
                      <ValidationProvider name="Check/ DD/ Chalan No" vid="check_no" rules="required">
                        <b-form-group slot-scope="{ valid, errors }" label-for="check_no">
                          <template v-slot:label>
                            {{ $t('teaGardenBtriService.check_no') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input type="text" v-model="payment_info.check_no"
                            :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <!-- receipt number  -->
                    <b-col sm="6" v-if="payment_info.payment_type === 1">
                      <ValidationProvider name="Receipt No." vid="received_number" rules="required">
                        <b-form-group slot-scope="{ valid, errors }" label-for="received_number">
                          <template v-slot:label>
                            {{ $t('teaGardenBtriService.receipt') }} <span class="text-danger">*</span>
                          </template>
                          <b-form-input type="number" :min="0" v-model="payment_info.received_number"
                            :state="errors[0] ? false : (valid ? true : null)"></b-form-input>
                          <div class="invalid-feedback">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                    <!-- date  -->
                    <b-col sm="6" v-if="payment_info.payment_type === 1 || payment_info.payment_type === 2">
                      <ValidationProvider name="Date" vid="date" rules="required">
                        <b-form-group class="row" label-for="date" slot-scope="{ valid, errors }">
                          <template v-slot:label>
                            {{ $t('teaGardenBtriService.date') }} <span class="text-danger">*</span>
                          </template>
                          <date-picker id="date" v-model="payment_info.date" class="form-control"
                            :placeholder="$t('globalTrans.select_date')"
                            :state="errors[0] ? false : (valid ? true : null)"
                            :class="errors[0] ? 'is-invalid' : ''"
                            :config="config"
                            :locale="currentLocale">
                          </date-picker>
                          <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <b-row>
                    <!-- attachment  -->
                    <b-col cols="12" v-if="payment_info.payment_type === 1 || payment_info.payment_type === 2">
                      <ValidationProvider name="Attachment" vid="attachment" rules="required">
                        <b-form-group slot-scope="{ valid, errors }" label-for="attachment">
                          <template v-slot:label>
                            <span v-if="payment_info.payment_type === 1">{{ $t('teaGardenBtriService.upload_receipt') }}</span>
                            <span v-if="payment_info.payment_type === 2">{{ $t('teaGardenBtriService.attachment') }}</span>
                            <span class="text-danger">*</span>
                          </template>
                          <div class="d-flex">
                            <b-form-file accept="application/pdf,image/*" id="attachment" v-model="payment_info.attachment"
                              @change="onChange" :state="errors[0] ? false : (valid ? true : null)"
                              :placeholder="$t('globalTrans.attachment_placeholder')"
                              :drop-placeholder="$t('globalTrans.attachment_drop_placeholder')"></b-form-file>
                          </div>
                          <div class="invalid-feedback d-block">
                            {{ errors[0] }}
                          </div>
                        </b-form-group>
                      </ValidationProvider>
                    </b-col>
                  </b-row>
                  <b-row>
                    <b-col cols="12">
                      <wizard-button type="submit" class="btn btn-success ml-1 mr-1" title="Submit">
                        <i class="ri-secure-payment-line"></i>
                        <span v-if="payment_info.payment_type === 1 || payment_info.payment_type === 2">
                          {{$t('globalTrans.submit')}}</span>
                        <span v-if="payment_info.payment_type === 3"> {{$t('teaGardenBtriService.online_payment')}}</span>
                      </wizard-button>
                      <!-- cancel button  -->
                        <router-link :to="{name: $route.query.from}" v-if="$route.query.from" class="btn btn-danger ml-1 mr-1 text-white"><i
                            class="ri-close-circle-line"></i> {{ $t('globalTrans.cancel') }}
                        </router-link>
                    </b-col>
                  </b-row>
                </div>
              </b-card>
              <div class="ml-4">
                <b-card>
                  <table class="payment-info">
                    <tbody>
                      <tr>
                        <td><p>{{ $t('teaGardenBtriService.total_packets') }}:</p></td>
                        <td><span> {{ $n(data.total_packets) }}</span></td>
                      </tr>
                      <tr>
                        <td><p>{{ $t('teaGardenBtriService.total_samples') }}:</p></td>
                        <td><span> {{ $n(data.total_samples) }}</span></td>
                      </tr>
                      <tr>
                        <td><p>{{ $t('teaGardenBtriService.amount') }}:</p></td>
                        <td><span> {{ $n(data.amount) }}</span></td>
                      </tr>
                      <tr>
                        <td><p>{{ $t('teaGardenBtriService.total_amount') }}:</p></td>
                        <td><span> {{ $n(data.total_amount) }}</span></td>
                      </tr>
                    </tbody>
                  </table>
                </b-card>
              </div>
            </div>
          </b-form>
      </b-overlay>
      </ValidationObserver>
      </template>
    </card>
  </div>
</template>
<script>
  import RestApi, { teaGardenServiceBaseUrl } from '@/config/api_config'
  import { ValidationObserver, ValidationProvider } from 'vee-validate'
  import { applicationPaymentOffline, applicationPaymentOnline, applicationDetails } from '../../api/routes'
  import teaGardenService from '@/mixins/tea-garden-service'
  import WizardButton from 'vue-form-wizard/src/components/WizardButton.vue'
  export default {
    mixins: [teaGardenService],
    name: 'Form',
    props: ['item'],
      components: {
          ValidationProvider,
          ValidationObserver,
          WizardButton
      },
    data () {
      return {
        valid: null,
        saveBtnName: this.$route.query.id ? this.$t('globalTrans.update') : this.$t('globalTrans.save'),
        errors: [],
        circularLoading: false,
        config: { static: true },
        data: {},
        payment_info: {
            payment_type: 0,
            attachment: '',
            bank_id: 0,
            branch_id: 0
        },
        branchList: [],
        isGardenAdmin: false,
        loading: false
      }
    },
    created () {
      if (this.$route.params.id) {
        this.loading = true
        const tmp = this.getData(this.$route.params.id)
        this.data = tmp
      }
      if (this.isGardenAdminCheckGardenId()) {
        this.isGardenAdmin = true
      }
    },
    computed: {
      currentLocale () {
          return this.$i18n.locale
      },
      paymentTypeList: function () {
        if (this.isGardenAdmin) {
            return this.$store.state.TeaGardenService.commonObj.btriPaymentType.filter(item => item.value !== 1)
        } else {
            return this.$store.state.TeaGardenService.commonObj.btriPaymentType.filter(item => item.value !== 3)
        }
      },
      valleyList: function () {
        return this.$store.state.TeaGardenService.commonObj.masterValleyList
      },
      bankList: function () {
        return this.$store.state.CommonService.commonObj.bankList
      }
    },
    methods: {
      async getData (id) {
          let result = null
          result = await RestApi.getData(teaGardenServiceBaseUrl, `${applicationDetails}/${id}`)
          this.data = result.data
          this.payment_info.payment_type = this.paymentTypeList[0].value
          this.loading = false
      },
      async paymentSubmit () {
        // for online payment
        if (this.payment_info.payment_type === 3) {
          this.onlinePayment()
        } else {
          // offline payment
          this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          this.loading = true
          const loadingState = { loading: false, listReload: false }
          result = await RestApi.postData(teaGardenServiceBaseUrl, applicationPaymentOffline + '/' + this.$route.params.id, this.payment_info)
          loadingState.listReload = true
          this.loading = false
          if (result.exist) {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('teaGardenConfig.existErrorMsg'),
                color: '#ee5253'
            })
            return false
          }
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
            this.$toast.success({
              title: 'Success',
              message: this.$t('teaGardenBtriService.payment_message'),
              color: '#D6E09B'
            })
              this.$router.push({ name: 'tea_garden_service.btri.test_services' })
          } else {
            this.$refs.form.setErrors(result.errors)
          }
        }
      },
      async onlinePayment () {
        let tmpPay = {}
        const name = this.$store.state.Auth.authUser.name
        const email = this.$store.state.Auth.authUser.email
        tmpPay = Object.assign(this.payment_info, { applicant_name: name, email: email })
        this.$store.dispatch('mutateCommonProperties', { loading: true })
          let result = null
          this.loading = true
          const loadingState = { loading: false, listReload: false }
          result = await RestApi.postData(teaGardenServiceBaseUrl, applicationPaymentOnline + '/' + this.$route.params.id, tmpPay)
          loadingState.listReload = true
          this.loading = false
          if (result.exist) {
            this.$toast.error({
                title: this.$t('globalTrans.error'),
                message: this.$t('teaGardenConfig.existErrorMsg'),
                color: '#ee5253'
            })
            return false
          }
          this.$store.dispatch('mutateCommonProperties', loadingState)
          if (result.success) {
            this.$store.dispatch('TeaGardenService/mutateCommonObj', { hasDropdownLoaded: false })
            // this.$toast.success({
            //   title: 'Success',
            //   message: this.$t('teaGardenBtriService.payment_message'),
            //   color: '#D6E09B'
            // })
            if (result.success === 2) {
              this.$router.push({ name: 'tea_garden_service.btri.test_services' })
              this.$toast.success({
                title: 'Success',
                message: this.$t('teaGardenBtriService.payment_message')
              })
            } else {
              window.location = result.url
            }
          } else {
            this.$refs.form.setErrors(result.errors)
          }
      },
      onChange (event) {
        const input = event.target
        if (input.files && input.files[0]) {
            const reader = new FileReader()
            reader.onload = (e) => {
                this.payment_info.attachment = e.target.result
            }
            reader.readAsDataURL(input.files[0])
        } else {
            this.payment_info.attachment = ''
        }
      },
      getBranchList (bankId) {
        this.branchList = this.$store.state.CommonService.commonObj.branchList.filter(item => (item.bank_id === bankId))
      }
    },
    watch: {
      'payment_info.payment_type': function (newVal, oldVal) {
          if (newVal === 1) {
            this.payment_info.bank_name = ''
            this.payment_info.branch_name = ''
            this.payment_info.check_no = ''
            this.payment_info.attachment = ''
          } else if (newVal === 2) {
            this.payment_info.received_number = ''
            this.payment_info.attachment = ''
          } else if (newVal === 3) {
            this.payment_info.bank_name = ''
            this.payment_info.branch_name = ''
            this.payment_info.check_no = ''
            this.payment_info.received_number = ''
            this.payment_info.attachment = ''
          }
      },
      'payment_info.bank_id': function (newVal, oldVal) {
        if (newVal !== 0) {
          this.payment_info.branch_id = 0
          this.getBranchList(newVal)
        } else {
          this.branchList = []
        }
      },
      currentLocale: function () { }
    }
  }
  </script>
<style scoped>
.p_heading{
      font-weight: bold;
    }

.payment-wrapper {
  background: #fff;
  width: 500px;
  border-radius: 5px;
  padding: 20px 15px;
  box-shadow: 5px 5px 30px rgba(0, 0, 0, 0.2);
}
.pay-options {
  display: inline-flex;
  height: 40px;
  width: 100%;
  align-items: center;
  justify-content: space-evenly;
}

.pay-options .option {
  background: #fff;
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
  justify-content: flex-start;
  cursor: pointer;
  padding: 0 10px;
  border: 1px solid lightgrey;
  transition: all 0.3s ease;
}

.pay-options .option .dot {
  height: 20px;
  width: 20px;
  margin-right: 1rem;
  background: #d9d9d9;
  border-radius: 50%;
  position: relative;
}

.pay-options .option .dot::before {
  position: absolute;
  content: "";
  top: 4px;
  left: 4px;
  width: 12px;
  height: 12px;
  background: #0069d9;
  border-radius: 50%;
  opacity: 0;
  transform: scale(1.5);
  transition: all 0.3s ease;
}

input[type="radio"] {
  display: none;
}

#cash:checked:checked~.cash,
#bank:checked:checked~.bank,
#ekpay:checked:checked~.ekpay {
  border-color: #0069d9;
  background: #0069d9;
}

#cash:checked:checked~.cash .dot,
#bank:checked:checked~.bank .dot,
#ekpay:checked:checked~.ekpay .dot {
  background: #fff;
}

#cash:checked:checked~.cash .dot::before,
#bank:checked:checked~.bank .dot::before,
#ekpay:checked:checked~.ekpay .dot::before {
  opacity: 1;
  transform: scale(1);
}

.pay-options .option span {
  font-size: 20px;
  color: #808080;
}

#cash:checked:checked~.cash span,
#bank:checked:checked~.bank span,
#ekpay:checked:checked~.ekpay span {
  color: #fff;
}
.payment-info-boxs {
  margin-top: 1.5rem;
}
.payment-info tr{
  border-bottom: 1px solid lightgrey;
}
.payment-info td{
  padding: .4rem;
}
.payment-info tr:last-child{
  border-bottom: none;
}
.payment-info tr td:last-child{
  font-weight: 700;
  padding-left: 1rem;
}
</style>
