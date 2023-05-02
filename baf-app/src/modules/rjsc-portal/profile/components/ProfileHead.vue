<template>
    <div class="profile-wrapper box">
        <div class="profile-info">
            <div class="cover">
                <img class="cover_img" src="../../../../assets/images/rjsc-portal/cover.png" alt="">
            </div>
            <b-container>
                <b-row>
                    <b-col sm="12" md="3" offset-md="1">
                        <div class="company-info">
                            <div class="ribbon-wrapper" title="16 Years of Glorious Journey">
                                <div class="company-journey">
                                    <p>16</p>
                                    <p>Years</p>
                                </div>
                            </div>
                            <div class="profile-img">
                                <img src="../../../../assets/images/syntech2.png" alt="">
                            </div>
                            <div class="company-name mt-1">
                                <h5>Syntech Solution Ltd.</h5>
                                <small id="address">House 45, Road 20, Mohakhali DOHS</small>
                            </div>
                            <div class="owner-info">
                                <img src="../../../../assets/images/user.jpg" alt="">
                                <div>
                                    <h6>Md. Faruk Uddin</h6>
                                    <small>Managing Director</small>
                                </div>
                            </div>
                            <div class="contact-info" :class="{show: isShow}">
                                <div class="office">
                                    <i class="ri-building-line"></i>
                                    <h6>OUR OFFICE</h6>
                                    <p>House 45, Road 20, Mohakhali DOHS</p>
                                </div>
                                <div class="contact">
                                    <i class="ri-mail-send-line"></i>
                                    <h6>EMAIL & PHONE</h6>
                                    <p>info@syntechbd.com</p>
                                    <p>+880 1863813906</p>
                                </div>
                                <div class="social-media">
                                    <h6>SOCIAL MEDIA</h6>
                                    <div class="social-icon">
                                        <i class="ri-facebook-box-fill"></i>
                                        <i class="ri-linkedin-box-fill"></i>
                                    </div>
                                    <p>www.syntechbd.com</p>
                                </div>
                                <button @click="showCard">✖</button>
                            </div>
                            <button class="mt-3 btn btn-sm contBtn" block size="sm" @click="showCard">Contact</button>
                        </div>
                    </b-col>
                    <b-col sm="12" md="8">
                        <div class="company-brif">
                            <h4>BRIEF OF COMPANY</h4>
                            <div :class="{ 'extended' : isExtend }">
                                <p>
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software
                                    engineering and consultancy firm focused on Web Based Application, & software
                                    development, offshore web design, Website Development & providing services to
                                    diverse customers. We provide Affordable Web Design. We have vision to provide.
                                    Syntech Solution Ltd is CMMI Level 3, ISO 9001 and ISO 27001 certified software
                                    engineering and consultancy firm focused on Web Based Application, & software
                                    development, offshore web design, Website Development & providing services to
                                    diverse customers. We provide Affordable Web Design. We have vision to provide.
                                </p>
                                <a href="javascript:" @click="extendText"> {{ isExtend ? 'Read more' : 'Less' }} </a>
                            </div>
                        </div>
                        <div class="basis-info">
                            <b-row>
                                <b-col sm="4">
                                    <img class="img-fluid" src="../../../../assets/images/basis-logo.svg" alt="">
                                </b-col>
                                <b-col sm="4">
                                    <span>
                                        <small>Member Id:</small>
                                        <h6>GE-11-11-450</h6>
                                    </span>
                                    <span>
                                        <small>Member Type:</small>
                                        <h6>Genarel Member</h6>
                                    </span>
                                </b-col>
                                <b-col sm="4">
                                    <span>
                                        <small>Member Since:</small>
                                        <h6>Nov 21, 2011</h6>
                                    </span>
                                    <span>
                                        <small>Valid Till:</small>
                                        <h6>Dec 31, 2012</h6>
                                    </span>
                                </b-col>
                            </b-row>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </div>
    </div>
</template>
<script>
    export default {
        name: 'ProfileHead',
        data: () => ({
           isExtend: true,
           isShow: false
        }),

        methods: {
            extendText: function () {
                this.isExtend = !this.isExtend
            },
            showCard: function () {
                this.isShow = !this.isShow
            }
        }
    }
</script>
<style>
.profile-wrapper{
        margin: 1em 0;
    }
    .profile-wrapper .company-info{
        margin: -5em 0 5em 0;
        padding: 1em;
        position: relative;
        display: flex;
        flex-direction: column;
        align-items: center;
        word-wrap: break-word;
        background-color: #f8f6ff;
        box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
        background-clip: border-box;
        border: 1px solid rgba(0, 0, 0, 0.125);
        border-radius: 0.25rem;
    }
    .profile-wrapper .company-info .contBtn{
        color: var(--light);
        background-color: var(--rjsc-brand);
        width: 100%;
    }
    .profile-wrapper .company-info .contBtn:hover{
        background-color: var(--rjsc-brand);
    }
    .profile-wrapper .company-info .ribbon-wrapper{
        position: absolute;
        width: 40px;
        height: 40px;
        background: var(--rjsc-brand);
        top: -6px;
        left: 25px;
        z-index: 3;
    }
    .profile-wrapper .company-info .ribbon-wrapper::after{
        content: "";
        position: absolute;
        height: 0;
        width: 0;
        border-left: 20px solid var(--rjsc-brand);
        border-right: 20px solid var(--rjsc-brand);
        border-bottom: 15px solid transparent;
        bottom: -15px;
    }
    .profile-wrapper .company-info .ribbon-wrapper::before{
        content: "";
        position: absolute;
        height: 0;
        width: 0;
        border-bottom: 6px solid #01503a;
        border-right: 6px solid transparent;
        right: -6px;
    }
    .profile-wrapper .company-info .ribbon-wrapper .company-journey{
        color: #fff;
        text-align: center;
        padding: 3px;
        font-size: 11px;
    }
    .profile-wrapper .company-info .ribbon-wrapper .company-journey p:first-child{
        font-weight: 600;
        font-size: 18px;
        padding-top: 3px;
        line-height: .8;
    }
    .profile-wrapper .company-info .profile-img{
        width: 12em;
        padding: 1em;
        text-align: center;
        border-bottom: 1px solid var(--gray-ccc);
    }
    .profile-wrapper .company-info .profile-img img{
        width: 100%;
        display: block;
    }
    .profile-wrapper .company-info .company-name{
        text-align: center;
    }
    .profile-wrapper .company-info .owner-info {
        margin-top: 1em;
        padding: 5px;
        width: 100%;
        display: flex;
        background-color: var(--light);
        border: 1px solid var(--gray-ccc);
        border-radius: 10px;
    }
    .profile-wrapper .company-info .owner-info img{
        width: 50px;
        height: auto;
        margin-right: 5px;

    }
    .profile-wrapper .contact-info {
        position: relative;
        padding: 8px;
        color: var(--white);
        position: absolute;
        display: none;
        top: 0;
        width: 100%;
        height: 100%;
        border-radius: 4px;
        background-color: #16a763;
        text-align: center;
        z-index: 2;
        animation: open 2s ease 0s 1 normal forwards;
    }
    @keyframes open {
        0% {
            opacity: 0.5;
            transform: scale(0.2);
        }
        20% {
            opacity: 1;
            transform: scale(1);
        }
    }
    .profile-wrapper .contact-info.show {
        display: block;
    }
    .profile-wrapper .contact-info div{
        padding: 5px 0;
        border-bottom: 1px solid var(--rjsc-brand);
    }
    .profile-wrapper .contact-info div:last-child{
        border: 0;
    }
    .profile-wrapper .contact-info button{
        position: absolute;
        bottom: 0;
        left: 50%;
        transform: translateX(-50%);
        color: var(--white);
        padding: 8px;
        width: 100%;
        display: block;
        border: 0;
        border-radius: 0 0 4px 4px;
        background: var(--rjsc-title-bg);
    }
    .company-brif {
        margin-top: 1.5em;
    }
    .company-brif h4{
        border-bottom: 1px solid var(--gray);
    }
    .company-brif div{
        border: 1px solid #eee;
        padding: 5px;
    }
    .company-brif div p{
        text-align: justify;
        transition: all 0.5s 0s linear;
    }
    .company-brif div.extended p{
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        transition: .5s all;
    }
    .basis-info{
        margin-top: 0.8rem;
        padding: 5px;
        border: 3px dotted #ddd;
    }
    .profile-wrapper .cover{
        width: 100%;
        height: 280px;
        overflow: hidden;
    }
    .profile-wrapper .cover .cover_img{
        width: 100%;
        display: block;
    }
</style>
