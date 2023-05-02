<template>
    <div class="external-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>External Panel</h5>
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
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>045</h2>
                        </div>
                        <div class="content">
                            <i class="ri-file-copy-2-fill"></i>
                            <p>Total Proposal Submit</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>045</h2>
                        </div>
                        <div class="content">
                            <i class="ri-apps-fill"></i>
                            <p>Total Number of Program</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>045</h2>
                        </div>
                        <div class="content">
                            <i class="ri-checkbox-multiple-fill"></i>
                            <p>Total Approved Proposals</p>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper">
                    <div class="info-item">
                        <div class="count-box">
                            <h2>045</h2>
                        </div>
                        <div class="content">
                            <i class="ri-timer-2-fill"></i>
                            <p>Total Pending Program</p>
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
.external-wrapper-db .card .card-header{
    background: transparent;
}
.external-wrapper-db .card .info-card-wrapper .info-item{
    margin-top: 30px;
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    border-radius: 10px;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item{
    border: 1px solid #6E3BFE;
    background: #F8F2FF;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #6E3BFE;
    background: linear-gradient(95deg, #953BFE 0%, #6F3FF8 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item{
    border: 1px solid #09AB73;
    background: #D8FFF1;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #09AB73;
    background: linear-gradient(95deg, #1DCD6E 0%, #009B76 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item{
    border: 1px solid #0073E2;
    background: #DDEEFF;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #0073E2;
    background: linear-gradient(95deg, #00B4E2 0%, #005BE2 100%);
}
.external-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item{
    border: 1px solid #DE330D;
    background: #FFEEE9;
}
.external-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .count-box{
    margin-top: -20px;
    width: 80%;
    height: 50px;
    background-color: #DE330D;
    background: linear-gradient(95deg, #DE1A0D 0%, #DE580D 100%);
}
.external-wrapper-db .card .info-card-wrapper .info-item .count-box{
    color: #fff;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 10px;
}
.external-wrapper-db .card .info-card-wrapper .info-item .content{
    text-align: center;
    padding: .5rem .2rem;
}
.external-wrapper-db .card .info-card-wrapper .info-item .content i{
    font-size: 20px;
}
</style>
