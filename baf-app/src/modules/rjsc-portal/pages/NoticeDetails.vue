<template>
    <b-overlay :show="loading">
        <div class="notice-details">
            <b-row>
                <b-col>
                    <div class="notice-card">
                        <div class="notice-action text-right">
                            <!-- <b-button class="btn btn-success" squared> <i class="ri-download-line"></i> Download Attachment</b-button> -->
                            <a v-if="data.attachment" title="Download Notice" class="btn btn-success law-btn mr-2" target="_blank" :href="rjscServiceBaseUrl + '' + data.attachment" squared><i
                                        class="ri-download-line"></i></a>
                        </div>
                        <div to="/" class="title">
                            <h4>{{ ($i18n.locale === 'bn') ? data.title_bn : data.title_en }}</h4>
                        </div>
                        <div class="notice-content">
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
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/single-notice', params)
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
.notice-card {
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

.notice-card:hover .title {
    color: var(--rjsc-brand);
}

.notice-card .title {
    color: var(--dark);
    padding: .8rem .5rem 0 .8rem;
    transition: .4s all;
}

.notice-card .notice-content {
    padding: .8rem;
}

.notice-card .notice-content p {
    margin-block: .6rem;
    text-align: justify;
}
</style>
