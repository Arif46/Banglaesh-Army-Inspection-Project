<template>
    <div class="news-details-page portal">
      <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/portal/news" target="_self" class="">{{ $t('portal.commerce_news') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.news_details') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row class="pb-4">
                <b-col sm="12" md="8">
                    <LoadNewsDetails v-if="loading" />
                    <b-card v-else>
                        <img :src="commonServiceBaseUrl + 'storage' + news.logo" alt="News Image" class="w-100">
                        <h4 class="font-weight-bold pt-4 pb-1">{{ ($i18n.locale == 'bn') ? news.title_bn : news.title }}</h4>
                        <b-card-text class="text-muted pb-2">
                            <!-- <div v-if="userLoad">
                                <b-skeleton animation="wave" width="100%"></b-skeleton>
                            </div>
                            <div v-else>
                                <i class="ri-user-line"></i> {{ checkBn ? user(news.user_id).name_bn : user(news.user_id).name }} &nbsp; <i class="ri-calendar-check-fill"></i> {{ dateFormat(news.updated_at) }}
                            </div> -->
                            <div>
                                <i class="ri-calendar-check-fill"></i> {{ dateFormat(news.updated_at) }}
                            </div>
                        </b-card-text>
                        <b-card-text class="text-justify">
                            {{ ($i18n.locale == 'bn') ? news.description_bn : news.description }}
                        </b-card-text>
                    </b-card>
                </b-col>
                <b-col sm="12" md="4">
                    <b-card text-variant="dark" header-tag="header" class="news-section">
                        <template #header>
                            <div class="d-flex card-title-wrapper">
                                <h6 class="mb-0 ml-2">{{ $t('portal.popular_news') }}</h6>
                            </div>
                        </template>
                        <LoadPopular v-if="newsLoading" />
                        <b-row v-else class="newsGroup newsSidebar">
                            <b-col cols="12" v-for="(news, index) in newsList.slice(0, 10)" :key="index">
                                <b-card class="mb-3">
                                    <img :src="commonServiceBaseUrl + 'storage' + news.logo" class="w-100" style="height: 140px">
                                    <router-link :to="`/portal/news-details/` + news.id" class="portal-text d-block p-2">
                                        <h6 class="pt-1 pb-2">{{ checkBn ? news.title_bn : news.title }}</h6>
                                        <!-- <small v-if="userLoad">
                                            <b-skeleton animation="wave" width="100%"></b-skeleton>
                                        </small>
                                        <small v-else class="text-muted"><i class="ri-user-line"></i> {{ checkBn ? user(news.user_id).name_bn : user(news.user_id).name }} &nbsp; <i
                                                class="ri-calendar-check-fill"></i> {{ dateFormat(news.updated_at) }}</small> -->
                                        <small class="text-muted"><i class="ri-calendar-check-fill"></i> {{ dateFormat(news.updated_at) }}</small>
                                        <b-card-text>
                                            {{ (checkBn ? shortString(news?.description_bn, 90) : shortString(news?.description, 90)) + '...' }}
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
    import LoadNewsDetails from './loading/newsdetails_loading'
    import LoadPopular from './loading/popular_loading'
    import RestApi, { authServiceBaseUrl, commonServiceBaseUrl } from '@/config/api_config'
    import moment from 'moment'

    export default {
        components: {
            LoadNewsDetails,
            LoadPopular
        },
        created () {
            window.scrollTo(0, 0)
            this.loadData()
        },
        data () {
            return {
                loading: false,
                commonServiceBaseUrl: commonServiceBaseUrl,
                newsLoading: false,
                news: {},
                newsList: [],
                userLoad: false,
                users: [],
                toPopular: true
            }
        },
        watch: {
            '$route.params.id': function (newVal, oldVal) {
                if (newVal !== oldVal) {
                    this.toPopular = false
                    this.loadData()
                }
            }
        },
        computed: {
            checkBn () {
                return (this.$i18n.locale === 'bn') ? 1 : 0
            }
        },
        methods: {
            dateFormat (value) {
                require('moment/min/locales.min')
                moment.locale(this.$i18n.locale)
                return moment(value).startOf('minute').fromNow()
            },
            shortString (str, n) {
                return (str.length > n) ? str.substr(0, n - 1) + '...' : str
            },
            user (id) {
                return this.users.find(item => item.id === parseInt(id))
            },
            async loadData () {
                if (this.toPopular) {
                    // this.userLoad = true
                    this.newsLoading = true
                }
                this.loading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/news/show', { id: this.$route.params.id })
                this.loading = false
                if (result.success) {
                    this.news = result.data
                    if (this.toPopular) {
                        this.loadPopular()
                    }
                }
            },
            async loadPopular () {
                this.newsLoading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/news/popular')
                this.newsLoading = false
                if (result.success) {
                    this.newsList = result.data
                    // const users = result.data.map(item => {
                    //     return item.user_id
                    // })
                    // const userIds = [this.news.user_id, ...users]
                    // this.loadUser(userIds)
                } else {
                    // this.loadUser([this.news.user_id])
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
    .news-section.card .newsGroup .card-body {
        padding: 0;
    }
    .news-section .newsGroup .card .card-body a {
        color: rgb(57, 57, 57);
        display: block;
        padding: .8em;
    }
    .news-section .newsGroup .card:hover .card-body a, .card-body a h6 {
        color: rgb(1, 99, 203);
    }
    .news-section .newsGroup .card:hover .card-body a h6 {
        color: rgb(1, 99, 203);
    }
    .news-section .newsGroup .card .card-body a h6 {
        color: var(--dark);
    }
</style>
