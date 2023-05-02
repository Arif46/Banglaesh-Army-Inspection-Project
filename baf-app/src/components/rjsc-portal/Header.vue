<template>
    <div>
        <div class="header-wrapper">
           <b-container>
            <b-row>
                <b-col sm="12" md="6">
                    <a href="javascript:" class="brand">
                        <img src="@/assets/images/logo.png" alt="Logo">
                        <span>
                            <p class="font-weight-bold">{{ $t('rjsc_portal.title') }}</p>
                            <small class="text-muted">{{ $t('rjsc_portal.sub_title') }}</small>
                        </span>
                    </a>
                </b-col>
                <b-col sm="12" md="6">
                    <div class="header-action">
                        <LangBtn />
                        <button class="gb-bordered hover-slide" @click="gotToLoginPage" id="log-btn"><i class="ri-login-circle-line"></i> {{ $t('rjsc_portal.login_btn') }}</button>
                    </div>
                </b-col>
            </b-row>
           </b-container>
        </div>
        <div class="nav-wrapper">
            <Navbar />
        </div>
    </div>
</template>
<script>
import Navbar from './Navbar.vue'
import LangBtn from '../../modules/rjsc-portal/components/LangBtn.vue'
    export default {
        name: 'Header',
        components: {
            Navbar,
            LangBtn
        },
        methods: {
            gotToLoginPage () {
                this.$router.push({ name: 'auth.login' })
            }
        }
    }
</script>
<style>
.header-wrapper{
        width: 100%;
        border-bottom: 1px solid var(--gray-ddd);
        background-color: var(--white);
    }
.header-wrapper .brand{
    color: var(--gray-dark);
    padding: .5em 0;
    display: inline-flex;
    align-items: center;
}
.header-wrapper .brand img{
    margin-right: 1em;
    width: 60px;
}
.header-wrapper .header-action{
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: end;
    align-items: center;
}
/* button style */
#log-btn {
    position: sticky;
    background-color: transparent;
    color: white;
}
#log-btn:after {
    background-image: linear-gradient(135deg, #1e7d4a 0%, #198754 12.5%, #1c9f61 12.5%, #1c9f61 25%, #198754 25%, #198754 37.5%, #1c9f61 37.5%, #1c9f61 50%, #198754 50%, #198754 62.5%, #1c9f61 62.5%, #1c9f61 75%, #198754 75%, #198754 87.5%, #1c9f61 87.5%, #1c9f61 100%);
}
.hover-slide {
    transition: 0.6s all;
}
.hover-slide:hover:after {
    background-position: 100% 0;
}
.gb-bordered {
    position: relative;
    border: 4px solid transparent;
    background-clip: padding-box;
    transition: 0.5s all;
}
.lg-button {
    cursor: pointer;
    font-size: 16px;
    border-radius: 4px;
}
.lg-button i{
    vertical-align: bottom;
}
.hover-slide:after {
    background-size: 200% 100%;
    background-position: 0% 0;
}
.gb-bordered:after {
    transition: 0.5s all;
    position: absolute;
    top: -4px;
    left: -4px;
    right: -4px;
    bottom: -4px;
    content: "";
    z-index: -1;
    border-radius: 4px;
}
</style>
