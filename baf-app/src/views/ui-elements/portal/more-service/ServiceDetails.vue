<template>
    <div class="service-details-wrapper">
        <Header />
        <div class="banner-img-wrapper">
            <h2 class="cover-title">Private Company</h2>
            <img src="../../../../assets/images/cover-img.jpg" alt="">
        </div>
        <div class="service-description">
            <b-container>
                <b-row>
                    <b-col sm="9">
                        <h3 class="mb-3">Service Description</h3>
                        <p class="mb-3">The Department of Agricultural Extension provides free seeds and fertilizers to marginal farmers. It also provides fertilizers and seeds to farmers with the aim of increasing the production of certain crops and expanding the cultivation of new crops invented. The Department of Agricultural Extension provides free seeds and fertilizers to marginal farmers. It also provides fertilizers and seeds to farmers with the aim of increasing the production of certain crops and expanding the cultivation of new crops invented. The Department of Agricultural Extension provides free seeds and fertilizers to marginal farmers. It also provides fertilizers and seeds to farmers with the aim of increasing the production of certain crops and expanding the cultivation of new crops invented.</p>
                    </b-col>
                    <b-col sm="3">
                        <img src="../../../../assets/images/user/no-image.jpg" class="img-fluid mb-4" alt="">
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="4">
                        <b-card>
                            <b-card-title>5,000 <small>Person</small></b-card-title>
                            <b-card-text class="disc">
                                Agricultural Marketing license
                            </b-card-text>
                            <b-card-text class="small text-muted">Last updated 3 mins ago</b-card-text>
                        </b-card>
                    </b-col>
                    <b-col sm="4">
                        <b-card>
                            <b-card-title>3,800 <small>Person</small></b-card-title>
                            <b-card-text class="disc">
                                Got The Service
                            </b-card-text>
                            <b-card-text class="small text-muted">Last updated 3 mins ago</b-card-text>
                        </b-card>
                    </b-col>
                    <b-col sm="4">
                        <b-card>
                            <b-card-title>50,000 <small>Person</small></b-card-title>
                            <b-card-text class="disc">
                                Target Customer
                            </b-card-text>
                            <b-card-text class="small text-muted">Last updated 3 mins ago</b-card-text>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col sm="4">
                        <b-card class="service-desc-card">
                            <b-card-text>
                                Time of Receiving Service (usually)
                            </b-card-text>
                            <b-card-title>1 Month</b-card-title>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col>
                        <b-card style="background: #fff;border-color: transparent;">
                            <b-card-title style="border-bottom: 1px solid #eee;padding-bottom: 15px;" class="mb-4">Steps to Get the Service</b-card-title>
                            <b-card-text>
                                <img src="../../../../assets/images/1637378521.png" class="img-fluid" alt="">
                            </b-card-text>
                        </b-card>
                    </b-col>
                </b-row>
                <b-row>
                    <b-col>
                        <div class="mb-4">
                            <b-button variant="light"><i class="ri-arrow-left-line"></i> Go Back</b-button>
                        </div>
                    </b-col>
                    <b-col>
                        <div class="text-right mb-4">
                            <b-button variant="secondary"><i class="ri-send-plane-fill"></i> Apply Now</b-button>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <Footer />
    </div>
</template>
<script>
import Header from '../common/PortalHeader.vue'
import Footer from '../common/PortalFooter.vue'
export default {
    components: {
        Header,
        Footer
    }
}
</script>
