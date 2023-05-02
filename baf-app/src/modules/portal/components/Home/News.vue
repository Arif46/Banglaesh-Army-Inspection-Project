<template>
    <div class="portal">
        <b-card text-variant="dark" header-tag="header" class="news-section">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">{{ $t('portal.news') }}</h6>
                    </div>
                    <router-link to="/portal/news" class="pr-3 portal-text">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></router-link>
                </div>
            </template>
            <NewsLoad v-if="loading"></NewsLoad>
            <b-row class="newsGroup">
                <b-col v-if="datas[0]" sm="12" md="12">
                    <b-card class="overflow-hidden mb-4">
                        <b-row>
                            <b-col sm="3">
                                <!-- <img src="../../../../assets/images/news3.jpeg" class="w-100" style="border-radius: 0" alt=""> -->
                                <img
                                    :src="commonServiceBaseUrl + 'storage' + datas[0].logo"
                                    class="img-fluid cover-img"
                                    alt="News Logo"
                                    loading="lazy"
                                />
                            </b-col>
                            <b-col sm="9" style="background: #f4f4f4;">
                                <router-link :to="`/portal/news-details/` + datas[0].id">
                                    <h6 class="pt-1 pb-2">{{ $i18n.locale === 'bn' ? datas[0].title_bn : datas[0].title }}</h6>
                                    <!-- <b-card-text class="text-muted mb-2"><i class="ri-user-line"></i> {{ $i18n.locale === 'bn' ? 'অ্যাডমিন' : 'admin' }} &nbsp; <i class="ri-calendar-check-fill"></i> {{ dateFormat(datas[0].created_at) }}</b-card-text> -->
                                    <b-card-text style="-webkit-line-clamp:4;">
                                        {{ $i18n.locale === 'bn' ? truncate(datas[0].description_bn, 200) : truncate(datas[0].description) }}
                                    </b-card-text>
                                </router-link>
                            </b-col>
                        </b-row>
                    </b-card>
                </b-col>
                <b-col sm="6" md="3" v-for="(item, index) in datas.filter((item, index)=>index !== 0)" :key="index">
                    <b-card class="mb-4 sub-card">
                        <div class="sub-cover-img">
                            <img :src="commonServiceBaseUrl + 'storage' + item.logo" class="img-fluid" alt="New logo"/>
                        </div>
                        <router-link :to="`/portal/news-details/` + item.id" class="sub-news-wrapper">
                            <h6>{{ ($i18n.locale === 'bn') ? item.title_bn : item.title }}</h6>
                            <!-- <small class="text-muted"><i class="ri-user-line"></i> {{ $i18n.locale === 'bn' ? 'অ্যাডমিন' : 'admin' }} &nbsp; <i class="ri-calendar-check-fill"></i> {{ dateFormat(item.created_at) }}</small> -->
                            <b-card-text>
                                <small>{{ ($i18n.locale === 'bn') ? truncate(item.description_bn, 100) : truncate(item.description, 100) }}</small>
                            </b-card-text>
                        </router-link>
                    </b-card>
                </b-col>
            </b-row>
        </b-card>
    </div>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import NewsLoad from './loading/news_loading.vue'
import moment from 'moment'

export default {
    name: 'News',
    components: {
        NewsLoad
    },
    created () {
        this.loadData()
    },
    data () {
        return {
            commonServiceBaseUrl: commonServiceBaseUrl,
            datas: [],
            loading: false
        }
    },
    methods: {
        newsDetails: function () {
            this.$router.push('/portal/news')
        },
        dateFormat (value) {
            require('moment/min/locales.min')
            moment.locale(this.$i18n.locale)
            return moment(value).startOf('minute').fromNow()
        },
        truncate (str, n) {
            return (str.length > n) ? str.substr(0, n - 1) + '' : str
        },
        async loadData () {
            this.loading = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/news-home')
            this.loading = false
            if (result.success) {
                this.datas = result.data
            }
        }
    }
}
</script>
<style>
.news-section.card .card-body {
    padding-bottom: 0;
}
.news-section.card .newsGroup .card-body {
    padding: 0;
}
/* .news-section.card .newsGroup .card {
    box-shadow: rgb(0 0 0 / 40%) 0px 3px 8px;
} */
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
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    color: var(--dark);
}
.news-section .newsGroup .card .card-body img{
    border-radius: 10px 10px 0 0;
}
.news-section .newsGroup .card .card-body img.cover-img {
    padding: 15px 0 15px 15px;
    border-radius: 0;
}
.news-section.card .newsGroup .sub-card .card-body {
    display: flex;
    justify-content: flex-start;
}
.news-section.card .newsGroup .sub-card .sub-cover-img {
    width: 35%;
}
.news-section.card .newsGroup .sub-card .sub-cover-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 10px 0 0 10px;
}
.news-section .newsGroup .card .card-body .card-text{
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
.news-section.card .newsGroup .sub-card .card-body .sub-news-wrapper {
    display: block;
    padding: 0.4em 0.2em 0.4em 0.4em;
    width: 65%;
}

@media (max-width: 575.98px) {
    .news-section .newsGroup .card .card-body img.cover-img {
        padding: 0;
    }
}
</style>
