<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper training-wrapper">
            <b-card title="Tea Garden Avisory Visit">
                <b-row>
                    <b-col>
                        <b-card-text>
                            <b-form-group label="Please Select">
                                <b-form-radio-group name="radio-inline">
                                    <b-form-radio name="training" size="sm">Garden Requested</b-form-radio>
                                    <b-form-radio name="workshop" size="sm">BTRI Schedule</b-form-radio>
                                </b-form-radio-group>
                            </b-form-group>
                        </b-card-text>
                    </b-col>
                </b-row>
            </b-card>
            <div class="info-card-wrapper">
                <b-card title="Requested Garden">
                    <b-card-text>
                        <b-row>
                            <b-col class="bdr" sm="6">
                                <div class="info-card application">
                                    <div class="content">
                                        <p>Total Application</p>
                                        <h3>56</h3>
                                    </div>
                                    <img src="../../../../../assets/images/application.png" class="img-fluid" alt="">
                                </div>
                            </b-col>
                            <b-col class="bdr mt-3 mt-sm-0" sm="6">
                                <div class="info-card visit">
                                    <div class="content">
                                        <p>Garden Visit</p>
                                        <h3>2560</h3>
                                    </div>
                                    <img src="../../../../../assets/images/garden-visit.png" class="img-fluid" alt="">
                                </div>
                            </b-col>
                        </b-row>
                    </b-card-text>
                </b-card>
            </div>
        </div>
    </div>
</template>
<style>
.training-wrapper .info-card-wrapper .info-card {
    border-radius: 1rem;
    color: #fff;
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.training-wrapper .info-card-wrapper .info-card .content p {
    font-size: 25px;
}

.training-wrapper .info-card-wrapper .info-card.application {
    background: linear-gradient(90deg, rgba(64, 123, 255, 1) 0%, rgba(159, 189, 255, 1) 100%);
}

.training-wrapper .info-card-wrapper .info-card.visit {
    background: linear-gradient(90deg, rgb(63, 179, 98) 0%, rgb(134, 227, 162) 100%);
}

.training-wrapper .info-card-wrapper .info-card img {
    height: 120px;
}
</style>
