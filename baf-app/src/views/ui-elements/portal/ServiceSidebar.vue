<template>
    <div class="portal service-sidebar-wrapper">
        <b-card>
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">Active Services</h6>
                    </div>
                    <a href="javascript:" class="pr-3 portal-text">See More <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <div class="services">
                <b-list-group>
                    <b-list-group-item button>Dealership License</b-list-group-item>
                    <b-list-group-item button>Payment for Financial Incentives</b-list-group-item>
                    <b-list-group-item button>Name Clearance</b-list-group-item>
                    <b-list-group-item button>Ex Garden Sale (Direct Sale)</b-list-group-item>
                </b-list-group>
            </div>
        </b-card>
        <b-card>
            <template #header>
                <div class="d-flex justify-content-between align-items-center">
                    <div class="d-flex card-title-wrapper">
                        <h6 class="mb-0 ml-2">Upcoming Services</h6>
                    </div>
                    <a href="javascript:" class="pr-3 portal-text">See More <i class="ri-arrow-right-line"></i></a>
                </div>
            </template>
            <div class="services">
                <b-list-group>
                    <b-list-group-item button>Name Clearance</b-list-group-item>
                    <b-list-group-item button>Tariff Rate</b-list-group-item>
                    <b-list-group-item button>Daily Market Price Rate</b-list-group-item>
                    <b-list-group-item button>Tea Garden Management</b-list-group-item>
                    <b-list-group-item button>Research</b-list-group-item>
                </b-list-group>
            </div>
        </b-card>
    </div>
</template>
<script>
    export default {
        name: 'ServiceSidebar'
    }
</script>

<style scoped>
.service-sidebar-wrapper {
    margin: 30px 0;
}
.service-sidebar-wrapper .card {
    margin-bottom: 10px;
    background: transparent;
    box-shadow: none;
}
.service-sidebar-wrapper .card .card-body {
    padding: 8px 0 0;
}
.service-sidebar-wrapper .card .card-body .services .list-group .list-group-item {
    margin-bottom: 6px;
    border: none;
    border-left: 4px solid var(--portal-brand);
    border-radius: 0;
    background: linear-gradient(to left, var(--white) 50%, var(--portal-secondary) 50%) right;
    background-size: 200%;
    border-radius: 0 10px 10px 0;
    box-shadow: #32325d40 0 2px 5px 1px, #0000004d 0 1px 5px -1px;
    transition: .5s ease-out;
}
.service-sidebar-wrapper .card .card-body .services .list-group .list-group-item:hover {
    color: var(--white);
    background-position: left;
}
</style>
