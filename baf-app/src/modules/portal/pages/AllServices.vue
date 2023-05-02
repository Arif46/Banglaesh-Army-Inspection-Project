<template>
    <div class="portal-service-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ getServiceTitle(0) }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ getServiceTitle(0) }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row>
                <b-col>
                    <b-tabs class="service-tab">
                        <b-tab @click="goToServiceType('customerTypeList')" :title="$t('portal.service_for_whom')"></b-tab>
                        <b-tab @click="goToServiceType('categoryList')" :title="$t('portal.what_kind_of_service')"></b-tab>
                        <b-tab @click="goToServiceType('orgList')" :title="$t('portal.which_org_service')"></b-tab>
                        <b-tab :title="getServiceTitle(1)" active>
                            <b-card-text class="all_service_wrapper">
                                <h5 class="service_title mt-2">{{ getServiceTitle(0) + ' ' + $t('globalTrans.list') }}</h5>
                                <div class="all-service-items">
                                    <LoadAllService v-if="loading"></LoadAllService>
                                    <b-row v-else>
                                        <b-col sm="6" v-for="(service, index) in serviceList" :key="index">
                                            <div class="service_item">
                                                <b-card class="service_item_card">
                                                    <router-link :to="`/portal/service-details?service_type=allService&service_id=${service.id}`">
                                                        <div class="item_all table-responsive">
                                                            <table class="table table-sm mb-0">
                                                                <tbody>
                                                                    <tr>
                                                                        <td style="width: 50%;">
                                                                            <div class="service_name">{{ checkBn ? service.name_bn : service.name }}</div>
                                                                            <small v-if="service.status === 1" class="counter_label">{{ $t('portal.active_service') }}</small>
                                                                            <small v-else class="counter_label">{{ $t('portal.upcoming_service') }}</small>
                                                                        </td>
                                                                        <td v-if="service.pr_service_applied">
                                                                            <div style="margin-bottom: -6px;">
                                                                                <span class="counter" style="visibility: visible;">{{ $n(service.applied_service) }} </span> {{ $t('portal.person') }}
                                                                            </div>
                                                                            <small class="counter_label">{{ $t('portal.applied_for_service') }}</small>
                                                                        </td>
                                                                        <td v-if="service.pr_target_customer">
                                                                            <div style="margin-bottom: -6px;">
                                                                                <span class="counter" style="visibility: visible;">{{ $n(service.target_customer) }}</span> {{ $t('portal.person') }}
                                                                            </div>
                                                                            <small class="counter_label">{{ $t('portal.target_customer') }}</small>
                                                                        </td>
                                                                    </tr>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </router-link>
                                                </b-card>
                                            </div>
                                        </b-col>
                                        <div v-if="!serviceList.length" class="service_item text-center">
                                            <h5>{{ $t('globalTrans.noDataFound') }}</h5>
                                        </div>
                                    </b-row>
                                </div>
                            </b-card-text>
                        </b-tab>
                        <template #tabs-end>
                            <li role="presentation" class="nav-item align-self-center ml-auto mr-2">
                                <b-form-input class="mb-0" style="border-radius: 10px;" size="sm" type="search"
                                    @keypress.enter="$event.preventDefault()"
                                    v-model="service_name"
                                    :placeholder="$t('portal.find_service')"></b-form-input>
                            </li>
                        </template>
                    </b-tabs>
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
    import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
    import Common from '@/mixins/portal/common'
    import LoadAllService from '../components/Services/loading/allservice_loading'

    export default {
        mixins: [Common],
        components: {
            LoadAllService
        },
        data () {
            return {
                service_name: '',
                loading: false,
                redirect_path: '',
                parentId: '',
                serviceList: [],
                allServiceList: []
            }
        },
        created () {
            this.loadData()
        },
        watch: {
            service_name: function (newVal, oldVal) {
                if (newVal) {
                    const service = this.allServiceList.filter(el => {
                    if (el.name.toLowerCase().includes(newVal.toLowerCase()) || el.name_bn.toLowerCase().includes(newVal.toLowerCase())) {
                        return el
                    }
                    })
                    this.serviceList = service
                } else {
                    this.serviceList = [...this.allServiceList]
                }
            }
        },
        computed: {
            totalService () {
                return this.$store.state.Portal.serviceData.total_services
            },
            checkBn () {
                return (this.$i18n.locale === 'bn') ? 1 : 0
            }
        },
        methods: {
            async loadData () {
                this.$Progress.start()
                this.loading = true
                let params = {}
                if (this.$route.query.status) {
                    params = { status: this.$route.query.status }
                }
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/service-list', params)
                this.loading = false
                if (result.success) {
                    this.$Progress.finish()
                    this.serviceList = result.data
                    this.allServiceList = result.data
                } else {
                    this.$Progress.fail()
                }
            },
            getServiceTitle (isCount) {
                if (this.$route.query.status) {
                    if (this.$route.query.status === 'active') {
                        return this.$t('portal.active_services') + (isCount ? ' (' + this.$n(this.serviceList.length) + ')' : '')
                    } else {
                        return this.$t('portal.upcoming_services') + (isCount ? ' (' + this.$n(this.serviceList.length) + ')' : '')
                    }
                } else {
                    return this.$t('portal.all_service') + (isCount ? ' (' + this.$n(this.totalService) + ')' : '')
                }
            },
            goToServiceType (comp) {
                if (comp === 'customerTypeList') {
                    const firstCus = this.$store.state.Portal.customerTypeList.slice(0, 1).shift()
                    this.redirect_path = '/portal/services?customer_type_id=' + firstCus.id
                } else if (comp === 'categoryList') {
                    const firstCat = this.$store.state.Portal.categoryList.slice(0, 1).shift()
                    this.redirect_path = '/portal/services?service_category_id=' + firstCat.id
                } else {
                    const firstOrg = this.$store.state.Portal.orgList.slice(0, 1).shift()
                    this.redirect_path = '/portal/services?org_id=' + firstOrg.id
                }
                if (this.redirect_path) {
                    this.$router.push({ path: this.redirect_path })
                }
            }
        }
    }
</script>
<style>
    .portal-service-wrapper .service-tab .nav-tabs{
        background-color: var(--portal-brand);
    }
    .portal-service-wrapper .service-badge{
        color: var(--portal-secondary);
        background-color: var(--white);
    }
</style>
