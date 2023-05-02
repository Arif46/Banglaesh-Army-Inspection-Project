<template>
    <b-overlay :show="loading">
        <div class="news-details">
            <b-row>
                <b-col>
                    <div class="news-card">
                        <div>
                            <div class="image">
                                <img :src="rjscServiceBaseUrl + 'storage/' + data.image" style="width: 100%; height: 100%;" :alt="data.title_en">
                            </div>
                            <div to="/" class="title">
                                <h4>{{ ($i18n.locale === 'bn') ? data.title_bn : data.title_en }}</h4>
                            </div>
                        </div>
                        <div class="news-content">
                            <div class="entry-meta">
                                <div class="meta-item date"><small class="text-muted">{{ data.created_at | dateFromNow }}</small></div>
                            </div>
                            <p>{{ ($i18n.locale === 'bn') ? data.description_bn : data.description_en }}</p>
                        </div>
                    </div>
                </b-col>
            </b-row>
        </div>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'noticeDetails',
    data () {
        return {
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            data: ''
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        async loadData () {
            this.loading = true
            const params = Object.assign({}, { id: this.$route.params.id })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/single-news', params)
            if (result.success) {
                this.data = result.data
            } else {
                this.data = ''
            }
            this.loading = false
        }
    }
}
</script>
<style>
.news-card {
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

.news-card .image {
    width: 100%;
    height: 100%;
    max-height: 400px;
    overflow: hidden;
}

.news-card .image img {
    width: 100%;
    height: auto;
    transition: .4s all;
}

.news-card:hover .title {
    color: var(--rjsc-brand);
}

.news-card .title {
    color: var(--dark);
    padding: .8rem .5rem 0 .8rem;
    transition: .4s all;
}

.news-card .news-content {
    padding: .8rem;
}

.news-card .news-content p {
    margin-block: .6rem;
    text-align: justify;
}
</style>
