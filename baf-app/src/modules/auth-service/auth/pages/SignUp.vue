<template>
   <b-container fluid class="px-0">
     <b-row align-v="center" no-gutters>
        <b-col cols="12" class="bg-secondary">
            <div class="signup-wrapper mc-signup-bg">
              <b-overlay :show="loading" style="margin: 30px 0;">
                <b-card>
                  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(register)" @reset.prevent="reset" autocomplete="off">
                      <img class="img-fluid d-block mx-auto" width="70" src="@/assets/images/logo.png" alt="">
                      <h6 class="text-center mt-2 mb-3 text-light">{{ $t('globalTrans.moc') }}</h6>
                      <div class="signin-lang-wrapper">
                        <LangButton />
                      </div>
                      <hr style="border-color: #fff">
                      <div class="mt-1 font-weight-bold" style="color: #fff;font-size: 0.86rem;">
                        {{ $i18n.locale === 'en' ? 'If you have already signed up' : 'যদি পূর্বে সাইনআপ করে থাকেন তাহলে' }}
                        <router-link to="/auth/login">
                          {{ $i18n.locale === 'en' ? 'login,' : 'লগইন' }}
                        </router-link>
                        {{ $i18n.locale === 'en' ? 'otherwise sign up by filling out the signup form below.' : 'করুন, নাহলে নিচের সাইনআপ ফর্ম পূরণ করে সাইনআপ করুন।' }}
                      </div>
                      <div class="mt-2 mb-2 font-weight-bold"  style="color: #fff;font-size: 0.86rem;">
                        {{ $i18n.locale === 'en' ? 'Note: Mobile no will be used for username in login and One ID applies to all services.' : 'বিঃদ্রঃ লগইনে ব্যবহারকারীর নামের জন্য মোবাইল নম্বর ব্যবহার করা হবে এবং একটি আইডি সকল সেবার জন্য প্রযোজ্য।' }}
                      </div>
                      <b-row class="justify-content-center">
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Name" vid="name" rules="required" v-slot="{ errors }">
                            <b-form-group
                              id="name"
                              label="Name(En)"
                              label-for="nameEN"
                            >
                            <template v-slot:label>
                              {{ $t('globalTrans.name_en')}} <span class="text-danger">*</span>
                            </template>
                              <b-form-input
                                id="name"
                                v-model="form.name"
                                type="text"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Name (Bn)" vid="name_bn" rules="required" v-slot="{ errors }">
                            <b-form-group
                                id="name_bn"
                                label="Name(Bn)"
                                label-for="name_bn"
                              >
                              <template v-slot:label>
                                {{ $t('globalTrans.name_bn')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="name_bn"
                                v-model="form.name_bn"
                                type="text"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Mobile" vid="mobile" rules="required" v-slot="{ errors }">
                            <b-form-group
                              label="Mobile No"
                              label-for="mobile"
                            >
                            <template v-slot:label>
                              {{ $t('globalTrans.mobile')}} <span class="text-danger">*</span>
                            </template>
                              <b-form-input
                                id="mobile"
                                v-model="form.mobile"
                                type="tel"
                                oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*?)\..*/g, '$1');"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Email" vid="email" v-slot="{ errors }">
                            <b-form-group
                              label="Email"
                              label-for="email"
                            >
                            <template v-slot:label>
                              {{ $t('globalTrans.email')}}
                            </template>
                              <b-form-input
                                id="email"
                                v-model="form.email"
                                type="email"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Password" ref="password" vid="password" rules="required|min:6" v-slot="{ errors }">
                            <b-form-group
                              id="pass"
                              label="Password"
                              label-for="pass">
                              <template v-slot:label>
                                {{ $t('globalTrans.password')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="passInput"
                                v-model="form.password"
                                type="password"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                        <b-col lg="6" md="6" sm="6" xs="12">
                          <ValidationProvider name="Confirm password" vid="confirm_password" rules="required|confirmed:password" v-slot="{ errors }">
                            <b-form-group
                              id="confirm_passowrd"
                              label="Confirm Password"
                              label-for="confirm_password">
                              <template v-slot:label>
                                {{ $t('globalTrans.confirm_password')}} <span class="text-danger">*</span>
                              </template>
                              <b-form-input
                                id="confirm_passowrd"
                                v-model="form.confirm_password"
                                type="password"
                                :state="errors[0] ? false : (valid ? true : null)"
                              ></b-form-input>
                              <div class="invalid-feedback">
                                {{ errors[0] }}
                              </div>
                            </b-form-group>
                          </ValidationProvider>
                        </b-col>
                      </b-row>
                      <b-button block type="submit" class="login-btn btn-sm" variant="primary" >{{ $t('globalTrans.sign_up') }}</b-button>
                      <p class="have-account-text text-light text-center"><router-link to="/auth/login">{{ $t('globalTrans.already_have_account') }}</router-link></p>
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
import { signUpApi } from '../api/routes'
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
      form: {
        name: '',
        name_bn: '',
        mobile: '',
        email: '',
        password: '',
        confirm_password: '',
        user_type: 2 // 2 mean public user
      }
    }
  },
  methods: {
    async register () {
      this.loading = true
      const result = await RestApi.postData(authServiceBaseUrl, signUpApi, this.form)
      this.loading = false
      if (result.success) {
        this.$router.push('/auth/otp/' + result.user_id)
        // this.$router.push('/auth/login')
      } else {
        this.$refs.form.setErrors(result.errors)
        this.$toast.error({
          title: 'Error',
          message: 'Operation failed! Please, try again.'
        })
      }
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
.signin-lang-wrapper {
  position: absolute;
  right: 20px;
  top: 10%;
}
</style>
