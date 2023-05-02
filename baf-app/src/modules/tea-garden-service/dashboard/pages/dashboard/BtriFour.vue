<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper training-wrapper">
            <b-card title="Training and Workshop">
                <b-row>
                    <b-col>
                        <b-card-text>
                            <b-form-group label="Please Select">
                                <b-form-radio-group name="radio-inline">
                                    <b-form-radio name="training" size="sm">Training</b-form-radio>
                                    <b-form-radio name="workshop" size="sm">Workshop</b-form-radio>
                                    <b-form-radio name="course" size="sm">Course</b-form-radio>
                                </b-form-radio-group>
                            </b-form-group>
                        </b-card-text>
                    </b-col>
                </b-row>
            </b-card>
            <div class="info-card-wrapper">
                <b-card title="Course">
                    <b-card-text>
                        <b-row>
                            <b-col class="bdr" sm="6">
                                <div class="info-card training">
                                    <div class="content">
                                        <p>No of Training</p>
                                        <h3>56</h3>
                                    </div>
                                    <img src="../../../../../assets/images/training.png" class="img-fluid" alt="">
                                </div>
                            </b-col>
                            <b-col class="bdr mt-3 mt-sm-0" sm="6">
                                <div class="info-card participant">
                                    <div class="content">
                                        <p>No of Participants</p>
                                        <h3>2560</h3>
                                    </div>
                                    <img src="../../../../../assets/images/participant.png" class="img-fluid" alt="">
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

.training-wrapper .info-card-wrapper .info-card.training {
    background: linear-gradient(90deg, rgba(230, 131, 61, 1) 0%, rgba(242, 182, 67, 1) 100%);
}

.training-wrapper .info-card-wrapper .info-card.participant {
    background: linear-gradient(90deg, #be39d6 0%, #e873fc 100%);
}

.training-wrapper .info-card-wrapper .info-card img {
    height: 120px;
    width: auto;
}
</style>
