<template>
  <b-container fluid>
    <b-row style="line-height: 20px">
        <b-overlay :show="loading">
            <template>
                <div class="accordion mt-3" role="tablist">
                    <div class="mb-1">
                        <div header-tag="header" role="tab">
                            <b-button block v-b-toggle.accordion-1 variant="association-custom text-left">{{$t('InformationTraining.business_directory')}}</b-button>
                        </div>
                        <b-collapse id="accordion-1" visible accordion="my-accordion" role="tabpanel">
                            <div class="p-2 border">
                                <b-row v-if="businessDirectores.length > 0">
                                    <b-col sm="6" v-for="(business,i) in visibleBusinessData" :key="i">
                                        <div class="mb-2">
                                            <a class="text-dark" href="#">{{currentLocale == 'en' ? business.company_name : business.company_name_bn}}</a>
                                        </div>
                                    </b-col>
                                    <template v-if="visibleBusinessData.length > 10">
                                        <p class="text-success" v-if="!allBusinessDataVisible" @click="showBusinessMore">{{ $t('portal.show_more')}}</p>
                                        <p class="text-success" v-if="allBusinessDataVisible" @click="showBusinessLess">{{ $t('portal.show_less')}}</p>
                                    </template>
                                </b-row>
                            </div>
                        </b-collapse>
                    </div>

                    <div class="mb-1">
                    <div header-tag="header" role="tab">
                        <b-button block v-b-toggle.accordion-2 variant="association-custom text-left">{{$t('InformationTraining.product_directory')}}</b-button>
                    </div>
                    <b-collapse id="accordion-2" accordion="my-accordion" role="tabpanel">
                        <div class="p-2 border">
                            <b-row v-if="productDirectores.length > 0">
                                <b-col sm="6" v-for="(product,i) in visibleProductData" :key="i">
                                    <div class="mb-2">
                                        <a class="text-dark" href="#">{{currentLocale == 'en' ? product.product_info_en : product.product_info_bn}}</a>
                                    </div>
                                </b-col>
                                <template v-if="visibleProductData.length > 10">
                                    <p class="text-success" v-if="!allProductDataVisible" @click="showProductMore">{{$t('portal.show_more')}}</p>
                                    <p class="text-success" v-if="allProductDataVisible" @click="showProductLess">{{$t('portal.show_less')}}</p>
                                </template>
                            </b-row>
                        </div>
                    </b-collapse>
                </div>
                </div>
            </template>
        </b-overlay>
    </b-row>
  </b-container>
</template>

<script>
import RestApi, { eBizServiceBaseUrl } from '@/config/api_config'
import { getProductBusinessDirectory } from '../../api/routes'
export default {
    props: ['councilId'],
    components: {
    },
    created () {
        this.productBusinessDirectory(this.councilId)
    },
    mounted () {
        // core.index()
    },
    data () {
        return {
            itemsToShow: 10,
            allBusinessDataVisible: false,
            allProductDataVisible: false,
            loading: true,
            productDirectores: [],
            businessDirectores: []
        }
    },
    computed: {
        currentLocale () {
            return this.$i18n.locale
        },
        visibleBusinessData () {
            if (this.allBusinessDataVisible) {
                return this.businessDirectores
            }
            return this.businessDirectores.slice(0, this.itemsToShow)
        },
        visibleProductData () {
            if (this.allProductDataVisible) {
                return this.productDirectores
            }
            return this.productDirectores.slice(0, this.itemsToShow)
        }
    },
    methods: {
        showBusinessMore () {
            this.allBusinessDataVisible = true
        },
        showBusinessLess () {
            this.allBusinessDataVisible = false
        },
        showProductMore () {
            this.allProductDataVisible = true
        },
        showProductLess () {
            this.allProductDataVisible = false
        },
        async productBusinessDirectory (councilId) {
            this.loading = true
            const params = {
                council_info_id: councilId
            }
            const result = await RestApi.getData(eBizServiceBaseUrl, getProductBusinessDirectory, params)
            if (result.success) {
                this.businessDirectores = result.data.business_directoreis
                this.productDirectores = result.data.product_directoreis
                this.loading = false
            }
            this.loading = false
        }
    }
}
</script>
<style>
.btn-association-custom{
    color: #fff;
    background: linear-gradient(to right, #009fff, #ec2f4b);
    border: none;
    border-radius: 4px 4px 0 0;
}
</style>
