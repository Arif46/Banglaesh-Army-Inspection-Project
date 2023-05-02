<template>
    <div class="portal-wrapper">
        <b-row>
            <b-col>
                <b-overlay :show="loading">
                    <vueper-slides :arrows-outside="false" class="no-shadow" :visible-slides="1" slide-multiple :gap="3"
                        :dragging-distance="200" :autoplay="true"
                        :breakpoints="{ 800: { visibleSlides: 2, slideMultiple: 2 } }">
                        <vueper-slide v-for="(slide, i) in slides" :key="i" :image="rjscServiceBaseUrl + 'storage/' + slide.thumbnail"/>
                    </vueper-slides>
                </b-overlay>
            </b-col>
        </b-row>
        <b-row class="mt-4">
            <b-col sm="4" class="mb-4" v-for="(header, index) in activity" :key='index'>
                <b-overlay :show="loader">
                    <div class="cards-wrapper rjsc-services">
                        <b-card class="">
                            <div class="card-head">
                                <div class="title-icon">
                                    <img :src="rjscServiceBaseUrl + 'storage/' + header.logo" alt="logo">
                                </div>
                                <h6 class="py-2">{{ ($i18n.locale === 'bn') ? header.name_bn : header.name_en }}</h6>
                            </div>
                            <b-list-group flush>
                                <b-list-group-item v-for="(detail, index1) in header.lists.slice(0, 3)" :key='index1' @click="afterLink(detail.url)">{{ ($i18n.locale === 'bn') ? detail.title_bn : detail.title_en }}</b-list-group-item>
                            </b-list-group>
                        </b-card>
                        <div class="more-service">
                            <b-list-group flush>
                                <b-list-group-item v-for="(detail, index1) in header.lists" :key='index1' @click="afterLink(detail.url)">{{
                                    ($i18n.locale === 'bn') ? detail.title_bn : detail.title_en}}
                                </b-list-group-item>
                            </b-list-group>
                        </div>
                    </div>
                </b-overlay>
            </b-col>
        </b-row>
    </div>
</template>
<script>
import { VueperSlides, VueperSlide } from 'vueperslides'
import RestApi, { rjscServiceBaseUrl } from '@/config/api_config'
import 'vueperslides/dist/vueperslides.css'
    export default {
        components: {
            VueperSlides, VueperSlide
        },
        data: () => ({
            // slides: [
            //     { image: require('@/assets/images/rjsc-portal/cover.png') },
            //     { image: require('@/assets/images/rjsc-portal/cover.png') },
            //     { image: require('@/assets/images/rjsc-portal/cover.png') },
            //     { image: require('@/assets/images/rjsc-portal/cover.png') }
            // ],
            slides: [],
            activity: [],
            rjscServiceBaseUrl: rjscServiceBaseUrl,
            loading: false,
            loader: false
        }),
        created () {
            this.loadData()
            this.activityLists()
        },
        methods: {
            afterLink (url) {
                window.location.href = url
            },
            async loadData () {
                this.loading = true
                const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/sliders')
                    if (result.success) {
                        this.slides = result.data
                    } else {
                        this.sliders = []
                    }
                this.loading = false
            },
            async activityLists () {
                this.loader = true
                const result = await RestApi.getData(rjscServiceBaseUrl, '/portal/activity-lists')
                    if (result.success) {
                        this.activity = result.data
                    } else {
                        this.activity = []
                    }
                this.loader = false
            }
        }
    }
</script>
<style>
.cards-wrapper{
    position: relative;
}
.cards-wrapper .card {
    background: url(../../../assets/images/rjsc-portal/card-bg.jpg) no-repeat;
    background-size: cover;
    filter: contrast(1.1);
    transition: filter 0.2s 0s linear;
}
.cards-wrapper .card:hover {
    filter: contrast(1);
}

.cards-wrapper .card .card-body {
    position: relative;
    z-index: 2;
}
.cards-wrapper .card .card-body .card-head{
    display: flex;
    flex-direction: column;
    align-items: center;
}

.cards-wrapper .card .card-body .title-icon {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100px;
    height: 100px;
    z-index: 3;
    border: 3px solid #fff;
    border-radius: 100px;
    background-color: var(--rjsc-brand);
}

.cards-wrapper .card .card-body .title-icon::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: 2px solid var(--rjsc-brand);
    border-radius: 50%;
    z-index: 1;
    transition: transform 0.5s 0s linear;
    transform: scale(1);
}

.cards-wrapper .card .card-body:hover .title-icon::after {
    transform: scale(1.1);
}

.cards-wrapper .card .card-body .title-icon img {
    width: 100%;
    max-width: 5em;
    z-index: 5;
}

.cards-wrapper .card .card-body .list-group-item {
    background: transparent;
    cursor: pointer;
}

.cards-wrapper .card .card-body .list-group-item:hover {
    color: var(--rjsc-brand);
    border-color: var(--rjsc-brand);
}

.rjsc-services{
    position: relative;
    /* z-index: 2; */
}
.font-bn .rjsc-services .card-head h6{
    font-size: 18px;
    font-weight: bold;
}
.cards-wrapper:hover .more-service {
    display: block;
    top: 100%;
}

.rjsc-services .more-service {
    padding: 6px 1px 1px 1px;
    position: absolute;
    top: 140px;
    left: 0;
    z-index: 100;
    width: 100%;
    display: none;
    overflow: hidden;
    border-radius: 5px;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
    background-color: var(--rjsc-brand);
    animation: flip-horizontal-bottom 0.4s cubic-bezier(0.455, 0.030, 0.515, 0.955) both;
}

@keyframes flip-horizontal-bottom {
    0% {
        transform: rotateX(0);
    }

    100% {
        transform: rotateX(-180deg);
    }
}
.rjsc-services .more-service .list-group {
    transform: rotateX(-180deg);
}
.rjsc-services .more-service::before {
    content: "";
    position: absolute;
    top: -10px;
    right: 40px;
    width: 0;
    height: 0;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    border-bottom: 10px solid var(--rjsc-brand);
}

.rjsc-services .more-service .list-group .list-group-item {
    padding: 0.5rem 1.4rem;
    padding-left: 25px;
    color: #f0f7ff;
    background-color: var(--rjsc-brand);
    border: none;
    cursor: pointer;
    border-bottom: 1px solid var(--rjsc-brand);
    transition: all .5s ease-in-out;
}

.rjsc-services .more-service .list-group .list-group-item:hover {
    padding-left: 28px;
    color: var(--rjsc-brand);
    background-color: #fffcfceb;
}
</style>
