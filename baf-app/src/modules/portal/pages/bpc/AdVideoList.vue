<template>
    <div class="bpc-ad-video-list pb-4">
        <b-container class="portal-container">
            <b-breadcrumb class="custom-bread">
                <b-breadcrumb-item to="/portal/home">{{ $t('portal.home')}}</b-breadcrumb-item>
                <b-breadcrumb-item to="/portal/bpc-landing-page">{{ $t('portal.bpc_langing_page')}}</b-breadcrumb-item>
                <b-breadcrumb-item active to="/portal/bpc-landing-page">{{ $t('portal.published_advertisement')}}</b-breadcrumb-item>
            </b-breadcrumb>
        </b-container>
        <b-container class="portal-container">
            <h5 class="ad-title text-center pb-3">{{ $t('portal.published_advertisement')}}</h5>
           <!-- <b-row>
                <b-col>
                    <b-form-group label="Select Association" label-for="association">
                        <b-form-select id="association" v-model="selected" :options="associationList" required></b-form-select>
                    </b-form-group>
                </b-col>
            </b-row> -->
            <b-row>
                <b-col sm="3" v-for="(items, index) in data" :key="index">
                    <div class="video-item" >
                        <b-embed type="iframe" aspect="16by9" :src="vidPlay(items.url)" allowfullscreen></b-embed>
                        <!--<iframe width="560" height="315" :src="vidPlay(items.url)" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>-->
                        <p class="video-title">
                            {{ $i18n.locale === 'en' ? items.advertisement_title_en.toUpperCase() : items.advertisement_title_bn }}
                         </p>
                    </div>
                </b-col>
                <b-col sm="1">
                </b-col>
            </b-row>
        </b-container>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { publicRelationshipPortalList } from '../../api/routes'

 export default {
    components: {
    },
    name: 'product-view',
    data () {
        return {
            eBizServiceBaseUrl: eBizServiceBaseUrl,
            modalShow: false,
            slide: 0,
            sliding: null,
            item: [],
            data: []
        }
    },
    created () {
        this.loadData()
    },
    methods: {
        vidPlay (item) {
            const p = item.includes('/watch?')
            let v = ''
            if (p === true) {
                v = item.split('v=')[1]
            } else {
                v = /[^/]*$/.exec(item)[0]
            }
            return 'https://www.youtube.com/embed/' + v
        },
        details (items) {
            this.item = items
        },
        onSlideStart (slide) {
            this.sliding = true
        },
        onSlideEnd (slide) {
            this.sliding = false
        },
        async loadData () {
            const result = await RestApi.getData(eBizServiceBaseUrl, publicRelationshipPortalList)
            if (result.success) {
                this.data = result.data
            } else {
            }
        }
    }
 }
</script>
<style>
.bpc-ad-video-list .video-item .video-title{
    margin-top: .5rem;
}
.ytp-large-play-button{
    width: 54px;
    height: 33px;
    margin-left: -24px;
    margin-top: -14px;
}
</style>
