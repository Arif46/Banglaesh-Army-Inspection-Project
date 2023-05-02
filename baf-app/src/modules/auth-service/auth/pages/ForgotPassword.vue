<template>
   <b-container fluid class="px-0">
     <b-row align-v="center" no-gutters>
        <b-col cols="12" class="bg-secondary">
            <div class="signup-wrapper forgot-wrapper mc-signup-bg">
              <b-overlay :show="loading">
                <b-card>
                  <img class="img-fluid d-block mx-auto" width="70" src="@/assets/images/logo.png" alt="">
                  <h6 class="text-center mt-2 mb-3 text-light">{{ $t('globalTrans.moc') }}</h6>
                  <div class="text-center"><LangButton /></div>
                  <hr style="border-color: #fff">
                  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(sendOtp)" @reset.prevent="reset" autocomplete="off">
                      <div style="width: 75%;margin: auto;">
                        <b-alert :show="errorAlert" variant="danger" dismissible fade class="p-2 mt-3 d-flex">
                            <div class="iq-alert-icon mr-2">
                              <i class="ri-information-line"></i>
                            </div>
                            <div class="iq-alert-text">{{ errorMsg }}</div>
                        </b-alert>
                        <b-row class="justify-content-center">
                          <b-col sm="12">
                            <ValidationProvider name="Mobile Number or Email" vid="mobile" rules="required|max:100" v-slot="{ errors }">
                              <b-form-group
                                label="Mobile No"
                                label-for="mobile"
                              >
                              <template v-slot:label>
                                {{ $t('forgot_password.mobile_or_email') }} <span class="text-danger">*</span>
                              </template>
                                <b-form-input
                                  id="mobile"
                                  v-model="formData.mobile_or_email"
                                  autocomplete="off"
                                  :state="errors[0] ? false : (valid ? true : null)"
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
                      <b-button block type="submit" class="login-btn btn-sm w-50" variant="success">{{ $t('forgot_password.sendPasswordResetCode') }}</b-button>
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
import { forgotPasswordOtpSendApi } from '../api/routes'
import LangButton from '@/components/LangButton.vue'
export default {
  components: {
    LangButton
  },
  data () {
    return {
      valid: null,
      loading: false,
      errors: [],
      formData: {
        mobile_or_email: ''
      },
      errorAlert: false,
      errorMsg: ''
    }
  },
  methods: {
    async sendOtp () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, forgotPasswordOtpSendApi, this.formData)
        if (result.success) {
          this.$router.push({ name: 'auth.forgot_password.otp_verification', params: { mobileOrEmail: this.formData.mobile_or_email } })
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
        this.errorMsg = this.$t('forgot_password.otpSendingerror')
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
