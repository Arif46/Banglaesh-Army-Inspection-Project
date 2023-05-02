<template>
    <main>
        <div class="section_title mb-3">
            <h5>{{ $t('rjsc_portal.all_notice') }}</h5>
        </div>
        <b-overlay :show="loading">
            <div class="notice-body">
                <div class="notice">
                    <ul>
                        <li class="d-flex justify-content-between align-items-center" v-for="(item, index) in data" :key="index">
                            <div class="d-flex align-items-center">
                                <span class="law-sl"><i class="far fa-file-pdf"></i></span>
                                <a :href="`/rjsc-portal/notice-details/${item.id}`">{{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}</a>
                            </div>
                            <div class="law-btn">
                                <a v-if="item.attachment" title="Download Notice" class="btn law-btn mr-2" target="_blank" :href="rjscServiceBaseUrl + '' + item.attachment">
                                    <i class="ri-download-2-fill"> </i>
                                </a>
                                <a v-if="!item.attachment" :title="$t('globalTrans.noDataFound')" class="btn law-btn mr-2" style="color:#EBEBE4"><i class="ri-download-2-fill"> </i></a>
                                <router-link class="m-auto" :to="`/rjsc-portal/notice-details/${item.id}`"><i class="ri-eye-line"></i></router-link>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </b-overlay>
    </main>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'noticeList',
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
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/notice-list')
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
.notice-body .notice {
    display: flex;
    height: auto;
}

.notice-body .notice ul {
    width: 100%;
}

.notice-body .notice ul li {
    padding: 0.2rem;
    margin-bottom: 1rem;
    background-color: #fff;
    box-shadow: rgba(0, 0, 0, 0.16) 0px 1px 4px;
}

.notice-body .notice .law-btn {
    transition: all .3s linear;
    display: flex;
}

.notice-body .notice .law-btn a {
    font-weight: 600;
    font-size: 1.1rem;
}

.notice-body .notice ul li:nth-child(even) .law-btn a {
    color: #32AF2D;
}

.notice-body .notice ul li:nth-child(odd) .law-btn a {
    color: #056CE5;
}

.notice-body .notice .law-sl {
    color: #fff;
    padding: .2rem;
    width: 35px;
    height: 35px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 35px;
}

.notice-body .notice ul li:nth-child(even) .law-sl {
    background-color: #32AF2D;
}

.notice-body .notice ul li:nth-child(odd) .law-sl {
    background-color: #056CE5;
}

.notice-body .notice ul li:last-child {
    margin-bottom: 0;
}

.notice-body .notice ul li a {
    display: block;
    font-size: .9rem;
    color: var(--dark);
    padding: .5rem;
}
</style>
