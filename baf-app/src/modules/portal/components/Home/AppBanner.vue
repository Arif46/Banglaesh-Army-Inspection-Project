<template>
    <div class="portal">
        <b-card text-variant="dark" header-tag="header" class="app-banner">
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">{{ $t('portal.bazar_monitoring_system') }}</h6>
                    </div>
                    <a href="https://play.google.com/store/apps/details?id=com.syntechbd.mocbma" target="_blank" class="pr-3 portal-text">{{ $t('portal.see_more') }} <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <div class="banner">
                <img class="img-fluid" width="300" src="../../../../assets/images/app-name.png" alt="">
                <a href="https://play.google.com/store/apps/details?id=com.syntechbd.mocbma" target="_blank" class="btn btn-info mt-4">{{ $t('portal.download') }}</a>
            </div>
        </b-card>
    </div>
</template>
<style scoped>
.app-banner .card-body{
    background-image: url(../../../../assets/images/app-banner-bg.png);
    background-repeat: no-repeat;
    background-size: cover;
    min-height: 350px;
}
.app-banner .banner{
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
}
</style>
