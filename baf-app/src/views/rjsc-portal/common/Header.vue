<template>
    <div>
        <div class="header-wrapper">
           <b-container>
            <b-row>
                <b-col sm="12" md="6">
                    <a href="javascript:" class="brand">
                        <img src="../../../assets/images/logo.png" alt="Logo">
                        <span>
                            <p class="font-weight-bold">Office of the Registrar of Joint Stock Companies and Firms</p>
                            <small class="text-muted">Government of the People's Republic of Bangladesh</small>
                        </span>
                    </a>
                </b-col>
                <b-col sm="12" md="6">
                    <div class="header-action">
                        <button class="lg-button gb-bordered hover-slide" id="log-btn" v-b-modal.modal-login><i class="ri-login-circle-line"></i> Login</button>
                    </div>
                </b-col>
            </b-row>
           </b-container>
        </div>
        <div class="nav-wrapper">
            <Navbar />
        </div>
        <!-- Login Modal -->
        <div class="login-modal">
            <b-modal id="modal-login" size="sm" centered hide-footer="true">
                <LoginForm></LoginForm>
                <span class="create-acc-btn">Don't Have Account?<a href="javascript:">Create</a></span>
            </b-modal>
        </div>
    </div>
</template>
<script>
import Navbar from './Navbar.vue'
import LoginForm from './Login.vue'
    export default {
        name: 'Header',
        components: {
            Navbar,
            LoginForm
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
        background-image: linear-gradient(135deg, #6c19bb 0%, #5f13a7 12.5%, #721fc1 12.5%, #721fc1 25%, #8325dd 25%, #8325dd 37.5%, #6e1fb9 37.5%, #7c11e3 50%, #7610d9 50%, #7c17dd 62.5%, #690ebf 62.5%, #640eb5 75%, #7215c9 75%, #7215c9 87.5%, #5b0ca5 87.5%, #5b0ca5 100%);
    }
    .hover-slide {
        transition: 0.6s all;
    }
    .hover-slide:hover:after {
        background-position: 100% 0;
    }
    .gb-bordered {
        padding: 6px 20px;
        position: relative;
        border: 4px solid transparent;
        background-clip: padding-box;
        transition: 0.5s all;
    }
    .lg-button {
        padding: 5px 20px;
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
    .header-wrapper .modal-header {
        position: relative;
        background-color: transparent;
    }
    .header-wrapper .modal-header .close {
        position: absolute;
        top: -18px;
        right: 28px;
    }
    /* Login modal */
    .modal-header {
        position: relative;
        padding: 0;
        border-bottom: none;
        background-color: transparent;
    }
    .modal-header .close {
        position: absolute;
        right: 10px;
        top: 5px;
        color: var(--white);
    }
    .modal-content {
        color: #fff;
        background-color: transparent;
        padding: 1rem;
    }
    .modal-content .modal-body {
        color: #fff;
        background-color: #1b0028d6;
        padding: 1rem;
    }
    .create-acc-btn{
        text-align: center;
        position: absolute;
        bottom: -50px;
        left: 50%;
        transform: translateX(-50%);
        color: var(--white);
        font-size: 13px;
        font-weight: 300;
    }
    .create-acc-btn a{
        color: var(--white);
        margin-left: 5px;
        text-decoration: underline;
        font-weight: 500;
    }
</style>
