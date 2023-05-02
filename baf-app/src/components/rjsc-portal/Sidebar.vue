<template>
    <b-overlay :show="loading">
        <div class="sidebar-wrapper">
            <div class="news-wrapper">
                <b-card header-tag="header">
                    <template #header>
                        <div class="title-header">
                            <div class="ticon">
                                <i class="ri-newspaper-fill"></i>
                                <h6 class="mb-0 ml-2">{{ $t('rjsc_portal.news') }}</h6>
                            </div>
                            <router-link to="/rjsc-portal/news-list">{{ $t('rjsc_portal.read_more') }}</router-link>
                            <!-- <router-link to="/">{{ $t('rjsc_portal.read_more') }}</router-link> -->
                        </div>
                    </template>
                        <b-list-group flush>
                            <b-list-group-item :href="`/rjsc-portal/news-details/${item.id}`" v-for="(item, index) in newsData" :key="index">
                                {{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}
                            </b-list-group-item>
                        </b-list-group>
                </b-card>
            </div>

            <div class="notice-wrapper">
                <b-card header-tag="header">
                    <template #header>
                        <div class="title-header">
                            <div class="ticon">
                                <i class="ri-article-line"></i>
                                <h6 class="mb-0 ml-2">{{ $t('rjsc_portal.notice') }}</h6>
                            </div>
                            <router-link to="/rjsc-portal/notice-list">{{ $t('rjsc_portal.read_more') }}</router-link>
                            <!-- <router-link to="/">{{ $t('rjsc_portal.read_more') }}</router-link> -->
                        </div>
                    </template>
                        <b-list-group flush>
                            <b-list-group-item :href="`/rjsc-portal/notice-details/${item.id}`" v-for="(item, index) in noticeData" :key="index">
                                {{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}
                            </b-list-group-item>
                        </b-list-group>
                </b-card>
            </div>
        </div>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'News',
    data () {
        return {
            loading: false,
            noticeData: [],
            newsData: []
        }
    },
    created () {
        this.getNoticeData()
        this.getNewsData()
    },
    methods: {
        async getNoticeData () {
            this.loading = true
            const params = Object.assign({}, { entity_sector_id: 1 })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/notice', params)
            if (result.success) {
                this.noticeData = result.data
            } else {
                this.noticeData = []
            }
            this.loading = false
        },
        async getNewsData () {
            this.loading = true
            const params = Object.assign({}, { entity_sector_id: 1 })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/news', params)
            if (result.success) {
                this.newsData = result.data
            } else {
                this.newsData = []
            }
            this.loading = false
        }
    }
}
</script>
<style>
.sidebar-wrapper{
    position: sticky;
    top: 1rem;
}
.sidebar-wrapper .card{
    border: none;
    background: transparent;
    box-shadow: 0 1px 3px 0 rgb(0 0 0 / 10%);
}
.sidebar-wrapper .card .card-header {
    color: var(--white);
    padding: 0;
    margin-bottom: .1rem;
    border: none;
    background-color: transparent;
    background-image: url(../../assets/images/rjsc-portal/title-pattern.png);
}
.sidebar-wrapper .card .card-body{
    padding: 0;
}
.sidebar-wrapper .card .card-header .title-header {
    display: flex;
    padding: 0.4rem;
    background: var(--rjsc-title-bg);
    justify-content: space-between;
    align-items: center;
}
.sidebar-wrapper .card .card-header .title-header a{
    color: var(--light);
}
.sidebar-wrapper .card .card-header .title-header .ticon{
    display: flex;
    justify-content: space-between;
    align-items: center;
}
.sidebar-wrapper .list-group-item-action {
    border-left: 3px solid transparent;
}
.sidebar-wrapper .list-group-item-action:hover,
.list-group-item-action:focus {
    color: var(--rjsc-brand);
    border-color:var(--rjsc-brand);
    border-bottom: 1px solid rgba(0, 0, 0, 0.125);
}
</style>
