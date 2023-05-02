<template>
    <div class="menu-bar rjsc-title-bg">
        <b-container>
            <b-navbar toggleable="lg" type="dark">
                <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>
                <b-collapse id="nav-collapse" is-nav>
                    <b-navbar-nav>
                        <b-nav-item href="#">Home</b-nav-item>
                        <b-nav-item href="#">
                            Introductions
                            <div class="dropdown">
                                <b-nav-item>About</b-nav-item>
                                <b-nav-item href="#">FAQ</b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item href="#">
                            Business Process & Documents
                            <div class="dropdown">
                                <b-nav-item href="#">Name Clearance</b-nav-item>
                                <b-nav-item href="#">Registration</b-nav-item>
                                <b-nav-item href="#">Returns Filing</b-nav-item>
                                <b-nav-item href="#">Winding Up</b-nav-item>
                                <b-nav-item href="#">Certified Copy Issuance</b-nav-item>
                                <b-nav-item href="#">Struck Off</b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item href="#">
                            Entity Statistics
                            <div class="dropdown">
                                <b-nav-item href="#">List of Entities</b-nav-item>
                                <b-nav-item href="#">
                                    No of Entities
                                    <div class="sub-dropdown">
                                        <b-nav-item href="#">List of Entities</b-nav-item>
                                        <b-nav-item href="#">List of Entities</b-nav-item>
                                        <b-nav-item href="#">List of Entities</b-nav-item>
                                        <b-nav-item href="#">List of Entities</b-nav-item>
                                    </div>
                                </b-nav-item>
                            </div>
                        </b-nav-item>
                        <b-nav-item href="#">Laws</b-nav-item>
                        <b-nav-item href="#">Fees</b-nav-item>
                        <b-nav-item href="#">FAQ</b-nav-item>
                        <b-nav-item href="#">Contact</b-nav-item>
                    </b-navbar-nav>
                </b-collapse>
            </b-navbar>
        </b-container>
    </div>
</template>
<script>
export default {
    name: 'MainNav'
}
</script>
<style>
    .menu-bar{
        width: 100%;
        height: auto;
    }
    .menu-bar .navbar-nav .nav-link{
        color: var(--white);
        font-weight: 400;
    }
    .menu-bar .navbar-nav .nav-link:hover .dropdown{
        display: block;
    }
    .menu-bar .navbar-nav .dropdown{
        position: absolute;
        top: 40px;
        min-width: 100px;
        border-top: 10px solid transparent;
        border-radius: 0 0 5px 5px;
        z-index: 10;
        display: none;
        background-color: #8d1cd3ed;
        animation: growOut 300ms ease-in-out forwards;
        transform-origin: top center;
    }
    .menu-bar .navbar-nav .nav-link .dropdown .nav-link:hover .sub-dropdown{
        display: block;
    }
    .menu-bar .navbar-nav .dropdown .sub-dropdown{
        position: absolute;
        left: 108px;
        top: 38px;
        width: fit-content;
        border-radius: 0 0 5px 5px;
        z-index: 10;
        display: none;
        background-color: #8d1cd3ed;
        animation: growOut 300ms ease-in-out forwards;
        transform-origin: top center;
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
</style>
