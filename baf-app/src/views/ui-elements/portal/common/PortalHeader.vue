<template>
    <div class="header-wrapper">
        <div class="top-header py-2">
            <b-container class="portal-container">
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex align-items-center">
                        <span class="hotline">
                            <i class="ri-headphone-fill"></i>33050
                        </span>
                        <b-button size="sm" variant="btn btn-outline-light" style="border-radius: 15px;">Bangla</b-button>
                    </div>
                    <div class="login-signup-wrapper">
                        <b-button-group>
                            <!-- <b-button size="sm" class="login-btn" :class="{'show' : show}" @click="showLogin">Login</b-button> -->
                            <a href="javascript:" class="login-btn" :class="{'show' : show}" @click="showLogin"><img
                                    style="width:102px" src="../../../../assets/images/login-btn.gif" alt=""></a>
                            <div class="login-card">
                                <b-form>
                                    <b-form-group id="input-group-1" label="Email:" label-for="input-1">
                                        <b-form-input id="input-1" type="email" placeholder="Enter email" required>
                                        </b-form-input>
                                    </b-form-group>

                                    <b-form-group id="input-group-2" label="Password:" label-for="input-2">
                                        <b-form-input id="input-2" placeholder="Enter Password" required>
                                        </b-form-input>
                                    </b-form-group>

                                    <b-form-group id="input-group-4">
                                        <b-form-checkbox value="that">Remember me</b-form-checkbox>
                                    </b-form-group>

                                    <button type="submit" size="sm" class="btn login-form-btn w-100">Login</button>
                                </b-form>
                            </div>
                        </b-button-group>
                    </div>
                </div>
            </b-container>
        </div>
        <div class="main-header">
            <b-container class="portal-container">
                <b-row>
                    <b-col sm="8">
                        <a href="javascript:" class="brand" @click="goTo">
                            <img src="../../../../assets/images/logo.png" width="50" alt="">
                            <div style="display: flex; flex-direction: column;">
                                <p>Ministry of Commerce Service Portal</p>
                                <small class="pl-3">All Services in one Address</small>
                            </div>
                        </a>
                    </b-col>
                    <b-col sm="3">
                        <div class="search-bar ml-auto">
                            <b-form-input size="lg" type="search" placeholder="Search..."></b-form-input>
                            <b-button size="sm"><i class="ri-search-2-line"></i></b-button>
                        </div>
                    </b-col>
                    <b-col>
                        <div class="float-right">
                            <img src="../../../../assets/images/mujib.png" width="70" alt="">
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </div>
    </div>
</template>

<script>
export default {
  name: 'Header',
  data: () => ({
    show: false
  }),
  methods: {
      showLogin: function () {
        // this.show = !this.show
        this.$router.push('/auth/login')
      },
      goTo: function () {
        this.$router.push('/portal')
      }
  }
}
</script>
<style>
    /* :root {
        --portal-brand: #214162;
        --portal-secondary: #4677AA;
    } */
    .header-wrapper {
        position: relative;
        z-index: 1000;
    }
    .top-header{
        background-color: var(--portal-brand);
    }
    .hotline{
        color: var(--light);
        display: block;
        font-size: medium;
        margin-right: .5em;
    }
    .hotline i{
        padding-right: .5em;
    }
    .login-signup-wrapper{
        position: relative;
    }
    .login-signup-wrapper .login-card .login-form-btn{
        color: #fff;
        background: var(--portal-secondary);
    }
    .login-signup-wrapper .login-card .login-form-btn:hover{
        color: #fff;
        background: var(--portal-brand);
    }
    .login-btn.show ~ .login-card{
        display: block;
    }
    .login-signup-wrapper .login-card{
        position: absolute;
        top: 40px;
        right: 0;
        padding: 12px;
        width: 230px;
        display: none;
        z-index: 5;
        border-top: 10px solid transparent;
        border-radius: 5px;
        animation: growOut 300ms ease-in-out forwards;
        transform-origin: top center;
        background-color: var(--white);
        box-shadow: rgba(50, 50, 93, 0.25) 0px 6px 12px -2px, rgba(0, 0, 0, 0.3) 0px 3px 7px -3px;
    }
    @keyframes growOut {
        0% {
            transform: scale(0)
        }
        80% {
            transform: scale(1.1)
        }
        100% {
            transform: scale(1)
        }
    }
    .login-signup-wrapper .login-card::after{
        content: "";
        position: absolute;
        top: -20px;
        left: 194px;
        width: 18px;
        height: 10px;
        border-bottom: 8px solid white;
        border-left: 8px solid #fff0;
        border-right: 8px solid transparent;
    }
    .main-header{
        display: flex;
        align-items: center;
        padding: .5em 0;
        background-color: var(--white);
        /* box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1); */
        box-shadow: rgb(0 0 0 / 10%) 0px 20px 25px -5px, rgb(0 0 0 / 4%) 0px 10px 10px -5px;
    }
    .main-header .brand{
        display: flex;
        align-items: center;
    }
    .main-header .brand p{
        color: var(--portal-brand);
        font-size: large;
        font-weight: bolder;
        padding-left: .8em;
    }
    .main-header .search-bar{
        position: relative;
        width: 100%;
        height: 100%;
        display: flex;
        align-items: center;
    }
    .main-header .search-bar .btn{
        position: absolute;
        right: 5px;
        top: 5px;
        line-height: 29px;
        border-radius: 20px;
        color: var(--portal-brand);
        background: transparent !important;
        border-color: transparent !important;
    }
    .main-header .search-bar .btn i {
        font-size: 1.2rem;
        transition: 0.5s ease-in-out;
    }
    .main-header .search-bar .btn:hover i {
        font-size: 1.5rem;
    }
    .main-header .search-bar .form-control{
        margin-bottom: 0;
        border-radius: 20px;
    }
    .main-header .total-user {
        text-align: center;
    }
    .main-header .total-user .count {
        margin-bottom: -5px;
        color: var(--primary);
        font-weight: 600;
    }
    .main-header .total-user p {
        font-size: 0.8rem;
    }
</style>
