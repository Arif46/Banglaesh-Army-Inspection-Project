<template>
    <div class="portal news-list-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ $t('portal.about_service_portal') }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.about_service_portal') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row class="pb-4">
                <b-col sm="12" md="12">
                    <div v-if="loading" class="text-center" style="height: 100px">
                        <b-spinner variant="primary" label="Spinning"></b-spinner>
                    </div>
                    <p class="text-justify" v-else v-html="checkBn ? aboutPortal?.description_bn : aboutPortal?.description"></p>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
    import RestApi, { commonServiceBaseUrl } from '@/config/api_config'

    export default {
        name: 'AboutPortal',
        components: {},
        data () {
            return {
                loading: false,
                aboutPortal: {}
            }
        },
        created () {
            window.scrollTo(0, 0)
            this.loadData()
        },
        computed: {
            checkBn () {
                return (this.$i18n.locale === 'bn') ? 1 : 0
            }
        },
        methods: {
            async loadData () {
                this.$Progress.start()
                this.loading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/about-service-portal', null)
                this.loading = false
                if (result.success) {
                    this.$Progress.finish()
                    this.aboutPortal = result.data
                } else {
                    this.$Progress.fail()
                }
            }
        }
    }
</script>
