<template>
    <div class="box p-3">
        <b-row>
            <b-col sm="12" md="4">
                <b-card>
                    <div class="title-icon">
                        <img src="../../../../assets/images/rjsc-portal/icons/general.png" alt="">
                    </div>
                    <h5 class="py-2">Post-Registration Activities</h5>
                    <b-list-group flush>
                        <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                        <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                        <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                        <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                        <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                    </b-list-group>
                </b-card>
            </b-col>
            <b-col sm="12" md="4">
                <b-card>
                    <div class="title-icon">
                        <img src="../../../../assets/images/rjsc-portal/icons/general.png" alt="">
                    </div>
                    <h5 class="py-2">Post-Registration Activities</h5>
                    <b-list-group flush>
                        <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                        <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                        <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                        <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                        <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                    </b-list-group>
                </b-card>
            </b-col>
            <b-col sm="12" md="4">
                <b-card>
                    <div class="title-icon">
                        <img src="../../../../assets/images/rjsc-portal/icons/general.png" alt="">
                    </div>
                    <h5 class="py-2">Post-Registration Activities</h5>
                    <b-list-group flush>
                        <b-list-group-item href="#">Cras justo odio</b-list-group-item>
                        <b-list-group-item href="#">Dapibus ac facilisis in</b-list-group-item>
                        <b-list-group-item href="#">Morbi leo risus</b-list-group-item>
                        <b-list-group-item href="#">Porta ac consectetur ac</b-list-group-item>
                        <b-list-group-item href="#">Vestibulum at eros</b-list-group-item>
                    </b-list-group>
                </b-card>
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

      .card{
        background: url(../../../../assets/images/rjsc-portal/card-bg.jpg) no-repeat;
        background-size: cover;
    }
      .card .card-body{
        overflow: hidden;
        text-align: center;
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
        z-index: 2;
    }
      .card::before{
        content: "";
        position: absolute;
        width: 85%;
        height: 80%;
        top: 65px;
        transform: translateX(-50%);
        left: 50%;
        z-index: 1;
            border: 2px solid var(--rjsc-brand);
            border-radius: 5px;
        }

          .card .card-body .title-icon {
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

          .card .card-body .title-icon::after {
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

          .card .card-body:hover .title-icon::after {
            transform: scale(1.1);
        }

          .card .card-body .title-icon img {
            width: 100%;
            max-width: 5em;
            z-index: 5;
        }

          .card .card-body .list-group-item {
            background: transparent;
        }

          .card .card-body .list-group-item:hover {
            color: var(--rjsc-brand);
            border-color: var(--rjsc-brand);
        }
</style>
