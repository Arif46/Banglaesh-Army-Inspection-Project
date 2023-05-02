<template>
    <div class="service_list_wrapper">
        <b-card v-for="(service, index) in serviceList" :key="index" header-tag="header" footer-tag="div" class="card_wrapper">
            <template #header>
                <h5 class="title">{{ ($i18n.locale === 'bn') ? service.name_bn : service.name }}</h5>
                <div>
                    <span v-if="service.status === 1" class="badge service-badge">{{ $t('portal.active_service') }}</span>
                    <span v-else class="badge service-badge">{{ $t('portal.upcoming_service') }}</span>
                </div>
            </template>
            <div class="row no-gutters">
                <div class="col-md-9">
                    <p class="card-text text-justify" v-html="($i18n.locale === 'bn') ? truncate(service.description_bn, 300) : truncate(service.description, 300)"></p>
                    <!-- <p class="card-text text-justify">{{ ($i18n.locale === 'bn') ? truncate(service.description_bn, 300) : truncate(service.description, 300) }}</p> -->
                    <router-link :to="`/portal/service-details?service_type=${comp}&${parentName}=${parentId}&service_id=${service.id}`" class="card-text details_link">
                        <p class="read_more d-inline-block mb-0">
                            {{ $t('portal.read_more') }} <i class="fas fa-long-arrow-alt-right"></i>
                        </p>
                    </router-link>
                </div>
                <div class="col-md-3">
                    <div class="apply_wrapper">
                        <a v-if="service.pr_apply_btn" @click="setServiceUrl(service)" href="javascript:void" class="apply_btn">
                            <i class="ri-send-plane-fill"></i> {{ $t('portal.apply_now') }}
                        </a>
                    </div>
                </div>
            </div>
            <!-- <template #footer>
                <span  v-if="service.pr_service_applied"> {{ $t('portal.applied_for_service') }} : <span class="counter"
                        style="visibility: visible;"> {{ $n(service.applied_service) }} </span> {{ $t('portal.person') }} </span>
                <span class="line_border d-none d-sm-inline-block"></span>
                <span v-if="service.pr_target_customer">{{ $t('portal.target_customer') }} : <span class="counter"
                        style="visibility: visible;">{{ $n(service.target_customer) }}</span> {{ $t('portal.person') }} </span>
            </template> -->
        </b-card>
        <div v-if="!serviceList.length" class="service_item text-center">
            <h5>{{ $t('globalTrans.noDataFound') }}</h5>
        </div>
    </div>
</template>

<script>
export default {
    props: ['serviceList', 'comp', 'parentName', 'parentId'],
    data () {
        return {
        }
    },
    created () {
    },
    computed: {
        // serviceList () {
        //     return this.$store.state.Portal.serviceList
        // }
    },
    methods: {
        truncate (str, n) {
            return (str.length > n) ? str.substr(0, n - 1) + '' : str
        },
        setServiceUrl (service) {
            const serviceUrl = service.service_url
            // window.scrollTo(0, 0)
            const authUser = this.$store.state.Auth.authUser
            if ((authUser) && authUser.user_type === 1) {
                return
            }

            if (serviceUrl.indexOf('export-trophy-cip-panel') !== -1) {
                this.$router.push({ name: 'portal.cip_et_circular_list', params: { name: service.name, name_bn: service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('itf-calendar-circular') !== -1) {
                this.$router.push({ name: 'portal.itf_calendar_circular', params: { name: service.name, name_bn: service.name_bn } }).catch(() => {})
                return
            }

            if (serviceUrl.indexOf('itf-participation-circular') !== -1) {
                this.$router.push({ name: 'portal.itf_participation_circular', params: { name: service.name, name_bn: service.name_bn } }).catch(() => {})
                return
            }

            this.$store.dispatch('Portal/setServiceUrl', {
                externalPanelServiceUrl: serviceUrl,
                externalPanelCurrentServiceUrl: serviceUrl
            })
            this.$router.push('/auth/login').catch(() => {})
        }
    }
}
</script>
