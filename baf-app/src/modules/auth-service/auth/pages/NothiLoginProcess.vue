<template>
  <div>
    <div class ="row justify-content-center mt-4">
      <div class="col-md-6 text-center" v-if="loading">
        <b-spinner variant="primary" label="Text Centered"></b-spinner>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import RestApi, { authServiceBaseUrl } from '@/config/api_config'
import { loginApi } from '../api/routes'

export default {
  data: () => ({
    loading: true,
    user: {
      username: '',
      password: '',
      email: ''
    },
    errorAlert: false,
    errorMsg: ''
  }),
  computed: {
    ...mapGetters({
      serviceUrl: 'Portal/serviceUrl'
    })
  },
  created () {
    // this.loading = false
    this.nothiLogin()
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
    async nothiLogin () {
      const apiResponse = await RestApi.postData(authServiceBaseUrl, loginApi, {
        nothi_login: 1,
        data: this.$route.query.data
      })
      if (typeof apiResponse === 'undefined') {
        this.loading = false
        this.errorAlert = true
        this.errorMsg = this.$t('globalTrans.login_failed')
      }
      if (apiResponse.success) {
          localStorage.setItem('access_token', apiResponse.access_token)
          this.$store.dispatch('Auth/setAccessToken', apiResponse.access_token)
          localStorage.setItem('userDetail', apiResponse.user_detail)
          this.$store.dispatch('Auth/updateAuthUser', Object.assign(
            {},
            {
              ssoLogin: true,
              user_id: apiResponse.user_id,
              user_type: apiResponse.user_type,
              org_admin: apiResponse.org_admin,
              office_detail: apiResponse.office_detail,
              last_panel: apiResponse.last_panel,
              panels: apiResponse.panels,
              name: apiResponse.name,
              name_bn: apiResponse.name_bn,
              email: apiResponse.email,
              mobile: apiResponse.mobile,
              photo: apiResponse.photo,
              user_detail: apiResponse.user_type === 1 ? apiResponse.user_detail : apiResponse.external_user_detail
            }
          ))
          this.areaTypeAdd()
          if (apiResponse.user_type === 1) { // 1 mean admin user
            this.loading = false
            this.$router.push('/auth/role-select')
          } else {
            this.checkExternalProfile()
          }
        } else {
          this.errorAlert = true
          this.errorMsg = this.$t('authentication.loginError')
          this.$router.push('/auth/login')
        }
        this.loading = false
    }
  }
}
</script>
