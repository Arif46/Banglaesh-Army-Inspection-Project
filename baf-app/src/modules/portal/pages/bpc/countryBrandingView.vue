<template>
    <div class="bdp-product-view pb-4">
        <b-container class="portal-container">
            <b-breadcrumb class="custom-bread">
                <b-breadcrumb-item to="/portal/home">{{ $t('portal.home')}}</b-breadcrumb-item>
                <b-breadcrumb-item to="/portal/bpc-landing-page">{{ $t('portal.bpc_langing_page')}}</b-breadcrumb-item>
                <b-breadcrumb-item active to="/portal/bpc-country-branding-view">{{
                $t('portal.country_branding')}}</b-breadcrumb-item>
            </b-breadcrumb>
        </b-container>
        <b-container class="portal-container">
            <h5 class="text-center pb-3">{{ $t('portal.country_branding') }}</h5>
            <b-row>
                <b-col sm="3" v-for="(items, index) in data" :key="index">
                    <div class="product-item">
                        <div class="prod-img">
                            <img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_main" alt="Profile Image">
                        </div>
                        <div class="prod-info mb-2">
                            {{ $i18n.locale === 'en' ? items.advertisement_title_en.toUpperCase() : items.advertisement_title_bn }}
                        </div>
                    <b-button v-b-modal.bpc-cuntry-modal @click="details(items)">{{ $t('portal.details') }}</b-button>
                    </div>
                </b-col>
            </b-row>
            <b-modal id="bpc-cuntry-modal" size="lg" hide-footer="true">
                <center><h3>{{ $i18n.locale === 'en' ? item.advertisement_title_en : item.advertisement_title_bn }}</h3></center><br>
                <b-row>
                        <b-col md="3"><span v-if="item.attachment_one" ><img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_one" alt="Profile Image"></span></b-col>
                        <b-col md="3"><span v-if="item.attachment_two" ><img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_two" alt="Profile Image"></span></b-col>
                        <b-col md="3"><span v-if="item.attachment_three" ><img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_three" alt="Profile Image"></span></b-col>
                        <b-col md="3"><span v-if="item.attachment_four" ><img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_four" alt="Profile Image"></span></b-col>
                </b-row>
                <div>
                    <hr>
                    <span v-if="$i18n.locale === 'en'" v-html="item.description_en"></span>
                    <span v-if="$i18n.locale === 'bn'" v-html="item.description_bn"></span>
                    <span v-if="item.url"> URL: <a :href="item.url">{{ item.url }}</a></span>
                </div>
            </b-modal>
        </b-container>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { countryBrandingPortalList } from '../../api/routes'

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
            const result = await RestApi.getData(eBizServiceBaseUrl, countryBrandingPortalList)
            if (result.success) {
                this.data = result.data
            } else {
            }
        }
    }
 }
</script>
<style>
.bdp-product-view .product-item{
    width: 100%;
    height: 300px;
    padding: 1rem;
    margin-bottom: 1.5rem;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    background: #fff;
    border-radius: 5px;
    box-shadow: rgba(99, 99, 99, 0.1) 0px 2px 8px 0px;
}
.bdp-product-view .product-item .prod-img{
    background: #fff;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}
.bdp-product-view .product-item .prod-img img{
    width: 160px;
    max-width: 100%;
    height: auto;
    display: block;
}
.bdp-product-view .product-item .prod-info{
    text-align: center;
    display: flex;
    width: 100%;
    align-items: center;
    flex-direction: column;
    margin-top: .7rem;
    border-top: 1px solid #eee;
}
.bdp-product-view .product-item .prod-info .form-control{
    margin: 0;
    border: none;
    background: transparent;
}
.bdp-product-view .product-item .prod-info .prod-title{
    color: var(--font-color);
    text-transform: uppercase;
    margin-top: .3rem;
    min-height: 2.7rem;
}
.bdp-product-view .product-item:hover .prod-info .prod-title{
    color: var(--portal-brand);
}
.bdp-product-view .product-item .prod-info .prod-rating{
    width: fit-content;
}
.bdp-product-view .product-item .prod-info .price{
    font-size: 1rem;
    font-weight: bold;
}
.bdp-product-view .product-item .prod-info .price span{
    text-decoration: line-through;
    font-weight: normal;
    margin-right: .5rem;
}
#bpc-cuntry-modal .modal-header {
    background-color: #fff;
}

#bpc-cuntry-modal .modal-header .close {
    margin-top: -6px;
    border-radius: 0 2px 0 0;
    padding: 0 0.5rem;
    color: #fff;
    background-color: #f1414a;
    opacity: 1;
    font-size: 2rem;
}

#bpc-cuntry-modal .modal-content .modal-body {
    padding: .5rem;
}
</style>
