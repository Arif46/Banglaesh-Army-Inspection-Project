<template>
    <div class="bpc-event-list pb-4">
        <b-container class="portal-container">
            <b-breadcrumb class="custom-bread">
                <b-breadcrumb-item to="/portal/home">{{ $t('portal.home')}}</b-breadcrumb-item>
                <b-breadcrumb-item to="/portal/bpc-landing-page">{{ $t('portal.bpc_langing_page')}}</b-breadcrumb-item>
                <b-breadcrumb-item active to="/portal/bpc-event-list">{{
                $t('portal.upcoming_event')}}</b-breadcrumb-item>
            </b-breadcrumb>
        </b-container>
        <b-container class="portal-container">
            <h4 class="event-title">{{ $t('portal.upcoming_event') }}</h4>
            <b-row>
                <b-col sm="4" v-for="(items, index) in data" :key="index">
                    <div class="event-item">
                        <div class="event-img">
                            <img :src="eBizServiceBaseUrl + 'storage' + items.attachment_main" alt="Profile Image">
                        </div>
                        <div class="event-info card">
                            <router-link to="/">
                            <h5 class="title">
                             {{ $i18n.locale === 'en' ? items.advertisement_title_en : items.advertisement_title_bn }}
                            </h5>
                            </router-link>
                            <div class="event-meta">
                                <b-col sm="12">
                                <span class="mr-3" v-if="items.start_date"><i class="fa fa-hourglass-start"></i>
                                {{ items.start_date | dateFormat }}</span>
                                <span class="mr-3" v-if="items.end_date !== '0000-00-00'"><i class="fa fa-hourglass-end"></i>
                                {{ items.end_date | dateFormat }}</span>
                                </b-col>
                                <b-col sm="12"><span>
                                <i class="ri-map-pin-2-fill"></i>
                                    {{ $i18n.locale === 'en' ? items.address_en : items.address_bn }}
                                    </span>
                                </b-col>
                            </div>
                            <p class="event-disc">
                                <span v-if="$i18n.locale === 'en'" v-html="items.description_en"></span>
                                <span v-if="$i18n.locale === 'bn'" v-html="items.description_bn"></span>
                            </p>
                            <b-button v-b-modal.bpc-event-modal @click="details(items)">Show More</b-button>
                        </div>
                    </div>
                </b-col>
            </b-row>
            <b-modal id="bpc-event-modal" centered size="lg" hide-footer>
                <h3 class="mb-2">{{ $i18n.locale === 'en' ? item.advertisement_title_en : item.advertisement_title_bn }}</h3>
                <span v-if="item.attachment_main">
                    <img style="height: auto; max-height: 300px; width: 100%" :src="eBizServiceBaseUrl + 'storage' + item.attachment_main"
                        alt="Profile Image">
                </span>
                <div class="mt-2">
                    <span v-if="$i18n.locale === 'en'" v-html="item.description_en"></span>
                    <span v-if="$i18n.locale === 'bn'" v-html="item.description_bn"></span>
                    <hr>
                    <span v-if="item.url"> Event URL: <a :href="item.url">{{ item.url }}</a></span>
                </div>
            </b-modal>
        </b-container>
    </div>
</template>
<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { eventPromotionalPortalList } from '../../api/routes'

 export default {
    components: {
    },
    name: 'bpc_event_list',
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
            const result = await RestApi.getData(eBizServiceBaseUrl, eventPromotionalPortalList)
            if (result.success) {
                this.data = result.data
            } else {
            }
        }
    }
 }
</script>
<style>
.bpc-event-list .event-title{
    text-align: center;
    padding: 1rem 0;
}
.bpc-event-list .event-item{
    border-radius: .5rem;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    background: #E7EAFF;
}
.bpc-event-list .event-item .event-img{
    border-radius: .5rem;
    overflow: hidden;
    height: 100%;
    width: 100%;
    max-height: 200px;
}
.bpc-event-list .event-item .event-img img{
    width: 100%;
    height: auto;
    max-height: 250px;
    display: block;
}
.bpc-event-list .event-item .event-info{
    margin-top: -2rem;
    padding: .8rem;
    width: 90%;
    border-radius: .5rem;
    border-top: 5px solid var(--portal-brand);
}
.bpc-event-list .event-item .event-info .title{
    color: var(--font-color);
}
.bpc-event-list .event-item .event-info .event-meta{
    border-bottom: 1px solid #ddd;
}
.bpc-event-list .event-item .event-info .event-disc{
    margin-top: .4rem;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
    text-overflow: ellipsis;
}
#bpc-event-modal .modal-header {
    background-color: #fff;
}

#bpc-event-modal .modal-header .close {
    margin-top: -6px;
    border-radius: 0 2px 0 0;
    padding: 0 0.5rem;
    color: #fff;
    background-color: #f1414a;
    opacity: 1;
    font-size: 2rem;
}

#bpc-event-modal .modal-content .modal-body {
    padding: .5rem;
}
</style>
