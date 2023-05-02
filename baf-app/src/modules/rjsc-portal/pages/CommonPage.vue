<template>
     <b-overlay :show="loading">
        <main id="contactUs">
            <div class="contact-us-page" v-if="data">
                <h4 v-if="data">
                    <div class="row">
                        <div class="col-10"> {{ $i18n.locale === 'en' ? data.attachment_name_en : data.attachment_name_bn}}</div>
                        <div class="col-2" style="text-align: right" v-if="data.attachment">
                            <a title="Download Notice" class="btn btn-success law-btn" target="_blank" :href="rjscServiceBaseUrl + '' + data.attachment">
                                <i class="ri-download-2-fill"></i>
                            </a>
                        </div>
                    </div>
                </h4>
                <div class="box p-2" v-if="$i18n.locale === 'en'">
                    <div class="cusDescription" v-html="data.details_en"></div>
                </div>
                <div class="box p-2" v-if="$i18n.locale === 'bn'">
                    <div class="cusDescription" v-html="data.details_bn"></div>
                </div>
            </div>
            <div class="contact-us-page text-center" v-if="!data">
                {{ $t('globalTrans.noDataFound') }}
            </div>
        </main>
    </b-overlay>
</template>
<script>
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
export default {
    name: 'CommonPage',
    props: ['id'],
    data () {
        return {
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            data: ''
        }
    },
    created () {
        this.getPageContent()
    },
    watch: {
        id: {
            handler: function (id) {
                this.getPageContent()
            },
            deep: true,
            immediate: true
        }
    },
    methods: {
        async getPageContent () {
            this.loading = true
            const params = Object.assign({}, { id: this.$route.params.id })
            const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/common-page', params)
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
  .cusDescription li:before {
    content: "\27A4";
    font-size: 1rem;
    text-align: right;
    min-width: 50px;
    padding-right: 8px;
    align-self: flex-start;
}
</style>
