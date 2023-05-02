<template>
    <div class="portal-service-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ checkBn ?  getParentName(comp, parentId).name_bn : getParentName(comp, parentId).name }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.services') }}</span></li>
                </ol>
            </b-container>
        </div>
        <b-container>
            <b-row>
                <b-col>
                    <b-tabs class="service-tab">
                        <b-tab :title="$t('portal.service_for_whom')" @click="loadComp('customerTypeList')" :active="comp === 'customerTypeList'">
                            <b-row v-if="comp === 'customerTypeList'">
                                <b-col sm="12" md="3">
                                    <CustomerTypeList></CustomerTypeList>
                                </b-col>
                                <b-col sm="12" md="9">
                                    <LoadService v-if="loading" />
                                    <ServiceList v-else :serviceList="filterServiceList" :comp="comp" :parentName="parentName" :parentId="parentId"></ServiceList>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab :title="$t('portal.what_kind_of_service')" @click="loadComp('categoryList')" :active="comp === 'categoryList'">
                            <b-row v-if="comp === 'categoryList'">
                                <b-col sm="12" md="3">
                                    <CategoryList></CategoryList>
                                </b-col>
                                <b-col sm="12" md="9">
                                    <LoadService v-if="loading" />
                                    <ServiceList v-else :serviceList="filterServiceList" :comp="comp" :parentName="parentName" :parentId="parentId"></ServiceList>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab :title="$t('portal.which_org_service')" @click="loadComp('orgList')" :active="comp === 'orgList'">
                            <b-row v-if="comp === 'orgList'">
                                <b-col sm="12" md="3">
                                    <OrgList></OrgList>
                                </b-col>
                                <b-col sm="12" md="9">
                                    <LoadService v-if="loading" />
                                    <ServiceList v-else :serviceList="filterServiceList" :comp="comp" :parentName="parentName" :parentId="parentId"></ServiceList>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab :title="$t('portal.all_service') + (totalService ? ' (' + $n(totalService) + ')' : '')" @click="allServiceRoute"></b-tab>
                        <template #tabs-end>
                            <li role="presentation" class="nav-item align-self-center ml-auto mr-2">
                                <b-form-input class="mb-0" style="border-radius: 10px;" size="sm" type="search"
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
    import CustomerTypeList from '../components/Services/CustomerType'
    import CategoryList from '../components/Services/CategoryList'
    import OrgList from '../components/Services/OrgList'
    import ServiceList from '../components/Services/ServiceList'
    import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
    import Common from '@/mixins/portal/common'
    import LoadService from '../components/Services/loading/service_loading'

    export default {
        mixins: [Common],
        components: {
            CustomerTypeList, CategoryList, OrgList, ServiceList, LoadService
        },
        data () {
            return {
                service_name: '',
                parentId: '',
                parentName: '',
                comp: 'customerTypeList',
                loading: false,
                filterServiceList: []
            }
        },
        created () {
            const search = {
                org_id: 0,
                customer_type_id: 0,
                service_category_id: 0
            }
            Object.keys(this.$route.query).map(key => {
                search[key] = parseInt(this.$route.query[key])
            })
            this.$store.dispatch('Portal/mutateSearch', search)
            this.setComp(this.$route.query)
            this.loadData()
        },
        computed: {
            searchData () {
                return this.$store.state.Portal.searchData.loading
            },
            totalService () {
                return this.$store.state.Portal.serviceData.total_services
            },
            serviceList () {
                return this.$store.state.Portal.serviceList
            }
        },
        watch: {
            searchData: function (newVal, oldVal) {
                this.loadData(newVal)
                this.setComp(this.$store.state.Portal.searchData)
            },
            service_name: function (newVal, oldVal) {
                if (newVal) {
                    const service = this.serviceList.filter(el => {
                    if (el.name.toLowerCase().includes(newVal.toLowerCase()) || el.name_bn.toLowerCase().includes(newVal.toLowerCase())) {
                        return el
                    }
                    })
                    this.filterServiceList = service
                } else {
                    this.filterServiceList = [...this.serviceList]
                }
            }
        },
        methods: {
            allServiceRoute () {
                window.scrollTo(0, 0)
                this.$router.push('/portal/all-services')
            },
            async loadData () {
                this.$Progress.start()
                this.loading = true
                const params = this.$store.state.Portal.searchData
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/service-list', params)
                this.loading = false
                if (result.success) {
                    this.$Progress.finish()
                    this.$store.dispatch('Portal/mutateServiceList', result.data)
                    this.filterServiceList = this.$store.state.Portal.serviceList
                } else {
                    this.$Progress.fail()
                }
            },
            loadComp (comp) {
                this.comp = comp
                const tmpSearch = this.setSearch(comp)
                this.$store.dispatch('Portal/mutateSearch', tmpSearch)
                this.loadData()
            },
            setComp (qRoute) {
                if (qRoute) {
                    if (qRoute.customer_type_id) {
                        this.comp = 'customerTypeList'
                        this.parentId = qRoute.customer_type_id
                        this.parentName = 'customer_type_id'
                    } else if (qRoute.service_category_id) {
                        this.comp = 'categoryList'
                        this.parentId = qRoute.service_category_id
                        this.parentName = 'service_category_id'
                    } else {
                        this.comp = 'orgList'
                        this.parentId = qRoute.org_id
                        this.parentName = 'org_id'
                    }
                }
            },
            setSearch (comp) {
                const search = {
                    org_id: 0,
                    customer_type_id: 0,
                    service_category_id: 0
                }
                if (comp === 'customerTypeList') {
                    const firstCus = this.$store.state.Portal.customerTypeList.slice(0, 1).shift()
                    return Object.assign(search, { customer_type_id: firstCus.id })
                } else if (comp === 'categoryList') {
                    const firstCat = this.$store.state.Portal.categoryList.slice(0, 1).shift()
                    return Object.assign(search, { service_category_id: firstCat.id })
                } else {
                    const firstOrg = this.$store.state.Portal.orgList.slice(0, 1).shift()
                    return Object.assign(search, { org_id: firstOrg.id })
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
