<template>
   <b-container fluid class="px-0 mc-login-bg">
     <b-row align-v="center" no-gutters>
        <b-col md="6" class="d-none d-md-block">
            <img class="img-fluid d-block mx-auto" width="100" src="@/assets/images/army.png" alt="">
            <h4 class="text-center mt-3 mb-2">Inspectorates Automation System</h4>
            <h4 class="text-center mt-3 mb-2">of</h4>
            <h5 class="text-center mb-3">Bangladesh Army</h5>
        </b-col>
        <b-col sm="12" md="6" style="background: #15273B">
            <div class="login-wrapper">
              <b-overlay :show="loading">
                <b-card>
                  <img class="img-fluid d-block mx-auto" width="70" src="@/assets/images/army.png" alt="">
                  <h5 class="form-logo-text text-center mt-2 mb-3">Bangladesh Army</h5>
                  <!-- <div class="text-center mb-2">
                    <LangButton />
                    <b-alert show dismissible fade variant="danger" v-if="errorAlert">{{ errorMsg }}</b-alert>
                  </div> -->
                  <ValidationObserver ref="form" v-slot="{ handleSubmit, reset }">
                    <b-form @submit.prevent="handleSubmit(login)" @reset.prevent="reset" autocomplete="off">
                      <ValidationProvider name="Username/Email/Mobile" vid="username" rules="required">
                        <b-form-group
                            id="user"
                            :label="$t('globalTrans.usernameOrEmail')"
                            label-for="username"
                        >
                          <b-form-input
                            id="username"
                            v-model="creds.username"
                            required
                          ></b-form-input>
                        </b-form-group>
                      </ValidationProvider>
                      <ValidationProvider name="password" rules="required">
                        <b-form-group
                        class="mb-3 position-relative"
                        id="password"
                        :label="$t('globalTrans.password')"
                        label-for="password">
                          <b-form-input
                            class="mb-0"
                            id="input-2"
                            v-model="creds.password"
                            :type="showPassword ? 'text' : 'password'"
                            required
                          ></b-form-input>
                          <a href="javascript:" class="logineye-wrapper" @click="showPassword =! showPassword">
                            <i v-if="showPassword" class="fa fa-eye-slash" aria-hidden="true"></i>
                            <i v-else class="fa fa-eye" aria-hidden="true"></i>
                          </a>
                        </b-form-group>
                      </ValidationProvider>
                      <!-- <p class="forgot-text"><i class="ri-key-2-fill"></i><router-link to="/auth/forgot-password/otp-sending">{{ $t('globalTrans.forgot_your_password') }}</router-link></p> -->
                      <b-button block type="submit" class="login-btn mb-2" variant="primary">{{ $t('globalTrans.login') }}</b-button>
                      <!-- <b-button block type="submit" class="login-btn mb-2" variant="primary">{{ $t('globalTrans.nothi_login') }}</b-button> -->
                      <!-- <a class="btn btn-primary login-btn btn-block mb-2 " :href="returnUrl">{{ $t('globalTrans.nothi_login') }}</a> -->
                      <!-- <p class="have-account-text">{{ $t('globalTrans.dont_have_an_account') }} <router-link to="/auth/sign-up"> {{ $t('globalTrans.sign_up') }}</router-link></p> -->
                    </b-form>
                  </ValidationObserver>
                </b-card>
                <div class="company-logo mt-2 text-right">
                  <span style="margin-right: 10px;font-size: 0.73rem;">
                    {{ $t('authentication.design_and_Development') }}
                  </span>
                  <a href="https://www.syntechbd.com/" target="_blank">
                    <img class="img-fluid" width="30" src="@/assets/images/syntech-logo-icon.png" alt="" />
                    <span>Syntech Solution Ltd.</span>
                  </a>
                </div>
              </b-overlay>
            </div>
        </b-col>
    </b-row>
   </b-container>
</template>

<script>
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { loginApi } from '../api/routes'
// import LangButton from '@/components/LangButton.vue'

export default {
  components: {
    // LangButton
  },
  data () {
    return {
      loading: false,
      errorAlert: false,
      errorMsg: '',
      returnUrl: '',
      creds: {
        username: '',
        password: '',
        nothi_login: 0
      },
      showPassword: false
    }
  },
  created () {
    this.returnUrl = process.env.VUE_APP_NOTHI_BASE_URL + '/login?referer=' + btoa(window.location.origin + '/auth/nothi-login-process')
  },
  methods: {
    areaTypeAdd () {
      const areaTypeList = [
        {
          value: 1,
          text: 'City Corporation',
          text_en: 'City Corporation',
          text_bn: 'সিটি কর্পোরেশন'
        },
        {
          value: 2,
          text: 'Pauroshoba',
          text_en: 'Pauroshoba',
          text_bn: 'পৌরসভা'
        },
        {
          value: 3,
          text: 'Union',
          text_en: 'Union',
          text_bn: 'ইউনিয়ন'
        }
      ]
      this.$store.dispatch('mutateCommonProperties', {
        areaTypeList: areaTypeList
      })
    },
    setWithExpiry (key, value, ttl) {
      const now = new Date()
      const item = {
        value: value,
        expiry: now.getTime() + ttl
      }
      localStorage.setItem(key, JSON.stringify(item))
    },
    async login () {
      this.loading = true
      this.errorAlert = false
      const result = await RestApi.postData(authServiceBaseUrl, loginApi, this.creds)
      // this.loading = false
      if (typeof result === 'undefined') {
        this.loading = false
        this.errorAlert = true
        this.errorMsg = this.$t('globalTrans.login_failed')
      }
      if (result.success) {
        localStorage.clear()
        // localStorage.setItem('access_token', result.access_token)
        // Set token for 72 Hours
        this.setWithExpiry('access_token', result.access_token, 72 * 60 * 60 * 1000)
        this.$store.dispatch('Auth/setAccessToken', result.access_token)
        localStorage.setItem('userDetail', result.user_detail)
        this.$store.dispatch('Auth/updateAuthUser', Object.assign(
          {},
          {
            user_id: result.user_id,
            user_type: result.user_type,
            org_admin: result.org_admin,
            office_detail: result.office_detail,
            last_panel: result.last_panel,
            panels: result.panels,
            name: result.name,
            name_bn: result.name_bn,
            email: result.email,
            mobile: result.mobile,
            photo: result.photo,
            user_detail: result.user_type === 1 ? result.user_detail : result.external_user_detail
          })
        )
        this.areaTypeAdd()
        if (result.user_type === 1) { // 1 mean admin user
          this.$router.push('/auth/role-select')
          this.loading = false
        } else {
          this.$router.push('/auth/external-menus')
        }
      } else {
        this.loading = false
        this.errorAlert = true
        this.errorMsg = this.$t('globalTrans.login_failed')
      }
    }
  }
}
</script>

<style scoped>
/* .login-bg {
    width: 100%;
    height: 100vh;
    background: linear-gradient(to bottom, rgb(50 50 50 / 50%), rgb(50 50 50 / 50%)),url(../../../../assets/images/login-bg.jpg);
    background-position: center;
    background-size: cover;
  } */
  .company-logo a span {
    margin-left: 3px;
    color: #fff;
    font-size: 0.73rem;
  }
  .mc-login-bg{
    background: url(../../../../assets/images/sidebar-bg.png);
    background-position: center;
  }
  .login-wrapper{
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
  }
  .login-wrapper .form-group label{
    color: var(--white);
  }
  .login-wrapper .card{
    backdrop-filter: blur(2px);
    background: rgba(255, 255, 255, 0.1);
    /* border: 1px solid rgba(255, 255, 255, 1); */
  }
</style>
