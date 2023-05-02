<template>
    <div class="news-list">
        <div class="section_title mb-3">
            <h5>{{ $t('rjsc_portal.all_news') }}</h5>
        </div>
        <b-overlay :show="loading">
            <b-row>
                <b-col sm="4" v-for="(item, index) in data" :key="index">
                    <div class="news-card">
                        <router-link :to="`/rjsc-portal/news-details/${item.id}`">
                            <div class="image">
                                <img :src="rjscServiceBaseUrl + 'storage/' + item.image" style="width: 100%; height: 100%;" class="center" :alt="item.title_en">
                            </div>
                            <div to="/" class="title">
                                <h6>{{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}</h6>
                            </div>
                        </router-link>
                        <div class="news-content">
                            <div class="entry-meta">
                                <div class="meta-item date"><small class="text-muted">{{ item.created_at | dateFromNow }}</small></div>
                            </div>
                            <p>
                                {{ ($i18n.locale === 'bn') ? item.description_bn : item.description_en }}
                            </p>
                        </div>
                    </div>
                </b-col>
            </b-row>
        </b-overlay>
        <!-- <div class="text-center">
            <button class="btn btn-success"><b-spinner small type="grow" label="Loading..."></b-spinner> Load More</button>
        </div> -->
    </div>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'newsList',
    data () {
        return {
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            data: []
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        async loadData () {
            this.loading = true
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/news-list')
            if (result.success) {
                this.data = result.data
            } else {
                this.data = []
            }
            this.loading = false
        }
    }
}
</script>
<style>
.news-card{
    margin-bottom: 1.6rem;
    position: relative;
    display: flex;
    flex-direction: column;
    min-width: 0;
    word-wrap: break-word;
    background-color: #fff;
    background-clip: border-box;
    border: 1px solid rgba(0, 0, 0, 0.125);
    border-radius: 0.25rem;
    box-shadow: 0 1px 3px 0 rgb(0 0 0 / 10%);
    transition: .4s all;
}
.news-card .image{
    width: 100%;
    height: 100%;
    max-height: 120px;
    overflow: hidden;
}
.news-card .image img{
    transition: .4s all;
}
.news-card:hover .image img{
    transform: scale(1.1) rotate(2deg);
}
.news-card:hover .title{
    color: var(--rjsc-brand);
}
.news-card .title {
    color: var(--dark);
    padding: .8rem .5rem 0 .8rem;
    transition: .4s all;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}
.news-card .news-content{
    padding: .8rem;
}
.news-card .news-content p{
    text-align:justify;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
