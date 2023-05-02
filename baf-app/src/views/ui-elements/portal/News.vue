<template>
    <div class="portal">
        <b-card text-variant="dark" header-tag="header" class="news-section">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">News</h6>
                    </div>
                    <a href="javascript:" class="pr-3 portal-text">See More <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <b-row class="newsGroup">
                <b-col>
                    <b-card class="overflow-hidden mb-4">
                        <b-row no-gutters>
                            <b-col sm="4">
                                <img src="../../../assets/images/news3.jpeg" class="w-100" style="border-radius: 0" alt="">
                            </b-col>
                            <b-col sm="8" style="background: #f4f4f4;">
                                <a href="javascript:">
                                    <h6 class="pt-1 pb-2">Zalando, About You and Net-a-Porter launch sustainability platform</h6>
                                    <b-card-text class="text-muted mb-2"><i class="ri-user-line"></i> admin &nbsp; <i class="ri-calendar-check-fill"></i> 24-05-2022</b-card-text>
                                    <b-card-text style="-webkit-line-clamp:4;">
                                        Fashion ecommerce giants Zalando, About You and Yoox Net-a-Porter are launching a sustainability platform for brand partners. The platform will offer a learning programme and engagement between brands and sustainability experts. About You and Yoox Net-a-Porter are launching a sustainability platform for brand partners.
                                    </b-card-text>
                                </a>
                            </b-col>
                        </b-row>
                    </b-card>
                </b-col>
            </b-row>
            <b-row class="newsGroup">
                <b-col>
                    <b-card class="mb-4">
                        <img src="../../../assets/images/news1.png" class="w-100" alt="">
                        <a href="javascript:">
                            <h6>This is News Header</h6>
                            <small class="text-muted"><i class="ri-user-line"></i> admin &nbsp; <i class="ri-calendar-check-fill"></i> 24-05-2022</small>
                            <b-card-text>
                                <small>This card has supporting text below as a natural lead-in to additional content.</small>
                            </b-card-text>
                        </a>
                    </b-card>
                </b-col>
                <b-col sm="6" md="3">
                    <b-card class="mb-4">
                        <img src="../../../assets/images/news2.png" class="w-100" alt="">
                        <a href="javascript:">
                            <h6>This is News Header</h6>
                            <small class="text-muted"><i class="ri-user-line"></i> admin &nbsp; <i class="ri-calendar-check-fill"></i> 24-05-2022</small>
                            <b-card-text>
                                <small>This card has supporting text below as a natural lead-in to additional content.</small>
                            </b-card-text>
                        </a>
                    </b-card>
                </b-col>
                <b-col sm="6" md="3">
                    <b-card class="mb-4">
                        <img src="../../../assets/images/news1.png" class="w-100" alt="">
                        <a href="javascript:">
                            <h6>This is News Header</h6>
                            <small class="text-muted"><i class="ri-user-line"></i> admin &nbsp; <i class="ri-calendar-check-fill"></i> 24-05-2022</small>
                            <b-card-text>
                                <small>This card has supporting text below as a natural lead-in to additional content.</small>
                            </b-card-text>
                        </a>
                    </b-card>
                </b-col>
                <b-col sm="6" md="3">
                    <b-card class="mb-4">
                        <img src="../../../assets/images/news2.png" class="w-100" alt="">
                        <a href="javascript:" @click="newsDetails">
                            <h6>This is News Header</h6>
                            <small class="text-muted"><i class="ri-user-line"></i> admin &nbsp; <i class="ri-calendar-check-fill"></i> 24-05-2022</small>
                            <b-card-text>
                                <small>This card has supporting text below as a natural lead-in to additional content.</small>
                            </b-card-text>
                        </a>
                    </b-card>
                </b-col>
            </b-row>
        </b-card>
    </div>
</template>
<script>
export default {
    name: 'News',
    methods: {
        newsDetails: function () {
            this.$router.push('/portal/news')
        }
    }
}
</script>
<style>
.news-section.card .card-body {
    padding-bottom: 0;
}
.news-section.card .newsGroup .card-body {
    padding: 0;
}
.news-section.card .newsGroup .card {
    box-shadow: rgb(0 0 0 / 40%) 0px 3px 8px;
}
.news-section .newsGroup .card .card-body a {
    color: rgb(57, 57, 57);
    display: block;
    padding: .8em;
}
.news-section .newsGroup .card:hover .card-body a, .card-body a h6 {
    color: rgb(1, 99, 203);
}
.news-section .newsGroup .card:hover .card-body a h6 {
    color: rgb(1, 99, 203);
}
.news-section .newsGroup .card .card-body a h6 {
    color: var(--dark);
}
.news-section .newsGroup .card .card-body img{
    border-radius: 10px 10px 0 0;
}
.news-section .newsGroup .card .card-body .card-text{
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>
