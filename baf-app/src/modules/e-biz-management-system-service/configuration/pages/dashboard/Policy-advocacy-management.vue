<template>
    <div class="policy-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>Policy Advocacy Management</h5>
                    <div class="d-flex">
                        <div class="form">
                            <b-form-select v-model="selected" :options="fiscalYear" size="sm"></b-form-select>
                        </div>
                        <div class="form ml-2">
                            <b-form-select v-model="selected" :options="associations" size="sm"></b-form-select>
                        </div>
                    </div>
                </div>
            </template>
            <b-row>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <p>Total No of Application</p>
                        <div class="content">
                            <h2>045</h2>
                            <i class="ri-file-copy-2-fill"></i>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <p>Total No of Feedback</p>
                        <div class="content">
                            <h2>045</h2>
                            <i class="ri-feedback-fill"></i>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <p>Total Approved</p>
                        <div class="content">
                            <h2>045</h2>
                            <i class="ri-shield-check-fill"></i>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <p>Total No of Workshop</p>
                        <div class="content">
                            <h2>045</h2>
                            <i class="ri-stack-fill"></i>
                        </div>
                    </div>
                </b-col>
            </b-row>
        </b-card>
    </div>
</template>
<script>
export default {
    data () {
        return {
            selected: null,
            associations: [
                { value: null, text: 'Filter By Association', disabled: true },
                { value: 'a', text: 'Association One' },
                { value: 'b', text: 'Association True' },
                { value: 'c', text: 'Association Three' },
                { value: 'd', text: 'Association Four' }
            ],
            fiscalYear: [
                { value: null, text: 'Filter By Fiscal Year', disabled: true },
                { value: 'a', text: '2011 - 2012' },
                { value: 'b', text: '2012 - 2013' },
                { value: 'c', text: '2013 - 2014' },
                { value: 'd', text: '2014 - 2015' }
            ]
        }
    }
}
</script>
<style>
.policy-wrapper-db .card .card-header {
    background: transparent;
}

.policy-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(255, 255, 255, 0.913);
    padding: 1rem;
    width: 100%;
    border-radius: 10px;
}

.policy-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item {
    background: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}

.policy-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item {
    background: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}
.policy-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item {
    background: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}
.policy-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item {
    background: #DE330D;
    background: linear-gradient(95deg, #fc4692 0%, #3f45fb 100%);
}
.policy-wrapper-db .card .info-card-wrapper .info-item .content {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.policy-wrapper-db .card .info-card-wrapper .info-item .content i {
    font-size: 20px;
}
</style>
