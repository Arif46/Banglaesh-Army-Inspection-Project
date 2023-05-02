<template>
    <div class="portal news-list-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ $t('portal.Q_A') }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.Q_A') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row class="pb-4">
                <b-col sm="12" md="12">
                    <div class="portal">
                        <b-card text-variant="dark" header-tag="header" class="faq-accordion">
                            <FaqLoading v-if="loading"></FaqLoading>
                            <div v-else role="tablist">
                                <div class="mb-1" v-for="(item, index) in faqList" :key="index">
                                    <div header-tag="header" class="faq-card" role="tab">
                                        <b-button @click="(single_faq.answer === index) ? single_faq.answer ='' : single_faq.answer = index" block class="faq-btn text-left">
                                            <div class="d-flex justify-content-between">
                                                <p>{{ ($i18n.locale === 'bn') ? item.title_bn : item.title }}</p>
                                                <i :class="single_faq.answer === index ? 'ri-arrow-up-s-line up-arrow' : 'ri-arrow-down-s-line down-arrow'"></i>
                                            </div>
                                        </b-button>
                                    </div>
                                    <b-collapse :visible="single_faq.answer === index ? true : false" accordion="my-accordion" role="tabpanel">
                                        <div class="faq-body">
                                            <b-card-text><strong>{{ $t('portal.answer') }}- </strong> {{ ($i18n.locale === 'bn') ? item.description_bn : item.description }}</b-card-text>
                                        </div>
                                    </b-collapse>
                                </div>
                            </div>
                        </b-card>
                    </div>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import FaqLoading from '../components/Home/loading/faq_loading'
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

export default {
    name: 'FAQ',
    components: { FaqLoading },
    data () {
        return {
            loading: false,
            single_faq: {
                answer: 0
            }
        }
    },
    created () {
        this.loadData()
    },
    computed: {
        faqList () {
            return this.$store.state.Portal.faqList.filter(item => item.status === 1)
        }
    },
    methods: {
        async loadData () {
            this.$Progress.start()
            this.loading = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/faq-list', this.search)
            this.loading = false
            if (result.success) {
                this.$Progress.finish()
                this.$store.dispatch('Portal/mutateFaqList', result.data)
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
