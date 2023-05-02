<template>
    <div class="promotion-wrapper-db">
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
            <b-row no-gutters>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-advertisement-line"></i>
                        </div>
                        <div class="content">
                            <p>Total Advertisement</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-volume-vibrate-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Promotion</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-calendar-event-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Approved Events</p>
                            <h2>045</h2>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-time-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Pending Sales Kits</p>
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
.promotion-wrapper-db .card .card-header {
    background: transparent;
}

.promotion-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(244, 244, 244, 0.913);
    text-align: center;
    padding: 1rem;
    width: 100%;
    display: flex;
    align-items: center;
    flex-direction: column;
    position: relative;
}

.promotion-wrapper-db .card .info-card-wrapper .info-item .icon {
    width: 35px;
    height: 35px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
}

.promotion-wrapper-db .card .info-card-wrapper .info-item .icon i {
    font-size: 20px;
}

.promotion-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item {
    background: #6E3BFE;
    border-radius: 8px 0 0 8px;
}

.promotion-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item {
    background: #09AB73;
}

.promotion-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item {
    background: #0073E2;
}

.promotion-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item {
    background: #de530d;
    border-radius: 0 8px 8px 0;
}
.promotion-wrapper-db .card .info-card-wrapper .info-item::after {
    content: "";
    position: absolute;
    top: 50%;
    right: -5px;
    transform: translateY(-50%);
    width: 10px;
    height: 60%;
    border-radius: 10px;
    background: #fff;
    z-index: 2;
}
.promotion-wrapper-db .card .info-card-wrapper:last-child .info-item::after {
    background: transparent;
}
.promotion-wrapper-db .card .info-card-wrapper .info-item .content {
    margin-top: .5rem;
}

.promotion-wrapper-db .card .info-card-wrapper .info-item .content i {
    font-size: 20px;
}
@media (max-width: 767.98px) {
    .promotion-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item {
        border-radius:0;
    }
    .promotion-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item {
        border-radius:0;
    }
    .promotion-wrapper-db .card .info-card-wrapper .info-item::after {
        width: 0;
        background: transparent;
    }
}
</style>
