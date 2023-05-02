<template>
    <b-nav-item-dropdown right>
        <template #button-content>
          <div class="user-dropdown-wrapper">
              <!-- <img v-if="authUser?.office_detail?.photo" :src="authServiceBaseUrl + authUser?.office_detail?.photo" class="profile-img" alt=""> -->
              <img src="../assets/images/man.png" class="profile-img" alt="">
          </div>
        </template>
        <p class="user-disc">{{ authUser ? (currentLocale === 'bn' ? authUser.name_bn : authUser.name) : '' }}</p>
        <!-- <b-dropdown-item href="#"><i class="ri-user-3-line"></i> User Profile</b-dropdown-item> -->
        <!-- <b-dropdown-item href="#"><i class="ri-tools-fill"></i> Settings</b-dropdown-item> -->
        <b-dropdown-item href="javascript:" to="/security/change-password">
          <i class="ri-lock-password-line"></i> {{ $t('authentication.changePassword') }}
        </b-dropdown-item>
        <b-dropdown-item class="log-out-btn" @click="logout">
          <i class="ri-logout-circle-r-line"></i> {{ $t('globalTrans.logout') }}
        </b-dropdown-item>
    </b-nav-item-dropdown>
</template>
<script>
import { mapGetters } from 'vuex'
import { authServiceBaseUrl } from '@/config/api_config'
export default {
  name: 'SitePreference',
  data () {
    return {
      authServiceBaseUrl: authServiceBaseUrl + '/storage'
    }
  },
  created () {
    if (this.authUser === null) {
      this.logout()
    }
  },
  computed: {
    currentLocale () {
      return this.$i18n.locale
    },
    authUser: function () {
      return this.$store.state.Auth.authUser
    },
    ...mapGetters({
      authUserRoles: 'Auth/getAuthUserRoles',
      authUserActiveRoleId: 'Auth/getActiveRole'
    })
  },
  methods: {
    logout () {
      this.$store.dispatch('Auth/updateAuthUser', null)
      this.$store.dispatch('Auth/setAccessToken', null)
      this.$router.push('/auth/login')
    }
  }
}
</script>
