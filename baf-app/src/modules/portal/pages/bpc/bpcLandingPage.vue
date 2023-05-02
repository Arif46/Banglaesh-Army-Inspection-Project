<template>
    <div class="bpc-wrapper">
        <b-container class="portal-container">
            <b-breadcrumb class="custom-bread">
                <b-breadcrumb-item to="/portal/home">{{ $t('portal.home')}}</b-breadcrumb-item>
                <b-breadcrumb-item active to="/portal/bpc-landing-page">{{ $t('portal.bpc_langing_page')}}</b-breadcrumb-item>
            </b-breadcrumb>
        </b-container>
        <section class="slider-section">
            <b-container class="portal-container">
                <b-row>
                    <b-col>
                        <div class="slider">
                            <vueper-slides :arrows-outside="false" class="no-shadow" :visible-slides="1" slide-multiple :gap="3"
                                :dragging-distance="200" :autoplay="true"
                                :breakpoints="{ 800: { visibleSlides: 2, slideMultiple: 2 } }">
                                <vueper-slide v-for="(slide, i) in slides" :key="i" :image="slide.image" />
                                <!-- <div class="slide">
                                    <h2>{{ slide.title_en }}</h2>
                                </div> -->
                            </vueper-slides>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </section>
        <section class="promotion-index">
            <b-container class="portal-container">
                <b-row>
                    <div class="grid-container">
                        <div class="grid-item">
                            <router-link to="/portal/bpc-product-view" class="card">
                                <div class="icon">
                                    <img src="../../../../assets/images/portal-icon/bpc/1.svg">
                                </div>
                                <h6 class="title">{{ $t('portal.online_product_dvertisement') }}</h6>
                            </router-link>
                        </div>
                        <div class="grid-item">
                            <router-link to="/portal/bpc-event-list" class="card">
                                <div class="icon">
                                    <img src="../../../../assets/images/portal-icon/bpc/2.svg">
                                </div>
                                <h6 class="title">{{ $t('portal.promotion_of_event') }}</h6>
                            </router-link>
                        </div>
                        <div class="grid-item">
                            <router-link to="/portal/bpc-add-videos" class="card">
                                <div class="icon">
                                    <img src="../../../../assets/images/portal-icon/bpc/3.svg">
                                </div>
                                <h6 class="title">{{ $t('portal.public_relationship_information') }}</h6>
                            </router-link>
                        </div>
                        <div class="grid-item">
                            <router-link to="/portal/bpc-country-branding-view" class="card">
                                <div class="icon">
                                    <img src="../../../../assets/images/portal-icon/bpc/4.svg">
                                </div>
                                <h6 class="title">{{ $t('portal.country_branding') }}</h6>
                            </router-link>
                        </div>
                        <div class="grid-item">
                            <router-link to="/portal/bpc-questions" class="card">
                                <div class="icon">
                                    <img src="../../../../assets/images/portal-icon/bpc/6.svg">
                                </div>
                                <h6 class="title">{{ $t('portal.business_match_making') }}</h6>
                            </router-link>
                        </div>
                    </div>
                </b-row>
            </b-container>
        </section>
        <section class="association-wrapper">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="6" v-for="(council,i) in councilList" :key="i">
                        <div class="card mb-3" v-b-modal.modal-directory @click="details(council)">
                            <a href="#">{{currentLocale == 'en' ? council.council_name_en : council.council_name_bn}}</a>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
            <b-modal id="modal-directory" size="lg" centered hide-footer :ok-title="$t('globalTrans.close')" ok-only
                ok-variant="danger">
                <ProductBusinessDirectory :councilId="councilId" />
            </b-modal>
        </section>
        <section class="bpc-contact">
            <b-container>
                <b-row>
                    <b-col>
                        <h4 class="mb-2">{{$t('portal.contact_with_bpc')}}</h4>
                        <address>{{ currentLocale === 'bn' ?  infos.address_bn : infos.address }}</address>
                        <a href="#"><i class="ri-phone-fill"></i> {{ infos.phone | mobileNumber }}</a>
                        <a target="_blank" :href=" 'https://'+ infos.website"><i class="ri-global-line"></i> {{ infos.website }}</a>
                    </b-col>
                </b-row>
            </b-container>
        </section>
    </div>
</template>
<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import 'vueperslides/dist/vueperslides.css'
import ProductBusinessDirectory from './ProductBusinessDirectory.vue'
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { getPortalData } from '../../api/routes'
import ModalBaseMasterList from '@/mixins/list'
export default {
    mixins: [ModalBaseMasterList],
    name: 'Slider',
    components: { VueperSlides, VueperSlide, ProductBusinessDirectory },
    data: () => ({
        eBizServiceBaseUrl: eBizServiceBaseUrl,
        slides: [],
        councilList: [],
        infos: '',
        councilId: 0,
        options: {
            // transition duration in ms (default is 500)
            transitionDuration: 500,
            // autoplay delay in ms (default is 5000)
            autoplayDelay: 5000,
            // pause on hover (default is true)
            pauseOnHover: true
        }
    }),
    computed: {
        currentLocale () {
            return this.$i18n.locale
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        details (council) {
            this.councilId = council.id
        },
        async loadData () {
            const result = await RestApi.getData(eBizServiceBaseUrl, getPortalData)
            if (result.success) {
                this.slides = result.data.sliders
                this.councilList = result.data.council_list
                this.slides.map(item => {
                    item.image = eBizServiceBaseUrl + 'download-attachment?file=storage' + item.image
                })
                this.infos = result.data.basic_info
            }
            this.$store.dispatch('mutateCommonProperties', { loading: false, listReload: false })
        }
    }

}
</script>
<style>
.bpc-wrapper section{
    padding: .8rem 0;
}
.bpc-wrapper .promotion-index .card{
    text-align: center;
    min-height: 9rem;
    padding: 1rem;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
}
.bpc-wrapper .promotion-index .card .icon img{
    width: 50px;
    height: auto;
}
.bpc-wrapper .promotion-index .card .title{
    color: var(--font-color);
    margin-top: 1rem;
}
.bpc-wrapper .grid-container {
    display: grid;
    grid-template-columns: repeat(5, 1fr);
    grid-gap: 10px;
}
.bpc-wrapper .grid-item {
    text-align: center;
}
.bpc-wrapper .association-wrapper{
    padding: 1.5rem;
    background: linear-gradient(to right, var(--portal-brand), #9b2fec);
}
.bpc-wrapper .association-wrapper .col-sm-6:last-child{
    margin-left: auto !important;
    margin-right: auto !important;
}
.bpc-wrapper .association-wrapper .col-sm-6:last-child .card{
    margin-bottom: 0!important;
}
.bpc-wrapper .association-wrapper .card{
    margin-bottom: 1rem;
    padding: .8rem;
    display: flex;
    border-radius: 2rem;
    flex-direction: row;
    align-items: center;
    overflow: hidden;
    mix-blend-mode: luminosity;
    box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
}
.bpc-wrapper .association-wrapper .card .logo{
    width: 50px;
    height: 50px;
    margin: 0 .8rem;
    display: flex;
    justify-content: center;
    align-items: center;
}
.bpc-wrapper .association-wrapper .card .logo img{
    width: 100%;
    height: auto;
}
.bpc-wrapper .association-wrapper .card a{
    color: var(--portal-brand);
    font-weight: bold;
}
.bpc-wrapper .bpc-contact{
    padding: 2rem 0;
    text-align: center;
}
.bpc-wrapper .bpc-contact a{
    color: var(--font-color);
    padding: 0 1rem;
}
#modal-directory .modal-header {
    background-color: #fff;
}

#modal-directory .modal-header .close {
    margin-top: -6px;
    border-radius: 0 2px 0 0;
    padding: 0 0.5rem;
    color: #fff;
    background-color: #f1414a;
    opacity: 1;
    font-size: 2rem;
}

#modal-directory .modal-content .modal-body {
    padding: .5rem;
}
</style>
