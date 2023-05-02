<template>
  <div>
    <div class="row justify-content-center mt-2">
      <div class="col-md-5">
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
                    <div class="p-2">
                      <b-alert :show="errorAlert" variant=" " dismissible fade class="text-white bg-danger">
                        <div class="iq-alert-icon">
                          <i class="ri-information-line"></i>
                        </div>
                        <div class="iq-alert-text">{{ errorMsg }}</div>
                      </b-alert>
                      <div class="text-center">
                        <h1 class="text-success">{{ $t('globalTrans.success') }}!</h1>
                        <div class="text-dark">
                          <br/>
                            {{ $t('globalTrans.account_create_msg') }}
                            <br/>
                            <br/>
                            <router-link to="/auth/login" class="btn btn-primary">{{ $t('globalTrans.go_to_login') }}</router-link>
                        </div>
                      </div>
                    </div>
                  </b-overlay>
              </div>
          </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { signUp } from '../api/routes'

export default {
  data: () => ({
    loading: false,
    defaultValue: '',
    user: {
      name: 'Unknown Name',
      email: '',
      username: '',
      password: '',
      password_confirmation: '',
      user_type_id: ''
    },
    errorAlert: false,
    errorMsg: ''
  }),
  computed: {
    ...mapGetters({
      userTypeList: 'Auth/userTypeList'
    })
  },
  methods: {
    async signup () {
      try {
        this.loading = true
        const result = await RestApi.postData(authServiceBaseUrl, signUp, this.user)

        if (result.success) {
          this.$router.push({ name: 'auth.login' })
        } else {
          this.errorAlert = true
          this.errorMsg = 'Failed to sign up. Please, try again. ttt'
          this.$refs.form.setErrors(result.errors)
        }
      } catch (error) {
        if (error) {
          //
        }
        this.errorAlert = true
        this.errorMsg = 'Failed to sign up. Please, try again.'
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
