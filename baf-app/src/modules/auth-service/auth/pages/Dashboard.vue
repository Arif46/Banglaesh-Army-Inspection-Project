<template>
    <div class="home-component-wrapper">
        <div class="main-wrapper">
            <div class="main-content-section home-logo-wrapper">
                <Header :layout="'Home'"></Header>
            </div>
        </div>
        <div class="component-wrapper">
            <b-container fluid>
                <b-row>
                    <b-col v-if="loader" class="col-md-12 text-center">
                        <div class="spinner-border" role="status">
                            <span class="sr-only"></span>
                        </div>
                        <br/>
                        <p class="loading-text">{{ $t('authentication.loadingMenus') }}</p>
                    </b-col>
                    <template v-else>
                        <b-col sm="12" md="4" v-for="item in componentList" :key="item.id" offset="2">
                            <b-card class="mc-db-card">
                                <div class="d-flex justify-content-start align-items-center"  @click="setComponent(item.id)">
                                    <img :class="`mr-3 component-${item.sorting_order}`" :src="require(`../../../../assets/icons/main-dashboard/${item.sorting_order}.png`)" alt="">
                                    <h5>{{($i18n.locale === 'en') ? item.component_name : item.component_name_bn}}</h5>
                                </div>
                            </b-card>
                        </b-col>
                        <b-col sm="12" md="4">
                            <b-card class="mc-db-card">
                                <div class="d-flex justify-content-start align-items-center">
                                    <!-- <img :class="mr-3 component" src="require(../../../../assets/icons/main-dashboard/army.png)" alt=""> -->
                                    <img src="../../../../assets/icons/main-dashboard/3.png" class="mr-3" width="46" alt="">
                                    <h5>PSI/SI/QAC Report Vetting</h5>
                                </div>
                            </b-card>
                        </b-col>
                        <b-col sm="12" md="4" offset="4">
                            <b-card class="mc-db-card">
                                <div class="d-flex justify-content-start align-items-center">
                                    <!-- <img :class="mr-3 component" src="require(../../../../assets/icons/main-dashboard/army.png)" alt=""> -->
                                    <img src="../../../../assets/icons/main-dashboard/8.png" class="mr-3" width="46" alt="">
                                    <h5>JPSI and Final Inspection</h5>
                                </div>
                            </b-card>
                        </b-col>
                        <!-- <b-col sm="12" md="4">
                            <b-card class="mc-db-card">
                                <div class="d-flex justify-content-start align-items-center">
                                    <img src="../../../../assets/icons/main-dashboard/5.png" class="mr-3" width="46" alt="">
                                    <h5></h5>
                                </div>
                            </b-card>
                        </b-col> -->
                    </template>
                </b-row>
            </b-container>
        </div>
        <Footer></Footer>
  </div>
</template>
<script>
    import { mapGetters, mapActions } from 'vuex'
    import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
    import { sidebarMenusApi } from '../api/routes'
    import Header from '@/components/Header.vue'
    import Footer from '@/components/Footer.vue'
    export default {
        name: 'Dashboard',
        components: {
            Header,
            Footer
        },
        data () {
            return {
                loader: false,
                orgList: [],
                componentId: 0,
                componentList: [],
                destinationUri: '',
                menus: [],
                authorizedURIs: []
            }
        },
        created () {
            // this.setOrgAndOrgComponentList()
            this.setActiveMenus([])
            this.setComponentList()
        },
        computed: {
            currentLocale: function () {
                return this.$i18n.locale
            },
            ...mapGetters({
                authorizedComponents: 'Auth/getAuthorizedComponents',
                activeRole: 'Auth/getActiveRole',
                authUserActiveRoleId: 'Auth/getActiveRole',
                authUserRoles: 'Auth/getAuthUserRoles',
                authUser: 'Auth/authUser'
            })
        },
        methods: {
            setComponentList () {
                if (this.authorizedComponents.length === 0) {
                    this.componentList = []
                    return
                }
                const componentList = this.authorizedComponents.map(item => ({ icon: '', ...item }))
                this.componentList = componentList.filter(item => item.id === 8)
                // this.componentList = componentList
            },
            setComponent (componentId) {
                if (componentId === 1) {
                    this.destinationUri = '/common-service/dashboard'
                } else if (componentId === 7) {
                    this.destinationUri = '/license-registration-service/dashboard'
                } else if (componentId === 3) {
                    this.destinationUri = '/bazar-monitoring-service/configuration/dashboard'
                } else if (componentId === 10) {
                    this.destinationUri = '/export-trophy-cip-service/configuration/dashboard'
                } else if (componentId === 11) {
                    this.destinationUri = '/rjsc-service/configuration/dashboard'
                } else if (componentId === 6) {
                  this.destinationUri = '/bfti-research-and-report-service/dashboard'
                } else if (componentId === 5) {
                  this.destinationUri = '/tea-garden-service/dashboard'
                } else if (componentId === 9) {
                  this.destinationUri = '/trade-fair-service/dashboard'
                } else if (componentId === 8) {
                  this.destinationUri = '/trade-tariff-service/specification/specification-info'
                //   this.destinationUri = '/trade-tariff-service/dashboard'
                } else if (componentId === 4) {
                  this.destinationUri = '/e-biz-management-system-service/dashboard'
                } else {
                    this.$toast.error({
                        title: 'Error',
                        message: this.$t('authentication.noPrivilege')
                    })
                    this.$router.push('/auth/login')
                }
                this.authorizedURIs.push(this.destinationUri)
                this.setActiveComponentId(componentId)
                this.getMenusByRoleComponent(componentId)
            },
            getMenusByRoleComponent (componentId) {
                this.loader = true
                RestApi.getData(commonServiceBaseUrl, `${sidebarMenusApi}/${this.activeRole}/${componentId}`).then(response => {
                    if (!response.success) {
                        this.$toast.error({
                        title: 'Error',
                        message: this.$t('authentication.noPrivilege')
                    })
                    this.$router.push('/auth/login')
                    return
                    }
                    this.menus = response.data
                    this.formatActiveMenus(componentId)
                    // this.loader = false
                }, error => {
                    if (error) {
                        this.loader = false
                    }
                })
            },
            formatActiveMenus (componentId) {
                const componentInfo = this.authorizedComponents.find(item => item.id === componentId)
                const menusByComponent = this.menus.modules.map(item => {
                    const formatedMenu = this.getFormatedModuleMenu(item)
                    const serviceMenus = this.getServiceMenusByModuleId(item.id)
                    const childMenus = this.getMenusByModuleId(item.id)
                    if (childMenus.length) {
                        formatedMenu.children.push(...childMenus)
                    }
                    if (serviceMenus.length) {
                        formatedMenu.children.push(...serviceMenus)
                    }
                    return formatedMenu
                })
                const lang = this.$i18n.locale
                menusByComponent.unshift({
                    title: componentInfo.component_name,
                    title_bn: componentInfo.component_name_bn,
                    name: lang === 'en' ? componentInfo.component_name : componentInfo.component_name_bn,
                    is_heading: false,
                    is_active: false,
                    link: this.destinationUri,
                    class_name: '',
                    is_icon_class: false,
                    sorting_order: componentInfo.sorting_order,
                    icon: 'ri-record-circle-line'
                })
                menusByComponent.unshift({
                    title: 'Home',
                    title_bn: 'হোম',
                    name: lang === 'en' ? 'Home' : 'হোম',
                    is_heading: false,
                    is_active: false,
                    link: '/auth/dashboard',
                    class_name: '',
                    is_icon_class: true,
                    icon: 'ri-home-4-line'
                })
                this.setAuthorizedUris(this.authorizedURIs)
                this.setActiveMenus(menusByComponent)
                if (this.componentId !== 0) {
                    this.$router.push(this.dashboardUrl)
                } else {
                    this.$router.push(this.destinationUri)
                }
            },
            getServiceMenusByModuleId (moduleId) {
                const services = this.menus.services.filter(item => item.module_id === moduleId)
                if (!services.length) {
                    return []
                }
                const serviceMenus = services.map(item => this.getMenusByServiceId(item))
                return serviceMenus
            },
            getMenusByServiceId (service) {
                // Menus belog to services
                const menus = this.menus.menus.filter(item => item.service_id === service.id)
                if (!menus.length) {
                    return []
                }
                const formatedMenu = this.getFormatedServiceMenu(service)
                const formatedChildMenus = menus.map(item => this.getFormatedMenu(item))
                formatedMenu.children.push(...formatedChildMenus)
                return formatedMenu
            },
            getMenusByModuleId (moduleId) {
                // Menu which does not belong to services
                const menus = this.menus.menus.filter(item => !item.service_id && item.module_id === moduleId)
                if (!menus.length) {
                    return []
                }
                const formatedMenus = menus.map(item => this.getFormatedMenu(item))
                return formatedMenus
            },
            getFormatedMenu (menuItem) {
                // Format menu here
                const lang = this.$i18n.locale
                let url = menuItem.url.trim()
                url = url.startsWith('/') ? url : `/${url}`
                this.authorizedURIs.push(url)
                if (menuItem.associated_urls !== null && menuItem.associated_urls.trim() !== '') {
                    const tmpUrls = menuItem.associated_urls.split(',')
                    tmpUrls.forEach(item => {
                        this.authorizedURIs.push(item.trim())
                    })
                }
                return {
                    title: menuItem.menu_name,
                    title_bn: menuItem.menu_name_bn,
                    name: lang === 'en' ? menuItem.menu_name : menuItem.menu_name_bn,
                    is_heading: false,
                    is_active: false,
                    link: url,
                    class_name: '',
                    is_icon_class: true,
                    icon: 'ri-record-circle-line'
                }
            },
            getFormatedModuleMenu (item) {
                const lang = this.$i18n.locale
                return {
                    title: item.module_name,
                    title_bn: item.module_name_bn,
                    name: lang === 'en' ? item.module_name : item.module_name_bn,
                    is_heading: false,
                    is_active: false,
                    link: '',
                    class_name: '',
                    is_icon_class: true,
                    icon: 'ri-record-circle-line',
                    children: []
                }
            },
            getFormatedServiceMenu (item) {
                const lang = this.$i18n.locale
                return {
                    title: item.service_name,
                    title_bn: item.service_name_bn,
                    name: lang === 'en' ? item.service_name : item.service_name_bn,
                    is_heading: false,
                    is_active: false,
                    link: '',
                    class_name: 'iq-submenu-data',
                    is_icon_class: true,
                    icon: 'ri-record-circle-line',
                    children: []
                }
            },
            ...mapActions({
                setActiveComponentId: 'Auth/setActiveComponentId',
                setActiveMenus: 'Auth/setActiveMenus',
                setAuthorizedUris: 'Auth/setAuthorizedMenus'
            })
        }
    }
</script>
