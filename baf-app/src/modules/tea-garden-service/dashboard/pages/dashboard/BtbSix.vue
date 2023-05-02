<template>
    <div class="section-wrapper">
        <breadcumb />
        <div class="form-wrapper fertilizer-distribution">
            <b-card title="Return Form">
                <b-row>
                    <b-col sm="6">
                        <b-card-text>
                            <b-form-group label="Select Return Form">
                                <b-form-radio-group name="radio-inline">
                                    <b-form-radio name="radio-size" size="sm">Return Form One</b-form-radio>
                                    <b-form-radio name="radio-size" size="sm">Return Form Two</b-form-radio>
                                    <b-form-radio name="radio-size" size="sm">Return Form Three</b-form-radio>
                                </b-form-radio-group>
                            </b-form-group>
                        </b-card-text>
                    </b-col>
                    <b-col sm="6 border-left">
                        <b-card-text>
                            <b-row class="">
                                <b-col sm="6">
                                    <b-form-group id="input-group-3" label="Select Year" label-for="input-3">
                                        <b-form-select id="input-3" required>
                                            <b-form-select-option value="2020">2020</b-form-select-option>
                                            <b-form-select-option value="2021">2021</b-form-select-option>
                                            <b-form-select-option value="2022">2022</b-form-select-option>
                                            <b-form-select-option value="2023">2023</b-form-select-option>
                                        </b-form-select>
                                    </b-form-group>
                                </b-col>
                                <b-col sm="6">
                                    <b-form-group id="input-group-3" label="Select Month" label-for="input-3">
                                        <b-form-select id="input-3" required>
                                            <b-form-select-option value="2020">2020</b-form-select-option>
                                            <b-form-select-option value="2021">2021</b-form-select-option>
                                            <b-form-select-option value="2022">2022</b-form-select-option>
                                            <b-form-select-option value="2023">2023</b-form-select-option>
                                        </b-form-select>
                                    </b-form-group>
                                </b-col>
                            </b-row>
                        </b-card-text>
                    </b-col>
                </b-row>
                <b-card-text class="mb-3 border-top">
                    <b-row>
                        <b-col sm="3">
                            <div class="info-card total-app">
                                <div class="icon">
                                    <i class="ri-file-3-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Total Application</p>
                                    <small>(New)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card approved">
                                <div class="icon">
                                    <i class="ri-checkbox-circle-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Approved Application</p>
                                    <small>(New)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card pending">
                                <div class="icon">
                                    <i class="ri-time-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Pending Application</p>
                                    <small>(New)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card reject">
                                <div class="icon">
                                    <i class="ri-close-line"></i>
                                </div>
                                <div class="content">
                                    <p>Rejected Application</p>
                                    <small> &nbsp; </small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card total-app">
                                <div class="icon">
                                    <i class="ri-file-3-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Total Application</p>
                                    <small>(Reniew)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card approved">
                                <div class="icon">
                                    <i class="ri-checkbox-circle-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Approved Application</p>
                                    <small>(Reniew)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card pending">
                                <div class="icon">
                                    <i class="ri-time-fill"></i>
                                </div>
                                <div class="content">
                                    <p>Pending Application</p>
                                    <small>(Reniew)</small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                        <b-col sm="3">
                            <div class="info-card reject">
                                <div class="icon">
                                    <i class="ri-close-line"></i>
                                </div>
                                <div class="content">
                                    <p>Expired Application</p>
                                    <small> &nbsp; </small>
                                    <h3>167</h3>
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                </b-card-text>
            </b-card>
            <b-card>
                <b-card-text>
                    <img src="../../../../../assets/images/chart-dark.png" class="img-fluid" alt="">
                </b-card-text>
            </b-card>
        </div>
    </div>
</template>
<style>
.fertilizer-distribution .info-card {
    margin-top: 35px;
    color: #fff;
    padding: 1rem;
    border-radius: 8px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
}

.fertilizer-distribution .info-card .icon {
    margin-top: -40px;
    display: flex;
    font-size: 25px;
    align-items: center;
    justify-content: center;
    width: 60px;
    height: 60px;
    border: 2px solid #fff;
    border-radius: 60px;
}

.fertilizer-distribution .info-card .content {
    margin-top: 5px;
}

.fertilizer-distribution .info-card .content h3 {
    margin-top: 5px;
    padding: 3px;
    border-radius: 10px;
}

.fertilizer-distribution .info-card.submitted {
    background: #0F95CF;
}

.fertilizer-distribution .info-card.submitted .icon,
.fertilizer-distribution .info-card.submitted .content h3 {
    background: #0785bb;
}

.fertilizer-distribution .info-card.approved {
    background: #1DCD6E;
}

.fertilizer-distribution .info-card.approved .icon,
.fertilizer-distribution .info-card.approved .content h3 {
    background: #11b75f;
}

.fertilizer-distribution .info-card.pending {
    background: #DE960D;
}

.fertilizer-distribution .info-card.pending .icon,
.fertilizer-distribution .info-card.pending .content h3 {
    background: #c78406;
}

.fertilizer-distribution .info-card.requested-far {
    background: #0fc9cf;
}

.fertilizer-distribution .info-card.requested-far .icon,
.fertilizer-distribution .info-card.requested-far .content h3 {
    background: #06abb1;
}

.fertilizer-distribution .info-card.total-app {
    background: #1930e2;
}

.fertilizer-distribution .info-card.total-app .icon,
.fertilizer-distribution .info-card.total-app .content h3 {
    background: #1127cd;
}

.fertilizer-distribution .info-card.reject {
    background: #e22619;
}

.fertilizer-distribution .info-card.reject .icon,
.fertilizer-distribution .info-card.reject .content h3 {
    background: #bd180c;
}
</style>
