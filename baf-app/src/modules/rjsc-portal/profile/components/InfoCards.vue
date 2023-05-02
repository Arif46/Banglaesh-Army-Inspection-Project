<template>
    <div class="box p-3">
        <b-row>
            <b-col sm="6" md="3" class="mb-4">
                <div class="cards-wrapper">
                    <b-card>
                        <div class="card-head">
                            <div class="title-icon">
                                <img src="../../../../assets/images/rjsc-portal/icons/registration.png" alt="">
                            </div>
                            <h5 class="py-2">Post-Registration Activities</h5>
                        </div>
                        <b-list-group flush>
                            <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                            <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                            <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                            <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                            <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                        </b-list-group>
                    </b-card>
                </div>
            </b-col>
            <b-col sm="6" md="3" class="mb-4">
                <div class="cards-wrapper">
                    <b-card>
                        <div class="card-head">
                            <div class="title-icon">
                                <img src="../../../../assets/images/rjsc-portal/icons/registration.png" alt="">
                            </div>
                            <h5 class="py-2">Post-Registration Activities</h5>
                        </div>
                        <b-list-group flush>
                            <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                            <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                            <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                            <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                            <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                        </b-list-group>
                    </b-card>
                </div>
            </b-col>
            <b-col sm="6" md="3" class="mb-4">
                <div class="cards-wrapper">
                    <b-card>
                        <div class="card-head">
                            <div class="title-icon">
                                <img src="../../../../assets/images/rjsc-portal/icons/registration.png" alt="">
                            </div>
                            <h5 class="py-2">Post-Registration Activities</h5>
                        </div>
                        <b-list-group flush>
                            <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                            <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                            <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                            <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                            <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                        </b-list-group>
                    </b-card>
                </div>
            </b-col>
            <b-col sm="6" md="3" class="mb-4">
                <div class="cards-wrapper">
                    <b-card>
                        <div class="card-head">
                            <div class="title-icon">
                                <img src="../../../../assets/images/rjsc-portal/icons/registration.png" alt="">
                            </div>
                            <h5 class="py-2">Post-Registration Activities</h5>
                        </div>
                        <b-list-group flush>
                            <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                            <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                            <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                            <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                            <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                        </b-list-group>
                    </b-card>
                </div>
            </b-col>
        </b-row>
    </div>
</template>
<script>
    export default {
        name: 'infoCard'
    }
</script>
<style>
.cards-wrapper .card {
    background: url(../../../../assets/images/rjsc-portal/card-bg.jpg) no-repeat;
    background-size: cover;
    filter: contrast(1.1);
    transition: filter 0.2s 0s linear;
}

.cards-wrapper .card:hover {
    filter: contrast(1);
}

.cards-wrapper .card .card-body {
    overflow: hidden;
    position: relative;
    z-index: 2;
}

.cards-wrapper .card .card-body .card-head {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.cards-wrapper .card .card-body .title-icon {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100px;
    height: 100px;
    z-index: 3;
    border: 3px solid #fff;
    border-radius: 100px;
    background-color: var(--rjsc-brand);
}

.cards-wrapper .card .card-body .title-icon::after {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border: 2px solid var(--rjsc-brand);
    border-radius: 50%;
    z-index: 1;
    transition: transform 0.5s 0s linear;
    transform: scale(1);
}

.cards-wrapper .card .card-body:hover .title-icon::after {
    transform: scale(1.1);
}

.cards-wrapper .card .card-body .title-icon img {
    width: 100%;
    max-width: 5em;
    z-index: 5;
}
.cards-wrapper .card .card-body h5 {
    text-align: center;
    font-size: 18px;
}

.cards-wrapper .card .card-body .list-group-item {
    background: transparent;
}

.cards-wrapper .card .card-body .list-group-item:hover {
    color: var(--rjsc-brand);
    border-color: var(--rjsc-brand);
}
</style>
