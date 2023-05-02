<template>
    <div class="sidebar-wrapper">
        <router-link :to="getHomeUrl()" class="logo-route">
            <div class="logo-wrapper">
                <img src="../assets/images/army.png" class="logo-img" alt="">
                <h2 class="title">Bangladesh Army</h2>
            </div>
        </router-link>
        <div class="sidebar-navigation">
            <CollapseMenu :items="items" :open="true" :horizontal="horizontal" :sidebarGroupTitle="sidebarGroupTitle"/>
        </div>
    </div>
</template>
<script>
import RestApi, { commonServiceBaseUrl, eBizServiceBaseUrl } from '@/config/api_config'
import CollapseMenu from './menus/CollapseMenu.vue'
import { mapGetters } from 'vuex'
import { EventBus } from '@/EventBusLayout'
export default {
    Name: 'Sidebar',
    props: ['name', 'panel_id'],
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
            sidebarGroupTitle: true,
            externalCommonMenus: [
                {
                    title: 'Home',
                    title_bn: 'হোম',
                    name: this.lang === 'en' ? 'Home' : 'হোম',
                    is_heading: false,
                    is_active: false,
                    link: '/external-user/panel',
                    class_name: '',
                    is_icon_class: true,
                    icon: 'ri-home-line',
                    panel_id: 0
                },
                {
                    title: 'Profile',
                    title_bn: 'প্রোফাইল',
                    name: this.lang === 'en' ? 'Profile' : 'প্রোফাইল',
                    is_heading: false,
                    is_active: false,
                    link: '/external-user/profile',
                    class_name: '',
                    is_icon_class: true,
                    icon: 'ri-profile-line',
                    panel_id: 0
                }
            ]
        }
    },
    beforeMount () {
        /** This EventBus should emitted before loading menus of external panels */
        EventBus.$on('LOAD_EXTERNAL_MENUS', this.externalMenusLoad)
        EventBus.$on('RESET_EXTERNAL_MENUS', this.resetExternalMenus)
    },
    destroyed () {
        // Removes Event Bus listener upon removal of template from DOM.
        EventBus.$off('LOAD_EXTERNAL_MENUS', this.externalMenusLoad)
    },
    created () {
        const panelId = this.panel_id
        if (panelId) {
            const isExist = this.$store.state.ExternalUserService.externalMenus.find(el => el.panel_id === panelId)
            if (typeof isExist === 'undefined') {
                this.externalMenusLoad(panelId)
            }
        }
        this.getExternalUserMenus()
        if (panelId) {
            this.setSideBarMenus()
        }
    },
    watch: {
        isInsidePanel: function (newVal) {
            if (newVal) {
                this.getExternalUserMenus()
            }
        }
    },
    computed: {
        lang: function () {
            return this.$i18n.locale
        },
        ...mapGetters({
            authUser: 'Auth/authUser',
            isInsidePanel: 'ExternalUserService/isInsidePanel',
            serviceUrl: 'Portal/serviceUrl',
            commonProfile: 'Auth/commonProfile'
        })
    },
    methods: {
        setSideBarMenus () {
            const panelId = this.panel_id
            if (panelId === 5) {
                this.checkAssociationProfile()
            }
        },
        async externalMenusLoad (panelId) {
            // checking users common profile updated or not
            if (!this.commonProfile) {
                // this.$router.push('/external-user/profile-update')
                this.resetExternalMenus()
                return
            }

            const response = await RestApi.getData(commonServiceBaseUrl, `external/external-menu/sidebar-menus/${panelId}`)
            this.loading = false
            if (response.success) {
                const menus = response.data
                this.loadExternalMenus(menus)
            } else {
                this.$store.dispatch('ExternalUserService/setExternalMenus', [])
            }
        },
        loadExternalMenus (data) {
            const panelMenus = data.map(item => {
                return Object.assign({}, this.getFormatedMenu(item))
            })
            this.$store.dispatch('ExternalUserService/setExternalMenus', this.formatWithCommonTwoMenu(panelMenus))
            this.$store.dispatch('ExternalUserService/isInsidePanel', true)

            const serviceUrl = this.serviceUrl.externalPanelServiceUrl
            if (!serviceUrl) {
                this.$router.push(data[0].url).catch(() => {})
            } else {
                this.$store.dispatch('Portal/setServiceUrl', {
                    externalPanelServiceUrl: null,
                    externalPanelCurrentServiceUrl: serviceUrl
                })
            }
            this.getExternalUserMenus()
        },
        getExternalUserMenus () {
            const tmpRoutes = this.$store.state.ExternalUserService.externalMenus
            if (this.isInsidePanel || tmpRoutes.length > 0) {
                this.items = tmpRoutes
                this.$store.dispatch('Auth/setActiveMenus', tmpRoutes)
                this.$store.dispatch('ExternalUserService/isInsidePanel', false)
            } else {
                this.items = this.externalCommonMenus
                this.$store.dispatch('Auth/setActiveMenus', this.externalCommonMenus)
            }
        },
        resetExternalMenus () {
            this.$store.dispatch('ExternalUserService/setExternalMenus', [])
            this.getExternalUserMenus()
        },
        getFormatedMenu (item) {
            return {
                title: item.name,
                title_bn: item.name_bn,
                name: this.lang === 'en' ? item.name : item.name_bn,
                is_heading: false,
                is_active: false,
                link: item.url,
                class_name: 'iq-submenu-data',
                is_icon_class: true,
                icon: 'ri-record-circle-line',
                panel_id: item.external_panel_id
            }
        },
        formatWithCommonTwoMenu (panelMenus) {
            return this.externalCommonMenus.concat(panelMenus)
        },
        getHomeUrl () {
            if (this.authUser && this.authUser.user_type === 1) {
                return '/auth/dashboard'
            } else {
                return '/external-user/panel'
            }
        },
        checkAssociationProfile () {
            this.associationMenuToggle(false)
            const userId = this.authUser.user_id
            RestApi.getData(eBizServiceBaseUrl, `/association-panel/association-profile/show/${userId}`).then(response => {
                if (response.success && response.data.status === 2) {
                    this.associationMenuToggle()
                     this.$store.dispatch('ExternalUserService/setAssociationProfile', response.data)
                } else {
                    this.$store.dispatch('ExternalUserService/setAssociationProfile', null)
                    this.$router.push({ path: '/association-panel/association-profile-update' }).catch(() => {})
                }
            })
        },
        associationMenuToggle (isEnable = true) {
            const menuSort = []
            this.items.forEach((item, key) => {
                const data = item
                data.class_name = (isEnable || item.title === 'Home' || item.title === 'Profile' || item.title === 'Association Profile') ? '' : 'disabled-sidebar-link'
            })
            this.items = menuSort
            this.getExternalUserMenus()
        }
    }
}
</script>
