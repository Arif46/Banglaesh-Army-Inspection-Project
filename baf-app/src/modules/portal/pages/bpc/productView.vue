<template>
    <div class="bdp-product-view pb-4">
        <b-container class="portal-container">
            <b-breadcrumb class="custom-bread">
                <b-breadcrumb-item to="/portal/home">{{ $t('portal.home')}}</b-breadcrumb-item>
                <b-breadcrumb-item to="/portal/bpc-landing-page">{{ $t('portal.bpc_langing_page')}}</b-breadcrumb-item>
                <b-breadcrumb-item active to="/portal/bpc-product-view">{{
                $t('portal.bpc_product_view')}}</b-breadcrumb-item>
            </b-breadcrumb>
        </b-container>
    <b-overlay :show="loader">
        <b-container class="portal-container">
            <h5 class="text-center pb-3">{{$t('portal.bpc_product_view')}}</h5>
            <!-- New Design Product Tab By Association-->
            <b-row>
                <b-col>
                    <div class="accordion promoted-association" role="tablist">
                        <div class="mb-3" v-for="(value, index) in data3" :key="index">
                            <div header-tag="header" class="p-1" role="tab">
                                <b-button block v-b-toggle="`pp-${index + 1}`" variant="accordion" @click="showItmInit(value.id)">
                                    <div>
                                        <span class="logo"><i class="fas fa-bullhorn"></i></span>
                                        <span class="pl-3">{{ $i18n.locale === 'en' ? value.association_name_en : value.association_name_bn }}</span>
                                    </div>
                                    <span><i class="ri-arrow-down-s-fill"></i></span>
                                </b-button>
                            </div>
                            <b-collapse :id="`pp-${index + 1}`" accordion="my-accordion" role="tabpanel">
                                <div class="p-1 pt-3 text-center">
                                    <b-row>
                                        <b-col sm="3" v-for="(items, index) in data.filter(el => el.association_info_id === value.id).slice(0, showItmCount)" :key="index">
                                            <div class="product-item">
                                                <div class="prod-img">
                                                    <img style="height: auto; width: 100px" :src="eBizServiceBaseUrl + 'storage' + items.attachment_main" alt="Profile Image">
                                                </div>
                                                <div class="prod-info">
                                                    <span>{{ $i18n.locale === 'en' ? items.advertisement_title_en.toUpperCase() : items.advertisement_title_bn }}</span>
                                                    <p class="price"><span class="text-muted line-throw">{{ $n(items.price, { useGrouping: false }) }}
                                                    </span>{{ $n(items.offer_price, { useGrouping: false }) }}</p>
                                                </div>
                                                <b-button variant="secondary" size="sm" pill v-b-modal.bpc-product-modal @click="details(items)">Details</b-button>
                                            </div>
                                        </b-col>
                                    </b-row>
                                </div>
                                <div class="w-100 d-block text-center">
                                    <b-button variant="outline-info" :hidden="itmCount < showItmCount ? true : false" size="sm" @click="showItmAction(value.id)">More Product <b-icon icon="plus" /></b-button>
                                </div>
                            </b-collapse>
                        </div>
                    </div>
                </b-col>
            </b-row>
            <b-modal id="bpc-product-modal" size="lg" centered hide-footer>
                <b-row>
                    <b-col sm="5">
                            <b-row>
            <span v-if="item.attachment_one && p===1" ><img style="height: auto; width: 300px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_one" alt="Profile Image"></span>
            <span v-if="item.attachment_two && p===2" ><img style="height: auto; width: 300px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_two" alt="Profile Image"></span>
            <span v-if="item.attachment_three && p===3" ><img style="height: auto; width: 300px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_three" alt="Profile Image"></span>
            <span v-if="item.attachment_four && p===4" ><img style="height: auto; width: 300px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_four" alt="Profile Image"></span>
                </b-row>
                <br>
                             <b-row>
            <b-col sm="1" @click="imgShow(1)" v-if="item.attachment_one" ><img style="height: auto; width: 70px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_one" alt="Profile Image"></b-col>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <b-col sm="1" @click="imgShow(2)" v-if="item.attachment_two" ><img style="height: auto; width: 70px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_two" alt="Profile Image"></b-col>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <b-col sm="1" @click="imgShow(3)" v-if="item.attachment_three" ><img style="height: auto; width: 70px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_three" alt="Profile Image"></b-col>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <b-col sm="1" @click="imgShow(4)" v-if="item.attachment_four" ><img style="height: auto; width: 70px" :src="eBizServiceBaseUrl + 'storage' + item.attachment_four" alt="Profile Image"></b-col>
                </b-row>
                    </b-col>
                    <b-col sm="7">
                        <div class="product-info">
                            <h5 class="pro-title">
                            {{ $i18n.locale === 'en' ? item.advertisement_title_en : item.advertisement_title_bn }}
                            </h5>
                            <p class="price"><span class="text-muted line-throw"><small>{{ $t('portal.bdt') }}</small> {{ $n(item.price, { useGrouping: false }) }}</span><small>{{ $t('portal.bdt') }}</small> {{ $n(item.offer_price, { useGrouping: false }) }}</p>
                            <div class="product-details">
                                <span v-if="$i18n.locale === 'en'" v-html="item.description_en"></span>
                                <span v-if="$i18n.locale === 'bn'" v-html="item.description_bn"></span>
                            </div>
                            <span v-if="item.url"> <a :href="item.url" class="btn btn-sm btn-success mt-3" target="_blank" rel="noopener noreferrer"><i class="fa fa-paper-plane"></i> URL</a></span>
                        </div>
                    </b-col>
                </b-row>
                <b-row class="mt-3" v-if="data2.length > 0">
                    <b-col>
                        <div class="sales-kit-title">
                            <p>{{ $t('portal.sales_kit') }}</p>
                            <span></span>
                        </div>
                        <b-card v-for="(items2, index) in data2" :key="index" style="max-width: 90%;">
                            <h5>
                            <img style="height: auto; width: 82px" :src="eBizServiceBaseUrl + 'storage' + items2.attachment_main" alt="Profile Image">
                            {{ $i18n.locale === 'en' ? items2.advertisement_title_en.toUpperCase() : items2.advertisement_title_bn }}
                            </h5>
                            <b-card-text>
                                <span v-if="$i18n.locale === 'en'" v-html="items2.description_en"></span>
                                <span v-if="$i18n.locale === 'bn'" v-html="items2.description_bn"></span>
                            </b-card-text>
                        </b-card>
                    </b-col>
                </b-row>
            </b-modal>
        </b-container>
    </b-overlay>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { opdPromotionalPortalList, salesKitPortalList, associationInfoList } from '../../api/routes'

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
            data: [],
            data2: [],
            data3: [],
            itmCount: 0,
            visible: true,
            loader: true,
            showItmCount: 4,
            p: 1,
            sales_kit_by_product: [],
            slides: [
                { image: require('../../../../assets/images/product-img/1.jpg') },
                { image: require('../../../../assets/images/product-img/2.jpg') },
                { image: require('../../../../assets/images/product-img/3.jpg') }
        ]
        }
    },
    created () {
        if (this.item.attachment_four) {
            this.p = 4
        }
        if (this.item.attachment_three) {
            this.p = 3
        }
        if (this.item.attachment_two) {
            this.p = 2
        }
        if (this.item.attachment_one) {
            this.p = 1
        }
        this.loadData()
    },
    methods: {
        imgShow (value) {
            this.p = value
        },
        showItmInit (value) {
            this.showItmCount = 4
            this.itmCount = this.data.filter(el => el.association_info_id === value).length
        },
        showItmAction (value) {
            this.showItmCount += 4
            this.data.slice(0, this.showItmCoun)
        },
        details (items) {
            this.item = items
            this.data2 = this.sales_kit_by_product.filter(item => item.product_id === parseInt(items.value))
        },
        onSlideStart (slide) {
            this.sliding = true
        },
        onSlideEnd (slide) {
            this.sliding = false
        },
        async loadData () {
            this.loader = true
            const result = await RestApi.getData(eBizServiceBaseUrl, opdPromotionalPortalList)
            const result2 = await RestApi.getData(eBizServiceBaseUrl, salesKitPortalList)
            const result3 = await RestApi.getData(eBizServiceBaseUrl, associationInfoList)
            if (result.success) {
                this.data = result.data.filter(item => item.approved_status === 1)
                    const arr = []
                    this.data.map((item, index) => {
                        arr.push(item.association_info_id)
                    })
                    var uniqueArr = [...new Set(arr.map(x => x))]
                if (result3.success) {
                    this.data3 = result3.data.filter(item => uniqueArr.includes(item.id))
                        if (result2.success) {
                            this.loader = false
                            this.sales_kit_by_product = result2.data
                        } else {
                            this.loader = false
                        }
                } else {
                }
            } else {
                this.loader = false
            }
        }
    }
 }
</script>
<style>
/* slider default style */
#bpc-product-modal .thumbnails {
    margin: auto;
    max-width: 300px;
}

#bpc-product-modal .thumbnails .vueperslide {
    box-sizing: border-box;
    border: 1px solid #fff;
    transition: 0.3s ease-in-out;
    opacity: 0.7;
    cursor: pointer;
}

#bpc-product-modal .thumbnails .vueperslide--active {
    box-shadow: 0 0 6px rgba(0, 0, 0, 0.3);
    opacity: 1;
    border-color: #000;
}
#bpc-product-modal .vueperslides--fixed-height.vueperslides--bullets-outside {
    margin-top: 1rem;
}
#bpc-product-modal .vueperslides:not(.no-shadow):not(.vueperslides--3d) .vueperslides__parallax-wrapper:after,
.vueperslides:not(.no-shadow):not(.vueperslides--3d) .vueperslides__parallax-wrapper:before{
    box-shadow: none;
}
#bpc-product-modal .modal-header{
    background-color: #fff;
}
#bpc-product-modal .modal-header .close {
    margin-top: -6px;
    border-radius: 0 2px 0 0;
    padding: 0 0.5rem;
    color: #fff;
    background-color: #f1414a;
    opacity: 1;
    font-size: 2rem;
}
#bpc-product-modal .modal-content .modal-body{
    padding: .5rem;
}
#bpc-product-modal .modal-content .modal-body .product-info .pro-title{
    text-transform: uppercase;
    font-weight: 600;
}
#bpc-product-modal .modal-content .modal-body .product-info .price{
    color: var(--portal-brand);
    padding: .4rem 0;
    font-size: 1.6rem;
    font-weight: bold;
    display: inherit;
}
#bpc-product-modal .modal-content .modal-body .product-info .price span{
    text-decoration: line-through;
    text-decoration-color: red;
    font-weight: normal;
    margin-right: .5rem;
}
#bpc-product-modal .modal-content .modal-body .product-info .product-details ul{
    list-style: square;
    list-style-position: inside;
}
#bpc-product-modal .sales-kit-title{
    text-transform: uppercase;
    position: relative;
    margin-bottom: 1rem;
}
#bpc-product-modal .sales-kit-title p{
    color: #fff;
    background: #10ac85;
    display: initial;
    position: relative;
    padding: 0.2rem 1rem;
    border-radius: 1rem;
    z-index: 4;
}
#bpc-product-modal .sales-kit-title span:before {
    content: "";
    position: absolute;
    top: 50%;
    left: 0;
    width: 100%;
    border: 1px solid #10ac85;
}
.bdp-product-view .promoted-association .btn-accordion{
    color: #eee;
    text-align: left;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background: linear-gradient(to right, #3b73da, #0490db, #0490db, #3b73da);
    box-shadow: inset rgb(50 50 93 / 25%) -1px -6px 13px 4px,
        rgb(0 0 0 / 30%) 0px 3px 7px -3px;
}
.bdp-product-view .promoted-association span.logo {
    background: #3b73da;
    padding: 1rem;
    border-radius: 5px;
}
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
.bdp-product-view .product-item .prod-info span{
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
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
    color: var(--portal-brand);
    padding: .4rem 0;
    font-size: 1.3rem;
    font-weight: bold;
    display: inherit;
}
.bdp-product-view .product-item .prod-info .price span{
    text-decoration: line-through;
    text-decoration-color: rgba(255, 0, 0, 0.701);
    font-weight: normal;
    margin-right: .5rem;
}
</style>
