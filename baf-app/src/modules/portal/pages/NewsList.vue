<template>
    <div class="portal news-list-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ $t('portal.commerce_news') }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.commerce_news') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <LoadNewslist v-if="loading" />
            <b-row v-else class="pb-4">
                <b-col sm="12" md="8">
                    <div class="news_item" v-for="(news, index) in newsList" :key="index">
                        <router-link :to="`/portal/news-details/` + news.id">
                            <div class="card overflow-hidden">
                                <div class="row no-gutters">
                                    <div class="col-sm-3">
                                        <div class="card-body">
                                            <img :src="commonServiceBaseUrl + 'storage' + news.logo" alt="News Image"
                                                class="news_cover_img rounded-0" style="height: 190px">
                                        </div>
                                    </div>
                                    <div class="col-sm-9">
                                        <div class="card-body news_summary">
                                            <h4 class="card-title">{{ checkBn ? news.title_bn : news.title }}</h4>
                                            <div class="card-text">
                                                <!-- <div v-if="userLoad">
                                                    <b-skeleton animation="wave" width="100%"></b-skeleton>
                                                </div>
                                                <div v-else class="timeline">
                                                    <small><i class="ri-user-line"></i> {{ checkBn ? user(news.user_id).name_bn : user(news.user_id).name }}</small>
                                                    <small><i class="ri-calendar-2-line"></i> {{ dateFormat(news.created_at) }}</small>
                                                </div> -->
                                                <div class="timeline">
                                                    <small><i class="ri-calendar-2-line"></i> {{ dateFormat(news.updated_at) }}</small>
                                                </div>
                                                <p class="details">{{ checkBn ? shortString(news?.description_bn, 200) : shortString(news?.description, 200) }}</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </router-link>
                    </div>
                </b-col>
                <b-col sm="12" md="4">
                    <b-card text-variant="dark" header-tag="header" class="news-section">
                        <template #header>
                            <div class="d-flex card-title-wrapper">
                                <h6 class="mb-0 ml-2">{{ $t('portal.popular_news') }}</h6>
                            </div>
                        </template>
                        <b-row class="newsGroup newsSidebar">
                            <b-col cols="12" v-for="(news, index) in newsList.slice(0, 10)" :key="index">
                                <b-card class="mb-3">
                                    <img :src="commonServiceBaseUrl + 'storage' + news.logo" class="w-100" style="height: 140px">
                                    <router-link :to="`/portal/news-details/` + news.id" class="portal-text d-block p-2">
                                        <h6 class="pt-1 pb-2">{{ checkBn ? news.title_bn : news.title }}</h6>
                                        <!-- <small v-if="userLoad">
                                            <b-skeleton animation="wave" width="100%"></b-skeleton>
                                        </small>
                                        <small v-else class="text-muted"><i class="ri-user-line"></i> {{ checkBn ? user(news.user_id).name_bn : user(news.user_id).name }} &nbsp; <i
                                                class="ri-calendar-check-fill"></i> {{ dateFormat(news.created_at) }}</small> -->
                                        <small class="text-muted"><i class="ri-calendar-check-fill"></i> {{ dateFormat(news.updated_at) }}</small>
                                        <b-card-text>
                                            {{ checkBn ? shortString(news?.description_bn, 90) : shortString(news?.description, 90) }}
                                        </b-card-text>
                                    </router-link>
                                </b-card>
                            </b-col>
                        </b-row>
                    </b-card>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
    import LoadNewslist from './loading/newslist_loading'
    import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
    import Common from '@/mixins/portal/common'
    import moment from 'moment'

    export default {
        mixins: [Common],
        components: {
            LoadNewslist
        },
        data () {
            return {
                loading: false,
                commonServiceBaseUrl: commonServiceBaseUrl,
                users: [],
                userLoad: false
            }
        },
        created () {
            window.scrollTo(0, 0)
            this.loadData()
        },
        computed: {
            newsList () {
                return this.$store.state.Portal.newsList
            }
        },
        methods: {
            shortString (str, n) {
                return (str.length > n) ? str.substr(0, n - 1) + '...' : str
            },
            user (id) {
                return this.users.find(item => item.id === parseInt(id))
            },
            dateFormat (value) {
                require('moment/min/locales.min')
                moment.locale(this.$i18n.locale)
                return moment(value).startOf('minute').fromNow()
            },
            async loadData () {
                this.loading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/news-list', this.search)
                this.loading = false
                if (result.success) {
                    this.$store.dispatch('Portal/mutateNewsList', result.data)
                    // const users = result.data.map(item => {
                    //     return item.user_id
                    // })
                    // this.loadUser(users)
                }
            },
            async loadUser (users) {
                this.userLoad = true
                const result = await RestApi.getData(authServiceBaseUrl, '/auth/portal/get-users', { user_ids: JSON.stringify(users) })
                this.userLoad = false
                if (result.success) {
                    this.users = result.data
                }
            }
        }
    }
</script>
<style>
    .newsSidebar .card .card-body{
        padding: 0;
    }
</style>
