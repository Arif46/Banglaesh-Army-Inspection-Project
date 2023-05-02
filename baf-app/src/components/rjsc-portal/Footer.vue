<template>
    <div class="footer-wrapper">
        <div class="middle-footer">
            <b-container>
                <b-row>
                    <b-col sm="12" md="4">
                        <div class="footer-item">
                            <h5>In Planning and Implementation</h5>
                            <a target="_blank" href="#">
                                <img style="width: 60px" src="@/assets/images/logo.png" alt="">
                                <h5 class="mt-1 mb-0">Ministry of Commerce</h5>
                            </a>
                        </div>
                    </b-col>
                    <b-col sm="12" md="4">
                        <div class="footer-item">
                            <h5>With Technical Assistance</h5>
                            <a target="_blank" href="#">
                                <img style="width: 110px" src="@/assets/images/ict-division.png" alt="">
                            </a>
                        </div>
                    </b-col>
                    <b-col sm="12" md="4">
                        <div class="footer-item">
                            <h5>In system development</h5>
                            <a target="_blank" href="#">
                                <img class="syntech" src="@/assets/images/syntech2.png" alt="">
                            </a>
                        </div>
                    </b-col>
                </b-row>
            </b-container>
        </div>
        <div class="bottom-footer">
            <b-container>
                <div class="d-flex justify-content-center text-light">
                    <p>&copy; {{ new Date().getFullYear() }} All Rights Reserved</p>
                </div>
            </b-container>
        </div>
    </div>
</template>

<script>
export default {
    name: 'Footer'
}
</script>
<style>
.footer-wrapper{
    background: url(../../assets/images/rjsc-portal/footer-bg-01.png) no-repeat;
    background-size: cover;
}

.footer-wrapper .middle-footer {
    width: 100%;
    padding: 30px 20px;
    border-top: 3px solid transparent;
    border-image: url(../../assets/images/rjsc-portal/border.jpg) 30;
    background-color: rgb(255 255 255 / 26%);
}

.footer-wrapper .middle-footer .footer-item {
    display: flex;
    flex-direction: column;
    justify-content: center;
    text-align: center;
}

.footer-wrapper .middle-footer .footer-item h5 {
    margin-bottom: 1em;
    font-size: medium;
}

.footer-wrapper .middle-footer .footer-item a {
    color: var(--dark-gray);
}

.footer-wrapper .middle-footer .footer-item a .syntech {
    width: 130px;
}

.footer-wrapper .bottom-footer {
    text-align: center;
    width: 100%;
    padding: 5px;
    background: linear-gradient(135deg, #25952f 0, var(--rjsc-brand) 100%);
    background-size: cover;
}
</style>
