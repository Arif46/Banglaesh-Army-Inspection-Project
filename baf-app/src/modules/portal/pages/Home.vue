<template>
    <div>
        <div class="main-service-wrapper">
            <b-container class="portal-container">
                <HomeService></HomeService>
            </b-container>
        </div>
        <!-- <div class="other-ministry-cta-wrapper mt-4 pt-2">
            <b-container class="portal-container">
                <div class="d-flex justify-content-between align-items-center other-ministry-cta">
                    <div class="d-flex align-items-center">
                        <img class="img-fluid" src="../../../assets/images/services.png" alt="">
                        <h3>অন্যান্য মন্ত্রণালয়ের সেবা সমূহ</h3>
                    </div>
                    <span class="mr-4 pr-4"><button class="btn btn-lg btn-details">বিস্তারিত দেখুন</button></span>
                </div>
            </b-container>
        </div> -->
        <div class="faq-wrapper pt-5" style="background-color: #fff;">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="4">
                        <AppBanner />
                    </b-col>
                    <b-col sm="5">
                        <Faq />
                    </b-col>
                    <b-col sm="3">
                        <Notice />
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <div class="news-wrapper pt-5" style="background-color: #F0F8FF;">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="9">
                        <News />
                    </b-col>
                    <b-col sm="3">
                        <OrganizationLinks></OrganizationLinks>
                    </b-col>
                </b-row>
            </b-container>
        </div>
    </div>
</template>

<script>
import HomeService from '../components/Home/HomeService.vue'
import OrganizationLinks from '../components/Home/OrganizationLinks.vue'
import Faq from '../components/Home/Faq.vue'
import AppBanner from '../components/Home/AppBanner'
import Notice from '../components/Home/Notice.vue'
import News from '../components/Home/News.vue'

export default {
    components: {
        HomeService,
        OrganizationLinks,
        Faq,
        AppBanner,
        Notice,
        News
    }
}
</script>
<style>
.main-service-wrapper {
    position: relative;
}
.main-service-wrapper::before {
    content: "";
    position: absolute;
    width: 100%;
    height: 100%;
    top: 0;
    left: 0;
    z-index: -1;
    background: url(../../../assets/images/portal-service-bg.png) no-repeat;
    background-size: cover;
}
/* .other-ministry-cta-wrapper{
    background: linear-gradient(to right, #CCECF0, #6ECBD2);
} */
.other-ministry-cta{
    /* background: url(../../../assets/images/other-ministry-banner.png); */
    background: linear-gradient(to right, #CCECF0, #6ecbd215), url(../../../assets/images/other-ministry-banner.png);
    background-repeat: no-repeat;
    background-position: right;
    border-radius: 1rem;
}
.other-ministry-cta img{
    max-width: 150px;
}
.other-ministry-cta h3{
    margin-left: 1rem;
    font-weight: bold;
    color: var(--portal-brand);
}
.other-ministry-cta .btn-details{
    color: #CCECF0;
    background: var(--portal-brand);
    border-radius: 1.4rem;
    animation: glowing 1s linear infinite;
}
@keyframes glowing {
    0% {
        background-color: #0083b2;
        box-shadow: 0 0 3px #e0f7ff;
    }

    25% {
        background-color: #3E69F1;
        box-shadow: 0 0 40px #f0f4ff;
    }

    50% {
        background-color: #0083b2;
        box-shadow: 0 0 3px #e0f7ff;
    }
    75% {
        background-color: #3E69F1;
        box-shadow: 0 0 40px #f0f4ff;
    }
    100% {
        background-color: #0083b2;
        box-shadow: 0 0 3px #e0f7ff;
    }
}
</style>
