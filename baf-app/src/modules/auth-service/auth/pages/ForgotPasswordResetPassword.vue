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
                    <b-form @submit.prevent="handleSubmit(resetPassword)" @reset.prevent="reset" autocomplete="off">
                      <div style="width: 75%;margin: auto;">
                        <b-alert :show="errorAlert" variant="danger" dismissible fade class="p-2 mt-3 d-flex">
                            <div class="iq-alert-icon mr-2">
                              <i class="ri-information-line"></i>
                            </div>
                            <div class="iq-alert-text">{{ errorMsg }}</div>
                        </b-alert>
                        <b-row class="justify-content-center">
                          <b-col sm="12" md="12">
                              <ValidationProvider name="New Password" vid="new_password" rules="required|min:6" v-slot="{ errors }">
                                <b-form-group
                                  label-cols-sm="12"
                                  label-for="new_password"
                                >
                                <template v-slot:label>
                                  <span>{{$t('forgot_password.newPassword')}}</span> <span class="text-danger">*</span>
                                </template>
                                <b-input-group>
                                  <b-input-group-prepend class="mb-0" style="height: 30px !important;">
                                      <span class="input-group-text"><i class="ri-lock-fill"></i></span>
                                  </b-input-group-prepend>
                                  <b-form-input
                                    id="new_password"
                                    type="password"
                                    v-model="formData.new_password"
                                    :placeholder="$t('forgot_password.newPassword')"
                                    autocomplete="new-password"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      <b-alert :show="errors[0] ? true : false" class="px-2 py-1" variant="danger" dismissible fade>
                                        <div class="iq-alert-text"><i class="ri-information-line"></i> {{ errors[0] }}</div>
                                      </b-alert>
                                    </div>
                                </b-input-group>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                            <b-col sm="12" md="12">
                                <ValidationProvider name="Confirm password" vid="password_confirmation" rules="required|confirmed:new_password" v-slot="{ errors }">
                                <b-form-group
                                  label-cols-sm="12"
                                  label-for="password_confirmation"
                                >
                                <template v-slot:label>
                                  <span>{{$t('globalTrans.confirm_password')}}</span> <span class="text-danger">*</span>
                                </template>
                                <b-input-group>
                                  <b-input-group-prepend class="mb-0" style="height: 30px !important;">
                                      <span class="input-group-text"><i class="ri-lock-fill"></i></span>
                                  </b-input-group-prepend>
                                  <b-form-input
                                    id="password_confirmation"
                                    type="password"
                                    v-model="formData.password_confirmation"
                                    autocomplete="new-password"
                                    :placeholder="$t('globalTrans.confirm_password')"
                                    :state="errors[0] ? false : (valid ? true : null)"
                                    ></b-form-input>
                                    <div class="invalid-feedback">
                                      <b-alert :show="errors[0] ? true : false" class="px-2 py-1" variant="danger" dismissible fade>
                                        <div class="iq-alert-text"><i class="ri-information-line"></i> {{ errors[0] }}</div>
                                      </b-alert>
                                    </div>
                                </b-input-group>
                                </b-form-group>
                              </ValidationProvider>
                            </b-col>
                        </b-row>
                      </div>
                      <b-button block type="submit" class="login-btn btn-sm w-50" variant="success">{{ $t('globalTrans.submit') }}</b-button>
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
import { forgotPasswordResetPasswordApi } from '../api/routes'
import LangButton from '@/components/LangButton.vue'
export default {
  props: ['passwordResetCode'],
  components: {
    LangButton
  },
  data () {
    return {
      valid: null,
      loading: false,
      errors: [],
      formData: {
        password_reset_code: '',
        new_password: '',
        password_confirmation: ''
      },
      errorAlert: false,
      errorMsg: ''
    }
  },
  mounted () {
    this.formData.password_reset_code = this.passwordResetCode
    if (this.formData.password_reset_code === undefined || this.formData.password_reset_code === '') {
      this.$router.push('/auth/forgot-password/otp-sending')
    }
  },
  methods: {
    async resetPassword () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, forgotPasswordResetPasswordApi, this.formData)
        if (result.success) {
          this.$toast.success({
            title: this.$t('globalTrans.success'),
            message: this.$t('forgot_password.successMsg'),
            color: '#D6E09B'
            })
          this.$router.push('/auth/login')
        } else {
          this.errorAlert = true
          this.errorMsg = this.$t('forgot_password.resetPasswordError')
          this.$refs.form.setErrors(result.errors)
        }
      } catch (error) {
        if (error) {
        }
        this.errorAlert = true
        this.errorMsg = this.$t('forgot_password.resetPasswordError')
      }

      this.loading = false
    }
  }
}
</script>

<style scoped>
.mc-signup-bg {
  background: url(../../../../assets/images/sidebar-bg.png);
  background-position: center;
  background-attachment: fixed;
}
.form-control{height:30px !important;}
.form-group{margin-bottom:.1rem !important;}
</style>
