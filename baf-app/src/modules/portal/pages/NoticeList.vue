<template>
    <div class="portal news-list-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ $t('portal.notice_list') }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.notice') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row class="pb-4">
                <b-col sm="12" md="12">
                    <div class="portal">
                        <b-card text-variant="dark" header-tag="header" class="faq-accordion">
                            <NoticeLoading v-if="loading"></NoticeLoading>
                            <div v-else class="notice-list">
                                <b-list-group class="notice-title">
                                    <b-list-group-item v-for="(notice, index) in noticeList" :key="index" class="flex-column align-items-start">
                                        <div><h5 class="mb-1">{{ checkBn ? notice.title_bn : notice.title }}</h5></div>
                                        <p class="mb-1">{{ $t('globalTrans.date') }} : {{ notice.updated_at | dateFormat }}</p>
                                        <a class="font-weight-bold" target="_blank" :href="commonServiceBaseUrl + notice.attachment">{{ $t('globalTrans.download') }}</a>
                                    </b-list-group-item>
                                </b-list-group>
                            </div>
                        </b-card>
                    </div>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import NoticeLoading from '../components/Home/loading/notice_loading'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
    name: 'NoticeList',
    components: { NoticeLoading },
    data () {
        return {
            loading: false,
            commonServiceBaseUrl: commonServiceBaseUrl
        }
    },
    created () {
        this.loadData()
    },
    computed: {
        checkBn () {
            return (this.$i18n.locale === 'bn') ? 1 : 0
        },
        noticeList () {
            return this.$store.state.Portal.noticeList.filter(item => item.status === 1)
        }
    },
    methods: {
        async loadData () {
            this.$Progress.start()
            this.loading = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/notice-list', this.search)
            this.loading = false
            if (result.success) {
                this.$Progress.finish()
                this.$store.dispatch('Portal/mutateNoticeList', result.data)
            } else {
                this.$Progress.fail()
            }
        }
    }
}
</script>
<style>
.faq-accordion{
    background-color: #F4F4F4!important;
}
.faq-accordion .faq-body{
    padding: 10px;
    background-color: #ffffff!important;
    border: 1px solid #ddd!important;
    border-top: none;
}
.faq-btn{
    padding: 0.48rem 0.75rem;
    color: var(--white) !important;
    border-color: var(--gray-ddd) !important;
    background-color: var(--portal-secondary) !important;
}
.faq-btn.not-collapsed{
  color: #fff!important;
  background-color: #1d4ff4!important;
}
.faq-btn .up-arrow{
    display: none;
}
.faq-btn .down-arrow{
    display: block;
}
.faq-btn.not-collapsed .up-arrow{
  display: block;
}
.faq-btn.not-collapsed .down-arrow{
  display: none;
}
</style>
