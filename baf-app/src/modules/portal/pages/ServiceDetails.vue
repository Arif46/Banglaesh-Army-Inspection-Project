<template>
    <div class="service-details-wrapper">
        <div class="banner-img-wrapper">
            <h2 class="cover-title">{{ checkBn ?  getParentName($route.query.service_type, parentId).name_bn : getParentName($route.query.service_type, parentId).name }}</h2>
            <img src="../../../assets/images/cover-img.jpg" alt="">
        </div>
        <!-- Breadcraumb  -->
        <div>
            <b-container>
                <ol class="breadcrumb custom-bread">
                    <li class="breadcrumb-item"><router-link to="/portal/home" target="_self" class="">{{ $t('portal.home') }}</router-link></li>
                    <li class="breadcrumb-item"><router-link to="/portal/all-services" target="_self" class="">{{ $t('portal.all_service') }}</router-link></li>
                    <li class="breadcrumb-item active"><span aria-current="location">{{ $t('portal.service_details') }}</span></li>
                </ol>
            </b-container>
        </div>
        <div class="service-description">
            <b-container v-if="loading">
                <LoadServiceDetail></LoadServiceDetail>
            </b-container>
            <b-container v-else>
                <h3 class="service-title">{{ checkBn ? service.name_bn : service.name }}</h3>
                <b-row class="mb-3">
                    <b-col lg="12" class="text-right">
                        <span v-if="service.pr_policy">
                            <a class="apply_btn" v-if="service.policy_attachment" :href="commonServiceBaseUrl + 'download-attachment?file=' + service.policy_attachment"><i class="ri-download-fill"></i> {{ $t('moc_portal.policy') + ' ' + $t('globalTrans.download') }}</a>
                        </span>
                    </b-col>
                </b-row>
                <b-row class="mb-3">
                    <b-col lg="12">
                        <!-- Export Trophy Circular  -->
                        <a v-if="hasCipEtCircular" href="javascript:" @click="setServiceUrl(service.service_url)">
                            <CIPCircularMarque ></CIPCircularMarque>
                        </a>
                        <!-- Delar Panel License requirment Notice -->
                        <a v-if="hasDealerLicenseNotice" href="javascript:" @click="setServiceUrl(service.service_url)">
                            <DealerRequirmentNotice ></DealerRequirmentNotice>
                        </a>
                        <!-- Tea Garden PDU Circular Notice -->
                        <a v-if="teaGardenPduNotice && service.name_bn === 'প্রফেশনাল কোর্স ম্যানেজমেন্ট'" href="javascript:" @click="setServiceUrl(service.service_url)">
                            <TeaGardenPduCircularNotice ></TeaGardenPduCircularNotice>
                        </a>
                        <!-- Trade Fair (Collect Fair Calender Circular) -->
                        <a v-if="service.service_url.indexOf('itf-calendar-circular') !== -1"
                            href="javascript:" @click="setServiceUrl(service.service_url)">
                            <ItfCalendarCircular></ItfCalendarCircular>
                        </a>
                        <!-- Trade Fair (Collect Fair Participation Circular) -->
                        <a v-if="service.service_url.indexOf('itf-participation-circular') !== -1"
                            href="javascript:" @click="setServiceUrl(service.service_url)">
                            <ItfParticipationCircular></ItfParticipationCircular>
                        </a>
                        <!-- Trade Fair (Collect Fair Circular Exhibition) -->
                        <a v-if="service.service_url.indexOf('itf-circular-exhibition') !== -1"
                            href="javascript:" @click="setServiceUrl(service.service_url)">
                            <ItfCircularExhibition></ItfCircularExhibition>
                        </a>
                        <!-- Trade Fair (DITF Participation Circular) -->
                        <a v-if="service.service_url.indexOf('circular-of-participation-ditf') !== -1"
                            href="javascript:" @click="setServiceUrl(service.service_url)">
                            <DitfParticipationCircular></DitfParticipationCircular>
                        </a>
                    </b-col>
                    <b-col lg="12" class="text-right mt-3">
                        <!-- Apply Button  -->
                        <span v-if="service.pr_attachment_form">
                            <a class="apply_btn" v-if="service.form_attachment" :href="commonServiceBaseUrl + 'download-attachment?file=' + service.form_attachment"><i class="ri-download-fill"></i> {{ $t('portal.form_download') }}</a>
                        </span>
                         <!-- Apply Button  -->
                        <span v-if="service.pr_apply_btn" class="ml-1">
                            <a href="javascript:" class="apply_btn" @click="setServiceUrl(service.service_url)"><i class="ri-send-plane-fill"></i> {{ $t('portal.apply_now') }}</a>
                        </span>
                        <!-- Only for BPC Portal -->
                        <span v-if="service.service_url.indexOf('bpc-landing-page') !== -1" class="ml-1">
                            <a href="javascript:" class="apply_btn" @click="setServiceUrl(service.service_url)"><i class="ri-send-plane-fill"></i> {{ $t('portal.go_to_bpc') }}</a>
                        </span>
                    </b-col>
                </b-row>
                <b-row class="mt-3">
                    <b-col sm="9">
                        <h3 class="mb-3 service-description-title">{{ $t('portal.service_description') }}</h3>
                        <p v-html="checkBn ? service.description_bn : service.description" class="mb-3 service-description"></p>
                        <!-- <p class="mb-3 service-description">{{ checkBn ? service.description_bn : service.description }}</p> -->
                    </b-col>
                    <b-col sm="3">
                        <img v-if="service.image" :src="commonServiceBaseUrl + 'storage' + service.image" class="img-fluid my-4" alt="Service Image">
                        <img v-else src="../../../assets/images/user/no-image.jpg" class="img-fluid my-4" alt="">
                    </b-col>
                </b-row>
                <b-row>
                    <b-col v-if="service.pr_service_applied" sm="4">
                        <b-card>
                            <b-card-title>{{ $n(service.applied_service) }} <small>{{ $t('portal.person') }}</small></b-card-title>
                            <b-card-text class="disc">
                                {{ $t('portal.applied_for_service') }}
                            </b-card-text>
                            <b-card-text class="small text-muted">{{ dateFormat(service.created_at) }}</b-card-text>
                        </b-card>
                    </b-col>
                    <!-- <b-col v-if="service.pr_service_received" sm="4">
                        <b-card>
                            <b-card-title>3,800 <small>{{ $t('portal.person') }}</small></b-card-title>
                            <b-card-text class="disc">
                                Got The Service
                            </b-card-text>
                            <b-card-text class="small text-muted">{{ dateFormat(service.created_at) }}</b-card-text>
                        </b-card>
                    </b-col> -->
                    <b-col v-if="service.pr_target_customer" sm="4">
                        <b-card>
                            <b-card-title>{{ $n(service.target_customer) }} <small>{{ $t('portal.person') }}</small></b-card-title>
                            <b-card-text class="disc">
                               {{ $t('portal.target_customer') }}
                            </b-card-text>
                            <b-card-text class="small text-muted">{{ dateFormat(service.created_at) }}</b-card-text>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col v-if="service.pr_service_time" sm="4">
                        <b-card class="service-desc-card">
                            <b-card-text>
                                {{ $t('portal.receiving_service') }}
                            </b-card-text>
                            <b-card-title>{{ $n(service.days_of_disposal) + ' ' + (checkBn ? 'দিন' : 'Days') }}</b-card-title>
                        </b-card>
                    </b-col>
                    <b-col sm="4" v-if="service.pr_fees">
                        <b-card class="service-desc-card">
                            <b-card-text>
                                {{ $t('portal.required_fees') }}
                            </b-card-text>
                            <b-card-title>
                                <b-list-group>
                                    <b-list-group-item class="text-left" v-for="(fee, index) in service.fees" :key="index">
                                        <h6><i class="far fa-hand-point-right"></i> {{ checkBn ? fee.name_bn : fee.name }} - {{ checkBn ? $n(fee.amount) + ' টাকা' : 'Tk. ' + fee.amount  }}</h6>
                                    </b-list-group-item>
                                </b-list-group>
                            </b-card-title>
                        </b-card>
                    </b-col>
                    <b-col sm="4">
                        <b-card class="service-desc-card">
                            <b-card-text>
                                {{ $t('portal.necessary_documents') }}
                            </b-card-text>
                            <b-card-title>
                                <b-list-group>
                                    <b-list-group-item class="text-left" v-for="(attach, index) in service.attachment" :key="index">
                                        <h6><i class="far fa-hand-point-right"></i> {{ checkBn ? attach.name_bn : attach.name }}</h6>
                                    </b-list-group-item>
                                </b-list-group>
                            </b-card-title>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row v-if="service.pr_service_process">
                    <b-col>
                        <b-card style="background: #fff;border-color: transparent;">
                            <b-card-title style="border-bottom: 1px solid #eee;padding-bottom: 15px;" class="mb-4">{{ $t('portal.step_to_get_service') }}</b-card-title>
                            <b-card-text>
                                <img v-if="service.process" :src="commonServiceBaseUrl + 'storage' + service.process" height="100px" class="img-fluid" alt="Process">
                                <img v-else src="../../../assets/images/1637378521.png" class="img-fluid" alt="">
                            </b-card-text>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="6">
                        <div class="mb-4 apply-btn-wrapper">
                            <b-button @click="$router.go(-1)" variant="light"><i class="ri-arrow-left-line"></i> {{ $t('portal.go_back') }}</b-button>
                        </div>
                    </b-col>
                    <b-col sm="6" v-if="service.pr_apply_btn">
                        <div class="text-right mb-4 apply-btn-wrapper">
                            <a href="javascript:" class="apply_btn" @click="setServiceUrl(service.service_url)"><i class="ri-send-plane-fill"></i> {{ $t('portal.apply_now') }}</a>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </div>
    </div>
</template>
<script>
import RestApi, { commonServiceBaseUrl } from '@/config/api_config'
import Common from '@/mixins/portal/common'
import LoadServiceDetail from './../components/Services/loading/service_detail_loading'
import moment from 'moment'
import CIPCircularMarque from './cip-et-circular/Marque'
import DealerRequirmentNotice from './license-dealer-notice/Marque'
import TeaGardenPduCircularNotice from './tea-garden-pdu-circular-notice/Marque'
import ItfCalendarCircular from './trade-fair/itf-calendar-circular/Marque'
import ItfParticipationCircular from './trade-fair/itf-participation-circular/Marque'
import ItfCircularExhibition from './trade-fair/itf-circular-exhibition/Marque'
import DitfParticipationCircular from './trade-fair/ditf-participation-circular/Marque'

export default {
    mixins: [Common],
    components: {
        LoadServiceDetail,
        CIPCircularMarque,
        DealerRequirmentNotice,
        ItfCalendarCircular,
        ItfParticipationCircular,
        ItfCircularExhibition,
        DitfParticipationCircular,
        TeaGardenPduCircularNotice
    },
    data () {
        return {
            loading: false,
            hasCipEtCircular: false,
            hasDealerLicenseNotice: false,
            teaGardenPduNotice: false,
            parentId: '',
            service: {},
            commonServiceBaseUrl: commonServiceBaseUrl
        }
    },
    computed: {
        commonProfile () {
            return this.$store.state.Auth.commonProfile
        }
    },
    created () {
        window.scrollTo(0, 0)
        this.setComp()
        this.loadData()
    },
    methods: {
        dateFormat (date) {
            require('moment/min/locales.min')
            moment.locale(this.$i18n.locale)
            return moment(date).startOf('minute').fromNow()
        },
        setComp () {
            if (this.$route.query.customer_type_id) {
                this.parentId = this.$route.query.customer_type_id
            } else if (this.$route.query.service_category_id) {
                this.parentId = this.$route.query.service_category_id
            } else {
                this.parentId = this.$route.query.org_id
            }
        },
        async setServiceUrl (serviceUrl, nextRoute = null) {
            // window.scrollTo(0, 0)
            const authUser = this.$store.state.Auth.authUser
            if ((authUser) && authUser.user_type === 1) {
                this.$toast.success({
                    title: 'Info',
                    message: this.$t('globalTrans.logout_admin_msg'),
                    color: '#D6E09B'
                })
                return
            }
            if (serviceUrl.indexOf('export-trophy-cip-panel') !== -1) {
                this.$router.push({ name: 'portal.cip_et_circular_list', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('dealer-panel') !== -1) {
                this.$router.push({ name: 'portal.license_dealer_notice', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('tea-garden-panel') !== -1) {
                this.$router.push({ name: 'portal.tea_garden_pdu_circular_notice', params: { name: this.service.name, name_bn: this.service.name_bn, service_url: serviceUrl } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('itf-calendar-circular') !== -1) {
                this.$router.push({ name: 'portal.itf_calendar_circular', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('itf-participation-circular') !== -1) {
                this.$router.push({ name: 'portal.itf_participation_circular', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('itf-circular-exhibition') !== -1) {
                this.$router.push({ name: 'portal.itf_circular_exhibition', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('circular-of-participation-ditf') !== -1) {
                this.$router.push({ name: 'portal.circular_of_participation_ditf', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }
            if (serviceUrl.indexOf('rjsc-portal') !== -1) {
                this.$router.push({ name: 'rjsc_portal.home', params: { name: this.service.name, name_bn: this.service.name_bn } }).catch(() => {})
                return
            }

            if (serviceUrl.indexOf('bpc-landing-page') !== -1) {
                this.$router.push(serviceUrl).catch(() => {})
                return
            }

            this.$store.dispatch('Portal/setServiceUrl', {
                externalPanelServiceUrl: serviceUrl,
                externalPanelCurrentServiceUrl: serviceUrl
            })
            this.$router.push('/auth/login').catch(() => {})
        },
        async loadData () {
            if (this.$route.query.service_id) {
                this.$Progress.start()
                this.loading = true
                const result = await RestApi.getData(commonServiceBaseUrl, '/portal/frontend/service/show', { id: this.$route.query.service_id })
                this.loading = false
                if (result.success) {
                    this.service = result.data
                    this.setSubsidyCircular()
                    this.$Progress.finish()
                }
            } else {
                this.$Progress.fail()
                this.$router.push('/portal/home').catch(() => {})
            }
        },
        setSubsidyCircular () {
            const componentId = this.service.component_id
            if (componentId === 10) {
                this.hasCipEtCircular = true
            } else if (componentId === 7) {
                this.hasDealerLicenseNotice = true
            } else if (componentId === 5) {
                this.teaGardenPduNotice = true
            }
        }
    }
}
</script>
<style>
@media (max-width: 575.98px) {
    .service-details-wrapper .service-description .service-title {
        margin-top: 10px;
        margin-bottom: 1.5rem;
        font-size: 1.3rem !important;
    }
    .service-details-wrapper .service-description .service-description-title {
        margin-top: 10px;
        margin-bottom: 5px;
        font-size: 1.2rem;
        font-weight: 600;
    }
    .service-details-wrapper .service-description .service-description {
        margin-bottom: 15px;
    }
    .apply-btn-wrapper a, .apply-btn-wrapper .btn {
        display: block;
        width: 100%;
        text-align: center;
    }
}
</style>
