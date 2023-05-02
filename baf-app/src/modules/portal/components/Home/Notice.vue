<template>
    <div class="portal notice-wrapper">
        <b-card text-variant="dark" header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">{{ $t('portal.notice_list') }}</h6>
                    </div>
                    <router-link to="/portal/notice" class="pr-3 portal-text">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></router-link>
                </div>
            </template>
            <LoadNotice v-if="loading"></LoadNotice>
            <div v-else class="notice-list">
                <b-list-group class="notice-title">
                    <b-list-group-item v-for="(item, index) in notice" :key="index" class="flex-column align-items-start">
                        <div>
                            <router-link to="/portal/notice">
                                <h5 class="mb-1">{{ (checkBn) ? item.title_bn : item.title }}</h5>
                            </router-link>
                        </div>
                        <p class="mb-1">
                            {{ checkBn ? truncate(item.description_bn, 150) : truncate(item.description) }}
                        </p>
                    </b-list-group-item>
                </b-list-group>
            </div>
        </b-card>
    </div>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
    name: 'Notice',
    components: {
        LoadNotice: () => import('./loading/notice_loading')
    },
    created () {
        this.loadData()
    },
    data () {
        return {
            commonServiceBaseUrl: commonServiceBaseUrl,
            notice: {},
            loading: false
        }
    },
    computed: {
        checkBn () {
            return (this.$i18n.locale === 'bn') ? 1 : 0
        }
    },
    methods: {
        truncate (str, n) {
            return (str.length > n) ? str.substr(0, n - 1) + '' : str
        },
        async loadData () {
            this.loading = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/notice-home')
            this.loading = false
            if (result.success) {
                this.notice = result.data.filter(item => item.status === 1)
            }
        }
    }
}
</script>
<style>
.notice-list::-webkit-scrollbar{
    width: 3px;
}
.notice-wrapper .card .card-body{
    padding: 5px;
}
.notice-list{
    height: 298px;
    overflow-y: auto;
    margin-bottom: 8px;
}
.notice-list .list-group-item{
    border: none;
    border-bottom: 1px solid #bbb;
}
.notice-list .list-group-item p {
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    font-size: 0.8rem;
    color: var(--font-color);
}
.notice-list .list-group-item:hover{
    color: #fff;
    background-color: var(--portal-secondary);
}
.notice-list .list-group-item:hover h5, .notice-list .list-group-item:hover p {
    color: #fff;
}
.portal .notice-title h5{
    color: var(--portal-brand);
    font-size: 15px;
    white-space: nowrap;
    width: 100%;
    overflow: hidden;
    text-overflow: ellipsis;
    transition: .5s all;
    }
</style>
