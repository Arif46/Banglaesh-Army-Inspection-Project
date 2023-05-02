<template>
    <div class="section-wrapper btri-db-wrapper">
        <breadcumb />
        <b-card class="header-img">
            <h2>Tea Plant Supply</h2>
        </b-card>
        <div class="info-card-wrapper">
            <b-card>
                <b-row>
                    <b-col sm="3">
                        <div class="info-card">
                            <i class="ri-file-copy-2-fill"></i>
                            <div class="content">
                                <p>Total Application</p>
                                <h3>256</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="info-card">
                            <i class="ri-file-copy-2-fill"></i>
                            <div class="content">
                                <p>Total Application</p>
                                <h3>256</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="info-card">
                            <i class="ri-file-copy-2-fill"></i>
                            <div class="content">
                                <p>Total Application</p>
                                <h3>256</h3>
                            </div>
                        </div>
                    </b-col>
                    <b-col sm="3">
                        <div class="info-card">
                            <i class="ri-file-copy-2-fill"></i>
                            <div class="content">
                                <p>Total Application</p>
                                <h3>256</h3>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-card>
        </div>
        <div class="data-chart">
            <b-card>
                <img src="../../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
            </b-card>
        </div>
    </div>
</template>
<style>
.btri-db-wrapper .header-img {
    height: 200px;
}

.btri-db-wrapper .header-img .card-body {
    padding: 0;
    background-image: linear-gradient(to bottom, rgba(34, 38, 47, 0.729), rgba(34, 38, 47, 0.729)),
        url('../../../../../assets/images/tea_gardens.jpg');
    background-position: center;
    background-size: cover;

}

.btri-db-wrapper .card .card-body h2 {
    color: #fff;
    text-transform: uppercase;
    text-align: center;
    margin-top: 40px;
}

.btri-db-wrapper .info-card-wrapper {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: center;
}

.btri-db-wrapper .info-card-wrapper .card {
    width: 90%;
    min-height: 150px;
    margin-top: -100px;
    color: #fff;
    background: var(--alt);
}

.btri-db-wrapper .info-card-wrapper .card .card-body {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.btri-db-wrapper .info-card-wrapper .info-card {
    text-align: center;
}

.btri-db-wrapper .info-card-wrapper .row div {
    border-right: 1px solid #ddd;
}

.btri-db-wrapper .info-card-wrapper .row div:last-child {
    border: none;
}
</style>
