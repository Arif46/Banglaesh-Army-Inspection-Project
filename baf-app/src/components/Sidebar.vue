<template>
    <div class="sidebar-wrapper">
        <router-link :to="getHomeUrl()" class="logo-route">
            <div class="logo-wrapper">
                <img src="../assets/images/army.png" class="logo-img" alt="">
                <h6 class="title" style="font-size:14px">Bangladesh Army</h6>
            </div>
        </router-link>
        <div class="sidebar-navigation">
            <CollapseMenu :items="items" :open="true" :horizontal="horizontal" :sidebarGroupTitle="sidebarGroupTitle"/>
        </div>
    </div>
</template>
<script>
import CollapseMenu from './menus/CollapseMenu.vue'
import { mapGetters } from 'vuex'
export default {
    Name: 'Sidebar',
    props: ['name'],
    components: {
        CollapseMenu
    },
    data () {
        return {
            items: [],
            homeURL: { type: Object, default: () => ({ path: '/auth/dashboard' }) },
            logo: { type: String, default: require('../assets/images/logo.png') },
            horizontal: true,
            toggleButton: true,
            logoShow: true,
            onlyLogo: true,
            onlyLogoText: true,
            sidebarGroupTitle: true
        }
    },
    created () {
        if (this.authUser && this.authUser.user_type === 1) {
            this.items = this.$store.state.Auth.activeMenus
        }
    },
    computed: {
        lang: function () {
            return this.$i18n.locale
        },
        ...mapGetters({
            authUser: 'Auth/authUser'
        })
    },
    methods: {
        getHomeUrl () {
            if (this.authUser && this.authUser.user_type === 1) {
                return '/auth/dashboard'
            } else {
                return '/external-user/panel'
            }
        }
    }
}
</script>
