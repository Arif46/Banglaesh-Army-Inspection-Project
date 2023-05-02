<template>
    <div class="section-wrapper portal-section-wrapper mb-0">
        <Header></Header>
        <div class="main-service-wrapper">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="9">
                        <Service></Service>
                    </b-col>
                    <b-col sm="3">
                        <ServiceSidebar></ServiceSidebar>
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <div class="faq-wrapper pt-5" style="background-color: #fff;">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="9">
                        <Faq />
                    </b-col>
                    <b-col sm="3">
                        <Notice />
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <div class="pt-5" style="background-color: #F0F8FF;">
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
            <Footer></Footer>
        </div>
</template>
<script>
import Header from './common/PortalHeader.vue'
import Service from './ServiceCategory.vue'
import OrganizationLinks from './OrganizationLinks.vue'
import Faq from './Faq.vue'
import ServiceSidebar from './ServiceSidebar.vue'
import Notice from './Notice.vue'
import News from './News.vue'
import Footer from './common/PortalFooter.vue'

export default {
    components: {
        Header,
        Service,
        OrganizationLinks,
        Faq,
        ServiceSidebar,
        Notice,
        News,
        Footer
    }
}
</script>
<style>
    .section-wrapper{
        overflow-x: hidden;
    }
    .main-service-wrapper {
        position: relative;
        background: url(../../../assets/images/portal-service-bg.png) no-repeat;
        background-size: cover;
    }
    /* .main-service-wrapper::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgb(0 0 0 / 40%);
    } */
</style>
