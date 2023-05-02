<template>
    <div class="program-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>Program Management</h5>
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
                        <div class="icon">
                            <i class="ri-apps-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Programs</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-shield-check-fill"></i>
                        </div>
                        <div class="content">
                            <p>Approved Programs</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-file-copy-2-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Agreements</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-timer-2-fill"></i>
                        </div>
                        <div class="content">
                            <p>Pending Programs</p>
                            <h2>045</h2>
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
.program-wrapper-db .card .card-header {
    background: transparent;
}

.program-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(31, 31, 31, 0.913);
    text-align: center;
    padding: 1rem;
    width: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
    border-radius: 10px;
}

.program-wrapper-db .card .info-card-wrapper .info-item .icon {
    color: #fff;
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
}
.program-wrapper-db .card .info-card-wrapper .info-item .icon i{
    font-size: 20px;
}
.program-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon {
    background: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon {
    background: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon {
    background: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}

.program-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon{
    background: linear-gradient(95deg, #DE1A0D 0%, #DE580D 100%);
}
.program-wrapper-db .card .info-card-wrapper:nth-child(1) {
    border-right: 1px solid #953BFE;
}

.program-wrapper-db .card .info-card-wrapper:nth-child(2) {
    border-right: 1px solid #1DCD6E;
}

.program-wrapper-db .card .info-card-wrapper:nth-child(3) {
    border-right: 1px solid #00B4E2;
}
.program-wrapper-db .card .info-card-wrapper .info-item .content {
    margin-top: .5rem;
}

.program-wrapper-db .card .info-card-wrapper .info-item .content i {
    font-size: 20px;
}
</style>
