<template>
  <div>
    <div class="row justify-content-center mt-2">
      <div class="col-md-4">
          <div class="card overflow-hidden">
              <div class="card-header">
                  <div class="avatar-md profile-user-wid">
                      <span class="avatar-title rounded-circle bg-light">
                           <img class="img-fluid d-block mx-auto" width="70" src="@/assets/images/logo.png" alt="">
                      </span>
                  </div>
              </div>
              <div class="card-body">
                  <b-overlay :show="loading">
                    <br/>
                    <div class="p-2">
                      <b-alert :show="errorAlert" variant="" style="padding:5px" dismissible fade class="alert alert-danger">
                        <div class="iq-alert-icon">
                          <i class="ri-information-line"></i>
                        </div>
                        <div class="iq-alert-text">{{ errorMsg }}</div>
                      </b-alert>
                      <p class="text-center alert alert-success font-weight-bold" style="font-size:12px; font-size: 12px; padding: 4px;margin-bottom: -8px;" v-if="warnAlert" >OTP sent in your phone whose validity is 3 minutes!</p>
                      <br/>
                      <ValidationObserver ref="form"  v-slot="{ handleSubmit, reset }">
                        <b-form @submit.prevent="handleSubmit(otpVerifySubmit)" @reset.prevent="reset" autocomplete="off">
                          <ValidationProvider name="OTP" vid="otp_code" rules="required|min:3">
                            <b-form-group style="margin-bottom:0px"
                              class="row"
                              label-cols-sm="12"
                              label-for="otp_code"
                              slot-scope="{ valid, errors }"
                            >
                              <b-form-input
                                id="otp_code"
                                v-model="otpData.otp_code"
                                placeholder="Enter OTP"
                                :state="errors[0] ? false : (valid ? true : null)"
                                ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                          <a href="#" @click="resendCode()" style="margin-top:0px;font-size:12px" class="text-primary">Resend code</a>
                            <br/>
                            <br/>
                            <div class="row">
                                <div class="col-md-6 offset-md-3 text-center">
                                  <button class="btn btn-primary btn-block" type="submit">{{ $t('globalTrans.verify') }}</button>
                                </div>
                            </div>
                            <div class="mt-4 text-center">
                                <router-link to="/auth/login">{{ $t('globalTrans.back_to_login') }}</router-link>
                            </div>
                        </b-form>
                      </ValidationObserver>
                    </div>
                  </b-overlay>
              </div>
          </div>
      </div>
    </div>
  </div>
</template>

<script>
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { otpVerify, resendOtp } from '../api/routes'
import { ValidationObserver, ValidationProvider } from 'vee-validate'

export default {
  components: { ValidationObserver, ValidationProvider },
  data: () => ({
    loading: false,
    defaultValue: '',
    otpData: {
      otp_code: '',
      id: ''
    },
    warnAlert: true,
    errorAlert: false,
    errorMsg: ''
  }),
  created () {
    this.otpData.id = this.$route.params.id
  },
  methods: {
    async otpVerifySubmit () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, otpVerify, this.otpData)
        if (result.success) {
          const notification = result.notification
          this.$router.push('/auth/sign-up-success')
          this.$socket.emit('send-notification', notification)
        } else {
          if (result.message) {
            this.errorAlert = true
            this.errorMsg = result.message
          } else {
            this.errorAlert = false
            this.$refs.form.setErrors(result.errors)
          }
        }
      } catch (error) {
        if (error) {
          //
        }
        this.errorAlert = true
        this.errorMsg = 'Failed to verify. Please, try again.'
      }

      this.loading = false
    },
    async resendCode () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, resendOtp, this.otpData)
        if (result.success === true) {
          this.errorAlert = false
          this.warnAlert = true
        } else {
          if (result.message) {
            this.errorAlert = true
            this.warnAlert = false
            this.errorMsg = result.message
          }
        }
      } catch (error) {
        if (error) {
          //
        }
        this.errorAlert = true
        this.warnAlert = false
        this.errorMsg = 'Failed to resend code. Please, try again.'
      }
      this.loading = false
    }
  }
}
</script>

<style scoped>
        .card{border: 0px!important;}
        .card-header{background-color: #c7cef8 !important; border-bottom: 0px!important;}
        .btn-custom{background-color: #596DE1; color: #fff;}
</style>
