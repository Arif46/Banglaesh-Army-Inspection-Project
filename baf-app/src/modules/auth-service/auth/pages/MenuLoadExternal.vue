<template>
  <div class="role-select-wrapper">
    <div class="role-select">
      <img class="img-fluid d-block mx-auto" width="100" src="@/assets/images/logo.png" alt="">
      <h5 class="text-center mt-3 mb-2">{{ $t('globalTrans.project_name') }}</h5>
      <h6 class="text-center mb-3">({{ $t('globalTrans.moc') }})</h6>
      <b-alert :show="errorAlert" variant=" " dismissible fade class="text-white bg-danger">
        <div class="iq-alert-text"><i class="ri-information-line"></i> {{ errorMsg }}</div>
      </b-alert>
      <div class="text-center">
        <b-overlay :show="loading">
          <p class="py-2">{{ message }}</p>
        </b-overlay>
      </div>
    </div>
  </div>
</template>

<script>
import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
import { mapGetters } from 'vuex'
import { EventBus } from '@/EventBusLayout'

export default {
  data () {
    return {
      loading: true,
      errorAlert: false,
      errorMsg: '',
      message: ''
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    ...mapGetters({
      serviceUrl: 'Portal/serviceUrl',
      authUser: 'Auth/authUser',
      commonProfile: 'Auth/commonProfile'
    })
  },
  created () {
    this.checkExternalProfile()
  },
  methods: {
    async loadPanels () {
        this.message = this.$i18n.locale === 'en' ? 'Panel Loading..' : 'প্যানেল লোড হচ্ছে..'
        const result = await RestApi.getData(commonServiceBaseUrl, 'external/external-panel/get-all')
        this.loading = false
        if (result.success) {
          this.$store.dispatch('ExternalUserService/setExternalPanels', result.data.filter(item => item.status === 1))
        } else {
          this.$store.dispatch('ExternalUserService/setExternalPanels', [])
        }
        this.$router.push({ path: '/external-user/panel' }).catch(() => {})
    },
    // future implementation
    getLastActivePanelUrl () {
      const panelId = this.authUser.last_panel
      if (panelId === '' || !panelId) {
        return '/external-user/panel'
      } else {
        return '/external-user/panel'
        // const targetUrl = this.$store.state.ExternalUserService.externalMenus[2] ? this.$store.state.ExternalUserService.externalMenus[2].link : this.$store.state.ExternalUserService.externalMenus[1]
        // return targetUrl
      }
    },
    navigateToExternalPanel () {
      this.message = this.$i18n.locale === 'en' ? 'Menus Loading..' : 'মেনু লোড হচ্ছে..'
      const serviceUrl = this.serviceUrl.externalPanelServiceUrl
      if (serviceUrl === undefined || serviceUrl === null || serviceUrl === '') {
        this.loadPanels()
        // this.loading = false
        // const homePage = this.getLastActivePanelUrl()
        // this.$router.push({ path: homePage }).catch(() => {})
      } else {
        this.$router.push({ path: serviceUrl }).catch(() => {})
      }
    },
    checkExternalProfile () {
      this.message = this.$i18n.locale === 'en' ? 'Checking Profile..' : 'প্রোফাইল যাচাই করা হচ্ছে..'
      const userId = this.authUser.user_id
      if (this.commonProfile && this.commonProfile.user_id === userId) {
        this.navigateToExternalPanel()
      } else {
        RestApi.getData(authServiceBaseUrl, `common-profile/show/${userId}`).then(response => {
          if (!response.success) {
              this.$store.dispatch('Auth/setCommonProfile', null)
              /** initially menus will be common for all new user */
              EventBus.$emit('RESET_EXTERNAL_MENUS')
              /** redirect to profie update page */
              this.$router.push('/external-user/profile-update')
              this.loading = false
          } else {
              EventBus.$emit('RESET_EXTERNAL_MENUS')
              const userData = Object.assign(response.data, { name: this.authUser.name, name_en: this.authUser.name, name_bn: this.authUser.name_bn, mobile: this.authUser.mobile, email: this.authUser.email })
              this.$store.dispatch('Auth/setCommonProfile', userData)
              this.navigateToExternalPanel()
          }
        })
      }
    }
  }
}
</script>
<style scoped>
.role-select-wrapper {
    margin: 30px auto !important;
    display: flex;
    width: 30%;
    height: 86vh;
    background: none !important;
}
.role-select {
    width: 100%;
    color: var(--white);
    background: var(--secondary);
    border-radius: 5px;
    padding: 50px 10px 50px 10px;
}
</style>
