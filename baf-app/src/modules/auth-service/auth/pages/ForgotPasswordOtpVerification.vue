<template>
   <b-container fluid class="px-0">
     <b-row align-v="center" no-gutters>
        <b-col cols="12" class="bg-secondary">
            <div class="signup-wrapper mc-signup-bg">
              <b-overlay :show="loading">
                <b-card>
                  <img class="img-fluid d-block mx-auto" width="70" src="@/assets/images/logo.png" alt="">
                  <h6 class="text-center mt-2 mb-3 text-light">{{ $t('globalTrans.moc') }}</h6>
                  <div class="text-center"><LangButton /></div>
                  <hr style="border-color: #fff">
                  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(otpVerification)" @reset.prevent="reset" autocomplete="off">
                      <div style="width: 75%;margin: auto;">
                        <b-alert :show="errorAlert" variant="danger" dismissible fade class="p-2 mt-3 d-flex">
                            <div class="iq-alert-icon mr-2">
                              <i class="ri-information-line"></i>
                            </div>
                            <div class="iq-alert-text">{{ errorMsg }}</div>
                        </b-alert>
                        <p class="text-center alert alert-success mb-2" style="font-size: 12px;" v-if="warnAlert" >
                          {{ resendMsg === '' ? $t('forgot_password.otpInstruction') : resendMsg }}
                        </p>
                        <b-row class="justify-content-center">
                          <b-col sm="12">
                            <ValidationProvider name="Password Reset Code" vid="password_reset_code" rules="required|min:6|max:100" v-slot="{ errors }">
                              <b-form-group
                                label-for="password_reset_code"
                              >
                                <b-form-input
                                  id="mobile"
                                  v-model="formData.password_reset_code"
                                  autocomplete="off"
                                  :state="errors[0] ? false : (valid ? true : null)"
                                  placeholder="6 digits password reset code"
                                ></b-form-input>
                                <div class="invalid-feedback">
                                   <b-alert :show="errors[0] ? true : false" class="px-2 py-1" variant="danger" dismissible fade>
                                    <div class="iq-alert-text"><i class="ri-information-line"></i> {{ errors[0] }}</div>
                                  </b-alert>
                                </div>
                              </b-form-group>
                            </ValidationProvider>
                          </b-col>
                        </b-row>
                      </div>
                      <div class="d-flex w-75 m-auto">
                        <b-button block type="submit" class="login-btn btn-sm mr-2" variant="warning">{{ $t('globalTrans.verify') }}</b-button>
                        <b-button block type="button" @click="resendCode()" class="login-btn btn-sm" variant="primary">{{ $t('forgot_password.resend') }}</b-button>
                      </div>
                      <div class="text-center">
                        <router-link class="m-auto" to="/auth/login">{{ $t('globalTrans.back_to_login') }}</router-link>
                      </div>
                    </b-form>
                  </ValidationObserver>
                </b-card>
              </b-overlay>
            </div>
        </b-col>
   </b-row>
   </b-container>
</template>

<script>
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { forgotPasswordOtpVerifyApi, forgotPasswordOtpSendApi } from '../api/routes'
import LangButton from '@/components/LangButton.vue'
export default {
  components: {
    LangButton
  },
  props: ['mobileOrEmail'],
  data () {
    return {
      valid: null,
      loading: false,
      errors: [],
      formData: {
        id: '',
        password_reset_code: ''
      },
      errorAlert: false,
      errorMsg: '',
      resendMsg: '',
      warnAlert: true
    }
  },
  created () {
    this.formData.id = this.$route.params.id
  },
  methods: {
    async otpVerification () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, forgotPasswordOtpVerifyApi, this.formData)
        if (result.success) {
          this.$router.push({ name: 'auth.forgot_password.reset_password', params: { passwordResetCode: this.formData.password_reset_code } })
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
        this.errorMsg = this.$t('forgot_password.otpVerifyErrorMsg')
      }

      this.loading = false
    },
    async resendCode () {
      try {
        if (this.mobileOrEmail === undefined || this.mobileOrEmail === '') {
          this.$router.push('/auth/forgot-password/otp-sending')
        }
        this.loading = true
        this.formData.password_reset_code = ''
        const result = await RestApi.postData(authServiceBaseUrl, forgotPasswordOtpSendApi, { mobile_or_email: this.mobileOrEmail })
        if (result.success === true) {
          this.errorAlert = false
          this.warnAlert = true
          this.resendMsg = this.$t('forgot_password.resendMsg')
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
        this.errorMsg = this.$t('forgot_password.otpVerifyErrorMsg')
      }
      this.loading = false
    }
  }
}
</script>

<style>
.mc-signup-bg {
  background: url(../../../../assets/images/sidebar-bg.png);
  background-position: center;
  background-attachment: fixed;
}
</style>
