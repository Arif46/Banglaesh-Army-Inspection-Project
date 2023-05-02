<template>
    <div class="portal">
        <b-card text-variant="dark" header-tag="header" class="faq-accordion">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">{{ $t('portal.Q_A') }}</h6>
                    </div>
                    <router-link to="/portal/faq" class="pr-3 portal-text">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></router-link>
                </div>
            </template>
            <FAQ v-if="loading"></FAQ>
            <div v-else role="tablist">
                <div class="mb-1" v-for="(item, index) in datas" :key="index">
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
                            <b-card-text><strong>{{ $t('portal.answer') }}- </strong> {{ ($i18n.locale === 'bn') ? truncate(item.description_bn, 300) : truncate(item.description, 300) }}...</b-card-text>
                        </div>
                    </b-collapse>
                </div>
            </div>
        </b-card>
    </div>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import FAQ from './loading/faq_loading.vue'

export default {
    name: 'Faq',
    components: {
        FAQ
    },
    data () {
        return {
            loading: false,
            datas: {},
            single_faq: {
                answer: 0
            }
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        truncate (str, n) {
            return (str.length > n) ? str.substr(0, n - 1) + '' : str
        },
        async loadData () {
            this.loading = true
            const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/qa-home')
            this.loading = false
            if (result.success) {
                this.datas = result.data.filter(item => item.status === 1)
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
/* .faq-btn .up-arrow{
    display: none;
} */
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
