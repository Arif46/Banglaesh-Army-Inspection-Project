<template>
    <b-overlay :show="loading">
        <main id="faq-page">
            <div class="faq-body">
                <div class="accordion" role="tablist">
                    <div class="faq-item" v-for="(item, index) in data" :key="index">
                        <div header-tag="header" role="tab">
                            <div class="box p-2 mb-2" v-b-toggle.accordion-2 v-b-toggle="'collapse' + index">
                                <div class="d-flex justify-content-between">
                                    <p class="text-info font-weight-bold">{{ ($i18n.locale === 'bn') ? item.title_bn : item.title_en }}</p>
                                    <i class="ri-arrow-up-s-line up-arrow"></i>
                                </div>
                            </div>
                        </div>
                        <b-collapse class="faq-content" :id="'collapse' + index" visible accordion="my-accordion" role="tabpanel">
                            <div class="box p-2">
                                <ul class="basic-list">
                                    <div class="box p-2" v-if="$i18n.locale === 'bn'">
                                        <div class="cusDescription" v-html="item.details_bn"></div>
                                    </div>
                                    <div class="box p-2" v-if="$i18n.locale === 'en'">
                                        <div class="cusDescription" v-html="item.details_en"></div>
                                    </div>
                                </ul>
                            </div>
                        </b-collapse>
                    </div>
                </div>
            </div>
        </main>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'Profile',
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
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/faq-list')
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
.cusDescription li:before {
    content: "\27A4";
    font-size: 1rem;
    text-align: right;
    min-width: 50px;
    padding-right: 8px;
    align-self: flex-start;
}
.faq-body .office{
    display: flex;
    justify-content: space-between;
}
.faq-body .office address{
    padding: 0.3rem;
    border-radius: 5px;
    width: 100%;
    border: 1px solid #ddd;
    margin: 0 1rem 1rem 0;
}
.faq-body .office address a{
    color: black;
}
</style>
