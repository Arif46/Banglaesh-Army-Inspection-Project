<template>
    <div>
        <Header />
        <b-container>
            <b-row class="py-4">
                <b-col sm="12" md="8">
                    <div class="page-title">
                        <h4>Contact Us</h4>
                    </div>
                    <div class="contact-details">
                        <b-card>
                            <div class="address-card">
                                <div>
                                    <h6 class="mb-2 pb-3 border-bottom">Corporate Address</h6>
                                    <div class="d-flex">
                                        <div class="address w-50">
                                            House-45, Road-20, Mohakhali DOHS. Dhaka-1206, Bangladesh
                                        </div>
                                        <div class="contact-info w-50">
                                            <ul>
                                                <li>
                                                    <a href="tel:+880 1715 054769">
                                                        <i class="ri-customer-service-2-fill"></i>+880 1715 054769
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="mailto: info@syntechbd.com">
                                                        <i class="ri-discuss-fill"></i> info@syntechbd.com
                                                    </a>
                                                </li>
                                                <li>
                                                    <a href="www.syntechbd.com">
                                                        <i class="ri-earth-fill"></i> www.syntechbd.com</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="icon">
                                    <i class="ri-building-line"></i>
                                </div>
                            </div>
                        </b-card>
                        <b-card class="my-3">
                            <h6 class="pb-3">Find us on Google Map</h6>
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3650.979175134882!2d90.39346031425512!3d23.783755893419762!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755c7741b47ca8f%3A0x35d50b7c82fb0443!2sSyntech%20Solution%20Ltd.!5e0!3m2!1sen!2sbd!4v1658212281393!5m2!1sen!2sbd" width="100%" height="250" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </b-card>
                        <b-card>
                            <div class="contact-form">
                                <h6 class="pb-3">Submit a Massage</h6>
                                <b-form>
                                    <b-row>
                                        <b-col>
                                            <b-form-group id="input-group-1">
                                                <b-form-input id="name" type="text" placeholder="Enter name" required>
                                                </b-form-input>
                                            </b-form-group>
                                        </b-col>
                                        <b-col>
                                            <b-form-group id="input-group-2">
                                                <b-form-input id="email" type="email" placeholder="Enter email"
                                                    required>
                                                </b-form-input>
                                            </b-form-group>
                                        </b-col>
                                    </b-row>
                                    <b-form-group id="input-group-2">
                                        <b-form-input id="email" type="text" placeholder="Subject" required>
                                        </b-form-input>
                                    </b-form-group>
                                    <b-form-textarea id="textarea" v-model="text" placeholder="Enter something..."
                                        rows="8" max-rows="10">
                                    </b-form-textarea>
                                    <b-button type="submit" class="float-right" variant="info">Send Mail</b-button>
                                </b-form>
                            </div>
                        </b-card>
                    </div>
                </b-col>
                <b-col sm="12" md="4">
                    <News class="mb-4"></News>
                    <Notice />
                </b-col>
            </b-row>
        </b-container>
        <Footer />
    </div>
</template>
<script>
import Header from '../common/Header.vue'
import Footer from '../common/Footer.vue'
import Notice from './Notice.vue'
import News from './News.vue'
export default {
    name: 'Contact',
    components: {
        Header,
        Footer,
        Notice,
        News
    }
}
</script>
<style>
    .page-title{
        width: 100%;
        padding: .5em 0;
        border-radius: .3em;
        text-align: center;
        color: var(--white);
        background-color: var(--rjsc-brand);
    }
    .contact-details{
        margin-top: 10px;
    }
    .address-card{
        width: 100%;
        display: flex;
        justify-content: space-between;
    }
    .address-card .icon{
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 10%;
        font-size: 60px;
    }
    .contact-info ul li{
        padding: 3px 0;
    }
    .contact-info ul li a{
        color: chocolate;
    }
    .contact-info ul li a i{
        margin-right: 10px;
    }
</style>
