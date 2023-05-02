<template>
    <b-row>
        <b-col sm="9">
            <div class="serviceCategory">
                <loadService v-if="loading"></loadService>
                <b-card v-else no-body>
                    <b-tabs class="tab-header" card vertical nav-wrapper-class="w-cus-16 mob-services-tab-wrapper">
                        <b-tab active>
                            <template #title>
                                <div class="d-flex flex-column align-items-center">
                                    <img src="../../../../assets/images/portal-icon/services.svg" class="img-fluid" alt="">
                                    <span>{{ $t('portal.service_for_whom') }}</span>
                                </div>
                            </template>
                            <b-row>
                                <b-col v-for="(customerType, index) in serviceCustomerListView" :key="index" sm="6">
                                    <b-card class="service-card" text-variant="dark" header-tag="header">
                                        <template #header>
                                            <div class="d-flex justify-content-between align-item-center py-2">
                                                <div class="d-flex" @click="customerServiceRoute(customerType.id)" style="cursor: pointer">
                                                    <img
                                                        :src="commonServiceBaseUrl + 'storage' + customerType.image"
                                                        height="25px"
                                                        width="25px"
                                                        alt=""
                                                    />
                                                    <h6 class="mb-0 ml-2">{{ checkBn ? customerType.name_bn : customerType.name }}</h6>
                                                </div>
                                                <span class="card-service-count">{{ $n(customerType.service.length) }} {{ $t('portal.service') }}</span>
                                            </div>
                                        </template>
                                        <b-list-group>
                                            <b-list-group-item v-for="(service, index) in customerType.service.slice(0, 3)" :key="index" :title="checkBn ? service.name_bn : service.name" @click="customerDetailsRoute(customerType.id, service.id)" style="cursor:pointer">
                                                {{ checkBn ? service.name_bn : service.name }}
                                            </b-list-group-item>
                                        </b-list-group>
                                        <div class="more-service">
                                            <b-list-group>
                                                <b-list-group-item v-for="(service, index) in customerType.service" :key="index" :title="checkBn ? service.name_bn : service.name" @click="customerDetailsRoute(customerType.id, service.id)" style="cursor:pointer">
                                                    {{ checkBn ? service.name_bn : service.name }}
                                                </b-list-group-item>
                                            </b-list-group>
                                        </div>
                                    </b-card>
                                </b-col>
                                <b-col v-if="readmoreCust && serviceCustomerTypeList.length > 6" sm="12">
                                    <a @click="setOffsetCust" href="javascript:" class="float-right more-service-btn">{{ $t('portal.see_more') }}</a>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab>
                            <template #title>
                                <div class="d-flex flex-column align-items-center">
                                    <img src="../../../../assets/images/portal-icon/kind-of-service.svg" class="img-fluid" alt="">
                                    <span>{{ $t('portal.what_kind_of_service') }}</span>
                                </div>
                            </template>
                            <b-row>
                                <b-col v-for="(category, index) in categoryListView" :key="index" sm="6">
                                    <b-card class="service-card" text-variant="dark" header-tag="header">
                                        <template #header>
                                            <div class="d-flex justify-content-between align-item-center py-2">
                                                <div class="d-flex" @click="serviceCategoryRoute(category.id)" style="cursor: pointer">
                                                    <img
                                                        :src="commonServiceBaseUrl + 'storage' + category.logo"
                                                        height="25px"
                                                        width="25px"
                                                        alt=""
                                                    />
                                                    <h6 class="mb-0 ml-2">{{ checkBn ? category.name_bn : category.name }}</h6>
                                                </div>
                                                <span class="card-service-count">{{ $n(category.service.length) }} {{ $t('portal.service') }}</span>
                                            </div>
                                        </template>
                                        <b-list-group>
                                            <b-list-group-item v-for="(service, index) in category.service.slice(0, 3)" :key="index" :title="checkBn ? service.name_bn : service.name" @click="serviceCategoryDetailsRoute(category.id, service.id)" style="cursor:pointer">
                                                {{ checkBn ? service.name_bn : service.name }}
                                            </b-list-group-item>
                                        </b-list-group>
                                        <div class="more-service">
                                            <b-list-group>
                                                <b-list-group-item v-for="(service, index) in category.service" :key="index" :title="checkBn ? service.name_bn : service.name" @click="serviceCategoryDetailsRoute(category.id, service.id)" style="cursor:pointer">
                                                    {{ checkBn ? service.name_bn : service.name }}
                                                </b-list-group-item>
                                            </b-list-group>
                                        </div>
                                    </b-card>
                                </b-col>
                                <b-col v-if="readmoreCat && serviceCategoryList.length > 6" sm="12">
                                    <a @click="setOffsetCat" href="javascript:" class="float-right more-service-btn">{{ $t('portal.see_more') }}</a>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab>
                            <template #title>
                                <div class="d-flex flex-column align-items-center">
                                    <img src="../../../../assets/images/portal-icon/organization.svg" class="img-fluid" alt="">
                                    <span>{{ $t('portal.which_org_service') }}</span>
                                </div>
                            </template>
                            <b-row>
                                <b-col v-for="(org, index) in orgListView" :key="index" sm="6">
                                    <b-card class="service-card" text-variant="dark" header-tag="header">
                                        <template #header>
                                            <div class="d-flex justify-content-between align-item-center py-2">
                                                <div @click="serviceOrgRoute(org.id)" style="cursor: pointer" class="d-flex">
                                                    <img v-if="org.logo" width="25px" height="25px" :src="commonServiceBaseUrl + 'storage' + org.logo" alt="Org Logo"/>
                                                    <img v-else width="25px" height="25px" src="@/assets/images/logo.png" alt=""/>
                                                    <h6 class="mb-0 ml-2" :title="checkBn ? org.org_name_bn : org.org_name">{{ checkBn ? org.abbreviation_bn : org.abbreviation }}</h6>
                                                </div>
                                                <span class="card-service-count">{{ $n(org.service.length) }} {{ $t('portal.service') }}</span>
                                            </div>
                                        </template>
                                        <b-list-group>
                                            <b-list-group-item v-for="(service, index) in org.service.slice(0, 3)" :key="index" :title="checkBn ? service.name_bn : service.name" @click="serviceOrgDetailsRoute(org.id, service.id)" style="cursor:pointer">
                                                {{ checkBn ? service.name_bn : service.name }}
                                            </b-list-group-item>
                                        </b-list-group>
                                        <div class="more-service">
                                            <b-list-group>
                                                <b-list-group-item v-for="(service, index) in org.service" :key="index" :title="checkBn ? service.name_bn : service.name" @click="serviceOrgDetailsRoute(org.id, service.id)" style="cursor:pointer">
                                                    {{ checkBn ? service.name_bn : service.name }}
                                                </b-list-group-item>
                                            </b-list-group>
                                        </div>
                                    </b-card>
                                </b-col>
                                <b-col v-if="readmore && orgList.length > 6" sm="12">
                                    <a @click="setOffsetOrg" href="javascript:" class="float-right more-service-btn">{{ $t('portal.see_more') }}</a>
                                </b-col>
                            </b-row>
                        </b-tab>
                        <b-tab>
                            <template #title>
                                <div class="d-flex flex-column align-items-center">
                                    <!-- <i class="ri-stack-line" style="font-size:xx-large"></i> -->
                                    <img src="../../../../assets/images/portal-icon/all-services.svg" class="img-fluid" alt="">
                                    <span>{{ $t('portal.all_service') + ' (' + $n(totalService, { useGrouping: false }) + ')' }}</span>
                                </div>
                            </template>
                            <div class="all-services">
                                <b-row class="align-items-center">
                                    <b-col v-for="(service, index) in allService.slice(0, 14)" :key="index" sm="12" md="6">
                                        <router-link :to="`/portal/service-details?service_type=allService&service_id=` + service.id" class="service-list">{{ ($i18n.locale === 'bn') ? service.name_bn : service.name }}</router-link>
                                    </b-col>
                                </b-row>
                                <b-row class="justify-content-center">
                                    <b-col sm="5">
                                        <router-link to="/portal/all-services" class="more-service-btn w-100">{{ $t('portal.see_all_service') }}</router-link>
                                    </b-col>
                                </b-row>
                            </div>
                        </b-tab>
                    </b-tabs>
                </b-card>
            </div>
        </b-col>
        <!-- Serive Sidebar  -->
        <b-col sm="3">
            <loadSidebar v-if="loading"></loadSidebar>
            <div v-else class="portal service-sidebar-wrapper">
                <b-card>
                    <template #header>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex card-title-wrapper">
                                <h6 class="mb-0 ml-2">{{ $t('portal.active_service') }}</h6>
                            </div>
                            <router-link class="pr-3 portal-text mob-portal-text" to="/portal/all-services?status=active">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></router-link>
                        </div>
                    </template>
                    <div class="services">
                        <b-list-group>
                            <b-list-group-item v-for="(service, index) in serviceList" :key="index" @click="serviceDetailsRoute(service.id)" :title="checkBn ? service.name_bn : service.name">
                                {{ checkBn ? service.name_bn : service.name }}
                            </b-list-group-item>
                        </b-list-group>
                    </div>
                </b-card>
                <b-card>
                    <template #header>
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex card-title-wrapper">
                                <h6 class="mb-0 ml-2">{{ $t('portal.upcoming_service') }}</h6>
                            </div>
                            <router-link class="pr-3 portal-text mob-portal-text" to="/portal/all-services?status=inavtive">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></router-link>
                        </div>
                    </template>
                    <div class="services">
                        <b-list-group>
                            <b-list-group-item v-for="(service, index) in serviceListUp" :key="index" @click="serviceDetailsRoute(service.id)" :title="checkBn ? service.name_bn : service.name">
                                {{ checkBn ? service.name_bn : service.name }}
                            </b-list-group-item>
                        </b-list-group>
                    </div>
                </b-card>
            </div>
        </b-col>
    </b-row>
</template>

<script>
    import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
    import Common from '@/mixins/common'
    import loadService from './loading/service_loading'
    import loadSidebar from './loading/sidebar_loading'

    export default {
        name: 'ServiceCatagory',
        mixins: [Common],
        components: {
            loadService, loadSidebar
        },
        created () {
            this.loadData()
        },
        data () {
            return {
                commonServiceBaseUrl: commonServiceBaseUrl,
                readmoreCust: true,
                readmoreCat: true,
                readmore: true,
                loading: false,
                offsetCust: 6,
                offsetCat: 6,
                offset: 6,
                serviceCustomerListView: [],
                categoryListView: [],
                serviceCategoryList: [],
                orgListView: [],
                orgList: []
            }
        },
        watch: {
            serviceCategoryListAll: function (newVal, oldVal) {
                if (newVal !== oldVal) {
                    this.setServiceCategoryList(newVal)
                }
            },
            orgListAll: function (newVal, oldVal) {
                if (newVal !== oldVal) {
                    this.setOrgList(newVal)
                }
            },
            serviceCustomerTypeList: function (newVal, oldVal) {
                if (newVal && newVal !== oldVal) {
                    this.setCustomerList(newVal)
                }
            }
        },
        computed: {
            totalService () {
                return this.$store.state.Portal.serviceData.total_services
            },
            allService () {
                return this.$store.state.Portal.serviceData.serviceList.filter(service => service.status === 1)
            },
            serviceList () {
                return this.$store.state.Portal.serviceData.serviceList.filter(service => (parseInt(service.is_featured) === 1 && service.status === 1)).slice(0, 4)
            },
            serviceListUp () {
                return this.$store.state.Portal.serviceData.serviceList.filter(service => (parseInt(service.is_featured) === 1 && service.status === 2)).slice(0, 5)
            },
            serviceCustomerTypeList () {
                return this.$store.state.Portal.serviceData.serviceCustomerTypeList.filter(item => item.status === 1)
            },
            serviceCategoryListAll () {
                return this.$store.state.Portal.serviceData.serviceCategoryList
            },
            orgListAll: function () {
                return this.$store.state.Portal.serviceData.orgList
            }
        },
        methods: {
            setCustomerList (customerList) {
                if (customerList !== undefined && customerList.length > 0) {
                    this.serviceCustomerListView = this.serviceCustomerTypeList.slice(0, this.offsetCust)
                    return
                }
                this.serviceCustomerListView = []
            },
            setServiceCategoryList (serviceCatList) {
                if (serviceCatList !== undefined && serviceCatList.length > 0) {
                    this.serviceCategoryList = serviceCatList.filter(item => item.status === 1)
                    this.categoryListView = this.serviceCategoryList.slice(0, this.offsetCat)
                    return
                }
                this.categoryListView = []
            },
            setOrgList (orgList) {
                if (orgList !== undefined && orgList.length > 0) {
                    this.orgList = orgList.filter(item => item.status === 1)
                    this.orgListView = this.orgList.slice(0, this.offset)
                    return
                }
                this.orgListView = []
            },
            setOffsetCust () {
                const nowOffset = this.offsetCust + 4
                this.offsetCust = nowOffset
                if (this.serviceCustomerTypeList.length < nowOffset) {
                    this.serviceCustomerListView = this.serviceCustomerTypeList
                    this.readmoreCust = false
                } else {
                    this.serviceCustomerListView = this.serviceCustomerTypeList.slice(0, nowOffset)
                }
            },
            setOffsetCat () {
                const nowOffset = this.offsetCat + 4
                this.offsetCat = nowOffset
                if (this.serviceCategoryList.length < nowOffset) {
                    this.categoryListView = this.serviceCategoryList
                    this.readmoreCat = false
                } else {
                    this.categoryListView = this.serviceCategoryList.slice(0, nowOffset)
                }
            },
            setOffsetOrg () {
                const nowOffset = this.offset + 4
                this.offset = nowOffset
                if (this.orgList.length < nowOffset) {
                    this.orgListView = this.orgList
                    this.readmore = false
                } else {
                    this.orgListView = this.orgList.slice(0, nowOffset)
                }
            },
            serviceDetailsRoute (serviceId) {
                this.$router.push('/portal/service-details?service_type=allService&service_id=' + serviceId)
            },
            serviceOrgRoute (orgId) {
                this.$router.push('/portal/services?org_id=' + orgId)
            },
            serviceOrgDetailsRoute (orgId, serviceId) {
                this.$router.push('/portal/service-details?service_type=orgList&org_id=' + orgId + '&service_id=' + serviceId)
            },
            serviceCategoryRoute (categoryId) {
                this.$router.push('/portal/services?service_category_id=' + categoryId)
            },
            serviceCategoryDetailsRoute (categoryId, serviceId) {
                this.$router.push('/portal/service-details?service_type=categoryList&service_category_id=' + categoryId + '&service_id=' + serviceId)
            },
            customerServiceRoute (customerTypeId) {
                this.$router.push('/portal/services?customer_type_id=' + customerTypeId)
            },
            customerDetailsRoute (customerTypeId, serviceId) {
                this.$router.push('/portal/service-details?service_type=customerTypeList&customer_type_id=' + customerTypeId + '&service_id=' + serviceId)
            },
            async loadData () {
                this.$Progress.start()
                this.loading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/service')
                this.loading = false
                if (result.success) {
                    this.$Progress.finish()
                    this.$store.dispatch('Portal/mutateServiceData', result.data)
                } else {
                    this.$Progress.fail()
                }
            }
        }
    }
</script>
<style>
.serviceCategory {
    margin: 30px 0 0;
}
.serviceCategory .card {
    background: transparent;
    border-color: transparent;
}
.serviceCategory .card .card-body {
    padding: 0 0 1rem 1rem;
}
.serviceCategory .card .tabs .tab-content {
    min-width: 1%;
    padding: 0;
    border-radius: 10px;
    /* background: #fff;
    box-shadow: rgb(50 50 93 / 25%) 0px 2px 5px -1px, rgb(0 0 0 / 30%) 0px 1px 3px -1px; */
}
.serviceCategory .card .tab-header {
    border-color: transparent;
}
.serviceCategory .card .card-header{
    padding: 0 10px;
    height: 40px;
    color: var(--white);
    background-color: var(--portal-secondary);
    background: transparent;
    box-shadow: none;
    padding: 0 25px 0 0;
}
.serviceCategory .card.service-card {
    margin-bottom: 15px;
    height: fit-content;
    box-shadow: rgba(0, 0, 0, 0.4) 0px 3px 8px;
    border-radius: 10px;
}
.serviceCategory .card.service-card .card-header {
    padding: 0 10px;
    height: 40px;
    color: var(--white);
    background: var(--portal-brand);
    border-color: var(--gray-ddd);
    border-radius: 10px 10px 0 0;
}
.serviceCategory .card.service-card .card-header i {
    font-size: 1.6rem;
    line-height: 1.6rem;
}
.serviceCategory .card.service-card .card-header h6 {
    font-size: 0.9rem;
    font-weight: 600;
    line-height: 1.6rem;
}
.serviceCategory .card .card-header li {
    width: 100%;
}
/* .serviceCategory .card .tab-header ul{
    padding: 0;
} */
.serviceCategory .card.service-card .card-body {
    padding: 0;
    background: var(--white);
    border-radius: 0 0 0.5rem 0.5rem;
}
.serviceCategory .service-tab .card .card-body{
    background: url(../../../../assets/images/card-bg.png);
    background-position: bottom;
    background-size: cover;
}
.serviceCategory .card .card-header .nav-tabs{
    box-shadow: none;
    background-color: #eeeeee;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link {
    position: relative;
    color: #495057;
    background: var(--white);
    padding: 1rem;
    width: 100%;
    font-size: 0.9rem;
    font-weight: 600;
    text-align: center;
    border-bottom: 5px solid transparent;
    border-radius: 0;
    box-shadow: rgba(0, 0, 0, 0.19) 0 10px 20px, rgba(0, 0, 0, 0.23) 0 6px 6px;
    transition: all .2s ease-in-out;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link img{
    margin-bottom: 10px;
    width: 32px;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item:last-child .nav-link {
    margin-bottom: 0;
    border-radius: 0 0 10px 10px;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item:first-child .nav-link {
    border-radius: 10px 10px 0 0;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link:hover {
    color: var(--white);
    background-color: var(--portal-secondary);
}
.serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link.active {
    position: relative;
    color: var(--white);
    background-color: var(--portal-brand);
    transform: scale(1.1);
    border: none;
    border-radius: 10px;
    z-index: 10;
}
.serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link.active::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 100%;
    transform: translate(-1%, -50%);
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
    border-left: 10px solid var(--portal-brand);
}
.serviceCategory .card .tab-content .tab-pane .card-deck .card-body .card-text {
    font-weight: 500;
}
.serviceCategory .service-card .card-body > .list-group {
    margin: 5px 0;
    height: 99px;
    background: var(--white);
}
.serviceCategory .service-card .card-body > .list-group > .list-group-item {
    position: relative;
    padding: 6px 10px 6px 25px;
    border: none;
    transition: all .5s ease-in-out;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}
.serviceCategory .service-card .card-body .list-group .list-group-item:hover,
.serviceCategory .service-card .card-body .list-group .list-group-item:focus {
    color: var(--white);
    background: var(--portal-brand);
    border-radius: 4px;
    padding-left: 25px;
}
.serviceCategory .service-card .card-body .list-group .list-group-item::before {
    content: '-';
    position: absolute;
    top: 50%;
    left: 5%;
    transform: translate(-20%, -50%);
    transition: all .2s ease-in-out;
}
.serviceCategory .service-card .card-body .list-group .list-group-item:hover::before {
    left: 5%;
    transform: translate(-20%, -50%);
}
.serviceCategory .service-card {
    position: relative;
}
.serviceCategory .service-card .card-service-count{
    color: var(--white);
    padding: 0 10px;
    margin-top: -2px;
    text-align: center;
    /* width: 24px; */
    /* height: 24px; */
    line-height: 1.8;
    font-size: 0.96rem;
    font-weight: 600;
    overflow: hidden;
    border-radius: 3px;
    background: rgb(255 255 255 / 10%);
    /* box-shadow: rgb(0 0 0 / 16%) 0px 3px 6px, rgb(0 0 0 / 23%) 0px 3px 6px; */
}
.serviceCategory .service-card:hover .more-service{
    display: block;
    top: 100%;
}
.serviceCategory .service-card .more-service{
    padding: 6px 1px 1px 1px;
    position: absolute;
    top: 140px;
    left: 0;
    z-index: 10;
    width: 100%;
    min-width: 260px;
    display: none;
    overflow: hidden;
    border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    background-color: var(--portal-secondary);
    animation: growOut 300ms ease-in-out forwards;
    transform-origin: top center;
}
@keyframes growOut {
    0% {
        transform: scale(0)
    }
    80% {
        transform: scale(1.1)
    }
    100% {
        transform: scale(1)
    }
}
.serviceCategory .service-card .more-service::before{
    content: "";
    position: absolute;
    top: -10px;
    right: 40px;
    width: 0;
    height: 0;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    border-bottom: 10px solid var(--portal-brand);
}
.serviceCategory .more-service-btn {
    display: inline-block;
    margin-top: 6px;
    padding: 5px 15px;
    color: var(--portal-brand);
    background: rgb(255 255 255 / 30%);
    font-weight: 600;
    text-align: center;
    border: 1px solid var(--portal-brand);
    border-radius: 20px;
}
.serviceCategory .more-service-btn:hover {
    color: var(--white);
    background: var(--portal-secondary);
    border-color: var(--portal-brand);
}
.about-services-portal .about-text p{
    margin-bottom: .5rem;
}
.serviceCategory .service-card .more-service .list-group .list-group-item{
    padding: 0.5rem 1.4rem;
    padding-left: 25px;
    color: #f0f7ff;
    background-color: var(--portal-brand);
    border: none;
    border-bottom: 1px solid #13048b;
    transition: all .5s ease-in-out;
}
.serviceCategory .service-card .more-service .list-group .list-group-item:hover {
    padding-left: 28px;
    color: #13048b;
    background-color: #fffcfceb;
}
.serviceCategory .all-services .service-list {
    display: block;
    margin-bottom: 15px;
    padding: 8px 15px;
    color: var(--portal-brand);
    background: linear-gradient(to top, var(--white) 50%, var(--portal-secondary) 50%) bottom;
    background-repeat: repeat;
    background-size: 100% 200%;
    font-weight: 600;
    border: 1px solid #b2b8c3;
    border-left: 5px solid var(--portal-brand);
    border-right: 3px solid var(--portal-brand);
    border-radius: 20px;
    box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
    transition: 0.5s all;
}
.serviceCategory .all-services .service-list:hover {
    color: var(--white);
    background-position: 0% 0%;
}
.w-cus-16 {
    width: 16% !important;
}
/* Sidebar Css  */
.service-sidebar-wrapper {
    margin: 30px 0;
}
.service-sidebar-wrapper .card {
    margin-bottom: 10px;
    background: transparent;
    box-shadow: none;
}
.service-sidebar-wrapper .card .card-body {
    padding: 8px 0 0;
}
.service-sidebar-wrapper .card .card-body .services .list-group .list-group-item {
    margin-bottom: 6px;
    border: none;
    border-left: 4px solid var(--portal-brand);
    border-radius: 0;
    background: linear-gradient(to left, var(--white) 50%, var(--portal-secondary) 50%) right;
    background-size: 200%;
    border-radius: 0 10px 10px 0;
    box-shadow: #32325d40 0 2px 5px 1px, #0000004d 0 1px 5px -1px;
    transition: .5s ease-out;
    cursor: pointer;
    display: -webkit-box;
    -webkit-line-clamp: 1;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
    padding: 0.4rem 1rem;
    line-height: 34px;
}
.service-sidebar-wrapper .card .card-body .services .list-group .list-group-item:hover {
    color: var(--white);
    background-position: left;
}

/* Responsive Styles Start */
@media (max-width: 575.98px) {
    .serviceCategory {
        margin: 15px 0 0;
    }
    .serviceCategory .card {
        margin-bottom: 0;
    }
    .serviceCategory .card .card-body {
        padding: 0;
    }
    .mob-services-tab-wrapper.w-cus-16 {
        margin-bottom: 20px;
        width: 100% !important;
    }
    .mob-services-tab-wrapper .nav-tabs {
        display: flex;
        align-items: center;
        justify-content: flex-start;
        flex-direction: row !important;
        flex-wrap: nowrap;
        overflow: hidden;
        overflow-x: auto;
        background-color: transparent;
        padding: 0 0 15px 0 !important;
        box-shadow: none;
    }
    .serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link {
        display: block;
        margin-right: 15px;
        padding: 1.1rem 1rem;
        width: 124px;
        /* min-height: 135px; */
        border: 1px solid #f7f7f7;
        border-radius: 10px;
        box-shadow: rgba(50, 50, 93, 0.25) 0px 2px 5px -1px, rgba(0, 0, 0, 0.3) 0px 1px 3px -1px;
    }
    .serviceCategory .card .tab-header .nav-tabs .nav-item:last-child .nav-link {
        margin-right: 3px;
        border-radius: 10px;
    }
    .serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link.active {
        transform: scale(1);
        box-shadow: rgb(0 0 0 / 35%) 0px 5px 15px;
    }
    .serviceCategory .card .tab-header .nav-tabs .nav-item .nav-link.active::before {
        top: 100%;
        left: 50%;
        transform: translate(-35%, 0%);
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        border-top: 10px solid var(--portal-brand);
    }
    .serviceCategory .more-service-btn {
        width: 100%;
        background: #fff;
    }
    .portal .card {
        margin-bottom: 30px;
    }
    .portal .card .card-header {
        border-bottom-color: #3c4dab;
    }
    .portal .card .card-header .card-title-wrapper ~ a.mob-portal-text {
        color: #eee !important;
    }
    .faq-wrapper, .news-wrapper {
        padding-top: 2rem !important;
    }
    .mob-footer-links {
        margin-bottom: 2rem;
    }
    .footer-wrapper .middle-footer .footer-item h5 {
        margin-bottom: 0.7rem !important;
    }
    .mob-footer-item {
        margin: 2.3rem 0;
    }
    .bottom-footer .copyright {
        justify-content: center !important;
    }
    .footer-wrapper .bottom-footer .social_wrapper {
        text-align: center !important;
    }
    .portal-service-wrapper .tabs > div {
        overflow: hidden;
        overflow-x: auto;
        background-color: var(--portal-brand);
        border-radius: 10px;
        min-height: 150px;
    }
    .portal-service-wrapper .tabs .tab-content {
        overflow: hidden;
        background: transparent;
    }
    .portal-service-wrapper .service-tab .nav-tabs {
        background-color: transparent;
        flex-wrap: nowrap;
        box-shadow: none;
    }
    .portal-service-wrapper .service-tab .nav-tabs .nav-link {
        width: 120px;
        margin-right: 10px;
        background: rgb(255 255 255 / 15%);
        border-radius: 10px;
        text-align: center;
    }
    .portal-service-wrapper .service-tab .nav-tabs .nav-item .form-control {
        position: absolute;
        width: 85%;
        top: 92px;
        left: 50%;
        transform: translate(-50%, 0);
    }
    .portal-service-wrapper .tabs .tab-content .tab-pane .list-group {
        margin-bottom: 20px;
    }
    .portal-service-wrapper .tabs .service_list_wrapper .card_wrapper .apply_wrapper {
        justify-content: center;
        margin-top: 5px;
    }
    .banner-img-wrapper {
        height: 65px;
    }
    .portal-service-wrapper .tabs .tab-content .tab-pane .list-group .list-group-item {
        box-shadow: rgb(0 0 0 / 5%) 0px 0px 0px 1px, rgb(209 213 219) 0px 0px 0px 1px inset;
    }
}
</style>
