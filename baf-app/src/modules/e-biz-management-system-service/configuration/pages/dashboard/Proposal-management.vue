<template>
    <div class="proposal-wrapper-db">
        <breadcumb />
        <b-card header-tag="header">
            <template #header>
                <div class="d-flex justify-content-between">
                    <h5>Proposal Management</h5>
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
                            <i class="ri-file-user-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Circulars</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-file-list-2-fill"></i>
                        </div>
                        <div class="content">
                            <p>Total Proposals</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-checkbox-fill"></i>
                        </div>
                        <div class="content">
                            <p>Approved Proposals</p>
                            <h4>045</h4>
                        </div>
                    </div>
                </b-col>
                <b-col sm="3" class="info-card-wrapper mb-3 mb-sm-0">
                    <div class="info-item">
                        <div class="icon">
                            <i class="ri-time-fill"></i>
                        </div>
                        <div class="content">
                            <p>Pending Proposals</p>
                            <h4>045</h4>
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
.proposal-wrapper-db .card .card-header {
    background: transparent;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item {
    color: rgba(23, 23, 23, 0.913);
    padding: 1rem;
    width: 100%;
    display: flex;
    align-items: center;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item .icon {
    width: 35px;
    height: 40px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-radius: 6px;
}

.proposal-wrapper-db .card .info-card-wrapper .info-item .icon i {
    color: #fff;
    font-size: 20px;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon i {
    color: #6E3BFE;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon i {
    color: #09AB73;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon i {
    color: #0073E2;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon i {
    color: #DE1A0D;
}
.proposal-wrapper-db .card .info-card-wrapper:nth-child(1) .info-item .icon {
    background: #e0d4ff;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(2) .info-item .icon {
    background: #c1fde8;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(3) .info-item .icon {
    background: #b5dcff;
}

.proposal-wrapper-db .card .info-card-wrapper:nth-child(4) .info-item .icon {
    background: #fcd9d7;
}
.proposal-wrapper-db .card .info-card-wrapper .info-item .content {
    margin-left: .5rem;
}
</style>
