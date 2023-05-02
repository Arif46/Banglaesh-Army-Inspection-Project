<template>
  <div class="header-wrapper">
      <vue-progress-bar></vue-progress-bar>
      <div class="top-header py-2">
          <b-container class="portal-container">
              <div class="d-flex justify-content-between align-items-center">
                  <div class="d-flex align-items-center">
                    <!-- <span class="hotline">
                        <i class="ri-headphone-fill"></i>{{ BangNum(header.helpline) }}
                    </span> -->
                    <b-button @click="changeLang" size="sm" class="lang-btn">
                        <i class="ri-global-line"></i>
                        <span>{{ langLabel }}</span>
                    </b-button>
                  </div>
                  <div class="login-signup-wrapper">
                    <div>
                        <router-link class="btn about_btn btn-sm mr-3" to="/portal/about-service-portal">
                            <i class="ri-information-line"></i>
                            <span>{{ $t('portal.about_service_portal') }}</span>
                        </router-link>
                        <b-button-group>
                            <a href="javascript:" class="login-btn" :class="{'show' : show}" @click="goLogin()">
                                <img style="width:102px" src="../../../assets/images/login-btn.gif" alt="Login">
                            </a>
                            <!-- <router-link to="/auth/login" class="login-btn" :class="{'show' : show}">
                                                    <img style="width:102px" src="../../../assets/images/login-btn.gif" alt="Login">
                                                </router-link> -->
                        </b-button-group>
                    </div>
                  </div>
              </div>
          </b-container>
      </div>
      <div class="main-header">
          <b-container class="portal-container">
              <b-row>
                  <b-col sm="6">
                      <a href="javascript:" class="brand" @click="goTo">
                          <img src="../../../assets/images/logo.png" width="50" alt="">
                          <div style="display: flex; flex-direction: column;">
                              <p>{{ ($i18n.locale === 'bn') ? header.title_bn : header.title }}</p>
                              <small class="pl-3">{{ ($i18n.locale === 'bn') ? header.description_bn : header.description }}</small>
                          </div>
                      </a>
                  </b-col>
                  <b-col sm="5" class="mob-search">
                    <div class="search-bar main-searchbar-wrapper ml-auto">
                        <b-form-input
                            v-model="name"
                            @keypress.enter="$event.preventDefault()"
                            size="lg"
                            type="search"
                            :placeholder="$t('globalTrans.search') + '...'"
                        >
                        </b-form-input>
                        <b-button v-if="name === ''" size="sm"><i class="ri-search-2-line"></i></b-button>
                        <div v-if="name !== ''" class="search-dropdown-wrapper" style="width: 100%">
                            <ul v-if="!searching">
                                <li @click="resetSearch" v-for="(service, index) in services" :key="index">
                                    <router-link :to="`/portal/service-details?service_type=allService&service_id=` + service.id" :title="$i18n.locale == 'bn' ? service.name_bn : service.name">
                                    <i class="fas fa-history"></i> {{ $i18n.locale == 'bn' ? service.name_bn : service.name }}
                                    </router-link>
                                </li>
                            </ul>
                            <div v-if="services.length > 0 && searching" style="display: flex; align-items: center; justify-content: center; height: 100%;">
                                <h6>{{ $i18n.locale === 'en' ? 'Loading...' : 'লোড হচ্ছে...' }}</h6>
                            </div>
                            <div v-if="!services.length" style="display: flex; align-items: center; justify-content: center; height: 100%;">
                                <h6 v-if="searching">{{ $i18n.locale === 'en' ? 'Loading...' : 'লোড হচ্ছে...' }}</h6>
                                <h6 v-else>{{ $t('globalTrans.noDataFound') }}</h6>
                            </div>
                        </div>
                    </div>
                  </b-col>
                  <b-col sm="1" class="mob-mujib">
                      <div class="float-right">
                          <img src="../../../assets/images/mujib.png" width="70" alt="">
                      </div>
                  </b-col>
              </b-row>
          </b-container>
      </div>
  </div>
</template>
<script>
import { mapGetters, mapActions } from 'vuex'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
  // mixins: [commonMixin],
    components: {
    },
    name: 'Header',
    data: () => ({
        show: false,
        routeError: '',
        name: '',
        searching: false,
        awaitingSearch: false,
        services: []
    }),
    created () {
        this.loadData()
    },
    watch: {
        name: function (val) {
        if (!this.awaitingSearch) {
            setTimeout(() => {
            this.searchService()
            this.awaitingSearch = false
            }, 1200) // 1.2 sec delay
        }
        this.awaitingSearch = true
        }
    },
    computed: {
        ...mapGetters({
            currentLocale: 'Setting/currentLocale'
        }),
        langLabel: function () {
            return this.$i18n.locale === 'en' ? 'বাংলা' : 'English'
        },
        header () {
            return this.$store.state.Portal.header
        }
    },
    methods: {
        resetSearch () {
            this.name = ''
        },
        async searchService () {
            const search = {
                org_id: 0,
                customer_type_id: 0,
                service_category_id: 0,
                name: this.name
            }
            this.searching = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/service-searching', search)
            if (result.success) {
                this.services = result.data
            }
            this.searching = false
        },
        BangNum (n) {
            return this.$i18n.locale === 'en' ? n : n.replace(/\d/g, d => '০১২৩৪৫৬৭৮৯'[d])
        },
        changeLang () {
            this.$i18n.locale = this.$i18n.locale === 'bn' ? 'en' : 'bn'
            this.setLocale(this.$i18n.locale)
            // this.$store.dispatch('Portal/localizeCommonDropdown', { value: this.$i18n.locale })
        },
        ...mapActions({
            setLocale: 'Setting/setLocale'
        }),
        goLogin () {
            // this.show = !this.show
            this.$router.push('/auth/login').catch(error => {
                this.routeError = error
            })
        },
        goTo () {
            this.$router.push('/portal/home')
        },
        async loadData () {
            this.$store.dispatch('Portal/mutatePortalLoad', true)
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/header')
            this.$store.dispatch('Portal/mutatePortalLoad', false)
            if (result.success) {
                this.$store.dispatch('Portal/mutateHeader', result.data)
            }
        }
    }
}
</script>
<style scoped>
/* :root {
        --portal-brand: #214162;
        --portal-secondary: #4677AA;
    } */
    .header-wrapper {
        position: relative;
        z-index: 1000;
    }
    .top-header{
        background-color: var(--portal-brand);
    }
    .hotline{
        color: var(--light);
        display: block;
        /* font-size: medium; */
        margin-right: .5em;
    }
    .hotline i{
        padding-right: .3em;
        vertical-align: bottom;
    }
    .about_btn{
        color: var(--light);
        overflow: hidden;
        padding: 0.01rem 0.7rem 0.01rem 0;
        background: transparent !important;
        border-color: var(--primary) !important;
        border-radius: 15px;
    }
    .about_btn i{
        display: inline-block;
        margin: 0 8px 0 0;
        padding: 0 8px;
        color: var(--white);
        background: var(--primary);
        height: 30px;
        font-size: 1.3rem;
        vertical-align: middle;
        line-height: 1.8rem;
    }
    .login-signup-wrapper{
        position: relative;
    }
    .login-signup-wrapper .login-card .login-form-btn{
        color: #fff;
        background: var(--portal-secondary);
    }
    .login-signup-wrapper .login-card .login-form-btn:hover{
        color: #fff;
        background: var(--portal-brand);
    }
    .login-btn.show ~ .login-card{
        display: block;
    }
    .login-signup-wrapper .login-card{
        position: absolute;
        top: 40px;
        right: 0;
        padding: 12px;
        width: 230px;
        display: none;
        z-index: 5;
        border-top: 10px solid transparent;
        border-radius: 5px;
        animation: growOut 300ms ease-in-out forwards;
        transform-origin: top center;
        background-color: var(--white);
        box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
    }
    @keyframes growOut {
        0% {
            transform: scale(0)
        }
        80% {
            transform: scale(1.1)
        }
        100% {
            transform: scale(1)
        }
    }
    .login-signup-wrapper .login-card::after{
        content: "";
        position: absolute;
        top: -20px;
        left: 194px;
        width: 18px;
        height: 10px;
        border-bottom: 8px solid white;
        border-left: 8px solid #fff0;
        border-right: 8px solid transparent;
    }
    .main-header{
        display: flex;
        align-items: center;
        padding: .5em 0;
        background-color: var(--white);
        /* box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); */
        box-shadow: rgb(0 0 0 / 10%) 0px 20px 25px -5px, rgb(0 0 0 / 4%) 0px 10px 10px -5px;
    }
    .main-header .brand{
        display: flex;
        align-items: center;
    }
    .main-header .brand p{
        color: var(--portal-brand);
        font-size: large;
        font-weight: bolder;
        padding-left: .8em;
    }
    .main-header .search-bar{
        position: relative;
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
        justify-content: flex-end;
    }
    .main-header .search-bar .btn{
        position: absolute;
        right: 5px;
        top: 0;
        line-height: 40px;
        border-radius: 20px;
        color: var(--portal-brand);
        background: transparent !important;
        border-color: transparent !important;
    }
    .main-header .search-bar .btn i {
        font-size: 1.2rem;
        transition: 0.5s ease-in-out;
    }
    .main-header .search-bar .btn:hover i {
        font-size: 1.5rem;
    }
    .main-header .search-bar .form-control{
        margin-bottom: 0;
        border-radius: 20px;
        width: 60%;
    }
    .main-header .total-user {
        text-align: center;
    }
    .main-header .total-user .count {
        margin-bottom: -5px;
        color: var(--primary);
        font-weight: 600;
    }
    .main-header .total-user p {
        font-size: 0.8rem;
    }
    .main-searchbar-wrapper {
        position: relative;
    }
    .main-searchbar-wrapper .search-dropdown-wrapper {
        position: absolute;
        left: 0;
        top: 90%;
        padding: 10px 5px 5px;
        background: var(--white);
        border: 1px solid #eee;
        border-radius: 10px;
        box-shadow: rgb(0 0 0 / 40%) 0px 3px 8px;
        overflow-x: auto;
        height: 280px;
        z-index: 1000;
    }
    .main-searchbar-wrapper .search-dropdown-wrapper ul {
        margin: 0;
        padding: 0;
        list-style: none;
    }
    .main-searchbar-wrapper .search-dropdown-wrapper ul a {
        display: block;
        margin-bottom: 6px;
        padding: 8px;
        color: var(--portal-secondary);
        font-size: 0.8rem;
        background: transparent;
        border: 1px solid var(--portal-secondary);
        border-radius: 5px;
    }
    .main-searchbar-wrapper .search-dropdown-wrapper ul a:hover {
        color: var(--white);
        background: var(--portal-secondary);
        border-color: transparent;
    }
    .main-searchbar-wrapper .search-dropdown-wrapper ul a i {
        color: #cdc29a;
        font-size: 0.86rem;
        vertical-align: middle;
    }
    .search-dropdown-wrapper::-webkit-scrollbar {
        width: 5px;
        height: 5px;
        border-radius: 20px;
    }

    .search-dropdown-wrapper::-webkit-scrollbar-thumb {
        /* background: var(--gray-aaa); */
        border-radius: 20px;
    }

    .search-dropdown-wrapper::-webkit-scrollbar-track {
        background: transparent;
        border: none;
        border-radius: 20px;
    }
</style>
